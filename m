Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103114F12C;
	Fri, 26 Jul 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031058; cv=none; b=Krf7b9fZ8IrKfiSEsz6Z7pNxwfC0J8rY8e0IMC45PhPNiR7Sb/l7FnyxHZpSYYOqeUFuvZKSXOjo938Oi3/2ubMiAXD/zM8WTzrzA43Ox2NPnlTgKu9yFy3G92w1z97NfKeapwFOR7gx/mlocX43m7amo5tMBZ350vUr4BK8y00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031058; c=relaxed/simple;
	bh=ti4mfUgveAuqTAPPwXGYkPNNFuo7Vc9aOZIdnCtmsYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aadfqqwwZ0ngFe+2yJNnY9iCap0txTBtuCNamYXjXNTIW2Vj9VCQpTvM4dS/ZzjuWDnxOjjpCFIE1xF3VWgcE6abBX3ff5OtFqzmgw+6xIwWOmtkgRwXZKRdIJFfMy46aO/vdlD+0udVzX0RTcPatZRm2947zXU/caZCAyrjFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heNYtWqP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heNYtWqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCB0C4AF0B;
	Fri, 26 Jul 2024 21:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031057;
	bh=ti4mfUgveAuqTAPPwXGYkPNNFuo7Vc9aOZIdnCtmsYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=heNYtWqPzI279b23ynorkZtq9s+XtrGZuDGs5HGiedBJIbhqIYfZlNLZbVnJRlGWb
	 OoIJj85ZxFgF5Pf0IoPAk1ly5fkb/U6UyuT5cW0GnVsadONHBpy7j2gDi7LQybe50+
	 I4fHIxGYUhytu7KJ87eKYGc87z8Mzg0xc3xy96B3iDivajwqofkWVWVJujy2Gx3XVF
	 a2bFKPz4bsNe5kK7YlfbJU6R/0i7zEH59l/Er15+P8rBvDbO2OVJ0sx5U7dcnX1D2n
	 wWZXB/LQV7ncN0jrEUJxS/KDWlj6z3hX0I+H0asvSQRZgwj5QmDkOnsHlYVNJPc5yU
	 wB+175sFPcwyQ==
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
Subject: [RFC PATCH 12/20] kthread: Implement preferred affinity
Date: Fri, 26 Jul 2024 23:56:48 +0200
Message-ID: <20240726215701.19459-13-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726215701.19459-1-frederic@kernel.org>
References: <20240726215701.19459-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Affining kthreads follow either of three existing different patterns:

1) Per-CPU kthreads must stay affine to a single CPU and never execute
   relevant code on any other CPU. This is currently handled by smpboot
   code which takes care of CPU-hotplug operations.

2) Kthreads that _have_ to be affine to a specific set of CPUs and can't
   run anywhere else. The affinity is set through kthread_bind_mask()
   and the subsystem takes care by itself to handle CPU-hotplug operations.

3) Kthreads that have a _preferred_ affinity but that can run anywhere
   without breaking correctness. Userspace can overwrite the affinity.
   It is set manually like any other task and CPU-hotplug is supposed
   to be handled by the relevant subsystem so that the task is properly
   reaffined whenever a given CPU from the preferred affinity comes up
   or down. Also care must be taken so that the preferred affinity
   doesn't cross housekeeping cpumask boundaries.

Currently the preferred affinity pattern has at least 4 identified
users, with more or less success when it comes to handle CPU-hotplug
operations and housekeeping cpumask.

Provide an infrastructure to handle this usecase patter. A new
kthread_affine_preferred() API is introduced, to be used just like
kthread_bind_mask(), right after kthread creation and before the first
wake up. The kthread is then affine right away to the cpumask passed
through the API if it has online housekeeping CPUs. Otherwise it will
be affine to all online housekeeping CPUs as a last resort.

It is aware of CPU hotplug events such that:

* When a housekeeping CPU goes up and is part of the preferred affinity
  of a given kthread, it is added to its applied affinity set (and
  possibly the default last resort online housekeeping set is removed
  from the set).

