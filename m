Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4627610E0;
	Thu, 31 Oct 2024 05:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730351012; cv=none; b=TZFMdKKS+O49aezyiZqixz5eT+K41FSpO1gYNXQDi2MbvOcij/FyGTaVGFVIiIbcvrDiz72Igv4RP0dozIuP/T3i6pnMVH51qH25yZGsAtJPNWtFLDUky3/4Vs2t9TIbNHjqUAijo80NsCaCJgDYRacyvdCkgFz2sHn9H4n/dpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730351012; c=relaxed/simple;
	bh=crqaGcpCs9QPG86QUyQdTNr4bi8mDvhVfJheQXLl5wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0kKCwzBokp0ur2wUMwbTsDwpHawB4Qhbzqovb5Z4PkQTq/4olhVX6cHw/0TjT7Bno6j6XBaB11SY4/ANFAVGy45g8p7cAdUwuK5Jz3TL2x0tYbTE6rDgnvNdHFiAArPwtAwO4NQM7PPliO9uwDjU0Ucjgfn3s9J6LPInuEeTaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMY3mB+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMY3mB+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FECC4CEC3;
	Thu, 31 Oct 2024 05:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730351011;
	bh=crqaGcpCs9QPG86QUyQdTNr4bi8mDvhVfJheQXLl5wc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hMY3mB+YLobcZV0zcJtOZAokvAVMuOHncN1p1ZESqp7uMxbBrdaRsc/DVeJKhv/AR
	 hdOBBVhHoa5Impr2dqzsTEbMgY6mAPvId6bwQU5BR1g88DPbNiJ8Ubfn8EZpFPRkKD
	 Rv5CeloM/Fa8EHEu/Jei/2mfwwjQtTritcBhckKR/MGWFBr6MuITntNEzveh7+AJPb
	 Im0kg1ZZc8A40+a2G4brwgtlSStnTDtqms+/Ds3vBnvRMSOssrSFOVqGAIp/aWdoF4
	 nGi1tSr8FaxlUaUjN6zLyaFKng5dzZimvA0eOTMAKuhCnGb7ycEYxeMovWztezSLEw
	 8L6Nyr+8cpuKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 58636CE0995; Wed, 30 Oct 2024 22:03:31 -0700 (PDT)
Date: Wed, 30 Oct 2024 22:03:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Cheng-Jui Wang =?utf-8?B?KOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>,
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
Message-ID: <1617541e-4853-4567-b9c0-febf1cfa26a8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
 <20241016161931.478592-3-paulmck@kernel.org>
 <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
 <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>
 <adb044e2-8f62-4367-9a22-30515f5647b1@paulmck-laptop>
 <d0adc7d14da0f21909eef68acf19fc5706a4b1af.camel@mediatek.com>
 <9e90d04e-081b-4730-890b-295ed52747de@paulmck-laptop>
 <CAD=FV=WBcOCGbD0haRYLGgAFpDhfoqMW8mvj9DEA0CSPHG3Owg@mail.gmail.com>
 <63859e70-2ea7-4a67-857c-fa226566f25a@paulmck-laptop>
 <CAD=FV=WsM=om=xobfWkC8nLQNK89xdyNNX=L1=DjD79ZPXYxRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WsM=om=xobfWkC8nLQNK89xdyNNX=L1=DjD79ZPXYxRg@mail.gmail.com>

