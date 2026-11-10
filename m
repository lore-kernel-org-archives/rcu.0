Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794298187;
	b=BzesBGuodrOwrHEtBmqhff82j7OyQ+HLp60xfp7a+4OlTzD4EZnN2AJeKbVG5WmoHQqL
	 slz9r1cmLom8f3X1uXUXThztbP4VeHr60TgK0+FJ3i+pdz5j0zCIxCE6VSNQ0ZNMU7QQU
	 iTIebTVPsyodNpY7By8aiNGIywZfYPX7eK2QyxEEfUKyP3AdtNAiDRYeD8MWYS94AFsCv
	 ldyGBLFP0cRNvzB/E1T3Gl21YGDk989X4gVGeqhVbmbpuxsQ0T/ePuXNVykRNDEIvP1yC
	 k22KqhdakJiSVv5PxJGQCHH6TQedAnjbJIRdi8oWUitL3RY/2YGfDI6Uur7AKApN78w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298187;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=c2qCJTJTcCHZf6cE2IYQnsWT3X7zyuhCPskU0MKXrgQ=;
	b=yPZ2qOvGrFRVW6s1t/g9Bdp544mttU94ByMXPXHOzT9ok6Dln00KlDFs7xP0hXv6yTry
	 qXYlVwxjv/EZmb7uuf7aQvycgwl/GBSnL7DaZvOiiPAXRsyyIOvpVboDtPtgVVyv037Wi
	 jO1gBGwqOvUnvRkneUsWQcnOqBBW3pHR2+ekO059qNcZ+3Pf2gjoVEt2moQB/k77lR83m
	 0tY5qtVADgsm42RtuV+V0XaMEFOrpp8iJUANN45u489NPKzUWGFBFSQEK1rxrP66Ehgub
	 brfyPViUvrb99Kaf8cP2jk3dt6LgryIsNkd5niK5OcgSZGaPhLJzMtq8BaDtyWhZUTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=1sx+DThx;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=hUC1VwOV;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B505960A2608
	for <rcu@vger.kernel.org>; Tue, 10 Nov 2026 08:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B505960A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=1sx+DThx;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=hUC1VwOV
Date: Tue, 10 Nov 2026 09:09:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794298184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c2qCJTJTcCHZf6cE2IYQnsWT3X7zyuhCPskU0MKXrgQ=;
	b=1sx+DThxqL79EQec3hFn2UEJuvkhE/i25n/sqP34XBQc2cW+VT4bKVEimdWj2OBSf9Aoke
	nkVzbIQ+3ZCzJYx18mKTdPglB76ey0BgDq+BqVsuuJFiYeSAb04PsE1K5dtZtwIjfxJPzw
	NDcz3XsgWcKuAoFqoHVORbpysHDIHONU6Ae1BX9CSWYRgHbVmUf+8xSuf1+WooT3nOlln6
	QTp3KLGZkkb1jD5DPV4i/QF6uXHBnNRwSnHIHhFg/uccf3eUjOsliwZvmgbm+RuQ6TaKFI
	XYkznZG2hOX1dT3pY0key68u0yYqVqmySYYqGh7V2o/VkZGkzRT1p4hO8x+S7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794298184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c2qCJTJTcCHZf6cE2IYQnsWT3X7zyuhCPskU0MKXrgQ=;
	b=hUC1VwOVpgnVuakNt27Tlt3/xte7tzjqV1T0Zgtj9roF+p5Ffy9zMXqLh3luL9iCOFrJW8
	P50CiMbLnEN278Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
Message-ID: <20261110080942.QxKXirzI@linutronix.de>
References: <20261105165113.82N-rPMG@linutronix.de>
 <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
 <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
 <auzXjQfYXs_gzx1y@gpd4>
 <c81d8243-c130-44d8-bef6-e678ecb088ac@paulmck-laptop>
 <20261106140401.90MH_6qt@linutronix.de>
 <5f5ffa5b-9fa5-4359-87fc-7558f37ff0eb@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f5ffa5b-9fa5-4359-87fc-7558f37ff0eb@paulmck-laptop>

On 2026-11-09 16:45:47 [-0800], Paul E. McKenney wrote:
> On Fri, Nov 06, 2026 at 03:04:01PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-11-05 12:03:11 [-0800], Paul E. McKenney wrote:
> > > > For rcutorture, I don't think there's a ready-made kernel interface,
> > > > maybe we could add a sched helper that performs the same operation as
> > > > the debugfs knobs?
> > > 
> > > I would very much appreciate that.  ;-)
> > 
> > This maybe? Since it is built-in only, there is no need to restore the
> > old state, is there?
> 
> Hearing no objections, I will start testing this.  I am applying both of
> your patches from this email thread, but please let me know if something
> else would work better.

I have kept the first one and added a proper body for the second. I
intend to repost it later today if nothing goes wrong.

> I would expect that this command would result in rcutorture complaining
> about priority-boost failures because SRCU does not support priority
> boosting.
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 15 --configs SRCU-P --bootargs "rcutorture.test_boost=2" --trust-make
> 
> But please correct me if I missed a turn in here somewhere.

SRCU doesn't do boosting so yes.
I just stared at rcu_torture_boost() and I probably miss bits. I would
expect this thread to run at SCHED_OTHER and then run at 100% for a
period of time within a RCU-read section. Once the RCU machinery decides
to start a GP and force a quiescent state it would instruct rcub/ to
boost the tasks which stayed in their RCU read section (I *think* to be
in RCU-section is enough because the idea was once to get task back on
CPU which were scheduled out while in their RCU read section).
Once this happens, the task should be with SCHED_FIFO priority and could
leave the RCU section, un-boosting itself and passing the test.
I don't see RCU-read locks but this might be done differently. I see
multiple sched_set_fifo_low(current) but this shouldn't change. (Your
priority shouldn't change (becomes lower) if your higher priority is
due to priority-boosting.)

Your rcu_torture_boost() runs at FIFO-1. So if it does what I described
but at FIFO-1 and rcub runs at FIFO-2 then it should still work.
Throttling should just make it go slower.

> And yes, in the built-in case we normally don't care about restoring
> state.  The usual situation is that the system (usually a guest OS)
> is brought down at the end of the test anyway, in contrast to running
> rcutorture non-builtin, that is, using modprobe and rmmod.

this makes things easier.

> 							Thanx, Paul

Sebastian
