Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CB1169AE3
	for <rcu@vger.kernel.org>; Thu, 11 Jul 2024 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702947; cv=none; b=gmli5KsQeP44e+FBqBT4yw4Go8PgKwK654FnczKisNcIxCIi+vF0QaI6Pi/qjaFMVPkUVKwM5qhDFkS2v05V2CFdEZVbzsRFEFGawOKvI02gu8LPgJjUuWOpZyKqU7m8u+st92bJXRIS8WifAAP+aeIMlMcb+sh1Qcf8QNhsroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702947; c=relaxed/simple;
	bh=ck9m3Um5OTNGL+iPZ3Ph2VLm2iJmwF9OHXTWyjvQvrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7Jp/eAc62eH7pF7uxjmkw8bIqCcQHEL9Ntx/hxvjIotp55GEQwzwFUvkaEVXBeZ3BMp6XTvQ5wAxfgoLev7PD+fhGgiVWsCXdtE2qTqt9ugUua8n54lSr8gaPd/qezdH0f/wKvlbICZ/bkc2HFKR8nPu4mYGhaZ0WieEi9VWgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMvTydEA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMvTydEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720702944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FzQ5KjMRLj4g81cfSh32RRFGiouIEV/aENXMGz09G0s=;
	b=ZMvTydEA442F20cTOaHkClaglaQvAS7MlxpU/rg7Y+KoXrDnUjO+9+Ysy5bQaygSm3LqP+
	7V/fQw7QQa2BpEkuOzfjSBXVxjKb83V1oe1N1e9w442O70R7ii8dLzr9QI5QQq+4KjWQuJ
	ad5yEbVafpA1olFlQdj6TqTECq71lpc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-w0Nh7MaYNbCd0g_UNUP4XA-1; Thu,
 11 Jul 2024 09:02:21 -0400
X-MC-Unique: w0Nh7MaYNbCd0g_UNUP4XA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE4111955EA9;
	Thu, 11 Jul 2024 13:02:11 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.211])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7194F1955EB3;
	Thu, 11 Jul 2024 13:02:04 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Phil Auld <pauld@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH v3 10/10] sched/fair: Throttle CFS tasks on return to userspace
Date: Thu, 11 Jul 2024 15:00:04 +0200
Message-ID: <20240711130004.2157737-11-vschneid@redhat.com>
In-Reply-To: <20240711130004.2157737-1-vschneid@redhat.com>
References: <20240711130004.2157737-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

As reported in [1], CFS bandwidth throttling is a source of headaches in
PREEMPT_RT - generally speaking, a throttled CFS task can hold locks that
prevent ksoftirqd from running, which prevents replenishing & unthrottling
the cfs_rq of said CFS task.

Peter mentioned that there have been discussions on changing /when/ the
throttling happens: rather than have it be done immediately upon updating
the runtime statistics and realizing the cfs_rq has depleted its quota, we wait
for the task to be about to return to userspace.

This approach also benefits !PREEMPT_RT, as it reduces latency caused by
throttled tasks owning contended (kernel) resources.

Concept
=======

Upon throttling a cfs_rq, all tasks already enqueued get a task_work added,
which lets the actual throttling happen in exit_to_user_mode().
Any new task migrated to or enqueued on such a cfs_rq similarly gets the
task_work added.

Previous patches have added helpers for all the relevant locations where
the task_work may need to be either added or removed depending on the state
of the cfs_rq the task is (to be) enqueued on:
o sched_class change
o cgroup migration
o CPU migration
o task wakeup

