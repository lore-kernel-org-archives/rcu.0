Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208379;
	b=5e1qVAj1FfS17J9CZTBlmYKYeh6NBibQLtcQWTiwOwPMrcysTlL9RYYTH4bRjktEcM+G
	 zrdKUC2BEgSknXBL/2n7936yTo/UMfZg/assDfYksoMv6UjOaS80tXpyWOAxKxpdtVIWl
	 LdQ8j7e1jdNwyYN3Qr5xEtmy8sq4BJLJjJd7bzKwlAIeHILswdJ/BNcB+GPeHfaUR8/97
	 rn7TkGat8Oe7gtic5K5wTFiPuNiPLen8UEU8FJO7qjBUbIGPr7dYC52qJ3n0j3sM51iSx
	 T6qFpAwAYkh56B4ClLGPR37g1JRUXqrvm+0+bp5d+4Mnx3y01Vp5KtPJyN06V8TUXJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208379;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=GEJKe1d+4X4wVLIgCq1iUH0EnoS9cT5q0+W0Fv5/iSM=;
	b=jnN/hyFW47R7fbJwdSLiaOW1Uom85ifhoQbZmKzs3hUATiip4/SfwmF9Q6QjQdqUfKfT
	 LlqCFffxZPkx3pQ6ssrHNhBXdtKFsySYP9L/5SBIvXToz8jGt5/WHFhCT7G92Mo36BWwQ
	 cAvybNU1ToErSbgppEsNWt58kqK/0vGa5ANi48mmOjBKmMPFdJpyNKLPwi0cY6wG070lh
	 +rA3152wDkrZ0Y7QUL0pni79vs3S+pJOflnYOIM6zmKVnmAaRGWLa5KUYguKc0z2VmQKz
	 XqnVJxBE4m316zB5SpdJgkbwZwcUqXJDRGgjj0cRXGK1B652ZbIACz4s/+KfxOiO5BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIR8NzH3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DB606A31C;
	Wed, 28 Oct 2026 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIR8NzH3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D757E1F01828;
	Wed, 28 Oct 2026 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793208378;
	bh=GEJKe1d+4X4wVLIgCq1iUH0EnoS9cT5q0+W0Fv5/iSM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=DIR8NzH3XozMmdHifampAct7beSoysEmzx8aQUwEgeTKe4FcxWI3uwS08cYram5GH
	 JjTZE9gkvd0Ym2ZUS1wUo8OpWhcb0D4iplXIapvrGl+WxS/sJm9Ony47cR6B4OOgel
	 wp+4GhB5fy9OYwRrAE5EMGaM5fXcpqPaL+njHvV4CuEIaL97mc7AVo7heyq4nZk9Kc
	 tfE97izn8wjhqOnJ/xG6LpDgy5DXgEZH8Zphnz8E1Mn4A1HqdYIYy9U2cVWFm32nDz
	 cK6KhmDJaK4/oD57vnyUniYbNpQ/cy2T9gI4th0LEYdJaNQHFzMJcvVzSWnxG+LHis
	 +5AbTTwSdh6Ag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A1655CE0B56; Wed, 28 Oct 2026 10:26:18 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:26:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Gary Guo <gary@garyguo.net>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>, rcu@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu/dev 1/4] hazptrtorture: Release all deferred hazard
 pointers before stopping
Message-ID: <eb59edbb-c6e8-49c6-a426-c55cdb792853@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261027163811.2470569-1-parri.andrea@gmail.com>
 <20261027163811.2470569-2-parri.andrea@gmail.com>
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
In-Reply-To: <20261027163811.2470569-2-parri.andrea@gmail.com>

