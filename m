Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3EE1537D9;
	Tue, 22 Oct 2024 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603740; cv=none; b=Ejx+nmdsWlNars7eHEBRaAX3ovNHFQXhvFJa7YWCPCgCRaPyj6wAFTtHEEVMobtOHfmvvX1ygyRSVXLHDIWT/U1v+Y/iaKoBmEvjUzx6vhD0y+gLsNfPPdZQXb+JAvgB79/X4XR+oN1bSKTbH0ApGXGEJPwXJdCuBikVdW0m7ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603740; c=relaxed/simple;
	bh=8nd1c4//eMXRbs/k0wkH44JygPUzZ9W7NiVGYqdCGxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB0i5MF0jrgIT0EWc+s3u+VR7nSkI7jOPLuwZ+i3D4bOK9WsZt36z8a37eOI8dD9hnwbGTHiHS/9qnxEhkzCmhSjG1m52dmSSKdbqsv4HvyFPyrRPJd37SgYtbQk9pJJEDT3cCZhjJK9Hw7q9MdXuTxhExh5NfaqyzYvmlMDc2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSf9I5Tk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSf9I5Tk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F69AC4CEC3;
	Tue, 22 Oct 2024 13:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729603739;
	bh=8nd1c4//eMXRbs/k0wkH44JygPUzZ9W7NiVGYqdCGxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSf9I5TkHcJr4WiGwZV4Xmq8BtBnE+j17nvX6qn4EO0JYq17RN7+ppcp81J4fJtUU
	 267NhGEFuq2gFRu61VQeV39IWJ2wGno8KAe1LpLDT//IVaroCpVb8A1uWymRri4LX6
	 +bn9ZJQbWlU9Y4Zhs/VzPeIg7n/KmNs8UXpy9rFjn9BKiOIeq6c4bhaP6bWvOnbkFH
	 ePZu9DzeYSXz4qv/+Ab6pHQopB4uoZ782rygXWrH9JMSRQBsncVtdN2qBPaGK/3Bhy
	 9iTnaCSlpV+BLaiEbQfGRvY6a3jNEF8W3yAuywpauTm/kIKY7DkcAanWxoJBzbb94d
	 s17+qRyQPFkcg==
Date: Tue, 22 Oct 2024 15:28:56 +0200
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
Message-ID: <ZxeomPnsi6oGHKPT@localhost.localdomain>
References: <20241004103842.131014-1-bigeasy@linutronix.de>
 <20241004103842.131014-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004103842.131014-2-bigeasy@linutronix.de>

Le Fri, Oct 04, 2024 at 12:17:04PM +0200, Sebastian Andrzej Siewior a écrit :
> A timer/ hrtimer softirq is raised in-IRQ context. With threaded
> interrupts enabled or on PREEMPT_RT this leads to waking the ksoftirqd
> for the processing of the softirq.

It took me some time to understand the actual problem (yeah I know...)

Can this be rephrased as: "Timer and hrtimer softirq vectors are special
in that they are always raised in-IRQ context whereas other vectors are
more likely to be raised from threaded interrupts or any regular tasks
when threaded interrupts or PREEMPT_RT are enabled. This leads to
waking ksoftirqd for the processing of the softirqs whenever timer
vectors are involved.

>
> Once the ksoftirqd is marked as pending (or is running) it will collect
> all raised softirqs. This in turn means that a softirq which would have
> been processed at the end of the threaded interrupt, which runs at an
> elevated priority, is now moved to ksoftirqd which runs at SCHED_OTHER
> priority and competes with every regular task for CPU resources.

But for ksoftirqd to collect other non-timers softirqs, those vectors must
have been raised before from a threaded interrupt, right? So why those
vectors didn't get a chance to execute at the end of that threaded interrupt?

OTOH one problem I can imagine is a threaded interrupt preempting ksoftirqd
which must wait for ksoftirqd to complete due to the local_bh_disable()
in the beginning of irq_forced_thread_fn(). But then isn't there some
PI involved on the local lock?

Sorry I'm probably missing something...

