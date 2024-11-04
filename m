Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C201B21AF;
	Mon,  4 Nov 2024 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720733; cv=none; b=E8nm8deEQ/AyKooHau2FgywCuvVXkiaC6IHdslryvRkoiETSJab7O9/ccpfCvlg0eYcCfwUwdho7qeB/aDyFUy+Bf1pC7t2u5thgoiSkWZBBAYcg/MluHXLXH0FCyHgWw/ssxTSU8rXApS0J74bKERljjGPQ/Y9GZkHzP7vvrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720733; c=relaxed/simple;
	bh=KVDby3c7DfMjMMwDb+3rQ9nlHeE4Avrp8aPfYCVqQbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIUbDjhmXPKP5lhYfj9OzsgBygOZ5Gckpv9WHgYg6gUYjPNINKwd/YlEz+Bzn6qWTb6VZa8WDPLh/+OLy46FAhG37YgmCFde+JkLg+FOYSiQdJBvBJzrW+iD1WxvmWq1FuaFbPu3of0u3+B+GUQipYl5PxFzwD4M7x1gco7xyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IQjV1Okq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IQjV1Okq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mYq2E5JqCpFxnnaQge2hIZbWTa3Or6pRl9pnrxRgOwA=; b=IQjV1OkqHH4Tgw5q5Eji03dmw3
	CYzrCgtzK5De54IbL3dsTmmMV00KpBjzzyrd9Rav5/FvRwOWoT5aYiTTfLeXFE+qIRNjcH0BWWLf3
	wrserS0aDM+kdcmlybZXwbOcswLILUastnrpSvGZZt/ZOyr3BP6zhuOmNNrRwLw5sQaR1qURtDl7P
	7aCF5J2GJhYWD8oBN/QbCWTyoOQCZL/3DlREe+0XRCLSdYURbWVabK48l0jGxUHoOpxcq7M1Euhn6
	bHMN2sb5h5Ib41iI5jQaQbsRxn+pH305Kxs50doIndy/CAHaHz2rYFR/V7T7islZ7nJIHcYsswWMi
	xNKEJQvA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7vW6-000000017vV-2NZE;
	Mon, 04 Nov 2024 11:45:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 58C81300324; Mon,  4 Nov 2024 12:45:06 +0100 (CET)
Date: Mon, 4 Nov 2024 12:45:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: syzbot <syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com>,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	kasan-dev <kasan-dev@googlegroups.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Waiman Long <longman@redhat.com>, dvyukov@google.com,
	vincenzo.frascino@arm.com, paulmck@kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	tj@kernel.org, cl@linux.com, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, rcu@vger.kernel.org
Subject: Re: [syzbot] [mm?] WARNING: locking bug in __rmqueue_pcplist
Message-ID: <20241104114506.GC24862@noisy.programming.kicks-ass.net>
References: <67275485.050a0220.3c8d68.0a37.GAE@google.com>
 <ee48b6e9-3f7a-49aa-ae5b-058b5ada2172@suse.cz>
 <b9a674c1-860c-4448-aeb2-bf07a78c6fbf@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a674c1-860c-4448-aeb2-bf07a78c6fbf@suse.cz>

On Mon, Nov 04, 2024 at 12:25:03PM +0100, Vlastimil Babka wrote:
> On 11/4/24 12:11, Vlastimil Babka wrote:

> >>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4771
> >>  alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
> >>  stack_depot_save_flags+0x666/0x830 lib/stackdepot.c:627
> >>  kasan_save_stack+0x4f/0x60 mm/kasan/common.c:48
> >>  __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
> >>  task_work_add+0xd9/0x490 kernel/task_work.c:77
> > 
> > It seems the decision if stack depot is allowed to allocate here depends on
> > TWAF_NO_ALLOC added only recently. So does it mean it doesn't work as intended?
> 
> I guess __run_posix_cpu_timers() needs to pass TWAF_NO_ALLOC too?

Yeah, or we just accept that kasan_record_aux_stack() is a horrible
thing and shouldn't live in functions that try their bestest to
locklessly setup async work at all.

That thing has only ever caused trouble :/

Also see 156172a13ff0.

How about we do the below at the very least?

---
 include/linux/kasan.h     |  2 --
 include/linux/task_work.h |  1 -
 kernel/irq_work.c         |  2 +-
 kernel/rcu/tiny.c         |  2 +-
 kernel/rcu/tree.c         |  4 ++--
 kernel/sched/core.c       |  2 +-
 kernel/task_work.c        | 12 +-----------
 kernel/workqueue.c        |  2 +-
 mm/kasan/generic.c        | 16 +++-------------
 mm/slub.c                 |  2 +-
 10 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 00a3bf7c0d8f..1a623818e8b3 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -488,7 +488,6 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
 void kasan_record_aux_stack(void *ptr);
