Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6339421235
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768897; cv=none; b=LrIvWHuFp6BxONE5FSXV1D9peYqy1V2uBx15yfi3s3z7TQD58mvcGtJW4kRegWAN9OE2Qw7RSn+NpNDfVP3UzIDtr5rZGNYtum9Q9n7wRSVQtKMfr2uSbbENd7okVnrwRmlFeZVh0Kxv9gc1afTjp8VHfksWeM0Gp8lKvHZI2xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768897; c=relaxed/simple;
	bh=GYHf+zbpJIbN8wdET2m2KoX50bTFoVYyZ6SIH+UzDwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GL+MyXQVz9TbclIE5+dPzOr40XlQ09H2qgpQuONpxC8pXUYHndZyjibHtTe/Ep54hw4SigxHJUr9zoigbcLUVLMjwRi/BiGmgotpPcyag8YI6jNS8YgJAuwTEzPhPCcEOGlYsAtAyKG4Hkd5SyfX5A1z4viUjMr8qS/2IVpHfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IK19lLt3; arc=none smtp.client-ip=91.218.175.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IK19lLt3"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GYHf+zbpJIbN8wdET2m2KoX50bTFoVYyZ6SIH+UzDwc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788768893; v=1; x=1789373693;
 b=IK19lLt3RNhYH68ocEIktoMXlTKmsbtOmPmpyDQFNth/wOqvSaB7UimEnHmi81y5XUfTIvwb
 kKKcLzcqR7McNFASai1GURu9fB3QBwYl8KS2twuyvQUTMw7KgSZP295bAN8RXc1oUjTU5fNebjS
 eABgGH/ib6letISwgKAGFn/0=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 70f3f824a87c0db2;
	Mon, 07 Sep 2026 08:14:52 +0000
X-Mizu-Trace-ID: 70f3f824a87c0db2
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	mic@digikod.net,
	oleg@redhat.com,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	gnoack3000@gmail.com,
	ljs@kernel.org,
	sj@kernel.org,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	x86@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	pavel@kernel.org,
	lance.yang@linux.dev,
	pmladek@suse.com,
	longman@redhat.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	mark.rutland@arm.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 5/8] kernel: convert process/thread iterators to for_each_*_rculock
Date: Mon,  7 Sep 2026 16:13:31 +0800
Message-Id: <20260907081334.1152889-6-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260907081334.1152889-1-ye.liu@linux.dev>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ye Liu <liuye@kylinos.cn>

Replace the manual rcu_read_lock()/rcu_read_unlock() and guard(rcu)
pairs combined with for_each_process(), for_each_thread() and
for_each_process_thread() loops across kernel/ with the
for_each_*_rculock() macros, which scope the RCU read lock to the
loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
---
Changes in v2:
  - Rename *_rcu to *_rculock
  - Rename stale 'unlock:' label to 'out:' in hung_task.c (Günther Noack)
 kernel/cpu.c             |  4 +---
 kernel/freezer.c         |  4 +---
 kernel/hung_task.c       | 11 ++++-------
 kernel/locking/lockdep.c |  4 +---
 kernel/rcu/update.c      |  4 +---
 kernel/sched/core.c      |  3 +--
 kernel/sched/debug.c     |  4 +---
 kernel/trace/fgraph.c    |  8 ++------
 kernel/unwind/deferred.c |  3 +--
 9 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index b3c8553d7bd6..00638d2abc0f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1254,8 +1254,7 @@ void clear_tasks_mm_cpumask(int cpu)
 	 * full-fledged tasklist_lock.
 	 */
 	WARN_ON(cpu_online(cpu));
