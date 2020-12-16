Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEACC4361B
	for <rcu@archiver.kernel.org>; Wed, 16 Dec 2020 16:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954BB233EA
	for <rcu@archiver.kernel.org>; Wed, 16 Dec 2020 16:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgLPQtL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Dec 2020 11:49:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgLPQtL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Dec 2020 11:49:11 -0500
Date:   Wed, 16 Dec 2020 08:48:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608137309;
        bh=XgE87/zh6WtILu03bQa/pP2CO/qLhs6CRGX2o37IZmI=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BzYPpJhQeBYyoNCNpnQ4TYXeU03zGd6bIbFE7XuTE0xuhQevtqQ5XZ0buRM80hg7Q
         8x7RFLc1VsBMigQQHu9qzElyroLPtNO4nOzU0OZCx+Pun0oKqTjuGUZ0Lrn5o6hlA9
         7m9jreqfze+djRDbGu3rDEEkyuyBbH8fYcTqnkyyeib3RamWEks/kIlMhqUx4szGF6
         j7o7KdUj6mePfkvLIT1J8lPJw7CLGEdLPxd7uBS1+CvGSoQyA1l1RrgngsSgf8nYj5
         NwL2G7Yz0mPw7lKp10LsMyBjjpsQAKD/X5neiyyUxQndS9i6landkvI8V3sgPe/yoA
         uV2eGyg2NhKpA==
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
Message-ID: <20201216164829.GI2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105233900.GA20676@paulmck-ThinkPad-P72>
 <20201105233933.20748-3-paulmck@kernel.org>
 <CAMuHMdXjUxfp0h=TiwNoZJUHrSD4sDwYEbuqNR4rcWSRFCjUtw@mail.gmail.com>
 <20201215182419.GD2657@paulmck-ThinkPad-P72>
 <CAMuHMdWdBVOZobfXD9i==yxB1QEEMAJa7BoTNem9FQmYFq_=dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWdBVOZobfXD9i==yxB1QEEMAJa7BoTNem9FQmYFq_=dA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 16, 2020 at 10:31:16AM +0100, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Tue, Dec 15, 2020 at 7:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Tue, Dec 15, 2020 at 09:40:26AM +0100, Geert Uytterhoeven wrote:
