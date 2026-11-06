Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964781;
	b=bprFNH+0qpfQpmQDHwdfi8XuzUewbNhj9QPz4g3Sejol8cE9GOqifFT/uRQBtYdJHh2E
	 Sr8qidqLIfVz5N4lMgh5qJdSLkAv1eulpQkgl3Q7joukDGRRLFyE8Kh09JtGnWKhxJNiq
	 rDuKl0HOGT4f1XvfJvunm7ZKYYwvNRQr1w/8ON9ldicHXgnyzZi1u5lLb2FnZL809Y4IG
	 pHve5sGjgQjtD7MKXDKHlXmN0H2KMw6Yuo61uHmJOnOu3mIOtHfu0HUvCcqhZHwCl3feg
	 jLxe36vVf+XgMDlyDgqQbhXfni5y6asPq/AtkLlnE8Ee7sAeJ5WjaJDvRKaR9X1tZ3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964781;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3jUYdZrEkjrMq6IR/U7hgRh3o6mcETEnWphbPhg2wWw=;
	b=hAFGVx0v74bVVpUh9XouBAvSZaLA86tx67kMZGxUaQlsjBuciOk2CoJTMuszOoJjBd9B
	 bTIB2CrMsvnXJr1dvigB1i3kAHEOPbvS9gB2X84yCEjp5QY+W5iXnPs5y9lMFJMOYFGwu
	 BdZ5zIC9RUVukiuINOXtX3Bi6HIeGskrDkJP9eilVlH4wc6J6ZfvNpYIaAgBf0rbJyoJF
	 lVI/7RHARkKr3pZYMvyPr3LDPjxtfWjX98XyN7+h7RxDa2Q83cX/Baz39glQHjMHU7eNO
	 J5QVDHbfY3g/k6LhyPCXWv2Bm7KeVpR+vMC3hWbxAqM2mLpPFf6dzixN+j2Ag0Xti4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="uAh/rscF";
	arc=none smtp.remote-ip=91.218.175.98
