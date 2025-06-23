Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22723E23C;
	Mon, 23 Jun 2025 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675786; cv=none; b=pTANBhOdIgqnwrxeHGmH3TmWlEbL4xO4MIq+aV0XyvsTLzxn0O8HMlnq/31LA+4no/sogDTTqRK5jxMCUFMyqMnmwwS3px3bNRvTWxEG0DlRc8eI5Q8kMHEyzJyXRh8nOZ+QK8Z2mJETMRS3JN/GLGQlq0MWA1bW4oZWjvuzb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675786; c=relaxed/simple;
	bh=7VU26WsfLwm50/m1Fdacy3rL7GUr7nmycZtoH1KxOO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDpQxkFEuj4LONaMHBODXSxMdPB5p9NpmMgHEqcGHCkmSCKqE1OmXCWwxp4wNwNw72Yfb6NejjkkMg1r0x7yUwXQjcgorahETlJnD/V6gG/spfKVX92ZsiIx6eoc1uEW6W8x+HhGtxkzbTDQ+Cl9bjsfe0YRjunzOBcA+JrKUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2vedRkoo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YgUCTBPl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2vedRkoo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YgUCTBPl"
Date: Mon, 23 Jun 2025 12:49:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750675782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YjeIAngkCR4Ivgud1B82q064J6U4+VawToHZ/hWi4Dc=;
	b=2vedRkooNti/MveWLwJ94UmyVb5dOBoUjNNzdjA+qiJvneZSjU/zty7jpFihItk8fyz0Gn
	5VhaRfpbN+aEcW7WLAgxphmCgdA/ddUxYNRI2ctxmF7RVa4HJjzgeShvDUT630w+eGscHb
	IhejSynjHjPg0dxeFhHmp7TkvSN94X5Z2Gx98AUrQ9OPDP46w75ukKdcg2LyOLU3UyeNFR
	YOkd2CD8HYb/nyQypCR7T++D8oMcppOae/0V0bFFrix20CTGn8tw4yEH3jYK70V4JfHceE
	xGXq1Nu77D36q/nZ1MEeO9Zg8J4RXpme3n6ADPy5PhuyTrXNknnBjjivH38KjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750675782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YjeIAngkCR4Ivgud1B82q064J6U4+VawToHZ/hWi4Dc=;
	b=YgUCTBPlu3EVd1aZehKZ74ydQvNWDlYQUVOxotA2KkHErJAX7jJJH3eopYtiLenAl4ZFi9
	ilHQDMTD2UJhxRAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20250623104941.WxOQtAmV@linutronix.de>
References: <20250613152218.1924093-1-bigeasy@linutronix.de>
 <20250613152218.1924093-2-bigeasy@linutronix.de>
 <aFL1pIGMDX5DG9f_@tardis.local>
 <20250620084334.Zb8O2SwS@linutronix.de>
 <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>

On 2025-06-20 04:23:49 [-0700], Paul E. McKenney wrote:
> > I hope not because it is not any different from
> > 
> >  	CPU 2			CPU 3
> >  	=====                   =====
> > 	NMI
> >  	rcu_read_lock();
> >  				synchronize_rcu();
> >  				// need all CPUs report a QS.
> >  	rcu_read_unlock();
> >  	// no rcu_read_unlock_special() due to in_nmi().
> > 
> > If the NMI happens while the CPU is in userland (say a perf event) then
> > the NMI returns directly to userland.
> > After the tracing event completes (in this case) the CPU should run into
> > another RCU section on its way out via context switch or the tick
> > interrupt.
> > I assume the tick interrupt is what makes the NMI case work.
> 
> Are you promising that interrupts will be always be disabled across
> the whole rcu_read_lock_notrace() read-side critical section?  If so,
> could we please have a lockdep_assert_irqs_disabled() call to check that?

No, that should stay preemptible because bpf can attach itself to
tracepoints and this is the root cause of the exercise. Now if you say
it has to be run with disabled interrupts to match the NMI case then it
makes sense (since NMIs have interrupts off) but I do not understand why
it matters here (since the CPU returns to userland without passing the
kernel).

I'm not sure how much can be done here due to the notrace part. Assuming
rcu_read_unlock_special() is not doable, would forcing a context switch
(via setting need-resched and irq_work, as the IRQ-off case) do the
trick?
Looking through rcu_preempt_deferred_qs_irqrestore() it does not look to
be "usable from the scheduler (with rq lock held)" due to RCU-boosting
or the wake of expedited_wq (which is one of the requirement).

> 							Thanx, Paul
Sebastian