On Tue, Oct 27, 2026 at 05:38:03PM +0100, Andrea Parri wrote:
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
> hazptr_torture_cleanup() stops the do_pending kthread first, then the
> writer, then the readers.  Once torture_must_stop(), do_pending makes
> one last pass and leaves its loop, but unless stutter_will_wait(), that
> pass releases the deferred hazard pointers of a single CPU.
> 
> Readers can also still defer after that pass, from the iteration they
> are in when torture_must_stop() becomes true.  Readers that have left
> their loop hold no hazard pointer, so the writer waits on one of the 25
> deferred hazard pointers above (reldefer - relundefer) that nothing
> releases.
> 
> Stop the readers before do_pending, and do_pending before the writer.
> do_pending still leaves its loop at torture_must_stop(), and now
> releases the deferred hazard pointers of all CPUs once
> torture_kthread_stopping() returns, that is, once
> hazptr_torture_cleanup() stops it, after the readers.  The writer can
> still wait in ->sync(), but only until then.
> 
> This should be safe because readers defer only from their own loop,
> which they have left once torture_stop_kthread() returns for them, and
> the hazptr_torture_acquire() IPI runs synchronously within that loop.
> The readers do not need the writer to stop: they leave their loop at
> torture_must_stop(), after at most one stutter_wait().
> 
> do_pending keeps the torture_must_stop() check before its sleep.  A
> kthread_stop() that comes after that check and before the sleep starts
> still delays do_pending's exit by a full kthread_do_pending_ms sleep,
> however long that is.  With the readers stopped first, this happens
> only if do_pending passed the check before the test began stopping and
> had not yet gone to sleep when kthread_stop() came, after all the
> readers had stopped.
> 
> With this change, a 30-minute PREEMPT run on x86_64 with 8 CPUs ends
> with "End of test: SUCCESS" and with as many hazard pointers released
> from the pending lists as were deferred (reldefer: 983727 relundefer
> 983727).
> 
> The hang was found with the help of an LLM.
> 
> Fixes: f23d7b47ced9 ("hazptrtorture: Add kthread to release deferred hazard pointers")
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Again, thank you!

Please see the question below.

							Thanx, Paul

> ---
>  kernel/rcu/hazptrtorture.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
> index 7c8b5899fb011..c46083a8af093 100644
> --- a/kernel/rcu/hazptrtorture.c
> +++ b/kernel/rcu/hazptrtorture.c
> @@ -560,6 +560,9 @@ static int hazptr_torture_do_pending(void *arg)
>  		// Omit stutter_wait() because this function needs to do cleanup.
>  	} while (!torture_must_stop());

The torture_must_stop() function expands to this condition:

	torture_must_stop_irq() || kthread_should_stop()

The torture_must_stop_irq() function expands to this condition:

	READ_ONCE(fullstop) != FULLSTOP_DONTSTOP

And the fullstop variable is set to FULLSTOP_RMMOD by
torture_cleanup_begin() (unless it has already been set to
FULLSTOP_SHUTDOWN).

And torture_cleanup_begin() is invoked by hazptr_torture_cleanup()
right at the beginning, before reaching any of the calls to
torture_stop_kthread().

So doesn't the above torture_must_stop() instead need to be
kthread_should_stop()?

As it is, hazptr_torture_do_pending() will still stop before the
hazptr_torture_reader() instances do, correct?

Or am I missing something subtle here?

>  	torture_kthread_stopping("hazptr_torture_do_pending");
> +	/* The readers have stopped, so nothing new can be deferred. */
> +	for_each_possible_cpu(cpu)
> +		hazptr_torture_do_one_pending(cpu, &rand);
>  	return 0;
>  }
>  
> @@ -773,9 +776,7 @@ hazptr_torture_cleanup(void)
>  		return;
>  	}
>  
> -	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
>  	torture_stop_kthread(hazptr_torture_preempt, preempt_task);
> -	torture_stop_kthread(hazptr_torture_writer, writer_task);
>  
>  	if (reader_tasks) {
>  		for (i = 0; i < nrealreaders; i++)
> @@ -785,6 +786,14 @@ hazptr_torture_cleanup(void)
>  		reader_tasks = NULL;
>  	}
>  
> +	/*
> +	 * Stop the writer only after do_pending, and do_pending only after
> +	 * the readers: the writer may be waiting on hazard pointers that
> +	 * readers deferred, which do_pending releases once they stopped.
> +	 */
> +	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
> +	torture_stop_kthread(hazptr_torture_writer, writer_task);
> +
>  	torture_stop_kthread(hazptr_torture_stats, stats_task);
>  
>  	/* Do torture-type-specific cleanup operations.  */
> -- 
> 2.53.0
> 
