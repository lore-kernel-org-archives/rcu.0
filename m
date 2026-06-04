Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B9336896;
	Thu,  4 Jun 2026 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780612144; cv=none; b=Cudcg0KXW6t00/zpzgiwjhQSpF8U4zOJxBI9iCItdQ4esvbqDE4YQKu2iznYpQygRyr2jfdmhnNvL0VloK/+782HGqAID1tai5NPfLXghRtOzgua0BcqOjCBdJJFlRVT7ed+oLi3T5V7LV2XTVPgpO/W7P3xsXnFNZu3/RW7E3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780612144; c=relaxed/simple;
	bh=9q13binj1Gh2mhCoNsaz8Nyhr+DpqkGjH7iScj/pL3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTAoUwpgqqKpHo43adY6AGViymYAAhVEJqetK5oRu0vUSdRW5r08gdqrK0lReszgDPxjMW3gCmb5o6/IsTvKaFPjgKAd89BkhBP2df5Km2acRFB+WV5H5HVqe14EVCKQXAw/8iop3GplHiks9q/rVgdAxAQuHjgra1jnAyZnxmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1zUvoBP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1zUvoBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533061F00893;
	Thu,  4 Jun 2026 22:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780612143;
	bh=aChqsZLCdnwCdbNyuyN+o8J2VhEvDT4W+ZyicK8F/s8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=A1zUvoBPOIRme8oK7mkdSUjzwcbu0bDy23xNMSGCQv8HQqLzwX6oy0CQvm+aO/8W1
	 qIn4UcTLy1xyshjnHR5Y4S23lhyf35pDk4HsMJbkghVZZ0YdOQqkIOHKVIv47mBQXV
	 pEikiP4in4Kix+uR2JPZi/N8EJ8GmQmu0tyYTK+DuCtIUDn7KKfIMswD8BWx2c6EGP
	 d6km3eQr0zuEGcgdpN62rP6S3WdpVKYx3QmIi+7cfRdC8rscXjM1QT1jcrAzgxBCrJ
	 G8iJoJz9Q0GzHvRT4ldlHaIi+1VFLya1tUdaptmFDtCB6U4Tq3VFBf75W6No107T/t
	 vbRv7d9kFiH6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EB526CE0555; Thu,  4 Jun 2026 15:29:02 -0700 (PDT)
Date: Thu, 4 Jun 2026 15:29:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, peterz@infradead.org, fujita.tomonori@gmail.com,
	tamird@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v9 2/4] srcu: expose srcu_readers_active()
Message-ID: <1db254a1-951c-47e9-bb4b-adb5ca00f2fd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260529134004.396743-1-work@onurozkan.dev>
 <20260529134004.396743-3-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260529134004.396743-3-work@onurozkan.dev>

On Fri, May 29, 2026 at 04:39:52PM +0300, Onur Özkan wrote:
> This is needed by rust/helpers/srcu.c which now adds
> rust_helper_srcu_readers_active() as a wrapper around the SRCU helper
> for Rust callers.
> 
> To achive this:
> 
> 1- Move the srcu_readers_active() implementation from
>    "kernel/rcu/srcutree.c" to "include/linux/srcutree.h".
> 
> 2- Implement a matching srcu_readers_active() in
>    "include/linux/srcutiny.h" and use it on the existing open-coded
>    WARN_ON() check in cleanup_srcu_struct().
> 
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Onur Özkan <work@onurozkan.dev>

It would be good to merge the rust/helpers piece of this change into
the separate commit that I suggested for patch 1/4.  Either way, I
still stand behind my Reviewed-by.

							Thanx, Paul

