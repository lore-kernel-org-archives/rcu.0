Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574F1442F2;
	Wed,  7 Aug 2024 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046591; cv=none; b=amT4tV+lu43qKud3hlhze1DWHJLiu/eqxQyG8lSG1zaQKRQwb+FKuc9rbvgoufoYzJMh04/QYSO9NtB8Qic+hCHD1bCa889CuysNbOeZFhgl9u6eb2cDjvCjeqcmO5MfYe1jy67uIZZPYxzGUGsby5bvEQacjAl7fMQ+J1D8GLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046591; c=relaxed/simple;
	bh=Rrk8ndlaediFaYaEu8Vy9mx3y5m6nelHltTuw6hlLeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rk+vD+rofYHZIX1gVjvt9wt8h28PAwcC6JHZIj/23RR4GixjTnLWm9+hxABuWoNgkHNakHUttCka6Do+KwRODmGQ2SMIIfv7dGqLPRezkLfmb4DCaSw0QiRIBvYeVmfKEeqiywpfxDL9Vag/7aoVIdQjLuEp8n9o0sl3DJUqDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPmXmXay; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPmXmXay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FD0C4AF12;
	Wed,  7 Aug 2024 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046590;
	bh=Rrk8ndlaediFaYaEu8Vy9mx3y5m6nelHltTuw6hlLeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPmXmXaymg6t7h15lBu/3348hOVNH5ElKYhXHPEkQknD8Gta7FRz1QHhhqgDuQU23
	 NgW/Qdu+u0YdOY8PpwLigl2vICH99j9y1zxtKqaD5munJXZbgu6an7v5YWKpgh2xcS
	 7Rar4jmX9SJu92hRuWgDjkYEMHe2pZTxChm6/2jxTSHYImSlYvAlbkDAjpwBziKLcV
	 qJIW6cC1/+XPlG0bPetzb4TIGh+LNUk050iua84tVm7w+MW7m6vdzSTfn0NL2PET7d
	 XGrnyHz3gWXYTrA5QwilPeG2taSn4C8BhmEDh1rL90FW5uvaWq6HLzvge98EN6e01Q
	 9jqdbPtEBjZlg==
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
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org
Subject: [PATCH 12/19] kthread: Default affine kthread to its preferred NUMA node
Date: Wed,  7 Aug 2024 18:02:18 +0200
Message-ID: <20240807160228.26206-13-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807160228.26206-1-frederic@kernel.org>
References: <20240807160228.26206-1-frederic@kernel.org>
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

* When a housekeeping CPU goes up and is part of the node of a given
  kthread, it is added to its applied affinity set (and
  possibly the default last resort online housekeeping set is removed
  from the set).

* When a housekeeping CPU goes down while it was part of the node of a
  kthread, it is removed from the kthread's applied
  affinity. The last resort is to affine the kthread to all online
  housekeeping CPUs.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/cpuhotplug.h |   1 +
 kernel/kthread.c           | 120 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 9316c39260e0..89d852538b72 100644
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
index ecb719f54f7a..eee5925e7725 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -35,6 +35,10 @@ static DEFINE_SPINLOCK(kthread_create_lock);
 static LIST_HEAD(kthread_create_list);
 struct task_struct *kthreadd_task;
 
+static struct cpumask kthread_online_mask;
+static LIST_HEAD(kthreads_hotplug);
+static DEFINE_MUTEX(kthreads_hotplug_lock);
+
 struct kthread_create_info
 {
 	/* Information passed to kthread() from kthreadd. */
@@ -53,6 +57,7 @@ struct kthread_create_info
 struct kthread {
 	unsigned long flags;
 	unsigned int cpu;
+	unsigned int node;
 	int started;
 	int result;
 	int (*threadfn)(void *);
@@ -64,6 +69,8 @@ struct kthread {
 #endif
 	/* To store the full name if task comm is truncated. */
 	char *full_name;
+	struct task_struct *task;
+	struct list_head hotplug_node;
 };
 
 enum KTHREAD_BITS {
@@ -122,8 +129,11 @@ bool set_kthread_struct(struct task_struct *p)
 
 	init_completion(&kthread->exited);
 	init_completion(&kthread->parked);
+	INIT_LIST_HEAD(&kthread->hotplug_node);
 	p->vfork_done = &kthread->exited;
 
+	kthread->task = p;
+	kthread->node = tsk_fork_get_node(current);
 	p->worker_private = kthread;
 	return true;
 }
@@ -314,6 +324,13 @@ void __noreturn kthread_exit(long result)
 {
 	struct kthread *kthread = to_kthread(current);
 	kthread->result = result;
+	if (!list_empty(&kthread->hotplug_node)) {
+		mutex_lock(&kthreads_hotplug_lock);
+		list_del(&kthread->hotplug_node);
+		/* Make sure the kthread never gets re-affined globally */
+		set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_KTHREAD));
+		mutex_unlock(&kthreads_hotplug_lock);
+	}
 	do_exit(0);
 }
 EXPORT_SYMBOL(kthread_exit);
