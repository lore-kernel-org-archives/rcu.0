Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9627C4338F
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 17:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7216101B
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 17:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhG0RXw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhG0RXv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jul 2021 13:23:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6785D60FF2;
        Tue, 27 Jul 2021 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627406631;
        bh=HLc2BDM2kYwcp2NlTEFookZLAzj0dilN5nei4XsYuw4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qjWOiLDlBg+C2NwZ8sanGMQb9HD3voSLEAcHVCNfdEyKgGIrwU1Nk2NzvnjSUG7Zb
         Px0l7udykWVNl7+NuZB5sPQBRd6zAg8PobGoovWxdnwf9RRWQkFCpppRCc9ZTxgZ+F
         dBDora9hio2u9UnLpwDKo9wm9ba9KvFBeuRu747NdgnRFTyIrKv9wYUb7nfqYgnihT
         r9Cz7eWTE48vuwIAwYZJTKOKVP4Z2b2dEeY0c+oxc6e2kNunIKEgJBPdfxlZ9hLLPt
         vOLzLnA8cevx8ce37jHYQDUdJk5PCeK3UjbyXmvVNc4hT6Ckt/hlVQ0C7jzd5T17dJ
         ogk9ymUFm890A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2BE5C5C099F; Tue, 27 Jul 2021 10:23:51 -0700 (PDT)
Date:   Tue, 27 Jul 2021 10:23:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] rcu/nocb: Extend checks for offloaded rdp by
 migrate_disable
Message-ID: <20210727172351.GC4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210727163815.nwvg5delbqs3ysxl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210727163815.nwvg5delbqs3ysxl@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 27, 2021 at 06:38:15PM +0200, Sebastian Andrzej Siewior wrote:
> Commit 3820b513a2e33 ("rcu/nocb: Detect unsafe checks for offloaded
> rdp") added checks for safe rdp usage in the nocb case.
> 
> On PREEMPT_RT this checks triggers in the
>  rcu_cpu_kthread() -> rcu_core() -> rcu_check_quiescent_state() ->
>   rcu_rdp_is_offloaded()
> 
> call chain. On !PREEMPT_RT this warnings is suppressed because rcu_core()
> is invoked with disabled BH which also disables preemption and
> "preemptible()" is part of the checks which are considered safe.
> On PREEMPT_RT disabling BH does not disable preemption and since there
> is no other criteria the warning triggers.
> 
> According to the mentioned commit the goal is to check if the rcu data
> pointer is "stable … and prevent from its value to be changed under us".
> My understanding is that this may happen if the task is preemptible and
> therefore free to be migrated to another CPU which would then lead to
> another value of `rcu_data'.
> One thing that has been overseen is that a task within a migrate-disable
> region (as on PREEMPT_RT with disabled BH) is fully preemptible but may
> not be migrated to another CPU which should be enough to guarantee that
> rdp remains stable.
> 
> Check also disabled migration of the task if the RCU data pointer is
> from current CPU. Put the whole check within an SMP ifdef block since
> without SMP there are not CPU migrations to worry about (also
> task_struct::migration_disabled is missing).
> 
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> I don't fully understand why the CPU-hotplug lock matters here but this
> is beside the point ;)

If I remember correctly, any attempt to change the offloaded state
must hold off CPU-hotplug operations.  So if the current thread is
holding off CPU-hotplug operations, no other thread can be doing
an offload or de-offload operation.

>  kernel/rcu/tree_plugin.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 0ff5e4fb933e7..d8a623ba7d243 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -57,16 +57,18 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>  	 * timers have their own means of synchronization against the
>  	 * offloaded state updaters.
>  	 */
> +#ifdef CONFIG_SMP
>  	RCU_LOCKDEP_WARN(
>  		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
>  		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
>  		  rcu_lockdep_is_held_nocb(rdp) ||
>  		  (rdp == this_cpu_ptr(&rcu_data) &&
> -		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
> +		   (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) ||


> +		    current->migration_disabled)) ||

How does this change interact with the one proposed by Valentin?

https://lore.kernel.org/lkml/20210721115118.729943-3-valentin.schneider@arm.com/

							Thanx, Paul

>  		  rcu_current_is_nocb_kthread(rdp)),
>  		"Unsafe read of RCU_NOCB offloaded state"
>  	);
> -
> +#endif
>  	return rcu_segcblist_is_offloaded(&rdp->cblist);
>  }
>  
> -- 
> 2.32.0
> 
