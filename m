Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D51632D3;
	Wed,  5 Feb 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767055; cv=none; b=dUshOukAyMjaWppnvr5tXUbdhTZREmZwTmmdtiAoZjn5dGU43znrfDBFMYUBMwiDkytcV0yLRu5p3QogqsQjsQJ/tYOSoD5bWU6tLGizQ/vXnMXJp+V+t5001Kn6/1P/3DXTJVQre5eFZmad2N/TZqkoOMalO+6V+wuev0+T1F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767055; c=relaxed/simple;
	bh=StKTB1B/3jPFwxrAklmtnDfsfOMHP2qcxx/OmEYAq1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvVczxQDUWlpMYAFrL3DpAWUn7PoFFwoxGmqlAQwRL5GczPa87MWW0npxeDIQ1EgSZlsQEtAGkbBX1LFJ1lFEjevIQTW65LTtZev44kmw+E9ttBx/XwA26o/rjlRjojE/JyVPR8WylCZvsIAL10rkgwOPOT/d/nkqmOomlOoQ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm6SDLLH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm6SDLLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A783BC4CED1;
	Wed,  5 Feb 2025 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738767053;
	bh=StKTB1B/3jPFwxrAklmtnDfsfOMHP2qcxx/OmEYAq1A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Xm6SDLLHA1Cqe+kvJd9o7k1682UMHWENIL9UavMyuulK0eMlpz6G/BruQ0W3mChDG
	 ehEPFDYWPNbwGOguisFAy3cRYqvzB8n4z0h/h7BrwVhzJWGBnc6EAZ/B8glTF2ARaO
	 swJhB0Uviaau+25kUFnZ6Jv/nX98bRnsGQaNtetbIjoIc3rEugmikTBCesJ0qCgC+Q
	 pr14HkwJLO4u8uPQHSAXTax+OqE/RIqF7SIEGo0v1+Xe+v0OlzcjUN1Yyq3UqlnM8v
	 FxV+iS8c9ayNnO7PwlaD58/kkH3kH12d3L8Jy4mK2igzBhKUr9c6L3ftEWDG8WDWHv
	 79O/om5OX3B+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 45C7ACE03CD; Wed,  5 Feb 2025 06:50:53 -0800 (PST)
Date: Wed, 5 Feb 2025 06:50:53 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, john.ogness@linutronix.de
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
Message-ID: <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
 <20250130185320.1651910-4-paulmck@kernel.org>
 <20250204102611.OVuHn9rS@linutronix.de>
 <ff2ed5ba-52f4-4e82-ac0c-6e6a7013d86e@paulmck-laptop>
 <20250204163409.ueObHFje@linutronix.de>
 <9ed4e0fd-75c4-400a-9a0b-74c68286bad3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ed4e0fd-75c4-400a-9a0b-74c68286bad3@paulmck-laptop>

