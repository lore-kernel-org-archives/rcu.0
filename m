Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2F200C3
	for <rcu@vger.kernel.org>; Tue,  6 Feb 2024 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245076; cv=none; b=VbFAJ+6p0EjREouhULFM8MpuFaH5rgYJzKpKLu81zycaminLrLriI3S2o8M2o4qFLQIN1OXjUssgMyGYCeIWLvuBMU9kZ8w4eqUQ00ZMlga5bepdpSw+Sm/qncw4aCFSgsoBWhK2Tohb/6n87Q4HfaY2ugujqWxoU+xiD04ETok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245076; c=relaxed/simple;
	bh=1TLpM9VBd/UNID1rDJ0TtJBNTWRi5+7vHsCOepvvho4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCDFaJmNcayQzzBnrEGR8zu3bdnnm4DFv9FAlBbogVKOgdy0hErFwHryzSBeAIeGSZkwwvAHNUzZBADJA+Ok8JmF+5W6fCCj8WHp8yPHBNWd1M41GgS/gTjyfBSPqlIvWScqNuFOUmg+0zrcgCvdx8LjmDKlb9PRoRSFYAp0FE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ2dwnDp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ2dwnDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC484C433C7;
	Tue,  6 Feb 2024 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707245076;
	bh=1TLpM9VBd/UNID1rDJ0TtJBNTWRi5+7vHsCOepvvho4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PZ2dwnDpARMJvtVwkxYyQRnsakgKn8T3hPsWXOUxxRTSsiZLmbyEk34TPVNNeO6KF
	 LpcPbbY6fmZaYbgy00d/cJfHB0v3ocSCJ/qqdGKUgIxAOW7VuAWGRVR5PBuXsudL7A
	 uaqqT2czJG7szpsbqc7lKtEQ/vn1qX1qLn6VKwKcY3/0kxraqb3Ab+0mb38tBNWhzy
	 yrq1U7VgBB6bLj9lk1fptvtPICImz7/TuP8Y5EUgEhKWj/i3eSDVq+rCbOhIcWVMVp
	 e84hXbju7+OS1Ew5fVysARQ/S5qO/ycdz+YQiMNC9m5OekpCNzYWu81eECBd67Dyq+
	 DHwWsXU5IcnsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 01E83CE0AB0; Tue,  6 Feb 2024 10:44:34 -0800 (PST)
Date: Tue, 6 Feb 2024 10:44:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <92cba6df-01de-4daa-a0cb-5fa92c7374dd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd>
 <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636>
 <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
 <ZcJxhoNpkTM7LnOr@gpd>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcJxhoNpkTM7LnOr@gpd>

