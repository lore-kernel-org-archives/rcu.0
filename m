Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D451812880A;
	Wed, 15 May 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777627; cv=none; b=r1tF+6t3Qkg8Ju179BjxMSNbfcwQuDy42L6SOHn4cPy2TQogV8PLF40lk7812NpgZpUrhLVCME2EwaNhBcaKgC1OVFV4cUZMBg20QaUQFN37P8ojupw2Xd9FccvWRqw/7qwdjfV6SAG9wHwOm9Va83WKjlaCgMDJ0J7NDaCepPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777627; c=relaxed/simple;
	bh=Cwf7KVnfd1lPdYZIzVZjhOBDZCNVDm3+eiHPehIQsUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MD0sMQXzC04gbrhwwLAPmIG4+3JCcwaJadff0ipzVaaN0jeHQCiHtgJ2Uxyo7CA23FikpQszrzkKR4r1J12LsXrAKIwiYRORHbSl/rXCKwCFZ3rdi4vio/dlGpf3GSYCKwJPw3vrsIFE0+/ggdNeo2ovsQaEIquIeUyGSqAlEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk/IArrO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk/IArrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9D6C116B1;
	Wed, 15 May 2024 12:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715777627;
	bh=Cwf7KVnfd1lPdYZIzVZjhOBDZCNVDm3+eiHPehIQsUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jk/IArrO6/Ocivft4HDWBiiKfGZW17EWtQmnaEY6IvqGqfzXtA67ivHh4gIxMnIu9
	 rmeRvHRY20SaosNvaMYQK2TDaKrwoHmbRw3veWnYz4JVRJzSWU5XBlxpN52ALGZXG8
	 ySlFelKvcW5WE4wYzANVet9cLfTwNb/H58xl3TFMkMo6/bqfN3+UCfauQT2gBgUT8G
	 NhJQtR3S9Q6+b5tGKHulGmML5Fcuc1F0zydSyayp71ZEgmr8KvHwh8Ve/En0gtilYT
	 4zC/NpYuWhh54xMrmEyGqRfIFbjxf94J0xM1Q/a0LKcvsvrVHWmzqPYEv2LD/DCNQF
	 Moq/KJ+/cwo/g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 4/6] rcu: Remove full memory barrier on boot time eqs sanity check
Date: Wed, 15 May 2024 14:53:30 +0200
Message-ID: <20240515125332.9306-5-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240515125332.9306-1-frederic@kernel.org>
References: <20240515125332.9306-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the boot CPU initializes the per-CPU data on behalf of all possible
CPUs, a sanity check is performed on each of them to make sure none is
initialized in an extended quiescent state.

This check involves a full memory barrier which is useless at this early
boot stage.

Do a plain access instead.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f5354de5644b..02f6f3483482 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4812,7 +4812,7 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(ct->dynticks_nesting != 1);
-	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu)));
+	WARN_ON_ONCE(rcu_dynticks_in_eqs(ct_dynticks_cpu(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_state = RCU_GP_CLEANED;
-- 
2.44.0

