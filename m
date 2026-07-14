Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF9A427FB4;
	Tue, 14 Jul 2026 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784060478; cv=none; b=UoGJwD4T7cgZ4U8MGHlwojPLN2TSuHQw0H9nK80c4/fDWdPcApO50UKts3L8N35kMZsBuepVEBfdPugkkF3tBJdc0BMeH/ts7ZE0CG5EljE9D+zrTEHb3Pgg+FgjOG9/9gjw5bpsl7BL7gpVz3XHMLODPSE+JcTigqzU/f2cGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784060478; c=relaxed/simple;
	bh=SNlerg+/0Dfsin6sgFH5COsXxOsgJfaslhh85xpmTBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtkTfS+QaDnhiB/uJqfJDkcP3Ero0Dsk31TYLD5oD+al5eqEs7yqvxQ2o9ZDUhKuFg7EkDN25l8fHln8ZH5njgMEzosa23lSKKRM/Bi8+28uEXIf8iCRJbBq3FROh3BkgcDXUw2UnvrWMZgYIR4gtBVlEP/y1Vh4sqgQqqmPHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrTn3ss9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrTn3ss9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF1C1F000E9;
	Tue, 14 Jul 2026 20:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784060476;
	bh=eMa/m4mj6zSiupzasWH9dMYr9Jjuqo/SOiRdqWq4i+U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=NrTn3ss9konjV9CaXUPjGSpJ+XyxJTkeOxvbucBgMoBfYLoLnEC9/nxatKAZrrT6Y
	 p7vr3SY/rWHVBt7IRrjKUrfAYrVlHk+1NG/CrsaNrhT6ZqYvwLwq9chJdd+swqOoe7
	 JAWQRo796pGT4aEA2W6hnRsSO3z8/FsJvvxml+LyGdO41/35y2R/Slar6HoclnbK7H
	 5snaQ2XU7Z8CDfvV8hQ9z5v0BuGLmRiTqcFfhYU7sYl1+TS8GsLv7rDKKtXdKtyOzU
	 sH/AKmD+GeoMVUlZzrnq5MMZvhf/nfF/nomhJ3QVAWEGdh/tZ3ccHFfKmm8y19k0z1
	 DzsfAVlA/BrbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9EE6FCE054B; Tue, 14 Jul 2026 13:21:16 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:21:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Update comments in call_rcu_tasks_generic()
Message-ID: <4f9b2c64-3d9d-4b39-af13-9ac726e21660@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260713103126.29782-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713103126.29782-1-qiang.zhang@linux.dev>

On Mon, Jul 13, 2026 at 06:31:26PM +0800, Zqiang wrote:
> Currently, the comments: "We can't create the thread unless interrupts
> are enabled." from 'commit 4929c913bda5 ("rcu: Make call_rcu_tasks()
> tolerate first call with irqs disabled")', now the kthread creation
> has been move to core_initcall() time from 'commit c63eb17ff06d
> ("rcu: Create call_rcu_tasks() kthread at boot time")', and use the
> irq_work does deferred wakeup. this commit therefore update comments
> in call_rcu_tasks_generic().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Queued and pushed both, thank you!  I adjusted the comment and commit log,
so please double-check them in case I messed something up.

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index a2ca79d1dd6a..089a0d5a5cc9 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -395,7 +395,11 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
>  	}
>  	rcu_read_unlock();
> -	/* We can't create the thread unless interrupts are enabled. */
> +	// We can't create the kthread with interrupts disabled,
> +	// or a spinlock might be held, the kthread creation has
> +	// been move to core_initcall() time.
> +	// at the same time, use the irq_work does deferred wakeup
> +	// to avoid potential lockdep splat.
>  	if (needwake && READ_ONCE(rtp->kthread_ptr))
>  		irq_work_queue(&rtpcp->rtp_irq_work);
>  }
> -- 
> 2.17.1
> 
