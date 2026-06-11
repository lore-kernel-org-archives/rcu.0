Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A66331EDA;
	Thu, 11 Jun 2026 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781207905; cv=none; b=cBIu0FpNxjJToW+XuNLJFvzE0eS75My5w+2t0+omrdiwEpHE9I1P0oLsA8v5klfZ47LT51bI5WHE0MfZ7gku01zokfN3eYMpc6TLSQaVZyUqQlXAu3eO2QENkWjcxB4gAFFtAAKmgmutyepBQP25r0e6CAapcgQRqFGhusCCbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781207905; c=relaxed/simple;
	bh=5VGQtUE+6eBQesnEYfm3ahTwid88FeajJWQceLjbRk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLWT7yOYU2PYQ3ULurQf635nhvUzTvsyADcNXoOv3daqxHAU34zHfjtAAxBnKWcrldnqfQ2DP+sFPOJgEpzgpK6PXv2RfPacJzy2BsnBFoHV8rtV1w5hT/ku/ucgVLPz8SWU1k22vfG06VjJudtTceslL/PdUUsBnUWDj8n60oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0zxQvlt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0zxQvlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F97F1F00A3A;
	Thu, 11 Jun 2026 19:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781207904;
	bh=gZv3iBufkhEiw+FDaMmJkHidUpwNlMzriTnANPpEITE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=b0zxQvltv081dgJwMX+FWhZNOjPHfZKWjDxINaj2ER0YHJNAmPKw2EVFx7C14VcBX
	 FuP0f7o56+IKeHTwI7AcrFglqrlcEt1F/O6yaKWWVW4SFc+XAUH+5VGtA/xXanhhQP
	 4CxR1tUL2jbDFVCWdtoXgBkjfxwMdGwYizEMOPmXeole+6dG4vI7drx3UXkWOGBYwF
	 4BsbETwuC/4tzMDUQWuCI4FgnjNh/zzgo2HV0M8nLNWx3vB9WVIcC+GjmYe59b7sNC
	 IQESAALctaBvSnCiWFdbeZEwMLRumURqmzNC21lPhVHb6TOtzRXh/ANpE9CeZ8gFwa
	 tDJqQE+4lSHTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C68DECE0532; Thu, 11 Jun 2026 12:58:23 -0700 (PDT)
Date: Thu, 11 Jun 2026 12:58:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, dave@stgolabs.net,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>, Wang Lian <lianux.mm@gmail.com>
Subject: Re: [PATCH] rcu: Use task_state_to_char() in stall-warning prints
Message-ID: <442e80e0-4f91-421c-ab68-d26e0a031472@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260611073201.3889919-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611073201.3889919-1-kunwu.chan@linux.dev>

On Thu, Jun 11, 2026 at 03:32:01PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> RCU stall warnings currently print task states as raw hexadecimal
> values (e.g., ->state=0x402), forcing developers to manually decode
> them from memory.
> 
> Replace these raw hex values with the compact, single-letter symbols
> already established by sched_show_task():
> 
>     ->state=0x402  becomes  ->state=I  (TASK_IDLE)
>     ->state=0x0    becomes  ->state=R  (TASK_RUNNING)
>     ->state=0x2    becomes  ->state=D  (TASK_UNINTERRUPTIBLE)
> 
> Convert five print sites across tree_stall.h, rcutorture.c, and
> hazptrtorture.c to use task_state_to_char() instead of the raw
> ->__state value.
> 
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Co-developed-by: Wang Lian <lianux.mm@gmail.com>
> Signed-off-by: Wang Lian <lianux.mm@gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Nice!

But could you please split this into three commits, one for each file?
That makes it easier to create branches to send to Linus.  Especially
since hazptrtorture.c will likely be in a different pull request.  ;-)

							Thanx, Paul

