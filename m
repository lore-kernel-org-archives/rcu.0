Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADFAC47076
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 18:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A2F6138C
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 18:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhEUSCv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 May 2021 14:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232931AbhEUSCv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 May 2021 14:02:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1129461004;
        Fri, 21 May 2021 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621620088;
        bh=I1mPSruZJKQMN8Q9puFaJiMHWUrjaOtRwC2UztdGKwE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dwu3rnHipJmAWYZyEDTLrK3sYp4T7XLhXIa3lb21Aef+4TTUrNDMLkXooWk9medC4
         b3xKxAAGxqE/botcquDFf77EBUZgl7enSHZtdkbn+r6mQJJf+xu5yLKDCc487nHv7F
         hN0L/xE+0icaGOsWH+g1cOV9yxqjtESHKH0M/yWX3ANEpDlbWadulH3miQRb12lFk+
         InyrUpuHNZuVRipt2MVnJ35tEPBfFyGlSl9WI/HUS7vHLcpLK1nOhoJpfuoHE6/1Uy
         BYPeIpEH6otyhT0XA+hxhiHYb92BtE91gteaePElc0cF/7NXW0SxCQJeKRqsEZW9Lp
         R/78csACn40CA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E2C2D5C018D; Fri, 21 May 2021 11:01:27 -0700 (PDT)
Date:   Fri, 21 May 2021 11:01:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] rcu/tree: handle VM stoppage in stall detection
Message-ID: <20210521180127.GD4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210521155624.174524-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521155624.174524-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, May 22, 2021 at 12:56:23AM +0900, Sergey Senozhatsky wrote:
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
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

I have queued both for testing and further review, thank you!

							Thanx, Paul

> ---
> 
> v2: fixed powerpc build breakage
> 
>  kernel/rcu/tree_stall.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index d574e3bbd929..bc689911a81d 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -7,6 +7,8 @@
>   * Author: Paul E. McKenney <paulmck@linux.ibm.com>
>   */
>  
> +#include <linux/kvm_para.h>
> +
>  //////////////////////////////////////////////////////////////////////////////
>  //
>  // Controlling CPU stall warnings, including delay calculation.
> @@ -698,6 +700,14 @@ static void check_cpu_stall(struct rcu_data *rdp)
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
> @@ -707,6 +717,14 @@ static void check_cpu_stall(struct rcu_data *rdp)
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
> 2.31.1.818.g46aad6cb9e-goog
> 
