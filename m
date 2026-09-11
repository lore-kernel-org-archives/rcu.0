Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1248E36196E;
	Fri, 11 Sep 2026 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146875; cv=none; b=hUyZmFhRrh62+HoOo7PcQqozlhxe1srEI9yIzkJ85IK4Z//UcCGihm87LQCRwA99Q7Vtt+OQVXd0gfz2kqju0roCArBg3ldNSuNdVi+LJ96oZRQfZpDyHyfhq3W60IiJYEO3YFkky+WUGEQAB7SKcpvDBs8saN4CHm/GEaMjcM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146875; c=relaxed/simple;
	bh=iznPGrSn1kAbtTmKN2RKw+ZgasjyIpcVrotV9gPicAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq+4ZgENXpxVIqwWxlzZ/6/THFhm238CF6hlBM7bVXnqv7S9fur0Yhks+FJsAH0N5T0xKAJh6LnySDHOV+pa1aI8In6/g6o6yftEBtneSCI3jy4zUCYTSfHgz/7df9VWgOHzu54DAWU6+RVTagSrlrmb3vV4z4cdiw1zRlKKWI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ti6lNFJX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ti6lNFJX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A701F000FF;
	Fri, 11 Sep 2026 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146873;
	bh=pZRCTefYVuYnljndnAo46+RBiYgb3mejJzuRtMHFoI8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Ti6lNFJXPIlaqEG5loznTed/DHEDzflUl3c9AJ7CrIAQSUcA9sGpQHDrpQuWtq/eo
	 DyAk1EzRXk9ilCfQidn011KnWvvQM2Fpv3XCzS2NrpFAY7oI0gx57GOo4kjbDNSXm9
	 cRCf7rZ9gHLjDGRcIYjPMGiJQ7gI0t68goDSnk6toAAo/LRBFTdCVpTbDD3LAnXHtz
	 VuNwin6QHWuSXu2ofmrKbiPJAk2Gk4I08/dS0whvBdJ8SNHKrurcCzNDVTUcUSHbT8
	 +Mf2VNEZkYKeP48/KDmN8wzIhjhslqWI2n1oZlPEi9alvWRFV96lLhLabtwM0k31nf
	 VAtjzAX7M6L2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1A7AACE1902; Fri, 11 Sep 2026 10:14:33 -0700 (PDT)
Date: Fri, 11 Sep 2026 10:14:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] srcutiny: Add lockdep and early-boot checks to
 synchronize_srcu_atomic()
Message-ID: <6ecc86ac-f763-4bde-a8af-22d97cd27a08@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911160913.2859713-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911160913.2859713-1-kunwu.chan@gmail.com>

On Sat, Sep 12, 2026 at 12:09:13AM +0800, Kunwu Chan wrote:
> Add the RCU_LOCKDEP_WARN and early-boot check that the Tree version
> gained, srcu_lock_sync() was already present.
> 
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Queued for testing and review, thank you both!

							Thanx, Paul

> ---
>  kernel/rcu/srcutiny.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 99f8bfd98b04..76411562366f 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -361,6 +361,12 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
>  
>  	srcu_lock_sync(&ssp->dep_map);
>  
> +	RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> +			 "Illegal synchronize_srcu_atomic() in same-type SRCU read-side critical section");
> +
> +	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> +		return;
> +
>  	if (IS_ENABLED(CONFIG_PREEMPTION))
>  		synchronize_rcu(); // Needed for RCU Tasks Trace to imply RCU grace period.
>  				   // And in Tiny RCU, it is near zero cost and doesn't block.
> -- 
> 2.43.0
> 
