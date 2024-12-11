Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9131D9324;
	Wed, 11 Dec 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931673; cv=none; b=PtuwsDLPVwTI0e1ajIDepczRGjKZojlITizXyEURGDTjLJQMJ6muwyXIoMOWVpce8M4KLegdDsIFF9h1zTBK7bI+rksUnxbO9yAvArJNTsuwVSfTqW267wIZz50tKcqYRjUnSC0Q/oG8E+pW1k7e81s1eJLzHhUHrGV9wzAALXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931673; c=relaxed/simple;
	bh=Zl9E3LG4ePzB3S1zktQqMaaRMvPxhBEbf67CVv5m/KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InGm8kz/Qgo11HlLHDqh+TiofZmtabatqY0sJ8qyLMV/o0k87YInUsAsJl06AW9FB3DJGMDrKeuw3EmdR0yTAzJSF9pUEcolCWAzWrF6MgoJtUblw58jSbZBDwPJ/1ezVd4vuT04DraFLg3rQMQ6Lwg2E+HuHkwboN6/enXULVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHTxkkVn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHTxkkVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD8BC4CEDE;
	Wed, 11 Dec 2024 15:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931673;
	bh=Zl9E3LG4ePzB3S1zktQqMaaRMvPxhBEbf67CVv5m/KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHTxkkVnesefVanc4+eZ3LWwfNJWnYX7m658TiDwNSPmtX/3AnFpkbX4TrJ/ImQy4
	 Hu4WVheUhsjZawEfpaSNjDmofDHG5tL8WAJgb9pFg0vauoXffLb/bjDBeXVP/ymgrU
	 KJyu5XUCrwo0usqm95LRig9tq26ZTpe/WlQb8Wbf2RsIkj4GLJlDVQTjZfIPIL+cZ9
	 tX08hMyrBYYVU32XsWlR3jaEdJkBbRiQkecnHN9+b9UVv/zxjT7HbRNknY0gLixVD+
	 Bz66hGcuGvyv1oHODsCFMOSYEwWtYO3HEfm+O5JppuSLhmsIA0tbIF2YFQtCWwckYE
	 o1Iw05m/KSfCg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org
Subject: [PATCH 12/19] kthread: Default affine kthread to its preferred NUMA node
Date: Wed, 11 Dec 2024 16:40:25 +0100
Message-ID: <20241211154035.75565-13-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211154035.75565-1-frederic@kernel.org>
References: <20241211154035.75565-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kthreads attached to a preferred NUMA node for their task structure
allocation can also be assumed to run preferrably within that same node.

A more precise affinity is usually notified by calling
kthread_create_on_cpu() or kthread_bind[_mask]() before the first wakeup.

For the others, a default affinity to the node is desired and sometimes
implemented with more or less success when it comes to deal with hotplug
events and nohz_full / CPU Isolation interactions:

- kcompactd is affine to its node and handles hotplug but not CPU Isolation
- kswapd is affine to its node and ignores hotplug and CPU Isolation
- A bunch of drivers create their kthreads on a specific node and
  don't take care about affining further.

Handle that default node affinity preference at the generic level
instead, provided a kthread is created on an actual node and doesn't
apply any specific affinity such as a given CPU or a custom cpumask to
bind to before its first wake-up.

This generic handling is aware of CPU hotplug events and CPU isolation
such that:

* When a housekeeping CPU goes up that is part of the node of a given
  kthread, the related task is re-affined to that own node if it was
  previously running on the default last resort online housekeeping set
  from other nodes.

