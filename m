Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280A486130;
	Wed, 15 May 2024 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777623; cv=none; b=dBPPhN+4Pg6g3F6QK8HcJQqBtSRqN70hGun0dhUd+/SLZT2TemZiGbi7BwJHHhseD/Iv6ymWITzv+FOmmYJ+IhpKJ3Bp2cT4z7tn7c7rmbN+OF/CPdiYuRQAb9b3/34fFpIgaIgG+F51VsnjnekU1oy3+qrASKaWs09B3fvivs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777623; c=relaxed/simple;
	bh=lDuQXnRkttWQtYPH873R34M0qG7UvBXw4mUYnyTd/2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVykN3UU2+JCMclWh8aTCbluILsAGaBs4pEdVDhxjBDZURzvpu89DC1wDlgq7twsc4XFKKO9fxhQz8nDen2b0tJILa0B5Fz3qt6wPnPBblbuaK0E7SPNvcnFh2wIFKuPuqM+k/34r6s1pIU4J8m6hBmcJITBnPcQCvJGHRzbMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGdE5R9f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGdE5R9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1016C32782;
	Wed, 15 May 2024 12:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715777622;
	bh=lDuQXnRkttWQtYPH873R34M0qG7UvBXw4mUYnyTd/2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qGdE5R9fS+NcqEx+GxPfGDnFmztS213YlOX81/dlCr76aJTfxenjBAp31IB6YIDw8
	 OHzWNQRfiw70AKZBfwsi0eNX2xHECKjEIGd6N4XgOhvE4cxyrTHvzgMCkYcMzG7H/Y
	 F2I0mZr07e/0zRRNjituereUAhp6/eHffzK0ipP9hx/N0qCu+evtYDCYSUFIlQRx59
	 bZz3JLF2jUZMhIx/Kc5TI3lVD7KuKofP5vRik8VSU9BlOIwrnL6f538Xjmg8O3mzal
	 gzSiiNzrnsd30QN9NyVxRFR10tZ36NIZFocCPOeWMi28apbCqnxCkI0hkaM3hNiq35
	 C9uqaxDvEbdxg==
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
Subject: [PATCH 2/6] rcu: Remove superfluous full memory barrier upon first EQS snapshot
Date: Wed, 15 May 2024 14:53:28 +0200
Message-ID: <20240515125332.9306-3-frederic@kernel.org>
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
 .../Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst    | 6 +++---
 kernel/rcu/tree.c                                          | 7 ++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 5750f125361b..728b1e690c64 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -149,9 +149,9 @@ This case is handled by calls to the strongly ordered
 ``atomic_add_return()`` read-modify-write atomic operation that
 is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
 time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
-The grace-period kthread invokes ``rcu_dynticks_snap()`` and
-``rcu_dynticks_in_eqs_since()`` (both of which invoke
-an ``atomic_add_return()`` of zero) to detect idle CPUs.
+The grace-period kthread invokes first ``ct_dynticks_cpu_acquire()``
+(preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_since()``
+(both of which rely on acquire semantics) to detect idle CPUs.
 
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 58415cdc54f8..f5354de5644b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -773,7 +773,12 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
  */
 static int dyntick_save_progress_counter(struct rcu_data *rdp)
 {
-	rdp->dynticks_snap = rcu_dynticks_snap(rdp->cpu);
+	/*
+	 * Full ordering against accesses prior current GP and also against
+	 * current GP sequence number is enforced by current rnp locking
+	 * with chained smp_mb__after_unlock_lock().
+	 */
+	rdp->dynticks_snap = ct_dynticks_cpu_acquire(rdp->cpu);
 	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
-- 
2.44.0