Upon unthrottling, tasks are enqueued back onto their respective
cfs_rq. Unlike the previous throttling implementation, cfs_rq's can be
unthrottled while in a half-throttled state (i.e. some tasks have been
removed from them, while others are still enqueued and runnable as they
haven't reached exit_to_user_mode() yet), so the unthrottling process is a
bit more involved, especially when it comes to maintaining *nr_running fields.

Clocks
======

Correctly handling the different cfs_rq->throttled_clock* is tricky, as
unlike the current upstream approach where all tasks of a cfs_rq are
throttled at the exact same time, here they each get throttled at a
per-task, not-known-beforehand time.

For instance, for the ->throttled_clock_pelt, ideally we would need a
per-task snapshot of when the task gets really throttled in
exit_to_user_mode(), rather than a single snapshot of when the cfs_rq runs
out of runtime. This isn't implemented here. The ->throttled_clock_pelt is
set when the cfs_rq runs out of runtime, which means the "grace period"
given to the cfs_rq's tasks on their way to exit_to_user_mode() isn't
accounted.

Notable behaviour changes
=========================

Once a cfs_rq is ->throttled, its tasks can continue running until they hit
exit_to_user_mode(). This means they can keep draining further runtime
from their cfs_rq, which can end up draining more than one period's worth
of runtime.

I've tested a 10ms runtime / 100ms period cgroup with an always running
task: upstream gets a "clean" periodic pattern of 10ms runtime every 100ms,
whereas this gets something more like 40ms runtime every 400ms.

[1]: https://lore.kernel.org/all/20231031160120.GE15024@noisy.programming.kicks-ass.net/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/sched.h |   1 +
 kernel/sched/fair.c   | 438 ++++++++++++++++++++++++++++++------------
 kernel/sched/sched.h  |   4 +
 3 files changed, 320 insertions(+), 123 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 99a1e77d769db..29b9334738af1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -815,6 +815,7 @@ struct task_struct {
 	struct task_group		*sched_task_group;
 	struct callback_head            sched_throttle_work;
 #ifdef CONFIG_CFS_BANDWIDTH
+	struct list_head                throttle_node;
 	struct irq_work                 unthrottle_irq_work;
 #endif
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0cec3e70f1277..08cf7343aedb1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -54,6 +54,7 @@
 #include "sched.h"
 #include "stats.h"
 #include "autogroup.h"
+#include "task_work_sched.h"
 
 /*
  * The initial- and re-scaling of tunables is configurable
@@ -5694,12 +5695,114 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 	return cfs_bandwidth_used() && cfs_rq->throttle_count;
 }
 
-static inline bool task_has_throttle_work(struct task_struct *p) { return false; }
-static inline bool task_needs_throttling(struct task_struct *p) { return false; }
-static inline bool task_needs_migrate_throttling(struct task_struct *p, unsigned int dst_cpu) { return false; }
-static inline void task_throttle_setup(struct task_struct *p) { }
-static inline void task_throttle_cancel_migrate(struct task_struct *p, int dst_cpu) { }
-static inline void task_throttle_cancel(struct task_struct *p) { }
+static inline bool task_has_throttle_work(struct task_struct *p)
+{
+	return p->sched_throttle_work.next != &p->sched_throttle_work;
+}
+
+static inline bool task_needs_throttling(struct task_struct *p)
+{
+	return throttled_hierarchy(cfs_rq_of(&p->se));
+}
+
+static inline bool task_needs_migrate_throttling(struct task_struct *p, unsigned int dst_cpu)
+{
+	return throttled_hierarchy(task_group(p)->cfs_rq[dst_cpu]);
+}
+
+static inline bool task_is_throttled(struct task_struct *p)
+{
+	return !list_empty(&p->throttle_node);
+}
+
+static inline void task_throttle_setup_work(struct task_struct *p)
+{
+	/*
+	 * Kthreads and exiting tasks don't return to userspace, so adding the
+	 * work is pointless
+	 */
+	if (!(p->flags & (PF_EXITING | PF_KTHREAD)))
+		task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
+}
+
+static void throttle_cfs_rq_work(struct callback_head *work);
+static inline void task_throttle_do_cancel_work(struct task_struct *p)
+{
+	/*
+	 * If this returns NULL, it means the work got run, which per
+	 * this being called is a bug: the task_work throttled the
+	 * task when it didn't need to be.
+	 */
+	WARN_ON_ONCE(!task_work_cancel_locked(p, throttle_cfs_rq_work));
+	p->sched_throttle_work.next = &p->sched_throttle_work;
+}
+
+static inline void task_throttle_cancel_work(struct task_struct *p, int dst_cpu)
+{
+       /*
+	* The calling context may be holding p->pi_lock, which is also acquired
+	* by task_work_cancel_match().
+	*
+	* Lock recursion is prevented by punting the work cancellation to the
+	* next IRQ enable. This is sent to the destination CPU rather than
+	* >this< CPU to prevent the task from resuming execution and getting
+	* throttled in its return to userspace.
+	*/
+       irq_work_queue_on(&p->unthrottle_irq_work, dst_cpu);
+}
+
+static void task_throttle_cancel_irq_work_fn(struct irq_work *work)
+{
+	struct task_struct *p = container_of(work, struct task_struct, unthrottle_irq_work);
+	int cpu = raw_smp_processor_id();
+
+	CLASS(task_rq_lock, rq_guard)(p);
+	WARN_ON_ONCE(task_cpu(p) != cpu);
+
+	if (task_has_throttle_work(p) && !task_needs_throttling(p))
+		task_throttle_do_cancel_work(p);
+}
+
+static inline void task_throttle_setup(struct task_struct *p)
+{
+	/*
+	 * If already throttled-in-userspace, just transfer the throttle_node
+	 * link to the new cfs_rq
+	 *
+	 * Else, if not yet throttled, set up the work. Also, the task may be
+	 * running in userspace (e.g. this is called from sched_move_task()),
+	 * so make sure it is running in kernelspace to get the kernel-exit
+	 * throttle.
+	 */
+	if (task_is_throttled(p))
+		list_move(&p->throttle_node, &cfs_rq_of(&p->se)->throttled_limbo_list);
+	else if (!task_has_throttle_work(p))
+		task_throttle_setup_work(p);
+}
+
+static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags);
+static inline void __task_throttle_cancel(struct task_struct *p, unsigned int cpu)
+{
+	/*
+	 * Task musn't be throttled, either:
+	 * o it's already throttled-in-userspace, unthrottle it
+	 * o it has the task_work installed, remove it
+	 */
+	if (task_is_throttled(p)) {
+		list_del_init(&p->throttle_node);
+		enqueue_task_fair(cpu_rq(cpu), p, ENQUEUE_WAKEUP);
+	} else if (task_has_throttle_work(p)) {
+		task_throttle_cancel_work(p, cpu);
+	}
+}
+static inline void task_throttle_cancel(struct task_struct *p)
+{
+	__task_throttle_cancel(p, task_cpu(p));
+}
+static inline void task_throttle_cancel_migrate(struct task_struct *p, unsigned int dst_cpu)
+{
+	__task_throttle_cancel(p, dst_cpu);
+}
 
 /*
  * Ensure that neither of the group entities corresponding to src_cpu or
@@ -5722,35 +5825,107 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
 	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+	struct sched_entity *se = tg->se[cpu_of(rq)];
+	struct cfs_rq *pcfs_rq = cfs_rq_of(se);
+	long task_delta = 0, idle_task_delta = 0;
+	struct task_struct *p, *tmp;
 
 	cfs_rq->throttle_count--;
-	if (!cfs_rq->throttle_count) {
-		cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
-					     cfs_rq->throttled_clock_pelt;
+	if (cfs_rq->throttle_count)
+		return 0;
 
-		/* Add cfs_rq with load or one or more already running entities to the list */
-		if (!cfs_rq_is_decayed(cfs_rq))
-			list_add_leaf_cfs_rq(cfs_rq);
+	cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
+		cfs_rq->throttled_clock_pelt;
+
+	/* Add cfs_rq with load or one or more already running entities to the list */
+	if (!cfs_rq_is_decayed(cfs_rq))
+		list_add_leaf_cfs_rq(cfs_rq);
 
