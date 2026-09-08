Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963AB52379E;
	Tue,  8 Sep 2026 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911021; cv=none; b=NTiyzGqRk2ytQsgS/NutXAFLvqJO8ChPn889b+mBn09zyU0lPofflQ0wR3YWA2YwVnbJreOs0ykT0U8IpmXknEQd521Jy935hl87INIOxlyNbAgT19xv2O9XyuH7rQzsRaHuyjMmJ1E0k7ci0zMAJTOblHLG6tBMmR1lHnnFtsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911021; c=relaxed/simple;
	bh=H999UKy2iuT6K8CgwNJcVisePbX+7Xem5RN2cVdD5c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkRwFRF82qLp3CHkvaPXfUBq+i9ngpLhlZ0H9tFmjgW//IcHP6FHVw+jSwwV2t56gcUGpf6zLu6KYmpHbu4YTeFNMsBDdG+/Mc2i5HfutRySrVl+f2+qjZ94lQg6m3PBpQBEHMVPxfrkYjF03tb+c9ViyJKfm9xntTvyqxBXObc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOv/YVHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOv/YVHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC071F00A3A;
	Tue,  8 Sep 2026 23:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788911020;
	bh=bTC3iSyF2tfahKD69KVMM+MNNO/UKZifg5yuXtJejmQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=mOv/YVHWssv7SlL3NRs15iDfBMqWENVXstipSTuZfYniXrL8HTO9PbjdMc6mcshS4
	 Kb0f0FM7iIJuNo7b0qRcFjwU2omEvbEQm31WvVuATYPn56wpw8x8S7ton2SWe7Qx7u
	 Qbc2lMZbekgGa7Ln4sUF8e0IT7F/KNPDEj09qgr7KK+212lTlfQ7tne93ejOyGHE2u
	 ErC8Z5cs3BiklJ7A/Y6VlK5M+gxe9zG1KcpUyV9gG7VfmNvVFok6u0Rq1clch8q6L9
	 xgAARo14RWPJJydxz33ciPMxHkIIiLflzCrx0Hr6fu3/48shqJ3T6ztJEnX61iREVf
	 52aROnR7I+bqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 032B1CE18F4; Tue,  8 Sep 2026 16:43:40 -0700 (PDT)
Date: Tue, 8 Sep 2026 16:43:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] srcutree: Forbid srcu_expedite_current() on atomic
 SRCU
Message-ID: <b292e178-0158-41df-881d-d02b0f393c6c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-9-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907075829.2073224-9-kunwu.chan@linux.dev>

On Mon, Sep 07, 2026 at 03:58:24PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> srcu_expedite_current() has no early guard for atomic SRCU, so calling
> it on an atomic srcu_struct leaks the expediting callback in
> __call_srcu(), leaving ->srcu_ec_state stuck at SRCU_EC_PENDING.
> 
> Add the same WARN_ON_ONCE()-guarded early return used by the other
> forbidden APIs, and list srcu_expedite_current() and srcu_barrier() in
> synchronize_srcu_atomic()'s documentation.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Excellent catch, thank you very much!!!  I have queued this to be folded
into the original with attribution, all in the name of bisectability.

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 74acd5645d4c..2d2a12f86115 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1972,6 +1972,9 @@ static void srcu_expedite_current_cb(struct rcu_head *rhp)
>   * no current grace period, one might be created.  If the current grace
>   * period is currently sleeping, that sleep will complete before expediting
>   * will take effect.
> + *
> + * This function must not be invoked on srcu_struct structures that are
> + * used with srcu_read_lock_atomic() and synchronize_srcu_atomic().
>   */
>  void srcu_expedite_current(struct srcu_struct *ssp)
>  {
> @@ -1979,6 +1982,9 @@ void srcu_expedite_current(struct srcu_struct *ssp)
>  	bool needcb = false;
>  	struct srcu_data *sdp;
>  
> +	// Atomic SRCU has no callbacks, so there is nothing to expedite.
> +	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
> +		return;
>  	migrate_disable();
>  	sdp = this_cpu_ptr(ssp->sda);
>  	raw_spin_lock_irqsave_sdp_contention(sdp, &flags);
> @@ -2104,8 +2110,9 @@ static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
>   *
>   * If synchronize_srcu_atomic() is invoked on a given srcu_struct
>   * structure, then none of call_srcu(), synchronize_srcu(),
> - * synchronize_srcu_expedited(), or start_poll_synchronize_srcu() may be
> - * invoked on that same structure.
> + * synchronize_srcu_expedited(), start_poll_synchronize_srcu(),
> + * srcu_barrier(), or srcu_expedite_current() may be invoked on that
> + * same structure.
>   *
>   * Because synchronize_srcu_atomic() is even more expedited than is
>   * synchronize_srcu_expedited(), there is no expedited counterpart to
> -- 
> 2.43.0
> 
