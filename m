Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6804C433C1
	for <rcu@archiver.kernel.org>; Tue, 30 Mar 2021 20:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFE261985
	for <rcu@archiver.kernel.org>; Tue, 30 Mar 2021 20:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhC3Uu0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Mar 2021 16:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232286AbhC3UuP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 Mar 2021 16:50:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47796619C5;
        Tue, 30 Mar 2021 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617137415;
        bh=tEAaMi25yS2z1dnSdhQ8QZl8Bk7j7DHZni+5n8JXYHc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Rdzc8CkvroMV7cdj/UcdaPbo2V6+EbK5Rf5eGGZ97XaDBANE/rG+7+cKQTnwpHEB9
         m1Ibk9lTuQF1E2xyFtBa3EKaZVhD9ca0kZVpW660yJ/hcRARwn+NKi/ILj1xcVlxoE
         HDKW4AuGNRS5BPEiFiEK+crGd0S+kINUs1wrFoiXgpm0Ufp+KswEL5qzXoFvDXccCM
         NUIR0GVw8eGD3ikdReXz8HvPptPZhjii0LhMXQCb2WFi3qIsyTIZAUcgv3wIPpvKUF
         KB/tX9dmLa2UAzkburLzGOQWXLK6n1DUtJ1KGRUlb6v5bDoS5lBen2OXGkBgiw11HD
         vD6nEIjaDAYqw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 134903522698; Tue, 30 Mar 2021 13:50:15 -0700 (PDT)
Date:   Tue, 30 Mar 2021 13:50:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     340442286@qq.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU: some improvements to comments of tree.c
Message-ID: <20210330205015.GY2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210321031725.15823-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321031725.15823-1-zhouzhouyi@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Mar 21, 2021 at 11:17:25AM +0800, Zhouyi Zhou wrote:
> During my study of RCU, I go through tree.c many times
> and try to make some improvements to the comments.
> 
> Thanks a lot.

Thank you for looking this over and for the patch!

The commit log should read something like this:

	This commit provides some cleanups to comments and code in the
	kernel/rcu/tree.c file.

I have provided responses below, followed by a modified commit.
Please let me know if you have objections to having your Signed-off-by
on this modified commit.

> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
>  kernel/rcu/tree.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index da6f5213fb74..50c6b8fd8d08 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -201,7 +201,7 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
>   * the need for long delays to increase some race probabilities with the
>   * need for fast grace periods to increase other race probabilities.
>   */
> -#define PER_RCU_NODE_PERIOD 3	/* Number of grace periods between delays. */
> +#define PER_RCU_NODE_PERIOD 3	/* Number of grace periods between delays, for debug purpose. */

This should be something like "delays for debugging".

>  /*
>   * Compute the mask of online CPUs for the specified rcu_node structure.
> @@ -835,9 +835,9 @@ void noinstr rcu_irq_exit(void)
>  
>  /**
>   * rcu_irq_exit_preempt - Inform RCU that current CPU is exiting irq
> - *			  towards in kernel preemption
> + *			  towards kernel preemption
>   *
> - * Same as rcu_irq_exit() but has a sanity check that scheduling is safe
> + * Same as rcu_irq_exit() but has some sanity checks that scheduling is safe
>   * from RCU point of view. Invoked from return from interrupt before kernel
>   * preemption.
>   */

Huh.  It does not look like this function is used.  And Thomas Gleixner
confirmed that it can be removed, which I did as a separate commit.

