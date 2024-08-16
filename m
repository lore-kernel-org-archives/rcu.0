Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D478287E;
	Fri, 16 Aug 2024 04:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781168; cv=none; b=mh182Wxs0Dpafbc+hl2LK205HXt6aEPD2uJ0nx4j1gseSUGv2slDUY83nkln5XoIyq22kj24K87JTFTL3blhQ+ySMDjuCXq017tKQTTewEFdVL7jqAE92yKHuSJ1oYxhOvRZC5IPHA7zZANR2YY0U46I6xNH2rwqR3Vr23pKqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781168; c=relaxed/simple;
	bh=/alW98fFIxhaforztOaK21XXuT5F3kiWNzbUR3+Uyto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cpJ3Mc1AZmn8BZJP/ej6XQZ4xYxxZBRKukx/JTbcwvY3Hn7MrigdxySmkoVcuZvpet45gBOWyAMiR06Ev0RW8vHPbGHN2uJ+xKZu+Vs4U2izAK6USK6MoHwOt1RHW6e08/bg2Clf+RWv/EImS+h/ZB8m3wusgGRxGPdQkJOnGEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEZz02E2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEZz02E2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F61C32782;
	Fri, 16 Aug 2024 04:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781168;
	bh=/alW98fFIxhaforztOaK21XXuT5F3kiWNzbUR3+Uyto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEZz02E27heWMWQ1tZ3OA81pbUt700h5ptXZPzMjpt01h16T8Bzr6r77x+cquS0cy
	 gFIrMXkuaFmBjf1/0OZRng3y+Pl7cCcvYuXfG9Q+Y0fxQ+dBB3aYWbZ4MC2FCucdsE
	 YehIXfC57wlbbRq6CDtsBXsHf1IPwkshETl0lWP6abOxfWvK/xC4+LrtPHTV6LIovi
	 fqusDHaDmEhYg92MtVZion5ujKFnh4H9rB8+Ygz01WikBPc0opvUsJCBApM8/NzwvP
	 ZqMdd8cwVFbtspGwlloHc4sil9oDA6TtZYk52XNmINyTwtKUJQn/89ZC95L6VXoKvr
	 3xEm1EnpYzrfA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH rcu 20/26] rcu: Rename struct rcu_data .exp_dynticks_snap into .exp_watching_snap
Date: Fri, 16 Aug 2024 09:32:35 +0530
Message-Id: <20240816040241.17776-20-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816040030.GA16986@neeraj.linux>
References: <20240816040030.GA16986@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, and the snapshot helpers are now prefix by
"rcu_watching". Reflect that change into the storage variables for these
snapshots.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.h     | 2 +-
 kernel/rcu/tree_exp.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index f5361a7d7269..13fdcc2aa081 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -215,7 +215,7 @@ struct rcu_data {
 	/* 4) rcu_barrier(), OOM callbacks, and expediting. */
 	unsigned long barrier_seq_snap;	/* Snap of rcu_state.barrier_sequence. */
 	struct rcu_head barrier_head;
-	int exp_dynticks_snap;		/* Double-check need for IPI. */
+	int exp_watching_snap;		/* Double-check need for IPI. */
 
 	/* 5) Callback offloading. */
 #ifdef CONFIG_RCU_NOCB_CPU
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 48ad8b868d83..eec42df0c018 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -380,7 +380,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 			if (rcu_watching_snap_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
-				rdp->exp_dynticks_snap = snap;
+				rdp->exp_watching_snap = snap;
 		}
 	}
 	mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
@@ -400,7 +400,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		unsigned long mask = rdp->grpmask;
 
 retry_ipi:
-		if (rcu_watching_snap_stopped_since(rdp, rdp->exp_dynticks_snap)) {
+		if (rcu_watching_snap_stopped_since(rdp, rdp->exp_watching_snap)) {
 			mask_ofl_test |= mask;
 			continue;
 		}
-- 
2.40.1

