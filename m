Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908992;
	b=fK9602m1/70BxVFa7FVzZI0YWSArcLYrGuXF9esBa/VB0BiRCBQU3lbdIcWZ1kZf68EM
	 MTh3q5N4M7NMCjy6pjG1+2b6T6fxsSQajk/yfsUkouXhG2nsY394QL85Pp9/pNR0FbK1z
	 nyYYntZh/M+13t7G32wmkaCoBzFNH+5zczhEkRcoMAUZDERllOMCCAbJLk5m7oMflhd5b
	 4pNj6Kc7G7yNYukpvkUspzK2L8ZCQoF4GGeUdYiYkNSXEEtSaDe9NAGPJUnertXDcwDl3
	 wDZIbS8n2AlON8wnLpLwobf7761dHAzlncBV8+/ouUP99Vhs6hvdZ0j6U8A60o6mqwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908992;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=hAMXcsDShigiscpI7Q3JDrAxmDURmvVQLCUjnSrGa7s=;
	b=zRYI9dO0/+W+LZdUtWrX6a5GfGc8jgrZQTvYpmv9dm1wBJ5mZJIXyUVCo45g0o1hnogQ
	 i2W62iXrsoJRvlNjqkqv5+6yRb8kRmxcyXriOGrCDffm/KPHBac4aDqhplBBMOZmPlISC
	 lVLiejiqfQKtse1wT1VpmX4JfEwuHdIKvvK8e498bbj/9KQnoUqyikYF7hsmG2FHDF8Wz
	 OuVDek51pAVprcUZAgFvGDhVFzIw4vQDIZQiejlRJwoZHXIUS10uLt2apQeteANtDe+vi
	 OHg/fbcM44/FRq0Mb2QbPvFM7PielGYa79O8gbhhS1S9cDbUw5Eu4vBLXIAfPLQsoYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCyiLreG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A372606A326;
	Thu,  5 Nov 2026 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCyiLreG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB1B1F0089F;
	Thu,  5 Nov 2026 20:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908992;
	bh=hAMXcsDShigiscpI7Q3JDrAxmDURmvVQLCUjnSrGa7s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=RCyiLreG9XH2JBaltlmMLYp0VF0XQv2PJcgVIXKANCwy6+vJZD2kviguo+wXhq+f6
	 T/nVzQ7WZqNA3CK3PfDUbHtIG9h3I5+3ZrpWEhvr1GrlVfZ3SVYcAIqBpnHhsjVMla
	 cyNMgbgNPqU6Yzy0FqkPhZBXGIEtlnHf56Vx0/Gh/VEorYVpB57BuIB6www0FHJThD
	 fZXHskLrb1rEnXv2fBkq4q6zOcu28HSHuKDPXntTJdb/wNIHJwJKp8EKEs+UmA8o1M
	 qCYUXdLQxoaOgzDVmUFQOwtS147x0JzuYxSPKPKlmODr1kx4MbXCoitFXCWuceYbXD
	 6DtMDGM9PIHLQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EC8C7CE04A0; Thu,  5 Nov 2026 12:03:11 -0800 (PST)
Date: Thu, 5 Nov 2026 12:03:11 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
Message-ID: <c81d8243-c130-44d8-bef6-e678ecb088ac@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261105165113.82N-rPMG@linutronix.de>
 <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
 <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
 <auzXjQfYXs_gzx1y@gpd4>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auzXjQfYXs_gzx1y@gpd4>

On Thu, Nov 05, 2026 at 08:22:53PM +0100, Andrea Righi wrote:
> Hello,
> 
> On Thu, Nov 05, 2026 at 06:52:47PM +0000, Joel Fernandes wrote:
> > 
> > 
> > > On Nov 5, 2026, at 1:36 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > ﻿On Thu, Nov 05, 2026 at 05:51:13PM +0100, Sebastian Andrzej Siewior wrote:
> > >> Commit 450efca7182a5 ("rcutorture: Disable RT throttling for boost
> > >> tests") added the ability to disable RT throttling while rcutorture was
> > >> run.
> > >> 
> > >> Since v6.12 the DL fair_server takes control of throttling and this
> > >> interface no longer serves this purpose. That sysctl control still
> > >> exists but serves a different cause.
> > >> 
> > >> There is no in-kernel interface to provide this feature, one needs to
> > >> echo -1 to each /sys/kernel/debug/sched/fair_server/cpu*/runtime file.
> > >> 
> > >> Since sysctl_sched_rt_runtime does not do what it once did, remove it
> > >> from rcutorture.
> > >> 
> > >> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > 
> > > Thank you, but ouch...  Does this mean that there is no longer any useful
> > > in-kernel way to test RCU priority boosting?
> > 
> > There should be a way to disable DL server. Adding Andreas to check if there is a way. But I am wondering if the prio boost tests are working, then is the DL server throttling broken? ;-)
> 
> The existing knob to disable the DL servers is debugfs, writing 0 to
> each /sys/kernel/debug/sched/fair_server/cpu*/runtime disables the fair
> server and, with sched_ext, the corresponding knob is in
> /sys/kernel/debug/sched/fair_server/ext_server/cpu*/runtime.
> 
> Small nit: the disable value is 0, not -1 (the handler parses an
> unsigned).

