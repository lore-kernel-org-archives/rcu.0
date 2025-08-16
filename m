Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E942DA778;
	Sat, 16 Aug 2025 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302410; cv=none; b=dQkAXBtqZULtb0Vo/qFnn7f2PoV0z70sfJrmmPoaovOrviX42KOVL3DGLLurl9QyO9H0HJsg69/Wx2i3WTWj+QojMZ7KgtINC5ZLjPJ6L+bm+3i8DOkS0kK5Jwofaj0KeYHYUhd0oaRQsyWIDEe3STvQo3lUh3Wt1e4gUKa51T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302410; c=relaxed/simple;
	bh=UBF0i4vX1lpONxPMzk+KRWffnxNvKh13MjTYdZMG8Z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r8CrrcFq8XvfGFVhO2VUK8CnZ6EqaKT4OYE+a32zZPH+gNf7Lh6nifAqha+jCztk1dII5pKfKte9AbbS0PURP63D2QbGZmI/vqBLEa1sMRbWRKQ93tuY4LL1K/bqVkcS8mHouqt/hu7sceG3BHwpccbBJo4sQUNU/HRmtFSwgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiIFSECk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiIFSECk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A098C4CEF5;
	Sat, 16 Aug 2025 00:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302410;
	bh=UBF0i4vX1lpONxPMzk+KRWffnxNvKh13MjTYdZMG8Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uiIFSECkALF03hV/uKHfhK2LUdOQO+xNIj9VCPGjisqYCW2sZkf6nLTkVmX5qL0qO
	 rVp2hKnT5G4s8+pjGAfaKgbfdBy3299ZQEmnq6l/dyjJc2UTGeEebkusSbC6SJKTTN
	 oASkCq8/JdiueoYyCeqKi9es/d2TaCzMEqFZx6pzMzMkHDKwvXOgDpFxWF/yKXOfs3
	 eiz/V+S7TM1cMY36RGE0ual0uPlpX8TougFrbuhtsHpQBMs/gvIJ07ZIS8GhRpYsOI
	 iGv/UdsAsuJPPYZ3Bp0wKaPIbfbVpmIyVld0qedHrn6ZCzQhsbsOEXHuiF4mgnrCx6
	 xqiVuObTWOiZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 86751CE0B31; Fri, 15 Aug 2025 17:00:09 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Akira Yokosawa <akiyks@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH 3/3] rcu: docs: Requirements.rst: Abide by conventions of kernel documentation
Date: Fri, 15 Aug 2025 17:00:07 -0700
Message-Id: <20250816000007.2622326-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9ea6b51e-b48a-474f-b7ae-4fb6414d0aaf@paulmck-laptop>
References: <9ea6b51e-b48a-474f-b7ae-4fb6414d0aaf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akira Yokosawa <akiyks@gmail.com>

Here is a list of conventions applied here:

- Don't mark up function names, to be taken care of by the automarkup
  extension.  Just say func().
- Instead of ".. code-block:: none", just say "::".
- Mark inline literals by a pair of ``xxxx``.  Don't use rust doc's
  dialect of `yyyy`.
- Instead of emphasizing headings by **strong emphasis**, use sub-level
  title adornments, in this case "^^^^^^^^^^" and make them proper
  sub-sections under "Hotplug CPU".

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst  | 52 +++++++++----------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index b0395540296b00..f24b3c0b9b0dc6 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1973,9 +1973,7 @@ code, and the FQS loop, all of which refer to or modify this bookkeeping.
 Note that grace period initialization (rcu_gp_init()) must carefully sequence
 CPU hotplug scanning with grace period state changes. For example, the
 following race could occur in rcu_gp_init() if rcu_seq_start() were to happen
-after the CPU hotplug scanning.
-
-.. code-block:: none
+after the CPU hotplug scanning::
 
    CPU0 (rcu_gp_init)                   CPU1                          CPU2
    ---------------------                ----                          ----
@@ -2008,22 +2006,22 @@ after the CPU hotplug scanning.
                                                                       kfree(r1);
                                         r2 = *r0; // USE-AFTER-FREE!
 
-By incrementing gp_seq first, CPU1's RCU read-side critical section
+By incrementing ``gp_seq`` first, CPU1's RCU read-side critical section
 is guaranteed to not be missed by CPU2.
 
