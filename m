Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967691;
	b=r/vtSutJvzArlG+53h420b8RvqtIwHpjbaCoEeU9lav7ZaQp5UFSfxrePj0Gzjb+JgF7
	 QSthgdeDwGa2eMF2n40nPwEiNuueWd13AtWa2oxiDvKQB07oRbjiM6WqXq26a/cmvtvnS
	 EVB4t2hGPvdZZ08cXIsYBalY44OGXwkZCM3Yj8htF33XYNiP1T3b2nV3hWJRMoELRHNhU
	 A6/ew3Sjrv4febOqlrJ7y2z60G1Yp7TnI3md0Lrji98ceE5vp6OZDR79OpMdpGJeBF//A
	 eDozJYMV74cPLExhTFKuBrOc0q4htVHE/IrG9IruC0pQsJT8UENQOM+FGOC4GTLGR+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967691;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cRzTH+yd4d8od9LM7sI2UHx2nrHb7DkZirOlIhvtcmU=;
	b=cOGRsYFWj5AkxbiNgGVq+ofijt2Pcmc7lDWFkc3zZlXR2tQ65PQIWzFVJvKVgEBviajJ
	 cjt+aT0ImWznCMEyoMWATUdtbAFawF0hwuIqMoVFjHhxvhiGOEW0+UrD9gXC2yk44SUys
	 HeUYkAt61RhkBckdRjskw5xNorCau8n9goswhkWGbqoe6JkpkSJjGZ6ME4RLY45cvP93X
	 Pa2jNAbVV6HSZPbGQDnb+PuAVV2QBMI7AnN9Ohk5fGKQ+6ZXWMsoI7Wwe/OB78lKttVey
	 9FIFmvZpvOnqDRPRxJa9azRaEqJHIbzFg5V7xMbYkueHWTtGQGCyjZl05V1b/2LAf2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZILsJYw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B4B606A326;
	Fri,  6 Nov 2026 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZILsJYw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F25F1F0089F;
	Fri,  6 Nov 2026 12:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793967691;
	bh=cRzTH+yd4d8od9LM7sI2UHx2nrHb7DkZirOlIhvtcmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GZILsJYwu5BayQcmz0opObBE0Ra84AH2emZVoDsYwET5lsnXq/90QfHCKSiuVcyng
	 QK6GS6TxvENK+/sND0HJk/pISIlyglRaJyq+yYhObAQDtBYNHdEpVa63IlVAN5jN2n
	 Bl71ZLc1hzVRPjVqVBic13CoXv5zTenBbEqK2e4ETjWnl2nEyM+OP3mMgP/jgfMMhI
	 gkeW+EK9keSGXtJBvkIbdh35aMPfca1IHC/jAU7w9xnDnPoyviV3mUPcSBB7hkElxv
	 wte2pRHKe9ddWnUtU/1XJDkCxQk3YddRhQ4Og723Jd8cfqg3VuPHeQIezaf2h/RZEN
	 Fe1/F8bvxLhzA==
Date: Fri, 6 Nov 2026 12:21:28 +0000
From: Harry Yoo <harry@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, vbabka@kernel.org, 
	paulmck@kernel.org, qiang.zhang@linux.dev, akpm@linux-foundation.org, 
	hao.li@linux.dev, cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH 2/2] mm/slab: don't queue the page cache work under
 krcp->lock
Message-ID: <au3ELzm_s9vhs7UO@thinkstation>
References: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
 <20261028134647.3176080-2-zhanxusheng1024@gmail.com>
 <au2fUYzBLv3uvj_2@milan>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au2fUYzBLv3uvj_2@milan>

On Fri, Nov 06, 2026 at 10:35:13AM +0100, Uladzislau Rezki wrote:
> On Wed, Oct 28, 2026 at 09:46:47PM +0800, Zhan Xusheng wrote:
> > From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> > 
> > run_page_cache_worker() runs under krcp->lock, from kvfree_call_rcu()
> > callers that may hold more, such as set_cpus_allowed_force() under
> > pi_lock, so it kicks the refill work from an hrtimer.  Under memory
> > pressure it instead queues the work with a delay of
> > rcutree.rcu_delay_page_cache_fill_msec, which may be 0, and a zero delay
> > queues it at once, taking pool->lock under krcp->lock.
> > 
> > With the delay set to 0, calling kvfree_rcu() on vmalloc memory under
> > pi_lock after a drop_caches makes lockdep report:
> > 
> >   Chain exists of:
> >     &pool->lock --> &p->pi_lock --> krc.lock
> > 
> > Use the hrtimer when the delay is 0.
> > 
> > Fixes: d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory pressure")
> > Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> > ---
> >  mm/slab_common.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 3729aa7a6156..ef5ff0a20249 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1987,7 +1987,13 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> >  
> >  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> >  			!atomic_xchg(&krcp->work_in_progress, 1)) {
> > -		if (atomic_read(&krcp->backoff_page_cache_fill)) {
> > +		/*
> > +		 * A zero delay would queue the work right here, under
> > +		 * krcp->lock and possibly the caller's pi_lock, so let the
> > +		 * hrtimer do it.
> > +		 */
> > +		if (atomic_read(&krcp->backoff_page_cache_fill) &&
> > +		    rcu_delay_page_cache_fill_msec) {
> >  			queue_delayed_work(rcu_reclaim_wq,
> >  				&krcp->page_cache_work,
> >  					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
> > -- 
> > 2.43.0
> > 
> > 
> Can we just clamp this to 1 - 100 seconds interval?

You mean clamp to [1:100,000] milliseconds interval?

> <snip>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 7223a7596dab..2c9236236ac9 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -2249,12 +2249,12 @@ void __init kvfree_rcu_init(void)
>  			WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
>  	WARN_ON(!rcu_reclaim_wq);
>  
> -	/* Clamp it to [0:100] seconds interval. */
> -	if (rcu_delay_page_cache_fill_msec < 0 ||
> +	/* Clamp it to [1:100] seconds interval. */
> +	if (rcu_delay_page_cache_fill_msec <= 0 ||
>  		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
>  
>  		rcu_delay_page_cache_fill_msec =
> -			clamp(rcu_delay_page_cache_fill_msec, 0,
> +			clamp(rcu_delay_page_cache_fill_msec, 1,
>  				(int) (100 * MSEC_PER_SEC));
>  
>  		pr_info("Adjusting rcutree.rcu_delay_page_cache_fill_msec to %d ms.\n",
> <snip>
> 
> so we forbid zero as value to use?

IMO in general we should keep existing behaviour unless we could
demonstrate setting a delay < 1ms is fundamentally flawed?

-- 
Cheers,
Harry / Hyeonggon