>
> This introduces long delays on heavy loaded systems and is not desired
> especially if the system is not overloaded by the softirqs.
> 
> Split the TIMER_SOFTIRQ and HRTIMER_SOFTIRQ processing into a dedicated
> timers thread and let it run at the lowest SCHED_FIFO priority.
> Wake-ups for RT tasks happen from hardirq context so only timer_list timers
> and hrtimers for "regular" tasks are processed here.

That last sentence confuses me. How are timers for non regular task processed
elsewhere? Ah you mean RT tasks rely on hard hrtimers?

> The higher priority
> ensures that wakeups are performed before scheduling SCHED_OTHER tasks.
> 
> Using a dedicated variable to store the pending softirq bits values
> ensure that the timer are not accidentally picked up by ksoftirqd and
> other threaded interrupts.
> It shouldn't be picked up by ksoftirqd since it runs at lower priority.
> However if ksoftirqd is already running while a timer fires, then
> ksoftird will be PI-boosted due to the BH-lock to ktimer's priority.
> Ideally we try to avoid having ksoftirqd running.
> 
> The timer thread can pick up pending softirqs from ksoftirqd but only
> if the softirq load is high. It is not be desired that the picked up
> softirqs are processed at SCHED_FIFO priority under high softirq load
> but this can already happen by a PI-boost by a force-threaded interrupt.
> 
> [ frederic@kernel.org: rcutorture.c fixes, storm fix by introduction of
>   local_pending_timers() for tick_nohz_next_event() ]
> 
> [ junxiao.chang@intel.com: Ensure ktimersd gets woken up even if a
>   softirq is currently served. ]
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/interrupt.h | 29 ++++++++++++++
>  kernel/rcu/rcutorture.c   |  6 +++
>  kernel/softirq.c          | 82 ++++++++++++++++++++++++++++++++++++++-
>  kernel/time/hrtimer.c     |  4 +-
>  kernel/time/tick-sched.c  |  2 +-
>  kernel/time/timer.c       |  2 +-
>  6 files changed, 120 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 457151f9f263d..4a4f367cd6864 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -616,6 +616,35 @@ extern void __raise_softirq_irqoff(unsigned int nr);
>  extern void raise_softirq_irqoff(unsigned int nr);
>  extern void raise_softirq(unsigned int nr);
>  
> +#ifdef CONFIG_PREEMPT_RT

This needs a comment section to explain why a dedicated
timers processing is needed.

> +DECLARE_PER_CPU(struct task_struct *, timersd);
> +DECLARE_PER_CPU(unsigned long, pending_timer_softirq);
> +
> +extern void raise_timer_softirq(void);
> +extern void raise_hrtimer_softirq(void);
> +
> +static inline unsigned int local_pending_timers(void)

Let's align with local_softirq_pending() naming and rather
have local_timers_pending() ?

> +{
> +	return __this_cpu_read(pending_timer_softirq);
> +}
> +
> +#ifdef CONFIG_PREEMPT_RT
> +static void timersd_setup(unsigned int cpu)
> +{

That also needs a comment.

> +	sched_set_fifo_low(current);
> +}
> +
> +static int timersd_should_run(unsigned int cpu)
> +{
> +	return local_pending_timers();
> +}
> +
> +static void run_timersd(unsigned int cpu)
> +{
> +	unsigned int timer_si;
> +
> +	ksoftirqd_run_begin();
> +
> +	timer_si = local_pending_timers();
> +	__this_cpu_write(pending_timer_softirq, 0);
> +	or_softirq_pending(timer_si);
> +
> +	__do_softirq();
> +
> +	ksoftirqd_run_end();
> +}
> +
> +static void raise_ktimers_thread(unsigned int nr)
> +{
> +	trace_softirq_raise(nr);
> +	__this_cpu_or(pending_timer_softirq, 1 << nr);
> +}
> +
> +void raise_hrtimer_softirq(void)
> +{
> +	raise_ktimers_thread(HRTIMER_SOFTIRQ);
> +}
> +
> +void raise_timer_softirq(void)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	raise_ktimers_thread(TIMER_SOFTIRQ);
> +	wake_timersd();

This is supposed to be called from hardirq only, right?
Can't irq_exit_rcu() take care of it? Why is it different
from HRTIMER_SOFTIRQ ?

Thanks.
