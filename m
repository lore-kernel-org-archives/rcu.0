Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6412581F
	for <rcu@vger.kernel.org>; Tue, 27 Feb 2024 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708993140; cv=none; b=FYsT2lMqqO4bEPL7nyBP9ysClHFyZRryZXH/m1nBc1RYO7c20fDNxNcUfxh10tw7qFsAm9pepoOJgWunlzEbGJPzZuHYJF63ZAy+TCub4poBBNUcARj/jOwuTr7t0yy/cjWTjdcf4/8kaq9jpcL0gHfr/JzJn7pEOo3fnBkGJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708993140; c=relaxed/simple;
	bh=KBtsQKgVZFIS1KJUXZKT/J/Ou0Dlw1acR/7/rTduMV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGtCfIUs0bjlPK/7wkYNb7+OaauzPIJC83zZrGup/JsEerljzNb1HJmxahws6juKbGOCxtMNLYXiEP02n3uK4p3zSxwgq9aB62tdncn6myXz+Y6LmxIUGKQWjJgNLqa8fbtsrOEkjfttEGIVCUvnMmRJ1sLu0Jxs+184rUnlFlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEVdc7wQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEVdc7wQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6494C433C7;
	Tue, 27 Feb 2024 00:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708993139;
	bh=KBtsQKgVZFIS1KJUXZKT/J/Ou0Dlw1acR/7/rTduMV8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vEVdc7wQYrfxbiCewFzZqtQFlpa52IFcPftJaAidp2F7cZ8s233he86VNE8n05MXv
	 fblTbpIgp4Obmmp72tQ/wOPjpCuCgYBHx1stvx7UY0JvE7QChAyZOtNuQZtchVjhli
	 3U2PjlrnzZxFz4NqNuzJ76k6DSF5nD+JeS7jpVz4UQ4t8YyYLtiF6kpkm9/7NinehZ
	 H0pTwk2PuWNw3ZNuh2teBexTO6FTy7mztt/PCI2chxGokye68zN6/2XK+GBhIcQI0V
	 oa1hsmFjqyPFk+o+ZNdC6YELr3JBo0T1uVpNsV11uvKjEB91ddzjYdQ7uSXrDucUsq
	 GgaTxD/2wYl8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 69831CE098C; Mon, 26 Feb 2024 16:18:59 -0800 (PST)
Date: Mon, 26 Feb 2024 16:18:59 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ze Gao <zegao2021@gmail.com>
Cc: neeraj.iitr10@gmail.com, joel@joelfernandes.org, frederic@kernel.org,
	boqun.feng@gmail.com, urezki@gmail.com, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org
Subject: Re: Questions on RCU memory guarantees in linux
Message-ID: <d19ead1b-bbb6-4a90-89dc-81a83f18bf59@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAD8CoPAKw7eXC5iTKJk=6NQi3HEOLAujFXQRD9ViB0eDQFYRLw@mail.gmail.com>
 <f856fa0a-2195-4eef-baf3-2b031770b97a@paulmck-laptop>
 <CAD8CoPB5MEHV6v+z5znY8apkaACM+s3oUu-tTttuQ29iRvU9EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD8CoPB5MEHV6v+z5znY8apkaACM+s3oUu-tTttuQ29iRvU9EQ@mail.gmail.com>

On Sun, Feb 25, 2024 at 06:41:46PM +0800, Ze Gao wrote:
> On Sat, Feb 24, 2024 at 6:19 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Adding some additional RCU experts on CC.
> >
> > On Fri, Feb 23, 2024 at 03:22:13PM +0800, Ze Gao wrote:
> > > Dear Paul,
> > >
> > > I'm reading this article [1] by you and have doubts about how these
> > > memory guarantees are provided in Linux.
> > >
> > > As quoted from [1], RCU needs to make sure:
> > >
> > > >1. Each CPU that has an RCU read-side critical section that begins before synchronize_rcu() >starts is guaranteed to execute a full memory barrier between the time that the RCU read-side >critical section ends and the time that synchronize_rcu() returns. Without this guarantee, a pre-> existing RCU read-side critical section might hold a reference to the newly removed struct foo > after the kfree() on line 14 of remove_gp_synchronous().
> > >
> > > >2. Each CPU that has an RCU read-side critical section that ends after synchronize_rcu() >returns is guaranteed to execute a full memory barrier between the time that synchronize_rcu() >begins and the time that the RCU read-side critical section begins. Without this guarantee, a >later RCU read-side critical section running after the kfree() on line 14 of >remove_gp_synchronous() might later run do_something_gp() and find the newly deleted >struct foo.
> > >
> > > FWIW,  I can understand the necessity for smp_mb() for both cases you
> > > have posted in the quick quiz. But I'm really curious about how
> > > Tree-RCU with !CONFIG_PREEMPT provides such
> > > guarantees where obviously smp_mb() cannot be provided by
> > > rcu_read_{lock, unlock}.
> > >
> > >  Also, I see you've answered another related question in a different
> > > quiz about how RCU infers quiescent states,  After digging for a
> > > while, I try to make the best guess of the answers so here is my
> > > understanding:
> > >
> > > 1) both Guarantee #1 and #2 are to make sure any loads/stores by
> > > updater are properly propagated to newly arriving readers so to avoid
> > >
> > > 2) according to 1), so in cases where rcu_read_{lock, unlock}
> > > generates no code, the smp_mb() is actually provided by where the CPU
> > > reports a quiescent state. IOW, Tree-RCU with !CONFIG_PREEMPT provides
> > > Guarantee #1 and #2 by extending the grace period requested by
> > > synchronize_rcu(), so in both following cases you mentioned, smp_mb()
> > > can be provided by accessing rcu_node structure's ->lock field
> > > mentioned in [2].
> >
> > So far so good.
> 
> First and most importantly, thanks for your attention and replies, which means
> a lot to me!
> 
> > > Case A:
> > > CPU 1: rcu_read_lock()
> > > CPU 1: q = rcu_dereference(gp); /* Very likely to return p. */
> > > CPU 0: list_del_rcu(p);
> > > CPU 0: synchronize_rcu() starts.
> > > CPU 1: do_something_with(q->a); /* No smp_mb(), so might happen after
> > > kfree(). */
> > > CPU 1: rcu_read_unlock()
> >
> > Here CPU 1 must report its quiescent state to the RCU core code.  This
> > involves locking and memory barriers that ensure that the rcu_read_lock()
> > is seen by all to precede the return from synchronize_rcu().
> >
> > > CPU 0: synchronize_rcu() returns.
> > > CPU 0: kfree(p);
> > >
> > > Case B:
> > > CPU 0: list_del_rcu(p);
> > > CPU 0: synchronize_rcu() starts.
> >
> > If synchronize_rcu() cannot prove that it started before a given
> > rcu_read_lock(), it must assume that the rcu_read_lock() was there first.
> > This is mediated by the RCU core code that sees that the grace period
> > started. So if CPU 1 sees the grace period as having started before the
> > rcu_read_lock(), then the grace period will not wait for the corresponding
> 
> So it means CPU 1 has already reported its QS for the recent most
> GP to the RCU core, and already see the published value (actually all
> writes before synchronize_rcu() ), so it's not necessary to wait for it.
> 
> I think I understand it a little bit: this is all about GP tracking. And from
> a high level of overview.
> 
> 1)  gp seq updating provides smp_mb() for all with the updater included.
> 2)  RCU core checks gp seq and does QS reporting provides smp_mb() for
> the readers
> 
> such that each reader CPU who reports its QS for a given GP is
> guaranteed to see all
> loads/writes by the updater who initiates the GP.
> 
> or maybe 2) provides all smp_mb() already.
> 
> I don't know if I get it right.