> ---
> Based on: linux-rcu repo (dev branch)
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> base-commit: 85bf11e84 ("smp: Make CSD lock acquisition atomic for debug mode")
> ---
>  kernel/rcu/hazptrtorture.c |  4 ++--
>  kernel/rcu/rcutorture.c    |  4 ++--
>  kernel/rcu/tree_stall.h    | 12 ++++++------
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
> index 0da0a4606..19ea479c9 100644
> --- a/kernel/rcu/hazptrtorture.c
> +++ b/kernel/rcu/hazptrtorture.c
> @@ -497,10 +497,10 @@ hazptr_torture_stats_print(void)
>  		unsigned long __maybe_unused gp_seq = 0;
>  
>  		wtp = READ_ONCE(writer_task);
> -		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
> +		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %c cpu %d\n",
>  			 hazptr_torture_writer_state_getname(),
>  			 hazptr_torture_writer_state, gp_seq, flags,
> -			 wtp == NULL ? ~0U : wtp->__state,
> +			 wtp == NULL ? '?' : task_state_to_char(wtp),
>  			 wtp == NULL ? -1 : (int)task_cpu(wtp));
>  		if (!splatted && wtp) {
>  			sched_show_task(wtp);
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index fcb421ced..4d4ebeeea 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -3074,10 +3074,10 @@ rcu_torture_stats_print(void)
>  		if (cur_ops->get_gp_data)
>  			cur_ops->get_gp_data(&flags, &gp_seq);
>  		wtp = READ_ONCE(writer_task);
> -		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
> +		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %c cpu %d\n",
>  			 rcu_torture_writer_state_getname(),
>  			 rcu_torture_writer_state, gp_seq, flags,
> -			 wtp == NULL ? ~0U : wtp->__state,
> +			 wtp == NULL ? '?' : task_state_to_char(wtp),
>  			 wtp == NULL ? -1 : (int)task_cpu(wtp));
>  		if (!splatted && wtp) {
>  			sched_show_task(wtp);
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 317ef91b1..7ca434b08 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -596,13 +596,13 @@ static void rcu_check_gp_kthread_starvation(void)
>  
>  	if (rcu_is_gp_kthread_starving(&j)) {
>  		cpu = gpk ? task_cpu(gpk) : -1;
> -		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#x ->cpu=%d\n",
> +		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%c ->cpu=%d\n",
>  		       rcu_state.name, j,
>  		       (long)rcu_seq_current(&rcu_state.gp_seq),
>  		       data_race(READ_ONCE(rcu_state.gp_flags)),
>  		       gp_state_getname(rcu_state.gp_state),
>  		       data_race(READ_ONCE(rcu_state.gp_state)),
> -		       gpk ? data_race(READ_ONCE(gpk->__state)) : ~0, cpu);
> +		       gpk ? task_state_to_char(gpk) : '?', cpu);
>  		if (gpk) {
>  			struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  
> @@ -639,12 +639,12 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
>  	    time_after(jiffies, jiffies_fqs + RCU_STALL_MIGHT_MIN) &&
>  	    gpk && !READ_ONCE(gpk->on_rq)) {
>  		cpu = task_cpu(gpk);
> -		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%#x\n",
> +		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%c\n",
>  		       rcu_state.name, (jiffies - jiffies_fqs),
>  		       (long)rcu_seq_current(&rcu_state.gp_seq),
>  		       data_race(READ_ONCE(rcu_state.gp_flags)), // Diagnostic read
>  		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
> -		       data_race(READ_ONCE(gpk->__state)));
> +		       task_state_to_char(gpk));
>  		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%u\n",
>  		       cpu, kstat_softirqs_cpu(TIMER_SOFTIRQ, cpu));
>  	}
> @@ -971,10 +971,10 @@ void show_rcu_gp_kthreads(void)
>  	jr = j - data_race(READ_ONCE(rcu_state.gp_req_activity));
>  	js = j - data_race(READ_ONCE(rcu_state.gp_start));
>  	jw = j - data_race(READ_ONCE(rcu_state.gp_wake_time));
> -	pr_info("%s: wait state: %s(%d) ->state: %#x ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_max %lu ->gp_flags %#x\n",
> +	pr_info("%s: wait state: %s(%d) ->state: %c ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_max %lu ->gp_flags %#x\n",
>  		rcu_state.name, gp_state_getname(rcu_state.gp_state),
>  		data_race(READ_ONCE(rcu_state.gp_state)),
> -		t ? data_race(READ_ONCE(t->__state)) : 0x1ffff, t ? t->rt_priority : 0xffU,
> +		t ? task_state_to_char(t) : '?', t ? t->rt_priority : 0xffU,
>  		js, ja, jr, jw, (long)data_race(READ_ONCE(rcu_state.gp_wake_seq)),
>  		(long)data_race(READ_ONCE(rcu_state.gp_seq)),
>  		(long)data_race(READ_ONCE(rcu_get_root()->gp_seq_needed)),
> -- 
> 2.43.0
> 
> 