On Tue, Feb 06, 2024 at 06:51:02PM +0100, Andrea Righi wrote:
> On Tue, Jan 30, 2024 at 05:39:37AM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 30, 2024 at 12:27:43PM +0100, Andrea Righi wrote:
> > > On Tue, Jan 30, 2024 at 12:06:49PM +0100, Uladzislau Rezki wrote:
> > > > On Tue, Jan 30, 2024 at 02:17:22AM -0800, Paul E. McKenney wrote:
> > > > > On Tue, Jan 30, 2024 at 07:58:18AM +0100, Andrea Righi wrote:
> > > > > > Hi Joel and Paul,
> > > > > > 
> > > > > > comments below.
> > > > > > 
> > > > > > On Mon, Jan 29, 2024 at 05:16:38PM -0500, Joel Fernandes wrote:
> > > > > > > Hi Paul,
> > > > > > > 
> > > > > > > On 1/29/2024 3:41 PM, Paul E. McKenney wrote:
> > > > > > > > On Mon, Jan 29, 2024 at 05:47:39PM +0000, Joel Fernandes wrote:
> > > > > > > >> Hi Guys,
> > > > > > > >> Something caught my eye in [1] which a colleague pointed me to
> > > > > > > >>  - CONFIG_HZ=1000 : 14866.05 bogo ops/s
> > > > > > > >>  - CONFIG_HZ=1000+nohz_full : 18505.52 bogo ops/s
> > > > > > > >>
> > > > > > > >> The test in concern is:
> > > > > > > >> stress-ng --matrix $(getconf _NPROCESSORS_ONLN) --timeout 5m --metrics-brief
> > > > > > > >>
> > > > > > > >> which is a CPU intensive test.
> > > > > > > >>
> > > > > > > >> Any thoughts on what else can attribute a 30% performance increase
> > > > > > > >> versus non-nohz_full ? (Confession: No idea if the baseline is
> > > > > > > >> nohz_idle or no nohz at all). If it is 30%, I may want to evaluate
> > > > > > > >> nohz_full on some of our limited-CPU devices :)
> > > > > > > > 
> > > > > > > > The usual questions.  ;-)
> > > > > > > > 
> > > > > > > > Is this repeatable?  Is it under the same conditions of temperature,
> > > > > > > > load, and so on?  Was it running on bare metal or on a guest OS?  If on a
> > > > > > > > guest OS, what was the load from other guest OSes on the same hypervisor
> > > > > > > > or on the hypervisor itself?
> > > > > > 
> > > > > > That was the result of a quick test, so I expect it has some fuzzyness
> > > > > > in there.
> > > > > > 
> > > > > > It's an average of 10 runs, it was bare metal (my laptop, 8 cores 11th
> > > > > > Gen Intel(R) Core(TM) i7-1195G7 @ 2.90GHz), *but* I wanted to run the
> > > > > > test with the default Ubuntu settings, that means having "power mode:
> > > > > > balanced" enabled. I don't know exactly what it's doing (I'll check how
> > > > > > it works in details), I think it's using intel p-states IIRC.
> > > > > > 
> > > > > > Also, the system was not completely isolated (my email client was
> > > > > > running) but the system was mostly idle in general.
> > > > > > 
> > > > > > I was already planning to repeat the tests in a more "isolated"
> > > > > > environment and add details to the bug tracker.
> > > > > > 
> > > > > > > > 
> > > > > > > > The bug report ad "CONFIG_HZ=250 : 17415.60 bogo ops/s", which makes
> > > > > > > > me wonder if someone enabled some heavy debug that is greatly
> > > > > > > > increasing the overhead of the scheduling-clock interrupt.
> > > > > > > > 
> > > > > > > > Now, if that was the case, I would expect the 250HZ number to have
> > > > > > > > three-quarters of the improvement of the nohz_full number compared
> > > > > > > > to the 1000HZ number:
> > > > > > > >> 17415.60-14866.05=2549.55
> > > > > > > > 18505.52-14866.05=3639.47
> > > > > > > > 
> > > > > > > > 2549.55/3639.47=0.70
> > > > > > > 
> > > > > > > I wonder if the difference here could possibly also be because of CPU idle
> > > > > > > governor. It may behave differently at differently clock rates so perhaps has
> > > > > > > different overhead.
> > > > > > 
> > > > > > Could be, but, again, the balanced power mode could play a major role
> > > > > > here.
> > > > > > 
> > > > > > > 
> > > > > > > I have added trying nohz full to my list as well to evaluate. FWIW, when we
> > > > > > > moved from 250HZ to 1000HZ, it actually improved power because the CPUidle
> > > > > > > governor could put the CPUs in deeper idle states more quickly!
> > > > > > 
> > > > > > Interesting, another benefit to add to my proposal. :)
> > > > > > 
> > > > > > > 
> > > > > > > > OK, 0.70 is not *that* far off of 0.75.  So what debugging does that
> > > > > > > > test have enabled?  Also, if you use tracing (or whatever) to measure
> > > > > > > > the typical duration of the scheduling-clock interrupt and related things
> > > > > > > > like softirq handlers, does it fit with these numbers?  Such a measurment
> > > > > > > > would look at how long it took to get back into userspace.
> > > > > 
> > > > > Just to emphasize...
> > > > > 
> > > > > The above calculations show that your measurements are close to what you
> > > > > would expect if scheduling-clock interrupts took longer than one would
> > > > > expect.  Here "scheduling-clock interrupts" includes softirq processing
> > > > > (timers, networking, RCU, ...)  that piggybacks on each such interrupt.
> > > > > 
> > > > > Although softirq makes the most sense given the amount of time that must
> > > > > be consumed, for the most part softirq work is conserved.  which suggests
> > > > > that you should also at the rest of the system to check whether the
> > > > > reported speedup is instead due to this work simply being moved to some
> > > > > other CPU.
> > > > > 
> > > > > But maybe the fat softirqs are due to some debugging option that Ubuntu
> > > > > enabled.  In which case checking up on the actual duration (perhaps
> > > > > using some form of tracing) would provide useful information.  ;-)
> > > > > 
> > > > As a first step i would have a look at perf figures what is going on
> > > > during a test run. For such purpose the "perf" tool can be used. As a
> > > > basic step it can be run in a "top" mode:
> > > > 
> > > > perf top -a -g -e cycles:k 
> > > > 
> > > > Sorry for the noise :)
> > > 
> > > Yep, I'm planning to do better tests and collect more info (perf,
> > > bpftrace). Also making sure that we don't have some crazy debugging
> > > config enabled in the Ubuntu kernel, as correctly pointed by Paul. But
> > > first of all I need to repeat the tests in a more isolated environment,
> > > just to make sure we're looking at reasonable numbers here.
> > 
> > Very good, and looking forward to seeing what you come up with!
> > 
> > 							Thanx, Paul
> 
> I repeated some tests in a more isolated environment and posted the
> results here:
> https://discourse.ubuntu.com/t/enable-low-latency-features-in-the-generic-ubuntu-kernel-for-24-04/42255
> 
> Highlights:
> 
>  - stress-ng --matrix seems quite unpredictable to be used a benchmarks
>    in this scenario (the bogo-ops/s are very susceptible to any kind of
>    interference, so even if in the long runs NO_HZ_FULL still seems to
>    provide some benefits looking at the average, we also need to
>    consider that there might be a significant error in the measurements,
>    standard deviation was pretty high)
> 
>  - fio doing short writes (in page cache) seems to perform like 2x
>    better in terms of iops with nohz_full, respect to the other cases
>    and it performs 2x slower with large IO writes (not sure why... need
>    to investigate more)
> 
>  - with lazy RCU enabled hrtimer_interrupt() takes like 2x more to
>    return, respect to the other cases (is this expected?)

This last is surprising at first glance, but I could be missing
something.  Joel, Uladzislau, thoughts?

							Thanx, Paul

> Let me know if you notice anything odd, if you need more information,
> etc.
> 
> Thanks,
> -Andrea
