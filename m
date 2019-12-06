Return-Path: <SRS0=+k02=Z4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5440EC2D0BF
	for <rcu@archiver.kernel.org>; Fri,  6 Dec 2019 01:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FF32075C
	for <rcu@archiver.kernel.org>; Fri,  6 Dec 2019 01:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bKWDDBEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfLFBlh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:41:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39668 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfLFBlh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Dec 2019 20:41:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so2483069pfx.6
        for <rcu@vger.kernel.org>; Thu, 05 Dec 2019 17:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eBL0dxUnCPdbAx80Pbs0LPxk1d8IlEiTZGPDdZ+eU8M=;
        b=bKWDDBEFJOmZD7o5VKensEdqDaj+WD3XggTcd/+f0NCSvPuNYvu3Yj9TRqVyBZJmq4
         cBB4oE5QNIjz80zSdTuccd4jdPxgU/cJ3rweq6G2IbJTEcfuBmr/aDz9I0EbTFtkduPy
         oxWLJfJE9JfV2Upn0/bVmsc+HTVyTm1IHzTnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eBL0dxUnCPdbAx80Pbs0LPxk1d8IlEiTZGPDdZ+eU8M=;
        b=phz+UQsA0PR/CKBv0SAP5mBOHsJCEAD+6g4gxBftQbE2gzk+1rlHbxH+f3xU/LIsvU
         ibskwY6JDITXaCr3KwPkeaGJTgzWOhqL7HphuqLtXmHe6CpSQOSndmTUPbrsxtIj/8Yn
         N+808AsUiPQ0OKWKCeYZUonRhKKyDHdQdb1Wqrf+7XvNhkDmFaDiLHmG4USPF+97UvcZ
         jGIZ1yv7ogw3aUcAtssb6O7r9MkXlVXF9aY1SZpp8wfT+HWGtSsq6QF753EyDkyg7iNB
         y7odxX6lKQmSBA9Nxao1r60Z2Yo1tUETtjJFNi0eYZ2ZbZuQFkkkGGeBSLobw+5nxEmL
         DR6w==
X-Gm-Message-State: APjAAAWhunnyGrLu3kt1kOGOvo5Wc37vO65ZKpYzR8u0hjF6tANzTne9
        hH3v3cmJ+vJhxlX0H6HcTflzFA==
X-Google-Smtp-Source: APXvYqzW9lZc1S8+hE8RbcQKemczaelZPfVH2ZZlhgwQiUxUk0zlY/6VFwBCfBnls83KdBW6ojBslg==
X-Received: by 2002:a62:1a16:: with SMTP id a22mr12068122pfa.34.1575596495882;
        Thu, 05 Dec 2019 17:41:35 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k12sm12567059pgm.65.2019.12.05.17.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 17:41:35 -0800 (PST)
Date:   Thu, 5 Dec 2019 20:41:34 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu] Enable tick for nohz_full CPUs not
 responding to expedited GP
Message-ID: <20191206014134.GA143492@google.com>
References: <20191204232544.GA17061@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204232544.GA17061@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 04, 2019 at 03:25:44PM -0800, Paul E. McKenney wrote:
> rcu: Enable tick for nohz_full CPUs slow to provide expedited QS
> 
> An expedited grace period can be stalled by a nohz_full CPU looping
> in kernel context.  This possibility is currently handled by some
> carefully crafted checks in rcu_read_unlock_special() that enlist help
> from ksoftirqd when permitted by the scheduler.  However, it is exactly
> these checks that require the scheduler avoid holding any of its rq or
> pi locks across rcu_read_unlock() without also having held them across
> the entire RCU read-side critical section.

Just got a bit more free to look into the topic of RCU-related scheduler
deadlocks I was previously looking into (And I will continue working on the
WIP patch for detecting bad scenarios).

> It would therefore be very nice if expedited grace periods could
> handle nohz_full CPUs looping in kernel context without such checks.

