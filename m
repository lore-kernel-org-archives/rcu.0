Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B82C433FE
	for <rcu@archiver.kernel.org>; Thu, 14 Oct 2021 11:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FB5C60F23
	for <rcu@archiver.kernel.org>; Thu, 14 Oct 2021 11:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhJNLKA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Oct 2021 07:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbhJNLJ4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Oct 2021 07:09:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E63D860F9E;
        Thu, 14 Oct 2021 11:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634209671;
        bh=mSOT5SaXvV5vgntRVKQZFS4W4Npe93HR4Dh/GaBD5zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHTyHKG+7hfmFs6Cs6smumVmFr3nWIHT7mWvJvNgy5WuN/KSI7+oMiEcnUDIVhptf
         m5NH/aaM1/mw5PHUoZmzCcjzHu4kD/9pK9VCCVH7c4XnI2rqLWjlkJ5z6RW8nRkFyw
         dwQbPFpdbLSCVkASgl6cgm1jlnDq5B+KzrQjA9HqdejEIl04JawH3av/i4ULAMrrve
         lSsM1SLi2znKe6GIX3zr9Hb4L+m2UG+VysVsgBL6NqrE6zZ+jJbVXXJWkAYgtSJmfp
         uzdZ6AvBACfxYOrjYDpSTEsyryjNKQ0PpuyElW8Nh0rPV24xksDyaZDkZ4upi6hT+I
         YIxuDyzCO6Yug==
Date:   Thu, 14 Oct 2021 13:07:48 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 03/11] rcu/nocb: Invoke rcu_core() at the start of
 deoffloading
Message-ID: <20211014110748.GB406368@lothringen>
References: <20211011145140.359412-1-frederic@kernel.org>
 <20211011145140.359412-4-frederic@kernel.org>
 <YWcEXj2+nqO8kIFS@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWcEXj2+nqO8kIFS@boqun-archlinux>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Boqun,

On Thu, Oct 14, 2021 at 12:07:58AM +0800, Boqun Feng wrote:
> If offloading races with rcu_core(), can the following happen?
> 
> 	<offload work>				
> 	rcu_nocb_rdp_offload():
> 	    					rcu_core():
> 						  ...
> 						  rcu_nocb_lock_irqsave(); // no a lock
> 	  raw_spin_lock_irqsave(->nocb_lock);
> 	    rdp_offload_toggle():
> 	      <LOCKING | OFFLOADED set>
> 	      					  if (!rcu_segcblist_restempty(...))
> 						    rcu_accelerate_cbs_unlocked(...);
> 						  rcu_nocb_unlock_irqrestore();
> 						  // ^ a real unlock,
> 						  // and will preempt_enable()
> 	    // offload continue with ->nocb_lock not held
> 
> If this can happen, it means an unpaired preempt_enable() and an
> incorrect unlock. Thoughts? Maybe I'm missing something here?

Since we are unconditionally disabling IRQs on rcu_nocb_lock_irqsave(), we can't
be preempted by rcu_nocb_rdp_offload() until rcu_nocb_unlock_irqrestore() has
completed. And both have to run on the rdp target CPU. So this shouldn't happen.

Thanks.



> 
> Regards,
> Boqun
> 
> > +	 *
> > +	 * _ Deoffloading: In the worst case we miss callbacks acceleration or
> > +	 *                 processing. This is fine because the early stage
> > +	 *                 of deoffloading invokes rcu_core() after setting
> > +	 *                 SEGCBLIST_RCU_CORE. So we guarantee that we'll process
> > +	 *                 what could have been dismissed without the need to wait
> > +	 *                 for the next rcu_pending() check in the next jiffy.
> > +	 */
> >  	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
> >  
> >  	if (cpu_is_offline(smp_processor_id()))
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 71a28f50b40f..3b470113ae38 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -990,6 +990,15 @@ static long rcu_nocb_rdp_deoffload(void *arg)
> >  	 * will refuse to put anything into the bypass.
> >  	 */
> >  	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> > +	/*
> > +	 * Start with invoking rcu_core() early. This way if the current thread
> > +	 * happens to preempt an ongoing call to rcu_core() in the middle,
> > +	 * leaving some work dismissed because rcu_core() still thinks the rdp is
> > +	 * completely offloaded, we are guaranteed a nearby future instance of
> > +	 * rcu_core() to catch up.
> > +	 */
> > +	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
> > +	invoke_rcu_core();
> >  	ret = rdp_offload_toggle(rdp, false, flags);
> >  	swait_event_exclusive(rdp->nocb_state_wq,
> >  			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
> > -- 
> > 2.25.1
> > 
