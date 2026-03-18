Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989519C546
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859380; cv=none; b=h+uxtiFHd2inTJsAW6lAtxogKWuJGyQWoyofj6EozCY6cbIDyWD+SMvB57RGAJLGniHWr1ij/6KtiMtfGRNWgUjGBIrPERYpI75AAaGXY2MSD01heRzoCdn2b5G8v0yygGF9coXiYVjJk1tXEQcP8Z1GXRLmryp4MSzQE5uzU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859380; c=relaxed/simple;
	bh=whQt4ik7BAhJgmj8svzzgOGlxN3t1EARGNpMNibcfgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuxrivfOyISIz7KsqcrgbFVS/KGkxPeveLMMXpLYlgzP5IKKMRV5UgLVukiRokqTIl7AMBswhW5nHr3iLwqiZZS9F18qk4b679lrI1AEHpLM+EN8u2KGfrSuRhh64EtPQj4YCuf8T3d5KQAZZYHlII3/j92CjfH+z6KjNhvik4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2Pqij5t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2Pqij5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4F7C19421;
	Wed, 18 Mar 2026 18:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773859380;
	bh=whQt4ik7BAhJgmj8svzzgOGlxN3t1EARGNpMNibcfgg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=B2Pqij5tS26GLNMKmR/HP9xNeX6X+1R933XU9DbukWaGhBsWIa7vu6xTP+dNxSPFj
	 j6TCWupA2WLUfmceEvtNjIb6GSfYUSGG45pXgjo9RgB0diybOwxYo2hoL6Yr7/oBOk
	 in2SOrQJmZbHshFdKXmXjp2pUslcq++eMvCvmF3wWrV3gEMJLd5RppLfbqqpvJ94L6
	 Ivwt9rA0I3bW1ntRuUMIZ/DoA6gUZCDK10og56PdvhfrF280dB+GAsCJ+U6D6rb1ev
	 Sy5SHONkrfuKhpr+4F2J63Eik1+b48nlp5xgAa6SJzyzeyLxVxH7+0i+UwTuXQJdar
	 g16W3xhtQkhTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 89E60CE098B; Wed, 18 Mar 2026 11:42:57 -0700 (PDT)
Date: Wed, 18 Mar 2026 11:42:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org,
	neeraj.iitr10@gmail.com, urezki@gmail.com, joelagnelf@nvidia.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <abrJ9C637V6keRvd@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abrJ9C637V6keRvd@tardis.local>

On Wed, Mar 18, 2026 at 08:51:16AM -0700, Boqun Feng wrote:
> On Wed, Mar 18, 2026 at 03:43:05PM +0100, Sebastian Andrzej Siewior wrote:
> [..]
> > > > > way that vanilla RCU's call_rcu_core() function takes an early exit if
> > > > > interrupts are disabled.  Of course, vanilla RCU can rely on things like
> > > > > the scheduling-clock interrupt to start any needed grace periods [1],
> > > > > but SRCU will instead need to manually defer this work, perhaps using
> > > > > workqueues or IRQ work.
> > > > > 
> > > > > In addition, rcutorture needs to be upgraded to sometimes invoke
> > > > > ->call() with the scheduler pi lock held, but this change is not fixing
> > > > > a regression, so could be deferred.  (There is already code in rcutorture
> > > > > that invokes the readers while holding a scheduler pi lock.)
> > > > > 
> > > > > Given that RCU for this week through the end of March belongs to you guys,
> > > > > if one of you can get this done by end of day Thursday, London time,
> > > > > very good!  Otherwise, I can put something together.
> > > > > 
> > > > > Please let me know!
> > > > 
> > > > Given that the current locking does allow it and lockdep should have
> > > > complained, I am curious if we could rule that out ;)
> > 
> > Your patch just s/spinlock_t/raw_spinlock_t so we get the locking/
> > nesting right. The wakeup problem remains, right?
> > But looking at the code, there is just srcu_funnel_gp_start(). If its
> > srcu_schedule_cbs_sdp() / queue_delayed_work() usage is always delayed
> > then there will be always a timer and never a direct wake up of the
> > worker. Wouldn't that work?
> 
> Late to the party, so just make sure I understand the problem. The
> problem is the wakeup in call_srcu() when it's called with scheduler
> lock held, right? If so I think the current code works as what you
> already explain, we defer the wakeup into a workqueue.

The issue is that call_rcu_tasks() (which is call_srcu() now) is
also invoked with a scheduler pi/rq lock held, which results in a
deadlock cycle.  So the srcu_gp_start_if_needed() function's call to
raw_spin_lock_irqsave_sdp_contention() must be deferred to the workqueue
handler, not just the wake-up.  And that in turn means that the callback
point also needs to be passed to this handler.

See this email thread:

https://lore.kernel.org/all/CAP01T75eKpvw+95NqNWg9P-1+kzVzojpN0NLat+28SF1B9wQQQ@mail.gmail.com/

> (but Paul, we are not talking about calling call_srcu(), that requires
> some more work to get it work)

Agreed, splitting srcu_gp_start_if_needed() and using a workqueue if
interrupts were already disabled on entry.  Otherwise, directly invoking
the split-out portion of srcu_gp_start_if_needed().

But we might be talking past each other.

							Thanx, Paul

> > > It would be nice, but your point about needing to worry about spinlocks
> > > is compelling.
> > > 
> > > But couldn't lockdep scan the current task's list of held locks and see
> > > whether only raw spinlocks are held (including when no spinlocks of any
> > > type are held), and complain in that case?  Or would that scanning be
> > > too high of overhead?  (But we need that scan anyway to check deadlock,
> > > don't we?)
> > 
> > PeterZ didn't like it and the nesting thing identified most of the
> > problem cases. It should also catch _this_ one.
> > 
> > Thinking about it further, you don't need to worry about
> > local_bh_disable() but RCU will becomes another corner case. You would
> > have to exclude "rcu_read_lock(); spin_lock();" on a !preempt kernel
> > which would otherwise lead to false positives.
> > But as I said, this case as explained is a nesting problem and should be
> > reported by lockdep with its current features.
> 
> Right, otherwise there is a lockdep bug ;-)
> 
> Regards,
> Boqun