-		if (cfs_rq->throttled_clock_self) {
-			u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
+	if (cfs_rq->throttled_clock_self) {
+		u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
 
-			cfs_rq->throttled_clock_self = 0;
+		cfs_rq->throttled_clock_self = 0;
 
-			if (SCHED_WARN_ON((s64)delta < 0))
-				delta = 0;
+		if (SCHED_WARN_ON((s64)delta < 0))
+			delta = 0;
 
-			cfs_rq->throttled_clock_self_time += delta;
-		}
+		cfs_rq->throttled_clock_self_time += delta;
+	}
+
+	/*
+	 * Re-enqueue the tasks that have been throttled at this level.
+	 *
+	 * The task count is up-propagated via ->unthrottled_*h_nr_running,
+	 * as we can't purely rely on h_nr_running post-enqueue: the unthrottle
+	 * might happen when a cfs_rq still has some tasks enqueued, either still
+	 * making their way to userspace, or freshly migrated to it.
+	 */
+	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
+		struct sched_entity *pse = &p->se;
+
+		list_del_init(&p->throttle_node);
+
+		enqueue_entity(cfs_rq, pse, ENQUEUE_WAKEUP);
+		task_delta++;
+		idle_task_delta += task_has_idle_policy(p);
+	}
+
+	/*
+	 * Account tasks woken up in children; by this point all direct children
+	 * have been visited.
+	 */
+	task_delta += cfs_rq->unthrottled_h_nr_running;
+	idle_task_delta += cfs_rq->unthrottled_idle_h_nr_running;
+
+	cfs_rq->h_nr_running += task_delta;
+	cfs_rq->idle_h_nr_running += idle_task_delta;
+
+	/*
+	 * unthrottle_cfs_rq() needs a value to up-propagate above the
+	 * freshly unthrottled cfs_rq.
+	 */
+	cfs_rq->unthrottled_h_nr_running = task_delta;
+	cfs_rq->unthrottled_idle_h_nr_running = idle_task_delta;
+
+	/* Accumulate the delta in the parent's stash. Once all its children
+	 * (i.e. all of this cfs_rq's siblings) have been visited, this value
+	 * will be stable and used for its own count update.
+	 */
+	pcfs_rq->unthrottled_h_nr_running += task_delta;
+	pcfs_rq->unthrottled_idle_h_nr_running += idle_task_delta;
+
+	/*
+	 * If the cfs_rq became empty during throttling, then we dequeued
+	 * it. It needs to be put back in the hierarchy if it or any of
+	 * its children have now-unthrottled tasks.
+	 */
+	if (!se->on_rq && (cfs_rq->h_nr_running || cfs_rq->idle_h_nr_running)) {
+		enqueue_entity(pcfs_rq, se, ENQUEUE_WAKEUP);
+	} else {
+		update_load_avg(pcfs_rq, se, UPDATE_TG);
+		se_update_runnable(se);
 	}
 
 	return 0;
 }
 
