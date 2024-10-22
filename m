Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449414B97E;
	Tue, 22 Oct 2024 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729636058; cv=none; b=oCM67sJoR8e4T+6Mh6Jjo06nGVq4q7k6D2LzrY0GyjRfHlhH/tuBTI3q0DmXmMFw9tbj2tvQzeumnZCBz9CA8cmi5SKWiMnbnyjUet3hu7Bb/204sP2b7blNRkaQmKiM3jYWm5dANHk7iPlwKyYOyCUO0rnXpG3FYscahiQnykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729636058; c=relaxed/simple;
	bh=KMEHB+VAFASGEyyk9QyeOHQsQn83Agc1/7pf/mwqwpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJpnuAB1BFsA1UOlZmBEzsn1WHWnW3rgOCxmwkcMhpIseuzGXGCg6sQ34IS0uede/INs9FCulaBrcASpUhw5n57V+RyGSmq3aXBph1v//A7sPLAYOKygzWYwkaHrRVKZvLPFVtbXE/VkiY1yirR4GjeMBXetNMNoyfHDaGR2KEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzIwGo5p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzIwGo5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC92C4CEC3;
	Tue, 22 Oct 2024 22:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729636058;
	bh=KMEHB+VAFASGEyyk9QyeOHQsQn83Agc1/7pf/mwqwpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzIwGo5p5IGyYqy8kn5yoPceahTY+j46Wyoy4tFLQyO6I5AGuJ4D7BHii9SswQU2C
	 Jbw5U6v8Xi+ujhbtHCStoAR/y+gqZtmN5mItP14z1UNcC9rgykl9dL3MRhnoir7Q3T
	 xJCYB3oLWLr3GIK/bF8205KW6B6Q5QDRC2UFO7YPfFOJ99paMeKiJitv8qorTMyGWa
	 6hPPcskbUeM4NYEolSqJWanMlmBGJbxCoQvJIX9XcXGfCMHk0VRpqxp5o4l8dbqt6j
	 vRwsoL3b/o87qhBdahtHJhPjV+eTcSarkGIb8vMRqKzSEewKehHSmbA7uss1uElk6Y
	 AJUdJHxeJXJ+g==
Date: Wed, 23 Oct 2024 00:27:34 +0200
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
Message-ID: <Zxgm1lOsddTRSToB@pavilion.home>
References: <20241004103842.131014-1-bigeasy@linutronix.de>
 <20241004103842.131014-2-bigeasy@linutronix.de>
 <ZxeomPnsi6oGHKPT@localhost.localdomain>
 <20241022153421.zLWiABPU@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022153421.zLWiABPU@linutronix.de>

Le Tue, Oct 22, 2024 at 05:34:21PM +0200, Sebastian Andrzej Siewior a écrit :
> On 2024-10-22 15:28:56 [+0200], Frederic Weisbecker wrote:
> > > Once the ksoftirqd is marked as pending (or is running) it will collect
> > > all raised softirqs. This in turn means that a softirq which would have
> > > been processed at the end of the threaded interrupt, which runs at an
> > > elevated priority, is now moved to ksoftirqd which runs at SCHED_OTHER
> > > priority and competes with every regular task for CPU resources.
> > 
> > But for ksoftirqd to collect other non-timers softirqs, those vectors must
> > have been raised before from a threaded interrupt, right? So why those
> > vectors didn't get a chance to execute at the end of that threaded interrupt?
> 
> This statement is no longer accurate since
> 	d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")
> 
> So the "collect all" part is no longer.
> 
> > OTOH one problem I can imagine is a threaded interrupt preempting ksoftirqd
> > which must wait for ksoftirqd to complete due to the local_bh_disable()
> > in the beginning of irq_forced_thread_fn(). But then isn't there some
> > PI involved on the local lock?
> 
> Yes, there is PI involved on the local lock. So this will happen.
> 
> > Sorry I'm probably missing something...
> 
> Try again without the "ksoftirqd will collect it all" since this won't
> happen since the revert I mentioned.

I still don't get it, this makes:

"""
Once the ksoftirqd is marked as pending (or is running), a softirq which
would have been processed at the end of the threaded interrupt, which runs
at an elevated priority, is now moved to ksoftirqd which runs at SCHED_OTHER
priority and competes with every regular task for CPU resources.
"""

ksoftirqd raised for timers still doesn't prevent a threaded IRQ from running
softirqs, unless it preempts ksoftirqd and waits with PI. So is it what you're
trying to solve?

Or is the problem that timer softirqs are executed with SCHED_NORMAL?

> 
> > > This introduces long delays on heavy loaded systems and is not desired
> > > especially if the system is not overloaded by the softirqs.
> > > 
> > > Split the TIMER_SOFTIRQ and HRTIMER_SOFTIRQ processing into a dedicated
> > > timers thread and let it run at the lowest SCHED_FIFO priority.
> > > Wake-ups for RT tasks happen from hardirq context so only timer_list timers
> > > and hrtimers for "regular" tasks are processed here.
> > 
> > That last sentence confuses me. How are timers for non regular task processed
> > elsewhere? Ah you mean RT tasks rely on hard hrtimers?
> 
> Correct. A clock_nanosleep() for a RT task will result in wake_up() from
> hardirq. A clock_nanosleep() for a !RT task will result in wake_up()
> from ksoftirqd or now the suggested ktimersd.

Oh I see now, that's all in __hrtimer_init_sleeper().

> 
> Quick question: Do we want this in forced-threaded mode, too? The timer
> (timer_list timer) and all HRTIMER_MODE_SOFT are handled in ksoftirqd.

It's hard to tell for me as I don't know the !RT usecases for forced-threaded mode.
"If in doubt say N" ;-)

> > > +#ifdef CONFIG_PREEMPT_RT
> > > +static void timersd_setup(unsigned int cpu)
> > > +{
> > 
> > That also needs a comment.
> 
> Why we want the priority I guess.

Yes.

> 
> …
> > > +void raise_hrtimer_softirq(void)
> > > +{
> > > +	raise_ktimers_thread(HRTIMER_SOFTIRQ);
> > > +}
> > > +
> > > +void raise_timer_softirq(void)
> > > +{
> > > +	unsigned long flags;
> > > +
> > > +	local_irq_save(flags);
> > > +	raise_ktimers_thread(TIMER_SOFTIRQ);
> > > +	wake_timersd();
> > 
> > This is supposed to be called from hardirq only, right?
> > Can't irq_exit_rcu() take care of it? Why is it different
> > from HRTIMER_SOFTIRQ ?
> 
> Good question. This shouldn't be any different compared to the hrtimer
> case. This is only raised in hardirq, so yes, the irq_save can go away
> and the wake call, too.

Cool. You can add lockdep_assert_in_irq() within raise_ktimers_thread() for
some well deserved relief :-)

Thanks.

> 
> > Thanks.
> 
> Sebastian