> ---
>  include/linux/srcutiny.h | 13 +++++++++++++
>  include/linux/srcutree.h | 24 ++++++++++++++++++++++++
>  kernel/rcu/srcutiny.c    |  2 +-
>  kernel/rcu/srcutree.c    | 25 -------------------------
>  rust/helpers/srcu.c      |  5 +++++
>  5 files changed, 43 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> index 905b629e8fa3..fbcf13bc12d1 100644
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -154,4 +154,17 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
>  		 data_race(READ_ONCE(ssp->srcu_idx_max)));
>  }
>  
> +/**
> + * srcu_readers_active - returns true if there are readers. and false otherwise.
> + * @ssp: which srcu_struct to count active readers (holding srcu_read_lock).
> + *
> + * Note that this is not an atomic primitive, and can therefore suffer
> + * severe errors when invoked on an active srcu_struct. That said, it
> + * can be useful as an error check at cleanup time.
> + */
> +static inline bool srcu_readers_active(struct srcu_struct *ssp)
> +{
> +	return READ_ONCE(ssp->srcu_lock_nesting[0]) || READ_ONCE(ssp->srcu_lock_nesting[1]);
> +}
> +
>  #endif
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index fd1a9270cb9a..75e54e4f963f 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -374,4 +374,28 @@ static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flav
>  		__srcu_check_read_flavor(ssp, read_flavor);
>  }
>  
> +/**
> + * srcu_readers_active - returns true if there are readers. and false otherwise.
> + * @ssp: which srcu_struct to count active readers (holding srcu_read_lock).
> + *
> + * Note that this is not an atomic primitive, and can therefore suffer
> + * severe errors when invoked on an active srcu_struct. That said, it
> + * can be useful as an error check at cleanup time.
> + */
> +static inline bool srcu_readers_active(struct srcu_struct *ssp)
> +{
> +	int cpu;
> +	unsigned long sum = 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> +
> +		sum += atomic_long_read(&sdp->srcu_ctrs[0].srcu_locks);
> +		sum += atomic_long_read(&sdp->srcu_ctrs[1].srcu_locks);
> +		sum -= atomic_long_read(&sdp->srcu_ctrs[0].srcu_unlocks);
> +		sum -= atomic_long_read(&sdp->srcu_ctrs[1].srcu_unlocks);
> +	}
> +	return sum;
> +}
> +
>  #endif
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 780a95e8cad7..dde99876d473 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -85,7 +85,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct_generic);
>   */
>  void cleanup_srcu_struct(struct srcu_struct *ssp)
>  {
> -	WARN_ON(ssp->srcu_lock_nesting[0] || ssp->srcu_lock_nesting[1]);
> +	WARN_ON(srcu_readers_active(ssp));
>  	irq_work_sync(&ssp->srcu_irq_work);
>  	flush_work(&ssp->srcu_work);
>  	WARN_ON(ssp->srcu_gp_running);
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 45154630c54e..d1a69320b5c0 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -599,31 +599,6 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
>  	return srcu_readers_lock_idx(ssp, idx, did_gp, unlocks);
>  }
>  
> -/**
> - * srcu_readers_active - returns true if there are readers. and false
> - *                       otherwise
> - * @ssp: which srcu_struct to count active readers (holding srcu_read_lock).
> - *
> - * Note that this is not an atomic primitive, and can therefore suffer
> - * severe errors when invoked on an active srcu_struct.  That said, it
> - * can be useful as an error check at cleanup time.
> - */
> -static bool srcu_readers_active(struct srcu_struct *ssp)
> -{
> -	int cpu;
> -	unsigned long sum = 0;
> -
> -	for_each_possible_cpu(cpu) {
> -		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> -
> -		sum += atomic_long_read(&sdp->srcu_ctrs[0].srcu_locks);
> -		sum += atomic_long_read(&sdp->srcu_ctrs[1].srcu_locks);
> -		sum -= atomic_long_read(&sdp->srcu_ctrs[0].srcu_unlocks);
> -		sum -= atomic_long_read(&sdp->srcu_ctrs[1].srcu_unlocks);
> -	}
> -	return sum;
> -}
> -
>  /*
>   * We use an adaptive strategy for synchronize_srcu() and especially for
>   * synchronize_srcu_expedited().  We spin for a fixed time period
> diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
> index 225b3bf9334a..1a2f563640e0 100644
> --- a/rust/helpers/srcu.c
> +++ b/rust/helpers/srcu.c
> @@ -9,6 +9,11 @@ __rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_struct *ssp,
>  	return __init_srcu_struct(ssp, name, key);
>  }
>  
> +__rust_helper bool rust_helper_srcu_readers_active(struct srcu_struct *ssp)
> +{
> +	return srcu_readers_active(ssp);
> +}
> +
>  __rust_helper int rust_helper_srcu_read_lock(struct srcu_struct *ssp)
>  {
>  	return srcu_read_lock(ssp);
> -- 
> 2.51.2
> 
