Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD8207669;
	Tue,  4 Feb 2025 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738669909; cv=none; b=Z1EAzoopjLvx14Ze9BBIA/A/ibIs4Rx2WqaCQXt0L4DZWv/5vKfh/zC11WObvNKz6E4Qbp4SL9ram75iyrdfEZy9BWNTktlCCnaFnj9HUzgHgg5EOAIMxwWFH7f9d0L6Yqf0y/ZYhUbFIaBKWfk/r0CdM8uvqTO88DHcHDcmEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738669909; c=relaxed/simple;
	bh=W0iAGFADeNbJCXhNLvY4b8BP7QreMpLTS/N4zSzKNB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyh94sqhR1zBppTVnyS304sJ9JK8St9WyELARSxEoHHnIedS6MFAw6ST80NfdLbZ0tqS2XJuoCWbRa0J0dAE6K+DZT5S4/+Jprydn0RE1ZGyMVZhFHp3S5n2JYBGuit/U12xBcOnj7vBnkP4pLsU80E1uy6nb/CE/w9ZjgqqTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guIg8Qnz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guIg8Qnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE383C4CEDF;
	Tue,  4 Feb 2025 11:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738669908;
	bh=W0iAGFADeNbJCXhNLvY4b8BP7QreMpLTS/N4zSzKNB8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=guIg8QnzzVOdHYbmqdQR7jlRzvw9kSDUqGBFrnji7JoPMjjC5+Qv2hroLBqWkYSoK
	 4JTxunz5uu+gqmZABBcWAzxmEuWoEnQzGMrv6+mZCw8QGw4SdQKRhBtcuTvbpuaznJ
	 BU93n8aPkzh72qmrkxtZygbJAe/o/tEHuE0xID5v+OEwxoK/8PqW4r67NbiQKSF25q
	 KxncE8E2gQgjge9kwDXaImz5DCzFEJMM4wkgolgmJ3GVcP6L4xTMbSrsNeOL8PXQIl
	 53kbjTQB3yMpCGphY295jixMTQz84rxXpDF83eB2QVJAXsZkxUAOlG2RL2cwcgSrvy
	 NterCQtaASZnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5FC80CE028A; Tue,  4 Feb 2025 03:51:48 -0800 (PST)
Date: Tue, 4 Feb 2025 03:51:48 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <ff2ed5ba-52f4-4e82-ac0c-6e6a7013d86e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
 <20250130185320.1651910-4-paulmck@kernel.org>
 <20250204102611.OVuHn9rS@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204102611.OVuHn9rS@linutronix.de>

On Tue, Feb 04, 2025 at 11:26:11AM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-01-30 10:53:19 [-0800], Paul E. McKenney wrote:
> > The timer and hrtimer softirq processing has moved to dedicated threads
> > for kernels built with CONFIG_IRQ_FORCED_THREADING=y.  This results in
> > timers not expiring until later in early boot, which in turn causes the
> > RCU Tasks self-tests to hang in kernels built with CONFIG_PROVE_RCU=y,
> > which further causes the entire kernel to hang.  One fix would be to
> > make timers work during this time, but there are no known users of RCU
> > Tasks grace periods during that time, so no justification for the added
> > complexity.  Not yet, anyway.
> > 
> > This commit therefore moves the call to rcu_init_tasks_generic() from
> > kernel_init_freeable() to a core_initcall().  This works because the
> > timer and hrtimer kthreads are created at early_initcall() time.
> 
> Fixes: 49a17639508c3 ("softirq: Use a dedicated thread for timer wakeups on PREEMPT_RT.")
> ?

Quite possibly...  I freely confess that I was more focused on the fix
than on the bug's origin.  Would you be willing to try this commit and
its predecessor?

> I played with it and I can reproduce the issue with !RT + threadirqs but
> not with RT (which implies threadirqs).
> Is there anything in RT that avoids the problem?

Not that I know of, but then again I did not try it.  To your point,
I do need to make a -rt rcutorture scenario.  TREE03 has been intended to
approximate this, and it uses the following Kconfig options:

------------------------------------------------------------------------

CONFIG_SMP=y
CONFIG_NR_CPUS=16
CONFIG_PREEMPT_NONE=n
CONFIG_PREEMPT_VOLUNTARY=n
CONFIG_PREEMPT=y
#CHECK#CONFIG_PREEMPT_RCU=y
CONFIG_HZ_PERIODIC=y
CONFIG_NO_HZ_IDLE=n
CONFIG_NO_HZ_FULL=n
CONFIG_RCU_TRACE=y
CONFIG_HOTPLUG_CPU=y
CONFIG_RCU_FANOUT=2
CONFIG_RCU_FANOUT_LEAF=2
CONFIG_RCU_NOCB_CPU=n
CONFIG_DEBUG_LOCK_ALLOC=n
CONFIG_RCU_BOOST=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
CONFIG_RCU_EXPERT=y

------------------------------------------------------------------------

And the following kernel-boot parameters:

------------------------------------------------------------------------

rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30
rcutree.gp_preinit_delay=12
rcutree.gp_init_delay=3
rcutree.gp_cleanup_delay=3
rcutree.kthread_prio=2
threadirqs
rcutree.use_softirq=0
rcutorture.preempt_duration=10

------------------------------------------------------------------------

Some of these are for RCU's benefit, but what should I change to more
closely approximate a typical real-time deployment?

> Thank you for debugging and the patch. 

And to you for digging into it!

							Thanx, Paul
