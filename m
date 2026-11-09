Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230029;
	b=mGsBYLIVZBaocntU8qgHz1hGq9LaKpb+V+NdOHb1Y+QICFkFaJE+klHvDq+KRDu8+e0j
	 bWC4gtsHDi8dgOnT8KsUzdhO/+U8BNCTTn+QJICiPJcAsmTUL7NRsd0TRV4MZrUXrh5nM
	 AO920ze5Eq1GzSUVUy7b/UhRpovHfd+FAFJvIZELHJwLMqPOMqOgSaU0H17yU4aDAGFNy
	 ujTfcXZZb2ib4JhuNOs2OvtWrKJOU/ncDFzJLRJxMrq8bmBoTivVxd2/pFBvsgd6e+NRR
	 Zn0YEgAs8QKwuL/pPS9ZOge20o8IMaaKQY/umsx/GVxfOcFl9+b5H8HPzqtpw52ZeJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230029;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7jQJsS30mfWqnutp4T/axVYFvwalLvCNK3lARAafv5M=;
	b=Dam6Cr0Ytr13+vc2bMR54aoyBmxTPzbIIdRFoXm3zFQXRL82FUTn/xjhvDR0es66vLT0
	 bxTHCMKG9fJ+ouYSUFA+nAzb2AXXvDxOMII+2vQUUqysu/NdII1/XCjtekJxFeTmFbELW
	 HcHKNHqgSj1MJe/JORz1uBFSNPeA+JGrQU3Mofl5fPU+w6W7NHwMVZdyx0hihL9Pvzol+
	 hfAYNAObRuD+6plJS08ACgdqHY/W7uP4ooPj/JqxtBCoF+h7EYy819tzc2kzycZGzyrcA
	 YaZ4BOsh0buJkx8nOkjkDb7QgWsQd+ymcUruLq10jd/lSZXYhkluJR42jXquAJ0WEuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfJm8OHh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE61606A321;
	Mon,  9 Nov 2026 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfJm8OHh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3091F0089F;
	Mon,  9 Nov 2026 13:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230029;
	bh=7jQJsS30mfWqnutp4T/axVYFvwalLvCNK3lARAafv5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nfJm8OHhyNANdak70pijBgAfPa88EnbFGsqwMrmWGsIIpiZ9oe1IOmuKMfkZFtHIY
	 l+EmlByl7y51Sjmkwawrghx/6hUDawrTZFLoQlCNN0lJU1ULlDME2LDFmpn+aBvtfG
	 Mhi3qqSbWZXaybzsgN3VrlHVk6NeaEAfVxWXc0LRpcfE+77roaidWe151Bc1UoYOpp
	 yJQjnoTQeWNQetvIJKRQvREGjwuYukX0EL8jxW9WdsuJGpMtyNnaV4643eo8tgitM2
	 Tb4ftJXCww3eNUNKUyoh6Yt1ieWGe6+17QiBr8kpNPFnGOUg4x+BsX7p40GVd1EWk7
	 kFZ4s4lbqwHtw==
Date: Mon, 9 Nov 2026 13:13:46 +0000
From: Harry Yoo <harry@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, vbabka@kernel.org, 
	paulmck@kernel.org, qiang.zhang@linux.dev, akpm@linux-foundation.org, 
	hao.li@linux.dev, cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH 2/2] mm/slab: don't queue the page cache work under
 krcp->lock
Message-ID: <avG1Yr9sjswFoJ9E@thinkstation>
References: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
 <20261028134647.3176080-2-zhanxusheng1024@gmail.com>
 <au2fUYzBLv3uvj_2@milan>
 <au3ELzm_s9vhs7UO@thinkstation>
 <avGzD8CAgg9Hif__@milan>
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
In-Reply-To: <avGzD8CAgg9Hif__@milan>

On Mon, Nov 09, 2026 at 12:48:31PM +0100, Uladzislau Rezki wrote:
> On Fri, Nov 06, 2026 at 12:21:28PM +0000, Harry Yoo wrote:
> > On Fri, Nov 06, 2026 at 10:35:13AM +0100, Uladzislau Rezki wrote:
> > > On Wed, Oct 28, 2026 at 09:46:47PM +0800, Zhan Xusheng wrote:
> > > > From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> > > > 
> > > > run_page_cache_worker() runs under krcp->lock, from kvfree_call_rcu()
> > > > callers that may hold more, such as set_cpus_allowed_force() under
> > > > pi_lock, so it kicks the refill work from an hrtimer.  Under memory
> > > > pressure it instead queues the work with a delay of
> > > > rcutree.rcu_delay_page_cache_fill_msec, which may be 0, and a zero delay
> > > > queues it at once, taking pool->lock under krcp->lock.
> > > > 
> > > > With the delay set to 0, calling kvfree_rcu() on vmalloc memory under
> > > > pi_lock after a drop_caches makes lockdep report:
> > > > 
> > > >   Chain exists of:
> > > >     &pool->lock --> &p->pi_lock --> krc.lock
> > > > 
> > > > Use the hrtimer when the delay is 0.
> > > > 
> > > > Fixes: d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory pressure")
> > > > Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> > > > ---
> > > >  mm/slab_common.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > > index 3729aa7a6156..ef5ff0a20249 100644
> > > > --- a/mm/slab_common.c
> > > > +++ b/mm/slab_common.c
> > > > @@ -1987,7 +1987,13 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> > > >  
> > > >  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> > > >  			!atomic_xchg(&krcp->work_in_progress, 1)) {
> > > > -		if (atomic_read(&krcp->backoff_page_cache_fill)) {
> > > > +		/*
> > > > +		 * A zero delay would queue the work right here, under
> > > > +		 * krcp->lock and possibly the caller's pi_lock, so let the
> > > > +		 * hrtimer do it.
> > > > +		 */
> > > > +		if (atomic_read(&krcp->backoff_page_cache_fill) &&
> > > > +		    rcu_delay_page_cache_fill_msec) {
> > > >  			queue_delayed_work(rcu_reclaim_wq,
> > > >  				&krcp->page_cache_work,
> > > >  					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
> > > > -- 
> > > > 2.43.0
> > > > 
> > > > 
> > > Can we just clamp this to 1 - 100 seconds interval?
> > 
> > You mean clamp to [1:100,000] milliseconds interval?
> > 
> Yes. It is now in milliseconds.

Thanks for clarifying.

> So starting with 1 - means that it can be configured at least from 1 msec
> whereas 0 is forbidden. Also we can drop the extra "if condition" proposed
> in the patch as it never can be zero.

But can we explain why forbiding 0 msec can be justified (when there's
an alternative approach to fix it?)

-- 
Cheers,
Harry / Hyeonggon
