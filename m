Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615A12BF32;
	Fri, 16 Aug 2024 04:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781145; cv=none; b=uldbGewNbpMcc1EZlUwsZVqqq3PwIFzvo+0dKGSTn8zMkFepGGDtlJG6Jcc1/fGPTF3xVPPXnD/spmeeLoy+arHFYfoYzo0X7hcuXKn3B7T9+bSdywzz4dP66tRflspaogP1j43otz7UqFq/1y5NUHQsKIGdTXgL5pe7SFXS1qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781145; c=relaxed/simple;
	bh=hjaBXcJ9dBRYxycecncIBwBcXltyNWJ49cx74mvOUCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NtMhxj/aN5zdeY7M4EeC4bgTkZMTkYxtbCJN3KdgZCtuVDqZ8YynNzH6WudGlLPifj1quzEGVLR7OgBUcachfeRIJVciA5Cxa+mALBW5i/Kk3xjYwx1Ogib5Tzh9518D0mg5InKN+QoL8miyPG3daFlXzKd1n6DmiiYeo5AK1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXqMY7hq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXqMY7hq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFD4C4AF09;
	Fri, 16 Aug 2024 04:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781144;
	bh=hjaBXcJ9dBRYxycecncIBwBcXltyNWJ49cx74mvOUCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXqMY7hqy44coyaWMN90bF3Q+JmvLt4aHS6542BsIURCbNe2q0xoOmt9tFM8wAQhz
	 tkNRt/S+/LCa0JVgCkIH7blcUKBW8yOW0TmxhiTBnPZ+eiTe85z1PovOmpCv3BREBZ
	 TLL2w/UiRC4x78H6lqSjvqyA+HU/2TBXySL53a+Ep4XjW/bhFNwUXSN0Iqz+jJIVTP
	 gplne0YhFQIOjxKUDpTqJlSw+A4lfmCvwRmX7mwCY/AWqcMY1sSfARCgk8S0Jc3SAF
	 gUl1EKHY1GDlGdbpDrDSto9V2ewdN3GcsmppaujhLu1UywnACI3cunzSeYO2tNcMhs
	 JmwYEOMIvJKqQ==
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
Subject: [PATCH rcu 17/26] rcu: Rename rcu_dynticks_in_eqs_since() into rcu_watching_snap_stopped_since()
Date: Fri, 16 Aug 2024 09:32:32 +0530
Message-Id: <20240816040241.17776-17-neeraj.upadhyay@kernel.org>
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
RCU_WATCHING, the dynticks prefix can go.

While at it, this helper is only meant to be called after failing an
earlier call to rcu_watching_snap_in_eqs(), document this in the comments
and add a WARN_ON_ONCE() for good measure.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 .../Tree-RCU-Memory-Ordering.rst              |  2 +-
 kernel/rcu/tree.c                             | 23 ++++++++++++++-----
 kernel/rcu/tree_exp.h                         |  2 +-
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 2d7036ad7476..7163d0def34e 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -150,7 +150,7 @@ This case is handled by calls to the strongly ordered
 is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
 time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
 The grace-period kthread invokes first ``ct_rcu_watching_cpu_acquire()``
-(preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_since()``
+(preceded by a full memory barrier) and ``rcu_watching_snap_stopped_since()``
 (both of which rely on acquire semantics) to detect idle CPUs.
 
 +-----------------------------------------------------------------------+
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 73516d76b70a..93570cb5e99e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -308,12 +308,20 @@ static bool rcu_watching_snap_in_eqs(int snap)
 	return !(snap & CT_RCU_WATCHING);
 }
 
-/*
- * Return true if the CPU corresponding to the specified rcu_data
- * structure has spent some time in an extended quiescent state since
- * rcu_dynticks_snap() returned the specified snapshot.
+/**
+ * rcu_watching_snap_stopped_since() - Has RCU stopped watching a given CPU
+ * since the specified @snap?
+ *
+ * @rdp: The rcu_data corresponding to the CPU for which to check EQS.
+ * @snap: rcu_watching snapshot taken when the CPU wasn't in an EQS.
+ *
+ * Returns true if the CPU corresponding to @rdp has spent some time in an
+ * extended quiescent state since @snap. Note that this doesn't check if it
+ * /still/ is in an EQS, just that it went through one since @snap.
+ *
+ * This is meant to be used in a loop waiting for a CPU to go through an EQS.
  */
-static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
+static bool rcu_watching_snap_stopped_since(struct rcu_data *rdp, int snap)
 {
 	/*
 	 * The first failing snapshot is already ordered against the accesses
@@ -323,6 +331,9 @@ static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 	 * performed by the remote CPU prior to entering idle and therefore can
 	 * rely solely on acquire semantics.
 	 */
+	if (WARN_ON_ONCE(rcu_watching_snap_in_eqs(snap)))
+		return true;
+
 	return snap != ct_rcu_watching_cpu_acquire(rdp->cpu);
 }
 
@@ -815,7 +826,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * read-side critical section that started before the beginning
 	 * of the current RCU grace period.
 	 */
-	if (rcu_dynticks_in_eqs_since(rdp, rdp->dynticks_snap)) {
+	if (rcu_watching_snap_stopped_since(rdp, rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 137559c84309..48ad8b868d83 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -400,7 +400,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		unsigned long mask = rdp->grpmask;
 
 retry_ipi:
-		if (rcu_dynticks_in_eqs_since(rdp, rdp->exp_dynticks_snap)) {
+		if (rcu_watching_snap_stopped_since(rdp, rdp->exp_dynticks_snap)) {
 			mask_ofl_test |= mask;
 			continue;
 		}
-- 
2.40.1

