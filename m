Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B61C3BFC;
	Mon, 29 Dec 2025 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767027755; cv=none; b=Tsjcyuxe4XWy8B4I9CuwpDmWzok92fdJKxbFVDUTWjGd39nsHzdgfHckFVP9vOf09H0y96P9jSpMNPdIkauBJrc3JeFCE7dXqGRi7jzJJO6eUhIoq1Sadj9LR/69UW7qOQ/P4Szp6VGMoijZX4vcue1t3GFvDmCEoLJZPhSfDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767027755; c=relaxed/simple;
	bh=EZZDJKj3MVgE4Vn45oCEjolF7rTHIlE28aJqqtfiJIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXitaGaErM+4R5N+WHK9jcTu7LMqgm0wroEPRNnRV/Pkm5GFWE+eSaYuo6ckvw20Yuj67jgxUvBL0KhThkh9tLB+vOn1OU9QkgDN6ylJETdPyt1O/xrMT9m1iOanA/sVHdru78oebMLYLbGeE2iwvaSQPpdgyy6tUkkScnBh+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/g0yzEo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/g0yzEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4998C4CEF7;
	Mon, 29 Dec 2025 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767027754;
	bh=EZZDJKj3MVgE4Vn45oCEjolF7rTHIlE28aJqqtfiJIQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=u/g0yzEo/vOkYU4UwAtjHde3eIT+35z9bFm2xj8GbDtF3ebyvx64aSrYrbkCQwtw9
	 9WewSIC7qjS7AC/1OwGj8l5DYI+ydWUyP0aRWpwjFla3tszYdTLyGNHtymquiR0m0O
	 t+YMqO1e+kH0AbLFA226WU9HQV33GiRYPIQJUOG2nIG9uVMSy92k1wJWzgdkyVtrsL
	 O2Cjh7T/IkfDHND80lcSWX/o3xCOMuau3cRcWxAaQhiHTIyTzcrCEsCz37oI2eHoes
	 wxer9frWmcnsVP5ycXNlBDnCzjEsWFaJSXrTeLAfu3gNAkH9w05UTIQMlewesqs5bW
	 nH2t9c1kiKMCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 866CACE0C97; Mon, 29 Dec 2025 09:02:34 -0800 (PST)
Date: Mon, 29 Dec 2025 09:02:34 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Reduce synchronize_rcu() latency by reporting GP
 kthread's CPU QS early
Message-ID: <8a7dcb6e-86cc-4abf-8496-9f38fb4e951f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1033a68f-c17b-4847-819d-7fb4e9e45016@paulmck-laptop>
 <164E7707-758C-44AA-BB75-B6560725C8CD@joelfernandes.org>
 <c75d4449-8329-4bf8-a4d9-03dec02c054e@paulmck-laptop>
 <20251229162840.GA361967@joelbox2>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251229162840.GA361967@joelbox2>

