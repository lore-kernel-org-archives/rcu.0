Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D1568FDC;
	Thu, 10 Sep 2026 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062727; cv=none; b=bGcMyVHbLbAXxZW6NCKMJa902/CAgx5EebEHwQhqm0RohtguCzjb8+xw5sac06JkEdp7lMHt/S8pBJ2p4t8ZDINhupz1H9gMNNwBzUmWu1Q7aCM1Gud8tD+m0vcM9DYCHWml8vGqLMq5S1s6B4CLq2fj84/L/tmjP1rywBhtPEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062727; c=relaxed/simple;
	bh=AnnNIzpbOfyYqkmvYoAw7hwb2MzMdlHdv89Xe+blWGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF2QmkcRTUHT4SHStEUZBHfGV+e0xAOP3rVNeDCJd0rJsTczy2unNyMld+9X8sxJmGW4BFBaFWpFWGNUQ3AwLVB2oAwM/6mpdJSHL93MSXWooXw9fhA/wit3stiP+XuTYXnI78QITVL49TLrMUz9B64wKQLmzGN0KfGZvCJVa/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2j9lgpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2j9lgpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919901F00893;
	Thu, 10 Sep 2026 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789062716;
	bh=Ga2HOa1loKq0jBHu59mKdChd26mC2i9x8MQreihVwCk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=i2j9lgpDVLRaoN4+nZpvoEmxQjIWi/WUTqHCARRpW9v1qb0eK+3RomrY+8XNJgSDP
	 njKLU11hVrGVJLXioGK4gl5m1cjfT3RNs5V7PG5Ki9DH95snF4uL29cpl8voGj9mDl
	 vUXwjugOv/Vc4FmiIRdY4Nhqmm3OyqoiGybf4BecBn6G6I4cU0q0NqVsJ8QiLuTE/S
	 4VQ2j2k7aontLvX2UayKWOric2A5BPY11UEoqEGsc/LcSg2D2WyBfvGMaD24FFPmVW
	 ftCDpluXqe1KapNtb/eIYxW/2Kzn86gNc+RCE48SIhq4+PZEv7cMzrRB3gm6PHler3
	 xFI37FcWoJVSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4662DCE19CD; Thu, 10 Sep 2026 10:51:56 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:51:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: urezki@gmail.com, harry@kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, boqun@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, corbet@lwn.net, skhan@linuxfoundation.org,
	rdunlap@infradead.org, surenb@google.com, vbabka@kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] rcu: make userspace barrier hook drain kvfree_rcu
 work
Message-ID: <6092a9d0-0125-4da4-ac48-85ccaeb83beb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260910101112.1648978-1-matthias.goergens@gmail.com>
 <20260910170040.344864-1-matthias.goergens@gmail.com>
 <20260910170040.344864-2-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910170040.344864-2-matthias.goergens@gmail.com>