Could you clarify 'without such checks'? Are you referring to these checks in
_unlock_special()?
                if (irqs_were_disabled && use_softirq &&
                    (in_interrupt() ||
                     (exp && !t->rcu_read_unlock_special.b.deferred_qs))) {
                        // Using softirq, safe to awaken, and we get
                        // no help from enabling irqs, unlike bh/preempt.
                        raise_softirq_irqoff(RCU_SOFTIRQ);

I am sorry but I did not fully understand this patch motivation but -- you
are just saying you want EXP GPs to be handled quickly on nohz_full CPUs,
right? Are we not turning the tick on already in rcu_nmi_enter_common() for
handling slow EXP GPs as well? And if not, can we do it from there instead?

> This commit therefore adds code to the expedited grace period's wait
> and cleanup code that forces the scheduler-clock interrupt on for CPUs
> that fail to quickly supply a quiescent state.  "Quickly" is currently
> a hard-coded single-jiffy delay.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> ---
> 
> This is needed to avoid rcu_read_unlock_special() needing to enter
> the scheduler for the benefit of expedited grace periods on nohz_full
> CPUs, thus enabling more of Lai Jiangshan's patchset.

Still need to go through Lai's patches :-(. Will be looking to make more time
for the same.

thanks!

 - Joel


> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index 4ed788c..72a2a21 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -109,9 +109,10 @@ enum tick_dep_bits {
>  	TICK_DEP_BIT_PERF_EVENTS	= 1,
>  	TICK_DEP_BIT_SCHED		= 2,
>  	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
> -	TICK_DEP_BIT_RCU		= 4
> +	TICK_DEP_BIT_RCU		= 4,
> +	TICK_DEP_BIT_RCU_EXP		= 5
>  };
> -#define TICK_DEP_BIT_MAX TICK_DEP_BIT_RCU
> +#define TICK_DEP_BIT_MAX TICK_DEP_BIT_RCU_EXP
>  
>  #define TICK_DEP_MASK_NONE		0
>  #define TICK_DEP_MASK_POSIX_TIMER	(1 << TICK_DEP_BIT_POSIX_TIMER)
> @@ -119,6 +120,7 @@ enum tick_dep_bits {
>  #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
>  #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
>  #define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
> +#define TICK_DEP_MASK_RCU_EXP		(1 << TICK_DEP_BIT_RCU_EXP)
>  
>  #ifdef CONFIG_NO_HZ_COMMON
>  extern bool tick_nohz_enabled;
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 634c1db..0c87e4c 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -181,6 +181,7 @@ struct rcu_data {
>  	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
>  	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
>  	bool rcu_forced_tick;		/* Forced tick to provide QS. */
> +	bool rcu_forced_tick_exp;	/*   ... provide QS to expedited GP. */
>  #ifdef CONFIG_RCU_FAST_NO_HZ
>  	unsigned long last_accelerate;	/* Last jiffy CBs were accelerated. */
>  	unsigned long last_advance_all;	/* Last jiffy CBs were all advanced. */
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 726ba20..6935a9e 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -230,7 +230,9 @@ static void __maybe_unused rcu_report_exp_rnp(struct rcu_node *rnp, bool wake)
>  static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
>  				    unsigned long mask, bool wake)
>  {
> +	int cpu;
>  	unsigned long flags;
> +	struct rcu_data *rdp;
>  
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	if (!(rnp->expmask & mask)) {
> @@ -238,6 +240,13 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
>  		return;
>  	}
>  	WRITE_ONCE(rnp->expmask, rnp->expmask & ~mask);
> +	for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
> +		rdp = per_cpu_ptr(&rcu_data, cpu);
> +		if (!IS_ENABLED(CONFIG_NO_HZ_FULL) || !rdp->rcu_forced_tick_exp)
> +			continue;
> +		rdp->rcu_forced_tick_exp = false;
> +		tick_dep_clear_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
> +	}
>  	__rcu_report_exp_rnp(rnp, wake, flags); /* Releases rnp->lock. */
>  }
>  
> @@ -450,6 +459,26 @@ static void sync_rcu_exp_select_cpus(void)
>  }
>  
>  /*
> + * Wait for the expedited grace period to elapse, within time limit.
> + * If the time limit is exceeded without the grace period elapsing,
> + * return false, otherwise return true.
> + */
> +static bool synchronize_rcu_expedited_wait_once(long tlimit)
> +{
> +	int t;
> +	struct rcu_node *rnp_root = rcu_get_root();
> +
> +	t = swait_event_timeout_exclusive(rcu_state.expedited_wq,
> +					  sync_rcu_exp_done_unlocked(rnp_root),
> +					  tlimit);
> +	// Workqueues should not be signaled.
> +	if (t > 0 || sync_rcu_exp_done_unlocked(rnp_root))
> +		return true;
> +	WARN_ON(t < 0);  /* workqueues should not be signaled. */
> +	return false;
> +}
> +
> +/*
>   * Wait for the expedited grace period to elapse, issuing any needed
>   * RCU CPU stall warnings along the way.
>   */
> @@ -460,22 +489,31 @@ static void synchronize_rcu_expedited_wait(void)
>  	unsigned long jiffies_start;
>  	unsigned long mask;
>  	int ndetected;
> +	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
>  	struct rcu_node *rnp_root = rcu_get_root();
> -	int ret;
>  
>  	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
>  	jiffies_stall = rcu_jiffies_till_stall_check();
>  	jiffies_start = jiffies;
> +	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
> +		if (synchronize_rcu_expedited_wait_once(1))
> +			return;
> +		rcu_for_each_leaf_node(rnp) {
> +			for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
> +				rdp = per_cpu_ptr(&rcu_data, cpu);
> +				if (rdp->rcu_forced_tick_exp)
> +					continue;
> +				rdp->rcu_forced_tick_exp = true;
> +				tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
> +			}
> +		}
> +		WARN_ON_ONCE(1);
> +	}
>  
>  	for (;;) {
> -		ret = swait_event_timeout_exclusive(
> -				rcu_state.expedited_wq,
> -				sync_rcu_exp_done_unlocked(rnp_root),
> -				jiffies_stall);
> -		if (ret > 0 || sync_rcu_exp_done_unlocked(rnp_root))
> +		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
>  			return;
> -		WARN_ON(ret < 0);  /* workqueues should not be signaled. */
>  		if (rcu_cpu_stall_suppress)
>  			continue;
>  		panic_on_rcu_stall();