On Wed, Oct 30, 2024 at 05:21:13PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Oct 30, 2024 at 4:27 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Oct 30, 2024 at 01:12:01PM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Wed, Oct 30, 2024 at 6:54 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > > > We do assume that nmi_trigger_cpumask_backtrace() uses true NMIs, so,
> > > > > > yes, nmi_trigger_cpumask_backtrace() should use true NMIs, just like
> > > > > > the name says.  ;-)
> > > > >
> > > > > In the comments of following patch, the arm64 maintainers have
> > > > > differing views on the use of nmi_trigger_cpumask_backtrace(). I'm a
> > > > > bit confused and unsure which perspective is more reasonable.
> > > > >
> > > > > https://lore.kernel.org/all/20230906090246.v13.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid/
> > > >
> > > > I clearly need to have a chat with the arm64 maintainers, and thank
> > > > you for checking.
> > > >
> > > > > > /*
> > > > > >  * NOTE: though nmi_trigger_cpumask_backtrace() has "nmi_" in the
> > > > > name,
> > > > > >  * nothing about it truly needs to be implemented using an NMI, it's
> > > > > >  * just that it's _allowed_ to work with NMIs. If ipi_should_be_nmi()
> > > > > >  * returned false our backtrace attempt will just use a regular IPI.
> > > > > >  */
> > > > >
> > > > > > Alternatively, arm64 could continue using nmi_trigger_cpumask_backtrace()
> > > > > > with normal interrupts (for example, on SoCs not implementing true NMIs),
> > > > > > but have a short timeout (maybe a few jiffies?) after which its returns
> > > > > > false (and presumably also cancels the backtrace request so that when
> > > > > > the non-NMI interrupt eventually does happen, its handler simply returns
> > > > > > without backtracing).  This should be implemented using atomics to avoid
> > > > > > deadlock issues.  This alternative approach would provide accurate arm64
> > > > > > backtraces in the common case where interrupts are enabled, but allow
> > > > > > a graceful fallback to remote tracing otherwise.
> > > > > >
> > > > > > Would you be interested in working this issue, whatever solution the
> > > > > > arm64 maintainers end up preferring?
> > > > >
> > > > > The 10-second timeout is hard-coded in nmi_trigger_cpumask_backtrace().
> > > > > It is shared code and not architecture-specific. Currently, I haven't
> > > > > thought of a feasible solution. I have also CC'd the authors of the
> > > > > aforementioned patch to see if they have any other ideas.
> > > >
> > > > It should be possible for arm64 to have an architecture-specific hook
> > > > that enables them to use a much shorter timeout.  Or, to eventually
> > > > switch to real NMIs.
> > >
> > > Note that:
> > >
> > > * Switching to real NMIs is impossible on many existing arm64 CPUs.
> > > The hardware support simply isn't there. Pseudo-NMIs should work fine
> > > and are (in nearly all cases) just as good as NMIs but they have a
> > > small performance impact. There are also compatibility issues with
> > > some pre-existing bootloaders. ...so code can't assume even Pseudo-NMI
> > > will work and needs to be able to fall back. Prior to my recent
> > > changes arm64 CPUs wouldn't even do stacktraces in some scenarios. Now
> > > at least they fall back to regular IPIs.
> >
> > But those IPIs are of no help whatsoever when the target CPU is spinning
> > with interrupts disabled, which is the scenario under discussion.
> 
> Right that we can't trace the target CPU spinning with interrupts
> disabled.

You can by invoking sched_show_task(cpu_curr(cpu)) on the CPU requesting
the backtrace.  The resulting backtrace will not be as good as you
would get from using an NMI, but if you don't have NMIs, it is better
than nothing.