Received: from mta0.migadu.com (out-98.mta0.migadu.com [91.218.175.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDD60A381C
	for <rcu@vger.kernel.org>; Fri,  6 Nov 2026 11:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4FDD60A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uAh/rscF
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GwHFqDFLj3G24ers9Fd8pFCaPPZSSUfX8U/u7WtHQmU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793964777; v=1; x=1794569577;
 b=uAh/rscFFhisTP9HlCD+0tRO3XPNijIP1QIJyTobv41JPTXex2txhnpl+ZlpimVsYDYKxdXN
 voPEar/jSKh1FzcAeEuj5wI0iO0dhKXcLdf50PvBF0cK5iiZK5p687OKWC7+KjM3huIk1FzqP20
 T+Nza2yU3qzTDtntrmYfmVD0=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 33a186fbf79cc617;
	Fri, 06 Nov 2026 11:32:57 +0000
X-Mizu-Trace-ID: 33a186fbf79cc617
X-Migadu-Flow: FLOW_OUT
Date: Fri, 6 Nov 2026 19:32:46 +0800
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry@kernel.org>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, vbabka@kernel.org, 
	urezki@gmail.com, paulmck@kernel.org, qiang.zhang@linux.dev, 
	akpm@linux-foundation.org, cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH 2/2] mm/slab: don't queue the page cache work under
 krcp->lock
Message-ID: <au24uW1sxT2Kb_Qb@fedora>
References: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
 <20261028134647.3176080-2-zhanxusheng1024@gmail.com>
 <auifTNDwbBTJeu81@thinkstation>
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
In-Reply-To: <auifTNDwbBTJeu81@thinkstation>

On Mon, Nov 02, 2026 at 02:35:40PM +0000, Harry Yoo wrote:
> Here I added bit more context and adjusted comment. End result:
> 
> mm/slab: don't queue the page cache work under krcp->lock
> 
> Commit 56292e8609e3 ("rcu/tree: Defer kvfree_rcu() allocation to a
> clean context") deferred page allocations to a workqueue. To avoid
> deadlocks with the scheduler, it used hrtimer to queue the work instead
> of queueing it directly.
> 
> Commit d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory
> pressure") later added a backoff mechanism under memory pressure, but
> did not consider that queue_delayed_work() with delay = 0 immediately
> queues the work and introduced the deadlock commit 56292e8609e3 tried to
> avoid.
> 
> run_page_cache_worker() runs under krcp->lock, from kvfree_call_rcu()
> callers that may hold more, such as set_cpus_allowed_force() under
> pi_lock, so it kicks the refill work from an hrtimer. Under memory
> pressure it instead queues the work with a delay of
> rcutree.rcu_delay_page_cache_fill_msec, which may be 0, and a zero delay
> queues it at once, taking pool->lock under krcp->lock.
> 
> With the delay set to 0, calling kvfree_rcu() on vmalloc memory under
> pi_lock after a drop_caches makes lockdep report:
> 
>   Chain exists of:
>     &pool->lock --> &p->pi_lock --> krc.lock
> 
> Use the hrtimer when the delay is 0.
> 
> Fixes: d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory pressure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> Link: https://patch.msgid.link/20261028134647.3176080-2-zhanxusheng1024@gmail.com
> [ harry@kernel.org: add more context to changelog and adjust comment ]
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
> ---
>  mm/slab_common.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 41dea01a8c1f..051ca63c0b67 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1987,7 +1987,15 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>  			!atomic_xchg(&krcp->work_in_progress, 1)) {
> -		if (atomic_read(&krcp->backoff_page_cache_fill)) {
> +		/*
> +		 * Use the hrtimer to avoid a deadlock with the scheduler
> +		 * by waking up the worker directly. queue_delayed_work()
> +		 * uses a timer to queue the work, so it's fine.
> +		 * But with delay = 0 it queues the work immediately.
> +		 * Fall back to the hrtimer in that case.
> +		 */
> +		if (atomic_read(&krcp->backoff_page_cache_fill) &&
> +		    rcu_delay_page_cache_fill_msec) {
>  			queue_delayed_work(rcu_reclaim_wq,
>  				&krcp->page_cache_work,
>  					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
> -- 
> 2.54.0

Just a thought: once this fix is applied, could we simplify the code further by
always queuing the work via hrtimer? This would make the logic more
understandable. For example:

diff --git a/mm/slab_common.c b/mm/slab_common.c
index ef5ff0a20249..e5213f952e16 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1480,7 +1480,7 @@ struct kfree_rcu_cpu {
 	struct delayed_work monitor_work;
 	bool initialized;
 
-	struct delayed_work page_cache_work;
+	struct work_struct page_cache_work;
 	atomic_t backoff_page_cache_fill;
 	atomic_t work_in_progress;
 	struct hrtimer hrtimer;
@@ -1878,7 +1878,7 @@ static void fill_page_cache_func(struct work_struct *work)
 	struct kvfree_rcu_bulk_data *bnode;
 	struct kfree_rcu_cpu *krcp =
 		container_of(work, struct kfree_rcu_cpu,
-			page_cache_work.work);
+			page_cache_work);
 	unsigned long flags;
 	int nr_pages;
 	bool pushed;
@@ -1974,34 +1974,27 @@ schedule_page_work_fn(struct hrtimer *t)
 	struct kfree_rcu_cpu *krcp =
 		container_of(t, struct kfree_rcu_cpu, hrtimer);
 
-	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
+	queue_work(system_highpri_wq, &krcp->page_cache_work);
 	return HRTIMER_NORESTART;
 }
 
 static void
 run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 {
+	ktime_t delay = 0;
+
 	// If cache disabled, bail out.
 	if (!rcu_min_cached_objs)
 		return;
 
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
-		/*
-		 * A zero delay would queue the work right here, under
-		 * krcp->lock and possibly the caller's pi_lock, so let the
-		 * hrtimer do it.
-		 */
-		if (atomic_read(&krcp->backoff_page_cache_fill) &&
-		    rcu_delay_page_cache_fill_msec) {
-			queue_delayed_work(rcu_reclaim_wq,
-				&krcp->page_cache_work,
-					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
-		} else {
-			hrtimer_setup(&krcp->hrtimer, schedule_page_work_fn, CLOCK_MONOTONIC,
-				      HRTIMER_MODE_REL);
-			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
-		}
+		if (atomic_read(&krcp->backoff_page_cache_fill))
+			delay = ms_to_ktime(rcu_delay_page_cache_fill_msec);
+
+		hrtimer_setup(&krcp->hrtimer, schedule_page_work_fn, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
+		hrtimer_start(&krcp->hrtimer, delay, HRTIMER_MODE_REL);
 	}
 }
 
@@ -2295,7 +2288,7 @@ void __init kvfree_rcu_init(void)
 			INIT_LIST_HEAD(&krcp->bulk_head[i]);
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
+		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 
