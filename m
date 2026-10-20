Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522149;
	b=J/Cw2q1NgzeIZQutNeoOCxYQrr+iWIAsg6HOQheLg267W0Rx6OtR/vp6+M1u6ZHh+NSA
	 fB5WnazG73OhYuyIkMoZWKL3zon3whBUTFFfs8wvr+P1T/CnvkfxsG4McIeIM2iHO71Q9
	 jaPQtxX7TJBvMQVYlIPRlNQC+CcY/JufHTOXous3B5lAOxxeJuUlH7GZ0YUm1ZcbvRFgc
	 jN3R75PmztJagv3OTJFgYQHVHHNw1fXmz5kidsgKY8cdauIvY46yW1/lPAfMrwVAizQAU
	 LvLohzeYUA+nFi1bYPIKJBIXkvV5zUTO65IHc3Edyjyq+W0m1ifgdk3p1Ll0X8xDP0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522149;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=61+e+z9lnj6B3jVuxnAy0csTPT5IQym/RO7PRxMGcPo=;
	b=D+/ffMe8+4kc9m1+UtrzOED/w45AfbzV4BUN1rgplpVGG2RJBW3+2BTISOmnUFzkMhjJ
	 WWtpI+X/h7k1Kg9L/5Vdee0WR7ovDvGzwZxL/oLyr6ucrhrEuiorZSfv91hONPIdj7ivl
	 cfSWHapsbZLzoG5HTe6JJTFzNIR6hAXJXfmf7Oi3IiKBwZOYkwts9lqFZBVv6vvC74lC2
	 zdwcEIq1+KtXu/3c1tWR/F7LuGAyk7GHIEvWnTPsXihVzud7g/SncJZk76fsBsxBG5Hnn
	 73C7YLQn+S4rt9c3VWbZH0iP2UmcmShPwUsrEruDYsX2QK+2Piy5OTmVfpdzEG+TK/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2dGw3QT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006A606A320;
	Tue, 20 Oct 2026 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2dGw3QT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979F91F000CC;
	Tue, 20 Oct 2026 18:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522148;
	bh=61+e+z9lnj6B3jVuxnAy0csTPT5IQym/RO7PRxMGcPo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=G2dGw3QThP0zv0jOoL+Vgc2f8VxdIgYzAC80hMQT2elKtaAkKBpqIOLkeC1F2e8eq
	 zTyVsyx9xY08UgVb8N9kF4xwL9nQMowaPt/aBZbsHxhN2ysLzrV6ONJXL851plssUp
	 PGFlT7Jb4By88yVPcTQRs4XA0r8QN4EByS0VfwxMpDubDtT5Mbnu8iDfpvXBE4tncX
	 k83WSkGF/nCcoBsw1rv5/+AvpzOC7qL7K4xYrPzJAZ4CzN2PiI5ca5Zs2TxyM428Xn
	 h3Nfb3UWcXz3TWyUcO84/+SANrLij+wn9AuWVQh0JbpVm+9m6zFALHpbqCi3ZYKI53
	 SLVULm6HLHGIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 47566CE09E8; Tue, 20 Oct 2026 11:49:08 -0700 (PDT)
Date: Tue, 20 Oct 2026 11:49:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC -rcu/dev] hazptrtorture: Release all deferred hazard
 pointers before stopping
Message-ID: <3e7abe29-df1f-4cb6-884f-dd0a70c5311f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261019162005.12888-1-parri.andrea@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019162005.12888-1-parri.andrea@gmail.com>

