Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293F78F4A;
	Fri, 20 Jun 2025 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418632; cv=none; b=bkLMsSqD1fTJkZI0YqFp0KyeVUM4zpbfv9sGaG8NRPAQvdFKQJZLJJEcnzZm6WTElm6uGOarY+RG4KG/wafhvi+SNHp0wHkIGq/XFEFvhff/rEoyqY1uGLHrqBLBmKMGW2jDkMmTRpOYQ4SC8qlm1dcS/a5M+Svt832EMJWB+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418632; c=relaxed/simple;
	bh=66n6XN5GLG8oS/KhyXU+4Cv1RfVfPu/ke39/ah7Y17o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNs5BNql7xBIq0577wLjqvCEbIM7RwzIqKB46idPacEpHAiLNZG/+KL/hlez82kBss83pozP8sEwWO8fvFlLWboNFOX0FABgf0IZGrEgcL+vmL8EUXftYaOfsUbQSYMaNj45VQ1tIRWFzZMeXSSbeeTDPtsqvkA0iSDc6kJ4hxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usnieh86; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usnieh86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF1DC4CEE3;
	Fri, 20 Jun 2025 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750418631;
	bh=66n6XN5GLG8oS/KhyXU+4Cv1RfVfPu/ke39/ah7Y17o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=usnieh861Bm0GnT4+GEXqjfolK8ru7zwDWOH6a0B/2DgG3ercPsOv66eczER6U0sC
	 F7k2ZKxFgJubdb+4Vt9w7c9OzkesdlR1YnJf85kRXkXJGmfLaFphUFy1oR/obcCDLz
	 V1x0+U667FQHiQRtzEkgZzuB7PBYSBCCpMLkmayWQ65a+71GOpWjaXLEfNJ86FxsLD
	 ZD7tcMjoEnyQT0IPqvkGpIx3s/IAdsAp/LsO1c/ly5EljQHeYKovhEr9l6Sr+ySJJK
	 iXWQf9ec6WjSAyu30x/Aqv+uhvBSsGUNqYEw6OJ6J2/MgNAovPqpNAP3RSe1sCVagH
	 HlCmVOdYJ5ZGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 30FA3CE0B9E; Fri, 20 Jun 2025 04:23:49 -0700 (PDT)
Date: Fri, 20 Jun 2025 04:23:49 -0700
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
Message-ID: <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250613152218.1924093-1-bigeasy@linutronix.de>
 <20250613152218.1924093-2-bigeasy@linutronix.de>
 <aFL1pIGMDX5DG9f_@tardis.local>
 <20250620084334.Zb8O2SwS@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620084334.Zb8O2SwS@linutronix.de>

On Fri, Jun 20, 2025 at 10:43:34AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-18 10:21:40 [-0700], Boqun Feng wrote:
> > 
> > If it doesn't participate in rcu_read_unlock_special() then it may not
> > report a QS in time, right? For example:
> > 
> > 	CPU 2			CPU 3
> > 	=====
> > 	rcu_read_lock_notrace();
> > 				synchronize_rcu();
> > 				// need all CPUs report a QS.
> > 	rcu_read_unlock_notrace();
> > 	// no rcu_read_unlock_special() so QS will only be reported next
> > 	// time we if another RCU read-side critical section exits.
> > 
> > Wouldn't this be a problem?
> 
> I hope not because it is not any different from
> 
>  	CPU 2			CPU 3
>  	=====                   =====
> 	NMI
>  	rcu_read_lock();
>  				synchronize_rcu();
>  				// need all CPUs report a QS.
>  	rcu_read_unlock();
>  	// no rcu_read_unlock_special() due to in_nmi().
> 
> If the NMI happens while the CPU is in userland (say a perf event) then
> the NMI returns directly to userland.
> After the tracing event completes (in this case) the CPU should run into
> another RCU section on its way out via context switch or the tick
> interrupt.
> I assume the tick interrupt is what makes the NMI case work.

Are you promising that interrupts will be always be disabled across
the whole rcu_read_lock_notrace() read-side critical section?  If so,
could we please have a lockdep_assert_irqs_disabled() call to check that?

							Thanx, Paul
