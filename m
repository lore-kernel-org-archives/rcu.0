Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78BFC433C1
	for <rcu@archiver.kernel.org>; Mon, 22 Mar 2021 15:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C877A6199F
	for <rcu@archiver.kernel.org>; Mon, 22 Mar 2021 15:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCVPr7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Mar 2021 11:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhCVPro (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Mar 2021 11:47:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BCA36198D;
        Mon, 22 Mar 2021 15:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616428064;
        bh=1g/LClqVpf7FnoXgXc6QupXxejYIzphT5/fE3lsVOww=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=X/QpGV5F5rlDQQDsJjzJ67kCC2MfGfUmBjMPIsWRwRY/3uYiByGZyawgVXTimtiRr
         mfWOzfbReFlAVXzpq4rBcFHg8qO753+VEXVQeF6D7uEo9hJea4SMUmMU/Kiy1oYOFL
         j69v2kzwlHlojum2tTo1JhW17ArBh9FyNLevIojYQx8JwvlEerX5U32PbQydW+LveO
         ZJtjrCHQdzPsujVebTwX+3J8MPH6a171UGXHWucwkLFuoH9G8gNECA5VCvSskniYLj
         6i2N5BSgkB1AhkgqEye6qE0pq7ztrWcmg4z2+tPrdQa2P0Fc6MB+dszPAKwsiLmIck
         EYqXRfJl2zVlw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5DD5735239E6; Mon, 22 Mar 2021 08:47:44 -0700 (PDT)
Date:   Mon, 22 Mar 2021 08:47:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 2/3] rcu: Provide polling interfaces for
 Tiny RCU grace periods
Message-ID: <20210322154744.GM2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-2-paulmck@kernel.org>
 <20210321222855.GA863290@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321222855.GA863290@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Mar 21, 2021 at 11:28:55PM +0100, Frederic Weisbecker wrote:
> On Wed, Mar 03, 2021 at 04:26:31PM -0800, paulmck@kernel.org wrote:
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
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  include/linux/rcutiny.h | 11 ++++++-----
> >  kernel/rcu/tiny.c       | 40 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 46 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > index 2a97334..69108cf4 100644
> > --- a/include/linux/rcutiny.h
> > +++ b/include/linux/rcutiny.h
> > @@ -17,14 +17,15 @@
> >  /* Never flag non-existent other CPUs! */
> >  static inline bool rcu_eqs_special_set(int cpu) { return false; }
> >  
> > -static inline unsigned long get_state_synchronize_rcu(void)
> > -{
> > -	return 0;
> > -}
> > +unsigned long get_state_synchronize_rcu(void);
> > +unsigned long start_poll_synchronize_rcu(void);
> > +bool poll_state_synchronize_rcu(unsigned long oldstate);
> >  
> >  static inline void cond_synchronize_rcu(unsigned long oldstate)
> >  {
> > -	might_sleep();
> > +	if (poll_state_synchronize_rcu(oldstate))
> > +		return;
> > +	synchronize_rcu();
> 
> Perhaps cond_synchronize_rcu() could stay as it was. If it might
> call synchronize_rcu() then it inherits its constraint to be
> called from a quiescent state.

As in leave the might_sleep()?  How about something like this?

static inline void cond_synchronize_rcu(unsigned long oldstate)
{
	if (!poll_state_synchronize_rcu(oldstate))
		synchronize_rcu();
	else
		might_sleep();
}

One advantage of this is that the Tiny and Tree implementations
become identical and can then be consolidated.

Or did I miss your point?

						Thanx, Paul
