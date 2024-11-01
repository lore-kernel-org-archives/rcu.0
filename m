Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2131A0AEC;
	Fri,  1 Nov 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469315; cv=none; b=g6mMo/kj8SgkJYOp5KeQmw8f06pCo+Pv2/SPIXaBaKWXZOrHTz4WlFECeiDp4ZGbwWLfer34ELdP+V4HQEzDaMKdSgdUEMRDwmWOpaTKldwBXnlqhZOayTjUUwYkgg6d7gEKlz/gmtyMbQkqexzpDncGLwWSzUKcmC6j0iisgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469315; c=relaxed/simple;
	bh=bj2tXz8fV5NYSRC9Q0sGDp5VvlK/Dny7YcEOv+vg+Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1kCwxOk2tHPEnUbBZpPkwlRPGmywX0fFom2MEkIAfmRS5dfxJOu+bWZqr8Z/JS+IUTqI/7t0GaqrgUWQa55K9xJlcrxFbwmNp4ytASdX42/S37FGc2E0oNWdp3m0Q/x/sxcTpiHmaqyi8Thbw5GtBovpYJT3g5PRN01QgYqEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rk9yBRJk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rk9yBRJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FA4C4CED1;
	Fri,  1 Nov 2024 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730469314;
	bh=bj2tXz8fV5NYSRC9Q0sGDp5VvlK/Dny7YcEOv+vg+Pc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rk9yBRJkw0yYcNTczLKzw4Lf5ddSqA7XwZ+ftGCRvlASt8SQI0+L5JgWmfMdYNs0C
	 1MJcXqiERURDhjXKoZtQ8SjGz9nBsp6bRvdEJSNo+6Z1Hpfx3bZr7tnQil7r+dhV4X
	 wJj0aBnsqUCWHUdGg1vRPCu4arLJTTAtXzZwyUhdnuMyEHr9+fxySW0WQs7FeRXE2Q
	 ngsu93yg1+MqPfw6sBggeCaKYmMCNF8Lwv8V7E2soiOIN+S15wpAZ/TfR+VZ5MbcHJ
	 Sa/gKmLLG2LxFNaLXlJNAdIaTknoj7Zj+Uy2dFaaRTcIxjAkuL3mKE0d2jEC5GPS7T
	 sCZ2y1eXNKBEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F1638CE0995; Fri,  1 Nov 2024 06:55:13 -0700 (PDT)
Date: Fri, 1 Nov 2024 06:55:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Cheng-Jui Wang =?utf-8?B?KOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>
Cc: "dianders@chromium.org" <dianders@chromium.org>,
	"sumit.garg@linaro.org" <sumit.garg@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"frederic@kernel.org" <frederic@kernel.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	Bobule Chang =?utf-8?B?KOW8teW8mOe+qSk=?= <bobule.chang@mediatek.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"joel@joelfernandes.org" <joel@joelfernandes.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in
 rcu_dump_cpu_stacks()
Message-ID: <baf50a32-e028-4161-8ca8-72a65917c1f3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>
 <adb044e2-8f62-4367-9a22-30515f5647b1@paulmck-laptop>
 <d0adc7d14da0f21909eef68acf19fc5706a4b1af.camel@mediatek.com>
 <9e90d04e-081b-4730-890b-295ed52747de@paulmck-laptop>
 <CAD=FV=WBcOCGbD0haRYLGgAFpDhfoqMW8mvj9DEA0CSPHG3Owg@mail.gmail.com>
 <63859e70-2ea7-4a67-857c-fa226566f25a@paulmck-laptop>
 <CAD=FV=WsM=om=xobfWkC8nLQNK89xdyNNX=L1=DjD79ZPXYxRg@mail.gmail.com>
 <1617541e-4853-4567-b9c0-febf1cfa26a8@paulmck-laptop>
 <CAD=FV=XHD9FhUPLHWRFSRzuHqoBFKT3_cDwMr0ApOBBOjPNnAg@mail.gmail.com>
 <612522fc41698c029e35e13d170339d21703b334.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <612522fc41698c029e35e13d170339d21703b334.camel@mediatek.com>

