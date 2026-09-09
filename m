Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306B1643B;
	Wed,  9 Sep 2026 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912079; cv=none; b=FrBlHiqwVYX6eop/MCTU2Eeg8V/ktvbU860bgvoN2vc8ZB9vTYitR2AEkJXHdKClYo3fbO2rUrfBYvO1mfhHsJlmYbVMWPUAKc0JLh2K2on4S+MZ1SVoOmZXAqwDtO+3pjGV4gxJOwSED82ADiD9QjL12XAspdSvE93DlLmOVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912079; c=relaxed/simple;
	bh=TC+AdfY5wfm6r30Pha+XuqlDXv5g8AbcqPX5qnkRyKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4iesxX9t7TNYKn1ImN2wrmjieE9+X1XozykikMRxWe1nSYCW0P/49oanxNNtTRb4vMDG5NoclJ7sSSIJPAnrriqOBfLT0gRGSMN71jO6O6xPkVN/kfnW5NXpdDP5FUVwqDuc/+sJvdLu8jaA6pnk+AbFeZCQBDl/R6oM//eWfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Io+uKMUS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Io+uKMUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536161F00A3A;
	Wed,  9 Sep 2026 00:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788912078;
	bh=0UTzGNUczp4DjsKEH5ve8IeesYqL56R6Vh31ixYFRRo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Io+uKMUSGTY0up/vQAofqyDHn97v9QnMf7Xg0Ira8cjPiE8dH3uhQdluwegTThNCv
	 KHx0draH0CbqH7Vy8EXdwXEwFZmk2tv05Hy7oIboD9Ojz9J3r50tKZlEiWDZQBWCdZ
	 qWlztS5t3nj5M9OSCMZLS1ka7ONSbAcqz8WMhMLO+mEM17rvZo7nv/dv7ZPF5s5X42
	 kgxrNU/MhxWLN0MpwsSh+lqKQvOzyUq6TtkWFR3+QmUlUHWM2yD2sTByHuJgtqeoA8
	 1rtUUagdcIL0uboclLguEtMwbZnI679Tm31kTJAH5QUmyCnqBzNACznuSiqjTVXsN1
	 JllNwkc91HXXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 18585CE18F4; Tue,  8 Sep 2026 17:01:18 -0700 (PDT)
Date: Tue, 8 Sep 2026 17:01:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] srcutree: Skip callback scheduling for atomic SRCU
 grace periods
Message-ID: <ec409022-0e89-477c-a900-537e7cb7285a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-11-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907075829.2073224-11-kunwu.chan@linux.dev>

On Mon, Sep 07, 2026 at 03:58:26PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> call_srcu() is forbidden on atomic srcu_struct, so srcu_gp_end() never
> has callbacks to invoke for them.  Yet it schedules callback invocation,
> which for atomic SRCU's SRCU_SIZE_SMALL state arms the boot CPU's
> ->delay_work timer every grace period, only for srcu_invoke_callbacks()
> to find nothing to do.
> 
> Skip this for atomic SRCU.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Nice optimization, thank you!  This does not matter for correctness,
and thus does not affect bisectability, so I have queued it as is for
testing and further review.

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 2d2a12f86115..c19f59725706 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1018,10 +1018,10 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
>  
>  	/* Initiate callback invocation as needed. */
>  	ss_state = smp_load_acquire(&sup->srcu_size_state);
> -	if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
> +	if (!is_atomic && ss_state < SRCU_SIZE_WAIT_BARRIER) {
>  		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, get_boot_cpu_id()),
>  					cbdelay);
> -	} else {
> +	} else if (!is_atomic) {
>  		idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
>  		srcu_for_each_node_breadth_first(ssp, snp) {
>  			raw_spin_lock_irq_rcu_node(snp);
> -- 
> 2.43.0
> 