-void kasan_record_aux_stack_noalloc(void *ptr);
 
 #else /* CONFIG_KASAN_GENERIC */
 
@@ -506,7 +505,6 @@ static inline void kasan_cache_create(struct kmem_cache *cache,
 static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
 static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 static inline void kasan_record_aux_stack(void *ptr) {}
-static inline void kasan_record_aux_stack_noalloc(void *ptr) {}
 
 #endif /* CONFIG_KASAN_GENERIC */
 
diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 2964171856e0..db1690e01346 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -21,7 +21,6 @@ enum task_work_notify_mode {
 	TWA_NMI_CURRENT,
 
 	TWA_FLAGS = 0xff00,
-	TWAF_NO_ALLOC = 0x0100,
 };
 
 static inline bool task_work_pending(struct task_struct *task)
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2f4fb336dda1..73f7e1fd4ab4 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -147,7 +147,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (!irq_work_claim(work))
 		return false;
 
-	kasan_record_aux_stack_noalloc(work);
+	kasan_record_aux_stack(work);
 
 	preempt_disable();
 	if (cpu != smp_processor_id()) {
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index b3b3ce34df63..4b3f31911465 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -250,7 +250,7 @@ EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
 void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 {
 	if (head)
-		kasan_record_aux_stack_noalloc(ptr);
+		kasan_record_aux_stack(ptr);
 
 	__kvfree_call_rcu(head, ptr);
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b1f883fcd918..7eae9bd818a9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3083,7 +3083,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	}
 	head->func = func;
 	head->next = NULL;
-	kasan_record_aux_stack_noalloc(head);
+	kasan_record_aux_stack(head);
 	local_irq_save(flags);
 	rdp = this_cpu_ptr(&rcu_data);
 	lazy = lazy_in && !rcu_async_should_hurry();
@@ -3807,7 +3807,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 		return;
 	}
 
-	kasan_record_aux_stack_noalloc(ptr);
+	kasan_record_aux_stack(ptr);
 	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
 	if (!success) {
 		run_page_cache_worker(krcp);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5de31c312189..dafc668a156e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10519,7 +10519,7 @@ void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
 		return;
 
 	/* No page allocation under rq lock */
-	task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
+	task_work_add(curr, work, TWA_RESUME);
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index c969f1f26be5..2ffd5a6db91b 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -64,17 +64,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		if (!IS_ENABLED(CONFIG_IRQ_WORK))
 			return -EINVAL;
 	} else {
-		/*
-		 * Record the work call stack in order to print it in KASAN
-		 * reports.
-		 *
-		 * Note that stack allocation can fail if TWAF_NO_ALLOC flag
-		 * is set and new page is needed to expand the stack buffer.
-		 */
-		if (flags & TWAF_NO_ALLOC)
-			kasan_record_aux_stack_noalloc(work);
-		else
-			kasan_record_aux_stack(work);
+		kasan_record_aux_stack(work);
 	}
 
 	head = READ_ONCE(task->task_works);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9949ffad8df0..65b8314b2d53 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2180,7 +2180,7 @@ static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
 	debug_work_activate(work);
 
 	/* record the work call stack in order to print it in KASAN reports */
-	kasan_record_aux_stack_noalloc(work);
+	kasan_record_aux_stack(work);
 
 	/* we own @work, set data and link */
 	set_work_pwq(work, pwq, extra_flags);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 6310a180278b..ac9f6682bb2f 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -521,12 +521,12 @@ size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
 			sizeof(struct kasan_free_meta) : 0);
 }
 
-static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
+void kasan_record_aux_stack(void *addr)
 {
 	struct slab *slab = kasan_addr_to_slab(addr);
 	struct kmem_cache *cache;
 	struct kasan_alloc_meta *alloc_meta;
-	void *object;
+	void *object
 
 	if (is_kfence_address(addr) || !slab)
 		return;
@@ -538,17 +538,7 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
 		return;
 
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
-}
-
-void kasan_record_aux_stack(void *addr)
-{
-	return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_CAN_ALLOC);
-}
-
-void kasan_record_aux_stack_noalloc(void *addr)
-{
-	return __kasan_record_aux_stack(addr, 0);
+	alloc_meta->aux_stack[0] = kasan_save_stack(0, 0);
 }
 
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
diff --git a/mm/slub.c b/mm/slub.c
index 5b832512044e..b8c4bf3fe0d0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2300,7 +2300,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
 			 * We have to do this manually because the rcu_head is
 			 * not located inside the object.
 			 */
-			kasan_record_aux_stack_noalloc(x);
+			kasan_record_aux_stack(x);
 
 			delayed_free->object = x;
 			call_rcu(&delayed_free->head, slab_free_after_rcu_debug);
