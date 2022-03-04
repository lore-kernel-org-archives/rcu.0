Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC7FC433F5
	for <rcu@archiver.kernel.org>; Fri,  4 Mar 2022 23:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiCDXWW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Mar 2022 18:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCDXWV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Mar 2022 18:22:21 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D7E224501
        for <rcu@vger.kernel.org>; Fri,  4 Mar 2022 15:21:33 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id g24so7680136qkl.3
        for <rcu@vger.kernel.org>; Fri, 04 Mar 2022 15:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=siFXKGyb4WioVadP46x1bP2FG0qNcQNiUepiQvedImY=;
        b=bzqYK4Q0cO2Nnjn5K+ImHLysilCgv6ZjAG79TTMbyo1TWy4CjE7X2IjkpiWN2Isnbb
         9lkKpQmnm2CFg/RW5WE//ygZfAA6eVZ9AXIVTF3v1i60bXJMDlt3A5aYTKJdQrz9LMFd
         F7CxvUzsCSXXaqYoPDpH7CRCnnGzJmyMdBmyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=siFXKGyb4WioVadP46x1bP2FG0qNcQNiUepiQvedImY=;
        b=Dqy1vKOVJK7Qpw01paq873/U/hWXxuxB2s18hPhtt11VdodK4VWJunQcpDvlDob+pN
         vgOC4MNBQTHIp5khYL9q9OuZ+mcbgqnjUf1XxiYjU1BrQ8XGoBHBN4woHKhelvULp8Rr
         LZ9CScm9AcalPwtzA+KwiKvobno/qS5nr83Bi096FaHgoV44/RP2Ri6tlD6RmvseoPul
         kdRHe61eyGodd3Ittb9eaaduT9cjjNd0b+pLnL0R5p/E5BVb3CuRdXbZVzzrTBxwGQ4n
         97bfj3gK41wdNgIBY73tPU4qYl9Y4nUotGRJuwX4bY3l8LRy1YC3t2lW/WIzIqWT2Ktk
         /RTw==
X-Gm-Message-State: AOAM5315ZtreT5XiXGAfZmJiUdPeC4mfC3pXD8h6BumOfp/9vzm5c+OY
        1ZJWbPm62RWTZqcg3jRtGhMIOw==
X-Google-Smtp-Source: ABdhPJztfEx5kYtyS2ZQAX0uVN3G/2wHe6y3O11IShfPfDP+R/woLRs2chfOlo9EEikG/7IdprzJIw==
X-Received: by 2002:a37:5d4:0:b0:508:18c2:30c1 with SMTP id 203-20020a3705d4000000b0050818c230c1mr689045qkf.376.1646436092387;
        Fri, 04 Mar 2022 15:21:32 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id o21-20020ac85a55000000b002d7847160c0sm4154741qta.82.2022.03.04.15.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:21:31 -0800 (PST)
Date:   Fri, 4 Mar 2022 23:21:31 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu-tasks: Use rcuwait for the rcu_tasks_kthread().
Message-ID: <YiKe+37M5d8ddSo/@google.com>
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

In theory, Sebasatian's idea makes sense to me. Since scheduler locks are not
sleepable even on -RT, using rcuwait-based wakeup is OK with the added
benefit that the no locking would be needed during the wake. Hence, this wake
up can happen even from hardirq context in an -RT kernel.

Correct me if I got that wrong though.

thanks,

 - Joel


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