On Fri, Nov 01, 2024 at 01:44:15AM +0000, Cheng-Jui Wang (王正睿) wrote:
> On Thu, 2024-10-31 at 14:27 -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Wed, Oct 30, 2024 at 10:03 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > > > > Note that:
> > > > > > 
> > > > > > * Switching to real NMIs is impossible on many existing arm64 CPUs.
> > > > > > The hardware support simply isn't there. Pseudo-NMIs should work fine
> > > > > > and are (in nearly all cases) just as good as NMIs but they have a
> > > > > > small performance impact. There are also compatibility issues with
> > > > > > some pre-existing bootloaders. ...so code can't assume even Pseudo-NMI
> > > > > > will work and needs to be able to fall back. Prior to my recent
> > > > > > changes arm64 CPUs wouldn't even do stacktraces in some scenarios. Now
> > > > > > at least they fall back to regular IPIs.
> > > > > 
> > > > > But those IPIs are of no help whatsoever when the target CPU is spinning
> > > > > with interrupts disabled, which is the scenario under discussion.
> > > > 
> > > > Right that we can't trace the target CPU spinning with interrupts
> > > > disabled.
> > > 
> > > You can by invoking sched_show_task(cpu_curr(cpu)) on the CPU requesting
> > > the backtrace.  The resulting backtrace will not be as good as you
> > > would get from using an NMI, but if you don't have NMIs, it is better
> > > than nothing.
> > > 
> > > >           ...but in the case where NMI isn't available it _still_
> > > > makes sense to make arch_trigger_cpumask_backtrace() fall back to IPI
> > > > because:
> > > > 
> > > > 1. There are many cases where the trigger.*cpu.*backtrace() class of
> > > > functions are used to trace CPUs that _aren't_ looping with interrupts
> > > > disabled. We still want to be able to backtrace in that case. For
> > > > instance, you can see in "panic.c" that there are cases where
> > > > trigger_all_cpu_backtrace() is called. It's valuable to make cases
> > > > like this (where there's no indication that a CPU is locked) actually
> > > > work.
> > > > 
> > > > 2. Even if there's a CPU that's looping with interrupts disabled and
> > > > we can't trace it because of no NMI, it could still be useful to get
> > > > backtraces of other CPUs. It's possible that what the other CPUs are
> > > > doing could give a hint about the CPU that's wedged. This isn't a
> > > > great hint, but some info is better than no info.
> > > 
> > > And it also makes sense for an IRQ-based backtrace to fall back to
> > > something like the aforementioned sched_show_task(cpu_curr(cpu)) if
> > > the destination CPU has interrupts disabled.
> > > 
> > > > > Hence my suggestion that arm64, when using IRQs to request stack
> > > > > backtraces, have an additional short timeout (milliseconds) in
> > > > > order to fall back to remote stack tracing.  In many cases, this
> > > > > fallback happens automatically, as you can see in dump_cpu_task().
> > > > > If trigger_single_cpu_backtrace() returns false, the stack is dumped
> > > > > remotely.
> > > > 
> > > > I think the answer here is that the API needs to change. The whole
> > > > boolean return value for trigger.*cpu.*backtrace() is mostly ignored
> > > > by callers. Yes, you've pointed at one of the two places that it's not
> > > > ignored and it tries a reasonable fallback, but all the other callers
> > > > just silently do nothing when the function returns false. That led to
> > > > many places where arm64 devices were simply not getting _any_
> > > > stacktrace.
> > > > 
> > > > Perhaps we need some type of API that says "I actually have a
> > > > fallback, so if you don't think the stracktrace will succeed then it's
> > > > OK to return false".
> > > 
> > > Boolean is fine for trigger_single_cpu_backtrace(), which is directed at
> > > a single CPU.  And the one call to this function that does not currently
> > > check its return value could just call dump_cpu_task() instead.
> > > 
> > > There are only 20 or so uses of all of these functions, so the API can
> > > change, give or take the pain involved in changing architecture-specific
> > > code.
> > 
> > Right. Falling back to "sched_show_task(cpu_curr(cpu))" or something
> > similar if the IPI doesn't go through is a good idea. Indeed, falling
> > back to that if the NMI doesn't go through is _also_ a good idea,
> > right? ...and we don't want to change all 20 callers to all add a
> > fallback. To that end, it feels like someone should change it so that
> > the common code includes the fallback and we get rid of the boolean
> > return value.
> > 
> > > > > > * Even if we decided that we absolutely had to disable stacktrades on
> > > > > > arm64 CPUs without some type of NMI, that won't fix arm32. arm32 has
> > > > > > been using regular IPIs for backtraces like this for many, many years.
> > > > > > Maybe folks don't care as much about arm32 anymore but it feels bad if
> > > > > > we totally break it.
> > > > > 
> > > > > Because arm32 isn't used much for datacenter workloads, it will not
> > > > > be suffering from this issue.  Not enough to have motivated anyone to
> > > > > fix it, anyway.  In contrast, in the datacenter, CPUs really can and
> > > > > do have interrupts disabled for many seconds.  (No, this is not a good
> > > > > thing, but it is common enough for us to need to avoid disabling other
> > > > > debugging facilities.)
> > > > > 
> > > > > So it might well be that arm32 will continue to do just fine with
> > > > > IRQ-based stack tracing.  Or maybe someday arm32 will also need to deal
> > > > > with this same issue.  But no "maybe" for arm64, given its increasing
> > > > > use in the datacenter.
> > > > 
> > > > IMO the answer here is that anyone in datacenters should just turn on
> > > > pseudo NMI (or NMI on newer arm64 CPUs).
> > > 
> > > Suppose datacenters all do this.  What part of this issue remains?
> > 
> > I believe that if datacenters enable pseudo NMIs then the issue is
> > "fixed" and thus only remains for anyone else (datacenters or other
> > users of Linux) that don't turn on pseudo NMIs.
> > 
> > 
> > > > > > IMO waiting 10 seconds for a backtrace is pretty crazy to begin with.
> > > > > > What about just changing that globally to 1 second? If not, it doesn't
> > > > > > feel like it would be impossibly hard to make an arch-specific
> > > > > > callback to choose the time and that callback could even take into
> > > > > > account whether we managed to get an NMI. I'd be happy to review such
> > > > > > a patch.
> > > > > 
> > > > > Let's please keep the 10-second timeout for NMI-based backtraces.
> > > > > 
> > > > > But I take it that you are not opposed to a shorter timeout for the
> > > > > special case of IRQ-based stack backtrace requests?
> > > > 
> > > > IMO the 10 second is still awfully long (HW watchdogs can trigger
> > > > during that time), but I'm not that upset by it. I'm OK with shorter
> > > > timeouts for IRQ-based ones, though I'm not sure I'd be OK w/ timeouts
> > > > measured in milliseconds unless the caller has actually said that they
> > > > can handle a "false" return or the caller says that it's more
> > > > important to be quick than to wait for a long time.
> > > 
> > > If you are using NMIs, and the CPU doesn't respond in 10 seconds,
> > > something is likely broken.  Maybe bad firmware or bad hardware.  You are
> > > right that watchdogs might trigger, but they are likely already triggering
> > > due to the target CPU being so firmly locked up that it is not responding
> > > even to NMIs.
> > 
> > Yeah, if NMIs aren't working then things are pretty bad. It still
> > seems like it would be better to let Linux dump more info before a
> > hardware watchdog triggers. For instance it could perhaps call
> > something akin to "sched_show_task(cpu_curr(cpu))".
> > 
> > I don't feel super strongly about it, but in my mind even if a CPU is
> > unresponsive to NMIs for 1-2 seconds then things are in pretty bad
> > shape and I'd want to start dumping some more info before the hardware
> > watchdog kicks in and we can't dump anything.
> > 
> > 
> > > On the other hand, when you are not using NMIs, then I agree
> > > you want a shorter timeout before remotely tracing the staek via
> > > sched_show_task(cpu_curr(cpu)).  I picked a few milliseconds, but if
> > > datacenters are using real NMIs or pseudo NMIs (and thus are not being
> > > blocked by normal interrupt disabling), then I must defer to others on
> > > the default timeout.  Much depends on the workload and configuration.
> > 
> > As I said, I don't feel strongly about this, so if people want to keep
> > the timeout or shorten it or add a knob, any of those would be fine
> > with me. I personally would object to a timeout that's _too_ short or
> > a timeout that is longer than the current 10 seconds.
> > 
> > -Doug
> 
> I hope this fix can be applied to the stable kernels. Modifying an API
> that is called by many architectures may encounter difficulties during
> the backporting process.
> 
> How about this: we keep the original nmi_trigger_cpumask_backtrace()
> but add a __nmi_trigger_cpumask_backtrace() in the middle that can
> accept a timeout parameter.
> 
> 
> +#define NMI_BACKTRACE_TIMEOUT (10 * 1000)
> 
> void nmi_trigger_cpumask_backtrace(...)
> +{
> +	__nmi_trigger_cpumask_backtrace(..., NMI_BACKTRACE_TIMEOUT);
> +}
> +
> +void __nmi_trigger_cpumask_backtrace(..., unsigned long timeout)
> {
> ...
> -	for (i = 0; i < 10 * 1000; i++) {
> +	for (i = 0; i < timeout; i++) {
> 
> 
> Then, the arch_trigger_cpumask_backtrace() for different architectures
> can pass in their desired timeout, for example:
> 
> 	/* 1 seconds if fallbacked to IPI */
> 	timeout = has_nmi() ? NMI_BACKTRACE_TIMEOUT : 1000;
> 	__nmi_trigger_cpu_mask_backtrace(..., timeout);
> 
> This way, archiectures that want different timeouts can modify it
> themselves without having to implement complex logic on their own.

Why not leave the current 10-second timeout (which is needed to handle
completely locked-up CPUs), and then add logic to the arm64 code that
does the substitution of the plain interrupt for the NMI?  If needed,
arm32 can do the same thing.

That way, we don't need to change the common-code API, we don't need
coordinated changes among multiple architectures, and architectures
using real NMIs need not change.

							Thanx, Paul
