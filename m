Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF03ED123
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849893; cv=none; b=BKeFK4jxMC9crouW2dNOFbvAMfRjYi5dlBMziRTekaUdD061SyEPTysg68eJBEJNBXDfVQfO6XNcfWhRPBv0FyylyKNjqUSDUbji6yFnQ87KWjqQsLwRRIHYV8L21brf7PFiH4i+9PacCTzLJjlwfU5rM6mFYnPOsIyIaGYb758=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849893; c=relaxed/simple;
	bh=STJdjRlD6M584x+D69bzavPPJUxASA2BgMc60QOK2OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcCEej0RvpLMUQy61e679ih6pq4q1ZsEdjMTMzHpfKFf6ndTyPe8MBd9hHV2JkziUWkRAZF/8NjY1j3qnj3Va3e3Cncx6s9Wyj3x9SJXzKu9F1lw4+TMMUhbjecHvjJJzmqSUjzctlBkWxYw84507CQQZgc+mAKtyIeJjBIQrs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c9mbuxey; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c4tL1cST; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c9mbuxey";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c4tL1cST"
Date: Wed, 18 Mar 2026 17:04:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773849887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LlMYzrZdvRoR0/AqvznUYYhH4g0udySuQyJiwISinew=;
	b=c9mbuxeyFhttsQkkgWUPypiImD5uhWDl8PahCYeV20maMEm918HShOu0iCnObj2j6AxYOA
	FPUevnVk/puVG4jGYqAdc/wb7GTz9h5d9HQZaJXVswcQ/6WPDmElzMv5rLszLhVdE3Bs7u
	lqb4+OsKUnSLo9h2vGOcDoa9ZUJalJkqYMLmJlPXDPn3NK2/ctzlY5suB1hppmlBuBiJ6A
	nO4Ox3uNNUVm+vjZTS8qD0dtJC+kXG73Nhz44S+MEE3PDEKVHQJvQoeypiItJI7jXILKzU
	iQeHZpxrJ569msZwgJbmj4013uV1mNPRH32vUDJttSWwJAJ103pCJEXW8rvY3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773849887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LlMYzrZdvRoR0/AqvznUYYhH4g0udySuQyJiwISinew=;
	b=c4tL1cSTSC3E5VVr4RPzy56hEL6aM8o1xaEb1sx4HGM/Eh6lb1db1mQzUz2kITXuOoorXy
	MMOB+cG6vw7BggCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <20260318160445.IyUiWV0T@linutronix.de>
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <76ef9a5e-7343-4b8e-bf3c-cabd8753ecdb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76ef9a5e-7343-4b8e-bf3c-cabd8753ecdb@paulmck-laptop>

On 2026-03-18 08:43:32 [-0700], Paul E. McKenney wrote:
> > Your patch just s/spinlock_t/raw_spinlock_t so we get the locking/
> > nesting right. The wakeup problem remains, right?
> > But looking at the code, there is just srcu_funnel_gp_start(). If its
> > srcu_schedule_cbs_sdp() / queue_delayed_work() usage is always delayed
> > then there will be always a timer and never a direct wake up of the
> > worker. Wouldn't that work?
> 
> Right, that patch fixes one lockdep problem, but another remains.

What remains?

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
> With a raw spinlock held, agreed.
> 
> Not a big deal, just working out what to put in rcutorture to avoid
> regressions that would otherwise result in being unable to invoke
> call_srcu() from non-preemptible contexts.

Okay. So take this as _no_ more work items ;)

> > > > > 						Thanx, Paul [2]
> > > > > 
> > > > > [1] The exceptions to this rule being handled by the call to
> > > > >     invoke_rcu_core() when rcu_is_watching() returns false.
> > > > > 
> > > > > [2] Ah, and should vanilla RCU's call_rcu() be invokable from NMI
> > > > >     handlers?  Or should there be a call_rcu_nmi() for this purpose?
> > > > >     Or should we continue to have its callers check in_nmi() when needed?
> > > > 
> > > > Did someone ask for this?
> > > 
> > > Yes.  The BPF guys need to invoke call_srcu() from interrupts-disabled
> > > regions of code.  I am way to old and lazy to do this sort of thing
> > > spontaneously.  ;-)
> > 
> > IRQ disabled should work but you asked about call_rcu_nmi() and NMI is
> > already complicated because "most" other things don't work and you would
> > need irq_work to let the remaining kernel know that you did something in
> > NMI and this needs to be integrated now. I don't think regular RCU has
> > call_rcu() from NMI. But I guess wrapping it via irq_work would be one
> > way of dealing with it.
> 
> Agreed, and as long as there is only a few call_rcu() call sites within
> NMI handlers, it is best to let the caller deal with it.  But if this
> becomes popular enough, it would be better to have a call_rcu_nmi() or
> some such.

Popular? Okay. Keep me posted, please.

> 							Thanx, Paul

Sebastian