> > > On Fri, Nov 6, 2020 at 12:40 AM <paulmck@kernel.org> wrote:
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > >
> > > > At the end of the test and after rcu_torture_writer() stalls, rcutorture
> > > > invokes show_rcu_gp_kthreads() in order to dump out information on the
> > > > RCU grace-period kthread.  This makes a lot of sense when testing vanilla
> > > > RCU, but not so much for the other flavors.  This commit therefore allows
> > > > per-flavor kthread-dump functions to be specified.
> > > >
> > > > [ paulmck: Apply feedback from kernel test robot <lkp@intel.com>. ]
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > > Thanks for your patch, which is now commit 27c0f1448389baf7
> > > ("rcutorture: Make grace-period kthread report match RCU flavor being
> > > tested").
> > >
> > > > --- a/kernel/rcu/rcu.h
> > > > +++ b/kernel/rcu/rcu.h
> > > > @@ -533,4 +533,20 @@ static inline bool rcu_is_nocb_cpu(int cpu) { return false; }
> > > >  static inline void rcu_bind_current_to_nocb(void) { }
> > > >  #endif
> > > >
> > > > +#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RCU)
> > > > +void show_rcu_tasks_classic_gp_kthread(void);
> > > > +#else
> > > > +static inline void show_rcu_tasks_classic_gp_kthread(void) {}
> > > > +#endif
> > > > +#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RUDE_RCU)
> > > > +void show_rcu_tasks_rude_gp_kthread(void);
> > > > +#else
> > > > +static inline void show_rcu_tasks_rude_gp_kthread(void) {}
> > > > +#endif
> > >
> > > The #ifdef expression does not match the one for the implementation
> > > below.
> >
> > That does sound like something I would do...
> >
> > The definition of show_rcu_tasks_rude_gp_kthread() must be provided
> > elsewhere if !TINY_RCU && TASKS_RUDE_RCU, correct?
> >
> > > > --- a/kernel/rcu/rcutorture.c
> > > > +++ b/kernel/rcu/rcutorture.c
> > >
> > > > @@ -762,6 +765,7 @@ static struct rcu_torture_ops tasks_rude_ops = {
> > > >         .exp_sync       = synchronize_rcu_tasks_rude,
> > > >         .call           = call_rcu_tasks_rude,
> > > >         .cb_barrier     = rcu_barrier_tasks_rude,
> > > > +       .gp_kthread_dbg = show_rcu_tasks_rude_gp_kthread,
> > >
> > > Perhaps you just want to have a NULL pointer for the dummy case, instead
> > > of instantiating a dummy static inline function and taking its address?
> >
> > You mean something like this in kernel/rcu/rcu.h?
> >
> > #if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RUDE_RCU)
> > void show_rcu_tasks_rude_gp_kthread(void);
> > #else
> > #define show_rcu_tasks_rude_gp_kthread NULL
> > #endif
> >
> > This does looks better to me, and at first glance would work.
> 
> Exactly. This is similar to how unimplemented PM callbacks are handled
> (git grep "#define\s*pm_.*NULL").

OK, as shown in the (untested) patch below?

> > > >         .fqs            = NULL,
> > > >         .stats          = NULL,
> > > >         .irq_capable    = 1,
> > >
> > >
> > > > --- a/kernel/rcu/tasks.h
> > > > +++ b/kernel/rcu/tasks.h
> > >
> > > > @@ -696,16 +696,14 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
> > > >  }
> > > >  core_initcall(rcu_spawn_tasks_rude_kthread);
> > > >
> > > > -#ifndef CONFIG_TINY_RCU
> > > > -static void show_rcu_tasks_rude_gp_kthread(void)
> > > > +#if !defined(CONFIG_TINY_RCU)
> > >
> > > Different #ifdef expression.
> >
> > I don't believe that it is.  The above supplies the !TINY_RCU, and a
> > prior #ifdef supplies the TASKS_RUDE_RCU.  So what am I missing here?
> 
> Sorry, you're right. I missed the outer #ifdef.
> 
> > > > +void show_rcu_tasks_rude_gp_kthread(void)
> > >
> > > Do you really want to define a non-static function...
> >
> > Yes, because its user is in kernel/rcu/rcutorture.c, which is in
> > a separate translation unit, so it must be non-static.  The earlier
> > version instead only called it from this file, but that turned out to
> > produce confusing output containing information for flavors of RCU that
> > were not under test.  So this commit exported it to allow rcutorture to
> > complain about only that RCU flavor being tested.
> >
> > > >  {
> > > >         show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
> > > >  }
> > > > -#endif /* #ifndef CONFIG_TINY_RCU */
> > > > -
> > > > -#else /* #ifdef CONFIG_TASKS_RUDE_RCU */
> > > > -static void show_rcu_tasks_rude_gp_kthread(void) {}
> > > > -#endif /* #else #ifdef CONFIG_TASKS_RUDE_RCU */
> > > > +EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
> > >
> > > ... and export its symbol, from a header file?
> > > I know the file is included only once.
> >
> > Because kernel/rcu/rcutorture.c can be built as a module, it must be
> > exported.  I agree that it is unusual to export from a .h file, but the
> > single inclusion is intentional.  There are several other .h files in
> > kernel/rcu that are also split out to group similar functionality while
> > still allowing the compiler to inline to its heart's content.
> 
> My main gripe is having non-static functions in a header file, which
> causes havoc if someone ever start including it from a second source
> file.
> 
> Why not move the contents of the header to the (single) source file that
> includes the header _unconditionally_, to make it nicely self-contained?
> For conditional includes, things are obviously different.

Because I used to do it that way and continually got tripped up by
the outer #if ranges that caused you trouble above.  Only with more
#if ranges spread through a larger file, it was even more painful.
With each .h file confined to a particular topic, its #if structure is
relatively simple, though perhaps not all that helpful to people such
as yourself who are new to the file.

But still way easier to pick up than having all of the #if ranges
contained within a single file.

> > Yes, this is a bit unconventional, but it has been this way for more
> > than a decade, at least for tree_plugin.h.
> 
> Oh right, there are even more of these ;-)

Indeed there are.

							Thanx, Paul
