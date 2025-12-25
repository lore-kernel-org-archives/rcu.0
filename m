Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486872417C2;
	Thu, 25 Dec 2025 18:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766689076; cv=none; b=t8S5SNtfewZupNbPIsqOE2sGWVsuu9W0BOiQHOnmAn5VPEL/EkQjmRJsrKIxtZWUIfpkBclGFP8jc9BRt1Xs+3+9FrehYDDe9OCbCHiZp59ss0RudNMfWJCKOrn3iV1fZt7LasMQKqTIzIfKN8IDOJSq2IRt7RZL7V7dFz1zUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766689076; c=relaxed/simple;
	bh=HiNSBchRdB4wQM3PDRqJnnrN23fjPx9zrCRsl0su7ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLzAWpMWJC4c12EBzzoTuInRxsMeRRMrJLIyrpANPhvNb8Pa280FgBbnt/cmcJj3x16OTrcOWaFdcFE5F5e1KJ3MvtMJNJ0r6JFlAIhrx72BGXmisL9n1r0ALfLPgGrmL7xMoDUIZz/1JGOSrdjJglydqumAeavTOIgODgkwfbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGJ4iZyD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGJ4iZyD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED5DC4CEF1;
	Thu, 25 Dec 2025 18:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766689075;
	bh=HiNSBchRdB4wQM3PDRqJnnrN23fjPx9zrCRsl0su7ec=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FGJ4iZyDGP6a04h6Rg863J/9+xdwe22+GZ6cEm4c7Z92PrSbhnp0tXGxfLoIKPogV
	 R+QQt6809u1MSrVkT4lffqOd4I0pS05Ep91uwNoyDi1uZb5A+ayxiVzfuRQPSYCzjP
	 loiW4IEGNIHs8/gMQ9GHYVWdYjbvCsv3Rddj996vUkDGPzMrD/DsvSC8qheS6EO+Vr
	 3qBWfegWHXjw8V5qDTwdo0soUIqgyhsFzA9QkcXtOL6WzMoac/qF25s7jFyJmwUQxN
	 sVlGUo+ilGTS6arF4GIrORg//Mwdl49RfAASjRpSS3SW5Ge+bEsB4F2J65e5nHUHFq
	 mdNPITqKD4PMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3B41FCE0D19; Thu, 25 Dec 2025 10:57:55 -0800 (PST)
Date: Thu, 25 Dec 2025 10:57:55 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Remove unnecessary smp_store operations in
 the cblist_init_generic()
Message-ID: <b8cae37a-65c9-4380-9290-8494c854373e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251214024904.121128-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214024904.121128-1-qiang.zhang@linux.dev>

On Sun, Dec 14, 2025 at 10:49:04AM +0800, Zqiang wrote:
> The cblist_init_generic() is executed during the CPU early boot
> phase due to commit:30ef09635b9e ("rcu-tasks: Initialize callback
> lists at rcu_init() time"), at this time, only one boot CPU is
> online. this commit therefore use WRITE_ONCE() to replace the
> smp_store_release() to assigning rtp->percpu_enqueue_lim in the
> cblist_init_generic().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Good eyes, thank you!

But in that case, we are running on a single CPU with interrupts disables,
so do we even need WRITE_ONCE()?

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 76f952196a29..f763f60d5e50 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -292,7 +292,7 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>  		shift++;
>  	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
>  	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
> -	smp_store_release(&rtp->percpu_enqueue_lim, lim);
> +	WRITE_ONCE(rtp->percpu_enqueue_lim, lim);
>  
>  	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
>  			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
> -- 
> 2.48.1
> 