>           ...but in the case where NMI isn't available it _still_
> makes sense to make arch_trigger_cpumask_backtrace() fall back to IPI
> because:
> 
> 1. There are many cases where the trigger.*cpu.*backtrace() class of
> functions are used to trace CPUs that _aren't_ looping with interrupts
> disabled. We still want to be able to backtrace in that case. For
> instance, you can see in "panic.c" that there are cases where
> trigger_all_cpu_backtrace() is called. It's valuable to make cases
> like this (where there's no indication that a CPU is locked) actually
> work.
> 
> 2. Even if there's a CPU that's looping with interrupts disabled and
> we can't trace it because of no NMI, it could still be useful to get
> backtraces of other CPUs. It's possible that what the other CPUs are
> doing could give a hint about the CPU that's wedged. This isn't a
> great hint, but some info is better than no info.

And it also makes sense for an IRQ-based backtrace to fall back to
something like the aforementioned sched_show_task(cpu_curr(cpu)) if
the destination CPU has interrupts disabled.

> > Hence my suggestion that arm64, when using IRQs to request stack
> > backtraces, have an additional short timeout (milliseconds) in
> > order to fall back to remote stack tracing.  In many cases, this
> > fallback happens automatically, as you can see in dump_cpu_task().
> > If trigger_single_cpu_backtrace() returns false, the stack is dumped
> > remotely.
> 
> I think the answer here is that the API needs to change. The whole
> boolean return value for trigger.*cpu.*backtrace() is mostly ignored
> by callers. Yes, you've pointed at one of the two places that it's not
> ignored and it tries a reasonable fallback, but all the other callers
> just silently do nothing when the function returns false. That led to
> many places where arm64 devices were simply not getting _any_
> stacktrace.
> 
> Perhaps we need some type of API that says "I actually have a
> fallback, so if you don't think the stracktrace will succeed then it's
> OK to return false".

Boolean is fine for trigger_single_cpu_backtrace(), which is directed at
a single CPU.  And the one call to this function that does not currently
check its return value could just call dump_cpu_task() instead.

There are only 20 or so uses of all of these functions, so the API can
change, give or take the pain involved in changing architecture-specific
code.

> > > * Even if we decided that we absolutely had to disable stacktrades on
> > > arm64 CPUs without some type of NMI, that won't fix arm32. arm32 has
> > > been using regular IPIs for backtraces like this for many, many years.
> > > Maybe folks don't care as much about arm32 anymore but it feels bad if
> > > we totally break it.
> >
> > Because arm32 isn't used much for datacenter workloads, it will not
> > be suffering from this issue.  Not enough to have motivated anyone to
> > fix it, anyway.  In contrast, in the datacenter, CPUs really can and
> > do have interrupts disabled for many seconds.  (No, this is not a good
> > thing, but it is common enough for us to need to avoid disabling other
> > debugging facilities.)
> >
> > So it might well be that arm32 will continue to do just fine with
> > IRQ-based stack tracing.  Or maybe someday arm32 will also need to deal
> > with this same issue.  But no "maybe" for arm64, given its increasing
> > use in the datacenter.
> 
> IMO the answer here is that anyone in datacenters should just turn on
> pseudo NMI (or NMI on newer arm64 CPUs).

Suppose datacenters all do this.  What part of this issue remains?

> > > IMO waiting 10 seconds for a backtrace is pretty crazy to begin with.
> > > What about just changing that globally to 1 second? If not, it doesn't
> > > feel like it would be impossibly hard to make an arch-specific
> > > callback to choose the time and that callback could even take into
> > > account whether we managed to get an NMI. I'd be happy to review such
> > > a patch.
> >
> > Let's please keep the 10-second timeout for NMI-based backtraces.
> >
> > But I take it that you are not opposed to a shorter timeout for the
> > special case of IRQ-based stack backtrace requests?
> 
> IMO the 10 second is still awfully long (HW watchdogs can trigger
> during that time), but I'm not that upset by it. I'm OK with shorter
> timeouts for IRQ-based ones, though I'm not sure I'd be OK w/ timeouts
> measured in milliseconds unless the caller has actually said that they
> can handle a "false" return or the caller says that it's more
> important to be quick than to wait for a long time.

If you are using NMIs, and the CPU doesn't respond in 10 seconds,
something is likely broken.  Maybe bad firmware or bad hardware.  You are
right that watchdogs might trigger, but they are likely already triggering
due to the target CPU being so firmly locked up that it is not responding
even to NMIs.

On the other hand, when you are not using NMIs, then I agree
you want a shorter timeout before remotely tracing the staek via
sched_show_task(cpu_curr(cpu)).  I picked a few milliseconds, but if
datacenters are using real NMIs or pseudo NMIs (and thus are not being
blocked by normal interrupt disabling), then I must defer to others on
the default timeout.  Much depends on the workload and configuration.

						Thanx, Paul
