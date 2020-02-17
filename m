Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C6BC34022
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 23:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E592620836
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 23:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581980585;
	bh=vw19dXoeTDHzqK+VBLov6WbJoLsfc1LeV9oIiYW493o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=eIecyCdrTHh/MwQsOJc7Pe973I47yEqcLeIV/tXvkOl3hWP9AA26qmUDWDILfoGnQ
	 CtnTfDXfoh6EjzmNXTLO4qyhNEwyMGDC4M3HEKcGPQB7jm7WpIAKYJldMeQNk/0dRy
	 CidNT//p6GVtnngYgRWEUBZUmGagZNgWnhURstrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgBQXDE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:03:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgBQXDE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 18:03:04 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B99620801;
        Mon, 17 Feb 2020 23:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581980583;
        bh=vw19dXoeTDHzqK+VBLov6WbJoLsfc1LeV9oIiYW493o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=1uBa8oW2JeQpzH6zBpqaq7dGPK+XTEgxIF20aoNtC1vzkN2uJUZEDP+PRSvkBGdHG
         vROKxCfEuNKCf8p4fDTwt/nlOUeuu24K5uPbsZf1EciyZzWFBF59XmLMPO5AoPHFta
         X+chGjHFqXD+O9RXKQhnWWIhXDu7qT+DPUzx2KPM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6289335227A8; Mon, 17 Feb 2020 15:03:03 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:03:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH tip/core/rcu 22/30] rcu: Don't flag non-starting GPs
 before GP kthread is running
Message-ID: <20200217230303.GZ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
 <20200214235607.13749-22-paulmck@kernel.org>
 <20200214225305.48550d6a@oasis.local.home>
 <20200215110111.GZ2935@paulmck-ThinkPad-P72>
 <20200215134208.GA9879@paulmck-ThinkPad-P72>
 <20200217152517.26cc11ea@gandalf.local.home>
 <20200217220356.GY2935@paulmck-ThinkPad-P72>
 <20200217172131.1f4c48d2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217172131.1f4c48d2@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 17, 2020 at 05:21:31PM -0500, Steven Rostedt wrote:
> On Mon, 17 Feb 2020 14:03:56 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > And what is a day without micro-optimization of a slowpath?  :-)
> 
> A day you have off, but still find yourself working ;-)
> 
> > 
> > OK, let's see...
> > 
> > Grace-period kthread wakeups are normally mediated by rcu_start_this_gp(),
> > which uses a funnel lock to consolidate concurrent requests to start
> > a grace period.  If a grace period is already in progress, it refrains
> > from doing a wakeup because that means that the grace-period kthread
> > will check for another grace period being needed at the end of the
> > current grace period.
> > 
> > Exceptions include:
> > 
> > o	The wakeup reporting the last quiescent state of the current
> > 	grace period.
> > 
> > o	Emergency situations such as callback overloads and RCU CPU stalls.
> > 
> > So on a busy system that is not overloaded, the common case is that
> > rcu_gp_kthread_wake() is invoked only once per grace period because there
> > is no emergency and there is a grace period in progress.  If this system
> > has short idle periods and a fair number of quiescent states, a reasonable
> > amount of idle time, then the last quiescent state will not normally be
> > detected by the grace-period kthread.  But workloads can of course vary.
> > 
> > The "!t" holds only during early boot.  So we could put a likely() around
> > the "t".  But more to the point, at runtime, "!t" would always be false,
> > so it really should be last in the list of "||" clauses.  This isn't
> > enough of a fastpath for a static branch to make sense.
> 
> Hey! Does that mean we can add a static branch for that check?
> 
> 
> struct static_key rcu_booting = STATIC_KEY_INIT_TRUE;
> 
> [...]
> 
> 	if (READ_ONCE(rcu_state.gp_flags) ||
> 	    (current == t && !in_irq() && !in_serving_softirq())
> 		return;
> 
> 	if (static_branch_unlikely(&rcu_booting) && !t)
> 		return;
> 
> At end of boot:
> 
> 	static_key_disable(&rcu_booting);
> 
> That way we can really micro-optimize the slow path, and it basically
> becomes a nop!

;-) ;-) ;-)

There might be some place where static branches would be of use in RCU,
but unfortunately none that I can think of on the read side.  Though I
am once again making progress on Lai Jiangshan's patchset, which might
one day result in inlining of __rcu_read_lock() and __rcu_read_unlock()
in PREEMPT=y kernels.

							Thanx, Paul

> -- Steve
> 
> > 
> > The "!READ_ONCE(rcu_state.gp_flags)" will normally hold, though it is
> > false often enough to pay for itself.  Or has been in the past, anyway.
> > I suspect that access to the global variable rcu_state.gp_flags is not
> > always fast either.
> > 
> > So I am having difficulty talking myself into modifying this one given
> > the frequency of operations.
> > 
> > 							Thanx, Paul
> 
