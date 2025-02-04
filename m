Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A592C181;
	Tue,  4 Feb 2025 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686854; cv=none; b=NhQCjGagG+L2S6FNXpzLtirWXMVDuxiu8dlzxvmTIFMBcXYPPutpDDEcmvY2F+ssJ0q99dM+VdVJzXZs3EwXLPy/fJUBjDK8UOOWg9nwy7uWyS1HJKuz+SRoUdWaqTw+x9z1bJ3EHuIjxKsRIfJ6N8vB27zX35PyCkwndayO7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686854; c=relaxed/simple;
	bh=8wM8PxwKt5hE+jlTkkgMtUmjK9tWRW7I0AK5GtpiFs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAsy9KBtyxCeUO+HMR7Bqy8hcUojopPcRNrGC4I5O/hvhofOudVD/ouL6dE5DGHbVE2zyNPTbpksfKSzdFfjfYYFCyhq6gsDiiWfptPgKg23ppN09FsgCFRITusOBjBimLUQ0ylfflO5A2voPgUBPAy4hztmKxASOHy++tBO/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IcVKUsUX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=63JlAPBo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IcVKUsUX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="63JlAPBo"
Date: Tue, 4 Feb 2025 17:34:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738686850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8HGciwVaWiFVnQeEkwNMUZx49RscaD3a80RktSJSXkg=;
	b=IcVKUsUXDca+vxSShEkbfSeIlMQVyGINIw5msWzlyTFIvAUGNGdWzH02CyZL0l10VjWSRo
	fQXc5uLPJRSiPaYhY5Y4bpHxHjHeJdQ4/1kx8UhoYQ6I2MaaTIycOXF1la7sQB9BAj1dDB
	6rB0SAuF/3j//N5fblYrYlWRU0cBrKo5YbeADEw8huQMsIjDmHHjNCV/D71uqcxfGo4hrv
	qbnPAbriEAc/kt2zMKGXbfX12hE3S1bzgk7YN++uF+SBOhepcpd3owhOUioWVAmOM2g0VY
	UkUw5TaYDoAP3O9V7xDrXfk5jsM+4SfqcoroW4ASmE+94ryiHAfIdyj7R7XdlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738686850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8HGciwVaWiFVnQeEkwNMUZx49RscaD3a80RktSJSXkg=;
	b=63JlAPBoJsCVTNn1j7wtylBauOQjPgAbpLfGlp9g4ZPcoZ/gSJLTkahj1+/hWT4PNTn25m
	5PanF0lpkX8P1bDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
Message-ID: <20250204163409.ueObHFje@linutronix.de>
References: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
 <20250130185320.1651910-4-paulmck@kernel.org>
 <20250204102611.OVuHn9rS@linutronix.de>
 <ff2ed5ba-52f4-4e82-ac0c-6e6a7013d86e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff2ed5ba-52f4-4e82-ac0c-6e6a7013d86e@paulmck-laptop>

On 2025-02-04 03:51:48 [-0800], Paul E. McKenney wrote:
> On Tue, Feb 04, 2025 at 11:26:11AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-01-30 10:53:19 [-0800], Paul E. McKenney wrote:
> > > The timer and hrtimer softirq processing has moved to dedicated threads
> > > for kernels built with CONFIG_IRQ_FORCED_THREADING=y.  This results in
> > > timers not expiring until later in early boot, which in turn causes the
> > > RCU Tasks self-tests to hang in kernels built with CONFIG_PROVE_RCU=y,
> > > which further causes the entire kernel to hang.  One fix would be to
> > > make timers work during this time, but there are no known users of RCU
> > > Tasks grace periods during that time, so no justification for the added
> > > complexity.  Not yet, anyway.
> > > 
> > > This commit therefore moves the call to rcu_init_tasks_generic() from
> > > kernel_init_freeable() to a core_initcall().  This works because the
> > > timer and hrtimer kthreads are created at early_initcall() time.
> > 
> > Fixes: 49a17639508c3 ("softirq: Use a dedicated thread for timer wakeups on PREEMPT_RT.")
> > ?
> 
> Quite possibly...  I freely confess that I was more focused on the fix
> than on the bug's origin.  Would you be willing to try this commit and
> its predecessor?

Yes. Just verified.
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> > I played with it and I can reproduce the issue with !RT + threadirqs but
> > not with RT (which implies threadirqs).
> > Is there anything in RT that avoids the problem?
> 
> Not that I know of, but then again I did not try it.  To your point,

The change looks fine.

> I do need to make a -rt rcutorture scenario.  TREE03 has been intended to
> approximate this, and it uses the following Kconfig options:
> 
> ------------------------------------------------------------------------
> 
> CONFIG_SMP=y
> CONFIG_NR_CPUS=16
> CONFIG_PREEMPT_NONE=n
> CONFIG_PREEMPT_VOLUNTARY=n
> CONFIG_PREEMPT=y
> #CHECK#CONFIG_PREEMPT_RCU=y
> CONFIG_HZ_PERIODIC=y
> CONFIG_NO_HZ_IDLE=n
> CONFIG_NO_HZ_FULL=n
> CONFIG_RCU_TRACE=y
> CONFIG_HOTPLUG_CPU=y
> CONFIG_RCU_FANOUT=2
> CONFIG_RCU_FANOUT_LEAF=2
> CONFIG_RCU_NOCB_CPU=n
> CONFIG_DEBUG_LOCK_ALLOC=n
> CONFIG_RCU_BOOST=y
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> CONFIG_RCU_EXPERT=y

You could enable CONFIG_PREEMPT_RT ;)
CONFIG_PREEMPT_LAZY is probably also set a lot.

That should be it.

> ------------------------------------------------------------------------
> 
> And the following kernel-boot parameters:
> 
> ------------------------------------------------------------------------
> 
> rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30
> rcutree.gp_preinit_delay=12
> rcutree.gp_init_delay=3
> rcutree.gp_cleanup_delay=3
> rcutree.kthread_prio=2
> threadirqs
> rcutree.use_softirq=0
> rcutorture.preempt_duration=10
> 
> ------------------------------------------------------------------------
> 
> Some of these are for RCU's benefit, but what should I change to more
> closely approximate a typical real-time deployment?

See above.

> > Thank you for debugging and the patch. 
> 
> And to you for digging into it!

Thanks.

> 							Thanx, Paul

Sebastian
