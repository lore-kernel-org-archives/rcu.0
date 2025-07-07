Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4716DEB3;
	Mon,  7 Jul 2025 21:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751925375; cv=none; b=A/SRVNs5UjdaMgXsIDQ0rxw8paev2ZZouv/BQroxEWcFiEGZrWL1K3gCgItG3floycXxsXn4Vl4RYkphh3n48gXIiEUjhs80QKgrQYbiVzgu9sBFWnzFZC1I+pbcs91outykCWoD1E2TrVBUED+rZFB3fcxK3onMWhTmAkM4zQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751925375; c=relaxed/simple;
	bh=SN7gE7wv44HsOXYJxG4NYhkPrK17oXrOVljL+MEmuDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOgNHTi658XoCz69FesYftqPLrq1gSA0Sp9XhWk5ubP6jmT+AwF918HuwyAgL+F8AZePsAKlVeb+zWxDfKQmrn/7i0Qs8/HUE0c7/vBuJHDDDgs+MwD1W0aTZz70HUHQGNlzNzXVuCtpH9BYPtWzpnkVGDPxylkcNo1jGFtA9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euzUwa+h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euzUwa+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C25C4CEE3;
	Mon,  7 Jul 2025 21:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751925374;
	bh=SN7gE7wv44HsOXYJxG4NYhkPrK17oXrOVljL+MEmuDw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=euzUwa+hWzgM2vB6hlO5Ds4h8txZL0Ee+YHbwT6jEx3xE7NwaoevERCfTSnIRcvNf
	 Z77BTpGPEhXKQSJRY7EESiXdvGQPSn5Yt0E1766VwQJ0fG2w8gdqdvEIYT9Gg6SpfV
	 ggrv2/s86HLFP3cj8zq2RVcnPN/+b+RfWXJgHnF9BBFsX0Y+N3Z897M7/w2n5WSiSO
	 ZWOqQe6Z4ISu2VVsLuSokujES01RBrTYKlSXv3/9wmWjUKYOKouC88xufDNgyg5wNY
	 T5Gpt20kgvnmWiy6uvqZo1j8C/PaEHbCWqCZpScacvMXHLyg3B8+QZaAcIAaVijxea
	 KjPk8Nr1qqclA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3E7DCCE0E61; Mon,  7 Jul 2025 14:56:14 -0700 (PDT)
Date: Mon, 7 Jul 2025 14:56:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250613152218.1924093-1-bigeasy@linutronix.de>
 <20250613152218.1924093-2-bigeasy@linutronix.de>
 <aFL1pIGMDX5DG9f_@tardis.local>
 <20250620084334.Zb8O2SwS@linutronix.de>
 <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
 <20250623104941.WxOQtAmV@linutronix.de>
 <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>

On Mon, Jun 23, 2025 at 11:13:03AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 23, 2025 at 12:49:41PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-06-20 04:23:49 [-0700], Paul E. McKenney wrote:
> > > > I hope not because it is not any different from
> > > > 
> > > >  	CPU 2			CPU 3
> > > >  	=====                   =====
> > > > 	NMI
> > > >  	rcu_read_lock();
> > > >  				synchronize_rcu();
> > > >  				// need all CPUs report a QS.
> > > >  	rcu_read_unlock();
> > > >  	// no rcu_read_unlock_special() due to in_nmi().
> > > > 
> > > > If the NMI happens while the CPU is in userland (say a perf event) then
> > > > the NMI returns directly to userland.
> > > > After the tracing event completes (in this case) the CPU should run into
> > > > another RCU section on its way out via context switch or the tick
> > > > interrupt.
> > > > I assume the tick interrupt is what makes the NMI case work.
> > > 
> > > Are you promising that interrupts will be always be disabled across
> > > the whole rcu_read_lock_notrace() read-side critical section?  If so,
> > > could we please have a lockdep_assert_irqs_disabled() call to check that?
> > 
> > No, that should stay preemptible because bpf can attach itself to
> > tracepoints and this is the root cause of the exercise. Now if you say
> > it has to be run with disabled interrupts to match the NMI case then it
> > makes sense (since NMIs have interrupts off) but I do not understand why
> > it matters here (since the CPU returns to userland without passing the
> > kernel).
> 
> Given your patch, if you don't disable interrupts in a preemptible kernel
> across your rcu_read_lock_notrace()/rcu_read_unlock_notrace() pair, then a
> concurrent expedited grace period might send its IPI in the middle of that
> critical section.  That IPI handler would set up state so that the next
> rcu_preempt_deferred_qs_irqrestore() would report the quiescent state.
> Except that without the call to rcu_read_unlock_special(), there might
> not be any subsequent call to rcu_preempt_deferred_qs_irqrestore().
> 
> This is even more painful if this is a CONFIG_PREEMPT_RT kernel.
> Then if that critical section was preempted and then priority-boosted,
> the unboosting also won't happen until the next call to that same
> rcu_preempt_deferred_qs_irqrestore() function, which again might not
> happen.  Or might be significantly delayed.
> 
> Or am I missing some trick that fixes all of this?
> 
> > I'm not sure how much can be done here due to the notrace part. Assuming
> > rcu_read_unlock_special() is not doable, would forcing a context switch
> > (via setting need-resched and irq_work, as the IRQ-off case) do the
> > trick?
> > Looking through rcu_preempt_deferred_qs_irqrestore() it does not look to
> > be "usable from the scheduler (with rq lock held)" due to RCU-boosting
> > or the wake of expedited_wq (which is one of the requirement).
> 
> But if rq_lock is held, then interrupts are disabled, which will
> cause the unboosting to be deferred.
> 
> Or are the various deferral mechanisms also unusable in this context?

OK, looking back through this thread, it appears that you need both
an rcu_read_lock_notrace() and an rcu_read_unlock_notrace() that are
covered by Mathieu's list of requirements [1]:

| - NMI-safe
	This is covered by the existing rcu_read_lock() and
	rcu_read_unlock().
| - notrace
	I am guessing that by "notrace", you mean the "notrace" CPP
	macro attribute defined in include/linux/compiler_types.h.
	This has no fewer than four different definitions, so I will
	need some help understanding what the restrictions are.
| - usable from the scheduler (with rq lock held)
	This is covered by the existing rcu_read_lock() and
	rcu_read_unlock().
| - usable to trace the RCU implementation
	This one I don't understand.  Can I put tracepoints on
	rcu_read_lock_notrace() and rcu_read_unlock_notrace() or can't I?
	I was assuming that tracepoints would be forbidden.  Until I
	reached this requirement, that is.

One possible path forward is to ensure that rcu_read_unlock_special()
calls only functions that are compatible with the notrace/trace
requirements.  The ones that look like they might need some help are
raise_softirq_irqoff() and irq_work_queue_on().  Note that although
rcu_preempt_deferred_qs_irqrestore() would also need help, it is easy to
avoid its being invoked, for example, by disabing interrupts across the
call to rcu_read_unlock_notrace().  Or by making rcu_read_unlock_notrace()
do the disabling.

However, I could easily be missing something, especially given my being
confused by the juxtaposition of "notrace" and "usable to trace the
RCU implementation".  These appear to me to be contradicting each other.

Help?

							Thanx, Paul

[1] https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/
