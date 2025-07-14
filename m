Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A825E813;
	Mon, 14 Jul 2025 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510857; cv=none; b=JqD3YpRItE62Rcvi/+g4aB5lpSQ0517E3ek1g/3HrH81s6Y0xAptfagWIIuuQoIEHb9Wg37kGBxod0pv6ofzUzW4bC1SJmdzWRse8KI0L5GGhuRT3DbYiKjYeiR/WUKK3sREWPpxHl7weRv79qIDc75qnN8ISWzTDymEUJvNusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510857; c=relaxed/simple;
	bh=OPJZv2ktMSedxs7E+ndBeD6MPhuYetJHIaeSdN08Rns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E79XUt4SXxHwrDIrYNUQQJAQAFTROiJmEboB1s0hPWclReYoYnf0FqkLNmJyZShdC1mkXZBU3Qj7sKSeTCM5nnKolKoH/+i0OLluQdzvSGQCXMaEoUDeELUjhRvMcska0Op3UaIVheN5FgV50T0jayNZ4Q+6l/NqR80dRTapwUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYozpRG2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYozpRG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0907AC4CEED;
	Mon, 14 Jul 2025 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752510857;
	bh=OPJZv2ktMSedxs7E+ndBeD6MPhuYetJHIaeSdN08Rns=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=aYozpRG2svZTnvSUWf4/z6Cpppf+q1bEOUqfGMPNZyiR+tgT/jeGqFCfn8OfQ9gAb
	 l/qKW5k2Yml9cxelkJYlFl2h/g//bMd8D8lTzKHzqLJCEk67BomnHFogiV9mGflvZk
	 PRQU2boN7u0Y8ABAoINmBHW37le3vJoM6QrZGeFWgL3Ikgj7F4cDJ6y1A15mjwCO3E
	 LoHpFYYLYDMZOoCB7Zj1GW/r30+9yntJqOHO0Hd1ZIuSuOCjA5v8mqYkBJz3a3bfzS
	 EBM8WbiGGBY17J6NXXQs0LH6/GeTxtSX7JOF+0zKWUkAS9vubWJ7YplZ8oNi9qDp26
	 B9zVfnaFbNr4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9F213CE0845; Mon, 14 Jul 2025 09:34:16 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:34:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <ebad20d8-7b04-4c32-97a9-8ae058bdaedc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
 <20250623104941.WxOQtAmV@linutronix.de>
 <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>

On Fri, Jul 11, 2025 at 10:05:26AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 11, 2025 at 09:46:25AM -0400, Mathieu Desnoyers wrote:

[ . . . ]

> > AFAIU the goal here is to turn the guard(preempt_notrace)() into a
> > guard(rcu_notrace)() because the preempt-off critical sections don't
> > agree with BPF.
> 
> OK, got it, thank you!
> 
> The combination of BPF and CONFIG_PREEMPT_RT certainly has provided at
> least its share of entertainment, that is for sure.  ;-)

Is there a similar issue with CONFIG_PREEMPT_LAZY, given that in that
case rcu_read_unlock() maps to preempt_enable(), which also can invoke
the scheduler?

							Thanx, Paul
