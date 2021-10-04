Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48288C433EF
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 11:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D3D613AC
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 11:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhJDLhn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 Oct 2021 07:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232193AbhJDLhm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 Oct 2021 07:37:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CB14613AD;
        Mon,  4 Oct 2021 11:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633347353;
        bh=vZuX3Cyse/YHIXHO2dy354XGAEyLO3imsdxMKLGQKUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWjgczH6LnTHMF7nlz5KlcQHSXXb69dnZByrraU59EJtJsgwHIUjTpB6p/CRzXQQt
         DDx5UyJbMZAHF6xxd+y2XGPvNapU+wpVYUQlhfjMAq64akAF4xhqo2c0y+DIdn7Qi/
         EJbFwmACH3CV4YZhSjWemLU2UWjZ4txOlGZ2ZWl11H1DzhHV9FslEOvRHgBiedIUiI
         irdMKARZtgJ6+wSxdOHyxcDBoiuq1kttBTNl7aD+l1PH+bMoxfmr2oD+T8U8U/EiQD
         aFXBZDnT21Ls8EfD0GnFEjXOPDhSiV4Xc1LhitKtKuqrTYAVXV64Fqv8iYPHr28WIF
         DXea4kU2bAifA==
Date:   Mon, 4 Oct 2021 13:35:51 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 02/11] rcu/nocb: Prepare state machine for a new step
Message-ID: <20211004113551.GA271348@lothringen>
References: <20210929221012.228270-1-frederic@kernel.org>
 <20210929221012.228270-3-frederic@kernel.org>
 <87ee94myab.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee94myab.mognet@arm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 01, 2021 at 06:48:28PM +0100, Valentin Schneider wrote:
> On 30/09/21 00:10, Frederic Weisbecker wrote:
> > Currently SEGCBLIST_SOFTIRQ_ONLY is a bit of an exception among the
> > segcblist flags because it is an exclusive state that doesn't mix up
> > with the other flags. Remove it in favour of:
> >
> > _ A flag specifying that rcu_core() needs to perform callbacks execution
> >   and acceleration
> >
> > and
> >
> > _ A flag specifying we want the nocb lock to be held in any needed
> >   circumstances
> >
> > This clarifies the code and is more flexible: It allows to have a state
> > where rcu_core() runs with locking while offloading hasn't started yet.
> > This is a necessary step to prepare for triggering rcu_core() at the
> > very beginning of the de-offloading process so that rcu_core() won't
> > dismiss work while being preempted by the de-offloading process, at
> > least not without a pending subsequent rcu_core() that will quickly
> > catch up.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > Cc: Uladzislau Rezki <urezki@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> 
> One question and a comment nit below, other than that:
> 
> Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
> 
> > @@ -84,7 +84,7 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
> >  static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
> 
> It doesn't show up on the diff but there's a SEGCBLIST_SOFTIRQ_ONLY
> straggler in the comment above (the last one according to grep).

Ah thanks, I'll remove that.

> 
> >  {
> >       if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> > -	    !rcu_segcblist_test_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY))
> > +	    rcu_segcblist_test_flags(rsclp, SEGCBLIST_LOCKING))
> >               return true;
> >
> >       return false;
> 
> > @@ -1000,12 +1000,12 @@ static long rcu_nocb_rdp_deoffload(void *arg)
> >        */
> >       rcu_nocb_lock_irqsave(rdp, flags);
> >       /*
> > -	 * Theoretically we could set SEGCBLIST_SOFTIRQ_ONLY after the nocb
> > +	 * Theoretically we could clear SEGCBLIST_LOCKING after the nocb
> >        * lock is released but how about being paranoid for once?
> >        */
> > -	rcu_segcblist_set_flags(cblist, SEGCBLIST_SOFTIRQ_ONLY);
> > +	rcu_segcblist_clear_flags(cblist, SEGCBLIST_LOCKING);
> 
> Thought experiment for me; AFAICT the comment still holds: we can't offload
> until deoffload has finished, and we shouldn't be able to preempt
> rcu_core() while it holds ->nocb_lock. With that said, I'm all for
> paranoia.

Exactly :)

Thanks.
