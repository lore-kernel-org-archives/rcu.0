Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E39C433DB
	for <rcu@archiver.kernel.org>; Wed, 27 Jan 2021 05:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D692068D
	for <rcu@archiver.kernel.org>; Wed, 27 Jan 2021 05:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhA0FES (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 27 Jan 2021 00:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhA0DA5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 26 Jan 2021 22:00:57 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33263C06121E;
        Tue, 26 Jan 2021 18:43:14 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z6so480914qtn.0;
        Tue, 26 Jan 2021 18:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FoO5NyiBqMJQ60zgYVG26Tny5Gy1fOck0T7QXSobk/I=;
        b=quz7kDHwxrH6oKCBl694OBv2lYQDrylvgRS/VxF4jZ1WPnskNxxYvsF0zQDDLRkRWC
         pIzy6ep0y++4SerkGCI3FNzTvqxWzz/9vcgBlzs0LsnjEjYAvV5f4xa8qvrBRJwsojCK
         koN2iuBVXB47sQUhl2vgccE0KlydzCn0lgPR+b09/gi2VTpsiSNI5KVlTWK4vs+gVrna
         0AapMKxWi6895uOndbDo94jAKmnUiesoHbXtXxzPB2wdWq+cRvWz0BLggmnjpAuAe1dl
         HEWrOaBbK36DX4gYkIfM+KRQAW1P6bku/JmXJwdXAUV61pNvJHti8usKIgjGZ+SpQEMA
         hpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FoO5NyiBqMJQ60zgYVG26Tny5Gy1fOck0T7QXSobk/I=;
        b=U4bDYh7sMA9yhRJMpL12eeHC6s/0kgoE/vOtAs3EgW/23a5bm57q5jhKOzQ714+BfX
         7B51UluEDaw6Fy00jv8qIyCFf+lqnCBoYkzEAuXadLs6IaWEl3+V3SlqObsIhHwKDw16
         2qTgV7MtuP7YeWpHT3439HGs6ao1AesDib5hvxi+SzBrLN1jT+FctUKjb3HGp8BIA8E/
         NGyl5Z5rPM/jyPOkdpGByX4X9VMqmPFbEgWpXsxwaOubCN1d2ASwZ6ps6t2npE5LpODT
         wjrjIYLQsED0F6MT2l4Zrx1QGPzbn3Vr5iFBJ+APUPrdVxhYlPHGsftJSojTt9QBZlb+
         g9vw==
X-Gm-Message-State: AOAM530mxwkUz5A0mEcZ7J8q0U0pecUxjaA79voivKBR8DmMUeqyBWtu
        d5LE740Bp0dFVJC80n/pRaY=
X-Google-Smtp-Source: ABdhPJwb/RjJQymO5V8o2lw64jiz7y7FcDDy7Te113NlvwBf2vE7d6JDz0hJnTvdVrMH5ZABmu3V5Q==
X-Received: by 2002:aed:34c7:: with SMTP id x65mr7910414qtd.210.1611715393459;
        Tue, 26 Jan 2021 18:43:13 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c12sm338749qkg.118.2021.01.26.18.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 18:43:12 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id BA4A627C0054;
        Tue, 26 Jan 2021 21:43:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 26 Jan 2021 21:43:11 -0500
X-ME-Sender: <xms:PtMQYLjarwezrzQW0Zo0KrQqG5bfthVix_edTpFm9zVg7c25p3yNOQ>
    <xme:PtMQYICM972Kf3QniAshd6pgIv4EzLvlAUJM0_3BJpt7LB3dPIzcif7LLPYl34jp-
    V0v-Ky9SrNmAOcYxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtggdttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeuueekfffhhffhveehvdfhfedvfeffgeeguefhfedvvdffuddvgfeiveetudef
    jeenucfkphepudefuddruddtjedrudegjedruddvieenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:PtMQYLEqAsjjLLL4hEbEprIxDlcIqjLZzdOE5Rk8ntjmI8pe6K5Hjg>
    <xmx:PtMQYISfVjn6kG4toQFhrVn4bfFjmCIRe4hK5ozh2xo8HSiejOGt6g>
    <xmx:PtMQYIxHJv_pnpdD2YcqS8sr29tO2hgFdLPs05d6ZVyF0XiqPOtRqA>
    <xmx:P9MQYMlG8HgSC0N1Dj7nEe2Nh4qfGYF_F0znHm2jSSKq0ChX8FGjyXhWnNk>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 34355108005C;
        Tue, 26 Jan 2021 21:43:10 -0500 (EST)
Date:   Wed, 27 Jan 2021 10:42:35 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: Re: [PATCH tip/core/rcu 1/4] rcu: Expedite deboost in case of
 deferred quiescent state
Message-ID: <YBDTG5HEC6OLV8OQ@boqun-archlinux>
References: <20210120043144.GA7045@paulmck-ThinkPad-P72>
 <20210120043236.7254-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120043236.7254-1-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Tue, Jan 19, 2021 at 08:32:33PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> Historically, a task that has been subjected to RCU priority boosting is
> deboosted at rcu_read_unlock() time.  However, with the advent of deferred
> quiescent states, if the outermost rcu_read_unlock() was invoked with
> either bottom halves, interrupts, or preemption disabled, the deboosting
> will be delayed for some time.  During this time, a low-priority process
> might be incorrectly running at a high real-time priority level.
> 
> Fortunately, rcu_read_unlock_special() already provides mechanisms for
> forcing a minimal deferral of quiescent states, at least for kernels
> built with CONFIG_IRQ_WORK=y.  These mechanisms are currently used
> when expedited grace periods are pending that might be blocked by the
> current task.  This commit therefore causes those mechanisms to also be
> used in cases where the current task has been or might soon be subjected
> to RCU priority boosting.  Note that this applies to all kernels built
> with CONFIG_RCU_BOOST=y, regardless of whether or not they are also
> built with CONFIG_PREEMPT_RT=y.
> 
> This approach assumes that kernels build for use with aggressive real-time
> applications are built with CONFIG_IRQ_WORK=y.  It is likely to be far
> simpler to enable CONFIG_IRQ_WORK=y than to implement a fast-deboosting
> scheme that works correctly in its absence.
> 
> While in the area, alphabetize the rcu_preempt_deferred_qs_handler()
> function's local variables.
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Scott Wood <swood@redhat.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree_plugin.h | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 8b0feb2..fca31c6 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -660,9 +660,9 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  static void rcu_read_unlock_special(struct task_struct *t)
>  {
>  	unsigned long flags;
> +	bool irqs_were_disabled;
>  	bool preempt_bh_were_disabled =
>  			!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
> -	bool irqs_were_disabled;
>  
>  	/* NMI handlers cannot block and cannot safely manipulate state. */
>  	if (in_nmi())
> @@ -671,30 +671,32 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  	local_irq_save(flags);
>  	irqs_were_disabled = irqs_disabled_flags(flags);
>  	if (preempt_bh_were_disabled || irqs_were_disabled) {
> -		bool exp;
> +		bool expboost; // Expedited GP in flight or possible boosting.
>  		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  		struct rcu_node *rnp = rdp->mynode;
>  
> -		exp = (t->rcu_blocked_node &&
> -		       READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
> -		      (rdp->grpmask & READ_ONCE(rnp->expmask));
> +		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
> +			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
> +			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
> +			    t->rcu_blocked_node);

I take it that you check whether possible boosting is in progress via
the last expression of "||", ie:

	(IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
	t->rcu_blocked_node)

if so, I don't see the point of using the new "expboost" in the
raise_softirq_irqoff() branch, because if in_irq() is false, we only
raise softirq if irqs_were_disabled is false (otherwise, we may take the
risk of doing a wakeup with a pi or rq lock held, IIRC), and the
boosting part of the "expboost" above is only true if irqs_were_disabled
is true, so using expboost makes no different here.

>  		// Need to defer quiescent state until everything is enabled.
> -		if (use_softirq && (in_irq() || (exp && !irqs_were_disabled))) {
> +		if (use_softirq && (in_irq() || (expboost && !irqs_were_disabled))) {
>  			// Using softirq, safe to awaken, and either the
> -			// wakeup is free or there is an expedited GP.
> +			// wakeup is free or there is either an expedited
> +			// GP in flight or a potential need to deboost.

and this comment will be incorrect, we won't enter here solely because
there is a potential need to deboost.

That said, why the boosting condition has a "irqs_were_disabled" in it?
What if a task gets boosted because of RCU boosting, and exit the RCU
read-side c.s. with irq enabled and there is no expedited GP in flight,
will the task get deboosted quickly enough?

Maybe I'm missing some subtle?

Regards,
Boqun

>  			raise_softirq_irqoff(RCU_SOFTIRQ);
>  		} else {
>  			// Enabling BH or preempt does reschedule, so...
> -			// Also if no expediting, slow is OK.
> -			// Plus nohz_full CPUs eventually get tick enabled.
> +			// Also if no expediting and no possible deboosting,
> +			// slow is OK.  Plus nohz_full CPUs eventually get
> +			// tick enabled.
>  			set_tsk_need_resched(current);
>  			set_preempt_need_resched();
>  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> -			    !rdp->defer_qs_iw_pending && exp && cpu_online(rdp->cpu)) {
> +			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
> -				init_irq_work(&rdp->defer_qs_iw,
> -					      rcu_preempt_deferred_qs_handler);
> +				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
>  				rdp->defer_qs_iw_pending = true;
>  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>  			}
> -- 
> 2.9.5
> 