On Tue, Feb 04, 2025 at 12:20:30PM -0800, Paul E. McKenney wrote:
> On Tue, Feb 04, 2025 at 05:34:09PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-02-04 03:51:48 [-0800], Paul E. McKenney wrote:
> > > On Tue, Feb 04, 2025 at 11:26:11AM +0100, Sebastian Andrzej Siewior wrote:
> > > > On 2025-01-30 10:53:19 [-0800], Paul E. McKenney wrote:
> > > > > The timer and hrtimer softirq processing has moved to dedicated threads
> > > > > for kernels built with CONFIG_IRQ_FORCED_THREADING=y.  This results in
> > > > > timers not expiring until later in early boot, which in turn causes the
> > > > > RCU Tasks self-tests to hang in kernels built with CONFIG_PROVE_RCU=y,
> > > > > which further causes the entire kernel to hang.  One fix would be to
> > > > > make timers work during this time, but there are no known users of RCU
> > > > > Tasks grace periods during that time, so no justification for the added
> > > > > complexity.  Not yet, anyway.
> > > > > 
> > > > > This commit therefore moves the call to rcu_init_tasks_generic() from
> > > > > kernel_init_freeable() to a core_initcall().  This works because the
> > > > > timer and hrtimer kthreads are created at early_initcall() time.
> > > > 
> > > > Fixes: 49a17639508c3 ("softirq: Use a dedicated thread for timer wakeups on PREEMPT_RT.")
> > > > ?
> > > 
> > > Quite possibly...  I freely confess that I was more focused on the fix
> > > than on the bug's origin.  Would you be willing to try this commit and
> > > its predecessor?
> > 
> > Yes. Just verified.
> > Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Boqun, could you please apply Sebastian's tags, including the Fixes
> tag above?
> 
> > > > I played with it and I can reproduce the issue with !RT + threadirqs but
> > > > not with RT (which implies threadirqs).
> > > > Is there anything in RT that avoids the problem?
> > > 
> > > Not that I know of, but then again I did not try it.  To your point,
> > 
> > The change looks fine.
> > 
> > > I do need to make a -rt rcutorture scenario.  TREE03 has been intended to
> > > approximate this, and it uses the following Kconfig options:
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > CONFIG_SMP=y
> > > CONFIG_NR_CPUS=16
> > > CONFIG_PREEMPT_NONE=n
> > > CONFIG_PREEMPT_VOLUNTARY=n
> > > CONFIG_PREEMPT=y
> > > #CHECK#CONFIG_PREEMPT_RCU=y
> > > CONFIG_HZ_PERIODIC=y
> > > CONFIG_NO_HZ_IDLE=n
> > > CONFIG_NO_HZ_FULL=n
> > > CONFIG_RCU_TRACE=y
> > > CONFIG_HOTPLUG_CPU=y
> > > CONFIG_RCU_FANOUT=2
> > > CONFIG_RCU_FANOUT_LEAF=2
> > > CONFIG_RCU_NOCB_CPU=n
> > > CONFIG_DEBUG_LOCK_ALLOC=n
> > > CONFIG_RCU_BOOST=y
> > > CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> > > CONFIG_RCU_EXPERT=y
> > 
> > You could enable CONFIG_PREEMPT_RT ;)
> > CONFIG_PREEMPT_LAZY is probably also set a lot.
> > 
> > That should be it.
> > 
> > > ------------------------------------------------------------------------
> > > 
> > > And the following kernel-boot parameters:
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30
> > > rcutree.gp_preinit_delay=12
> > > rcutree.gp_init_delay=3
> > > rcutree.gp_cleanup_delay=3
> > > rcutree.kthread_prio=2
> > > threadirqs
> > > rcutree.use_softirq=0
> > > rcutorture.preempt_duration=10
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > Some of these are for RCU's benefit, but what should I change to more
> > > closely approximate a typical real-time deployment?
> > 
> > See above.
> 
> Which got me this diff:
> 
> ------------------------------------------------------------------------
> 
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE03 b/tools/testing/selftests/rcutorture/configs/rcu/TREE03
> index 2dc31b16e506..6158f5002497 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE03
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE03
> @@ -2,7 +2,9 @@ CONFIG_SMP=y
>  CONFIG_NR_CPUS=16
>  CONFIG_PREEMPT_NONE=n
>  CONFIG_PREEMPT_VOLUNTARY=n
> -CONFIG_PREEMPT=y
> +CONFIG_PREEMPT=n
> +CONFIG_PREEMPT_LAZY=y
> +CONFIG_PREEMPT_RT=y
>  #CHECK#CONFIG_PREEMPT_RCU=y
>  CONFIG_HZ_PERIODIC=y
>  CONFIG_NO_HZ_IDLE=n
> @@ -15,4 +17,5 @@ CONFIG_RCU_NOCB_CPU=n
>  CONFIG_DEBUG_LOCK_ALLOC=n
>  CONFIG_RCU_BOOST=y
>  CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> +CONFIG_EXPERT=y
>  CONFIG_RCU_EXPERT=y
> 
> ------------------------------------------------------------------------
> 
> But a 10-minute run got me the splat shown below, and in addition a
> shutdown-time hang.
> 
> This is caused by RCU falling behind a callback-flooding kthread that
> invokes call_rcu() in a semi-tight loop.  Setting rcutree.kthread_prio=40
> avoids the splat, but still gets the shutdown-time hang.  Retrying with
> the default rcutree.kthread_prio=2 failed to reproduce the splat, but
> it did reproduce the shutdown-time hang.
> 
> OK, maybe printk buffers are not being flushed?  A 100-millisecond sleep
> at the end of of rcu_torture_cleanup() got all of rcutorture's output
> flushed, but lost the subsequent shutdown-time console traffic.  The
> pr_flush(HZ/10,1) seems more sensible, but this is private to printk().
> 
> I would like to log the shutdown-time console traffic because RCU can
> sometimes break things on that path.
> 
> Thoughts?

Longer rcutorture runs showed (not unexpectedly) that the 100-millisecond
sleep was not always sufficient, nor was a 500-milliseconds sleep.

There is a call to kmsg_dump(KMSG_DUMP_SHUTDOWN) in kernel_power_off()
that appears to be intended to dump out the printk() buffers, but it
does not seem to do so in kernels built with CONFIG_PREEMPT_RT=y.
Does there need to be a pr_flush() call prior to the call to
migrate_to_reboot_cpu()?  Or maybe even to do_kernel_power_off_prepare()
or kernel_shutdown_prepare()?

Adding John Ogness on CC so that he can tell me the error of my ways.

> PS:  I will do longer runs in case that splat was not a one-off.
>      My concern is that I might need to adjust something more in order
>      to get a reliable callback-flooding test.

And this was not a one-off.  Running 10 40-minute instances of the new-age
CONFIG_PREEMPT_RT=y TREE03 reliably triggers this.  At first glance,
this appears to be an interaction between testing of RCU priority
boosting and RCU-callback flooding forward-progress testing.  And disabling
testing of RCU priority boosting avoids these OOMs.  As does running
without CONFIG_PREEMPT_RT=y.

My next step is to run with rcutorture.preempt_duration=0, which disables
within-guest-OS random preempting of kthreads.  If that doesn't help,
I expect to play around with avoiding concurrent testing of RCU priority
boosting and RCU callback flooding forward progress.

Or is there a better way?

							Thanx, Paul
