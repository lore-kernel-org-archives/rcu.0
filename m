Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0031C433E0
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 01:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB4A64DDA
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 01:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhA1BPQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 27 Jan 2021 20:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhA1BMu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 27 Jan 2021 20:12:50 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E34C061574;
        Wed, 27 Jan 2021 17:12:02 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id j13so2069699qvu.10;
        Wed, 27 Jan 2021 17:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JwVS1jIkqmTmlzjLEdE5nvb994PexEEiKgfRgbEq3/A=;
        b=XBYlS/VK667yrjQS8K6B8nNWzAEMRLvgUQx0YoVBy5gjTUUsxRX1g+n2hHrdx2wkP3
         95vk6TIfRU9EhKTUouSTPtoixgkci7yRIpsFw+Fi6kkY3LP1UZU9QTQExe+duPCy3XzH
         ssKvXEi6l55ysG6Or+BBhHNW7/Sv2pfJsTIsYJPZOMIY4ZSj2BwcEL8Ji4Z/xUtG9ciB
         fpkW87nfFuU1+daMmyEgr1HQ7gnT48B56KSerxXFacWnjWFsKzqZsCxKDSXRAob8UGKC
         ag4R/julJlgWpNvGfHFjfTFO4L3k7hDmxxrRqrnoYmsJPoS/zSiNdqVy2dgRlZm11eZP
         Plkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JwVS1jIkqmTmlzjLEdE5nvb994PexEEiKgfRgbEq3/A=;
        b=SOcB8lxbekkcfWt0azN09BzNx5NFTAf5KlhTSdjCyq/o5RDU9FmvLdUn6u/aNAByyS
         LUaVKDo4xpiLjMo0vgQV30czjjwNqGAkgscDUusaIuEsdkGt+8p7AmBrjCvtfbvGEhAr
         3ZT9lWHMFoPG6Ydy7aBneAc33LOGo93uNKFEvH+VAibWTMMfME8I33rlOVpp+BVBA4Lv
         nQb1K+oSKrT047fK2zGLEfU2A2JpkVS8GVoEdNEsWHiX6miIuXq24IX4SeLpaLqOQTYe
         exgNO33lQ6+yMrdF+/FWhTcm6DScTy+qN7Q1ggU7HAoZTo7Tt/ajOCZ8RhLaTl41FaLp
         V+gA==
X-Gm-Message-State: AOAM532IueqMnQGakEE3Znzw3wLxWwqIDRjxSjGMXwiPhygbPqQOI9px
        widiV8/lFWQf5FX3YF/50sQ=
X-Google-Smtp-Source: ABdhPJzatu8bQ7IQDs+SbS/1psRWuR7u6vyfcvwqZKEhKmEXnpVJbG1oOWaHFwQojWsdlaGSKLd5hg==
X-Received: by 2002:a0c:f64c:: with SMTP id s12mr13287967qvm.2.1611796321544;
        Wed, 27 Jan 2021 17:12:01 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d192sm2407532qkc.65.2021.01.27.17.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 17:12:00 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7F3D527C0054;
        Wed, 27 Jan 2021 20:11:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Jan 2021 20:11:59 -0500
X-ME-Sender: <xms:XQ8SYOcVI99cOQnqST_x-muPxMviO_RnXgbgR_r5zYQQhcMK6kTsww>
    <xme:XQ8SYIP5h1IhdgMNdTbltbfpHIlZ_lPVLFv2DWVvLNxXpW8lHCbjr3v_4DEDOUlot
    658GoiHqjvKGHQ6Ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdelgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphepudeijedrvddvtddrvddruddvieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:XQ8SYPhGNeT3MCbF1Ppyg5c6qVOikwU17M9928aFuekdU9qhn9_TiQ>
    <xmx:XQ8SYL9z9cn6dZpDcLDgmrvg1FskuxSKcLodBTacYg_XfOTm8xi7BA>
    <xmx:XQ8SYKum1xVJDRET5PVjQ2gkIZGlag1GAEo7jU8cHgg28XzLJ0mYHw>
    <xmx:Xw8SYL93WGyKV6pOiYJF3SX9DI3TOzcJIGHg80aUOLAljqe1OuYS9dxXayg>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9E14724005B;
        Wed, 27 Jan 2021 20:11:57 -0500 (EST)
Date:   Thu, 28 Jan 2021 09:11:20 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <YBIPOMdfOSw3TLa9@boqun-archlinux>
References: <20210120043144.GA7045@paulmck-ThinkPad-P72>
 <20210120043236.7254-1-paulmck@kernel.org>
 <YBDTG5HEC6OLV8OQ@boqun-archlinux>
 <20210127044024.GI2743@paulmck-ThinkPad-P72>
 <YBEQtAeqMg5AX291@boqun-archlinux>
 <20210127191831.GM2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127191831.GM2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 27, 2021 at 11:18:31AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 27, 2021 at 03:05:24PM +0800, Boqun Feng wrote:
