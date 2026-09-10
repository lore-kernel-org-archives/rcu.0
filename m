Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78E3DE43B;
	Thu, 10 Sep 2026 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031163; cv=none; b=gPNk1ymzsWPomgA+ALtCZrkZ4MN3NBterFGAMkrVsVX13ngQyiBAR57sbWEVlz1OZFJvdj0XZTRA304L1+Xrt9EXdZLY1rwm+Rftp7HkTdN7QuVgaQPYMlVw0Sxou2gMQa6zlTrdfxOY5Im0tdxXXr0U23UO19o2R4z3xTtS6wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031163; c=relaxed/simple;
	bh=1xueSEs1Lf1/iaVYDjuyvTMGzK9+IYhL8XIuERTyBuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdPQE1NNusQmW/yel0Em7Qi9QCGAfz9DNA4jSPXViXVtjlhmZsg6tuQuvnWAio4kvAsPp0hW7vQDP+MzZhnRt8l99hry8g/xuog6JA5/cG4A59QIrJKoHiSnhLYVwc1B/ZFoZx0w/1BUqW7bs2zYiu0ag8zmuvQpoGHBZeR2QCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wWMZPehr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gVC5LMNq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wWMZPehr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gVC5LMNq"
Date: Thu, 10 Sep 2026 11:05:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789031159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojT9pNL33Xeb8UjNXG8w6sJZoICmBryWtIIq+k4hPQM=;
	b=wWMZPehrkZ8NjWyZmQ92P5Q7zhqVr0RHrZUGla3YpuherDKC0WgPptXEvOK1evbvBK96W5
	QNS5s408Dw1pPaUcTzlecVi4XrMWvr9WIDmSCmGcmeR6VbiiVxlI/2EzUs2FIaJeIxyjq3
	c7qrnfV4bRE+L8EvjA2vmUERsYGdvv2MdBlkFyBILx1FyjW99fUHIVUuXyokdoV9Qyxv16
	nNbp8Wgzo2LbEIsZX+GxL9FMAC3EAwbjEoEEElXC9XIjXbM67Hly+boglbatpLnCclZ3Lc
	/cKDmgqHsUgt+hOkGTOStoba7pom3243YkTmAKSu9QmpBJSp8eRPvaQ5C7hMZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789031159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojT9pNL33Xeb8UjNXG8w6sJZoICmBryWtIIq+k4hPQM=;
	b=gVC5LMNqMPzB/TeKKTtexb6gNooOm4s8J8rOeDagddmlatGItL5XKaGgk5YqJ9eqiKyr9v
	EWIIgzikXPW8LICg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any context
Message-ID: <20260910090557.zz62jtMt@linutronix.de>
References: <20260810122758.183765-1-puranjay@kernel.org>
 <20260810122758.183765-2-puranjay@kernel.org>
 <20260826144636.3IRUXeFV@linutronix.de>
 <CANk7y0hbwXL7nBDgjTgrneBejEgGrsZnc02RztG-aSBEEvAcwQ@mail.gmail.com>
 <20260902082657.yPEhNFlo@linutronix.de>
 <CANk7y0gMh6McuLnFwxGO-nH_g3TnstwTK2rtT5pq=b8qq9ykKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANk7y0gMh6McuLnFwxGO-nH_g3TnstwTK2rtT5pq=b8qq9ykKQ@mail.gmail.com>

On 2026-09-02 15:14:20 [+0100], Puranjay Mohan wrote:
> >
> > But it is wrong to talk about NMI and do this for other reasons not
> > mentioning why this was needed/ made sense.
> > Can this be fixed?
> > Also what is the reasoning for doing it from any IRQ disabled region?
>=20
> So, the main reason for this patchset is to make call_(s)rcu() work
> from BPF programs, and these BPF programs can run from any context
> like an NMI perf event interrupt or maybe attached to a function
> through ftrace which is in the call chain of call_rcu() itself.

This I expected.

