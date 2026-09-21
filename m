Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42C4FDA6B;
	Mon, 21 Sep 2026 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016655; cv=none; b=VwJy2cyETgKAoi4iV7mZAk5KvZinSccXWFWRJhJhkXg3g3wwgfvUtSNN8dtIf7jRq6jVQkQEAlwOIXGcbSiOpFij2znWLx2a/ueN7Vm2iVuA4mAKaTsPuA93z1xz3kZ63vrhcEppC/dVpXIsdwrf6nehJFJlTl7/PeNENMDhAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016655; c=relaxed/simple;
	bh=p9vye9Fn0omqERqkD37y+L1HgqTR2av/DqQTxodGdhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXiCj+fbu4ekXvnI2iRtZV+FAQFP7ijOk9Sgc8Wcu9avfMmmxJ6oxcMDt8+0l/LEyBZlKretdcV2AEqbrQz8yVUJzbxxQ4+2vDrmqlRg0ZD4gR2/Dn/uWYMkQ7tjPKI+ZTPjMt5tyg/BTppdT/TBiQdvMNgyvUK9ajBtcRHG7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ9PM8tZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ9PM8tZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C3E1F000FF;
	Mon, 21 Sep 2026 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790016654;
	bh=ORjA4AxqThj6VTeZiT/jrtg6yNBkGJ64/nYD9YDquxo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=bJ9PM8tZiGRVPYCFuS05geBu6n15rijUhOKvxNMwzwQp+vbWm3n8K2FVx12gEAnAB
	 r7U5zr7RnMj9j8GRGxVkdBds35a9fWV6O8KPjgsKK6bTS/hberfFiCAZeiHHNYWcuD
	 qDYwIFiG5WirUSzyY++Qg+6C0TlfI+QlQ9Cvtlht6PNqj66UZvKcllq5EYladN5AMn
	 TFilCwbbVTjC7pdDkXA3v0bXB+YzylJZb3NuH8gjFdFE2o2ngyR44RDveH93mnu+4M
	 yngGOBJXyjwmG0VreHoc/Lfdk0A8uZuyaSA5gwmUafgrD+Oja+zl1jJ3umAj1ZVJLR
	 eDU/Ilec2XVhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B90E4CE0E8C; Mon, 21 Sep 2026 11:50:53 -0700 (PDT)
Date: Mon, 21 Sep 2026 11:50:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 1/7] rcu: Make call_rcu() safe to call from any context
Message-ID: <fd572a7e-86f4-4ef3-8ebc-abeced7a6159@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2a742578-120a-421d-9305-5de0b22bda33@paulmck-laptop>
 <20260919003258.3134343-1-paulmck@kernel.org>
 <aq6XFyrR3OiSvKl9@MacBook-0RXW5>
 <CANk7y0g5EU8T8cLiU=+tLiZCcMEhZOjhnvs4uzD8Z=8GwN+7LA@mail.gmail.com>
 <arF30s1AAAkmq0DB@MacBook-0RXW5>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arF30s1AAAkmq0DB@MacBook-0RXW5>

