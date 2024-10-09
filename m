Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB8198A01;
	Wed,  9 Oct 2024 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478308; cv=none; b=puYU3mSn6ZPmw9sMmqPo/dVkSgrlgCa8qC5egrtOI+PLLKKZuMhfutFN9iLgXiM+93Z6yh0kA9kCHTDTkuma4yvjtXKDSGHXMgjbmqW49yO2XqeoFJ2BBlT4TSiGdrYdkLtKMOkOon+5ua2z9fPW/sk+0nuKWX3H+2Mt8XdIQLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478308; c=relaxed/simple;
	bh=rnKdynjqKm/mQK0nDRtTLsJ5yELo/xHl8PWVPVBr0B4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2edssElZ6lWbvuq0ehhS5VvBjcwmtIIa7AOqyziBpUAHDMkrFjk1XFJFs49Tm7sdQoDiDYp1jVAn0TVZyIwjM9l6m17oj7n+rgnqJEjWHbcgv5kmUj8LC12cRSl6sg1zYmlr7yknct/3ps0r+k0xM7/fP0BDihaz32RdKOicsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwEBHHGD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwEBHHGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F95C4CECD;
	Wed,  9 Oct 2024 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478307;
	bh=rnKdynjqKm/mQK0nDRtTLsJ5yELo/xHl8PWVPVBr0B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwEBHHGDYbUoag2h+zmYdpPC6ps6kVvptJ0fL+KFKT2jqPRO8hfLYUAFKCAdC5SoS
	 u2sXqEXnNYLVbQWcm3zElBs7UIvzN5IQQqQN2j6F+ZxAftAn2PB6A0NXleX4+XSGod
	 1BlEKavWbtnxa+pH0XTf6Je9n4CpPVY9CCeoXJgbYgJHWh75GQxyNDAbSLZEtm+nGV
	 0AnqA9NuR4azXvKG/3gxF4zrPOptwbTJciF9HbAydI9QSm1p3qbScCO4wiAdHfVCNO
	 BHB4n8GEoxPolSGX2XUwrlkc756g8+vnmD1WmJ/QIjCXKvTes5Gog2xWW4uBskXWqc
	 Ss+hm5CXtSKqw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joel@joelfernandes.org,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	peterz@infradead.org,
	neeraj.upadhyay@amd.com,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH v2 01/10] rcu: Change rdp arg to cpu number for rcu_watching_snap_stopped_since()
Date: Wed,  9 Oct 2024 18:21:18 +0530
Message-Id: <20241009125127.18902-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
References: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

In preparation of making rcu_watching_snap_stopped_since() available
for RCU code outside of tree.c, change the rdp argument to cpu number.

Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c     | 14 +++++++-------
 kernel/rcu/tree_exp.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a60616e69b66..ea17dd2d0344 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -312,16 +312,16 @@ static bool rcu_watching_snap_in_eqs(int snap)
  * rcu_watching_snap_stopped_since() - Has RCU stopped watching a given CPU
  * since the specified @snap?
  *
- * @rdp: The rcu_data corresponding to the CPU for which to check EQS.
+ * @cpu: The CPU for which to check EQS.
  * @snap: rcu_watching snapshot taken when the CPU wasn't in an EQS.
  *
- * Returns true if the CPU corresponding to @rdp has spent some time in an
- * extended quiescent state since @snap. Note that this doesn't check if it
- * /still/ is in an EQS, just that it went through one since @snap.
+ * Returns true if the CPU has spent some time in an extended quiescent state
+ * since @snap. Note that this doesn't check if it /still/ is in an EQS, just
+ * that it went through one since @snap.
  *
  * This is meant to be used in a loop waiting for a CPU to go through an EQS.
  */
-static bool rcu_watching_snap_stopped_since(struct rcu_data *rdp, int snap)
+static bool rcu_watching_snap_stopped_since(int cpu, int snap)
 {
 	/*
 	 * The first failing snapshot is already ordered against the accesses
@@ -334,7 +334,7 @@ static bool rcu_watching_snap_stopped_since(struct rcu_data *rdp, int snap)
 	if (WARN_ON_ONCE(rcu_watching_snap_in_eqs(snap)))
 		return true;
 
-	return snap != ct_rcu_watching_cpu_acquire(rdp->cpu);
+	return snap != ct_rcu_watching_cpu_acquire(cpu);
 }
 
 /*
@@ -826,7 +826,7 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
 	 * read-side critical section that started before the beginning
 	 * of the current RCU grace period.
 	 */
-	if (rcu_watching_snap_stopped_since(rdp, rdp->watching_snap)) {
+	if (rcu_watching_snap_stopped_since(rdp->cpu, rdp->watching_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index fb664d3a01c9..e3bd4c18a852 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -401,7 +401,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		unsigned long mask = rdp->grpmask;
 
 retry_ipi:
-		if (rcu_watching_snap_stopped_since(rdp, rdp->exp_watching_snap)) {
+		if (rcu_watching_snap_stopped_since(rdp->cpu, rdp->exp_watching_snap)) {
 			mask_ofl_test |= mask;
 			continue;
 		}
-- 
2.40.1

