Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A471B2536;
	Thu, 26 Sep 2024 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390997; cv=none; b=d7eOX6ha8z4LTfzjhEWJ9lf6dB1r7vQSWeqGAAeCfMgRwYDLR8exPJp0bhe7IdKTdZc3pVWSGHVB3RGOWCb0QdRRLqmJghacTyrv3bAsE1pjp0fqazQDgpuGms667CTreUrxtlqtqgVq6D+mCD7KEP50pRv+BWp+KAlbd45etKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390997; c=relaxed/simple;
	bh=m1Tcj1zEK+qAK6ToFK+B33y3KL3pudrwFEmXyRTSR20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFznQOQ5ngElsRGvCOjrlanV92hb7QO1WqiczLzVlXziwLiyqB2h0xgW62vMOnSKEse+u/1yf/gjFuQISuRKs6inQJZYPX/fQwO2faKgZRIJu39xUY4dTssLCV0RmQLGVAc1r+Qt/khgaS4qTY2xHBqa5+OFfcsklMcJQjdQxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWWKYk8L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWWKYk8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5996C4CED1;
	Thu, 26 Sep 2024 22:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727390997;
	bh=m1Tcj1zEK+qAK6ToFK+B33y3KL3pudrwFEmXyRTSR20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iWWKYk8L61abF7LxWDWRGHMgy+nOKnnunvJUW6jJ41wneZPY/6lNIfMOqSed6R/gW
	 jYrTjTIZIFOLj5S9/D62bKvAsDKJlVPJ2WzeTRs1NDsf+swIeolOnOhhlyqYZwrjg8
	 C3/ohAwI76aHXOJp2XqCIN+THlWHkX+Dtjz2+LU4B7XMIRnGUgqj7s9Brak89HhBCs
	 XLWJeiAf4oZhQIlBTJ63ZQvlf9wr3Mos+fhlYgs/hiXgr1bxJwGQ87/eZuQ290s0yE
	 6biSgYOA3Bmkgv2xZ+CrpL2IyvqvrMNfjI8hKSfgjFL8+HhCyyLz68L7TfR8fcZFpO
	 4sV4ZR3ULcjMQ==
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
Subject: [PATCH 16/20] kthread: Implement preferred affinity
Date: Fri, 27 Sep 2024 00:49:04 +0200
Message-ID: <20240926224910.11106-17-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926224910.11106-1-frederic@kernel.org>
References: <20240926224910.11106-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Affining kthreads follow either of four existing different patterns:

1) Per-CPU kthreads must stay affine to a single CPU and never execute
   relevant code on any other CPU. This is currently handled by smpboot
   code which takes care of CPU-hotplug operations.

2) Kthreads that _have_ to be affine to a specific set of CPUs and can't
   run anywhere else. The affinity is set through kthread_bind_mask()
   and the subsystem takes care by itself to handle CPU-hotplug operations.

3) Kthreads that prefer to be affine to a specific NUMA node. That
   preferred affinity is applied by default when an actual node ID is
   passed on kthread creation, provided the kthread is not per-CPU and
   no call to kthread_bind_mask() has been issued before the first
   wake-up.

4) Similar to the previous point but kthreads have a preferred affinity
   different than a node. It is set manually like any other task and
   CPU-hotplug is supposed to be handled by the relevant subsystem so
   that the task is properly reaffined whenever a given CPU from the
   preferred affinity comes up. Also care must be taken so that the
   preferred affinity doesn't cross housekeeping cpumask boundaries.

Provide a function to handle the last usecase, mostly reusing the
current node default affinity infrastructure. kthread_affine_preferred()
is introduced, to be used just like kthread_bind_mask(), right after
kthread creation and before the first wake up. The kthread is then
affine right away to the cpumask passed through the API if it has online
housekeeping CPUs. Otherwise it will be affine to all online
housekeeping CPUs as a last resort.

As with node affinity, it is aware of CPU hotplug events such that:

