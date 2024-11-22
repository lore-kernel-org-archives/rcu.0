Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A026AF6;
	Fri, 22 Nov 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290897; cv=none; b=IgNWBDACG8489MizXsMs6XCnzjyCxkpLnfLe/mhzmze6AOD1KcP/q4Ba88uYlVT9t5j3TACHK7VuQyK8k0RAkq9ckDkFXuLlYhPqddo49YOfkZ+GStHn+xnu07TsPYmLQ+y0O97km7hoTeXgt34vMYjASCYf9twt16aQXFlJQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290897; c=relaxed/simple;
	bh=8bCnSgRws1rACEsVKOBydmPBxatHnnR2VgF2BINOJ2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6ar0ST3CPLZbYPKjn7YMcxuyMiG3OkrnS9s0o/emzQiA3My+zHyspWaE2JbK8LY+ei+sUsKapB+e7h3OG4pazJNstUFNWDPNDEYk7htrYSkG/MBtLaQIJlSCvsen7+GbAAtGe5zt5YSemkTrJoNFEAWxE8utkrZvSKU2M9IngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dE3cTHlA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1juVXva; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dE3cTHlA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1juVXva"
Date: Fri, 22 Nov 2024 16:54:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732290893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbQPnVZqE+G9GCldWBdvS97jPY1ZKwkWnp4Cqk0q/4c=;
	b=dE3cTHlAmV6SQCh/hIIKb1EH3qWyk/DQ9F1NlLIFayhk1DOzId1QyRaM2XjvFXqowf3NBt
	ExHCn+6ZAlYOoWgutnqtL6YzWbF1/DlNIBLVXjtWpqf9k7XFTP9F/n7bwqdy37UOb4q3YJ
	/3n4OeknXfMpegog2CNel1988YguShNX0zVyZPUpjhukEWKp7nuBFTP5f7n2Cf9kPd2HSw
	RtVzEHL8zs+VJ+OnwxH8sgL9OOxwArEICOXIUeiwnYmPXTU2hF7mUv5pOxg+EuRcjl/YYp
	O7xc/mKlSknU9ChHBn0XeN18SV6kEs1pobYj9ckMpF4Xjasf12JKiz5hWKxZJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732290893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbQPnVZqE+G9GCldWBdvS97jPY1ZKwkWnp4Cqk0q/4c=;
	b=c1juVXva7gE2YlTOtf3dCdu6XZ7N/p1rXxISDXAHeG68isyz78O3FVRRF5C+AkDbEGPz+t
	IJjpwxgAbjyj8XBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	syzbot <syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com>,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com,
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
Subject: [PATCH v2] kasan: Make kasan_record_aux_stack_noalloc() the default
 behaviour
Message-ID: <20241122155451.Mb2pmeyJ@linutronix.de>
References: <67275485.050a0220.3c8d68.0a37.GAE@google.com>
 <ee48b6e9-3f7a-49aa-ae5b-058b5ada2172@suse.cz>
 <b9a674c1-860c-4448-aeb2-bf07a78c6fbf@suse.cz>
 <20241104114506.GC24862@noisy.programming.kicks-ass.net>
 <CANpmjNPmQYJ7pv1N3cuU8cP18u7PP_uoZD8YxwZd4jtbof9nVQ@mail.gmail.com>
 <20241119155701.GYennzPF@linutronix.de>
 <CA+fCnZfzJcbEy0Qmn5GPzPUx9diR+3qw+4ukHa2j5xzzQMF8Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+fCnZfzJcbEy0Qmn5GPzPUx9diR+3qw+4ukHa2j5xzzQMF8Kw@mail.gmail.com>

=46rom: Peter Zijlstra <peterz@infradead.org>

kasan_record_aux_stack_noalloc() was introduced to record a stack trace
without allocating memory in the process. It has been added to callers
which were invoked while a raw_spinlock_t was held.
More and more callers were identified and changed over time. Is it a
good thing to have this while functions try their best to do a
locklessly setup? The only downside of having kasan_record_aux_stack()
not allocate any memory is that we end up without a stacktrace if
stackdepot runs out of memory and at the same stacktrace was not
recorded before To quote Marco Elver from
   https://lore.kernel.org/all/CANpmjNPmQYJ7pv1N3cuU8cP18u7PP_uoZD8YxwZd4jt=
bof9nVQ@mail.gmail.com/

| I'd be in favor, it simplifies things. And stack depot should be
| able to replenish its pool sufficiently in the "non-aux" cases
| i.e. regular allocations. Worst case we fail to record some
| aux stacks, but I think that's only really bad if there's a bug
| around one of these allocations. In general the probabilities
| of this being a regression are extremely small [...]

Make the kasan_record_aux_stack_noalloc() behaviour default as
kasan_record_aux_stack().

[bigeasy: Dressed the diff as patch. ]

