Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7F23C76BE;
	Mon,  6 Jul 2026 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363738; cv=none; b=kIa8u7lJ2g/UwRQPS87gEEBV108x0wBK53MJUshp3758dHLA7ClGSTQNmc25WyLFq6kOIEaKJ4Gz+7Lk8Mlzm9/YXjLpvka3hbK2UQhu5W5u85MuAiHmCEaRXR4wV4LSB5JkB5S82kw1fJIqj/nOLb/Fm9FativISp/0ihGjNAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363738; c=relaxed/simple;
	bh=Ezhumi2M34YynmeDohnt3CpOxp8wRSR4L+0IGWeFU/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGsMdpH3qbaogImVb91uS51A/TpwGFiM4P34zXO/UkjtMBmpskJRw6B3SpcUcskLmPyZcUzhRe3c7SnY7LFtL5FlYZxzJVSYufjgp6nRfeOQ5x6vDFMAnwItVmI/Cq3JLBZ6p2atl7i3DDTFfAfRqXefb1euYnSXeL4Heru5eYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzFU0M/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzFU0M/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B123D1F000E9;
	Mon,  6 Jul 2026 18:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783363729;
	bh=eHLeT4Ue4rnx+KXLgOFdpggR2nzrrq0ku1NgN2yO7is=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=HzFU0M/89Ga/qKp893TX4nCqsuVdnoJ3nXuB3FxSPDRPVyqeVZCZB1hUumVYMgNpL
	 XjAeZ6Cr6RXWuxaA6rSUdwufkIH+T7ODr/VAoaRm6oKhTp2HgiVrfK8u7hxkWfeMk8
	 z0Drz9eSfoO+usnSi6X0GLSNpji/kUuSXMcqGlznEDy0tEI7NLQKS9j2BjJQnNZdLY
	 mty7DxjxWKLM4aJLx+5b4rvKD/Uk8HS6eBgwXuGN4LKdx7fFdjNwIPulRPcJSrvuF2
	 TTXSdaoA4NEsogd5ugLNJcULhHh94Pn5IeEj4j7LHZGHCA79J1XdSOYtCT6o2eA2Mz
	 l/1keWSUeFlGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 84D94CE08AF; Mon,  6 Jul 2026 11:48:49 -0700 (PDT)
Date: Mon, 6 Jul 2026 11:48:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Use __set_current_state() set task state in
 rcu_nocb_toggle()
Message-ID: <c826b59e-993f-4ff5-ac1a-6898bfaf05cc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260702101125.14100-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702101125.14100-1-qiang.zhang@linux.dev>

On Thu, Jul 02, 2026 at 06:11:25PM +0800, Zqiang wrote:
> In the rcu_nocb_toggle(), the schedule_hrtimeout() is called after the
> state assignment with no condition check. the release-acquire pair from
> raw_spin_unlock/lock(&cpu_base->lock), guarantee that task->__state is
> visible to the hrtimer callback:
> 
>               CPU0                                                     CPU1
> __set_current_state(TASK_INTERRUPTIBLE)
> ->WRITE_ONCE(task->__state, TASK_INTERRUPTIBLE)
> schedule_hrtimeout
> ->hrtimer_sleeper_start_expires()
>   ->raw_spin_lock_irqsave(&cpu_base->lock)
>     ....
>   ->raw_spin_unlock_irqrestore(&cpu_base->lock)
> 
> 								hard-irq:
> 							raw_spin_lock_irqsave(&cpu_base->lock)
> 							__hrtimer_run_queues
> 							->__run_hrtimer
> 							  ->raw_spin_unlock_irqrestore(&cpu_base->lock)
> 							  ->fn(timer)
> 							    ->hrtimer_wakeup
> 							      ->wake_up_process
> 								->try_to_wake_up
> 								  ->READ task->__state
> 
> This commit therefore use the __set_current_state() to replace the
> set_current_state() in rcu_nocb_toggle().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

This looks correct, and either drops an smp_mb() or converts an
xchg() to a WRITE_ONCE(), which does decrease overhead.  Except that
rcu_nocb_toggle() is invoked very infrequently and has high overhead
that I would expect to lose this overhead decrease in the noise.  And it
forces those reading the code to go figure out what is different between
set_current_state() and __set_current_state().

So I am not convinced to take this patch.  But am I missing something here?

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index b1bab59efde5..a0e6901e0f90 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2947,7 +2947,7 @@ static int rcu_nocb_toggle(void *arg)
>  			atomic_long_inc(&n_nocb_deoffload);
>  		}
>  		toggle_delay = torture_random(&rand) % toggle_fuzz + toggle_interval;
> -		set_current_state(TASK_INTERRUPTIBLE);
> +		__set_current_state(TASK_INTERRUPTIBLE);
>  		schedule_hrtimeout(&toggle_delay, HRTIMER_MODE_REL);
>  		if (stutter_wait("rcu_nocb_toggle"))
>  			sched_set_normal(current, oldnice);
> -- 
> 2.17.1
> 
