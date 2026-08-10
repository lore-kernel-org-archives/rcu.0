Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87BC3AF66E;
	Mon, 10 Aug 2026 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370676; cv=none; b=IczjCjmpCrIHGcQtkg9dVm2w+JFxBsKSxmbdQQIfaw+C3AoY8Z5Bw711ryWGMCBMJnfoEo7CLfgFJDtEsoEuduW5TPuvpahJoUBGG0WX67zIOtaArSpw5hTArxbf9GWRo8y6OJ+Vuqb7KQVnyEt5+2KDSzrIDGkqPFAFS/H7+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370676; c=relaxed/simple;
	bh=WYrev9q0LwHPAoYIXifjstxyK084nAb2x4EPTK7PDRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnQE5uPOjE9Nwlbv4sYRGF61fE3iBeIxJrbVQ+xXtaAQOC4uQNamL0CYke01Aoe1coh4bhFprlILzsJqhu4npHVnSSD2+4aoXaHaaUEoMdTG10wKr1nJwKk8wIiWn9EIOULTGn8ohrgFjTt7RpAJtQBAFdBgofA4Fz7n5Gl1w0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Os2Q7XnV; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Os2Q7XnV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/CQULXH1ChuOEcgcuNiy27/MeYaJmRr7EaZTTR+ti2A=; b=Os2Q7XnVZEJLmEmybXN0TLYiko
	IdrAL42Jkfh3e4V8pdz7jgTtwWDR17EDEWkZHayRDQb4KdQYUggnTfPLhgESsnicA0gaQdHy8MY0w
	3nojJ6zuxu2WPBQdvTnaRBGYehrDsPJD9JkP6tlZ2YPyF61n4h80Ila6i0eue227PNc9aUwCimctG
	Y4M5wAv34dRIw5YSrnX8Nnq26zWPPy+viPyC+T7jGuvveOIpeYXmeJj1pYILJLkE3x07GdITUcECv
	BxTtksql5QokmUsMSbLzhUXDOzCX2g92DjXbY65L2XquO1KzElzEZtS76bIvQiNehpC7PsUiU007p
	4yfmhq+A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtQc8-002nsK-2g;
	Mon, 10 Aug 2026 14:04:29 +0000
Date: Mon, 10 Aug 2026 07:04:24 -0700
From: Breno Leitao <leitao@debian.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] srcu: Fix WARN_ON() for timer_delete_sync() in
 cleanup_srcu_struct()
Message-ID: <annZejMO4k33rdn9@gmail.com>
References: <20260810105522.19022-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810105522.19022-1-qiang.zhang@linux.dev>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 06:55:22PM +0800, Zqiang wrote:
> The WARN_ON() for timer_delete_sync() means that the caller forgot to
> call srcu_barrier() before cleanup. however, it still can trigger even
> when srcu_barrier() was properly called.
> 
> When a SRCU grace period ends and ss_state < SRCU_SIZE_BIG, the mask=~0
> causes delay_work timer be queued on every online CPU regardless of
> whether it's sdp->srcu_cblist has callbacks. srcu_barrier() only wait
> srcu_barrier_head's callbacks to complete, however, the srcu_barrier_head
> will not be inserted into an empty sdp->srcu_cblist. after that, when
> cleanup_srcu_struct() finds a pending delay_work timer on a CPU with no
> callbacks, triggering a false positive.
> 
> This commit therefore add rcu_segcblist_n_cbs() to WARN_ON(), make the
> warning triggers only when the timer is still pending and there are actual
> outstanding callbacks.
> 
> Fixes: 05c3e88488ed ("srcu: Queue sdp->work when the delay timer is successfully deleted")
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-by: kernel test robot <oliver.sang@intel.com> 
> Closes: https://lore.kernel.org/oe-lkp/202608060833.bce92909-lkp@intel.com/ 
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> ---
>  kernel/rcu/srcutree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 35fface51d50..090dddfc7463 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -753,8 +753,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
>  
>  		// Call srcu_barrier() before this cleanup_srcu_struct()
>  		// to avoid triggering this WARN_ON().
> -		if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
> -					rcu_cpu_beenfullyonline(sdp->cpu))
> +		if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
> +			rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
> +				rcu_cpu_beenfullyonline(sdp->cpu))

This is quite hard to read, mainly with this indentation.

You probably want to rewrite the checks , otherwise the indentation
should be something like, which is horrible (although correct?):

	if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
	            rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
	    rcu_cpu_beenfullyonline(sdp->cpu))

Would something like this work?

	if (rcu_cpu_beenfullyonline(sdp->cpu) &&
	    WARN_ON(timer_delete_sync(&sdp->delay_work) &&
	            rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