* When a housekeeping CPU goes down while it was part of the node of a
  kthread, the running task is migrated (or the sleeping task is woken
  up) automatically by the scheduler to other housekeepers within the
  same node or, as a last resort, to all housekeepers from other nodes.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/cpuhotplug.h |   1 +
 kernel/kthread.c           | 106 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index a04b73c40173..6cc5e484547c 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -240,6 +240,7 @@ enum cpuhp_state {
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RANDOM_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
+	CPUHP_AP_KTHREADS_ONLINE,
 	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 40,
diff --git a/kernel/kthread.c b/kernel/kthread.c
index b6f9ce475a4f..3394ff024a5a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -35,6 +35,9 @@ static DEFINE_SPINLOCK(kthread_create_lock);
 static LIST_HEAD(kthread_create_list);
 struct task_struct *kthreadd_task;
 
+static LIST_HEAD(kthreads_hotplug);
+static DEFINE_MUTEX(kthreads_hotplug_lock);
+
 struct kthread_create_info
 {
 	/* Information passed to kthread() from kthreadd. */
@@ -53,6 +56,7 @@ struct kthread_create_info
 struct kthread {
 	unsigned long flags;
 	unsigned int cpu;
+	unsigned int node;
 	int started;
 	int result;
 	int (*threadfn)(void *);
@@ -64,6 +68,8 @@ struct kthread {
 #endif
 	/* To store the full name if task comm is truncated. */
 	char *full_name;
+	struct task_struct *task;
+	struct list_head hotplug_node;
 };
 
 enum KTHREAD_BITS {
@@ -122,8 +128,11 @@ bool set_kthread_struct(struct task_struct *p)
 
 	init_completion(&kthread->exited);
 	init_completion(&kthread->parked);
+	INIT_LIST_HEAD(&kthread->hotplug_node);
 	p->vfork_done = &kthread->exited;
 
+	kthread->task = p;
+	kthread->node = tsk_fork_get_node(current);
 	p->worker_private = kthread;
 	return true;
 }
@@ -314,6 +323,11 @@ void __noreturn kthread_exit(long result)
 {
 	struct kthread *kthread = to_kthread(current);
 	kthread->result = result;
+	if (!list_empty(&kthread->hotplug_node)) {
+		mutex_lock(&kthreads_hotplug_lock);
+		list_del(&kthread->hotplug_node);
+		mutex_unlock(&kthreads_hotplug_lock);
+	}
 	do_exit(0);
 }
 EXPORT_SYMBOL(kthread_exit);
@@ -339,6 +353,48 @@ void __noreturn kthread_complete_and_exit(struct completion *comp, long code)
 }
 EXPORT_SYMBOL(kthread_complete_and_exit);
 
+static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpumask)
+{
+	cpumask_and(cpumask, cpumask_of_node(kthread->node),
+		    housekeeping_cpumask(HK_TYPE_KTHREAD));
+
+	if (cpumask_empty(cpumask))
+		cpumask_copy(cpumask, housekeeping_cpumask(HK_TYPE_KTHREAD));
+}
+
+static void kthread_affine_node(void)
+{
+	struct kthread *kthread = to_kthread(current);
+	cpumask_var_t affinity;
+
+	WARN_ON_ONCE(kthread_is_per_cpu(current));
+
+	if (kthread->node == NUMA_NO_NODE) {
+		housekeeping_affine(current, HK_TYPE_KTHREAD);
+	} else {
+		if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
+			WARN_ON_ONCE(1);
+			return;
+		}
+
+		mutex_lock(&kthreads_hotplug_lock);
+		WARN_ON_ONCE(!list_empty(&kthread->hotplug_node));
+		list_add_tail(&kthread->hotplug_node, &kthreads_hotplug);
+		/*
+		 * The node cpumask is racy when read from kthread() but:
+		 * - a racing CPU going down will either fail on the subsequent
+		 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
+		 *   afterwards by the scheduler.
+		 * - a racing CPU going up will be handled by kthreads_online_cpu()
+		 */
+		kthread_fetch_affinity(kthread, affinity);
+		set_cpus_allowed_ptr(current, affinity);
+		mutex_unlock(&kthreads_hotplug_lock);
+
+		free_cpumask_var(affinity);
+	}
+}
+
 static int kthread(void *_create)
 {
 	static const struct sched_param param = { .sched_priority = 0 };
@@ -369,7 +425,6 @@ static int kthread(void *_create)
 	 * back to default in case they have been changed.
 	 */
 	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
-	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_KTHREAD));
 
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
@@ -385,6 +440,9 @@ static int kthread(void *_create)
 
 	self->started = 1;
 
+	if (!(current->flags & PF_NO_SETAFFINITY))
+		kthread_affine_node();
+
 	ret = -EINTR;
 	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
 		cgroup_kthread_ready();
@@ -781,6 +839,52 @@ int kthreadd(void *unused)
 	return 0;
 }
 
+/*
+ * Re-affine kthreads according to their preferences
+ * and the newly online CPU. The CPU down part is handled
+ * by select_fallback_rq() which default re-affines to
+ * housekeepers in case the preferred affinity doesn't
+ * apply anymore.
+ */
+static int kthreads_online_cpu(unsigned int cpu)
+{
+	cpumask_var_t affinity;
+	struct kthread *k;
+	int ret;
+
+	guard(mutex)(&kthreads_hotplug_lock);
+
+	if (list_empty(&kthreads_hotplug))
+		return 0;
+
+	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
+		return -ENOMEM;
+
+	ret = 0;
+
+	list_for_each_entry(k, &kthreads_hotplug, hotplug_node) {
+		if (WARN_ON_ONCE((k->task->flags & PF_NO_SETAFFINITY) ||
+				 kthread_is_per_cpu(k->task) ||
+				 k->node == NUMA_NO_NODE)) {
+			ret = -EINVAL;
+			continue;
+		}
+		kthread_fetch_affinity(k, affinity);
+		set_cpus_allowed_ptr(k->task, affinity);
+	}
+
+	free_cpumask_var(affinity);
+
+	return ret;
+}
+
+static int kthreads_init(void)
+{
+	return cpuhp_setup_state(CPUHP_AP_KTHREADS_ONLINE, "kthreads:online",
+				kthreads_online_cpu, NULL);
+}
+early_initcall(kthreads_init);
+
 void __kthread_init_worker(struct kthread_worker *worker,
 				const char *name,
 				struct lock_class_key *key)
-- 
2.46.0

