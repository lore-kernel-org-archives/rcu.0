Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5568BC433DB
	for <rcu@archiver.kernel.org>; Mon, 22 Mar 2021 19:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B4161994
	for <rcu@archiver.kernel.org>; Mon, 22 Mar 2021 19:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhCVTBD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Mar 2021 15:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232343AbhCVTAi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Mar 2021 15:00:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5410061992;
        Mon, 22 Mar 2021 19:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616439637;
        bh=m5Q2fV13IhNOqiQoivgPYaEpk//90PRFUmdnX366uXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q2ask9leB4b+WKlZRCe1t9M/ui9JjzRl/l06vwEZzKmPdBGryjdQimhPGN2qvwWaT
         uAfjHEcVjAffun1z5bY7SfH7/Be7Odw9+pRRMxNFsZkNk+pZUomU71J2dbk2b5zOUe
         NnfzUQrKQ1X2R0/LE81u6cUKYnZNBthT0FGJwU4L7RPsnpswhIyN7gL1k1qwJPpbK+
         D9Fn9CyGiklwVZ/oRuaAKNljswwjwDEf1XpMHWJyWRAq5RltvVTDIRFvwcIn+EAkTB
         8WLjZBynDhF54h2MiBS+d85iGMZXMcMu+Z7oF3jgc4wzqbEGfqvNqw9KT35w+5SMf9
         NTa+wSxXeqV4w==
Date:   Mon, 22 Mar 2021 20:00:35 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 2/3] rcu: Provide polling interfaces for
 Tiny RCU grace periods
Message-ID: <20210322190035.GA874833@lothringen>
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-2-paulmck@kernel.org>
 <20210321222855.GA863290@lothringen>
 <20210322154744.GM2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322154744.GM2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 22, 2021 at 08:47:44AM -0700, Paul E. McKenney wrote:
> On Sun, Mar 21, 2021 at 11:28:55PM +0100, Frederic Weisbecker wrote:
> > On Wed, Mar 03, 2021 at 04:26:31PM -0800, paulmck@kernel.org wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > There is a need for a non-blocking polling interface for RCU grace
> > > periods, so this commit supplies start_poll_synchronize_rcu() and
> > > poll_state_synchronize_rcu() for this purpose.  Note that the existing
> > > get_state_synchronize_rcu() may be used if future grace periods are
> > > inevitable (perhaps due to a later call_rcu() invocation).  The new
> > > start_poll_synchronize_rcu() is to be used if future grace periods
> > > might not otherwise happen.  Finally, poll_state_synchronize_rcu()
> > > provides a lockless check for a grace period having elapsed since
> > > the corresponding call to either of the get_state_synchronize_rcu()
> > > or start_poll_synchronize_rcu().
> > > 
> > > As with get_state_synchronize_rcu(), the return value from either
> > > get_state_synchronize_rcu() or start_poll_synchronize_rcu() is passed in
> > > to a later call to either poll_state_synchronize_rcu() or the existing
> > > (might_sleep) cond_synchronize_rcu().
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  include/linux/rcutiny.h | 11 ++++++-----
> > >  kernel/rcu/tiny.c       | 40 ++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 46 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > > index 2a97334..69108cf4 100644
> > > --- a/include/linux/rcutiny.h
> > > +++ b/include/linux/rcutiny.h
> > > @@ -17,14 +17,15 @@
> > >  /* Never flag non-existent other CPUs! */
> > >  static inline bool rcu_eqs_special_set(int cpu) { return false; }
> > >  
> > > -static inline unsigned long get_state_synchronize_rcu(void)
> > > -{
> > > -	return 0;
> > > -}
> > > +unsigned long get_state_synchronize_rcu(void);
> > > +unsigned long start_poll_synchronize_rcu(void);
> > > +bool poll_state_synchronize_rcu(unsigned long oldstate);
> > >  
> > >  static inline void cond_synchronize_rcu(unsigned long oldstate)
> > >  {
> > > -	might_sleep();
> > > +	if (poll_state_synchronize_rcu(oldstate))
> > > +		return;
> > > +	synchronize_rcu();
> > 
> > Perhaps cond_synchronize_rcu() could stay as it was. If it might
> > call synchronize_rcu() then it inherits its constraint to be
> > called from a quiescent state.
> 
> As in leave the might_sleep()?  How about something like this?
> 
> static inline void cond_synchronize_rcu(unsigned long oldstate)
> {
> 	if (!poll_state_synchronize_rcu(oldstate))
> 		synchronize_rcu();
> 	else
> 		might_sleep();
> }
> 
> One advantage of this is that the Tiny and Tree implementations
> become identical and can then be consolidated.
> 
> Or did I miss your point?

But poll_state_synchronize_rcu() checks that the gp_num has changed,
which is not needed for cond_synchronize_rcu() since this it is
only allowed to be called from a QS.

> 
> 						Thanx, Paul
