Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713F97BB01;
	Fri, 16 Aug 2024 04:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781161; cv=none; b=lGZvX/+zvqJEwztfUjotFOlNIGzj4O8cMkr+Mm9ZNhfuUBFwHDbi7sOqAMKg78GDY9meFJGcOzlSOYzUmcFWX5VSYQG/Psybv67YkMiFOTmAr0udwXYb62DqsRDHQ+npwJ8itDvgnqSBewrsgTFE4iD22jNdOr93mj4CULsNSNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781161; c=relaxed/simple;
	bh=eezzsYtU0JEgacHwaXnRZKwm2QxEqloqluBFnlXLfZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1ULUtNDSbMtlUrRpZ2YevDcWUQmRLu66OtGxTM04aLEQ8kQclsElyPg6163Lr1VGYSX9JTN2K7O0c5zLCIqgtoiB7quRFLePyhGiGPsTRK5xRqfUvoaPbFWT1cz3nI//KYZRQLYgeiZZtShFL3ah0AX8vgf10svA1/U43QYJ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryEuqN1b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryEuqN1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE434C32782;
	Fri, 16 Aug 2024 04:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781161;
	bh=eezzsYtU0JEgacHwaXnRZKwm2QxEqloqluBFnlXLfZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ryEuqN1boUtjAxV2kmP11XcJQ0NX4LcJFiAEIKO5N075HWyEBhbx2VdTPXbgCKDSI
	 aGu0VNDKGbawUCbgtGoTg+nWrONg2MXF2sb8njL66hjK8xblcGv/17PF06c8sceqml
	 XoxlOLkOmtX3+aa2WZrtmdzkv2GpitxKxWSCPz+UH/PsXiP3xAs1T9yGwi60lOMaXQ
	 r+koiGRJAhiu74ueQrk0iYws8el41a+RQhNS3Da2Bx5bpFIZnScld9Gflk3hifS0mt
	 5AcsXWuw4XRJz1Ktypgn+5/DZ2jFsf4f/xa2pQKSFOjBKqbwumTsRm0h4oU6fGcCRj
	 oaDUpeijjca6Q==
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
Subject: [PATCH rcu 19/26] rcu: Rename struct rcu_data .dynticks_snap into .watching_snap
Date: Fri, 16 Aug 2024 09:32:34 +0530
Message-Id: <20240816040241.17776-19-neeraj.upadhyay@kernel.org>
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
 .../RCU/Design/Data-Structures/Data-Structures.rst          | 4 ++--
 kernel/rcu/tree.c                                           | 6 +++---
 kernel/rcu/tree.h                                           | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index 28d9f9e1783f..04e16775c752 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -921,10 +921,10 @@ This portion of the ``rcu_data`` structure is declared as follows:
 
 ::
 
-     1   int dynticks_snap;
+     1   int watching_snap;
      2   unsigned long dynticks_fqs;
 
-The ``->dynticks_snap`` field is used to take a snapshot of the
+The ``->watching_snap`` field is used to take a snapshot of the
 corresponding CPU's dyntick-idle state when forcing quiescent states,
 and is therefore accessed from other CPUs. Finally, the
 ``->dynticks_fqs`` field is used to count the number of times this CPU
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ac3577ac10bd..a969d8ddc58e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -793,8 +793,8 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 	 * Ordering between remote CPU's pre idle accesses and post grace period
 	 * updater's accesses is enforced by the below acquire semantic.
 	 */
-	rdp->dynticks_snap = ct_rcu_watching_cpu_acquire(rdp->cpu);
-	if (rcu_watching_snap_in_eqs(rdp->dynticks_snap)) {
+	rdp->watching_snap = ct_rcu_watching_cpu_acquire(rdp->cpu);
+	if (rcu_watching_snap_in_eqs(rdp->watching_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
 		return 1;
@@ -826,7 +826,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * read-side critical section that started before the beginning
 	 * of the current RCU grace period.
 	 */
-	if (rcu_watching_snap_stopped_since(rdp, rdp->dynticks_snap)) {
+	if (rcu_watching_snap_stopped_since(rdp, rdp->watching_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index fcf2b4aa3441..f5361a7d7269 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -206,7 +206,7 @@ struct rcu_data {
 	long		blimit;		/* Upper limit on a processed batch */
 
 	/* 3) dynticks interface. */
-	int dynticks_snap;		/* Per-GP tracking for dynticks. */
+	int  watching_snap;		/* Per-GP tracking for dynticks. */
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 	bool rcu_forced_tick;		/* Forced tick to provide QS. */
-- 
2.40.1