> @@ -959,7 +959,7 @@ EXPORT_SYMBOL_GPL(rcu_idle_exit);
>   */
>  void noinstr rcu_user_exit(void)
>  {
> -	rcu_eqs_exit(1);
> +	rcu_eqs_exit(true);

Fair enough, might as well be consistent with the other call to
rcu_eqs_exit().

>  }
>  
>  /**
> @@ -1226,7 +1226,7 @@ EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
>  #endif /* #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU) */
>  
>  /*
> - * We are reporting a quiescent state on behalf of some other CPU, so
> + * We may reporting a quiescent state on behalf of some other CPU, so

Fair enough, although we are trying to report or preparing to report
a quiescent state when invoking this function, we might end up not doing
so.  I reworded as follows:

 * When trying to report a quiescent state on behalf of some other CPU,

>   * it is our responsibility to check for and handle potential overflow
>   * of the rcu_node ->gp_seq counter with respect to the rcu_data counters.
>   * After all, the CPU might be in deep idle state, and thus executing no
> @@ -1808,9 +1808,9 @@ static bool rcu_gp_init(void)
>  		return false;
>  	}
>  
> -	/* Advance to a new grace period and initialize state. */
> -	record_gp_stall_check_time();
>  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> +	record_gp_stall_check_time();
> +	/* Advance to a new grace period and initialize state. */

Recording the grace-period stall machinery is part of advancing to a new
grace period, so I left this one as is.

>  	rcu_seq_start(&rcu_state.gp_seq);
>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
>  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> @@ -2630,7 +2630,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>   * state, for example, user mode or idle loop.  It also schedules RCU
>   * core processing.  If the current grace period has gone on too long,
>   * it will ask the scheduler to manufacture a context switch for the sole
> - * purpose of providing a providing the needed quiescent state.
> + * purpose of providing the needed quiescent state.

Good catch, applied as you suggested.

