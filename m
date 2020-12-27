Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427B6C433DB
	for <rcu@archiver.kernel.org>; Sun, 27 Dec 2020 16:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF0922512
	for <rcu@archiver.kernel.org>; Sun, 27 Dec 2020 16:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgL0Qt6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 27 Dec 2020 11:49:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgL0Qt6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 27 Dec 2020 11:49:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 809D220857;
        Sun, 27 Dec 2020 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609087757;
        bh=9C7dX+mOhfBbsVXvL9LdEzhr5gJN34Hz9kXNIhM2jWM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jtZpuAJV8n4gfq4bJ1agEn5jiEx44XSpm+IqaxJ54QKLxruvLnUwNYZ/J4+hY3g2z
         P5HYOwWzYRVXALEisjORfizLzVSG6QwCQDp/QX5Wu7drdAPOGzzB0cNRkmqtmKpUsH
         WglJNbVlOfMjizOnaZPmyM9wsSoQW65Y+EpJE3aMjJWJ3VRFn3qUwBUtj14ry8XXfl
         sx7XwzcWytbLGPswLSkNDX1H0A2X3uMIUM8OicE1ilxLIPkVWsEOY++I7Es6lC+kGU
         vGZ+f1SJsUfK7knv0mBqIhm6YB8RivZ6N1Z6zIRnh/A+GUNvyW+Hth66xpUHrqO9eB
         +kWzamkLvYHOQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 44A8E35226B3; Sun, 27 Dec 2020 08:49:17 -0800 (PST)
Date:   Sun, 27 Dec 2020 08:49:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH tip/core/rcu 3/4] rcutorture: Make grace-period kthread
 report match RCU flavor being tested
Message-ID: <20201227164917.GA2139@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105233900.GA20676@paulmck-ThinkPad-P72>
 <20201105233933.20748-3-paulmck@kernel.org>
 <CAMuHMdXjUxfp0h=TiwNoZJUHrSD4sDwYEbuqNR4rcWSRFCjUtw@mail.gmail.com>
 <20201215182419.GD2657@paulmck-ThinkPad-P72>
 <CAMuHMdWdBVOZobfXD9i==yxB1QEEMAJa7BoTNem9FQmYFq_=dA@mail.gmail.com>
 <20201216164829.GI2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216164829.GI2657@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 16, 2020 at 08:48:29AM -0800, Paul E. McKenney wrote:
> On Wed, Dec 16, 2020 at 10:31:16AM +0100, Geert Uytterhoeven wrote:
> > Hi Paul,
> > 
> > On Tue, Dec 15, 2020 at 7:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > On Tue, Dec 15, 2020 at 09:40:26AM +0100, Geert Uytterhoeven wrote:
> > > > On Fri, Nov 6, 2020 at 12:40 AM <paulmck@kernel.org> wrote:
> > > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > >
> > > > > At the end of the test and after rcu_torture_writer() stalls, rcutorture
> > > > > invokes show_rcu_gp_kthreads() in order to dump out information on the
> > > > > RCU grace-period kthread.  This makes a lot of sense when testing vanilla
> > > > > RCU, but not so much for the other flavors.  This commit therefore allows
> > > > > per-flavor kthread-dump functions to be specified.
> > > > >
> > > > > [ paulmck: Apply feedback from kernel test robot <lkp@intel.com>. ]
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > >
> > > > Thanks for your patch, which is now commit 27c0f1448389baf7
> > > > ("rcutorture: Make grace-period kthread report match RCU flavor being
> > > > tested").
> > > >
> > > > > --- a/kernel/rcu/rcu.h
> > > > > +++ b/kernel/rcu/rcu.h
> > > > > @@ -533,4 +533,20 @@ static inline bool rcu_is_nocb_cpu(int cpu) { return false; }
> > > > >  static inline void rcu_bind_current_to_nocb(void) { }
> > > > >  #endif
> > > > >
> > > > > +#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RCU)
> > > > > +void show_rcu_tasks_classic_gp_kthread(void);
> > > > > +#else
> > > > > +static inline void show_rcu_tasks_classic_gp_kthread(void) {}
> > > > > +#endif
> > > > > +#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RUDE_RCU)
> > > > > +void show_rcu_tasks_rude_gp_kthread(void);
> > > > > +#else
> > > > > +static inline void show_rcu_tasks_rude_gp_kthread(void) {}
> > > > > +#endif
> > > >
> > > > The #ifdef expression does not match the one for the implementation
> > > > below.
> > >
> > > That does sound like something I would do...
> > >
> > > The definition of show_rcu_tasks_rude_gp_kthread() must be provided
> > > elsewhere if !TINY_RCU && TASKS_RUDE_RCU, correct?
> > >
> > > > > --- a/kernel/rcu/rcutorture.c
> > > > > +++ b/kernel/rcu/rcutorture.c
> > > >
> > > > > @@ -762,6 +765,7 @@ static struct rcu_torture_ops tasks_rude_ops = {
> > > > >         .exp_sync       = synchronize_rcu_tasks_rude,
> > > > >         .call           = call_rcu_tasks_rude,
> > > > >         .cb_barrier     = rcu_barrier_tasks_rude,
> > > > > +       .gp_kthread_dbg = show_rcu_tasks_rude_gp_kthread,
> > > >
> > > > Perhaps you just want to have a NULL pointer for the dummy case, instead
> > > > of instantiating a dummy static inline function and taking its address?
> > >
> > > You mean something like this in kernel/rcu/rcu.h?
> > >
> > > #if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RUDE_RCU)
> > > void show_rcu_tasks_rude_gp_kthread(void);
> > > #else
> > > #define show_rcu_tasks_rude_gp_kthread NULL
> > > #endif
> > >
> > > This does looks better to me, and at first glance would work.
> > 
> > Exactly. This is similar to how unimplemented PM callbacks are handled
> > (git grep "#define\s*pm_.*NULL").
> 
> OK, as shown in the (untested) patch below?

I finally got around to running the full suite after completing a couple
of long-running bisections, and yes, you got me on this one!  ;-)

Both locktorture and scftorture build with CONFIG_TINY_RCU,
CONFIG_TASKS_RCU, CONFIG_TASKS_RUDE_RCU, and CONFIG_TASKS_TRACE_RCU
all disabled.  So when the compiler attempts to build this:

	void show_rcu_tasks_gp_kthreads(void)
	{
		show_rcu_tasks_classic_gp_kthread();
		show_rcu_tasks_rude_gp_kthread();
		show_rcu_tasks_trace_gp_kthread();
	}

It sees this:

	void show_rcu_tasks_gp_kthreads(void)
	{
		NULL();
		NULL();
		NULL();
	}

Needless to say, it doesn't like this much, and refuses to suffer
in silence.

I am reverting the commit that defined these three functions to NULL.
This means that rcutorture runs still instantiate static inline
definitions of these three functions, but that does work and only takes
effect for those who are actually running rcutorture.

							Thanx, Paul
