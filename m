Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11600745F4;
	Sun, 20 Oct 2024 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729466092; cv=none; b=NBm1WuT02Vvkt2xNVdxntvtXYwCY23R32OlPhmhP/CdLGoOrhctIpxj9L9pSmGxZ+Bij9OX0zACGd3x44bvfPv2f20oPIKbHjOsConOid0whsiHUe80OH4Mg4IFGFvp8/g8aow/xb34nk6j2bgmL/ceyR4n/gSVTkliGqoJ7Qt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729466092; c=relaxed/simple;
	bh=DIi4/V5oy+QjUgVMTE0K4vNn0oH0o0UhK2mlYcDmo10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZALp4D59g3lMJDCmMk8Yf66DL7GpxyEDzueUWXFdUUe4tXx4kYcsRWAS8HDUJd53fU0siFA8FP+HlEl0FUvs0ChG2eLan5SnqrBOdW2pJx8sp9N2is8gw00/naJNwMs2raBgc03J1G3cVMaQkAqkR8U4aOBUDvqu8WXvm5xJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANPCY+4R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANPCY+4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2557DC4CEC6;
	Sun, 20 Oct 2024 23:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729466091;
	bh=DIi4/V5oy+QjUgVMTE0K4vNn0oH0o0UhK2mlYcDmo10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANPCY+4RivGNlyRmkH4jF1h9FH8W5QhidZnNmXy7yp+2uFYm9uiW4RaLZD/Pl6mMw
	 WGdZbw7FTjgR+VFLweuLOSlScdrCRp4KRqTLmsZaRiWS+LAy28ihr6kr6GrkxMfrjf
	 3v+s+4Smkkxs/E4KIVotBs6/5pOP6VNmSszI1LhWdML7iFR1Iz/qRmMidXI57EuWDi
	 N1AsopigdJYrWvxFlCzKbPsDcGBYLIJ66EuL4T/dIR1MPN2zJIMQuIo5aC/vQq5kGs
	 xhwu6yWyaNpzBFYgZoNYbvIEYnpKuA6ViJMGSK7Jz9eH4bk7gOYS3gFMeBtcTBx1Zu
	 Uy4eiLHXZVz1g==
Date: Mon, 21 Oct 2024 01:14:48 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix the WARN_ON_ONCE() in
 rcu_nocb_rdp_deoffload()
Message-ID: <ZxWO6BmRutOC0RnZ@pavilion.home>
References: <20241020125119.14751-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241020125119.14751-1-qiang.zhang1211@gmail.com>

