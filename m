Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A819F128;
	Wed, 23 Oct 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680787; cv=none; b=Sws0YIxJ7cQHzwOM/09XMNDsjVEXKuGE7GTKpP9vh9acnOK4YrHUlY+A3STNd/jbeCaTf7bH8OLCNwlPrYrMdq0AVHHXMJ9LN6WmeIkNC0i9HhtapXgtmhq58IaxOcskNMdUTyOAacPHvnXp1IAENboNHfmUI34oMkD1UNpx+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680787; c=relaxed/simple;
	bh=AAU8KRcl96ThA1amDDhZN1F5mt06VT7Cl0E97kVyZj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3lHUaX1yCo6uwdzgiKwz0IA/iaohS2Yxr12bmhAVDYR60flnvwJzo+yTxsU9QSkWYnssFyRM9WuUxJEVoKthQhn7GBxx5jAtBrE+ZiCuAYUXsBEGwv41EhtiyR7oYbmQdxdILIRD8Nb6uCeg6h2JRYyTe52ManLvMBc8ZNXxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YA8Vt+oL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=asvjDthV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YA8Vt+oL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="asvjDthV"
Date: Wed, 23 Oct 2024 12:52:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729680778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z5cYhVPG6B3EdAF5puQribkhOVErnOJ3c7NZLJS9l04=;
	b=YA8Vt+oL+RV6h2mGuBhreZBvqzFhkzz4nEoEp4cPCS7eSSygxU9suv43i+NTUKhUQLGWaZ
	cjGlOVedOTgcZKaXVRZ1LKk7RjfghQ3CF174m/uh9Rv0rvVAKDs6dIQEg04pwECDKbWjL2
	CppRZjUusUvBec7k/W2gVD8FXO66/umBabozu2JUpMBzl2GtP5EXMDJNQoXfZ813FjgZSk
	VPc/yZmw6pxT4MIi34rZbc+Ve+8W/mfbGqx6kEoTvrgZ4G6LAVXU/wOjMh2LgA3BVzBPiU
	/XORfIk3BM10MKLrknVT/caRlAN5xm2cfL3HIQuzTPETrfqBxgI3aVjMIU4j6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729680778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z5cYhVPG6B3EdAF5puQribkhOVErnOJ3c7NZLJS9l04=;
	b=asvjDthVa95B3RC3XCKFPW3PyNpLKFJEQuM4kq39EC7Xg469qTCOKLG1QzBlEBk4HZY2LK
	bR4mufrbgSy+eJAw==
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
Message-ID: <20241023105257.3Ibh0V5d@linutronix.de>
References: <20241004103842.131014-1-bigeasy@linutronix.de>
 <20241004103842.131014-2-bigeasy@linutronix.de>
 <ZxeomPnsi6oGHKPT@localhost.localdomain>
 <20241022153421.zLWiABPU@linutronix.de>
 <Zxgm1lOsddTRSToB@pavilion.home>
 <20241023063014.iPbVTkiw@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023063014.iPbVTkiw@linutronix.de>

On 2024-10-23 08:30:18 [+0200], To Frederic Weisbecker wrote:
> > > > > +void raise_timer_softirq(void)
> > > > > +{
> > > > > +	unsigned long flags;
> > > > > +
> > > > > +	local_irq_save(flags);
> > > > > +	raise_ktimers_thread(TIMER_SOFTIRQ);
> > > > > +	wake_timersd();
> > > > 
> > > > This is supposed to be called from hardirq only, right?
> > > > Can't irq_exit_rcu() take care of it? Why is it different
> > > > from HRTIMER_SOFTIRQ ?
> > > 
> > > Good question. This shouldn't be any different compared to the hrtimer
> > > case. This is only raised in hardirq, so yes, the irq_save can go away
> > > and the wake call, too.
> > 
> > Cool. You can add lockdep_assert_in_irq() within raise_ktimers_thread() for
> > some well deserved relief :-)
> 
> If you want to, sure. I would add them to both raise functions.

That function (run_local_timers()) was in past also called from other
places like the APIC IRQ but all this is gone now. The reason why I
added the wake and the local_irq_save() is because it uses
raise_softirq() instead raise_softirq_irqoff(). And raise_softirq() was
used since it was separated away from tasklets.

Now, raise_timer_softirq() is a function within softirq.c because it
needs to access task_struct timersd which was only accessible there. It
has been made public later due to the rcutorture bits so it could be
very much be made inline and reduced to just raise_ktimers_thread().
I tend to make TIMER_SOFTIRQ use also raise_softirq_irqoff() to make it
look the same. That lockdep_assert_in_irq() is probably cheap but it
might look odd why RT needs or just TIMER and not HRTIMER.

> > Thanks.

Sebastian