+static int tg_unthrottle_clear_up(struct task_group *tg, void *data)
+{
+	struct rq *rq = data;
+	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+
+	cfs_rq->unthrottled_h_nr_running = 0;
+	cfs_rq->unthrottled_idle_h_nr_running = 0;
+
+	return 0;
+}
+
 static int tg_throttle_down(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
 	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+	struct rb_node *node;
+	struct task_struct *p;
 
 	/* group is entering throttled state, stop time */
 	if (!cfs_rq->throttle_count) {
@@ -5763,17 +5938,118 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	}
 	cfs_rq->throttle_count++;
 
+	/*
+	 * If we've already visited this cfs_rq (e.g. it ran out of its own
+	 * runtime sometime earlier and hasn't had a replenish yet), then
+	 * there's nothing more to do.
+	 */
+	if (cfs_rq->throttle_count > 1)
+		return 0;
+
+	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
+	/*
+	 * rq_lock is held, current is (obviously) executing this in kernelspace.
+	 *
+	 * All other tasks enqueued on this rq have their saved PC at the
+	 * context switch, so they will go through the kernel before returning
+	 * to userspace. Thus, there are no tasks-in-userspace to handle, just
+	 * install the task_work on all of them.
+	 */
+	node = rb_first(&cfs_rq->tasks_timeline.rb_root);
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+
+		if (!entity_is_task(se))
+			goto next;
+
+		p = task_of(se);
+
+		if (!task_has_throttle_work(p))
+			task_throttle_setup_work(p);
+next:
+		node = rb_next(node);
+	}
+
 	return 0;
 }
 