On Mon, Dec 29, 2025 at 11:28:40AM -0500, Joel Fernandes wrote:
> On Sun, Dec 28, 2025 at 08:37:14PM -0800, Paul E. McKenney wrote:
> > On Sun, Dec 28, 2025 at 09:49:45PM -0500, Joel Fernandes wrote:
> > > 
> > > 
> > > > On Dec 28, 2025, at 7:04 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > 
> > > > ﻿On Sun, Dec 28, 2025 at 06:57:58PM +0100, Uladzislau Rezki wrote:
> > > >>> On Thu, Dec 25, 2025 at 09:33:39PM -0500, Joel Fernandes wrote:
> > > >>> On Thu, Dec 25, 2025 at 10:35:44AM -0800, Paul E. McKenney wrote:
> > > >>>> On Mon, Dec 22, 2025 at 10:46:29PM -0500, Joel Fernandes wrote:
> > > >>>>> The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
> > > >>>>> State) design where the first FQS saves dyntick-idle snapshots and
> > > >>>>> the second FQS compares them. This results in long and unnecessary latency
> > > >>>>> for synchronize_rcu() on idle systems (two FQS waits of ~3ms each with
> > > >>>>> 1000HZ) whenever one FQS wait sufficed.
> > > >>>>> 
> > > >>>>> Some investigations showed that the GP kthread's CPU is the holdout CPU
> > > >>>>> a lot of times after the first FQS as - it cannot be detected as "idle"
> > > >>>>> because it's actively running the FQS scan in the GP kthread.
> > > >>>>> 
> > > >>>>> Therefore, at the end of rcu_gp_init(), immediately report a quiescent
> > > >>>>> state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). The
> > > >>>>> GP kthread cannot be in an RCU read-side critical section while running
> > > >>>>> GP initialization, so this is safe and results in significant latency
> > > >>>>> improvements.
> > > >>>>> 
> > > >>>>> I benchmarked 100 synchronize_rcu() calls with 32 CPUs, 10 runs each
> > > >>>>> showing significant latency improvements (default settings for fqs jiffies):
> > > >>>>> 
> > > >>>>> Baseline (without fix):
> > > >>>>> | Run | Mean      | Min      | Max       |
> > > >>>>> |-----|-----------|----------|-----------|
> > > >>>>> | 1   | 10.088 ms | 9.989 ms | 18.848 ms |
> > > >>>>> | 2   | 10.064 ms | 9.982 ms | 16.470 ms |
> > > >>>>> | 3   | 10.051 ms | 9.988 ms | 15.113 ms |
> > > >>>>> | 4   | 10.125 ms | 9.929 ms | 22.411 ms |
> > > >>>>> | 5   |  8.695 ms | 5.996 ms | 15.471 ms |
> > > >>>>> | 6   | 10.157 ms | 9.977 ms | 25.723 ms |
> > > >>>>> | 7   | 10.102 ms | 9.990 ms | 20.224 ms |
> > > >>>>> | 8   |  8.050 ms | 5.985 ms | 10.007 ms |
> > > >>>>> | 9   | 10.059 ms | 9.978 ms | 15.934 ms |
> > > >>>>> | 10  | 10.077 ms | 9.984 ms | 17.703 ms |
> > > >>>>> 
> > > >>>>> With fix:
> > > >>>>> | Run | Mean     | Min      | Max       |
> > > >>>>> |-----|----------|----------|-----------|
> > > >>>>> | 1   | 6.027 ms | 5.915 ms |  8.589 ms |
> > > >>>>> | 2   | 6.032 ms | 5.984 ms |  9.241 ms |
> > > >>>>> | 3   | 6.010 ms | 5.986 ms |  7.004 ms |
> > > >>>>> | 4   | 6.076 ms | 5.993 ms | 10.001 ms |
> > > >>>>> | 5   | 6.084 ms | 5.893 ms | 10.250 ms |
> > > >>>>> | 6   | 6.034 ms | 5.908 ms |  9.456 ms |
> > > >>>>> | 7   | 6.051 ms | 5.993 ms | 10.000 ms |
> > > >>>>> | 8   | 6.057 ms | 5.941 ms | 10.001 ms |
> > > >>>>> | 9   | 6.016 ms | 5.927 ms |  7.540 ms |
> > > >>>>> | 10  | 6.036 ms | 5.993 ms |  9.579 ms |
> > > >>>>> 
> > > >>>>> Summary:
> > > >>>>> - Mean latency: 9.75 ms -> 6.04 ms (38% improvement)
> > > >>>>> - Max latency:  25.72 ms -> 10.25 ms (60% improvement)
> > > >>>>> 
> > > >>>>> Tested rcutorture TREE and SRCU configurations.
> > > >>>>> 
> > > >>>>> [apply paulmck feedack on moving logic to rcu_gp_init()]
> > > >>>> 
> > > >>>> If anything, these numbers look better, so good show!!!
> > > >>> 
> > > >>> Thanks, I ended up collecting more samples in the v2 to further confirm the
> > > >>> improvements.
> > > >>> 
> > > >>>> Are there workloads that might be hurt by some side effect such
> > > >>>> as increased CPU utilization by the RCU grace-period kthread?  One
> > > >>>> non-mainstream hypothetical situation that comes to mind is a kernel
> > > >>>> built with SMP=y but running on a single-CPU system with a high-frequence
> > > >>>> periodic interrupt that does call_rcu().  Might that result in the RCU
> > > >>>> grace-period kthread chewing up the entire CPU?
> > > >>> 
> > > >>> There are still GP delays due to FQS, even with this change, so it could not
> > > >>> chew up the entire CPU I believe. The GP cycle should still insert delays
> > > >>> into the GP kthread. I did not notice in my testing that synchronize_rcu()
> > > >>> latency dropping to sub millisecond, it was still limited by the timer wheel
> > > >>> delays and the FQS delays.
> > > >>> 
> > > >>>> For a non-hypothetical case, could you please see if one of the
> > > >>>> battery-powered embedded guys would be willing to test this?
> > > >>> 
> > > >>> My suspicion is the battery-powered folks are already running RCU_LAZY to
> > > >>> reduce RCU activity, so they wouldn't be effected. call_rcu() during idleness
> > > >>> will be going to the bypass. Last I checked, Android and ChromeOS were both
> > > >>> enabling RCU_LAZY everywhere (back when I was at Google).
> > > >>> 
> > > >>> Uladzislau works on embedded (or at least till recently) and had recently
> > > >>> checked this area for improvements so I think he can help quantify too
> > > >>> perhaps. He is on CC. I personally don't directly work on embedded at the
> > > >>> moment, just big compute hungry machines. ;-) Uladzislau, would you have some
> > > >>> time to test on your Android devices?
> > > >>> 
> > > >> I will check the patch on my home based systems, big machines also :)
> > > >> I do not work with mobile area any more thus do not have access to our
> > > >> mobile devices. In fact i am glad that i have switched to something new.
> > > >> I was a bit tired by the applied Google restrictions when it comes to
> > > >> changes to the kernel and other Android layers.
> > > > 
> > > > How quickly I forget!  ;-)
> > > > 
> > > > Any thoughts on who would be a good person to ask about testing Joel's
> > > > patch on mobile platforms?
> > > 
> > > Maybe Suren? As precedent and fwiw, When rcu_normal_wake_from_gp
> > > optimization happened, it only improved things for Android.
> > > 
> > > Also Android already uses RCU_LAZY so this should not affect power for
> > > non-hurry usages.
> > > 
> > > Also networking bridge removal depends on synchronize_rcu() latency. When
> > > I forced rcu_normal_wake_from_gp on large machines, it improved bridge
> > > removal speed by about 5% per my notes. I would expect similar
> > > improvements with this.
> > 
> > Could you please try running on a single-CPU system or VM to check the
> > CPU overhead from RCU's grace-period kthread?
> 
> Hi, Paul,
> 
> I ran some tests with single CPU and used perf to measure overhead of the
> GP kthread (rcu_preempt).
> 
> Actually, the GP kthread's CPU usage goes down, I believe this is because it
> sleeps more.
> 
> I see similar/same results with synchronize_rcu() loop (200 iterations). I
> also tested call_rcu() stressing from timer interrupts and call_rcu_hurry()
> flooding.
> 
>                           Baseline    With Patch    Change
>   task-clock:             1008 ms     898 ms        -11%
>   CPU cycles:             48M         44M           -8%
> 
> Should I add these results to the changelog and send out a v3 (preferrably
> with your review tag if you approve).

Very good, and sounds good!

							Thanx, Paul
