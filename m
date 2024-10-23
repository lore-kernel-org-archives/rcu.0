Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153F27452;
	Wed, 23 Oct 2024 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665022; cv=none; b=oxMVWwzfc0Z8TsPiQkdVgLWBaQthWRz1+6fUPMpC2X2C2h8tG0Y6RR/nVuF74YycBQbwHTYswFH+fYvYolugtl5vRflm3dcD/4YIiEiXeDesQkiOy94L1kHY/fAn1LsLtkOUKbyANz2xnQRSZiz/aElOQ3GK2SiIkt4utHGBHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665022; c=relaxed/simple;
	bh=QbAEjoqqD8dE8UMerOtG1Bm+HFqOopdQDDF7NdEUrGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg8sCOdYuHBtAt8auFY3IIGjZB1AchwMs36pCWwWOAdwM1TD90HPhFgIrFI04B2oHUq5HR+YP5Zs8miBhWC4oXfWbJMnJN3i5Ex1Y0h3tzDGQNkz99x1xmFgC3zyXCpXOg/1ZHA5/cKVyZzebXLpfF9Idv95g+L1vLZeAW0Ss/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xcWORGFI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F4yZ7xhU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xcWORGFI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F4yZ7xhU"
Date: Wed, 23 Oct 2024 08:30:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729665018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SG0hzgWLDBlj5RPqIAz1xu2cvOfX0z+VKLYeMfLojgQ=;
	b=xcWORGFIEu2lH/Nye0BrdvtKKYeIGctLuzpzCfSfM/z9/0gt1wEvGqahC4Lmli0LDWmiS2
	y3WrrumwD4i997JS45v9xs7VClXp4we684jlgla0hrR2w3tmlJRZbAuJxabBPaym0x5lXP
	7dYSXLXUBwJP7W1jVkDeHiK7Gw5DH3tZ5fAnGVK0mWKBEaEh6c3I5N8BA0nsDErIMFBow7
	s6gzadc95YEdz5jv6eKVFAiWv71jNnSmILnmXxQViyFC60y90IQ9EmAPxlwJpaT23z/KHt
	ucEiSX4d0v6ZwE8Q2ZbpZueaJ37ACMBrjGSRe29gcTN1OMfb2HHc6WzTcvGjtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729665018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SG0hzgWLDBlj5RPqIAz1xu2cvOfX0z+VKLYeMfLojgQ=;
	b=F4yZ7xhUOQEncSFvwzGtM35y4gQugJVAEQILjcNdSJ9cn8BAeKXsP00QPfdRgsDHwjRQar
	J0T23k3OUo/gQ2AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] softirq: Use a dedicated thread for timer wakeups on
 PREEMPT_RT.
Message-ID: <20241023063014.iPbVTkiw@linutronix.de>
References: <20241004103842.131014-1-bigeasy@linutronix.de>
 <20241004103842.131014-2-bigeasy@linutronix.de>
 <ZxeomPnsi6oGHKPT@localhost.localdomain>
 <20241022153421.zLWiABPU@linutronix.de>
 <Zxgm1lOsddTRSToB@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zxgm1lOsddTRSToB@pavilion.home>

On 2024-10-23 00:27:34 [+0200], Frederic Weisbecker wrote:
> > Try again without the "ksoftirqd will collect it all" since this won't
> > happen since the revert I mentioned.
> 
> I still don't get it, this makes:
> 
> """
> Once the ksoftirqd is marked as pending (or is running), a softirq which
> would have been processed at the end of the threaded interrupt, which runs
> at an elevated priority, is now moved to ksoftirqd which runs at SCHED_OTHER
> priority and competes with every regular task for CPU resources.
> """
> 
> ksoftirqd raised for timers still doesn't prevent a threaded IRQ from running
> softirqs, unless it preempts ksoftirqd and waits with PI. So is it what you're
> trying to solve?
> 
> Or is the problem that timer softirqs are executed with SCHED_NORMAL?

Exactly. It runs at SCHED_NORMAL and competes with everything else. It
can delay tasks wakes depending on system load.

> > Quick question: Do we want this in forced-threaded mode, too? The timer
> > (timer_list timer) and all HRTIMER_MODE_SOFT are handled in ksoftirqd.
> 
> It's hard to tell for me as I don't know the !RT usecases for forced-threaded mode.
> "If in doubt say N" ;-)

Oki.

> > > > +void raise_timer_softirq(void)
> > > > +{
> > > > +	unsigned long flags;
> > > > +
> > > > +	local_irq_save(flags);
> > > > +	raise_ktimers_thread(TIMER_SOFTIRQ);
> > > > +	wake_timersd();
> > > 
> > > This is supposed to be called from hardirq only, right?
> > > Can't irq_exit_rcu() take care of it? Why is it different
> > > from HRTIMER_SOFTIRQ ?
> > 
> > Good question. This shouldn't be any different compared to the hrtimer
> > case. This is only raised in hardirq, so yes, the irq_save can go away
> > and the wake call, too.
> 
> Cool. You can add lockdep_assert_in_irq() within raise_ktimers_thread() for
> some well deserved relief :-)

If you want to, sure. I would add them to both raise functions.

> Thanks.

Sebastian
