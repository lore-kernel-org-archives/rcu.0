Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A93C6377B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB636120D
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhGUUok (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhGUUok (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:44:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 346866120C;
        Wed, 21 Jul 2021 21:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626902716;
        bh=k4tebm4ckQUUfigmvIsDkaS0hJcmbZNxBgEUPDP9zyw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g2qEUyEjuiVizeov2tx4qpJdxW8uKaN5rIVq4g9z7yITohA99A6rbKooxwhlqR0AU
         FdWXKbL0mbUkOg/X5dsMWDpySXrQAj5pQphp6GPaichiIAEJKwhT2G8YOWoxBkrGrw
         XnttHRZ/ArFZ9tvuA5+UNM3vvgjoTlRnThdqfTzl/VM4gg3iMEvmnsh4AedfHgIato
         UIbyK9qWdDYOOEQDcoODfoFbdCMw8zuoLjdqjvz5eLu43xb0W41YLXHAxYKVhLIV7Z
         gwIoQG619ciTa7iu4ngW/ZzlTYSXWSnwM58DTRdzfV1gh0fwd1TyRBlJAVkjJ9shzp
         D7WV67/L6C3wQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0007E5C09A4; Wed, 21 Jul 2021 14:25:15 -0700 (PDT)
Date:   Wed, 21 Jul 2021 14:25:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Message-ID: <20210721212515.GV4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
 <CAHk-=wgm_W82CcbiJHZPw45QRwomFbWcHkFoOd5C5hG-5GGoRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgm_W82CcbiJHZPw45QRwomFbWcHkFoOd5C5hG-5GGoRQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 21, 2021 at 01:41:46PM -0700, Linus Torvalds wrote:
> Hmm.
> 
> This actually seems to make some of the ordering worse.
> 
> I'm not seeing a lot of weakening or optimization, but it depends a
> bit on what is common and what is not.

Agreed, and I expect that I will be reworking this patch rather
thoroughly.

Something about smp_mb() often being a locked atomic operation on a
stack location.  :-/

But you did ask for this to be sped up some years back (before the
memory model was formalized), so I figured I should at least show what
can be done.  Plus I expect that you know much more about what Intel is
planning than I do.

> On Wed, Jul 21, 2021 at 1:21 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > +/*
> > + * Increment the current CPU's rcu_data structure's ->dynticks field
> > + * with ordering.  Return the new value.
> > + */
> > +static noinstr unsigned long rcu_dynticks_inc(int incby)
> > +{
> > +       struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > +       int seq;
> > +
> > +       seq = READ_ONCE(rdp->dynticks) + incby;
> > +       smp_store_release(&rdp->dynticks, seq);
> > +       smp_mb();  // Fundamental RCU ordering guarantee.
> > +       return seq;
> > +}
> 
> So this is actually likely *more* expensive than the old code was, at
> least on x86.
> 
> The READ_ONCE/smp_store_release are cheap, but then the smp_mb() is expensive.
> 
> The old code did just arch_atomic_inc_return(), which included the
> memory barrier.
> 
> There *might* be some cache ordering advantage to letting the
> READ_ONCE() float upwards, but from a pure barrier standpoint this is
> more expensive than what we used to have.

No argument here.

> > -       if (atomic_read(&rdp->dynticks) & 0x1)
> > +       if (READ_ONCE(rdp->dynticks) & 0x1)
> >                 return;
> > -       atomic_inc(&rdp->dynticks);
> > +       rcu_dynticks_inc(1);
> 
> And this one seems to not take advantage of the new rule, so we end up
> having two reads, and then that potentially more expensive sequence.

This one only executes when a CPU comes online, so I am not worried
about its overhead.

> >  static int rcu_dynticks_snap(struct rcu_data *rdp)
> >  {
> > -       return atomic_add_return(0, &rdp->dynticks);
> > +       smp_mb();  // Fundamental RCU ordering guarantee.
> > +       return smp_load_acquire(&rdp->dynticks);
> >  }
> 
> This is likely cheaper - not because of barriers, but simply because
> it avoids dirtying the cacheline.
> 
> So which operation do we _care_ about, and do we have numbers for why
> this improves anything? Because looking at the patch, it's not obvious
> that this is an improvement.

It sounds like I should keep this hunk and revert the rest back to
atomic operations, but still in the new rcu_dynticks_inc() function.

Either way, thank you for looking this over!

							Thanx, Paul
