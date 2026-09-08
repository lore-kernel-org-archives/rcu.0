Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7043B05B0;
	Tue,  8 Sep 2026 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788899345; cv=none; b=HSbqgm1+eysYE9PLJvf4hOIfKQzqSMYLqKMNy+U+/mdl2PwyFIm/rCqXR3mZtn6PYUkDVG7odgI7sddVPXHqKcqQwCDDeY4eG5EHADy9zvAc0zTTPtN6ZPlh5REk/GQxlKb6UYeNsQQTX/jnRVss6ceYWWQBPyA98KrhxveiD5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788899345; c=relaxed/simple;
	bh=wkB3TVnakfJAcjfXFDta8JYcQsg9hg4Qi6d1R1AaR/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIF0t8Lk9iQX5PHgAtweVd4HTEy13eBAdzXkZCT7nFxos+lyccscNhpGd2b7cvlacmedzFaMZ8dLLCcCOfY/V1D06qzdjlc3G3cyylIGHkRH2AKXNZC8p+iEeJx1cwdT2EkMfKTEoPgX4x2Qqdd/vR4wT9Ng60URd5p334bFg84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlmQUng8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlmQUng8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1D91F00A3A;
	Tue,  8 Sep 2026 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788899344;
	bh=/dJPJeOSGvBvwBPr4h9ly4OoXEGhRaYu3+8uD1dUxQU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=nlmQUng88aq+xf9prtXEGHtqQkkVay1P6z8GsISN17fx+DQuq98W46R0FLaINf7Uw
	 Kq89csuzB+GPy8nOMnlDKUlKLiuRvM2G1aXHAA2W8bo+rVzN5TM9RB9vWQ/2zgz6RT
	 NkD2lkooUEiXv9gDW7OOgJHUGsPoF5hCIzBZkHwXVqJ7cXXgPqsasBHmuys8P5bXn4
	 8dtrcQ1HZ1n2QeOp/Xz6urnGCPVDyNouyVds/NGV22GJsEhniv506qXHYjD2EJe65J
	 AoumiEvhdyRqsV4U8ie0yOdKzBUpdQQJqANlnXnnOyjHOYgiBLM0FvA2tkw127mV5m
	 ZSwnRd+vRTl8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2367FCE1902; Tue,  8 Sep 2026 13:29:04 -0700 (PDT)
Date: Tue, 8 Sep 2026 13:29:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 03/13] srcutree: Add reader-free fastpath to
 synchronize_srcu_atomic()
Message-ID: <b7bc58aa-4b8a-4eaa-a7e8-8d338f34d14a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-4-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907075829.2073224-4-kunwu.chan@linux.dev>

On Mon, Sep 07, 2026 at 03:58:19PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> synchronize_srcu_atomic() is restricted to srcu_read_lock_atomic() and
> srcu_read_unlock_atomic(), whose read-side critical sections disable
> preemption.  In the common case where there are no readers at all, the
> grace period therefore need not do the index flip.  Add a fastpath
> that sums both ranks of the per-CPU ->srcu_ctrs[] counters and, if the
> lock counts match the unlock counts on both ranks, ends the grace
> period immediately, skipping the srcu_advance_state() scans, mirroring
> the similar Tiny SRCU fastpath.
> 
> Correctness requires the counter-sum proof to follow the grace-period
> anchor written by srcu_gp_start(); placing it before the anchor could
> let this grace period miss a pre-existing reader and return without
> waiting for it.  The smp_mb() between the unlock and lock sums pairs
> with the smp_mb() in __srcu_read_lock().  The grace period is ended
> manually under ->lock and ->srcu_atomic_gp_flag.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Adding David Woodhouse on CC.

David, does this provide appropriate performance in your use case?

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 48 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 7dd705eec573..533607de5728 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -2113,6 +2113,8 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
>  {
>  	unsigned long srcu_state;
>  	struct srcu_usage *sup = ssp->srcu_sup;
> +	unsigned long rdm0, rdm1;
> +	unsigned long unlocks0, unlocks1;
>  
>  	// Initialize.	Either init_srcu_struct() was invoked or
>  	// DEFINE_SRCU() or similar was used.  Therefore, no allocation
> @@ -2149,6 +2151,52 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
>  	srcu_gp_start(ssp);
>  	raw_spin_unlock_irq_rcu_node(sup);
>  
> +	//
> +	// Fastpath:  If there are no readers at all, neither grace-period
> +	// scan need wait, so both can be satisfied at once without doing
> +	// the index flip.  The counter-sum proof is the same as that of
> +	// srcu_readers_active_idx_check(), but spanning both indices.
> +	// Atomic SRCU guarantees that all readers are of
> +	// SRCU_READ_FLAVOR_ATOMIC, so the SLOWGP check never triggers and
> +	// the ->srcu_reader_flavor masks returned by
> +	// srcu_readers_unlock_idx() are unused.
> +	//
> +	// This proof must follow the grace-period anchor written by the
> +	// srcu_gp_start() above, never precede it.  With the anchor first,
> +	// a reader whose lock increment is missed by the sums below cannot
> +	// have incremented its lock counter before the anchor, and therefore
> +	// cannot be a pre-existing reader of this grace period.  Placing the
> +	// proof before the anchor would let this grace period miss a
> +	// pre-existing reader and return without waiting for it.
> +	//
> +	// The smp_mb() pairs with the smp_mb() in __srcu_read_lock()
> +	// (store-buffering pattern), which guarantees that a lock is always
> +	// counted if the corresponding unlock is counted, the same
> +	// memory-ordering guarantee as is provided by
> +	// srcu_readers_active_idx_check().
> +	//
> +	unlocks0 = srcu_readers_unlock_idx(ssp, 0, &rdm0);
> +	unlocks1 = srcu_readers_unlock_idx(ssp, 1, &rdm1);
> +	smp_mb(); /* A */
> +	if (srcu_readers_lock_idx(ssp, 0, false, unlocks0) &&
> +	    srcu_readers_lock_idx(ssp, 1, false, unlocks1)) {
> +		// No readers, so end this grace period manually, skipping
> +		// the index flip.  Advancing the sequence number via
> +		// rcu_seq_start() in srcu_gp_start() above and rcu_seq_end()
> +		// below keeps get_state_synchronize_srcu() and
> +		// poll_state_synchronize_srcu() working, all under ->lock
> +		// and ->srcu_atomic_gp_flag, which excludes concurrent
> +		// sequence-number updates.
> +		raw_spin_lock_irq_rcu_node(sup);
> +		rcu_seq_end(&sup->srcu_gp_seq);
> +		raw_spin_unlock_irq_rcu_node(sup);
> +		WARN_ON_ONCE(!poll_state_synchronize_srcu(ssp, srcu_state));
> +		atomic_set_release(&sup->srcu_atomic_gp_flag, 0);
> +		preempt_enable();
> +		non_block_end();
> +		return;
> +	}
> +
>  	// Wait for it to complete, helping it along.
>  	while (!poll_state_synchronize_srcu(ssp, srcu_state)) {
>  		cpu_relax();
> -- 
> 2.43.0
> 
