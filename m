Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAFE1885A1;
	Mon, 28 Oct 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124118; cv=none; b=rhqa4OdNaFTZ2g02u31oi8qDBFV1xa7Fmwxf7WhNrKlsLntM9KLhwBOnBv2ypK8moB78yKQDAX0uWkKub+SVKWINqAdZlQTJycxmMySWMDKOd5Scn8eTuvkskXeodmDgUelIHRJVl+YRCHbPt6iUlm5Tfz3E/12ss5ceL6s07+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124118; c=relaxed/simple;
	bh=r+tAXgNrbfhZmW4PuLb692rBzxWN1DsgXFcatraEYyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEOgP7ilZlExrdKLROlxodiBDJGNXdRIFoViwoOmS0sH4ILUCvxR1TsQXaVbrcMZoPknA6wgbTufS+wC2L1k7IbNkS3dMP9HyOPRfT6oz6ZMfvePvp1BAWXvOvTwA/9bvFrffJ+gg7o4SEmeWeE5tFcgDiJ8Piw5ABU56DfQUV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIej2On7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIej2On7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05CEC4CEC3;
	Mon, 28 Oct 2024 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730124118;
	bh=r+tAXgNrbfhZmW4PuLb692rBzxWN1DsgXFcatraEYyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RIej2On7tiF0JM3OwwuHNvqiJQy9bb1n2OGCQl6qlIo2xKy3mhGKw0J96sMyFhCqS
	 APeyCn6UlbGRfvlztP5AwWBsYwv7iAQOqKXE7rkqr0Ut/0KjSg9xI24K1N1slPZBYP
	 ZBDwPCUpndG9ksmRNWJzPiLuLVWvMB3X3sKP2mxfMFN4OlZimP9guzSaWvU6/gERss
	 aedeRKjpM0SokEWm1OEtq+0XhK2EFdhWsjjMs3AUyth6f7aSUofhVXzzVsRkC1ItMZ
	 cMgIVOiCkf63OUGlEbuct32Tz+EG8XkyLAOov6ENSNnnQbftIUeMURa7mDTmbxMlgO
	 9rENFrgW7J88A==
Date: Mon, 28 Oct 2024 15:01:55 +0100
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
Message-ID: <Zx-ZUyMLWWsxR8nL@localhost.localdomain>
References: <20241024150413.518862-1-bigeasy@linutronix.de>
 <20241024150413.518862-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024150413.518862-4-bigeasy@linutronix.de>

Le Thu, Oct 24, 2024 at 04:55:51PM +0200, Sebastian Andrzej Siewior a écrit :
> A timer/ hrtimer softirq is raised in-IRQ context. With threaded
> interrupts enabled or on PREEMPT_RT this leads to waking the ksoftirqd
> for the processing of the softirq. ksoftirqd runs as SCHED_OTHER which
> means it will compete with other tasks for CPU ressources.
> This can introduce long delays for timer processing on heavy loaded
> systems and is not desired.
> 
> Split the TIMER_SOFTIRQ and HRTIMER_SOFTIRQ processing into a dedicated
> timers thread and let it run at the lowest SCHED_FIFO priority.
> Wake-ups for RT tasks happen from hardirq context so only timer_list timers
> and hrtimers for "regular" tasks are processed here. The higher priority
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
>   local_timers_pending() for tick_nohz_next_event() ]
> 
> [ junxiao.chang@intel.com: Ensure ktimersd gets woken up even if a
>   softirq is currently served. ]
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org> [rcutorture]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Just a few nits:


> ---
>  include/linux/interrupt.h | 44 +++++++++++++++++++++++++
>  kernel/rcu/rcutorture.c   |  6 ++++
>  kernel/softirq.c          | 69 ++++++++++++++++++++++++++++++++++++++-
>  kernel/time/hrtimer.c     |  4 +--
>  kernel/time/tick-sched.c  |  2 +-
>  kernel/time/timer.c       |  2 +-
>  6 files changed, 122 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 457151f9f263d..9637af78087f3 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -616,6 +616,50 @@ extern void __raise_softirq_irqoff(unsigned int nr);
>  extern void raise_softirq_irqoff(unsigned int nr);
>  extern void raise_softirq(unsigned int nr);
>  
> +/*
> + * Handle timers in a dedicated thread at a low SCHED_FIFO priority instead in
> + * ksoftirqd as to be prefred over SCHED_NORMAL tasks.
> + */

This doesn't parse. How about, inspired by your changelog:

"""
Wake-ups for RT tasks happen from hardirq context so only timer_list timers
and hrtimers for SCHED_OTHER tasks are processed from softirq. As they are
raised from hardirq, their processing would normally happen from ksoftirqd
which runs as SCHED_OTHER and compete with other tasks. Moving timers softirqs
to a low-prio SCHED_FIFO kthread instead ensures that wakeups from timers are
performed before scheduling the target SCHED_OTHER tasks.
"""

Thanks.
