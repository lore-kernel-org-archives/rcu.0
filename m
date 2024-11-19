Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9B78C76;
	Tue, 19 Nov 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031827; cv=none; b=kb+HcMHWP5nxKz+AqFLgRG/SO8ShmgRZR7JxL+LcHpMLumErggQ8oogLxbiEJWazyWh7EyX2nDcrJih/GWak959R/YXa7QHFn6UGnlxh8cr4+cB3iniCrp+m/0gmI0kWCBpSWnJ2QeAWEjiGQvqJAOK8YbiwT9ZFlbTBcbc7xCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031827; c=relaxed/simple;
	bh=pPWk2srY52uKpMTPEaaa6/FCmseLFxfV4tOXS4hNUW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vsecc4sA7r7JUBEvjo09VNRsUUyuNCxEafao8KLAr08bAy6EhLyPvBf9zGFfzOtwzrFQRG3jFwCZkKEqtY/yzoW4naRmo36X3AaX54Dy/FqOtPgsLNJbTg21TCpMWthmtkFXFyh+ZygMLk7eAJ6YBkBTrya22btLzCDojF+Vfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zVS+9zO4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M9Vih6ak; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zVS+9zO4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M9Vih6ak"
Date: Tue, 19 Nov 2024 16:57:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732031823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/MZupiwZEv7S6PjpR394r6GaOTkxg+//UpoNKUISypU=;
	b=zVS+9zO4h+PK0IqQ8XLcKd95hrb/9Cn9t82pvxjhq4ohxyu58DOSkzJbM51AE7F8552EIW
	XMu+7XqS47dcd5OlDFlrIhBBvo6uaj9gYuDQOqDydml0UkFFPKRU74ogbUzFTRElOMEas+
	4VFxUTTe8pX68HxeleUaEUwFl/7OJr4tQL4ToTV1vg8W3q/R5Y90dOUo1PHYCWPzC12miy
	k6OS0jvb0jPrulaRnWUycY0ivSOV89iYjeXmE3QaWOdjTbslix5x6Yk7yGLrkWykLo+sJw
	BCSGmzmipZ3KQaZVnNiAw1kQ0pYI8Sgg1Bf4bz2qqEAMdzhzdkjRxdNuyBKEdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732031823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/MZupiwZEv7S6PjpR394r6GaOTkxg+//UpoNKUISypU=;
	b=M9Vih6akybhkq0+cTrUzYnbzTr0aHFMI9KXtGv3vOOIAn3q9LUHEu8CCp1WTz13SSKwT4Z
	Lpcp3VRNsatxhTCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	syzbot <syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com>,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com,
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
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
	Thomas Gleixner <tglx@linutronix.de>, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, rcu@vger.kernel.org
Subject: [PATCH] kasan: Remove kasan_record_aux_stack_noalloc().
Message-ID: <20241119155701.GYennzPF@linutronix.de>
References: <67275485.050a0220.3c8d68.0a37.GAE@google.com>
 <ee48b6e9-3f7a-49aa-ae5b-058b5ada2172@suse.cz>
 <b9a674c1-860c-4448-aeb2-bf07a78c6fbf@suse.cz>
 <20241104114506.GC24862@noisy.programming.kicks-ass.net>
 <CANpmjNPmQYJ7pv1N3cuU8cP18u7PP_uoZD8YxwZd4jtbof9nVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNPmQYJ7pv1N3cuU8cP18u7PP_uoZD8YxwZd4jtbof9nVQ@mail.gmail.com>

From: Peter Zijlstra <peterz@infradead.org>

kasan_record_aux_stack_noalloc() was introduced to record a stack trace
without allocating memory in the process. It has been added to callers
which were invoked while a raw_spinlock_t was held.
More and more callers were identified and changed over time. Is it a
good thing to have this while functions try their best to do a
locklessly setup? The only downside of having kasan_record_aux_stack()
not allocate any memory is that we end up without a stacktrace if
stackdepot runs out of memory and at the same stacktrace was not
recorded before. Marco Elver said in
	https://lore.kernel.org/all/20210913112609.2651084-1-elver@google.com/
that this is rare.

Make the kasan_record_aux_stack_noalloc() behaviour default as
kasan_record_aux_stack().

[bigeasy: Dressed the diff as patch. ]

Reported-by: syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67275485.050a0220.3c8d68.0a37.GAE@google.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Didn't add a Fixes tag, didn't want to put 
   7cb3007ce2da2 ("kasan: generic: introduce kasan_record_aux_stack_noalloc()")

there.

 include/linux/kasan.h     |  2 --
 include/linux/task_work.h |  3 ---
 kernel/irq_work.c         |  2 +-
 kernel/rcu/tiny.c         |  2 +-
 kernel/rcu/tree.c         |  4 ++--
 kernel/sched/core.c       |  2 +-
 kernel/task_work.c        | 14 +-------------
 kernel/workqueue.c        |  2 +-
 mm/kasan/generic.c        | 14 ++------------
 mm/slub.c                 |  2 +-
 10 files changed, 10 insertions(+), 37 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 00a3bf7c0d8f0..1a623818e8b39 100644
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
index 2964171856e00..0646804860ff1 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -19,9 +19,6 @@ enum task_work_notify_mode {
 	TWA_SIGNAL,
 	TWA_SIGNAL_NO_IPI,
 	TWA_NMI_CURRENT,
-
-	TWA_FLAGS = 0xff00,
-	TWAF_NO_ALLOC = 0x0100,
 };
 
 static inline bool task_work_pending(struct task_struct *task)
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2f4fb336dda17..73f7e1fd4ab4d 100644
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
index b3b3ce34df631..4b3f319114650 100644
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
index b1f883fcd9185..7eae9bd818a90 100644
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
index a1c353a62c568..3717360a940d2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10485,7 +10485,7 @@ void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
 		return;
 
 	/* No page allocation under rq lock */
-	task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
+	task_work_add(curr, work, TWA_RESUME);
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index c969f1f26be58..d1efec571a4a4 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -55,26 +55,14 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		  enum task_work_notify_mode notify)
 {
 	struct callback_head *head;
-	int flags = notify & TWA_FLAGS;
 
-	notify &= ~TWA_FLAGS;
 	if (notify == TWA_NMI_CURRENT) {
 		if (WARN_ON_ONCE(task != current))
 			return -EINVAL;
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
index 9949ffad8df09..65b8314b2d538 100644
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
index 6310a180278b6..b18b5944997f8 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -521,7 +521,7 @@ size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
 			sizeof(struct kasan_free_meta) : 0);
 }
 
-static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
+void kasan_record_aux_stack(void *addr)
 {
 	struct slab *slab = kasan_addr_to_slab(addr);
 	struct kmem_cache *cache;
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
index 5b832512044e3..b8c4bf3fe0d07 100644
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
-- 
2.45.2

