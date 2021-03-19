Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209F1C433DB
	for <rcu@archiver.kernel.org>; Fri, 19 Mar 2021 22:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F696197E
	for <rcu@archiver.kernel.org>; Fri, 19 Mar 2021 22:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhCSWLJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhCSWKn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Mar 2021 18:10:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EDC061979;
        Fri, 19 Mar 2021 22:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616191843;
        bh=9dG8aL3BrKWbFS+Lqoql6t6iTEwSbP1Iz6LMq7AC1R0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jeoy602ofP6YvVVzI5eZImUy7ztEa/wuHa7l81NYDYPvXqNi4R3ALCVMu2Iayw38c
         3DXh7b1CYR3Hmg4MkRrXwNoxSINNzXNA5PQ8oAV21/q/X8/+wSSv0UK7fxFxZqlmwX
         nT6yOspGUmC1btzkJ/U78YYYfEXQzVv8pt0yZYWicd/InqwxCjEjT4T2KuZ9GhzADU
         4HFqAtPssCaGZYkG6b9gHE05erUw9BR9W1S4fC2jjqH0C3EdRWsBvIhN6InRHPEohF
         1P/tBvUH8PPTx7WPnrpXJTkndb8bhs0vWKhGIkvj6V/GK65mw7uXaODXKt0JelUQsL
         4DowOYIAJh5sA==
Date:   Fri, 19 Mar 2021 23:10:40 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu: Provide polling interfaces for
 Tree RCU grace periods
Message-ID: <20210319221040.GC814853@lothringen>
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-1-paulmck@kernel.org>
 <20210319135854.GA814853@lothringen>
 <20210319175116.GO2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319175116.GO2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 19, 2021 at 10:51:16AM -0700, Paul E. McKenney wrote:
> On Fri, Mar 19, 2021 at 02:58:54PM +0100, Frederic Weisbecker wrote:
> > It's all a matter of personal taste but if I may suggest some namespace
> > modifications:
> > 
> > get_state_synchronize_rcu() -> synchronize_rcu_poll_start_raw()
> > start_poll_synchronize_rcu() -> synchronize_rcu_poll_start()
> > poll_state_synchronize_rcu() -> synchronize_rcu_poll()
> > cond_synchronize_rcu() -> synchronize_rcu_cond()
> > 
> > But it's up to you really.
> 
> I am concerned about starting anything "synchronize_rcu" if that
> thing doesn't unconditionally wait for a grace period.  "What do
> you mean that there was no grace period?  Don't you see that call to
> synchronize_rcu_poll_start_raw()???"

I see, that could indeed be confusing.

> 
> This objection doesn't apply to cond_synchronize_rcu(), but it is
> already in use, so any name change should be worked with the users.
> All two of them.  ;-)

Probably not worth it. We have cond_resched() as a schedule() counterpart
for a reference after all.

> > >  /**
> > > + * start_poll_state_synchronize_rcu - Snapshot and start RCU grace period
> > > + *
> > > + * Returns a cookie that is used by a later call to cond_synchronize_rcu()
> > 
> > It may be worth noting that calling start_poll_synchronize_rcu() and then
> > pass the cookie to cond_synchronize_rcu() soon after may end up waiting for
> > one more grace period.
> 
> You mean this sequence of events?
> 
> 1.	cookie = start_poll_synchronize_rcu()
> 
> 2.	The grace period corresponding to cookie is almost over...
> 
> 3.	cond_synchronize_rcu() checks the cookie and sees that the
> 	grace period has not yet expired.
> 
> 4.	The grace period corresponding to cookie completes.
> 
> 5.	Someone else starts a grace period.
> 
> 6.	cond_synchronize_rcu() invokes synchronize_rcu(), which waits
> 	for the just-started grace period plus another grace period.
> 	Thus, there has been no fewer than three full grace periods
> 	between the call to start_poll_synchronize_rcu() and the
> 	return from cond_synchronize_rcu().
> 
> Yes, this can happen!  And it can be worse, for example, it is quite
> possible that cond_synchronize_rcu() would be preempted for multiple
> grace periods at step 5, in which case it would still wait for almost
> two additional grace periods.
> 
> Or are you thinking of something else?

I didn't even think that far.
My scenario was:

1.	cookie = start_poll_synchronize_rcu()
 
 
2.	cond_synchronize_rcu() checks the cookie and sees that the
	grace period has not yet expired. So it calls synchronize_rcu()
	which queues a callback.

3.	The grace period for the cookie eventually completes.

4.	The callback queued in 2. gets assigned a new grace period number.
	That new grace period starts.

5.	The new grace period completes and synchronize_rcu() returns.


But I think this is due to some deep misunderstanding from my end.


> > > + * If a full RCU grace period has elapsed since the earlier call from
> > > + * which oldstate was obtained, return @true, otherwise return @false.
> > > + * Otherwise, invoke synchronize_rcu() to wait for a full grace period.
> > 
> > Rephrase suggestion for the last sentence:
> > 
> > "In case of failure, it's up to the caller to try polling again later or
> > invoke synchronize_rcu() to wait for a new full grace period to complete."
> 
> How about like this?
> 
> /**
>  * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
>  *
>  * @oldstate: return from call to get_state_synchronize_rcu() or start_poll_synchronize_rcu()
>  *
>  * If a full RCU grace period has elapsed since the earlier call from
>  * which oldstate was obtained, return @true, otherwise return @false.
>  * If @false is returned, it is the caller's responsibilty to invoke this
>  * function later on until it does return @true.  Alternatively, the caller
>  * can explicitly wait for a grace period, for example, by passing @oldstate
>  * to cond_synchronize_rcu() or by directly invoking synchronize_rcu().

Yes very nice!

Thanks!