On Fri, Sep 11, 2026 at 01:00:40AM +0800, Matthias Goergens wrote:
> The bcachefs ktest allocation-leak check writes rcutree.do_rcu_barrier
> before reading /proc/allocinfo. While testing bcachefs performance
> changes, small objects released with kfree_rcu() remained visible after
> repeated writes to the hook and 20 seconds of waiting, causing otherwise
> clean tests to fail their leak check.
> 
> The test assumes a stronger contract than the hook currently documents:
> rcu_barrier() waits for ordinary callbacks, but does not flush objects
> still held in kfree_rcu() batching or per-CPU SLUB sheaves. The retained
> population eventually fell as a sheaf filled; there is no evidence here
> of unbounded growth or OOM.
> 
> Changing the hook to drain kvfree_rcu() work let the same unmodified
> bcachefs workload pass its allocation check. All eight checkpoints in
> one VM, after 50 through 400 option changes, reported zero retained
> reconcile_scan objects. This motivated the separate private-cache
> reproducer used to isolate the incomplete drain from bcachefs.
> 
> Calling kvfree_rcu_barrier() from rcu_barrier_throttled() was proposed
> when the former API was added in 2024, to restore a clean baseline
> between userspace benchmark runs. The discussion concluded that keeping
> the existing hook name, adding the second operation and documenting both
> was the safest compatibility choice, but the follow-up was not added.
> 
> Add that drain and document the stronger test interface. Keep the
> explicit rcu_barrier() so the hook's ordinary-callback contract does not
> depend on kvfree_rcu_barrier() reaching an ordinary barrier internally.
> 
> Do not reuse the ordinary rcu_barrier() sequence as an early-completion
> check while throttling: an unrelated ordinary barrier does not establish
> that kvfree_rcu() work was drained. Retain the existing start-rate limit.
> 
> Four fresh VM pairs with the full private-cache fixture retained the
> queued object without the patch (60 to 60 active objects) and drained it
> with the patch (60 to 59). A separate ordinary-callback regression test
> passed on both kernels.
> 
> Link: https://lore.kernel.org/all/20240820155935.1167988-1-urezki@gmail.com/
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  7 ++---
>  kernel/rcu/tree.c                             | 27 ++++++++++++-------
>  2 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 68647ff4bdd2..244a53166249 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5699,9 +5699,10 @@ Kernel parameters
>  			there is an ongoing too-long CSD-lock wait.
>  
>  	rcutree.do_rcu_barrier=	[KNL]
> -			Request a call to rcu_barrier().  This is
> -			throttled so that userspace tests can safely
> -			hammer on the sysfs variable if they so choose.
> +			Request that deferred kfree_rcu() objects and
> +			ordinary call_rcu() callbacks be drained.  This is
> +			throttled so that userspace tests can safely hammer
> +			on the sysfs variable if they so choose.
>  			If triggered before the RCU grace-period machinery
>  			is fully active, this will error out with EAGAIN.
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 96848fc1f02b..014e28ec3bd3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3989,12 +3989,12 @@ EXPORT_SYMBOL_GPL(rcu_barrier);
>  static unsigned long rcu_barrier_last_throttle;
>  
>  /**
> - * rcu_barrier_throttled - Do rcu_barrier(), but limit to one per second
> + * rcu_barrier_throttled - Drain deferred RCU frees, but rate-limit starts
>   *
> - * This can be thought of as guard rails around rcu_barrier() that
> - * permits unrestricted userspace use, at least assuming the hardware's
> - * try_cmpxchg() is robust.  There will be at most one call per second to
> - * rcu_barrier() system-wide from use of this function, which means that
> + * This can be thought of as guard rails around the deferred-free barriers
> + * that permit unrestricted userspace use, at least assuming the hardware's
> + * try_cmpxchg() is robust.  There will be at most one drain operation started
> + * per sixteenth of a second from use of this function, which means that
>   * callers might needlessly wait a second or three.
>   *
>   * This is intended for use by test suites to avoid OOM by flushing RCU
> @@ -4011,18 +4011,25 @@ static void rcu_barrier_throttled(void)
>  {
>  	unsigned long j = jiffies;
>  	unsigned long old = READ_ONCE(rcu_barrier_last_throttle);
> -	unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
>  
>  	while (time_in_range(j, old, old + HZ / 16) ||
>  	       !try_cmpxchg(&rcu_barrier_last_throttle, &old, j)) {
>  		schedule_timeout_idle(HZ / 16);
> -		if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
> -			smp_mb(); /* caller's subsequent code after above check. */
> -			return;

Don't we still want to skip the rcu_barrier() in this case?  Or am I missing
something subtle here?

								Thanx, Paul

> -		}
>  		j = jiffies;
>  		old = READ_ONCE(rcu_barrier_last_throttle);
>  	}
> +	/*
> +	 * kfree_rcu() can retain objects outside the ordinary callback lists in
> +	 * per-CPU SLUB sheaves and kvfree_rcu batches.  Test suites use this hook
> +	 * to prevent deferred frees from spilling into the following test, so
> +	 * drain those queues as well as ordinary call_rcu() callbacks.
> +	 *
> +	 * kvfree_rcu_barrier() currently includes an ordinary barrier, but that
> +	 * is not part of its documented API.  Keep the explicit rcu_barrier() so
> +	 * this hook's original contract does not depend on slab implementation
> +	 * details.
> +	 */
> +	kvfree_rcu_barrier();
>  	rcu_barrier();
>  }
>  
> -- 
> 2.55.0
> 