Le Sun, Oct 20, 2024 at 08:51:19PM +0800, Zqiang a écrit :
> Currently, running rcutorture test with torture_type=rcu fwd_progress=8
> n_barrier_cbs=8 nocbs_nthreads=8 nocbs_toggle=100 onoff_interval=60
> test_boost=2, will trigger the following warning:
> 
> WARNING: CPU: 19 PID: 100 at kernel/rcu/tree_nocb.h:1061 rcu_nocb_rdp_deoffload+0x292/0x2a0
> RIP: 0010:rcu_nocb_rdp_deoffload+0x292/0x2a0
> [18839.537322] Call Trace:
> [18839.538006]  <TASK>
> [18839.538596]  ? __warn+0x7e/0x120
> [18839.539491]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
> [18839.540757]  ? report_bug+0x18e/0x1a0
> [18839.541805]  ? handle_bug+0x3d/0x70
> [18839.542837]  ? exc_invalid_op+0x18/0x70
> [18839.543959]  ? asm_exc_invalid_op+0x1a/0x20
> [18839.545165]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
> [18839.546547]  rcu_nocb_cpu_deoffload+0x70/0xa0
> [18839.547814]  rcu_nocb_toggle+0x136/0x1c0
> [18839.548960]  ? __pfx_rcu_nocb_toggle+0x10/0x10
> [18839.550073]  kthread+0xd1/0x100
> [18839.550958]  ? __pfx_kthread+0x10/0x10
> [18839.552008]  ret_from_fork+0x2f/0x50
> [18839.553002]  ? __pfx_kthread+0x10/0x10
> [18839.553968]  ret_from_fork_asm+0x1a/0x30
> [18839.555038]  </TASK>
> 
> CPU0                               CPU2                          CPU3
> //rcu_nocb_toggle             //nocb_cb_wait                   //rcutorture
> 
> // deoffload CPU1             // process CPU1's rdp
> rcu_barrier()
>     rcu_segcblist_entrain()
>         rcu_segcblist_add_len(1);
>         // len == 2
>         // enqueue barrier
>         // callback to CPU1's
>         // rdp->cblist
>                              rcu_do_batch()
>                                  // invoke CPU1's rdp->cblist
>                                  // callback
>                                  rcu_barrier_callback()
>                                                              rcu_barrier()
>                                                                mutex_lock(&rcu_state.barrier_mutex);
>                                                                // still see len == 2
>                                                                // enqueue barrier callback
>                                                                // to CPU1's rdp->cblist
>                                                                rcu_segcblist_entrain()
>                                                                    rcu_segcblist_add_len(1);
>                                                                    // len == 3
>                                  // decrement len
>                                  rcu_segcblist_add_len(-2);
>                              kthread_parkme()
> 
> // CPU1's rdp->cblist len == 1
> // Warn because there is
> // still a pending barrier
> // trigger warning
> WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
> cpus_read_unlock();
> 
>                                                                 // wait CPU1 comes online
>                                                                 // invoke barrier callback on
>                                                                 // CPU1 rdp's->cblist
>                                                                 wait_for_completion(&rcu_state.barrier_completion);
> // deoffload CPU4
> cpus_read_lock()
>   rcu_barrier()
>     mutex_lock(&rcu_state.barrier_mutex);
>     // block on barrier_mutex
>     // wait rcu_barrier() on
>     // CPU3 to unlock barrier_mutex
>     // but CPU3 unlock barrier_mutex
>     // need to wait CPU1 comes online
>     // when CPU1 going online will block on cpus_write_lock
> 
> The above scenario will not only trigger WARN_ON_ONCE(), but also
> trigger deadlock, this commit therefore check rdp->cblist length
> before invoke kthread_parkme(), and the kthread_parkme() is not
> invoke until length reaches zero.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/tree_nocb.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 8648233e1717..a2b0ebdefee3 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -893,6 +893,12 @@ static inline bool nocb_cb_wait_cond(struct rcu_data *rdp)
>  	return !READ_ONCE(rdp->nocb_cb_sleep) || kthread_should_park();
>  }
>  
> +static inline bool nocb_cblist_empty(struct rcu_data *rdp)
> +{
> +	return !(rcu_rdp_is_offloaded(rdp) &&

But the rdp has to be offloaded when nocb_cb_wait() is running, and that
include the times when it is parking and when it is unparking.

> +		WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist)));

And like your scenario above shows, it's possible to reach here with
callbacks. So this check shouldn't be a warning at that point?

> +}
> +
>  /*
>   * Invoke any ready callbacks from the corresponding no-CBs CPU,
>   * then, if there are no more, wait for more to appear.
> @@ -907,7 +913,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
>  
>  	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
>  					    nocb_cb_wait_cond(rdp));
> -	if (kthread_should_park()) {
> +	if (kthread_should_park() && nocb_cblist_empty(rdp)) {

What about this instead? If the second barrier is queued before
the final check to rcu_segcblist_ready_cbs() in nocb_cb_wait(), this
will be noticed and ->nocb_cb_sleep will remain false. If otherwise rcu_barrier()
is called after that final rcu_segcblist_ready_cbs() check, it will observe
the final decrement to zero and won't entrain the callback.

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 16865475120b..0de07d44646c 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -891,7 +891,19 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
 					    nocb_cb_wait_cond(rdp));
 	if (kthread_should_park()) {
-		kthread_parkme();
+		/*
+		 * kthread_park() must be preceded by an rcu_barrier().
+		 * But yet another rcu_barrier() might have sneaked in between
+		 * the barrier callback execution and the callbacks counter
+		 * decrement.
+		 */
+		if (rdp->nocb_cb_sleep) {
+			rcu_nocb_lock_irqsave(rdp, flags);
+			WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+
+			kthread_parkme();
+		}
 	} else if (READ_ONCE(rdp->nocb_cb_sleep)) {
 		WARN_ON(signal_pending(current));
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
