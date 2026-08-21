Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8572F39B8
	for <rcu@vger.kernel.org>; Fri, 21 Aug 2026 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310072; cv=none; b=JXff5FJcoBhLmaNfoYATxz4O0gU5rhM/+i+ET/cmnu+YftPxmIlnDt0NGP9uh500B3qSIpwTzV6oZVYWDcJoyP/pX9WxWiCoLpq8z59tLuUEYgxFzBneD9Qg07fPphuClOAtenq5C03KnhQjAUYBr1GZO2f+Fp3E7DCG4tCsKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310072; c=relaxed/simple;
	bh=7l/sFVSaV78o4552sO1Ae7Z08wWDy4s5ylXSMQZsmAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mzo5eo/9Ri4RGBGNQu5uj8L77qzVHnDyKcblsFuBOMZSCP6cgirsQBvWLtW8TBOluGrQWbhOjA43z7wChjayiB1EpElQJnlKG97zwDqRwIbsY5DFPEcX2qfwZHOodAIp5UrN6q8bilWiy7lvnjA2FwYdDvze0DX3dk+bqATXsQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=buXxuxET; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7qJux9Ad; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="buXxuxET";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7qJux9Ad"
Date: Fri, 21 Aug 2026 13:01:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787310069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2UdDps+h2roHsawrcojpNwHjPMhgMt+pmiwEKjvji0=;
	b=buXxuxETPdk/0rmFOiUxNX0wzGd8Zr+yfLZImqCjUqfU8JxSNWR9X7YHD1MQQ8vpGTN7hA
	FkoREaEB0MPCStHDsqBFHUlmcvxEAgUctwqipoJ6Irc+1ZdlBgjag3FGWI44EYWyJjRQSc
	FlnCDM0fnx8tep1IsIEFd4LOq0LxyUog3GkotzA6sNVBrJykXFYvBJLaRqTSQYTqLRBPcM
	su80VwQTw3OqjtnqMTvL3p0qyJ30VTqh94HpQ7MP6Y71wMO/UBrEq3u/5cnzmquhYhCZmM
	X4Ywb31nXtKfFH5qDkq/EHRYWsss9c5u1scMYbFfSKELRcUmnabnirsHFoBgRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787310069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2UdDps+h2roHsawrcojpNwHjPMhgMt+pmiwEKjvji0=;
	b=7qJux9AdMl0IXf/O7Hv5y+h8F6Q4iD8TUE3/x8ZkXd2Q3JYIIGl4FgnNhpJ291+rSVpZ3C
	yxGiPSm4sDevhQDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH] rcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
Message-ID: <20260821110108.kAu0wszk@linutronix.de>
References: <20260820110008.v2Tlr0_H@linutronix.de>
 <aob12RahomSmpUQY@localhost.localdomain>
 <20260820135500.hXUAsbHR@linutronix.de>
 <20260820130028.2243d53c@fedora>
 <20260821100431.jvWas8Wc@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821100431.jvWas8Wc@linutronix.de>

On 2026-08-21 12:04:31 [+0200], To Steven Rostedt wrote:
> On 2026-08-20 13:00:28 [-0400], Steven Rostedt wrote:
> > On Thu, 20 Aug 2026 15:55:00 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > 
> > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > index 7c2f7cc131f7a..b703233d4a63f 100644
> > > > > --- a/kernel/rcu/srcutree.c
> > > > > +++ b/kernel/rcu/srcutree.c
> > > > > @@ -218,7 +218,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> > > > >  	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
> > > > >  	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
> > > > >  	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
> > > > > -	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
> > > > > +	ssp->srcu_sup->irq_work = IRQ_WORK_INIT_HARD(srcu_irq_work);  
> > > > 
> > > > It may need a comment to not lose that.  
> > 
> > I agree a comment would be useful here.
> Urgh.

What do you want me to cover in the comment? The arguing pro
IRQ_WORK_INIT_HARD is because it is "just" a workqueue schedule and it
avoids the jump over irq_work/ thread. This makes sense regardless of
the tracing issue.
If it would be not compatible with hard-irq context I would argue for
the makefile change which is still sane since there is no other way to
express dependencies (which we clearly have here).

Sebastian
