Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4819E99B;
	Thu, 24 Oct 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778541; cv=none; b=KIQmx9wdY5dIu1jW255jrzIN6+MIZvZQJH4hWnnbnNxJ5ewHqx3/cpWRTvby6vBdJEso2pmty+zDlW5p4MoP8aNaIWjxOBjLfXs5WfXjOIdrmYQ4yFHXOkd34tfLIgBtG+ezCE+IuxAVLQlh4nxC5TUFhev8bNaG6vakXIFgnWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778541; c=relaxed/simple;
	bh=gCEb9QgeShNZCTbHKLpSf1GoiuQOCh5wnymlgnlcEYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEdMTgNoV7gB2N8nyNh4+mDSAgEF9LG+iLNo+28MVjVHeqJGKo4stsYJnk9hza1J1T/Dx+4ViRS3KCoaOJ8MwqPEs5kmbQ92GHDqx0Fx5vSUof0SLAzs292uO62tpV5XOw+mLj369f/JrlybjZ99N33Hl4o5i4mNOcHNuIrsN3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8vQTwBz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8vQTwBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108E2C4CEC7;
	Thu, 24 Oct 2024 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729778540;
	bh=gCEb9QgeShNZCTbHKLpSf1GoiuQOCh5wnymlgnlcEYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8vQTwBzZJJV+gx0VZ0YBXtwxQMugHj5Hkeaosh6u+OGmidObmyGFOvW1Rz3WJOU+
	 6YBwTjOZEg1wToQIUkE7hOmgI71HIO0u5ERGiYEDrSw8v+V+H0LDoLfhz0FgKSjYik
	 pqheGvq5voJpLwhSHGQqWCC4loYyQjxcEZ/fDp10zJ+1pIm+1tLhXYojiSxeqRBwgN
	 RoWYlg0sUScmTYidSULraxmauddTb9B4G918BY7UUXiWujAQYJC+htGF/u+3vEGsCE
	 PKTrNKbENVNM+4qSYkRCbOslGvIH+p6Rws42E3PUT5bFeCEizT9g9F9ZxaiSNkNwRp
	 +l+kQKBNyNJ8w==
Date: Thu, 24 Oct 2024 16:02:17 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] softirq: Use a dedicated thread for timer wakeups on
 PREEMPT_RT.
Message-ID: <ZxpTaXwmas8a0QuK@localhost.localdomain>
References: <20241004103842.131014-1-bigeasy@linutronix.de>
 <20241004103842.131014-2-bigeasy@linutronix.de>
 <ZxeomPnsi6oGHKPT@localhost.localdomain>
 <20241022153421.zLWiABPU@linutronix.de>
 <Zxgm1lOsddTRSToB@pavilion.home>
 <20241023063014.iPbVTkiw@linutronix.de>
 <20241023105257.3Ibh0V5d@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241023105257.3Ibh0V5d@linutronix.de>

Le Wed, Oct 23, 2024 at 12:52:57PM +0200, Sebastian Andrzej Siewior a écrit :
> On 2024-10-23 08:30:18 [+0200], To Frederic Weisbecker wrote:
> > > > > > +void raise_timer_softirq(void)
> > > > > > +{
> > > > > > +	unsigned long flags;
> > > > > > +
> > > > > > +	local_irq_save(flags);
> > > > > > +	raise_ktimers_thread(TIMER_SOFTIRQ);
> > > > > > +	wake_timersd();
> > > > > 
> > > > > This is supposed to be called from hardirq only, right?
> > > > > Can't irq_exit_rcu() take care of it? Why is it different
> > > > > from HRTIMER_SOFTIRQ ?
> > > > 
> > > > Good question. This shouldn't be any different compared to the hrtimer
> > > > case. This is only raised in hardirq, so yes, the irq_save can go away
> > > > and the wake call, too.
> > > 
> > > Cool. You can add lockdep_assert_in_irq() within raise_ktimers_thread() for
> > > some well deserved relief :-)
> > 
> > If you want to, sure. I would add them to both raise functions.
> 
> That function (run_local_timers()) was in past also called from other
> places like the APIC IRQ but all this is gone now. The reason why I
> added the wake and the local_irq_save() is because it uses
> raise_softirq() instead raise_softirq_irqoff(). And raise_softirq() was
> used since it was separated away from tasklets.
> 
> Now, raise_timer_softirq() is a function within softirq.c because it
> needs to access task_struct timersd which was only accessible there. It
> has been made public later due to the rcutorture bits so it could be
> very much be made inline and reduced to just raise_ktimers_thread().
> I tend to make TIMER_SOFTIRQ use also raise_softirq_irqoff() to make it
> look the same.

Sounds good!

> That lockdep_assert_in_irq() is probably cheap but it
> might look odd why RT needs or just TIMER and not HRTIMER.

I guess adding the same test on inline !RT functions in bottom_half.h
will be challening... Perhaps forget about that idea...

Thanks.