* When a housekeeping CPU goes up that is part of the preferred affinity
  of a given kthread, the related task is re-affined to that preferred
  affinity if it was previously running on the default last resort
  online housekeeping set.

* When a housekeeping CPU goes down while it was part of the preferred
  affinity of a kthread, the running task is migrated (or the sleeping
  task is woken up) automatically by the scheduler to other housekeepers
  within the preferred affinity or, as a last resort, to all
  housekeepers from other nodes.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/kthread.h |  1 +
 kernel/kthread.c        | 68 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 62 insertions(+), 7 deletions(-)

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
index 736276d313c2..91037533afda 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -70,6 +70,7 @@ struct kthread {
 	char *full_name;
 	struct task_struct *task;
 	struct list_head hotplug_node;
+	struct cpumask *preferred_affinity;
 };
 
 enum KTHREAD_BITS {
@@ -327,6 +328,11 @@ void __noreturn kthread_exit(long result)
 		mutex_lock(&kthreads_hotplug_lock);
 		list_del(&kthread->hotplug_node);
 		mutex_unlock(&kthreads_hotplug_lock);
+
+		if (kthread->preferred_affinity) {
+			kfree(kthread->preferred_affinity);
+			kthread->preferred_affinity = NULL;
+		}
 	}
 	do_exit(0);
 }
@@ -355,9 +361,17 @@ EXPORT_SYMBOL(kthread_complete_and_exit);
 
 static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpumask)
 {
-	cpumask_and(cpumask, cpumask_of_node(kthread->node),
-		    housekeeping_cpumask(HK_TYPE_KTHREAD));
+	const struct cpumask *pref;
 
+	if (kthread->preferred_affinity) {
+		pref = kthread->preferred_affinity;
+	} else {
+		if (WARN_ON_ONCE(kthread->node == NUMA_NO_NODE))
+			return;
+		pref = cpumask_of_node(kthread->node);
+	}
+
+	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_KTHREAD));
 	if (cpumask_empty(cpumask))
 		cpumask_copy(cpumask, housekeeping_cpumask(HK_TYPE_KTHREAD));
 }
@@ -440,7 +454,7 @@ static int kthread(void *_create)
 
 	self->started = 1;
 
-	if (!(current->flags & PF_NO_SETAFFINITY))
+	if (!(current->flags & PF_NO_SETAFFINITY) && !self->preferred_affinity)
 		kthread_affine_node();
 
 	ret = -EINTR;
@@ -837,12 +851,53 @@ int kthreadd(void *unused)
 	return 0;
 }
 
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
+	WARN_ON_ONCE(kthread->preferred_affinity);
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
+	WARN_ON_ONCE(!list_empty(&kthread->hotplug_node));
+	list_add_tail(&kthread->hotplug_node, &kthreads_hotplug);
+	kthread_fetch_affinity(kthread, affinity);
+
+	/* It's safe because the task is inactive. */
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	do_set_cpus_allowed(p, affinity);
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	mutex_unlock(&kthreads_hotplug_lock);
+out:
+	free_cpumask_var(affinity);
+
+	return 0;
+}
+
 /*
  * Re-affine kthreads according to their preferences
  * and the newly online CPU. The CPU down part is handled
  * by select_fallback_rq() which default re-affines to
- * housekeepers in case the preferred affinity doesn't
- * apply anymore.
+ * housekeepers from other nodes in case the preferred
+ * affinity doesn't apply anymore.
  */
 static int kthreads_online_cpu(unsigned int cpu)
 {
@@ -862,8 +917,7 @@ static int kthreads_online_cpu(unsigned int cpu)
 
 	list_for_each_entry(k, &kthreads_hotplug, hotplug_node) {
 		if (WARN_ON_ONCE((k->task->flags & PF_NO_SETAFFINITY) ||
-				 kthread_is_per_cpu(k->task) ||
-				 k->node == NUMA_NO_NODE)) {
+				 kthread_is_per_cpu(k->task))) {
 			ret = -EINVAL;
 			continue;
 		}
-- 
2.46.0