Reported-by: syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67275485.050a0220.3c8d68.0a37.GAE@googl=
e.com
Acked-by: Waiman Long <longman@redhat.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Reviewed-by: Marco Elver <elver@google.com>
Fixes: 7cb3007ce2da2 ("kasan: generic: introduce kasan_record_aux_stack_noa=
lloc()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - Renamed the patch as per Marco.
  - Added comment to kasan_record_aux_stack() as per Andrey.
  - Added fixes tag since Waiman that it is the only user.
  - Added Marco's quote from the mail to the commit description.

 include/linux/kasan.h     |  2 --
 include/linux/task_work.h |  3 ---
 kernel/irq_work.c         |  2 +-
 kernel/rcu/tiny.c         |  2 +-
 kernel/rcu/tree.c         |  4 ++--
 kernel/sched/core.c       |  2 +-
 kernel/task_work.c        | 14 +-------------
 kernel/workqueue.c        |  2 +-
 mm/kasan/generic.c        | 18 ++++++------------
 mm/slub.c                 |  2 +-
 10 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 00a3bf7c0d8f0..1a623818e8b39 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -488,7 +488,6 @@ void kasan_cache_create(struct kmem_cache *cache, unsig=
ned int *size,
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
 void kasan_record_aux_stack(void *ptr);
-void kasan_record_aux_stack_noalloc(void *ptr);
=20
 #else /* CONFIG_KASAN_GENERIC */
=20
@@ -506,7 +505,6 @@ static inline void kasan_cache_create(struct kmem_cache=
 *cache,
 static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
 static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 static inline void kasan_record_aux_stack(void *ptr) {}
-static inline void kasan_record_aux_stack_noalloc(void *ptr) {}
=20
 #endif /* CONFIG_KASAN_GENERIC */
=20
diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 2964171856e00..0646804860ff1 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -19,9 +19,6 @@ enum task_work_notify_mode {
 	TWA_SIGNAL,
 	TWA_SIGNAL_NO_IPI,
 	TWA_NMI_CURRENT,
-
-	TWA_FLAGS =3D 0xff00,
-	TWAF_NO_ALLOC =3D 0x0100,
 };
=20
 static inline bool task_work_pending(struct task_struct *task)
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2f4fb336dda17..73f7e1fd4ab4d 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -147,7 +147,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (!irq_work_claim(work))
 		return false;
=20
-	kasan_record_aux_stack_noalloc(work);
+	kasan_record_aux_stack(work);
=20
 	preempt_disable();
 	if (cpu !=3D smp_processor_id()) {
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
=20
 	__kvfree_call_rcu(head, ptr);
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b1f883fcd9185..7eae9bd818a90 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3083,7 +3083,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback=
_t func, bool lazy_in)
 	}
 	head->func =3D func;
 	head->next =3D NULL;
-	kasan_record_aux_stack_noalloc(head);
+	kasan_record_aux_stack(head);
 	local_irq_save(flags);
 	rdp =3D this_cpu_ptr(&rcu_data);
 	lazy =3D lazy_in && !rcu_async_should_hurry();
@@ -3807,7 +3807,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 		return;
 	}
=20
-	kasan_record_aux_stack_noalloc(ptr);
+	kasan_record_aux_stack(ptr);
 	success =3D add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
 	if (!success) {
 		run_page_cache_worker(krcp);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a1c353a62c568..3717360a940d2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10485,7 +10485,7 @@ void task_tick_mm_cid(struct rq *rq, struct task_st=
ruct *curr)
 		return;
=20
 	/* No page allocation under rq lock */
-	task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
+	task_work_add(curr, work, TWA_RESUME);
 }
=20
 void sched_mm_cid_exit_signals(struct task_struct *t)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index c969f1f26be58..d1efec571a4a4 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -55,26 +55,14 @@ int task_work_add(struct task_struct *task, struct call=
back_head *work,
 		  enum task_work_notify_mode notify)
 {
 	struct callback_head *head;
-	int flags =3D notify & TWA_FLAGS;
=20
-	notify &=3D ~TWA_FLAGS;
 	if (notify =3D=3D TWA_NMI_CURRENT) {
 		if (WARN_ON_ONCE(task !=3D current))
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
=20
 	head =3D READ_ONCE(task->task_works);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9949ffad8df09..65b8314b2d538 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2180,7 +2180,7 @@ static void insert_work(struct pool_workqueue *pwq, s=
truct work_struct *work,
 	debug_work_activate(work);
=20
 	/* record the work call stack in order to print it in KASAN reports */
-	kasan_record_aux_stack_noalloc(work);
+	kasan_record_aux_stack(work);
=20
 	/* we own @work, set data and link */
 	set_work_pwq(work, pwq, extra_flags);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 6310a180278b6..2242249c2d50d 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -521,7 +521,11 @@ size_t kasan_metadata_size(struct kmem_cache *cache, b=
ool in_object)
 			sizeof(struct kasan_free_meta) : 0);
 }
=20
-static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
+/*
+ * This function avoids dynamic memory allocations and thus can be called =
=66rom
+ * contexts that do not allow allocating memory.
+ */
+void kasan_record_aux_stack(void *addr)
 {
 	struct slab *slab =3D kasan_addr_to_slab(addr);
 	struct kmem_cache *cache;
@@ -538,17 +542,7 @@ static void __kasan_record_aux_stack(void *addr, depot=
_flags_t depot_flags)
 		return;
=20
 	alloc_meta->aux_stack[1] =3D alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] =3D kasan_save_stack(0, depot_flags);
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
+	alloc_meta->aux_stack[0] =3D kasan_save_stack(0, 0);
 }
=20
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t f=
lags)
diff --git a/mm/slub.c b/mm/slub.c
index 5b832512044e3..b8c4bf3fe0d07 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2300,7 +2300,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bo=
ol init,
 			 * We have to do this manually because the rcu_head is
 			 * not located inside the object.
 			 */
-			kasan_record_aux_stack_noalloc(x);
+			kasan_record_aux_stack(x);
=20
 			delayed_free->object =3D x;
 			call_rcu(&delayed_free->head, slab_free_after_rcu_debug);
--=20
2.45.2

