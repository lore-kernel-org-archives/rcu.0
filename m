Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A51C433EF
	for <rcu@archiver.kernel.org>; Sat,  5 Mar 2022 04:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiCEElA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Mar 2022 23:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiCEElA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Mar 2022 23:41:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E797C580D4
        for <rcu@vger.kernel.org>; Fri,  4 Mar 2022 20:40:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 961E3B82B66
        for <rcu@vger.kernel.org>; Sat,  5 Mar 2022 04:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544BAC004E1;
        Sat,  5 Mar 2022 04:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646455208;
        bh=IFCWxgRqj3/7k+8r8F2hwSLZx8jyUGzSAaYXsMCbuIY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l9xv0xLmohVZmqEyxDCdrSvMmTLkyNOSB/JpkxcXczz/+nkfNxE9owBvK9rhQuUdI
         LIdHBs0GgMNbEd/38QbWsHge2QH5X1pZ4cqmp4H/IWdNMAfoFutbKXT3uqUbg4qsT6
         ScyF7b3Wr6GHyE66mJuERWxym7Ay4MJ/vHsaCKHEa1lyxfdjblIiCrV2ELEpTHryg4
         M3D08fhrD5Kx6cUhi45qUCLojY/2oatiWeU52c+D7kfNlAVth6DuxNpIFGd6Vq8wgh
         tbvCZGNSiE1dQkxMZ+taFmN1pjIViLj20AQctDgQZjUvs+1Pz1gzQDlDrj4yUecu3n
         bqXp7IvHe5LxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D5F0B5C0920; Fri,  4 Mar 2022 20:40:07 -0800 (PST)
Date:   Fri, 4 Mar 2022 20:40:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu-tasks: Use rcuwait for the rcu_tasks_kthread().
Message-ID: <20220305044007.GV4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
 <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
 <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <YiHy7Y5fTU3jRdMi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiHy7Y5fTU3jRdMi@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 04, 2022 at 12:07:25PM +0100, Sebastian Andrzej Siewior wrote:
> The waitqueue used by rcu_tasks_kthread() has always only one waiter.
> With a guaranteed only one waiter, this can be replaced with rcuwait
> which is smaller and simpler. With rcuwait based wake counterpart, the
> irqwork function (call_rcu_tasks_iw_wakeup()) can be invoked hardirq
> context because it is only a wake up and no sleeping locks are involved
> (unlike the wait_queue_head).
> As a side effect, this is also one piece of the puzzle to pass the RCU
> selftest at early boot on PREEMPT_RT.
> 
> Replace wait_queue_head with rcuwait and let the irqwork run in hardirq
> context on PREEMPT_RT.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> On 2022-03-03 12:02:37 [-0800], Paul E. McKenney wrote:
> > There is indeed only ever one waiter.  
> > 
> > But rcuwait is going to acquire scheduler locks, correct?  It would be
> > better to avoid that potential deadlock.
> 
> This is what I had in mind. Does this work for you?

This does seem to be working, thank you!  I even manually inserted
a pi_lock() acquisition across one of the calls to call_rcu_tasks(),
and it did seem to work.

>  kernel/rcu/tasks.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index d64f0b1d8cd3b..f804afb304135 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -46,7 +46,7 @@ struct rcu_tasks_percpu {
>  
>  /**
>   * struct rcu_tasks - Definition for a Tasks-RCU-like mechanism.
> - * @cbs_wq: Wait queue allowing new callback to get kthread's attention.
> + * @cbs_wait: RCU wait allowing a new callback to get kthread's attention.
>   * @cbs_gbl_lock: Lock protecting callback list.
>   * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
>   * @gp_func: This flavor's grace-period-wait function.
> @@ -77,7 +77,7 @@ struct rcu_tasks_percpu {
>   * @kname: This flavor's kthread name.
>   */
>  struct rcu_tasks {
> -	struct wait_queue_head cbs_wq;
> +	struct rcuwait cbs_wait;
>  	raw_spinlock_t cbs_gbl_lock;
>  	int gp_state;
>  	int gp_sleep;
> @@ -113,11 +113,11 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
>  #define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
>  static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
>  	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
> -	.rtp_irq_work = IRQ_WORK_INIT(call_rcu_tasks_iw_wakeup),			\
> +	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),			\

This is the key piece, right?  If so, I am wondering if there are other
irq_work instances that need to move to _HARD.

							Thanx, Paul

>  };											\
>  static struct rcu_tasks rt_name =							\
>  {											\
> -	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(rt_name.cbs_wq),			\
> +	.cbs_wait = __RCUWAIT_INITIALIZER(rt_name.wait),				\
>  	.cbs_gbl_lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name.cbs_gbl_lock),			\
>  	.gp_func = gp,									\
>  	.call_func = call,								\
> @@ -261,7 +261,7 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
>  	struct rcu_tasks_percpu *rtpcp = container_of(iwp, struct rcu_tasks_percpu, rtp_irq_work);
>  
>  	rtp = rtpcp->rtpp;
> -	wake_up(&rtp->cbs_wq);
> +	rcuwait_wake_up(&rtp->cbs_wait);
>  }
>  
>  // Enqueue a callback for the specified flavor of Tasks RCU.
> @@ -509,7 +509,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
>  
>  		/* If there were none, wait a bit and start over. */
> -		wait_event_idle(rtp->cbs_wq, (needgpcb = rcu_tasks_need_gpcb(rtp)));
> +		rcuwait_wait_event(&rtp->cbs_wait,
> +				   (needgpcb = rcu_tasks_need_gpcb(rtp)),
> +				   TASK_IDLE);
>  
>  		if (needgpcb & 0x2) {
>  			// Wait for one grace period.
> -- 
> 2.35.1
> 