>   */
>  void rcu_sched_clock_irq(int user)
>  {
> @@ -3260,7 +3260,7 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
>  
>  /*
>   * This function is invoked in workqueue context after a grace period.
> - * It frees all the objects queued on ->bhead_free or ->head_free.
> + * It frees all the objects queued on ->bkvhead_free or ->head_free.

And for this one as well.

>   */
>  static void kfree_rcu_work(struct work_struct *work)
>  {
> @@ -3287,7 +3287,7 @@ static void kfree_rcu_work(struct work_struct *work)
>  	krwp->head_free = NULL;
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  
> -	// Handle two first channels.
> +	// Handle first two channels.

This one I translated the rest of the way to English as follows:

	// Handle the first two channels.

>  	for (i = 0; i < FREE_N_CHANNELS; i++) {
>  		for (; bkvhead[i]; bkvhead[i] = bnext) {
>  			bnext = bkvhead[i]->next;
> @@ -3530,7 +3530,7 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>  
>  /*
>   * Queue a request for lazy invocation of appropriate free routine after a
> - * grace period. Please note there are three paths are maintained, two are the
> + * grace period. Please note there are three paths maintained, two are the

I made this "Please note that three paths are maintained" and fixed up a few
other things, resulting in this:

 * Queue a request for lazy invocation of the appropriate free routine
 * after a grace period.  Please note that three paths are maintained,
 * two for the common case using arrays of pointers and a third one that
 * is used only when the main paths cannot be used, for example, due to
 * memory pressure.

>   * main ones that use array of pointers interface and third one is emergency
>   * one, that is used only when the main path can not be maintained temporary,
>   * due to memory pressure.
> @@ -3813,7 +3813,7 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu);
>  
>  /*
>   * Check to see if there is any immediate RCU-related work to be done by
> - * the current CPU, returning 1 if so and zero otherwise.  The checks are
> + * the current CPU, returning 1 if so and 0 otherwise.  The checks are

I am not feeling it for this one...

>   * in order of increasing expense: checks that can be carried out against
>   * CPU-local state are performed first.  However, we must check for CPU
>   * stalls first, else we might not get a chance.
> @@ -4153,7 +4153,7 @@ int rcutree_online_cpu(unsigned int cpu)
>  }
>  
>  /*
> - * Near the beginning of the process.  The CPU is still very much alive
> + * Near the beginning of the offline process. The CPU is still very much alive
>   * with pretty much all services enabled.
>   */
>  int rcutree_offline_cpu(unsigned int cpu)

The name of the function suffices here.

I will agree that finding all the pieces of RCU's CPU-hotplug processing
can be a bit annoying.  I have been thinking in terms of gathering these
functions into a tree_hotplug.c or similar.

Thoughts?

> @@ -4651,7 +4651,7 @@ void __init rcu_init(void)
>  		rcutree_online_cpu(cpu);
>  	}
>  
> -	/* Create workqueue for expedited GPs and for Tree SRCU. */
> +	/* Create workqueue for Tree SRCU and for expedited GPs. */

Fair enough...

>  	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
>  	WARN_ON(!rcu_gp_wq);
>  	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);

------------------------------------------------------------------------

commit 3f0d0d00b8f3fe58754071eb7726c5128b5816da
Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue Mar 30 13:47:42 2021 -0700

    rcu: Improve tree.c comments and add code cleanups
    
    This commit cleans up some comments and code in kernel/rcu/tree.c.
    
    Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 418c743..ce5b4cd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -202,7 +202,7 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
  * the need for long delays to increase some race probabilities with the
  * need for fast grace periods to increase other race probabilities.
  */
-#define PER_RCU_NODE_PERIOD 3	/* Number of grace periods between delays. */
+#define PER_RCU_NODE_PERIOD 3	/* Number of grace periods between delays for debugging. */
 
 /*
  * Compute the mask of online CPUs for the specified rcu_node structure.
@@ -938,7 +938,7 @@ EXPORT_SYMBOL_GPL(rcu_idle_exit);
  */
 void noinstr rcu_user_exit(void)
 {
-	rcu_eqs_exit(1);
+	rcu_eqs_exit(true);
 }
 
 /**
@@ -1204,7 +1204,7 @@ EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
 #endif /* #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU) */
 
 /*
- * We are reporting a quiescent state on behalf of some other CPU, so
+ * When trying to report a quiescent state on behalf of some other CPU,
  * it is our responsibility to check for and handle potential overflow
  * of the rcu_node ->gp_seq counter with respect to the rcu_data counters.
  * After all, the CPU might be in deep idle state, and thus executing no
@@ -2608,7 +2608,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
  * state, for example, user mode or idle loop.  It also schedules RCU
  * core processing.  If the current grace period has gone on too long,
  * it will ask the scheduler to manufacture a context switch for the sole
- * purpose of providing a providing the needed quiescent state.
+ * purpose of providing the needed quiescent state.
  */
 void rcu_sched_clock_irq(int user)
 {
@@ -3237,7 +3237,7 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 
 /*
  * This function is invoked in workqueue context after a grace period.
- * It frees all the objects queued on ->bhead_free or ->head_free.
+ * It frees all the objects queued on ->bkvhead_free or ->head_free.
  */
 static void kfree_rcu_work(struct work_struct *work)
 {
@@ -3264,7 +3264,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	krwp->head_free = NULL;
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
-	// Handle two first channels.
+	// Handle the first two channels.
 	for (i = 0; i < FREE_N_CHANNELS; i++) {
 		for (; bkvhead[i]; bkvhead[i] = bnext) {
 			bnext = bkvhead[i]->next;
@@ -3531,11 +3531,11 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 }
 
 /*
- * Queue a request for lazy invocation of appropriate free routine after a
- * grace period. Please note there are three paths are maintained, two are the
- * main ones that use array of pointers interface and third one is emergency
- * one, that is used only when the main path can not be maintained temporary,
- * due to memory pressure.
+ * Queue a request for lazy invocation of the appropriate free routine
+ * after a grace period.  Please note that three paths are maintained,
+ * two for the common case using arrays of pointers and a third one that
+ * is used only when the main paths cannot be used, for example, due to
+ * memory pressure.
  *
  * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
  * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
@@ -4709,7 +4709,7 @@ void __init rcu_init(void)
 		rcutree_online_cpu(cpu);
 	}
 
-	/* Create workqueue for expedited GPs and for Tree SRCU. */
+	/* Create workqueue for Tree SRCU and for expedited GPs. */
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_gp_wq);
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
