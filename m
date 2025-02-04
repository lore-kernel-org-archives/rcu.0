Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450D209F57;
	Tue,  4 Feb 2025 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664776; cv=none; b=lPjfsAeT2PUUjC+dEQkbCnSJuBwg+N0fggjTrOv8NX1w0DCiWCgvz/bBve5KSxvNyX0ur96YXUv2XGtau+dhdausdh954jdqhlqipuOrwngykwIX59/t1a0CrHZko1Ha78z/6qozZ7Z5S5Rdk/hqVwPPOy6yCxjLch/F8Wpno38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664776; c=relaxed/simple;
	bh=gC2aHzd+wwShId9cIq7FLtsXQIZDubIW/8Lg5TVvsQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qymru0oeJVME/PVd0DWlFT3V8j3dm4vUTnSwizFTqvMw7WwPtkNQ+e4JzIYEmFh7YrQR7ScGQSbH3xopqKJcVk8t3fArT1P2vdsR0aAW4gelD2qWPaR3uvq0bJF10jaU8vvup+iGk52glK602hCRlOpfg88yIRWD/T2QT2BCoAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WByCeUJj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ACChoWpf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WByCeUJj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ACChoWpf"
Date: Tue, 4 Feb 2025 11:26:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738664773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kgn+rEcEOY8px6GFHYJNkHnz2BEPnX2Ua3XM3Zflbxo=;
	b=WByCeUJjx4ioUYZW1V1sQl5m3OlikHYJjOvTW2vk14i2J5DDGDIDujOnIv4B6HUD+/mcL+
	PNPIzhOXqVHSZae7pwOtX8hGKOg/232h1f9s9Lkzyr2A1p/9Jv6+XjZGRXoFIlODP4m8mH
	/Nn1glQre8bbvLeKYcc9J16lfe5ZvwWbUUinhebwrhi1gUMGaLeZOGIOKm6NbUR0pQnZp/
	pf9ieK0dujG6D12H9OxSm7J66VhIL3A3AA+4QQc3/gIlD8Mch8mDK8l+QaoqU8+XzqCtmD
	juCVcYIVJgorN0lsGgHDdCxIH9ehLF3dHOp8CTa9wWdun5U3VrcDXQ/NMVznWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738664773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kgn+rEcEOY8px6GFHYJNkHnz2BEPnX2Ua3XM3Zflbxo=;
	b=ACChoWpfAFNoOSvNtAAvJBWZAQnDD2bscx00dzwgR0T4RRmAzsPwupMC2n5w8hA8NlP8sz
	+lWrntu+7jlhRLAA==
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
Message-ID: <20250204102611.OVuHn9rS@linutronix.de>
References: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
 <20250130185320.1651910-4-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130185320.1651910-4-paulmck@kernel.org>

On 2025-01-30 10:53:19 [-0800], Paul E. McKenney wrote:
> The timer and hrtimer softirq processing has moved to dedicated threads
> for kernels built with CONFIG_IRQ_FORCED_THREADING=y.  This results in
> timers not expiring until later in early boot, which in turn causes the
> RCU Tasks self-tests to hang in kernels built with CONFIG_PROVE_RCU=y,
> which further causes the entire kernel to hang.  One fix would be to
> make timers work during this time, but there are no known users of RCU
> Tasks grace periods during that time, so no justification for the added
> complexity.  Not yet, anyway.
> 
> This commit therefore moves the call to rcu_init_tasks_generic() from
> kernel_init_freeable() to a core_initcall().  This works because the
> timer and hrtimer kthreads are created at early_initcall() time.

Fixes: 49a17639508c3 ("softirq: Use a dedicated thread for timer wakeups on PREEMPT_RT.")
?

I played with it and I can reproduce the issue with !RT + threadirqs but
not with RT (which implies threadirqs).
Is there anything in RT that avoids the problem?

Thank you for debugging and the patch. 

Sebastian
