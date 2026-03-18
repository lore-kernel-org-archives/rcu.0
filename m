Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0426625B1D2
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844991; cv=none; b=IyLH6afJizlBDN+YmOxxo7vdvKHWnFzTPWlb5hFfJQBTN4MEqbgBZrh1s48MnFdutwJRnYjkDUV9XNNnw4Wmygbw9iUC29qDhrUwI6yfbNths2BU9tyt/+FTNpzZLiMx+IZDa3P42poP2FaZkx+f9qPTjxa3pV4rpZr7zM/Z/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844991; c=relaxed/simple;
	bh=nJRACLTq23U9jNkWAcOiZUsP6mmnmmPB1xoB+YpVLac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uy9uJ0J9zY1VVfq0IpiMpXiMqqG8inot8mpvH7NvE9gPGLYAnXB5KEVxrCfVHci25184A/9O7ETHE2rmiTSSjpIEU4wiifH36wfOEytkd4VGDKYJ8VxcEG0TrN/mTqxuPxO0WGDYxKehuuBljZhw6FE1tq7t4Pr8jk38R1Ntolk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LBNyoLeS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8yjj27oa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LBNyoLeS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8yjj27oa"
Date: Wed, 18 Mar 2026 15:43:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773844986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fpam0nVd3qKW8NKIK99DOMy1zKdMjF23OnK6v22NQWA=;
	b=LBNyoLeSfuxbMp5B7K2Xr4B8h3HJe9L5LFgLxE/+TbTE+jNqDGU540v9p5ZXY+32nzm2o1
	pUlt16lHjS9M3YD482eb0Y7QiCIgTLoJBVlCYopd9XO5kIe7Q/ApnRjIJFBSDfg7VZP/yH
	PdfGLR+3mb3oUwC+hivhE48DyLNEUNHuqNGTRg2KJXLz8R4OKCgWT1SqZwWsZSYCtYB2QQ
	ywFudJV8gpTvSglhhyNcQmXSKZ7gPwm+mtUfUv2Z9VjyMcc8btUg/GqlvdLzlCUEj3GQ4u
	R1an7VUPKUsv24ulqLPQi3OPdV1Hag3Cl8QphnIP2b8SAgnSDO1tdPTKzp5L1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773844986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fpam0nVd3qKW8NKIK99DOMy1zKdMjF23OnK6v22NQWA=;
	b=8yjj27oayqIjq/z337hr9kMYIpuWFEytTZrl4FvI0IPoc7s1sUK0XPLsVTxRA24Dek9kNn
	qtB8a/olWpP89BBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <20260318144305.xI6RDtzk@linutronix.de>
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>

On 2026-03-18 04:49:52 [-0700], Paul E. McKenney wrote:
> > > Back to the actual bug, that call_srcu() now needs to tolerate being called
> > > with scheduler rq/pi locks held...
> > 
> > This is because it is called from sched_ext BPF callbacks?
> 
> You got it!  We are re-implementing Tasks Trace RCU in terms of SRCU-fast,
> and I missed this requirement the first time around.  I *did* make readers
> able to deal with BPF being invoked from everywhere, so two out of three?

right ;)

> > > The straightforward (but perhaps broken) way to resolve this is to make
> > > srcu_gp_start_if_needed() defer invoking the scheduler, similar to the
> > 
> > Quick question. If srcu_gp_start_if_needed() can be invoked from a
> > preempt-disabled section (due to rq/pi lock) then 
> > 	spin_lock_irqsave_sdp_contention(sdp, &flags);
> > 
> > does not work, right?
> 
> Agreed, which is why the patch at the end of this email converts this to:
> 
> 	raw_spin_lock_irqsave_sdp_contention(sdp, &flags)

I've seen that now. So the spinlock_t usage in SRCU was short.

> > > way that vanilla RCU's call_rcu_core() function takes an early exit if
> > > interrupts are disabled.  Of course, vanilla RCU can rely on things like
> > > the scheduling-clock interrupt to start any needed grace periods [1],
> > > but SRCU will instead need to manually defer this work, perhaps using
> > > workqueues or IRQ work.
> > > 
> > > In addition, rcutorture needs to be upgraded to sometimes invoke
> > > ->call() with the scheduler pi lock held, but this change is not fixing
> > > a regression, so could be deferred.  (There is already code in rcutorture
> > > that invokes the readers while holding a scheduler pi lock.)
> > > 
> > > Given that RCU for this week through the end of March belongs to you guys,
> > > if one of you can get this done by end of day Thursday, London time,
> > > very good!  Otherwise, I can put something together.
> > > 
> > > Please let me know!
> > 
> > Given that the current locking does allow it and lockdep should have
> > complained, I am curious if we could rule that out ;)

Your patch just s/spinlock_t/raw_spinlock_t so we get the locking/
nesting right. The wakeup problem remains, right?
But looking at the code, there is just srcu_funnel_gp_start(). If its
srcu_schedule_cbs_sdp() / queue_delayed_work() usage is always delayed
then there will be always a timer and never a direct wake up of the
worker. Wouldn't that work?

> It would be nice, but your point about needing to worry about spinlocks
> is compelling.
> 
> But couldn't lockdep scan the current task's list of held locks and see
> whether only raw spinlocks are held (including when no spinlocks of any
> type are held), and complain in that case?  Or would that scanning be
> too high of overhead?  (But we need that scan anyway to check deadlock,
> don't we?)

PeterZ didn't like it and the nesting thing identified most of the
problem cases. It should also catch _this_ one.

Thinking about it further, you don't need to worry about
local_bh_disable() but RCU will becomes another corner case. You would
have to exclude "rcu_read_lock(); spin_lock();" on a !preempt kernel
which would otherwise lead to false positives.
But as I said, this case as explained is a nesting problem and should be
reported by lockdep with its current features.

> > > 						Thanx, Paul [2]
> > > 
> > > [1] The exceptions to this rule being handled by the call to
> > >     invoke_rcu_core() when rcu_is_watching() returns false.
> > > 
> > > [2] Ah, and should vanilla RCU's call_rcu() be invokable from NMI
> > >     handlers?  Or should there be a call_rcu_nmi() for this purpose?
> > >     Or should we continue to have its callers check in_nmi() when needed?
> > 
> > Did someone ask for this?
> 
> Yes.  The BPF guys need to invoke call_srcu() from interrupts-disabled
> regions of code.  I am way to old and lazy to do this sort of thing
> spontaneously.  ;-)

IRQ disabled should work but you asked about call_rcu_nmi() and NMI is
already complicated because "most" other things don't work and you would
need irq_work to let the remaining kernel know that you did something in
NMI and this needs to be integrated now. I don't think regular RCU has
call_rcu() from NMI. But I guess wrapping it via irq_work would be one
way of dealing with it.

> 							Thanx, Paul
> 

Sebastian
