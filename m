Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD8127E0A;
	Wed, 15 May 2024 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777625; cv=none; b=Tp3BweMb8zXfHzB2/EpwMURWqkRA0Fy+YJdXw2UoSDApynJJoE7SspawQoGX2T7DJdiHPzfOGvKAU8sbNeWNIC13A4hBJBhvVW8v+WelGH36rzWWdce1EE/EmLJalcU8rhLDXTbSHEUWKuza8w0Cda0w3BQRTVNyNzue12iVohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777625; c=relaxed/simple;
	bh=MdzjiUsPb9xUfFMEziaGcXIRd8h9jhd5Aag1va9ra28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7Va3kEgGQ2U8Y/wpdBsLKuuoMnz7YBLLyAUh/9eci1yAaF9PJv0RR7COS9gOpveFdmYPmOvOO1L/sZGDO3eaO2EhEd0hMOlsk5Ytiw/ghebDsDzMCGwsoS524GP/ypf0CrnekOkc5lRxMeUmEhOBW2ei4Zinw42pSnThXgqcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiR9/Pvd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiR9/Pvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBA8C4AF08;
	Wed, 15 May 2024 12:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715777625;
	bh=MdzjiUsPb9xUfFMEziaGcXIRd8h9jhd5Aag1va9ra28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiR9/Pvdqc4Tv3LWXkd9/FPw/NyVasazyt/C8l04pt5IEFNIcE9kblgboXGyADNHx
	 laiAj2ftzFrwtpybS7ZhcmFn56DfJX2oTOMMKhiRtAAm8gMfXj3fK2Ob05y/UZ5lRC
	 TiUb7YuAWMUuYbA+9HqE2ayqhsE/Ji16HygG705JkVCtX9BJvERPQRLFcPKLyBkeg9
	 ejBzhY6sxdZaXJbZtoXXgnEe+BePqz2HbQixxwRM3C92ch/5fviLXq8g17u0Rq2j9q
	 Pegyyd2bO9o5oUWpJP70RcDw3LRdcf3dx6GYmtF/JMAi6OckEsCB/09Ka4IHeAQKqq
	 kbceTK3tNv6iQ==
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
Subject: [PATCH 3/6] rcu/exp: Remove superfluous full memory barrier upon first EQS snapshot
Date: Wed, 15 May 2024 14:53:29 +0200
Message-ID: <20240515125332.9306-4-frederic@kernel.org>
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

When the grace period kthread checks the extended quiescent state
counter of a CPU, full ordering is necessary to ensure that either:

* If the GP kthread observes the remote target in an extended quiescent
  state, then that target must observe all accesses prior to the current
  grace period, including the current grace period sequence number, once
  it exits that extended quiescent state.

or:

* If the GP kthread observes the remote target NOT in an extended
  quiescent state, then the target further entering in an extended
  quiescent state must observe all accesses prior to the current
  grace period, including the current grace period sequence number, once
  it enters that extended quiescent state.

This ordering is enforced through a full memory barrier placed right
before taking the first EQS snapshot. However this is superfluous
because the snapshot is taken while holding the target's rnp lock which
provides the necessary ordering through its chain of
smp_mb__after_unlock_lock().

Remove the needless explicit barrier before the snapshot and put a
comment about the implicit barrier newly relied upon here.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8a1d9c8bd9f7..bec24ea6777e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -357,7 +357,13 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		    !(rnp->qsmaskinitnext & mask)) {
 			mask_ofl_test |= mask;
 		} else {
-			snap = rcu_dynticks_snap(cpu);
+			/*
+			 * Full ordering against accesses prior current GP and
+			 * also against current GP sequence number is enforced
+			 * by current rnp locking with chained
+			 * smp_mb__after_unlock_lock().
+			 */
+			snap = ct_dynticks_cpu_acquire(cpu);
 			if (rcu_dynticks_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
-- 
2.44.0