Everything you say is true up to a point if you look at things in the
right way, but there are many details, each hiding many devils.

> > rcu_read_unlock().  Otherwise, it will wait, avoiding the situation
> > shown below.
> > Again, with locks and memory barriers providing ordering.
> >
> > > CPU 1: rcu_read_lock()
> > > CPU 1: q = rcu_dereference(gp); /* Might return p if no memory barrier. */
> > > CPU 0: synchronize_rcu() returns.
> > > CPU 0: kfree(p);
> > > CPU 1: do_something_with(q->a); /* Boom!!! */
> > > CPU 1: rcu_read_unlock()
> > >
> > > I should've studied the code to find the answer, but It may take years
> > > to know the details :).
> > > (no kidding given the large codebase and its complicacy).  So I'm
> > > being bold to directly write to you for help. Please forgive me for
> > > being reckless.
> > >
> > > Appreciate your excellent docs on this topic and look forward to your
> > > comments to clear my doubts.
> >
> > As you say, the code is non-trivial.  Something about needing to scale
> > to systems having thousands of CPUs, conserve energy on battery-powered
> > systems, tolerate CPUs coming and going (for example, in suspend/resume),
> > help to provide deep sub-millisecond real-time latencies, work properly
> > when being used before it is initialized during kernel boot, and so on.
> >
> > So [3] is the summary I wrote up to communicate how this works (sadly, all
> > 648 lines of it), with [4] being a graphical summary of how things work.
> > Studying these carefully over a period of time has proven quite helpful
> > to some people.
> >
> > Section 4 of [5] gives an overview, but with less detail.  It might
> > be a good place to get a running start for digging through [3][4].
> > We have a bunch of low-level RCU design documents publicly available
> > [6], which might also be helpful.
> >
> > Or you might wish to take a look at a simpler RCU implementation, which
> > faces the same issues, but which is easier to get one's head around.
> > Userspace RCU is such an implementation (and there are many others
> > [8]), and its web page [8] points to a great deal of documentation,
> > perhaps most notably the February 2012 IEEE TPDS paper.
> 
> Thanks for the great materials and advice, which I should digest for a while.

Great effort is required, but great rewards are waiting.

> > This is not easy stuff, and I encourage you to keep at it!
> 
> Yes, It's hard, but I hope my curiosity can bring me a little further.
> :) And again,
> thanks for your encouragement and glad to learn from you and your
> brilliant work.

Please let me know how it goes!

							Thanx, Paul

> Thanks,
>         -- Ze
> 
> >                                                         Thanx, Paul
> >
> > > Regards,
> > >         -- Ze
> > > ---
> > > [1]: https://dri.freedesktop.org/docs/drm/RCU/Design/Requirements/Requirements.html#memory-barrier-guarantees
> > > [2]: https://dri.freedesktop.org/docs/drm/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html#what-is-tree-rcu-s-grace-period-memory-ordering-guarantee
> >
> > [3]: https://dri.freedesktop.org/docs/drm/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html#what-is-tree-rcu-s-grace-period-memory-ordering-guarantee
> > [4] https://www.kernel.org/doc/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html
> > [5] https://github.com/michaliskok/rcu/blob/master/rcupaper.pdf
> > [6] https://docs.google.com/document/d/1GCdQC8SDbb54W1shjEXqGZ0Rq8a6kIeYutdSIajfpLA/edit?usp=sharing
> > [7] https://kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook.html
> >     Section 9.5.5 has a list of uses and implementations.
> > [8] https://liburcu.org
