Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B32114;
	Fri, 13 Dec 2024 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131249; cv=none; b=BgYnt1TyJ0iqg48UTmEUpYuw7NHZQ923V2lkTL4pgPhcSa7oQ0H9qgv5VkMCLLcCMIWalESfV6cLeco79PGGVfKf791Q7YhG4FO4vs9UoXZb7SunbG6Qp9tDhPz61R4xeUcb04m97HCzRkAZRMesNsMC+3A//vdzfh7n6nd4D8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131249; c=relaxed/simple;
	bh=u4TyrajqiJTqJ/P7uAVn977bkWVdgy/o/RTdfJTSbsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raGPvh9gcHjIpQIm4vXlY5oJrFmu5GHHGf2jK5fhXe+x5sP+JbA4S6X9fS8IzSkO0S0L4M/bmcYKGiYy4yQn4F8h8Ae4Dxni+V3aKTeQJppR+KBSlkrVrKE8lSXkrLaQUpKmkrXxcCL+oLg5W50VCRYs01/qfjNN7Ai+wXayD6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVcsUcAx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVcsUcAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B715C4CED0;
	Fri, 13 Dec 2024 23:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734131248;
	bh=u4TyrajqiJTqJ/P7uAVn977bkWVdgy/o/RTdfJTSbsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVcsUcAxCviEJIB/htWEJQtTjZasqvZWmKDQzRVawuQbKnnNX3qckXjPvmYqaOhpD
	 e/hT7e1bbp9wwKh/FE9DFdMWfE4jllUYHmqGNE1slHwINXkVkTy+twdPtmQEUW40CO
	 45MKmUl7t8d9CwmcjhH/RrxtzyPirTEloYp2lM5l/czecAtcBpSh5paICgRNxX7TJU
	 EiMxIUBBL+oydC48VfHNNZ2NcbziBuXwW6pHbtCU3gQJqnaJsCRxijYDLrmWLETBgI
	 GxR8PEMEixLWOVom+RkTdern48FhNvYrhtgReVJ/bAtqfLaBY5e2i2L/FJrjDDsdz/
	 to3oycN7uCUJw==
Date: Sat, 14 Dec 2024 00:07:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH rcu 2/2] rcu/nocb: Fix rcuog wake-up from offline softirq
Message-ID: <Z1y-LbA1UFLb314l@pavilion.home>
References: <c0daba35-f647-40cd-b556-3a04e03da93c@paulmck-laptop>
 <20241212184214.2018411-2-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212184214.2018411-2-paulmck@kernel.org>

Le Thu, Dec 12, 2024 at 10:42:14AM -0800, Paul E. McKenney a écrit :
> From: Frederic Weisbecker <frederic@kernel.org>
> 
> After a CPU has set itself offline and before it eventually calls
> rcutree_report_cpu_dead(), there are still opportunities for callbacks
> to be enqueued, for example from an IRQ. When that happens on NOCB, the
> rcuog wake-up is deferred through an IPI to an online CPU in order not
> to call into the scheduler and risk arming the RT-bandwidth after
> hrtimers have been migrated out and disabled.
> 
> But performing a synchronized IPI from an IRQ is buggy as reported in
> the following scenario:
> 
> 	WARNING: CPU: 1 PID: 26 at kernel/smp.c:633 smp_call_function_single
> 	Modules linked in: rcutorture torture
> 	CPU: 1 UID: 0 PID: 26 Comm: migration/1 Not tainted 6.11.0-rc1-00012-g9139f93209d1 #1
> 	Stopper: multi_cpu_stop+0x0/0x320 <- __stop_cpus+0xd0/0x120
> 	RIP: 0010:smp_call_function_single
> 	<IRQ>
> 	swake_up_one_online
> 	__call_rcu_nocb_wake
> 	__call_rcu_common
> 	? rcu_torture_one_read
> 	call_timer_fn
> 	__run_timers
> 	run_timer_softirq
> 	handle_softirqs
> 	irq_exit_rcu
> 	? tick_handle_periodic
> 	sysvec_apic_timer_interrupt
> 	</IRQ>
> 
> The periodic tick must be shutdown when the CPU is offline, just like is
> done for oneshot tick. This must be fixed but this is not enough:
> softirqs can happen on any hardirq tail and reproduce the above scenario.
> 
> Fix this with introducing a special deferred rcuog wake up mode when the
> CPU is offline. This deferred wake up doesn't arm any timer and simply
> wait for rcu_report_cpu_dead() to be called in order to flush any
> pending rcuog wake up.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409231644.4c55582d-lkp@intel.com
> Fixes: 9139f93209d1 ("rcu/nocb: Fix RT throttling hrtimer armed from offline CPU")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

You can drop this patch, it has been replaced with another version upstream.

Thanks!
