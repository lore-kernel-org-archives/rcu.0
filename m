Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840132F84F;
	Wed,  9 Sep 2026 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912321; cv=none; b=isGRsGkt8OT6y3s840gLc1hVGScaaDC6K2x5aLD+6IG7JUBMKHo6LwYGue8BXWkR2Kl6lwThyxDLnb/HLX2EPSpKlSygFH5sjA9165E8wG5MwAwZLTozFOJ/jDO12m2Sj1lAiu4TRdKD9ZsP9DuyAz/mEUWJpMzyigfF0ZWIA7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912321; c=relaxed/simple;
	bh=3B+4k41zxzptlySDkpPnilKy0f4ATQLmUkZ24G6ghWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrDRlbYrqw+bWVQhTfYnr/1pMFX8I5DAegYJ3LUHta5XYc/QYKW8cw2jfz4+7aLaCnw7+UJmsDALPq1YpA6ZHVh98mOM/i8IMqK0nCzzu16Hdy43oqSZCVYsHOhqG0deR8kqz0yoi9ziwjuk0OMAqTDkE7epW35mtmAOUrtxdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICNv2xx8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICNv2xx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CCD1F00A3A;
	Wed,  9 Sep 2026 00:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788912319;
	bh=H4u424Q7+T+AtSR+8IxmCN/x7kq8QpF1E2bKYJ1L4Cw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ICNv2xx8ZNR2Ng6kD5pHhsDw0NGQG6ddxB9B7+tUHvVXDxcXQhH7GgtkazKDqNWlQ
	 P5RXw8AV1ShGIrcKXMKcSkg/wfKuNUPfIXatDF83m8gFYL6Pq9xUrv2CXHbkUBzxDi
	 yDkqKtDrcaWkBYweQG/DGxF2ULrMUKSJoXv02mSDfzeXvDBOho+iGsyBW1Uvzsb+o3
	 XmDNMZ0kOpJwM2WxhJ46denKrV4y8apWnyRi2YzIz5c31QM0mB+I1EZ4pPpHZVf41L
	 37OllZyLVby+le9pDxJ0d5+fR+R+334YR7BqhALlEjDtRxW2eiczThXtCxH1rLcsBo
	 uliwt4Iwl7A2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8C389CE18F4; Tue,  8 Sep 2026 17:05:19 -0700 (PDT)
Date: Tue, 8 Sep 2026 17:05:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] srcutree: Remove srcu_barrier() sleep for atomic
 SRCU
Message-ID: <8f355841-9a5c-43b0-8fad-e58a0f081fd3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-12-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907075829.2073224-12-kunwu.chan@linux.dev>

On Mon, Sep 07, 2026 at 03:58:27PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> The atomic-SRCU path in srcu_barrier() sleeps for 100 milliseconds just
> in case there are callbacks to wait for.  But call_srcu() refuses
> atomic SRCU with a WARN_ON_ONCE() before reaching the deferred-enqueue
> path, so there can be no callbacks, deferred or otherwise.
> 
> Drop the sleep.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Good catch!  As you say, now that call_srcu() leaks callbacks that are
for atomic srcu_struct structures, there really cannot be any callbacks.
Queued for further review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index c19f59725706..a93bf803e2f7 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1895,12 +1895,9 @@ void srcu_barrier(struct srcu_struct *ssp)
>  	unsigned long s;
>  
>  	check_init_srcu_struct(ssp, false);
> -	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC)) {
> -		// There shouldn't be any callbacks for atomic SRCU,
> -		// but just in case.
> -		schedule_timeout_uninterruptible(HZ/10);
> +	// Atomic SRCU has no callbacks, so there is nothing to wait on.
> +	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
>  		return;
> -	}
>  
>  	/*
>  	 * Register any deferred callbacks before snapshotting the sequence.  The
> -- 
> 2.43.0
> 
