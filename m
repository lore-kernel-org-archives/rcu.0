Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4075215F74;
	Fri, 20 Dec 2024 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734737164; cv=none; b=shjaLilXb/EJiZE8RLr6mjboqZOyMLm025x99pnzgW0v0KS5RNrz6zWZX1wLdh9E0W38f7LC+9Ntuzo/JbE6tKTjMCbYMB15lLWuO0LvNZtgf0oygeDeqVtr/XIK5aCllFv51w6GwjoHYp3Mjvo3qu8vJoLCtaYrtPWcOFLDj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734737164; c=relaxed/simple;
	bh=pSIbK50X7KhEVywpTEhdEM3e8CuEmUvS4q0T7m21IsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeqvqVzJtCJ5yGM5heJTseRGa5vXUUXGnzIHmpl/ikWlqYRlfephDR2ZnFZh1eDIICuK7zmxX4ljLUDrMX7LN7EF2bLkygQFrxuwoKMegJ3F9C14/RbLm/FH3w6QhWlE2M5/AUMjoIL46R0ivLf5MS5quXDbgcm1SX43ul9Soik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWQs5ivS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWQs5ivS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE41EC4CECD;
	Fri, 20 Dec 2024 23:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734737164;
	bh=pSIbK50X7KhEVywpTEhdEM3e8CuEmUvS4q0T7m21IsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWQs5ivSe4KCZiL+OETubDLrTV8vapPMzNWjFc0Gcsv6zIUOiq0r+COTVIjhkAcP7
	 Wtp6epoAr8XAuJLmoRpr3IdWJkQUgNwbwZoj3SVDNY8tDWpdvRCWrfmzBb7+x1aRhW
	 xoSs+rqWGkQVvgSgm6eRM9/38gYXo1tJSMuLo58XR9OcibPWQzjnSpN9aBY7ZY+tiX
	 9XJB1shk3rihpb0/89PMUgGKUYEF59Rh1EsCFntpt3IWcegDGyPVg4o2w27C67kP12
	 sC/bNryo392OJAVxtYA5ocTGjLypsXW3IRCAf/V/LTBzQr7AfBPhsDcY2lu3+UWZSm
	 Z09nw2TBtHhNg==
Date: Sat, 21 Dec 2024 00:26:01 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, vlad.wing@gmail.com,
	rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org, kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 0/3] hrtimer: Fix timers queued locally from offline CPUs
Message-ID: <Z2X9CYoZVnvRncM8@pavilion.home>
References: <20241218165008.37820-1-frederic@kernel.org>
 <7d19b58a-2cd2-4c29-8596-f0cda605112f@paulmck-laptop>
 <4fbc9ab5-43f3-47b7-a8df-27a8e6cf7040@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fbc9ab5-43f3-47b7-a8df-27a8e6cf7040@paulmck-laptop>

Le Fri, Dec 20, 2024 at 03:19:31PM -0800, Paul E. McKenney a écrit :
> On Thu, Dec 19, 2024 at 09:42:48AM -0800, Paul E. McKenney wrote:
> > On Wed, Dec 18, 2024 at 05:50:05PM +0100, Frederic Weisbecker wrote:
> > > 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> > > was introduced to fix stalls with scheduler bandwidth timers getting
> > > migrated while some kthreads handling CPU hotplug rely on bandwidth.
> > > 
> > > However this has introduced several other issues which used to be
> > > confined to RCU. But not anymore as it is spreading to hotplug code
> > > itself (https://lore.kernel.org/all/20241213203739.1519801-1-usamaarif642@gmail.com/)
> > > 
> > > Instead of introducing yet another new hackery, fix the problem in
> > > hrtimers for everyone.
> > 
> > The good news is that this passes 12 hours of 400*TREE03.  (Yay!!!)
> > 
> > The so-so news is that this gives only about 70% confidence that these
> > patches help, but on the other hand, it also gives much higher confidence
> > that these patches are not hurting anything.
> > 
> > At least for TREE03.
> 
> Another day, another 12 hours of 400*TREE03 passed.  This gets us up
> beyond 90% confidence that these patches help, and even more confidence
> that they are not too severely hurting anything.

Cool :-)

> 
> > The not-so-good news is that this series causes build failures for
> > rcutorture scenarios (such as SRCU-T) that build with CONFIG_SMP=n:
> > 
> > ------------------------------------------------------------------------
> > kernel/time/hrtimer.c: In function ‘enqueue_hrtimer_offline’:
> > kernel/time/hrtimer.c:1229:42: error: ‘migration_base’ undeclared (first use in this function); did you mean ‘is_migration_base’?
> > ------------------------------------------------------------------------
> > 
> > When built with KCSAN enabled (--kcsan to kvm.sh), there is this
> > additional build failure on that same line of code:
> > 
> > ------------------------------------------------------------------------
> > kernel/time/hrtimer.c:1229:3: error: incompatible pointer types assigning to 'volatile typeof (timer->base)' (aka 'struct hrtimer_clock_base *volatile') from 'bool (*)(struct hrtimer_clock_base *)' (aka '_Bool (*)(struct hrtimer_clock_base *)') [-Werror,-Wincompatible-pointer-types]
> > 
> >  1229 |                 WRITE_ONCE(timer->base, &migration_base);
> > ------------------------------------------------------------------------
> > 
> > Me, I am a bit surprised that enqueue_hrtimer_offline() is even built
> > in a CONFIG_SMP=n kernel.
> > 
> > But there might be some reason why #ifdef-ing out that function's body
> > would be a bad idea, so over to you!  ;-)
> 
> Curiosity overcame me, and the #ifdef makes things at least appear to
> work for CONFIG_SMP=n kernels.  Experimental patch below, which I intend
> to use for further testing, but I have no plans to push it upstream.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 61a0b92b3a3cfef69e3848806e51d1b99a9e9406
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Dec 20 15:10:26 2024 -0800
> 
>     EXP hrtimers: No-op enqueue_hrtimer_offline() if !HOTPLUG_CPU
>     
>     In kernels built with CONFIG_HOTPLUG_CPU=n, this experimental commit
>     uses #ifdef to remove the body of the enqueue_hrtimer_offline() function.
>     This might or might not be the correct fix to the build complaint about
>     migration_base being undeclared.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Vlad Poenaru <vlad.wing@gmail.com>
>     Cc: Usama Arif <usamaarif642@gmail.com>
>     Cc: Frederic Weisbecker <frederic@kernel.org>
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 48c0078d2c4f2..4235b7825b152 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1213,6 +1213,7 @@ static void enqueue_hrtimer_offline(struct hrtimer *timer,
>  				    struct hrtimer_clock_base *base,
>  				    const enum hrtimer_mode mode)
>  {
> +#ifdef CONFIG_HOTPLUG_CPU
>  	struct hrtimer_cpu_base *new_cpu_base, *old_cpu_base, *this_cpu_base;
>  	struct hrtimer_clock_base *new_base;
>  	int cpu;
> @@ -1238,6 +1239,7 @@ static void enqueue_hrtimer_offline(struct hrtimer *timer,
>  
>  	if (enqueue_hrtimer(timer, new_base, mode))
>  		smp_call_function_single_async(cpu, &new_cpu_base->csd);
> +#endif
>  }

I was thinking about something like that. Can I fold that and add your
SOB?

Thanks.

>  
>  
