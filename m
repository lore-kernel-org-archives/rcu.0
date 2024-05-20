Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E85136995;
	Mon, 20 May 2024 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230935; cv=none; b=Wmi/shvFeqq4mAMoWrPnghgHBUaT+zrj3kUAPXubvRZFGDqPE4zgHKNbGIq1rm2T1aLcAcUztdM1BbP5f2hxxQEU3ILre+YvBS22ungT2Vmwk3v8K5VvxWbRSyPsz2FdJGjzrHG0ZmSVWJyk3UR9jCQS9AT817IQcrAZa8sKtEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230935; c=relaxed/simple;
	bh=rLvfVrT3RSfo8V86Enva/SuZ325r1uqZx5zwFDX9ZM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8WRhhPnoa83FQcs6CgSoI7F/mEjM3/y8i1vpq/y+nSLwkuo95oWaokGYMtnfRs0yPOolQeJ4jp2heO2YqhHFJOBgtr/gZIWbMUoAvy2Uf8woh9B/xTdIk1ujU7xX4x+eK9Eh4Byf05qVF3lGqlioUHSUMO5bMwnKiW7XcOsyPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pA/GtieQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA/GtieQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC97CC2BD10;
	Mon, 20 May 2024 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716230934;
	bh=rLvfVrT3RSfo8V86Enva/SuZ325r1uqZx5zwFDX9ZM0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pA/GtieQJ4UKIk5JaT0SFRwNFL7WrZx7jhYRqPXLQwNz6RKBoB6apXEzyguoOxJJ1
	 ZMb5M5j5ZnGQ7lP1ffPP9q53P91SxTUZEdy65XIVz406EmpzbL1CV5nrxp5i1MDwz7
	 Pd6AGnAkzPZ64WP7lLdWS/i4dTcWk42vv7mCDDUvK3SnHJ/AQI6kZv6squVES14x1x
	 tzi+rfmAd0SUZ4buV5V1RSTR9frut5rc7Sh+hMLAjKIiYBO15vhgPYJ3AXm+K0UeCh
	 npgY/eRo89gVwcdzxjilKoLqxGq9ninkLmLhMHnCqrV7lb54C/YB0Q+djgVDywJSQK
	 ruinrad5b0HVA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 73306CE0C3C; Mon, 20 May 2024 11:48:54 -0700 (PDT)
Date: Mon, 20 May 2024 11:48:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] rcu/tasks: Further comment ordering around current
 task snapshot on TASK-TRACE
Message-ID: <adf836b2-c660-4dc5-82dd-55d18596c803@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240517152303.19689-1-frederic@kernel.org>
 <20240517152303.19689-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517152303.19689-3-frederic@kernel.org>

On Fri, May 17, 2024 at 05:23:03PM +0200, Frederic Weisbecker wrote:
> Comment the current understanding of barriers and locking role around
> task snapshot.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tasks.h | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 6a9ee35a282e..05413b37dd6e 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1738,9 +1738,21 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
>  	for_each_online_cpu(cpu) {
>  		rcu_read_lock();
>  		/*
> -		 * RQ must be locked because no ordering exists/can be relied upon
> -		 * between rq->curr write and subsequent read sides. This ensures that
> -		 * further context switching tasks will see update side pre-GP accesses.
> +		 * RQ lock + smp_mb__after_spinlock() before reading rq->curr serve
> +		 * two purposes:
> +		 *
> +		 * 1) Ordering against previous tasks accesses (though already enforced
> +		 *    by upcoming IPIs and post-gp synchronize_rcu()).
> +		 *
> +		 * 2) Make sure not to miss latest context switch, because no ordering
> +		 *    exists/can be relied upon between rq->curr write and subsequent read
> +		 *    sides.
> +		 *
> +		 * 3) Make sure subsequent context switching tasks will see update side
> +		 *    pre-GP accesses.
> +		 *
> +		 * smp_mb() after reading rq->curr doesn't play a significant role and might
> +		 * be considered for removal in the future.
>  		 */
>  		t = cpu_curr_snapshot(cpu);
>  		if (rcu_tasks_trace_pertask_prep(t, true))

How about this for that comment?

		// Note that cpu_curr_snapshot() picks up the target
		// CPU's current task while its runqueue is locked with an
		// smp_mb__after_spinlock().  This ensures that subsequent
		// tasks running on that CPU will see the updater's pre-GP
		// accesses.  The trailng smp_mb() in cpu_curr_snapshot()
		// does not currently play a role other than simplify
		// that function's ordering semantics.  If these simplified
		// ordering semantics continue to be redundant, that smp_mb()
		// might be removed.

I left out the "ordering agains previous tasks accesses" because,
as you say, this ordering is provided elsewhere.

Thoughts?

							Thanx, Paul