-	rcu_read_lock();
-	for_each_process(p) {
+	for_each_process_rculock(p) {
 		struct task_struct *t;
 
 		/*
@@ -1268,7 +1267,6 @@ void clear_tasks_mm_cpumask(int cpu)
 		arch_clear_mm_cpumask_cpu(cpu, t->mm);
 		task_unlock(t);
 	}
-	rcu_read_unlock();
 }
 
 /* Take this CPU down. */
diff --git a/kernel/freezer.c b/kernel/freezer.c
index a76bf957fb32..7a870f71dcf6 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -217,11 +217,9 @@ void thaw_process(struct task_struct *p)
 {
 	struct task_struct *t;
 
-	rcu_read_lock();
-	for_each_thread(p, t) {
+	for_each_thread_rculock(p, t) {
 		__thaw_task(t);
 	}
-	rcu_read_unlock();
 }
 
 /**
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 6fcc94ce4ca9..73a5ad3be9a8 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -315,13 +315,12 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 		return;
 
 	this_round_count = 0;
-	rcu_read_lock();
-	for_each_process_thread(g, t) {
+	for_each_process_thread_rculock(g, t) {
 		if (!max_count--)
-			goto unlock;
+			goto out;
 		if (time_after(jiffies, last_break + HUNG_TASK_LOCK_BREAK)) {
 			if (!rcu_lock_break(g, t))
-				goto unlock;
+				goto out;
 			last_break = jiffies;
 		}
 
@@ -337,9 +336,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 			hung_task_info(t, timeout, this_round_count);
 		}
 	}
- unlock:
-	rcu_read_unlock();
-
+out:
 	if (!this_round_count)
 		return;
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c56a7f91d72e..ea218dc75ad5 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6834,15 +6834,13 @@ void debug_show_all_locks(void)
 	}
 	pr_warn("\nShowing all locks held in the system:\n");
 
-	rcu_read_lock();
-	for_each_process_thread(g, p) {
+	for_each_process_thread_rculock(g, p) {
 		if (!p->lockdep_depth)
 			continue;
 		lockdep_print_held_locks(p);
 		touch_nmi_watchdog();
 		touch_all_softlockup_watchdogs();
 	}
-	rcu_read_unlock();
 
 	pr_warn("\n");
 	pr_warn("=============================================\n\n");
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 2a778b8ab4ad..d8e0b5896db9 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -548,15 +548,13 @@ void synchronize_rcu_trivial_preempt(void)
 	struct task_struct *t;
 
 	smp_mb(); // Order prior accesses before grace-period start.
-	rcu_read_lock(); // Protect task list.
-	for_each_process_thread(g, t) {
+	for_each_process_thread_rculock(g, t) {
 		if (t == current)
 			continue;  // Don't deadlock on ourselves!
 		// Order later rcu_read_lock() on other tasks after QS.
 		while (smp_load_acquire(&t->rcu_trivial_preempt_nesting))
 			continue;
 	}
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_trivial_preempt);
 #endif // #if IS_ENABLED(CONFIG_TRIVIAL_PREEMPT_RCU)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0697ed0f1c3d..fd5bdd2cb798 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2005,8 +2005,7 @@ static void uclamp_sync_util_min_rt_default(void)
 	smp_mb__after_spinlock();
 	read_unlock(&tasklist_lock);
 
-	guard(rcu)();
-	for_each_process_thread(g, p)
+	for_each_process_thread_rculock(g, p)
 		uclamp_update_util_min_rt_default(p);
 }
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 72236db67983..cdae165b98f7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1029,14 +1029,12 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 #endif
 		   "\n");
 
-	rcu_read_lock();
-	for_each_process_thread(g, p) {
+	for_each_process_thread_rculock(g, p) {
 		if (task_cpu(p) != rq_cpu)
 			continue;
 
 		print_task(m, rq, p);
 	}
-	rcu_read_unlock();
 }
 
 void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 40d373d65f9b..f797ce119223 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1057,11 +1057,10 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 		}
 	}
 
-	rcu_read_lock();
-	for_each_process_thread(g, t) {
+	for_each_process_thread_rculock(g, t) {
 		if (start == end) {
 			ret = -EAGAIN;
-			goto unlock;
+			goto free;
 		}
 
 		if (t->ret_stack == NULL) {
@@ -1074,9 +1073,6 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 			t->ret_stack = ret_stack_list[start++];
 		}
 	}
-
-unlock:
-	rcu_read_unlock();
 free:
 	for (i = start; i < end; i++)
 		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 5bea47314254..ecfe1336095e 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -319,9 +319,8 @@ void unwind_deferred_cancel(struct unwind_work *work)
 
 	synchronize_srcu(&unwind_srcu);
 
-	guard(rcu)();
 	/* Clear this bit from all threads */
-	for_each_process_thread(g, t) {
+	for_each_process_thread_rculock(g, t) {
 		atomic_long_andnot(BIT(bit),
 				   &t->unwind_info.unwind_mask);
 		if (t->unwind_info.cache)
-- 
2.25.1

