Return-Path: <SRS0=W0OP=4H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E31C34022
	for <rcu@archiver.kernel.org>; Wed, 19 Feb 2020 03:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526B324656
	for <rcu@archiver.kernel.org>; Wed, 19 Feb 2020 03:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582084762;
	bh=UlD/GgrIoO+98ilCRhTMm11ZU9cYeUcU+NIKuiRdwPM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=UOM+WMn7w8pyWWAnMjqA0gnN2k4SoicXb8M0+xnsmBMHEiYhHxoJVmdkxnIGUfice
	 RLjB9dGc1syxzW7+lzJyi7TPS52yqjqrjqKSgybuzkBJpT2/MSZYfPFYO+qc+qw6in
	 jLL6XlS2FRS5vRoX2m+7WWdhwFL8mxRPdr2dqGCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBSD7W (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:59:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgBSD7W (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 22:59:22 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BDAD208E4;
        Wed, 19 Feb 2020 03:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582084761;
        bh=UlD/GgrIoO+98ilCRhTMm11ZU9cYeUcU+NIKuiRdwPM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UsgF5iz6/VZmX54+QmHA84ui3KIJdH/0oIaBJC6mlm9ljdykZx8mZcnyvhN9ZjoqI
         Jo3bo9dnj2K9gB/b2J6ZWZ1JqPyRd7uVrN1IT6bgKFVWYPPZ226X3ypA3/vdDRXtBE
         FOdUbeVrx/mABL9FuPe4aFjosHkBdRZ3XcX8HRs4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F21AF3520C69; Tue, 18 Feb 2020 19:59:20 -0800 (PST)
Date:   Tue, 18 Feb 2020 19:59:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH V2 1/7] rcu: use preempt_count to test whether scheduler
 locks is held
Message-ID: <20200219035920.GR2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-2-laijs@linux.alibaba.com>
 <20200219033147.GA103554@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219033147.GA103554@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 18, 2020 at 10:31:47PM -0500, Joel Fernandes wrote:
> On Sat, Nov 02, 2019 at 12:45:53PM +0000, Lai Jiangshan wrote:
> > Ever since preemption was introduced to linux kernel,
> > irq disabled spinlocks are always held with preemption
> > disabled. One of the reason is that sometimes we need
> > to use spin_unlock() which will do preempt_enable()
> > to unlock the irq disabled spinlock with keeping irq
> > disabled. So preempt_count can be used to test whether
> > scheduler locks is possible held.
> > 
> > CC: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > ---
> >  kernel/rcu/tree_plugin.h | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 0982e9886103..aba5896d67e3 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -603,10 +603,14 @@ static void rcu_read_unlock_special(struct task_struct *t)
> >  		      tick_nohz_full_cpu(rdp->cpu);
> >  		// Need to defer quiescent state until everything is enabled.
> >  		if (irqs_were_disabled && use_softirq &&
> > -		    (in_interrupt() ||
> > -		     (exp && !t->rcu_read_unlock_special.b.deferred_qs))) {
> > +		    (in_interrupt() || (exp && !preempt_bh_were_disabled))) {
> >  			// Using softirq, safe to awaken, and we get
> >  			// no help from enabling irqs, unlike bh/preempt.
> > +			// in_interrupt(): raise_softirq_irqoff() is
> > +			// guaranteed not to not do wakeup
> > +			// !preempt_bh_were_disabled: scheduler locks cannot
> > +			// be held, since spinlocks are always held with
> > +			// preempt_disable(), so the wakeup will be safe.
> 
> This means if preemption is disabled for any reason (other than scheduler
> locks), such as acquiring an unrelated lock that is not held by the
> scheduler, then the softirq would not be raised even if it was safe to
> do so. From that respect, it seems a step back no?

This patch was one of the things motivating me to turn tick on for
nohz_full CPUs that spend too long in the kernel.  Given that change,
this patch can be (and recently was) made more straightforward.  Prior to
the nohz_full change, Lai was kind of between a rock and a hard place
on this one.  ;-)

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> >  			raise_softirq_irqoff(RCU_SOFTIRQ);
> >  		} else {
> >  			// Enabling BH or preempt does reschedule, so...
> > -- 
> > 2.20.1
> > 