> call_rcu() takes locks with irqs disabled or it modifies lists
> non-atomically with irqs disabled. This means that a BPF program that
> runs from NMI with the lock already taken will deadlock, or if it runs
> between these non-atomic list modifications, it will corrupt the
> lists. A BPF program can also synchronously re-enter call_rcu() if it
> is attached to a function in the call chain of call_rcu() that is
> called with a lock taken. So, all these cases are detected with
> irqs_disabled() and on detection we do stuff that doesn't require
> taking any locks and is safe even if re-entered.

Attaching a BPF program to call_rcu() and re-entering sounds great. But
there is nothing unique about call_rcu(), is there? We do have certain
amount of functions which can be invoked from NMI and their usage is
limited.

Anyway. If this is the sole reason for stunt then it _has_ to be part of
the commit message. Now it looks like an ooopsie where you talk about
NMI and do hardirq check.

> > > > > +static void __rcu_defer_drain(struct rcu_data *rdp)
> > > > > +{
> > > > > +     struct llist_node *node, *next;
> > > > > +     unsigned long flags;
> > > > > +
> > > > > +     if (!IS_ENABLED(CONFIG_RCU_DEFER))
> > > > > +             return;
> > > > > +
> > > > > +     raw_spin_lock_irqsave(&rdp->defer_lock, flags);
> > > > > +     llist_for_each_safe(node, next, llist_del_all(&rdp->defer_h=
ead)) {
> > > > > +             struct rcu_head *head =3D (struct rcu_head *)node;
> > > >
> > > > Why do you need the lock. This is still not clear to me despite the
> > > > comment. You can do llist_del_all() towards another list and then f=
eed
> > > > it into rcu_do_enqueue() one by one. And you use the LAZY part.
> > >
> > > Because rcu_barrier() can call this for each cpu and at the same time
> > > rcu_defer_drain() can call it too, so this would cause a race where
> > > the irq work can remove the callbacks (llist_del_all) and before it
> > > can enqueue them, rcu_barrier will see that the list is already empty
> > > and will not wait for these callbacks. We want the llist_del_all() and
> > > rcu_do_enqueue() to happen atomically so rcu_barrier() can work
> > > correctly.
> >
> > So you collect a bunch of callbacks and spent time re-arranging
> > everything with irqs off.
> > What is wrong with keeping it in the llist and consuming it like the
> > regular rcu_segcblist?
>=20
> I don't understand your last point, all the collection and delayed
> addition into rcu_segcblist is because it is not safe to do it
> directly as I explained above.

That is correct. My point is the more callbacks you add, the more time
you spend to re-add them here. It is not just the one NMI callback
injected from NMI, it is everyone within interrupts disabled region.
After each one you trigger an IRQ. And with LAZY-irq-work or on
architectures which don't have an IRQ-work interrupt, you accumulate
every callback from IRQ disabled region since the last HZ tick.

The question is why not have an additional list which is handled the
same way in terms of grace period like the current one?

> > It does not look like you defer them for long at all. Every callback
> > enqueued in an IRQ-off region will be immediately re-enqueued to the
> > regular list the moment interrupts are enabled again.
> > Except on architectures which don't implement irq-work interrupts where
> > it will be delayed to the next HZ tick. And the next HZ tick does not
> > sound like a long time either.
>=20
> Yeah, I get your point, and when a CPU goes offline will its LAZY irq
> works be drained or left in the queue? Because we want to make sure
> this irq work is executed before a CPU goes offline.

Hmm. There is smpcfd_dying_cpu() running before rcutree_dying_cpu().
smpcfd_dying_cpu() flushes irq-work near the end. On PREEMPT_RT we have
this thread handling them and this one is parked smpboot_park_threads()
a bit earlier. So here smpcfd_dying_cpu() will wake the parked thread
which then waits until the CPU comes back on.
We can't run the work directly due to the IRQ-off context. We could move
them to another CPU but then the irq-work might expect to be run on the
other CPU=E2=80=A6
But we could flush the queue before parking at the very least I suppose=E2=
=80=A6

Sebastian
