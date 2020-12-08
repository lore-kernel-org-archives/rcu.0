Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD5AC4361B
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 18:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8725323B46
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 18:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgLHSYv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 13:24:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730424AbgLHSYv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 13:24:51 -0500
Date:   Tue, 8 Dec 2020 10:24:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607451850;
        bh=KkXJZf6suN8ZSAFkTq+0D7NxW5P4HswxVh8yAgzaLEY=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uuy90LTvbsX4ESDngPRdEZXvJeP0EU94kktMByziFDYKHrhtUQxMYZO8iL6gWw0fQ
         fyOxjcWuY2D6pbFcdTQTjPdg6YVLc7QXyag/SL6QDiqZpi/B6/5Fl0uddw0ZwqPC0t
         wqkLa0YSmtxDTv6pO4dXO1tfAcIJrLGSbBISxRekkuOi57XkxUEjQMEBg+VL9PD8LQ
         jH1cZ1z0aGmF/5jHO2zESnYizBkHOKvBFF8u/H3+nu5GR350JrFg7P+U41Ru4wYQXT
         dErOKGruUsZSdeOKBZlmk89YuHTh4zgXH5EypE0sA0ejsAozqU1Uy4vk8EnlZ6h3EO
         cW09+O9FaPUiQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     boqun.feng@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: One potential issue with concurrent execution of RCU callbacks...
Message-ID: <20201208182409.GT2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201208145810.GA4875@paulmck-ThinkPad-P72>
 <20201208155457.GA3916@lothringen>
 <20201208171927.GS2657@paulmck-ThinkPad-P72>
 <20201208175230.GB3916@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208175230.GB3916@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 08, 2020 at 06:52:30PM +0100, Frederic Weisbecker wrote:
> On Tue, Dec 08, 2020 at 09:19:27AM -0800, Paul E. McKenney wrote:
> > On Tue, Dec 08, 2020 at 04:54:57PM +0100, Frederic Weisbecker wrote:
> > > On Tue, Dec 08, 2020 at 06:58:10AM -0800, Paul E. McKenney wrote:
> > > > Hello, Frederic,
> > > > 
> > > > Boqun just asked if RCU callbacks ran in BH-disabled context to avoid
> > > > concurrent execution of the same callback.  Of course, this raises the
> > > > question of whether a self-posting callback can have two instances of
> > > > itself running concurrently while a CPU is in the process of transitioning
> > > > between softirq and rcuo invocation of callbacks.
> > > > 
> > > > I believe that the answer is "no" because BH-disabled context is
> > > > an implicit RCU read-side critical section.  Therefore, the initial
> > > > invocation of the RCU callback must complete in order for a new grace
> > > > period to complete, and a new grace period must complete before the
> > > > second invocation of that same callback to start.
> > > > 
> > > > Does that make sense, or am I missing something?
> > > 
> > > Sounds like a good explanation. But then why are we actually calling
> > > the entire rcu_do_batch() under BH-disabled context? Was it to quieten
> > > lockdep against rcu_callback_map ?
> > 
> > Inertia and lack of complaints about it.  ;-)
> > 
> > Plus when called from softirq, neither local_bh_disable() nor
> > rcu_read_lock() is necessary, and so represents pointless overhead.
> > 
> > > Wouldn't rcu_read_lock() around callbacks invocation be enough? Or is
> > > there another reason for the BH-disabled context that I'm missing?
> > 
> > There are likely to be callback functions that use spin_lock() instead
> > of spin_lock_bh() because they know that they are invoked in BH-disabled
> > context.
> 
> Ah right. So perhaps we can keep local_bh_disable() instead.
> 
> > But what does this change help?
> 
> It reduces the code scope running with BH disabled.
> Also narrowing down helps to understand what it actually protects.

I thought that you would call out unnecessarily delaying other softirq
handlers.  ;-)

But if such delays are a problem (and they might well be), then to
avoid them on non-rcu_nocb CPUs would instead/also require changing the
early-exit checks to check for other pending softirqs to the existing
checks involving time, need_resched, and idle.  At which point, entering and
exiting BH-disabled again doesn't help, other than your point about the
difference in BH-disabled scopes on rcu_nocb and non-rcu_nocb CPUs.

Would it make sense to exit rcu_do_batch() if more than some amount
of time had elapsed and there was some non-RCU softirq pending?

My guess is that the current tlimit checks in rcu_do_batch() make this
unnecessary.

Thoughts?

							Thanx, Paul