On Mon, Sep 21, 2026 at 08:30:42PM +0200, Boqun Feng wrote:
> On Mon, Sep 21, 2026 at 07:12:02PM +0100, Puranjay Mohan wrote:
> > On Sat, Sep 19, 2026 at 3:07 PM Boqun Feng <boqun@kernel.org> wrote:
> > >
> > > On Fri, Sep 18, 2026 at 05:32:52PM -0700, Paul E. McKenney wrote:
> > > > From: Puranjay Mohan <puranjay@kernel.org>
> > > >
> > >
> > > Hi,
> > >
> > > Sorry for a bit late repsonse.
> > >
> > > > RCU's per-CPU callback list is only touched with interrupts disabled: the
> > > > enqueue runs under local_irq_save() (and the nocb locks when offloaded),
> > > > as do callback invocation and grace-period work.  A call_rcu() that
> > > > arrives with interrupts already disabled, whether from an NMI or from
> > > > instrumentation that re-enters RCU, can interrupt one of those and corrupt
> > > > the list or deadlock.
> > > >
> > > > Defer instead: stage the callback on a per-CPU llist and raise an irq_work
> > > > that re-issues it once interrupts are on, straight to the enqueue so it
> > > > cannot defer again.  The gate is bare irqs_disabled(), so callers that
> > > > merely hold interrupts off are deferred too and pay one irq_work hop.
> > > > Skip it while the scheduler is down (RCU_SCHEDULER_INACTIVE): irq_work is
> > > > not usable that early, rcu_init() already calls call_rcu(), and the per-CPU
> > > > deferral state is not initialised until rcu_init_one() runs later in it.
> > > >
> > > > rcu_barrier() drains every CPU's ->defer_head before it scans the lists,
> > > > and rcutree_migrate_callbacks() drains an outgoing CPU's.  A drain
> > > > re-issues onto the draining CPU, so a barrier moves other CPUs' staged
> > > > callbacks onto
> > > > its own ->cblist; call_rcu() promises no CPU affinity for invocation.
> > > > ->defer_lock is held across llist_del_all() and the whole re-issue so the
> > > > drainers
> > > > serialize: one that finds the list empty can conclude that everything
> > > > staged before it is already on a callback list.  Interrupts stay off for
> > > > the batch.  Where the arch has an irq_work self-IPI that is what one
> > > > interrupts-disabled region could stage, normally a single callback; where
> > > > arch_irq_work_has_interrupt() is false the drain waits for the tick, so
> > > > several regions can accumulate first.
> > > >
> > > > The drain clears ->next before re-issuing.  A double call_rcu() on a head
> > > > that is already debug-object-active self-links the staged node, and
> > > > rcu_do_enqueue()'s duplicate path returns without clearing it, so the
> > > > drain would spin.  A re-add behind other staged callbacks makes a longer
> > > > cycle, which that does not bound; a double call_rcu() stays undefined.
> > > > llist_del_all() yields newest-first, so a batch is re-issued in reverse
> > > > call order; nothing depends on call_rcu() ordering.  The re-issue drops
> > > > the lazy hint, since staging records only ->func, so a deferred callback
> > > > loses its batching on CONFIG_RCU_LAZY.  kasan_record_aux_stack() moves to
> > >
> > > I'm not sure this is a good idea, because it effectively remove LAZY
> > > support when DEFER is enabled. Since the goal of this patchset supports
> > > BPF and NMI, would it be nicer that we skip the whole defer logic if the
> > > callback is LAZY? Alternatively, you can have two llist (one for hurry
> > > and one for lazy).
> > 
> > I had made this trade-off of removing the Lazy tag as I thought it is
> > not necessary to support lazy when call_rcu() is called from nmi and
> > bpf based instrumentation as they should not be frequent. But I like
> 
> Ah, I missed that you only defer if irqs_disabled() is true, so this is
> much better than I used to think. So..
> 
> > the idea of two lists (skipping the defer logic is not possible as it
> > could lead to deadlocks/corruption). I will also investigate if we can
> > put the Lazy tag on the ->next pointer. But will it be acceptable if I
> > do that as a follow up? I want to get the base support fully validated

I agree that you need a lazy flag that indicates that all deferred
callbacks in this llist are lazy.  As soon as the first non-lazy callback
arrives, the flag must be cleared.  Because this is the way laziness
works without deferral, correct?

Then in the irq-work handler, enqueue them all lazily if the flag is
still set, or non-lazily otherwise.  If the flag is not set, enqueue
them lazily.  Either way, set the lazy flag.

Of course, as described, this is quite racy.  To make it work, the
enqueuing and the clearing of the flag for that first non-lazy
callback must be atomic.  Which can be accomplished by having this
be the low-order bit of the llist_head structure's ->first pointer,
as opposed to the llist_node structure's ->next pointer.

Or am I missing something subtle here?

And of course, either way, this requires llist primitives that clear
that low-order bit at the appropriate places.

> .. definitely a follow-up would do, thank you!

Very much agreed on this being a follow-up item!

							Thanx, Paul

> Regards,
> Boqun
> 
> > with the BPF side changes. I also have more optimizations planned as
> > suggested by Sebastian.
> > 
> > Thanks,
> > Puranjay
> > 
