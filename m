Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8542E421;
	Fri, 11 Sep 2026 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141478; cv=none; b=m/wWoOYiXqVbJMi0X+yt9jjEZtz/1FFmlfxV6FsHJndEKeePRrq/2qB1WxhCefPSHgnwoLOoXULPndNltrssaT6P0FI24HPYJOVYcKv7OENn4yT4J++Wwj9mXoKot3dsIya7WJ+aX/3g1eGyjeGP0y07v2C3+w9gwF+x0tHj1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141478; c=relaxed/simple;
	bh=dIrbDnzgyXhHod8pRVMH4sZvy6JWr/7Wtzlgh1Obah8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvusU2PUaP4uVuK8gIz7VNP1z+l2KR96Os/qLcsMvAva8RrE2x+3G/Xlhod3m4nlqmNx6pWshjZLVavfu3SeGGsb2KOoZsiNttZ3ewTMLnMk6wxf87hZkFf2lFsIlHaNUTRqtADYdO/v+bUGDT4XTcFODCohVQdeUAyWNDdexW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lmee9QMr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lmee9QMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7064F1F000FF;
	Fri, 11 Sep 2026 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789141476;
	bh=1B/r3anMNhgtOBMW1KxIb2EhbjZvlBVjZ1VTOFwKWAk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Lmee9QMr5Ft/bSPcW2z86IcfA3NUku51rdmD53b9lmn32AkaJhEqeI+M9G4E6zwrG
	 UUdSwmk35IVrniaEEiz5eob74j7ZBka+Ccj6oYkwyTGbPbixBdWoSodUgaDM927AN1
	 iXYKtvnAhMTKFbx1I/SiM2PKx5zlFDdkIpUr11lIlZVuyqRsGZAYgmx6ahW2mU5Sup
	 3m+ry/Ozu/2QpSHF/54DrLpe3KTnsvUZi+R4P08z/USqsCTVJLXFhfx0EU84BZnrAM
	 qMqVd6AuHfRejiNAKjTaRrAFLDWWvuObwzjbYlEYjJLhOLWOs66MlPIWVS/RiJ0O/v
	 bz8F4LEHI9Csg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3AD70CE1902; Fri, 11 Sep 2026 08:44:36 -0700 (PDT)
Date: Fri, 11 Sep 2026 08:44:36 -0700
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
Subject: Re: [PATCH v3 1/1] rcu: make userspace barrier hook drain kvfree_rcu
 work
Message-ID: <7050515d-eadf-4050-9c54-7a202d552b88@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6092a9d0-0125-4da4-ac48-85ccaeb83beb@paulmck-laptop>
 <20260911034059.3569914-1-matthias.goergens@gmail.com>
 <20260911034059.3569914-2-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911034059.3569914-2-matthias.goergens@gmail.com>

On Fri, Sep 11, 2026 at 11:40:59AM +0800, Matthias Goergens wrote:
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
> reconcile_scan objects. This motivated the separate private-cache test
> used to isolate the incomplete drain from bcachefs.
> 
> Calling kvfree_rcu_barrier() from rcu_barrier_throttled() was proposed
> when kvfree_rcu_barrier() was added in 2024, to restore a clean baseline
> between userspace benchmark runs. The discussion concluded that keeping
> the existing hook name, adding the second operation and documenting both
> was the safest compatibility choice, but the follow-up was not added.
> 
> Add that drain and document the stronger test interface. Always retain
> the existing start-rate limit and perform the kvfree_rcu() drain: an
> unrelated ordinary barrier does not establish that this work completed.
> 
> Retain the entry ordinary-barrier sequence snapshot. After draining,
> skip the final ordinary barrier only if that snapshot is complete,
> preserving the memory barrier on the completion path. Otherwise, invoke
> rcu_barrier() explicitly. This keeps the ordinary-callback guarantee
> independent of whether kvfree_rcu_barrier() embeds an ordinary barrier.
> 
> Clarify that the documented completion guarantee covers work queued
> before the request, without preventing new work from being queued.
> 
> Earlier validation of the unconditional-drain version used four fresh
> VM pairs with a private-cache fixture: controls retained the queued
> object (60 to 60 active objects), and treatments drained it (60 to 59).
> An ordinary-callback test passed on both kernels. Those runs predated
> the guarded skip and do not validate that change. No elapsed-time
> improvement is claimed.
> 
> Link: https://lore.kernel.org/all/20240820155935.1167988-1-urezki@gmail.com/
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

Queued for further review and testing, thank you!

							Thanx, Paul

> ---
>  .../admin-guide/kernel-parameters.txt         |  9 ++++--
>  kernel/rcu/tree.c                             | 30 ++++++++++++-------
>  2 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 68647ff4bdd2..914b65ae9413 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5699,9 +5699,12 @@ Kernel parameters
>  			there is an ongoing too-long CSD-lock wait.
>  
>  	rcutree.do_rcu_barrier=	[KNL]
> -			Request a call to rcu_barrier().  This is
> -			throttled so that userspace tests can safely
> -			hammer on the sysfs variable if they so choose.
> +			Wait for deferred kfree_rcu() frees and ordinary
> +			call_rcu() callbacks queued before this request to
> +			complete.  This does not prevent new work from being
> +			queued concurrently.  Requests are throttled so that
> +			userspace tests can safely hammer on the sysfs
> +			variable if they so choose.
>  			If triggered before the RCU grace-period machinery
>  			is fully active, this will error out with EAGAIN.
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 96848fc1f02b..93b71682306c 100644
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
> @@ -4016,14 +4016,24 @@ static void rcu_barrier_throttled(void)
>  	while (time_in_range(j, old, old + HZ / 16) ||
>  	       !try_cmpxchg(&rcu_barrier_last_throttle, &old, j)) {
>  		schedule_timeout_idle(HZ / 16);
> -		if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
> -			smp_mb(); /* caller's subsequent code after above check. */
> -			return;
> -		}
>  		j = jiffies;
>  		old = READ_ONCE(rcu_barrier_last_throttle);
>  	}
> -	rcu_barrier();
> +	/*
> +	 * kfree_rcu() can retain objects outside the ordinary callback lists in
> +	 * per-CPU SLUB sheaves and kvfree_rcu batches.  Always drain those queues:
> +	 * an ordinary barrier does not establish that this work was drained.
> +	 */
> +	kvfree_rcu_barrier();
> +	/*
> +	 * A completed barrier can still cover ordinary callbacks queued before
> +	 * our entry snapshot.  Otherwise, retain an explicit ordinary barrier
> +	 * without depending on the implementation of kvfree_rcu_barrier().
> +	 */
> +	if (rcu_seq_done(&rcu_state.barrier_sequence, s))
> +		smp_mb(); /* caller's subsequent code after above check. */
> +	else
> +		rcu_barrier();
>  }
>  
>  /*
> -- 
> 2.55.0
> 
