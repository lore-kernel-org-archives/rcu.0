Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4D6D1C4
	for <rcu@vger.kernel.org>; Tue, 30 Jan 2024 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706621978; cv=none; b=d7pb49PDuMXcUO9WEK7Rcp0bKteFTF/IPcMBYsJ6fHxExT6YyPlMuRH4qXJpehX/dRi5QD/wHXgjyT2i7kq3NDywyysxsqvCWihtdxcCBTncJIo9Qop/c1lgq3yImPOZYdsYCyS4v+aDeVl5UaFAzkfLINXNUnL4ptwclHLm0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706621978; c=relaxed/simple;
	bh=KMoi9Uk2vtkVwTOZo2bbV3VroMcycAeUb9TYmWOX2rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmK3o0zXh0kdeUcgdhP84obo1qbGsVBwfQaZ4U9SGMP/UVlHlAn0Z2PIqpBkQsy2g7JbMEeQOd0BgKWMNK3o1ggHuj/3/v+ytS/4Hpe3jR/OiiKn1wqrsLRucWFnUpRHF6ETrnEidq2XmcuOMAdPXqH4vSzLICi/hnZjgJd8JjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWbeIkVr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWbeIkVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432F6C433F1;
	Tue, 30 Jan 2024 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706621978;
	bh=KMoi9Uk2vtkVwTOZo2bbV3VroMcycAeUb9TYmWOX2rM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AWbeIkVrMmCgSyiho7L5P90dkxMBQlvmbo3om1UAaxY1wEs65RUxtyo7cNYfIMw3j
	 1/SMvMO1jZQ+ITnMP8wa5tygB9iQHbebY2loOA7yvdFG2WY0r7fA//vemoeh7UrZLn
	 zH4AvdQpuHqqaA6A2UmTXMx+AoR+PI8mVZ4Fc1kno8Klyv1ZaNTK/l4oOAbpsKLu9K
	 y16fDtPZ4/JJQUdpOvY1QE90wjlJXENglLxtHGHqGqnZcm1oCX/bwDFP3eN7dnn5mI
	 umFTwZc63ET4RMRDQ/HV2gemwWZPknei6jitof2kzLyjqFnozDWXrpxUJCQu345fLI
	 ljCri9HK1Dzqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ED97ECE0975; Tue, 30 Jan 2024 05:39:37 -0800 (PST)
Date: Tue, 30 Jan 2024 05:39:37 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd>
 <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636>
 <ZbjdL04k2Z2ZdUyp@gpd>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbjdL04k2Z2ZdUyp@gpd>