> > On Tue, Jan 26, 2021 at 08:40:24PM -0800, Paul E. McKenney wrote:
> > > On Wed, Jan 27, 2021 at 10:42:35AM +0800, Boqun Feng wrote:
> > > > Hi Paul,
> > > > 
> > > > On Tue, Jan 19, 2021 at 08:32:33PM -0800, paulmck@kernel.org wrote:
> > > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > 
> > > > > Historically, a task that has been subjected to RCU priority boosting is
> > > > > deboosted at rcu_read_unlock() time.  However, with the advent of deferred
> > > > > quiescent states, if the outermost rcu_read_unlock() was invoked with
> > > > > either bottom halves, interrupts, or preemption disabled, the deboosting
> > > > > will be delayed for some time.  During this time, a low-priority process
> > > > > might be incorrectly running at a high real-time priority level.
> > > > > 
> > > > > Fortunately, rcu_read_unlock_special() already provides mechanisms for
> > > > > forcing a minimal deferral of quiescent states, at least for kernels
> > > > > built with CONFIG_IRQ_WORK=y.  These mechanisms are currently used
> > > > > when expedited grace periods are pending that might be blocked by the
> > > > > current task.  This commit therefore causes those mechanisms to also be
> > > > > used in cases where the current task has been or might soon be subjected
> > > > > to RCU priority boosting.  Note that this applies to all kernels built
> > > > > with CONFIG_RCU_BOOST=y, regardless of whether or not they are also
> > > > > built with CONFIG_PREEMPT_RT=y.
> > > > > 
> > > > > This approach assumes that kernels build for use with aggressive real-time
> > > > > applications are built with CONFIG_IRQ_WORK=y.  It is likely to be far
> > > > > simpler to enable CONFIG_IRQ_WORK=y than to implement a fast-deboosting
> > > > > scheme that works correctly in its absence.
> > > > > 
> > > > > While in the area, alphabetize the rcu_preempt_deferred_qs_handler()
> > > > > function's local variables.
> > > > > 
> > > > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > > Cc: Scott Wood <swood@redhat.com>
> > > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > ---
> > > > >  kernel/rcu/tree_plugin.h | 26 ++++++++++++++------------
> > > > >  1 file changed, 14 insertions(+), 12 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > > index 8b0feb2..fca31c6 100644
> > > > > --- a/kernel/rcu/tree_plugin.h
> > > > > +++ b/kernel/rcu/tree_plugin.h
> > > > > @@ -660,9 +660,9 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
> > > > >  static void rcu_read_unlock_special(struct task_struct *t)
> > > > >  {
> > > > >  	unsigned long flags;
> > > > > +	bool irqs_were_disabled;
> > > > >  	bool preempt_bh_were_disabled =
> > > > >  			!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
> > > > > -	bool irqs_were_disabled;
> > > > >  
> > > > >  	/* NMI handlers cannot block and cannot safely manipulate state. */
> > > > >  	if (in_nmi())
> > > > > @@ -671,30 +671,32 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > > > >  	local_irq_save(flags);
> > > > >  	irqs_were_disabled = irqs_disabled_flags(flags);
> > > > >  	if (preempt_bh_were_disabled || irqs_were_disabled) {
> > > > > -		bool exp;
> > > > > +		bool expboost; // Expedited GP in flight or possible boosting.
> > > > >  		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > > >  		struct rcu_node *rnp = rdp->mynode;
> > > > >  
> > > > > -		exp = (t->rcu_blocked_node &&
> > > > > -		       READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
> > > > > -		      (rdp->grpmask & READ_ONCE(rnp->expmask));
> > > > > +		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
> > > > > +			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
> > > > > +			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
> > > > > +			    t->rcu_blocked_node);
> > > > 
> > > > I take it that you check whether possible boosting is in progress via
> > > > the last expression of "||", ie:
> > > > 
> > > > 	(IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
> > > > 	t->rcu_blocked_node)
> > > > 
> > > > if so, I don't see the point of using the new "expboost" in the
> > > > raise_softirq_irqoff() branch, because if in_irq() is false, we only
> > > > raise softirq if irqs_were_disabled is false (otherwise, we may take the
> > > > risk of doing a wakeup with a pi or rq lock held, IIRC), and the
> > > > boosting part of the "expboost" above is only true if irqs_were_disabled
> > > > is true, so using expboost makes no different here.
> > > 
> > > I started out with two local variables, one for each side of the ||,
> > > but this looked nicer.
> > > 
> > > > >  		// Need to defer quiescent state until everything is enabled.
> > > > > -		if (use_softirq && (in_irq() || (exp && !irqs_were_disabled))) {
> > > > > +		if (use_softirq && (in_irq() || (expboost && !irqs_were_disabled))) {
> > > > >  			// Using softirq, safe to awaken, and either the
> > > > > -			// wakeup is free or there is an expedited GP.
> > > > > +			// wakeup is free or there is either an expedited
> > > > > +			// GP in flight or a potential need to deboost.
> > > > 
> > > > and this comment will be incorrect, we won't enter here solely because
> > > > there is a potential need to deboost.
> > > 
> > > You are quite right, given the !irqs_were_disabled.
> > > 
> > > > That said, why the boosting condition has a "irqs_were_disabled" in it?
> > > > What if a task gets boosted because of RCU boosting, and exit the RCU
> > > > read-side c.s. with irq enabled and there is no expedited GP in flight,
> > > > will the task get deboosted quickly enough?
> > > 
> > > Because if !irqs_were_disabled, there will be a local_bh_enable() or
> > > a preempt_enable(), give or take preempt_enable_no_resched(), and those
> > > will both get the scheduler involved because of the set_tsk_need_resched()
> > > and set_preempt_need_resched().  There is thus no need for the irq_work
> > > unless irqs_were_disabled.
> > 
> > But if so, shouldn't we check !preemp_bh_were_disabled instead of
> > irqs_were_disabled? I.e. there is no need for the irq_work unless
> > preemption and bottom halves are all enabled (IOW, we cannot expect the
> > task to get into scheduler soon via *_enable()).
> > 
> > Current what we are doing is if irqs_were_disabled is true (along with
> > other checks pass), we queue a irq work, but in this situation,
> > preept_bh_were_disabled might be true as well, which means there may be
> > a preempt_enable() not far away.
> 
> Except that the preempt_enable() might be executed before the
> local_irq_enable(), in which case the scheduler would not be invoked.
> 
> > Consider the following simple example, if we have a in-flight gp or
> > this task has been boosted:
> > 
> > 	preempt_disable();
> > 	local_irq_disable();
> > 	rcu_read_lock();
> > 	...
> > 	rcu_read_unlock();
> > 	// current we will queue a irq work here.
> > 	local_irq_enable();
> > 	preempt_enable();
> > 	// but we will enter scheduelr here./
> 
> And consider this variation:
> 
> 	preempt_disable();
> 	local_irq_disable();
> 	rcu_read_lock();
> 	...
> 	rcu_read_unlock();
> 	// Currently, we will queue a irq work here...
> 	preempt_enable();
> 	// ...because we cannot yet enter the scheduler.
> 	local_irq_enable();
> 	// Now we can but we won't because no irq_work has been scheduled.
> 

Fair enough!

But what stops the following from happening?

 	preempt_disable();
 	rcu_read_lock();
 	...
 	rcu_read_unlock();
 	// irq is not disabled, so no irq_work.

 	local_irq_disable();
 	preempt_enable();
 	// we cannot enter the scheduler
 	local_irq_enable();
 	// Now we can but we won't because no irq_work has been scheduled

Am I too paranoid and nobody writes code like the above? ;-)

Regards,
Boqun

> However, the expboost condition is missing one thing, namely strict
> grace periods.  It should read as follows:
> 
> 		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
> 			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
> 			   IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
> 			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
> 			    t->rcu_blocked_node);
> 
> Not that this has anything to do with RCU priority boosting, but while
> in the area...
> 
> 							Thanx, Paul
> 
> > > I am not all that worried about preempt_enable_no_resched() because
> > > it is a problem for RT even in the absence of RCU priority boosting.
> > > And the current uses appear to be in things that one would not use while
> > > running an RT workload.
> > > 
> > > > Maybe I'm missing some subtle?
> > > 
> > > Or maybe I am.  Thoughts?
> > > 
> > > 							Thanx, Paul
> > > 
> > > > Regards,
> > > > Boqun
> > > > 
> > > > >  			raise_softirq_irqoff(RCU_SOFTIRQ);
> > > > >  		} else {
> > > > >  			// Enabling BH or preempt does reschedule, so...
> > > > > -			// Also if no expediting, slow is OK.
> > > > > -			// Plus nohz_full CPUs eventually get tick enabled.
> > > > > +			// Also if no expediting and no possible deboosting,
> > > > > +			// slow is OK.  Plus nohz_full CPUs eventually get
> > > > > +			// tick enabled.
> > > > >  			set_tsk_need_resched(current);
> > > > >  			set_preempt_need_resched();
> > > > >  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> > 
> > so the irqs_were_disabled here should be !preempt_bh_were_disabled?
> > 
> > Regards,
> > Boqun
> > 
> > > > > -			    !rdp->defer_qs_iw_pending && exp && cpu_online(rdp->cpu)) {
> > > > > +			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
> > > > >  				// Get scheduler to re-evaluate and call hooks.
> > > > >  				// If !IRQ_WORK, FQS scan will eventually IPI.
> > > > > -				init_irq_work(&rdp->defer_qs_iw,
> > > > > -					      rcu_preempt_deferred_qs_handler);
> > > > > +				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
> > > > >  				rdp->defer_qs_iw_pending = true;
> > > > >  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> > > > >  			}
> > > > > -- 
> > > > > 2.9.5
> > > > > 
