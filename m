Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925232DAFB9;
	Wed, 22 Oct 2025 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115634; cv=none; b=s5HO+9j/McU5K7ZHePk399vfiQR8jPH4zBNbCs56OglG7Gaf5LYyDe5+K/ZYn+MU/ZHSRSl+wJePLFvhYTZsiBtps3bO52HAkCjO8x/NDx5HnUdbJCdq6DGgLET7K+E8nIloLtDpDCuKNCYY6LOCurr8qJCbBcWCHEWQmbOgvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115634; c=relaxed/simple;
	bh=G7dayAQv5ZRa6jMwnD0jvsb+pjUyevU3TM3k7L1mdHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYg93R4kaW7LC/wLH79gDJYC1KHmBcZ145ZTbkZQ8KXWoUloVJ2Syj9arl8+vfJJe+3+pL6cCNxPHOBq4eaecObefxWMF5+SSCrykyj76yjaENknN5bIXDnnGaFrkVDwValDQU7ulwHEFp4PjLe7fhEYynwmpvCq4w3f8Yfm5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ydOkPqfF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ydOkPqfF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yps/DoJ74xCH7LKaUk7bfRUU8Jdecw5+xxO3zciKsXg=; b=ydOkPqfFQJfLbk7/4eJ1nENLB/
	7ico0BBBJlHdZytu4u2JI53ikj+afFUK6Esvzk3movFUM6Eo452gx3KDnRbg5jdNb9VNfLI4eb9oU
	OSh2rbJxhv+/xwwrooRiabHli0lVrBPD58cR6V0dp2X0FtcU9qnl5/xBmLi+Bzv6jamky3YuiR6Ht
	7Nipb9xy14H4yKZqlgkSYa7VbHExeD+aA85T+YzxoN1ywS7/kRZpvJme/gYPmNlKtZ5RD76rRITAX
	jL52eu8xA9ARiwVmNnLAaHO+RC9WzAz85vk3qSkn2C0SG38Dtw+ZFk9T6XObMYyq/GOiSt0VIGdJM
	X4jaQx4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSck-00000001iFh-3FyY;
	Wed, 22 Oct 2025 06:47:06 +0000
Date: Tue, 21 Oct 2025 23:47:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	WangYuli <wangyuli@uniontech.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v8 00/23] SLUB percpu sheaves
Message-ID: <aPh96jn2NcqXY4IC@infradead.org>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <aOS0Z5N4HaBNeb_J@infradead.org>
 <c750ab62-a3d4-422e-ac5b-c531dfcc749d@suse.cz>
 <aOX-87tPdtuPb9Uh@infradead.org>
 <c0eb4acf-47ff-4e39-8d32-4e5f3857a851@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0eb4acf-47ff-4e39-8d32-4e5f3857a851@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 15, 2025 at 10:32:44AM +0200, Vlastimil Babka wrote:
> Yeah, not a replacement for mempools which have their special semantics.
> 
> > to implement a mempool_alloc_batch to allow grabbing multiple objects
> > out of a mempool safely for something I'm working on.
> 
> I can imagine allocating multiple objects can be difficult to achieve with
> the mempool's guaranteed progress semantics. Maybe the mempool could serve
> prefilled sheaves?

It doesn't look too bad, but I'd be happy for even better versions.

This is wht I have:

---
From 9d25a3ce6cff11b7853381921c53a51e51f27689 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 8 Sep 2025 18:22:12 +0200
Subject: mempool: add mempool_{alloc,free}_bulk

Add a version of the mempool allocator that works for batch allocations
of multiple objects.  Calling mempool_alloc in a loop is not safe
because it could deadlock if multiple threads are attemping such an
allocation at the same time.

As an extra benefit the interface is build so that the same array
can be used for alloc_pages_bulk / release_pages so that at least
for page backed mempools the fast path can use a nice batch optimization.

Still WIP, this needs proper documentation, and mempool also seems to
miss error injection to actually easily test the pool code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mempool.h |   6 ++
 mm/mempool.c            | 131 ++++++++++++++++++++++++----------------
 2 files changed, 86 insertions(+), 51 deletions(-)

diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 34941a4b9026..59f14e94596f 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -66,9 +66,15 @@ extern void mempool_destroy(mempool_t *pool);
 extern void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask) __malloc;
 #define mempool_alloc(...)						\
 	alloc_hooks(mempool_alloc_noprof(__VA_ARGS__))
+int mempool_alloc_bulk_noprof(mempool_t *pool, void **elem,
+		unsigned int count, gfp_t gfp_mask);
+#define mempool_alloc_bulk(...)						\
+	alloc_hooks(mempool_alloc_bulk_noprof(__VA_ARGS__))
 
 extern void *mempool_alloc_preallocated(mempool_t *pool) __malloc;
 extern void mempool_free(void *element, mempool_t *pool);
+unsigned int mempool_free_bulk(mempool_t *pool, void **elem,
+		unsigned int count);
 
 /*
  * A mempool_alloc_t and mempool_free_t that get the memory from
diff --git a/mm/mempool.c b/mm/mempool.c
index 1c38e873e546..d8884aef2666 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -371,26 +371,13 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
 }
 EXPORT_SYMBOL(mempool_resize);
 
-/**
- * mempool_alloc - allocate an element from a specific memory pool
- * @pool:      pointer to the memory pool which was allocated via
- *             mempool_create().
- * @gfp_mask:  the usual allocation bitmask.
- *
- * this function only sleeps if the alloc_fn() function sleeps or
- * returns NULL. Note that due to preallocation, this function
- * *never* fails when called from process contexts. (it might
- * fail if called from an IRQ context.)
- * Note: using __GFP_ZERO is not supported.
- *
- * Return: pointer to the allocated element or %NULL on error.
- */
-void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
+int mempool_alloc_bulk_noprof(mempool_t *pool, void **elem,
+		unsigned int count, gfp_t gfp_mask)
 {
-	void *element;
 	unsigned long flags;
 	wait_queue_entry_t wait;
 	gfp_t gfp_temp;
+	unsigned int i;
 
 	VM_WARN_ON_ONCE(gfp_mask & __GFP_ZERO);
 	might_alloc(gfp_mask);
@@ -401,15 +388,24 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 
 	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
 
+	i = 0;
 repeat_alloc:
+	for (; i < count; i++) {
+		if (!elem[i])
+			elem[i] = pool->alloc(gfp_temp, pool->pool_data);
+		if (unlikely(!elem[i]))
+			goto use_pool;
+	}
 
-	element = pool->alloc(gfp_temp, pool->pool_data);
-	if (likely(element != NULL))
-		return element;
+	return 0;
 
+use_pool:
 	spin_lock_irqsave(&pool->lock, flags);
-	if (likely(pool->curr_nr)) {
-		element = remove_element(pool);
+	if (likely(pool->curr_nr >= count - i)) {
+		for (; i < count; i++) {
+			if (!elem[i])
+				elem[i] = remove_element(pool);
+		}
 		spin_unlock_irqrestore(&pool->lock, flags);
 		/* paired with rmb in mempool_free(), read comment there */
 		smp_wmb();
@@ -417,8 +413,9 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 		 * Update the allocation stack trace as this is more useful
 		 * for debugging.
 		 */
-		kmemleak_update_trace(element);
-		return element;
+		for (i = 0; i < count; i++)
+			kmemleak_update_trace(elem[i]);
+		return 0;
 	}
 
 	/*
@@ -434,10 +431,12 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 	/* We must not sleep if !__GFP_DIRECT_RECLAIM */
 	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
 		spin_unlock_irqrestore(&pool->lock, flags);
-		return NULL;
+		if (i > 0)
+			mempool_free_bulk(pool, elem + i, count - i);
+		return -ENOMEM;
 	}
 
-	/* Let's wait for someone else to return an element to @pool */
+	/* Let's wait for someone else to return elements to @pool */
 	init_wait(&wait);
 	prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
 
@@ -452,6 +451,30 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 	finish_wait(&pool->wait, &wait);
 	goto repeat_alloc;
 }