@@ -339,6 +356,45 @@ void __noreturn kthread_complete_and_exit(struct completion *comp, long code)
 }
 EXPORT_SYMBOL(kthread_complete_and_exit);
 
+static void kthread_fetch_affinity(struct kthread *k, struct cpumask *mask)
+{
+	if (k->node == NUMA_NO_NODE) {
+		cpumask_copy(mask, housekeeping_cpumask(HK_TYPE_KTHREAD));
+	} else {
+		/*
+		 * The node cpumask is racy when read from kthread() but:
+		 * - a racing CPU going down won't be present in kthread_online_mask
+		 * - a racing CPU going up will be handled by kthreads_online_cpu()
+		 */
+		cpumask_and(mask, cpumask_of_node(k->node), &kthread_online_mask);
+		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_KTHREAD));
+		if (cpumask_empty(mask))
+			cpumask_copy(mask, housekeeping_cpumask(HK_TYPE_KTHREAD));
+	}
+}
+
+static int kthread_affine_node(void)
+{
+	struct kthread *kthread = to_kthread(current);
+	cpumask_var_t affinity;
+
+	WARN_ON_ONCE(kthread_is_per_cpu(current));
+
+	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
+		return -ENOMEM;
+
+	mutex_lock(&kthreads_hotplug_lock);
+	WARN_ON_ONCE(!list_empty(&kthread->hotplug_node));
+	list_add_tail(&kthread->hotplug_node, &kthreads_hotplug);
+	kthread_fetch_affinity(kthread, affinity);
+	set_cpus_allowed_ptr(current, affinity);
+	mutex_unlock(&kthreads_hotplug_lock);
+
+	free_cpumask_var(affinity);
+
+	return 0;
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
@@ -779,6 +837,66 @@ int kthreadd(void *unused)
 	return 0;
 }
 
+static int kthreads_hotplug_update(void)
+{
+	cpumask_var_t affinity;
+	struct kthread *k;
+	int err;
+
+	if (list_empty(&kthreads_hotplug))
+		return 0;
+
+	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = 0;
+
+	list_for_each_entry(k, &kthreads_hotplug, hotplug_node) {
+		if (WARN_ON_ONCE((k->task->flags & PF_NO_SETAFFINITY) ||
+				 kthread_is_per_cpu(k->task))) {
+			err = -EINVAL;
+			continue;
+		}
+		kthread_fetch_affinity(k, affinity);
+		set_cpus_allowed_ptr(k->task, affinity);
+	}
+
+	free_cpumask_var(affinity);
+
+	return err;
+}
+
+static int kthreads_offline_cpu(unsigned int cpu)
+{
+	int ret = 0;
+
+	mutex_lock(&kthreads_hotplug_lock);
+	cpumask_clear_cpu(cpu, &kthread_online_mask);
+	ret = kthreads_hotplug_update();
+	mutex_unlock(&kthreads_hotplug_lock);
+
+	return ret;
+}
+
+static int kthreads_online_cpu(unsigned int cpu)
+{
+	int ret = 0;
+
+	mutex_lock(&kthreads_hotplug_lock);
+	cpumask_set_cpu(cpu, &kthread_online_mask);
+	ret = kthreads_hotplug_update();
+	mutex_unlock(&kthreads_hotplug_lock);
+
+	return ret;
+}
+
+static int kthreads_init(void)
+{
+	return cpuhp_setup_state(CPUHP_AP_KTHREADS_ONLINE, "kthreads:online",
+				kthreads_online_cpu, kthreads_offline_cpu);
+}
+early_initcall(kthreads_init);
+
 void __kthread_init_worker(struct kthread_worker *worker,
 				const char *name,
 				struct lock_class_key *key)
-- 
2.45.2