On Mon, Oct 19, 2026 at 06:20:03PM +0200, Andrea Parri wrote:
> hazptrtorture can hang at shutdown when deferral is enabled, as in the
> PREEMPT scenario: the writer stays in ->sync() and kthread_stop() on it
> never returns, until kvm.sh kills QEMU:
> 
>     [ 1800.899278] hazptr-torture: Stopping hazptr_torture_do_pending task
>     [ 1800.899447] hazptr-torture: Stopping hazptr_torture_writer task
>     [ 1812.713870] hazptr-torture: rtc: 00000000225df70a ver: 12436 HTWS_SYNC tfle: 0 rta: 12437 rtaf: 0 rtf: 12427 onoff: 48783/48783:48786/48786 3,254:3,280 611671:731494 (HZ=1000) acq: 5720353149 rel: 5720210186 acqirq: 571927 relirq: 714778 reldefer: 714139 relundefer 714114
>     [ 1812.713971] hazptr-torture: hazptr_torture_stats is stopping
> 
>     Summary: Potential hang (QEMU killed)
>     !!! PID 1393523 hung at 1980 vs. 1800 seconds
> 
> hazptr_torture_cleanup() stops the do_pending kthread before the writer
> and the readers.  Once torture_must_stop(), do_pending makes one last
> pass and leaves its loop, but unless stutter_will_wait(), that pass
> releases the deferred hazard pointers of a single CPU.
> 
> Readers can also still defer after that pass, from the iteration they
> are in when torture_must_stop() becomes true.  Stopped readers hold no
> hazard pointer, so the writer waits on one of the 25 deferred hazard
> pointers above (reldefer - relundefer) that nothing releases.
> 
> Keep do_pending running until hazptr_torture_cleanup() stops it, after
> the writer and the readers, releasing the deferred hazard pointers of
> all CPUs on each pass once torture_must_stop() and once more on exit.
> It now also sleeps between those passes, and kthread_stop() wakes it.
> 
> This should be safe because readers defer only from their own loop,
> which they have left once torture_stop_kthread() returns for them, and
> the hazptr_torture_acquire() IPI runs synchronously within that loop.
> 
> With this change, a 30-minute PREEMPT run on x86_64 with 8 CPUs ends
> with "End of test: SUCCESS" and with as many hazard pointers released
> from the pending lists as were deferred (reldefer: 960658 relundefer
> 960658).
> 
> Fixes: f23d7b47ced9 ("hazptrtorture: Add kthread to release deferred hazard pointers")
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Thank you for digging into this!  Some questions and comments interspersed
below.

							Thanx, Paul

> ---
>  kernel/rcu/hazptrtorture.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
> index 7c8b5899fb011..5153720074644 100644
> --- a/kernel/rcu/hazptrtorture.c
> +++ b/kernel/rcu/hazptrtorture.c
> @@ -547,18 +547,25 @@ static int hazptr_torture_do_pending(void *arg)
>  	DEFINE_TORTURE_RANDOM(rand);
>  
>  	VERBOSE_TOROUT_STRING("hazptr_torture_do_pending task started");
> -	do {
> -		if (stutter_will_wait()) {
> +	/*
> +	 * Run until hazptr_torture_cleanup() stops this kthread, not just
> +	 * until torture_must_stop(): the writer can be waiting in ->sync()
> +	 * for a deferred hazard pointer while it is being stopped.
> +	 */
> +	while (!kthread_should_stop()) {
> +		if (torture_must_stop() || stutter_will_wait()) {
>  			for_each_possible_cpu(cpu)
>  				hazptr_torture_do_one_pending(cpu, &rand);
>  		} else {
>  			cpu = cpumask_next_wrap(cpu, cpu_possible_mask);
>  			hazptr_torture_do_one_pending(cpu, &rand);
>  		}
> -		if (!torture_must_stop())
> -			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
> +		torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);

Is the theory here that a kthread_stop() will wake up this sleep anyway?
And if so, would that work if the kthread_stop() already happened?

(I do recall adding the torture_must_stop() checks due to delays at
kthread_stop() time, but perhaps things have changed since then.)

>  		// Omit stutter_wait() because this function needs to do cleanup.
> -	} while (!torture_must_stop());
> +	}
> +	/* The readers have stopped, so nothing new can be deferred. */
> +	for_each_possible_cpu(cpu)
> +		hazptr_torture_do_one_pending(cpu, &rand);

Very good!

But given these two lines, do we need the changes to the loop?

>  	torture_kthread_stopping("hazptr_torture_do_pending");
>  	return 0;
>  }
> @@ -773,7 +780,6 @@ hazptr_torture_cleanup(void)
>  		return;
>  	}
>  
> -	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
>  	torture_stop_kthread(hazptr_torture_preempt, preempt_task);
>  	torture_stop_kthread(hazptr_torture_writer, writer_task);
>  
> @@ -785,6 +791,12 @@ hazptr_torture_cleanup(void)
>  		reader_tasks = NULL;
>  	}
>  
> +	/*
> +	 * Stop do_pending only after the writer and the readers: the writer
> +	 * may be waiting on hazard pointers that readers deferred.
> +	 */
> +	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
> +

And this change looks good.

>  	torture_stop_kthread(hazptr_torture_stats, stats_task);
>  
>  	/* Do torture-type-specific cleanup operations.  */
> 
> -- 
> 2.53.0
> 
