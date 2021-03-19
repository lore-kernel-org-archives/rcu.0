Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8598EC433C1
	for <rcu@archiver.kernel.org>; Fri, 19 Mar 2021 23:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1676192E
	for <rcu@archiver.kernel.org>; Fri, 19 Mar 2021 23:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCSXiv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Mar 2021 19:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhCSXit (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Mar 2021 19:38:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E81726192E;
        Fri, 19 Mar 2021 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616197129;
        bh=eVtrR96RBIQgK8dnIrYylJM2O3USKklA8KIdCQWqPY0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UjlRD+rkO61jVyuLaowJlbF/4Fa3zTBeGGhyYGXdZ0GDx2P1vy+NggpQ92B2V9bS7
         dwTkK38U/HsX9XQrqywFdZMlzL5yzEwcew5bYYZ/IWPIdvIAHLnCuz3SIIYK0htIn/
         DfYuylMzoSRNEzN1jRbjhZDYIx+p44Saa/wswuLvSfwVPtHzDn1MxfCppUc9k63Hw3
         4T3cR71XTMp0rk1umy8PtFbFSYwwR8MqVwJUPFhY1ab8wFmUYB3VrEZPX0X7WrPwMc
         vHU6M60efPCha1cQgTaz151gjEYzoG7La+EmaEtMBbYVez0V6uJKkpbYrdHDa+8Vpw
         eJze9gNr4HExQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AB30535239E5; Fri, 19 Mar 2021 16:38:48 -0700 (PDT)
Date:   Fri, 19 Mar 2021 16:38:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu: Provide polling interfaces for
 Tree RCU grace periods
Message-ID: <20210319233848.GV2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-1-paulmck@kernel.org>
 <20210319135854.GA814853@lothringen>
 <20210319175116.GO2696@paulmck-ThinkPad-P72>
 <20210319221040.GC814853@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319221040.GC814853@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 19, 2021 at 11:10:40PM +0100, Frederic Weisbecker wrote:
> On Fri, Mar 19, 2021 at 10:51:16AM -0700, Paul E. McKenney wrote:
> > On Fri, Mar 19, 2021 at 02:58:54PM +0100, Frederic Weisbecker wrote:
> > > It's all a matter of personal taste but if I may suggest some namespace
> > > modifications:
> > > 
> > > get_state_synchronize_rcu() -> synchronize_rcu_poll_start_raw()
> > > start_poll_synchronize_rcu() -> synchronize_rcu_poll_start()
> > > poll_state_synchronize_rcu() -> synchronize_rcu_poll()
> > > cond_synchronize_rcu() -> synchronize_rcu_cond()
> > > 
> > > But it's up to you really.
> > 
> > I am concerned about starting anything "synchronize_rcu" if that
> > thing doesn't unconditionally wait for a grace period.  "What do
> > you mean that there was no grace period?  Don't you see that call to
> > synchronize_rcu_poll_start_raw()???"
> 
> I see, that could indeed be confusing.
> 
> > This objection doesn't apply to cond_synchronize_rcu(), but it is
> > already in use, so any name change should be worked with the users.
> > All two of them.  ;-)
> 
> Probably not worth it. We have cond_resched() as a schedule() counterpart
> for a reference after all.

Good point!

> > > >  /**
> > > > + * start_poll_state_synchronize_rcu - Snapshot and start RCU grace period
> > > > + *
> > > > + * Returns a cookie that is used by a later call to cond_synchronize_rcu()
> > > 
> > > It may be worth noting that calling start_poll_synchronize_rcu() and then
> > > pass the cookie to cond_synchronize_rcu() soon after may end up waiting for
> > > one more grace period.
> > 
> > You mean this sequence of events?
> > 
> > 1.	cookie = start_poll_synchronize_rcu()
> > 
> > 2.	The grace period corresponding to cookie is almost over...
> > 
> > 3.	cond_synchronize_rcu() checks the cookie and sees that the
> > 	grace period has not yet expired.
> > 
> > 4.	The grace period corresponding to cookie completes.
> > 
> > 5.	Someone else starts a grace period.
> > 
> > 6.	cond_synchronize_rcu() invokes synchronize_rcu(), which waits
> > 	for the just-started grace period plus another grace period.
> > 	Thus, there has been no fewer than three full grace periods
> > 	between the call to start_poll_synchronize_rcu() and the
> > 	return from cond_synchronize_rcu().
> > 
> > Yes, this can happen!  And it can be worse, for example, it is quite
> > possible that cond_synchronize_rcu() would be preempted for multiple
> > grace periods at step 5, in which case it would still wait for almost
> > two additional grace periods.
> > 
> > Or are you thinking of something else?
> 
> I didn't even think that far.
> My scenario was:
> 
> 1.	cookie = start_poll_synchronize_rcu()
>  
>  
> 2.	cond_synchronize_rcu() checks the cookie and sees that the
> 	grace period has not yet expired. So it calls synchronize_rcu()
> 	which queues a callback.
> 
> 3.	The grace period for the cookie eventually completes.
> 
> 4.	The callback queued in 2. gets assigned a new grace period number.
> 	That new grace period starts.
> 
> 5.	The new grace period completes and synchronize_rcu() returns.
> 
> 
> But I think this is due to some deep misunderstanding from my end.

You mean like this?

	oldstate = start_poll_synchronize_rcu();
	// Why wait?  Beat the rush!!!
	cond_synchronize_rcu(oldstate);

This would be a bit silly (why not just call synchronize_rcu()?),
and yes, this would unconditionally get you an extra RCU grace period.
Then again, any call to cond_synchronize_rcu() before the desired grace
period has expired will get you an extra grace period, and maybe more.

So a given use case either needs to not care about the added latency
or have a high probability of invoking cond_synchronize_rcu() after
the desired grace period has expired.

> > > > + * If a full RCU grace period has elapsed since the earlier call from
> > > > + * which oldstate was obtained, return @true, otherwise return @false.
> > > > + * Otherwise, invoke synchronize_rcu() to wait for a full grace period.
> > > 
> > > Rephrase suggestion for the last sentence:
> > > 
> > > "In case of failure, it's up to the caller to try polling again later or
> > > invoke synchronize_rcu() to wait for a new full grace period to complete."
> > 
> > How about like this?
> > 
> > /**
> >  * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
> >  *
> >  * @oldstate: return from call to get_state_synchronize_rcu() or start_poll_synchronize_rcu()
> >  *
> >  * If a full RCU grace period has elapsed since the earlier call from
> >  * which oldstate was obtained, return @true, otherwise return @false.
> >  * If @false is returned, it is the caller's responsibilty to invoke this
> >  * function later on until it does return @true.  Alternatively, the caller
> >  * can explicitly wait for a grace period, for example, by passing @oldstate
> >  * to cond_synchronize_rcu() or by directly invoking synchronize_rcu().
> 
> Yes very nice!

You got it!

							Thanx, Paul
