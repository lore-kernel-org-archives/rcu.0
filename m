Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4229131E49;
	Mon,  5 Jan 2026 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648846; cv=none; b=eYWF3G9GbOZoW/F6nFMf5F9dyCNNuM3JOR5HNmcsGPnNX+zda61E7Kx/R8jPadCQ2UcV3N7lGIerBHYBARSSPeTRkQoRQE5wiP6KdR4XjBk9tg4y4knL6xwunkDVpYZ9Q3gzD8FmIn/1zizhbYaVWwT9LrdvRGGXKtKTQ3I7eHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648846; c=relaxed/simple;
	bh=WpB988ZXfEnPrIyGAfIoa1859xMRPptZMhpU+ljnsbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucuLIQy5OQxKbZlRRZa2OokIm7B5od2gP+5dC64mQo9Czf5EO1Tke2j6ETpuJLqvJ+TLM8ng6KiOMiif6Q1FTUyUEDXBDgVwR1XGjP7LD8bqZIsKtRScjuJD5oigNh6OZBCWfPLeg2Jlt/k4vmC5xz0c/JYf5fO9NdVqqh9BnUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg/5DtDq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg/5DtDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C990C116D0;
	Mon,  5 Jan 2026 21:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767648846;
	bh=WpB988ZXfEnPrIyGAfIoa1859xMRPptZMhpU+ljnsbc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Qg/5DtDqq1qAebNp6tCmhtczXWCUllMuzxPR3mEDmAnZi9eDiU9aiT5co645YFylO
	 nmQ+SiM20v7qk5p4c+sUyISSaxu+0kHFEvLBviKTJ9AY0n7vhJsi0xxtje9EdvbW87
	 uu8rzXfejUJ5mzJ3a4dFJCh8+Y67auP7Q9AeCcEVu6uEuCM7kT62lnIsfOO6mSrV5y
	 c6WbYTGxwdwxDCZyGmkClARtEbbv3GbHPW7+t8q60v7pu7Olih5wIXLz3vKHKMknli
	 yiZYULx82O6hE8pB7De9uVCBJyKfhuEr+Zh3mDbraQBuTEl+sXZ8kj3mS7zx9rDM51
	 uE2w6lclklEoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 37F98CE0BB3; Mon,  5 Jan 2026 13:34:06 -0800 (PST)
Date: Mon, 5 Jan 2026 13:34:06 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	boqun.feng@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu-tasks: Remove unnecessary smp_store_release() in
 cblist_init_generic()
Message-ID: <784b10f0-45c4-4038-97b1-e20cacd3709b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260105011951.72850-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105011951.72850-1-qiang.zhang@linux.dev>

On Mon, Jan 05, 2026 at 09:19:51AM +0800, Zqiang wrote:
> The cblist_init_generic() is executed during the CPU early boot
> phase due to commit:30ef09635b9e ("rcu-tasks: Initialize callback
> lists at rcu_init() time"), at this time, only one boot CPU is
> online and the irq is disabled. this commit therefore use routine
> assignment replace of smp_store_release() and WRITE_ONCE() in the
> cblist_init_generic().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Very good!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tasks.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 76f952196a29..c736900317cd 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -290,9 +290,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>  	shift = ilog2(rcu_task_cpu_ids / lim);
>  	if (((rcu_task_cpu_ids - 1) >> shift) >= lim)
>  		shift++;
> -	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
> -	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
> -	smp_store_release(&rtp->percpu_enqueue_lim, lim);
> +	rtp->percpu_enqueue_shift = shift;
> +	rtp->percpu_dequeue_lim = lim;
> +	rtp->percpu_enqueue_lim = lim;
>  
>  	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
>  			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
> -- 
> 2.48.1
> 
