Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA2165F1F;
	Mon, 16 Sep 2024 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726527015; cv=none; b=aVHsHqOxTBDrjHlaJs9p8pZ+E1kroLHxvXZzpEXSDGiw6goH/2QKPohtPKNCPOD7w2md0rOmi1TcPesH46keZ9/xYEPqgq7qNJtEpHUm079/qzsp6467bWPdmsCfOYZFRRtf80vzKkXmDOilRs78DKvlRERcPsB63ZYbDG//Wlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726527015; c=relaxed/simple;
	bh=P7lEwaOzaXjSDSuqvPYP44l3AVedPSv4yEdx2INBc1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2hVz2/9QGvsVN7ucI7bS1T/ENnyUZ/m+tI1Qh15Oi6kvYxJNVryme1pBV0DYf5J1XS3xei2CltBW76iDid2QeEXpWLpiMsb5EiDqZ6BoZ9HWyZBurat182F2blDPtRYGSaR+7LXQqSxAnECAuQy6eiQjtsQDWgCDs+mToDx4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTMAEhtm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTMAEhtm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFBCC4CECF;
	Mon, 16 Sep 2024 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726527015;
	bh=P7lEwaOzaXjSDSuqvPYP44l3AVedPSv4yEdx2INBc1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bTMAEhtmDWTkAFtjFel6YnKlcx7X0ChO155prgrysl4heaF1ThwtNHRBhS4FO/DMM
	 Ux5mxG2+CwHUJikekDXLAo4L4K4bNG9uz7jITDTDSvgK2DxUPM0fo2+DEZfAouY9ER
	 dilkbmfRl7MYxnJMDZ11VXPlKYkkalgBDZV6bZnjDvFwiTujQapfYK51U/C0ShCdW1
	 lx8J950jAJ+ntD//LV9vqIGtJdqw6YAFUc/xD6iR00Zgh8IUPefYuxyXgEYBIznB3j
	 O5+kRWjvVyhwf2J8vpIrrvV4C9Dky08LtfS9rNk4jcM3laxTPz7u9Qr8g0dJkvNEOY
	 MJ7YO6yx3PMcA==
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
Subject: [PATCH 15/19] kthread: Implement preferred affinity
Date: Tue, 17 Sep 2024 00:49:19 +0200
Message-ID: <20240916224925.20540-16-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916224925.20540-1-frederic@kernel.org>
References: <20240916224925.20540-1-frederic@kernel.org>
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
   preferred affinity comes up or down. Also care must be taken so that
   the preferred affinity doesn't cross housekeeping cpumask boundaries.

Provide a function to handle the last usecase, mostly reusing the
current node default affinity infrastructure. kthread_affine_preferred()
is introduced, to be used just like kthread_bind_mask(), right after
kthread creation and before the first wake up. The kthread is then
affine right away to the cpumask passed through the API if it has online
housekeeping CPUs. Otherwise it will be affine to all online
housekeeping CPUs as a last resort.

As with node affinity, it is aware of CPU hotplug events such that:

* When a housekeeping CPU goes up and is part of the preferred affinity
  of a given kthread, it is added to its applied affinity set (and
  possibly the default last resort online housekeeping set is removed
  from the set).

* When a housekeeping CPU goes down while it was part of the preferred
  affinity of a kthread, it is removed from the kthread's applied
  affinity. The last resort is to affine the kthread to all online
  housekeeping CPUs.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/kthread.h |  1 +
 kernel/kthread.c        | 69 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 62 insertions(+), 8 deletions(-)

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
index eee5925e7725..e4ffc776928a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -71,6 +71,7 @@ struct kthread {
 	char *full_name;
 	struct task_struct *task;
 	struct list_head hotplug_node;
+	struct cpumask *preferred_affinity;
 };
 
 enum KTHREAD_BITS {
@@ -330,6 +331,11 @@ void __noreturn kthread_exit(long result)
 		/* Make sure the kthread never gets re-affined globally */
 		set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_KTHREAD));
 		mutex_unlock(&kthreads_hotplug_lock);
+
+		if (kthread->preferred_affinity) {
+			kfree(kthread->preferred_affinity);
+			kthread->preferred_affinity = NULL;
+		}
 	}
 	do_exit(0);
 }
@@ -358,19 +364,25 @@ EXPORT_SYMBOL(kthread_complete_and_exit);
 
 static void kthread_fetch_affinity(struct kthread *k, struct cpumask *mask)
 {
-	if (k->node == NUMA_NO_NODE) {
-		cpumask_copy(mask, housekeeping_cpumask(HK_TYPE_KTHREAD));
-	} else {
+	const struct cpumask *pref;
+
+	if (k->preferred_affinity) {
+		pref = k->preferred_affinity;
+	} else if (k->node != NUMA_NO_NODE) {
 		/*
 		 * The node cpumask is racy when read from kthread() but:
 		 * - a racing CPU going down won't be present in kthread_online_mask
 		 * - a racing CPU going up will be handled by kthreads_online_cpu()
 		 */
-		cpumask_and(mask, cpumask_of_node(k->node), &kthread_online_mask);
-		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_KTHREAD));
-		if (cpumask_empty(mask))
-			cpumask_copy(mask, housekeeping_cpumask(HK_TYPE_KTHREAD));
+		pref = cpumask_of_node(k->node);
+	} else {
+		pref = housekeeping_cpumask(HK_TYPE_KTHREAD);
 	}
+
+	cpumask_and(mask, pref, &kthread_online_mask);
+	cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_KTHREAD));
+	if (cpumask_empty(mask))
+		cpumask_copy(mask, housekeeping_cpumask(HK_TYPE_KTHREAD));
 }
 
 static int kthread_affine_node(void)
@@ -440,7 +452,7 @@ static int kthread(void *_create)
 
 	self->started = 1;
 
-	if (!(current->flags & PF_NO_SETAFFINITY))
+	if (!(current->flags & PF_NO_SETAFFINITY) && !self->preferred_affinity)
 		kthread_affine_node();
 
 	ret = -EINTR;
@@ -837,6 +849,47 @@ int kthreadd(void *unused)
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
 static int kthreads_hotplug_update(void)
 {
 	cpumask_var_t affinity;
-- 
2.46.0

