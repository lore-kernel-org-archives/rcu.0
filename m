Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003A41BD9E5;
	Wed, 30 Oct 2024 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730330791; cv=none; b=Z1sGQoQfNgpsa1kTeY5YToCT9FFIg0bywXtazcUGRO3Bw9zHPrMdNLZ5s8Z7oW2m6yDe1I6cPnbw1iGqKZ6jR25PfoTnbiwGgYkAMVaiQZwIbqnN10aBaGmG1kcclSnTk091nDIEvX4trxdHY6yqbIDVPUrbZsWpnXlSitDmZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730330791; c=relaxed/simple;
	bh=k6u6rTWgbtqX5RZS91709xj4B2edbqg5JCf0JPVmVBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlJTQsiulDTt6LuSc70MNcQCV+wnk/JdKTIF43IOOypyyxx2TPfaINVJyBK99pUQRkUcbPzePdBngJGYu5xeJ0Pueoc+tzpssgV1KuQi/75XRaP96ziWG7TTB+/3BKNx3tnFMQfekkOPvLPBSgNA0E40fpBwW9OWz78Qn9d4Jlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hek6yvWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hek6yvWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDA0C4CEE4;
	Wed, 30 Oct 2024 23:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730330790;
	bh=k6u6rTWgbtqX5RZS91709xj4B2edbqg5JCf0JPVmVBo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hek6yvWivPN5tc0Wpc1yFBr75EBEGrpSLdC2EK47W906pDwJSi6ahh6MGxLZOh424
	 OAYrHHKR9uqyFxQ8u7ObPzUZq5SO0lXiuVzo6PIvzUPRuX/o+I5t0+4AUVMoPnsq8Y
	 2Nf7G+GliED1X6v4abBLghup1M87ql+bA7HsUHTWkLZM/eXGVDZQDA9zD24iB21tKt
	 UfEim2HQEIxfWHj36RA00c0u0RLvJK7j2HziEqB78dPSqKZK96WdBGttp1P5x42O1A
	 m1dJbEGjPAS7cNNc1nhXHZcvwJbt7PKReJ9H4LBgJs3/xwu+ekjuc64NokorMLlJ4W
	 kLOhWDe+Hp05Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1EBCECE0864; Wed, 30 Oct 2024 16:26:30 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:26:30 -0700
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
Message-ID: <63859e70-2ea7-4a67-857c-fa226566f25a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
 <20241016161931.478592-3-paulmck@kernel.org>
 <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
 <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>
 <adb044e2-8f62-4367-9a22-30515f5647b1@paulmck-laptop>
 <d0adc7d14da0f21909eef68acf19fc5706a4b1af.camel@mediatek.com>
 <9e90d04e-081b-4730-890b-295ed52747de@paulmck-laptop>
 <CAD=FV=WBcOCGbD0haRYLGgAFpDhfoqMW8mvj9DEA0CSPHG3Owg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WBcOCGbD0haRYLGgAFpDhfoqMW8mvj9DEA0CSPHG3Owg@mail.gmail.com>

On Wed, Oct 30, 2024 at 01:12:01PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Oct 30, 2024 at 6:54 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > > > We do assume that nmi_trigger_cpumask_backtrace() uses true NMIs, so,
> > > > yes, nmi_trigger_cpumask_backtrace() should use true NMIs, just like
> > > > the name says.  ;-)
> > >
> > > In the comments of following patch, the arm64 maintainers have
> > > differing views on the use of nmi_trigger_cpumask_backtrace(). I'm a
> > > bit confused and unsure which perspective is more reasonable.
> > >
> > > https://lore.kernel.org/all/20230906090246.v13.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid/
> >
> > I clearly need to have a chat with the arm64 maintainers, and thank
> > you for checking.
> >
> > > > /*
> > > >  * NOTE: though nmi_trigger_cpumask_backtrace() has "nmi_" in the
> > > name,
> > > >  * nothing about it truly needs to be implemented using an NMI, it's
> > > >  * just that it's _allowed_ to work with NMIs. If ipi_should_be_nmi()
> > > >  * returned false our backtrace attempt will just use a regular IPI.
> > > >  */
> > >
> > > > Alternatively, arm64 could continue using nmi_trigger_cpumask_backtrace()
> > > > with normal interrupts (for example, on SoCs not implementing true NMIs),
> > > > but have a short timeout (maybe a few jiffies?) after which its returns
> > > > false (and presumably also cancels the backtrace request so that when
> > > > the non-NMI interrupt eventually does happen, its handler simply returns
> > > > without backtracing).  This should be implemented using atomics to avoid
> > > > deadlock issues.  This alternative approach would provide accurate arm64
> > > > backtraces in the common case where interrupts are enabled, but allow
> > > > a graceful fallback to remote tracing otherwise.
> > > >
> > > > Would you be interested in working this issue, whatever solution the
> > > > arm64 maintainers end up preferring?
> > >
> > > The 10-second timeout is hard-coded in nmi_trigger_cpumask_backtrace().
> > > It is shared code and not architecture-specific. Currently, I haven't
> > > thought of a feasible solution. I have also CC'd the authors of the
> > > aforementioned patch to see if they have any other ideas.
> >
> > It should be possible for arm64 to have an architecture-specific hook
> > that enables them to use a much shorter timeout.  Or, to eventually
> > switch to real NMIs.
> 
> Note that:
> 
> * Switching to real NMIs is impossible on many existing arm64 CPUs.
> The hardware support simply isn't there. Pseudo-NMIs should work fine
> and are (in nearly all cases) just as good as NMIs but they have a
> small performance impact. There are also compatibility issues with
> some pre-existing bootloaders. ...so code can't assume even Pseudo-NMI
> will work and needs to be able to fall back. Prior to my recent
> changes arm64 CPUs wouldn't even do stacktraces in some scenarios. Now
> at least they fall back to regular IPIs.

But those IPIs are of no help whatsoever when the target CPU is spinning
with interrupts disabled, which is the scenario under discussion.

Hence my suggestion that arm64, when using IRQs to request stack
backtraces, have an additional short timeout (milliseconds) in
order to fall back to remote stack tracing.  In many cases, this
fallback happens automatically, as you can see in dump_cpu_task().
If trigger_single_cpu_backtrace() returns false, the stack is dumped
remotely.

> * Even if we decided that we absolutely had to disable stacktrades on
> arm64 CPUs without some type of NMI, that won't fix arm32. arm32 has
> been using regular IPIs for backtraces like this for many, many years.
> Maybe folks don't care as much about arm32 anymore but it feels bad if
> we totally break it.

Because arm32 isn't used much for datacenter workloads, it will not
be suffering from this issue.  Not enough to have motivated anyone to
fix it, anyway.  In contrast, in the datacenter, CPUs really can and
do have interrupts disabled for many seconds.  (No, this is not a good
thing, but it is common enough for us to need to avoid disabling other
debugging facilities.)

So it might well be that arm32 will continue to do just fine with
IRQ-based stack tracing.  Or maybe someday arm32 will also need to deal
with this same issue.  But no "maybe" for arm64, given its increasing
use in the datacenter.

> IMO waiting 10 seconds for a backtrace is pretty crazy to begin with.
> What about just changing that globally to 1 second? If not, it doesn't
> feel like it would be impossibly hard to make an arch-specific
> callback to choose the time and that callback could even take into
> account whether we managed to get an NMI. I'd be happy to review such
> a patch.

Let's please keep the 10-second timeout for NMI-based backtraces.

But I take it that you are not opposed to a shorter timeout for the
special case of IRQ-based stack backtrace requests?

							Thanx, Paul