-static void throttle_cfs_rq_work(struct callback_head *work)
+static void throttle_one_task(struct cfs_rq *cfs_rq, struct task_struct *p)
 {
+	long task_delta, idle_task_delta;
+	struct sched_entity *se = &p->se;
+
+	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
 
+	task_delta = 1;
+	idle_task_delta = cfs_rq_is_idle(cfs_rq) ? 1 : 0;
+
+	for_each_sched_entity(se) {
+		cfs_rq = cfs_rq_of(se);
+
+		if (!se->on_rq)
+			return;
+
+		dequeue_entity(cfs_rq, se, DEQUEUE_SLEEP);
+		cfs_rq->h_nr_running -= task_delta;
+		cfs_rq->idle_h_nr_running -= idle_task_delta;
+
+		if (cfs_rq->load.weight) {
+			/* Avoid re-evaluating load for this entity: */
+			se = parent_entity(se);
+			break;
+		}
+	}
+
+	for_each_sched_entity(se) {
+		cfs_rq = cfs_rq_of(se);
+		/* throttled entity or throttle-on-deactivate */
+		if (!se->on_rq)
+			goto throttle_done;
+
+		update_load_avg(cfs_rq, se, 0);
+		se_update_runnable(se);
+		cfs_rq->h_nr_running -= task_delta;
+		cfs_rq->h_nr_running -= idle_task_delta;
+	}
+
+throttle_done:
+	/* At this point se is NULL and we are at root level*/
+	sub_nr_running(rq_of(cfs_rq), 1);
 }
 
-static void task_throttle_cancel_irq_work_fn(struct irq_work *work)
+static void throttle_cfs_rq_work(struct callback_head *work)
 {
-       /* Write me */
+	struct task_struct *p = container_of(work, struct task_struct, sched_throttle_work);
+	struct sched_entity *se;
+	struct rq *rq;
+	struct cfs_rq *cfs_rq;
+
+	WARN_ON_ONCE(p != current);
+	p->sched_throttle_work.next = &p->sched_throttle_work;
+	/*
+	 * If task is exiting, then there won't be a return to userspace, so we
+	 * don't have to bother with any of this.
+	 */
+	if ((p->flags & PF_EXITING))
+		return;
+
+	CLASS(task_rq_lock, rq_guard)(p);
+	rq = rq_guard.rq;
+	se = &p->se;
+	cfs_rq = cfs_rq_of(se);
+
+	/*
+	 * If not in limbo, then either replenish has happened or this task got
+	 * migrated out of the throttled cfs_rq, move along
+	 */
+	if (!cfs_rq->throttle_count)
+		return;
+
+	update_rq_clock(rq);
+
+	throttle_one_task(cfs_rq, p);
+
+	resched_curr(rq);
 }
 
 static void task_woken_fair(struct rq *rq, struct task_struct *p)
@@ -5792,6 +6068,7 @@ void init_cfs_throttle_work(struct task_struct *p)
 	/* Protect against double add, see throttle_cfs_rq() and throttle_cfs_rq_work() */
 	p->sched_throttle_work.next = &p->sched_throttle_work;
 	init_task_work(&p->sched_throttle_work, throttle_cfs_rq_work);
+	INIT_LIST_HEAD(&p->throttle_node);
 	p->unthrottle_irq_work = IRQ_WORK_INIT_HARD(task_throttle_cancel_irq_work_fn);
 }
 
@@ -5799,8 +6076,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-	struct sched_entity *se;
-	long task_delta, idle_task_delta, dequeue = 1;
+	long dequeue = 1;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5818,70 +6094,24 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		list_add_tail_rcu(&cfs_rq->throttled_list,
 				  &cfs_b->throttled_cfs_rq);
 	}
+
 	raw_spin_unlock(&cfs_b->lock);
 
 	if (!dequeue)
 		return false;  /* Throttle no longer required. */
 