On Tue, Jan 30, 2024 at 12:27:43PM +0100, Andrea Righi wrote:
> On Tue, Jan 30, 2024 at 12:06:49PM +0100, Uladzislau Rezki wrote:
> > On Tue, Jan 30, 2024 at 02:17:22AM -0800, Paul E. McKenney wrote:
> > > On Tue, Jan 30, 2024 at 07:58:18AM +0100, Andrea Righi wrote:
> > > > Hi Joel and Paul,
> > > > 
> > > > comments below.
> > > > 
> > > > On Mon, Jan 29, 2024 at 05:16:38PM -0500, Joel Fernandes wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > On 1/29/2024 3:41 PM, Paul E. McKenney wrote:
> > > > > > On Mon, Jan 29, 2024 at 05:47:39PM +0000, Joel Fernandes wrote:
> > > > > >> Hi Guys,
> > > > > >> Something caught my eye in [1] which a colleague pointed me to
> > > > > >>  - CONFIG_HZ=1000 : 14866.05 bogo ops/s
> > > > > >>  - CONFIG_HZ=1000+nohz_full : 18505.52 bogo ops/s
> > > > > >>
> > > > > >> The test in concern is:
> > > > > >> stress-ng --matrix $(getconf _NPROCESSORS_ONLN) --timeout 5m --metrics-brief
> > > > > >>
> > > > > >> which is a CPU intensive test.
> > > > > >>
> > > > > >> Any thoughts on what else can attribute a 30% performance increase
> > > > > >> versus non-nohz_full ? (Confession: No idea if the baseline is
> > > > > >> nohz_idle or no nohz at all). If it is 30%, I may want to evaluate
> > > > > >> nohz_full on some of our limited-CPU devices :)
> > > > > > 
> > > > > > The usual questions.  ;-)
> > > > > > 
> > > > > > Is this repeatable?  Is it under the same conditions of temperature,
> > > > > > load, and so on?  Was it running on bare metal or on a guest OS?  If on a
> > > > > > guest OS, what was the load from other guest OSes on the same hypervisor
> > > > > > or on the hypervisor itself?
> > > > 
> > > > That was the result of a quick test, so I expect it has some fuzzyness
> > > > in there.
> > > > 
> > > > It's an average of 10 runs, it was bare metal (my laptop, 8 cores 11th
> > > > Gen Intel(R) Core(TM) i7-1195G7 @ 2.90GHz), *but* I wanted to run the
> > > > test with the default Ubuntu settings, that means having "power mode:
> > > > balanced" enabled. I don't know exactly what it's doing (I'll check how
> > > > it works in details), I think it's using intel p-states IIRC.
> > > > 
> > > > Also, the system was not completely isolated (my email client was
> > > > running) but the system was mostly idle in general.
> > > > 
> > > > I was already planning to repeat the tests in a more "isolated"
> > > > environment and add details to the bug tracker.
> > > > 
> > > > > > 
> > > > > > The bug report ad "CONFIG_HZ=250 : 17415.60 bogo ops/s", which makes
> > > > > > me wonder if someone enabled some heavy debug that is greatly
> > > > > > increasing the overhead of the scheduling-clock interrupt.
> > > > > > 
> > > > > > Now, if that was the case, I would expect the 250HZ number to have
> > > > > > three-quarters of the improvement of the nohz_full number compared
> > > > > > to the 1000HZ number:
> > > > > >> 17415.60-14866.05=2549.55
> > > > > > 18505.52-14866.05=3639.47
> > > > > > 
> > > > > > 2549.55/3639.47=0.70
> > > > > 
> > > > > I wonder if the difference here could possibly also be because of CPU idle
> > > > > governor. It may behave differently at differently clock rates so perhaps has
> > > > > different overhead.
> > > > 
> > > > Could be, but, again, the balanced power mode could play a major role
> > > > here.
> > > > 
> > > > > 
> > > > > I have added trying nohz full to my list as well to evaluate. FWIW, when we
> > > > > moved from 250HZ to 1000HZ, it actually improved power because the CPUidle
> > > > > governor could put the CPUs in deeper idle states more quickly!
> > > > 
> > > > Interesting, another benefit to add to my proposal. :)
> > > > 
> > > > > 
> > > > > > OK, 0.70 is not *that* far off of 0.75.  So what debugging does that
> > > > > > test have enabled?  Also, if you use tracing (or whatever) to measure
> > > > > > the typical duration of the scheduling-clock interrupt and related things
> > > > > > like softirq handlers, does it fit with these numbers?  Such a measurment
> > > > > > would look at how long it took to get back into userspace.
> > > 
> > > Just to emphasize...
> > > 
> > > The above calculations show that your measurements are close to what you
> > > would expect if scheduling-clock interrupts took longer than one would
> > > expect.  Here "scheduling-clock interrupts" includes softirq processing
> > > (timers, networking, RCU, ...)  that piggybacks on each such interrupt.
> > > 
> > > Although softirq makes the most sense given the amount of time that must
> > > be consumed, for the most part softirq work is conserved.  which suggests
> > > that you should also at the rest of the system to check whether the
> > > reported speedup is instead due to this work simply being moved to some
> > > other CPU.
> > > 
> > > But maybe the fat softirqs are due to some debugging option that Ubuntu
> > > enabled.  In which case checking up on the actual duration (perhaps
> > > using some form of tracing) would provide useful information.  ;-)
> > > 
> > As a first step i would have a look at perf figures what is going on
> > during a test run. For such purpose the "perf" tool can be used. As a
> > basic step it can be run in a "top" mode:
> > 
> > perf top -a -g -e cycles:k 
> > 
> > Sorry for the noise :)
> 
> Yep, I'm planning to do better tests and collect more info (perf,
> bpftrace). Also making sure that we don't have some crazy debugging
> config enabled in the Ubuntu kernel, as correctly pointed by Paul. But
> first of all I need to repeat the tests in a more isolated environment,
> just to make sure we're looking at reasonable numbers here.

Very good, and looking forward to seeing what you come up with!

							Thanx, Paul