+EXPORT_SYMBOL_GPL(mempool_alloc_bulk_noprof);
+
+/**
+ * mempool_alloc - allocate an element from a specific memory pool
+ * @pool:      pointer to the memory pool which was allocated via
+ *             mempool_create().
+ * @gfp_mask:  the usual allocation bitmask.
+ *
+ * this function only sleeps if the alloc_fn() function sleeps or
+ * returns NULL. Note that due to preallocation, this function
+ * *never* fails when called from process contexts. (it might
+ * fail if called from an IRQ context.)
+ * Note: using __GFP_ZERO is not supported.
+ *
+ * Return: pointer to the allocated element or %NULL on error.
+ */
+void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
+{
+	void *elem[1] = { };
+
+	if (mempool_alloc_bulk_noprof(pool, elem, 1, gfp_mask) < 0)
+		return NULL;
+	return elem[0];
+}
 EXPORT_SYMBOL(mempool_alloc_noprof);
 
 /**
@@ -491,20 +514,11 @@ void *mempool_alloc_preallocated(mempool_t *pool)
 }
 EXPORT_SYMBOL(mempool_alloc_preallocated);
 
-/**
- * mempool_free - return an element to the pool.
- * @element:   pool element pointer.
- * @pool:      pointer to the memory pool which was allocated via
- *             mempool_create().
- *
- * this function only sleeps if the free_fn() function sleeps.
- */
-void mempool_free(void *element, mempool_t *pool)
+unsigned int mempool_free_bulk(mempool_t *pool, void **elem, unsigned int count)
 {
 	unsigned long flags;
-
-	if (unlikely(element == NULL))
-		return;
+	bool added = false;
+	unsigned int freed = 0;
 
 	/*
 	 * Paired with the wmb in mempool_alloc().  The preceding read is
@@ -541,15 +555,11 @@ void mempool_free(void *element, mempool_t *pool)
 	 */
 	if (unlikely(READ_ONCE(pool->curr_nr) < pool->min_nr)) {
 		spin_lock_irqsave(&pool->lock, flags);
-		if (likely(pool->curr_nr < pool->min_nr)) {
-			add_element(pool, element);
-			spin_unlock_irqrestore(&pool->lock, flags);
-			if (wq_has_sleeper(&pool->wait))
-				wake_up(&pool->wait);
-			return;
+		while (pool->curr_nr < pool->min_nr && freed < count) {
+			add_element(pool, elem[freed++]);
+			added = true;
 		}
 		spin_unlock_irqrestore(&pool->lock, flags);
-	}
 
 	/*
 	 * Handle the min_nr = 0 edge case:
@@ -560,20 +570,39 @@ void mempool_free(void *element, mempool_t *pool)
 	 * allocation of element when both min_nr and curr_nr are 0, and
 	 * any active waiters are properly awakened.
 	 */
-	if (unlikely(pool->min_nr == 0 &&
+	} else if (unlikely(pool->min_nr == 0 &&
 		     READ_ONCE(pool->curr_nr) == 0)) {
 		spin_lock_irqsave(&pool->lock, flags);
 		if (likely(pool->curr_nr == 0)) {
-			add_element(pool, element);
-			spin_unlock_irqrestore(&pool->lock, flags);
-			if (wq_has_sleeper(&pool->wait))
-				wake_up(&pool->wait);
-			return;
+			add_element(pool, elem[freed++]);
+			added = true;
 		}
 		spin_unlock_irqrestore(&pool->lock, flags);
 	}
 
-	pool->free(element, pool->pool_data);
+	if (unlikely(added) && wq_has_sleeper(&pool->wait))
+		wake_up(&pool->wait);
+
+	return freed;
+}
+EXPORT_SYMBOL_GPL(mempool_free_bulk);
+
+/**
+ * mempool_free - return an element to the pool.
+ * @element:   pool element pointer.
+ * @pool:      pointer to the memory pool which was allocated via
+ *             mempool_create().
+ *
+ * this function only sleeps if the free_fn() function sleeps.
+ */
+void mempool_free(void *element, mempool_t *pool)
+{
+	if (likely(element)) {
+		void *elem[1] = { element };
+
+		if (!mempool_free_bulk(pool, elem, 1))
+			pool->free(element, pool->pool_data);
+	}
 }
 EXPORT_SYMBOL(mempool_free);
 
-- 
2.47.3