Thank you for the clarification!

> For rcutorture, I don't think there's a ready-made kernel interface,
> maybe we could add a sched helper that performs the same operation as
> the debugfs knobs?

I would very much appreciate that.  ;-)

> And I think a passing boost test doesn't necessarily mean the DL server
> is necessarily broken. The server can still give a starved reader enough
> CPU time to leave its RCU read-side critical section without relying on
> priority boosting. That can mask a boosting failure, much like the old
> RT throttling could.

The way that rcutorture deals with this (or attempts to, anyway) is to
repeatedly run the boost test, with the interval between consecutive
boost tests controled by the test_boost_interval module parameter.

So my concern is that throttling might happen on at least one CPU during
each four-second boost test.

(I gave a longer duration in my earlier message, apologies, the shorter
test is possible because rcutorture tests for grace periods not completing
during the test rather than waiting for an RCU CPU stall warning.)

							Thanx, Paul

> Thanks,
> -Andrea
> 
> > 
> > Thanks
> > 
> > > 
> > >                            Thanx, Paul
> > > 
> > >> ---
> > >> kernel/rcu/rcu.h        |  2 --
> > >> kernel/rcu/rcutorture.c | 35 -----------------------------------
> > >> 2 files changed, 37 deletions(-)
> > >> 
> > >> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > >> index d60444bf3a02d..6d1034e49d411 100644
> > >> --- a/kernel/rcu/rcu.h
> > >> +++ b/kernel/rcu/rcu.h
> > >> @@ -69,8 +69,6 @@
> > >> /* A complete grace period count */
> > >> #define RCU_SEQ_GP (RCU_SEQ_STATE_MASK + 1)
> > >> 
> > >> -extern int sysctl_sched_rt_runtime;
> > >> -
> > >> /*
> > >>  * Return the counter portion of a sequence number previously returned
> > >>  * by rcu_seq_snap() or rcu_seq_current().
> > >> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > >> index 968343be4e0d1..acab425e72ad5 100644
> > >> --- a/kernel/rcu/rcutorture.c
> > >> +++ b/kernel/rcu/rcutorture.c
> > >> @@ -1333,39 +1333,6 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
> > >>    return cur_ops->gp_diff(new, old);
> > >> }
> > >> 
> > >> -/*
> > >> - * RCU torture priority-boost testing.  Runs one real-time thread per
> > >> - * CPU for moderate bursts, repeatedly starting grace periods and waiting
> > >> - * for them to complete.  If a given grace period takes too long, we assume
> > >> - * that priority inversion has occurred.
> > >> - */
> > >> -
> > >> -static int old_rt_runtime = -1;
> > >> -
> > >> -static void rcu_torture_disable_rt_throttle(void)
> > >> -{
> > >> -    /*
> > >> -     * Disable RT throttling so that rcutorture's boost threads don't get
> > >> -     * throttled. Only possible if rcutorture is built-in otherwise the
> > >> -     * user should manually do this by setting the sched_rt_period_us and
> > >> -     * sched_rt_runtime sysctls.
> > >> -     */
> > >> -    if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime != -1)
> > >> -        return;
> > >> -
> > >> -    old_rt_runtime = sysctl_sched_rt_runtime;
> > >> -    sysctl_sched_rt_runtime = -1;
> > >> -}
> > >> -
> > >> -static void rcu_torture_enable_rt_throttle(void)
> > >> -{
> > >> -    if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime == -1)
> > >> -        return;
> > >> -
> > >> -    sysctl_sched_rt_runtime = old_rt_runtime;
> > >> -    old_rt_runtime = -1;
> > >> -}
> > >> -
> > >> static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long *start)
> > >> {
> > >>    int cpu;
> > >> @@ -3390,7 +3357,6 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
> > >>    mutex_lock(&boost_mutex);
> > >>    t = boost_tasks[cpu];
> > >>    boost_tasks[cpu] = NULL;
> > >> -    rcu_torture_enable_rt_throttle();
> > >>    mutex_unlock(&boost_mutex);
> > >> 
> > >>    /* This must be outside of the mutex, otherwise deadlock! */
> > >> @@ -3428,7 +3394,6 @@ static int rcutorture_booster_init(unsigned int cpu)
> > >> 
> > >>    /* Don't allow time recalculation while creating a new task. */
> > >>    mutex_lock(&boost_mutex);
> > >> -    rcu_torture_disable_rt_throttle();
> > >>    VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
> > >>    boost_tasks[cpu] = kthread_run_on_cpu(rcu_torture_boost, NULL,
> > >>                          cpu, "rcu_torture_boost_%u");
> > >> --
> > >> 2.55.0
> > >> 
> 
