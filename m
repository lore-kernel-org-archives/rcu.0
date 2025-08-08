Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790AD528;
	Fri,  8 Aug 2025 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754674450; cv=none; b=GXeTrkEauEPsaByPkeIbccfUg2D7Wc/jgdDPnbToHkcxKoXgUcPssvg5YPyk+ExHVSv7DpquqItOG3ffI3/1l+kHUBzCR6hAIQAdPUe2tO1lW/7OF5bUeWrEmjeDomiLa0W8XHFX1oPMxVzjaMtiNckgywGJLx8D/JtVcsIHBf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754674450; c=relaxed/simple;
	bh=8XF8Ga2PDNSnYb/eoI/7Oc7qMvpQES/wciKSY+UdJcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQSMk+8h+DEFD9su4RVPatl5270SvTj6YB4Y4goQ8diIOYxVfxobpJ4v85R3zVZ8Hxi5Z08VYFEDva3uHi5+xDa12enTC0uMggnoa+hPu5069UGHuZnhiKgzQuaPvmxoBtt9WHJQdYBnq3Nunl8EBYoOrE85TFNhZwpK6qeLi40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLsCNMju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLsCNMju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C1FC4CEED;
	Fri,  8 Aug 2025 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754674450;
	bh=8XF8Ga2PDNSnYb/eoI/7Oc7qMvpQES/wciKSY+UdJcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLsCNMjuwhAo0FuIoJXhVZM4/ixLBmxsADPA1eRcphryEZr3E0JBXhMlxanCOCGR/
	 COeId181qU2J0gGdJFKxNEkxX18N8khJLaF1AtTCbqDF16unfQovUbC/FOZsdX9ZhW
	 QB3s/pIPP5dkTEN239l08Lu/6ipXbbVZKjGB3IspRP+VcX4xEZFuoMNR0vbbKIfNuj
	 0Q2TyxV6qimkgmulrRHqkmr97n9MDu9duOn7ZoAo5/PUIjSGMJgf2Pv7DbK87/gYVx
	 Fl/hF+cHzbu95+oIqCltppCve1htXfUcLXTp5hHXziwUnLVBYSyxO4WSi9tsCbYYGg
	 wqQAs+8ud5Ymg==
Date: Fri, 8 Aug 2025 19:34:06 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Qi Xi <xiqi2@huawei.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	rcu@vger.kernel.org
Subject: Re: [linus:master] [rcu]  b41642c877: BUG:kernel_hang_in_boot_stage
Message-ID: <aJY1DsIUQxzq1U1Q@localhost.localdomain>
References: <202508071303.c1134cce-lkp@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202508071303.c1134cce-lkp@intel.com>

Le Thu, Aug 07, 2025 at 01:39:32PM +0800, kernel test robot a écrit :
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:kernel_hang_in_boot_stage" on:
> 
> commit: b41642c87716bbd09797b1e4ea7d904f06c39b7b ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      7e161a991ea71e6ec526abc8f40c6852ebe3d946]
> [test failed on linux-next/master 5c5a10f0be967a8950a2309ea965bae54251b50e]
> 
> in testcase: boot
> 
> config: i386-randconfig-2006-20250804
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +-------------------------------+------------+------------+
> |                               | d827673d8a | b41642c877 |
> +-------------------------------+------------+------------+
> | boot_successes                | 15         | 0          |
> | boot_failures                 | 0          | 15         |
> | BUG:kernel_hang_in_boot_stage | 0          | 15         |
> +-------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202508071303.c1134cce-lkp@intel.com

#syz test

From a3cc7624264743996d2ad1295741933103a8d63b Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Fri, 8 Aug 2025 19:03:22 +0200
Subject: [PATCH] rcu: Fix racy re-initialization of irq_work causing hangs

RCU re-initializes the deferred QS irq work everytime before attempting
to queue it. However there are situations where the irq work is
attempted to be queued even though it is already queued. In that case
re-initializing messes-up with the irq work queue that is about to be
handled.

The chances for that to happen are higher when the architecture doesn't
support self-IPIs and irq work are then all lazy, such as with the
following sequence:

1) rcu_read_unlock() is called when IRQs are disabled and there is a
   grace period involving blocked tasks on the node. The irq work
   is then initialized and queued.

2) The related tasks are unblocked and the CPU quiescent state
   is reported. rdp->defer_qs_iw_pending is reset to DEFER_QS_IDLE,
   allowing the irq work to be requeued in the future (note the previous
   one hasn't fired yet).

3) A new grace period starts and the node has blocked tasks.

4) rcu_read_unlock() is called when IRQs are disabled again. The irq work
   is re-initialized (but it's queued! and its node is cleared) and
   requeued. Which means it's requeued to itself.

5) The irq work finally fires with the tick. But since it was requeued
   to itself, it loops and hangs.

Fix this with initializing the irq work only once before the CPU boots.

Fixes: b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508071303.c1134cce-lkp@intel.com
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c        | 2 ++
 kernel/rcu/tree.h        | 1 +
 kernel/rcu/tree_plugin.h | 8 ++++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8c22db759978..3a17466ae84a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4242,6 +4242,8 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+
+	rcu_preempt_deferred_qs_init(rdp);
 	rcu_spawn_rnp_kthreads(rnp);
 	rcu_spawn_cpu_nocb_kthread(cpu);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.n_online_cpus);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index de6ca13a7b5f..b8bbe7960cda 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -488,6 +488,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp);
 static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
 static void rcu_flavor_sched_clock_irq(int user);
 static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
+static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static bool rcu_is_callbacks_kthread(struct rcu_data *rdp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b6f44871f774..c99701dfffa9 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -699,8 +699,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			    cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-				rdp->defer_qs_iw =
-					IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
 				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
@@ -840,6 +838,10 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 	}
 }
 
+static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp)
+{
+	rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
+}
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
 /*
@@ -1039,6 +1041,8 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 	WARN_ON_ONCE(!list_empty(&rnp->blkd_tasks));
 }
 
+static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp) { }
+
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
 /*
-- 
2.50.1




-- 
Frederic Weisbecker
SUSE Labs
