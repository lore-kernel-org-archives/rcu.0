Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CBD206E92;
	Tue, 29 Oct 2024 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730238445; cv=none; b=eIArm1/qQu6+q/wOUIDIZLNWS7HQG6rHiClg7YRXqN0PGbEcvOVp2Il0xnZ/aItdUJUVSuL/7Oo3Iwr4JOUXHvRDw/+XKuuKbQAyiNPiGPHPlAmVm6pnBd7FY3IKCv/2Tyds3F4OwUs2rKPH5i0nMHmDjFO3GLfo+psOXw7Uies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730238445; c=relaxed/simple;
	bh=N/kzGiFtxEdxXOYyFslD837ahNcfx1xVOpoWS6w0INc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNWiCTaE6FWfUgEouzA1wBJItxLDIly7fDi5q0sn9t6OOv3JKHmlgUvLHS+Ag1j4Mue1jAOh+OQAW0cHmHmzrvxckWJpu8wDkguHUKoKIQLBVt3O5dH2CWY18T1+cbgVkuOANanXCKKcy6j/0W6+DXOMnnBnZooxxhoElvkUTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZWBsiSd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZWBsiSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A6BC4CEE3;
	Tue, 29 Oct 2024 21:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730238444;
	bh=N/kzGiFtxEdxXOYyFslD837ahNcfx1xVOpoWS6w0INc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZWBsiSdFfCITzDSBAT5tYWbfKWs6sRdxS1ASP/sAQYP7B9C4ZLV+ipSGyxvCFBM0
	 U0AtVVh9MMM/YWGoiJyZ276u1faE4BxgojC6LxcVzcAXYXIrgreiUuJlCnwOD/Z1gG
	 Sc8SUCcjD37yXa8DAvEkxKCi5WqTm4op+C1si98zIECewuKJMgJgpfH2oRLqzs44jX
	 Yw13iWXCnQAdut7fjMUEvNpjK+mD+LCMFns4yo/UKdcQnf9LUOhkkoobSCogiTx/D+
	 jwx5B6WuyE8zFSZCRqP+BqTCEePsMhoUiq6TEnsMTdgoHBXC7YiodURouDUHot94zM
	 Bg6CpryzuxD4g==
Date: Tue, 29 Oct 2024 22:47:21 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 3/3] softirq: Use a dedicated thread for timer wakeups
 on PREEMPT_RT.
Message-ID: <ZyFX6R_7HptXRdsK@pavilion.home>
References: <20241024150413.518862-1-bigeasy@linutronix.de>
 <20241024150413.518862-4-bigeasy@linutronix.de>
 <Zx-ZUyMLWWsxR8nL@localhost.localdomain>
 <20241029135231.ScfxKhz1@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029135231.ScfxKhz1@linutronix.de>

Le Tue, Oct 29, 2024 at 02:52:31PM +0100, Sebastian Andrzej Siewior a écrit :
> On 2024-10-28 15:01:55 [+0100], Frederic Weisbecker wrote:
> > > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> > > index 457151f9f263d..9637af78087f3 100644
> > > --- a/include/linux/interrupt.h
> > > +++ b/include/linux/interrupt.h
> > > @@ -616,6 +616,50 @@ extern void __raise_softirq_irqoff(unsigned int nr);
> > >  extern void raise_softirq_irqoff(unsigned int nr);
> > >  extern void raise_softirq(unsigned int nr);
> > >  
> > > +/*
> > > + * Handle timers in a dedicated thread at a low SCHED_FIFO priority instead in
> > > + * ksoftirqd as to be prefred over SCHED_NORMAL tasks.
> > > + */
> > 
> > This doesn't parse. How about, inspired by your changelog:
> …
> 
> What about this essay instead:
> 
> | With forced-threaded interrupts enabled a raised softirq is deferred to
> | ksoftirqd unless it can be handled within the threaded interrupt. This
> | affects timer_list timers and hrtimers which are explicitly marked with
> | HRTIMER_MODE_SOFT.
> | With PREEMPT_RT enabled more hrtimers are moved to softirq for processing
> | which includes all timers which are not explicitly marked HRTIMER_MODE_HARD.
> | Userspace controlled timers (like the clock_nanosleep() interface) is divided
> | into two categories: Tasks with elevated scheduling policy including
> | SCHED_{FIFO|RR|DL} and the remaining scheduling policy. The tasks with the
> | elevated scheduling policy are woken up directly from the HARDIRQ while all
> | other wake ups are delayed to so softirq and so to ksoftirqd.

First "so" is intended?

> |
> | The ksoftirqd runs at SCHED_OTHER policy at which it should remain since it
> | handles the softirq in an overloaded situation (not handled everything
> | within its last run).
> | If the timers are handled at SCHED_OTHER priority then they competes with all
> | other SCHED_OTHER tasks for CPU resources are possibly delayed.
> | Moving timers softirqs to a low priority SCHED_FIFO thread instead ensures
> | that timer are performed before scheduling any SCHED_OTHER thread.

Works for me!

> And with this piece of text I convinced myself to also enable this in
> the forced-threaded case.

Yes, that makes sense.

Thanks.

> > Thanks.
> 
> Sebastian
