Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C285F23717C;
	Fri, 20 Jun 2025 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409019; cv=none; b=B73R7B6JAHLhQetrEoCuD1LEmUcbRjXIMVRkRQNqjKhPhna2bKrskKx9KfhSJ1QbcInfMYM8HpXkJMZt/L+1FwuFXJlpJXxJXtUEO5UKVVawuv6H/rScX8TMgmAsRvNqpj/6+Su+NVxCHwzPjzvIiKTQe8dchItnWsuwrGur29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409019; c=relaxed/simple;
	bh=xiYoiA0vD0R9FosBeepOA5ayZ68lc048xz2QjR77AQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIalHB1qGW1KoLXB8ljyNBMfjnhTw4EsvMBiW9uuVQOWvJOKoQ4ss0yIfpJRC4cpc0jfjrVFzfoipuyYcSFwGuE3M9uazEy5Y6SwrNYj56w/iTV/VQux3cctPPNGKbI341xVppFx7FEvwA0BaCAJJ+tJPgL0nm52rvKOzi1yvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SlC8L2zz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L0dFoXJI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SlC8L2zz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L0dFoXJI"
Date: Fri, 20 Jun 2025 10:43:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750409016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nIoY8ERSlva0NoEjEF9t7JgdIzcqxRup7Yp6VS+OPfU=;
	b=SlC8L2zzQ5ajZ7h+5wljjYQ0rN2aXw6LeknxNSo6/MXTghM/+L9wCOEt5K+pzVvWi+rPgI
	9YrP3RVwY0ehgFsVLH6lMn/Dnmaa0c8s7rZTJmerdKJVqvH4EnM8kE01RrIUjRcgU4HG9F
	a/khfxK84CkiwWPXzBVcM7Zy1ZuYcMviOimm3SAEmGwVH01txFu5mDTlv6jeliS5FvEZR9
	k8m+yPr0SSx7mWzj3dU9URDAJzIqIUnDSNp3YldlZN6cPW8gilr32NJBmCY+ptkiCwv1sQ
	undbVQ52Uumu+dxH3WGHcoMXUPUNOI2+jVRfyqCrOiE+YsCQ9qZmGxKfFJmxXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750409016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nIoY8ERSlva0NoEjEF9t7JgdIzcqxRup7Yp6VS+OPfU=;
	b=L0dFoXJI2uUbWAgtm74SBNvu9ziOhm3tdTGAqSpWI6AmOcsrPe7n3ksZg+trecFINbAC5b
	CB96TAdGSch1FMAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20250620084334.Zb8O2SwS@linutronix.de>
References: <20250613152218.1924093-1-bigeasy@linutronix.de>
 <20250613152218.1924093-2-bigeasy@linutronix.de>
 <aFL1pIGMDX5DG9f_@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFL1pIGMDX5DG9f_@tardis.local>

On 2025-06-18 10:21:40 [-0700], Boqun Feng wrote:
> 
> If it doesn't participate in rcu_read_unlock_special() then it may not
> report a QS in time, right? For example:
> 
> 	CPU 2			CPU 3
> 	=====
> 	rcu_read_lock_notrace();
> 				synchronize_rcu();
> 				// need all CPUs report a QS.
> 	rcu_read_unlock_notrace();
> 	// no rcu_read_unlock_special() so QS will only be reported next
> 	// time we if another RCU read-side critical section exits.
> 
> Wouldn't this be a problem?

I hope not because it is not any different from

 	CPU 2			CPU 3
 	=====                   =====
	NMI
 	rcu_read_lock();
 				synchronize_rcu();
 				// need all CPUs report a QS.
 	rcu_read_unlock();
 	// no rcu_read_unlock_special() due to in_nmi().

If the NMI happens while the CPU is in userland (say a perf event) then
the NMI returns directly to userland.
After the tracing event completes (in this case) the CPU should run into
another RCU section on its way out via context switch or the tick
interrupt.
I assume the tick interrupt is what makes the NMI case work.

> Regards,
> Boqun

Sebastian