-	se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
-
-	/* freeze hierarchy runnable averages while throttled */
+	/* Flag the hierarchy for throttle-at-user-entry */
 	rcu_read_lock();
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
 	rcu_read_unlock();
 
-	task_delta = cfs_rq->h_nr_running;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-		/* throttled entity or throttle-on-deactivate */
-		if (!se->on_rq)
-			goto done;
-
-		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
-
-		qcfs_rq->h_nr_running -= task_delta;
-		qcfs_rq->idle_h_nr_running -= idle_task_delta;
-
-		if (qcfs_rq->load.weight) {
-			/* Avoid re-evaluating load for this entity: */
-			se = parent_entity(se);
-			break;
-		}
-	}
-
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-		/* throttled entity or throttle-on-deactivate */
-		if (!se->on_rq)
-			goto done;
-
-		update_load_avg(qcfs_rq, se, 0);
-		se_update_runnable(se);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
-
-		qcfs_rq->h_nr_running -= task_delta;
-		qcfs_rq->idle_h_nr_running -= idle_task_delta;
-	}
-
-	/* At this point se is NULL and we are at root level*/
-	sub_nr_running(rq, task_delta);
-
-done:
-	/*
-	 * Note: distribution will already see us throttled via the
-	 * throttled-list.  rq->lock protects completion.
-	 */
 	cfs_rq->throttled = 1;
+
 	SCHED_WARN_ON(cfs_rq->throttled_clock);
 	if (cfs_rq->nr_running)
 		cfs_rq->throttled_clock = rq_clock(rq);
-	return true;
+
+	return false;
 }
 
 void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
@@ -5922,25 +6152,17 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		goto unthrottle_throttle;
 	}
 
-	task_delta = cfs_rq->h_nr_running;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-
-		if (se->on_rq)
-			break;
-		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+	if (cfs_rq->throttle_count)
+		return;
 
-		qcfs_rq->h_nr_running += task_delta;
-		qcfs_rq->idle_h_nr_running += idle_task_delta;
+	/*
+	 * cfs_rq's below us may not have been fully emptied out, so we can't rely
+	 * directly on ->h_nr_running. Use the stash instead.
+	 */
+	task_delta = cfs_rq->unthrottled_h_nr_running;
+	idle_task_delta = cfs_rq->unthrottled_idle_h_nr_running;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
-			goto unthrottle_throttle;
-	}
+	walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_clear_up, (void *)rq);
 
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
@@ -5948,15 +6170,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		update_load_avg(qcfs_rq, se, UPDATE_TG);
 		se_update_runnable(se);
 
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
-
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
-			goto unthrottle_throttle;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6455,6 +6670,7 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	cfs_rq->runtime_enabled = 0;
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
 	INIT_LIST_HEAD(&cfs_rq->throttled_csd_list);
+	INIT_LIST_HEAD(&cfs_rq->throttled_limbo_list);
 }
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
@@ -6822,10 +7038,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
-
 		flags = ENQUEUE_WAKEUP;
 	}
 
@@ -6841,10 +7053,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6867,7 +7075,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		check_update_overutilized_status(rq);
 
-enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
@@ -6900,10 +7107,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto dequeue_throttle;
-
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -6932,10 +7135,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto dequeue_throttle;
-
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6945,7 +7144,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
-dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -12815,9 +13013,6 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-	if (cfs_rq_throttled(cfs_rq))
-		return;
-
 	if (!throttled_hierarchy(cfs_rq))
 		list_add_leaf_cfs_rq(cfs_rq);
 
@@ -12829,9 +13024,6 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		if (cfs_rq_throttled(cfs_rq))
-			break;
-
 		if (!throttled_hierarchy(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 943bca8263ffe..f4a00b1dd9505 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -690,8 +690,12 @@ struct cfs_rq {
 	u64			throttled_clock_self_time;
 	int			throttled;
 	int			throttle_count;
+	/* Temp storage for updating the counts during unthrottling */
+	unsigned int            unthrottled_h_nr_running;
+	unsigned int            unthrottled_idle_h_nr_running;
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;
+	struct list_head	throttled_limbo_list;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
-- 
2.43.0

