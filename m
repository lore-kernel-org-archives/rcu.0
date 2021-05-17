Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08657C433B4
	for <rcu@archiver.kernel.org>; Mon, 17 May 2021 16:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0DF610A8
	for <rcu@archiver.kernel.org>; Mon, 17 May 2021 16:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbhEQQZD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 May 2021 12:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346334AbhEQQY3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 May 2021 12:24:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0079461042;
        Mon, 17 May 2021 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621268593;
        bh=LX1Um5xURyTO5CyK1WgfQ2dHQ8bucxW1gMUuqNrXqvk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tHd8cQLt8uXFmwCFoRcNsI9tWllC1HrjOmdoN34cdKStXcSbAbfdjeYyh2GVb7uwW
         VYK/mqS7qqSL7Dva0pGgU/meyuaQn5JFgnMsyvpnapLzVuWCww6A3UcL573AKPzf9D
         6doWT+aOjttLE0EtKYBeh2ljNEa5h4wqa2QGhqfHQSScQeJoRh/MyxJ9EoRs5x6V9o
         W4S8aUjeJdmMRyCwCMVBkm2e+jkIH7tLZsJ5MF/1mLQxaGNbjlzLhQLX7gY3uKBmUJ
         iyvKcByFKHRH7QtFsZssDHJL7E4Ro2XCDilPo5F90u4mBbDmq06r9EGYNN6TlyHGNV
         2Fx/LKuQTkeaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C35885C00C6; Mon, 17 May 2021 09:23:12 -0700 (PDT)
Date:   Mon, 17 May 2021 09:23:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210516102716.689596-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516102716.689596-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 16, 2021 at 07:27:16PM +0900, Sergey Senozhatsky wrote:
> Soft watchdog timer function checks if a virtual machine
> was suspended and hence what looks like a lockup in fact
> is a false positive.
> 
> This is what kvm_check_and_clear_guest_paused() does: it
> tests guest PVCLOCK_GUEST_STOPPED (which is set by the host)
> and if it's set then we need to touch all watchdogs and bail
> out.
> 
> Watchdog timer function runs from IRQ, so PVCLOCK_GUEST_STOPPED
> check works fine.
> 
> There is, however, one more watchdog that runs from IRQ, so
> watchdog timer fn races with it, and that watchdog is not aware
> of PVCLOCK_GUEST_STOPPED - RCU stall detector.
> 
> apic_timer_interrupt()
>  smp_apic_timer_interrupt()
>   hrtimer_interrupt()
>    __hrtimer_run_queues()
>     tick_sched_timer()
>      tick_sched_handle()
>       update_process_times()
>        rcu_sched_clock_irq()
> 
> This triggers RCU stalls on our devices during VM resume.
> 
> If tick_sched_handle()->rcu_sched_clock_irq() runs on a VCPU
> before watchdog_timer_fn()->kvm_check_and_clear_guest_paused()
> then there is nothing on this VCPU that touches watchdogs and
> RCU reads stale gp stall timestamp and new jiffies value, which
> makes it think that RCU has stalled.
> 
> Make RCU stall watchdog aware of PVCLOCK_GUEST_STOPPED and
> don't report RCU stalls when we resume the VM.

Good point!

But if I understand your patch correctly, if the virtual machine is
stopped at any point during a grace period, even if only for a short time,
stall warnings are suppressed for that grace period forever, courtesy of
the call to rcu_cpu_stall_reset().  So, if something really is stalling,
and the virtual machine just happens to stop for a few milliseconds, the
stall warning is completely suppressed.  Which would make it difficult
to debug the underlying stall condition.

Is it possible to provide RCU with information on the duration of the
virtual-machine stoppage so that RCU could adjust the timing of the
stall warning?  Maybe by having something like rcu_cpu_stall_reset()
that takes the duration of the stoppage in jiffies?

Please note that I am not completely opposed to your patch below, but
I figured that this was a good time to ask if we can do better.

							Thanx, Paul

> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  kernel/rcu/tree_stall.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 59b95cc5cbdf..cb233c79f0bc 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -7,6 +7,8 @@
>   * Author: Paul E. McKenney <paulmck@linux.ibm.com>
>   */
>  
> +#include <asm/kvm_para.h>
> +
>  //////////////////////////////////////////////////////////////////////////////
>  //
>  // Controlling CPU stall warnings, including delay calculation.
> @@ -695,6 +697,14 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
>  	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
>  
> +		/*
> +		 * If a virtual machine is stopped by the host it can look to
> +		 * the watchdog like an RCU stall. Check to see if the host
> +		 * stopped the vm.
> +		 */
> +		if (kvm_check_and_clear_guest_paused())
> +			return;
> +
>  		/* We haven't checked in, so go dump stack. */
>  		print_cpu_stall(gps);
>  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
> @@ -704,6 +714,14 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
>  		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
>  
> +		/*
> +		 * If a virtual machine is stopped by the host it can look to
> +		 * the watchdog like an RCU stall. Check to see if the host
> +		 * stopped the vm.
> +		 */
> +		if (kvm_check_and_clear_guest_paused())
> +			return;
> +
>  		/* They had a few time units to dump stack, so complain. */
>  		print_other_cpu_stall(gs2, gps);
>  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
> -- 
> 2.31.1.751.gd2f1c929bd-goog
> 