-**Concurrent Quiescent State Reporting for Offline CPUs**
+Concurrent Quiescent State Reporting for Offline CPUs
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 RCU must ensure that CPUs going offline report quiescent states to avoid
 blocking grace periods. This requires careful synchronization to handle
 race conditions
 
-**Race condition causing Offline CPU to hang GP**
-
-A race between CPU offlining and new GP initialization (gp_init) may occur
-because `rcu_report_qs_rnp()` in `rcutree_report_cpu_dead()` must temporarily
-release the `rcu_node` lock to wake the RCU grace-period kthread:
+Race condition causing Offline CPU to hang GP
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-.. code-block:: none
+A race between CPU offlining and new GP initialization (gp_init()) may occur
+because rcu_report_qs_rnp() in rcutree_report_cpu_dead() must temporarily
+release the ``rcu_node`` lock to wake the RCU grace-period kthread::
 
    CPU1 (going offline)                 CPU0 (GP kthread)
    --------------------                 -----------------
@@ -2044,15 +2042,14 @@ release the `rcu_node` lock to wake the RCU grace-period kthread:
        // Reacquire lock (but too late)
      rnp->qsmaskinitnext &= ~mask       // Finally clears bit
 
-Without `ofl_lock`, the new grace period includes the offline CPU and waits
+Without ``ofl_lock``, the new grace period includes the offline CPU and waits
 forever for its quiescent state causing a GP hang.
 
-**A solution with ofl_lock**
+A solution with ofl_lock
+^^^^^^^^^^^^^^^^^^^^^^^^
 
-The `ofl_lock` (offline lock) prevents `rcu_gp_init()` from running during
-the vulnerable window when `rcu_report_qs_rnp()` has released `rnp->lock`:
-
-.. code-block:: none
+The ``ofl_lock`` (offline lock) prevents rcu_gp_init() from running during
+the vulnerable window when rcu_report_qs_rnp() has released ``rnp->lock``::
 
    CPU0 (rcu_gp_init)                   CPU1 (rcutree_report_cpu_dead)
    ------------------                   ------------------------------
@@ -2065,21 +2062,20 @@ the vulnerable window when `rcu_report_qs_rnp()` has released `rnp->lock`:
        arch_spin_unlock(&ofl_lock) ---> // Now CPU1 can proceed
    }                                    // But snapshot already taken
 
-**Another race causing GP hangs in rcu_gpu_init(): Reporting QS for Now-offline CPUs**
+Another race causing GP hangs in rcu_gpu_init(): Reporting QS for Now-offline CPUs
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 After the first loop takes an atomic snapshot of online CPUs, as shown above,
-the second loop in `rcu_gp_init()` detects CPUs that went offline between
-releasing `ofl_lock` and acquiring the per-node `rnp->lock`. This detection is
-crucial because:
+the second loop in rcu_gp_init() detects CPUs that went offline between
+releasing ``ofl_lock`` and acquiring the per-node ``rnp->lock``.
+This detection is crucial because:
 
 1. The CPU might have gone offline after the snapshot but before the second loop
 2. The offline CPU cannot report its own QS if it's already dead
 3. Without this detection, the grace period would wait forever for CPUs that
    are now offline.
 
-The second loop performs this detection safely:
-
-.. code-block:: none
+The second loop performs this detection safely::
 
    rcu_for_each_node_breadth_first(rnp) {
        raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -2093,10 +2089,10 @@ The second loop performs this detection safely:
    }
 
 This approach ensures atomicity: quiescent state reporting for offline CPUs
-happens either in `rcu_gp_init()` (second loop) or in `rcutree_report_cpu_dead()`,
-never both and never neither. The `rnp->lock` held throughout the sequence
-prevents races - `rcutree_report_cpu_dead()` also acquires this lock when
-clearing `qsmaskinitnext`, ensuring mutual exclusion.
+happens either in rcu_gp_init() (second loop) or in rcutree_report_cpu_dead(),
+never both and never neither. The ``rnp->lock`` held throughout the sequence
+prevents races - rcutree_report_cpu_dead() also acquires this lock when
+clearing ``qsmaskinitnext``, ensuring mutual exclusion.
 
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
-- 
2.40.1