* When a housekeeping CPU goes down while it was part of the preferred
  affinity of a kthread, it is removed from the kthread's applied
  affinity. The last resort is to affine the kthread to all online
  housekeeping CPUs.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/cpuhotplug.h |   1 +
 include/linux/kthread.h    |   1 +
 kernel/kthread.c           | 121 +++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 7a5785f405b6..5c204bd0fed6 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -238,6 +238,7 @@ enum cpuhp_state {
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RANDOM_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
+	CPUHP_AP_KTHREADS_ONLINE,
 	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 40,
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index b11f53c1ba2e..30209bdf83a2 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -85,6 +85,7 @@ kthread_run_on_cpu(int (*threadfn)(void *data), void *data,
 void free_kthread_struct(struct task_struct *k);
 void kthread_bind(struct task_struct *k, unsigned int cpu);
 void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
+int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask);
 int kthread_stop(struct task_struct *k);
 int kthread_stop_put(struct task_struct *k);
 bool kthread_should_stop(void);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index ecb719f54f7a..cfa6e1b8d933 100644
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
@@ -64,6 +68,9 @@ struct kthread {
 #endif
 	/* To store the full name if task comm is truncated. */
 	char *full_name;
+	struct task_struct *task;
+	struct list_head hotplug_node;
+	struct cpumask *preferred_affinity;
 };
 
 enum KTHREAD_BITS {
@@ -124,6 +131,7 @@ bool set_kthread_struct(struct task_struct *p)
 	init_completion(&kthread->parked);
 	p->vfork_done = &kthread->exited;
 
+	kthread->task = p;
 	p->worker_private = kthread;
 	return true;
 }
@@ -314,6 +322,16 @@ void __noreturn kthread_exit(long result)
 {
 	struct kthread *kthread = to_kthread(current);
 	kthread->result = result;
+	if (kthread->preferred_affinity) {
+		mutex_lock(&kthreads_hotplug_lock);
+		list_del(&kthread->hotplug_node);
+		/* Make sure the kthread never gets re-affined globally */
+		set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_KTHREAD));
+		mutex_unlock(&kthreads_hotplug_lock);
+
+		kfree(kthread->preferred_affinity);
+		kthread->preferred_affinity = NULL;
+	}
 	do_exit(0);
 }
 EXPORT_SYMBOL(kthread_exit);
@@ -779,6 +797,109 @@ int kthreadd(void *unused)
 	return 0;
 }
 
+static void kthread_fetch_affinity(struct kthread *k, struct cpumask *mask)
+{
+	cpumask_and(mask, k->preferred_affinity, &kthread_online_mask);
+	cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_KTHREAD));
+	if (cpumask_empty(mask))
+		cpumask_copy(mask, housekeeping_cpumask(HK_TYPE_KTHREAD));
+}
+
+int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
+{
+	struct kthread *kthread = to_kthread(p);
+	cpumask_var_t affinity;
+	unsigned long flags;
+	int ret;
+
+	if (!wait_task_inactive(p, TASK_UNINTERRUPTIBLE) || kthread->started) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
+		return -ENOMEM;
+
+	kthread->preferred_affinity = kzalloc(sizeof(struct cpumask), GFP_KERNEL);
+	if (!kthread->preferred_affinity) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	mutex_lock(&kthreads_hotplug_lock);
+	cpumask_copy(kthread->preferred_affinity, mask);
+	list_add_tail(&kthread->hotplug_node, &kthreads_hotplug);
+	kthread_fetch_affinity(kthread, affinity);
+
+	/* It's safe because the task is inactive. */
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	do_set_cpus_allowed(p, mask);
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	mutex_unlock(&kthreads_hotplug_lock);
+out:
+	free_cpumask_var(affinity);
+
+	return 0;
+}
+
+static int kthreads_hotplug_update(void)
+{
+	cpumask_var_t affinity;
+	struct kthread *k;
+	int err = 0;
+
+	if (list_empty(&kthreads_hotplug))
+		return 0;
+
+	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
+		return -ENOMEM;
+
+	list_for_each_entry(k, &kthreads_hotplug, hotplug_node) {
+		if (WARN_ON_ONCE(!k->preferred_affinity)) {
+			err = -EINVAL;
+			break;
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

