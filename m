Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E38C433DB
	for <rcu@archiver.kernel.org>; Fri, 19 Mar 2021 17:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619B461984
	for <rcu@archiver.kernel.org>; Fri, 19 Mar 2021 17:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhCSRvj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Mar 2021 13:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhCSRvR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Mar 2021 13:51:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EF726197F;
        Fri, 19 Mar 2021 17:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616176277;
        bh=WRl0GRgoU/1zwIbJose+MNySiCwfqa2ZEYJ2UZJ9lhg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PPd3xjmb2hLaYSX3Tzb5J7LKVs7vIvo484Zl0hIdQEuTTecjnpuUQUxPWn7+pYpH1
         szSbpARh5h3rLwiW6kVEO8nOG1RIGABE+7Jxo28To1U0lJl/8xEXI6tP7V/0L87V2b
         h4tog0qqbQedrsIL7BSAmi4p+EAw9dMhX0ykfBa6t6VhJTtC0zEGgUAWGiPCcHE1SH
         ShJVlXvVOBtx2p0SETDwfXM791lBAChbgkBqgU549vGnmoZsO1xn6B2svMFZKhD2Nq
         ReubcAAZednbl3hW68OSER9NNHM+0ZMZQuz4jBy3TKx/nKwmONeQHUb1jhpLIsC20r
         34QC1ymUp0zYw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C773535239E5; Fri, 19 Mar 2021 10:51:16 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:51:16 -0700
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
Message-ID: <20210319175116.GO2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-1-paulmck@kernel.org>
 <20210319135854.GA814853@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319135854.GA814853@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 19, 2021 at 02:58:54PM +0100, Frederic Weisbecker wrote:
> On Wed, Mar 03, 2021 at 04:26:30PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > There is a need for a non-blocking polling interface for RCU grace
> > periods, so this commit supplies start_poll_synchronize_rcu() and
> > poll_state_synchronize_rcu() for this purpose.  Note that the existing
> > get_state_synchronize_rcu() may be used if future grace periods are
> > inevitable (perhaps due to a later call_rcu() invocation).  The new
> > start_poll_synchronize_rcu() is to be used if future grace periods
> > might not otherwise happen.  Finally, poll_state_synchronize_rcu()
> > provides a lockless check for a grace period having elapsed since
> > the corresponding call to either of the get_state_synchronize_rcu()
> > or start_poll_synchronize_rcu().
> > 
> > As with get_state_synchronize_rcu(), the return value from either
> > get_state_synchronize_rcu() or start_poll_synchronize_rcu() is passed in
> > to a later call to either poll_state_synchronize_rcu() or the existing
> > (might_sleep) cond_synchronize_rcu().
> 
> It's all a matter of personal taste but if I may suggest some namespace
> modifications:
> 
> get_state_synchronize_rcu() -> synchronize_rcu_poll_start_raw()
> start_poll_synchronize_rcu() -> synchronize_rcu_poll_start()
> poll_state_synchronize_rcu() -> synchronize_rcu_poll()
> cond_synchronize_rcu() -> synchronize_rcu_cond()
> 
> But it's up to you really.

I am concerned about starting anything "synchronize_rcu" if that
thing doesn't unconditionally wait for a grace period.  "What do
you mean that there was no grace period?  Don't you see that call to
synchronize_rcu_poll_start_raw()???"

This objection doesn't apply to cond_synchronize_rcu(), but it is
already in use, so any name change should be worked with the users.
All two of them.  ;-)

> >  /**
> > + * start_poll_state_synchronize_rcu - Snapshot and start RCU grace period
> > + *
> > + * Returns a cookie that is used by a later call to cond_synchronize_rcu()
> 
> It may be worth noting that calling start_poll_synchronize_rcu() and then
> pass the cookie to cond_synchronize_rcu() soon after may end up waiting for
> one more grace period.

You mean this sequence of events?

1.	cookie = start_poll_synchronize_rcu()

2.	The grace period corresponding to cookie is almost over...

3.	cond_synchronize_rcu() checks the cookie and sees that the
	grace period has not yet expired.

4.	The grace period corresponding to cookie completes.

5.	Someone else starts a grace period.

6.	cond_synchronize_rcu() invokes synchronize_rcu(), which waits
	for the just-started grace period plus another grace period.
	Thus, there has been no fewer than three full grace periods
	between the call to start_poll_synchronize_rcu() and the
	return from cond_synchronize_rcu().

Yes, this can happen!  And it can be worse, for example, it is quite
possible that cond_synchronize_rcu() would be preempted for multiple
grace periods at step 5, in which case it would still wait for almost
two additional grace periods.

Or are you thinking of something else?

> > + * or poll_state_synchronize_rcu() to determine whether or not a full
> > + * grace period has elapsed in the meantime.  If the needed grace period
> > + * is not already slated to start, notifies RCU core of the need for that
> > + * grace period.
> > + *
> > + * Interrupts must be enabled for the case where it is necessary to awaken
> > + * the grace-period kthread.
> > + */
> > +unsigned long start_poll_synchronize_rcu(void)
> > +{
> > +	unsigned long flags;
> > +	unsigned long gp_seq = get_state_synchronize_rcu();
> > +	bool needwake;
> > +	struct rcu_data *rdp;
> > +	struct rcu_node *rnp;
> [...]
> > +
> > +/**
> > + * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
> > + *
> > + * @oldstate: return from call to get_state_synchronize_rcu() or start_poll_synchronize_rcu()
> > + *
> > + * If a full RCU grace period has elapsed since the earlier call from
> > + * which oldstate was obtained, return @true, otherwise return @false.
> > + * Otherwise, invoke synchronize_rcu() to wait for a full grace period.
> 
> Rephrase suggestion for the last sentence:
> 
> "In case of failure, it's up to the caller to try polling again later or
> invoke synchronize_rcu() to wait for a new full grace period to complete."

How about like this?

/**
 * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
 *
 * @oldstate: return from call to get_state_synchronize_rcu() or start_poll_synchronize_rcu()
 *
 * If a full RCU grace period has elapsed since the earlier call from
 * which oldstate was obtained, return @true, otherwise return @false.
 * If @false is returned, it is the caller's responsibilty to invoke this
 * function later on until it does return @true.  Alternatively, the caller
 * can explicitly wait for a grace period, for example, by passing @oldstate
 * to cond_synchronize_rcu() or by directly invoking synchronize_rcu().
 *
 * Yes, this function does not take counter wrap into account.
 * But counter wrap is harmless.  If the counter wraps, we have waited for
 * more than 2 billion grace periods (and way more on a 64-bit system!).
 * Those needing to keep oldstate values for very long time periods
 * (many hours even on 32-bit systems) should check them occasionally
 * and either refresh them or set a flag indicating that the grace period
 * has completed.
 */

> In any case: Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thank you, I will apply it at the next rebase.

							Thanx, Paul
