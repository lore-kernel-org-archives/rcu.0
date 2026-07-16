Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896923BF9F;
	Thu, 16 Jul 2026 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161096; cv=none; b=lkR59OC4SMIqIagc3NZ2jLtH/yYLQ9PJNzYF58AWonXk7buxNheko6Sk4QPqFT5mduY6LB14EwH4vf3JDsp7bp+USuIn4GSKNQFy5Ztnxat7R03lw2zoVwE0/JYBl5ujZ8lTaVpldMTm2F49s5IUILCwnHpkpuXDiNoXyz0oDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161096; c=relaxed/simple;
	bh=/zonpul43VppgukDMsBQNGiTbbiYXq6Xs4Unnezskg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOeBYG3kHhrS6P9KV+vDWSetoY5u5kASjDuuMl3Zcw+oh0QBFAzgmnUXiIKbjKAWSaG7DedlZIt5RX3kk5/CKZrv3agM+ehnL+seD2XCi33vPobCqFTOFrdxQKRG2tFSV/NdxHZO9TJ21lOpcYJm/u+F6OhpaCgnKBRu9pypELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W47wNrJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W47wNrJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34F71F0155E;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=h5ky3EvNHhzgz0w9Yhq3ozQuB2Sf01a5zXkBYIpuLOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W47wNrJtuYoqllGQIYj/5oYX+Utp4AtghTpwYbr/KTcJeI3AKaR6/N5GMvfGrgYJd
	 BggDDEsmsA1SsDX6JPMhAXV5jkBlJ556mQFo9rAMyXJEj0Jm6rmfB8HI5nORatp7AD
	 2ITiMfYWuXmQ0vbWob7rtcspkKqLPbEoQEH5u5600hElHCOLGHeFPmCXMcOg15hadZ
	 m9crNzGrnF/Z7hH3A8dfwGBpzW8hMhQhFIORD/TuxHThx6q6cwdyiMj9BmjoMPnFzZ
	 j5B0mLzu2vl277A4N7usvanHpyfIRj3Jeowqs3vfqCBjDH18lkV7aC+FJz19NtChCr
	 DBCu/+BccO+pQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4CBDDCE0F67; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 17/24] hazptrtorture: Accumulate operation statistics
Date: Wed, 15 Jul 2026 17:18:02 -0700
Message-Id: <20260716001809.11084-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit accumulates and prints counts of the number and types of
hazard-pointer operations that the test performed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/torture.h    |  3 +++
 kernel/rcu/hazptrtorture.c | 28 ++++++++++++++++++++++++++--
 kernel/torture.c           | 15 +++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index b8e5d0f3c2d8f9..1b6d5be641f8d5 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -136,4 +136,7 @@ void torture_sched_set_normal(struct task_struct *t, int nice);
 long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask, bool dowarn);
 #endif
 
+/* Atomic per-CPU counters. */
+s64 torture_sum_pcpu_atomic_long(atomic_long_t __percpu *pcp);
+
 #endif /* __LINUX_TORTURE_H */
diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index fb25f8351659a4..311b387d6ae755 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -81,6 +81,12 @@ static atomic_t n_hazptr_torture_alloc;
 static atomic_t n_hazptr_torture_alloc_fail;
 static atomic_t n_hazptr_torture_free;
 static atomic_t n_hazptr_torture_error;
+static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_acquires);
+static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases);
+static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_acquires_irq);
+static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases_irq);
+static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases_defer);
+static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases_undefer);
 static struct list_head hazptr_torture_removed;
 
 // State for a deferred (AKA pending) hazard pointer
@@ -364,6 +370,7 @@ static void hazptr_torture_acquire(void *hppp_in)
 	struct hazptr_pending *hppp = hppp_in;
 
 	hppp->hpp_htp = cur_ops->readlock(&hppp->hpp_hc);
+	atomic_long_inc(per_cpu_ptr(&hazptr_torture_acquires_irq, raw_smp_processor_id()));
 }
 
 /*
@@ -374,6 +381,7 @@ static void hazptr_torture_release(void *hppp_in)
 	struct hazptr_pending *hppp = hppp_in;
 
 	cur_ops->readunlock(&hppp->hpp_hc, hppp->hpp_htp);
+	atomic_long_inc(per_cpu_ptr(&hazptr_torture_releases_irq, raw_smp_processor_id()));
 }
 
 /*
@@ -407,6 +415,7 @@ hazptr_torture_reader_tail(struct hazptr_pending *hppp, struct torture_random_st
 		smp_call_function_single(cpu, hazptr_torture_release, hppp, 1);
 	} else {
 		cur_ops->readunlock(hcp, htp);
+		atomic_long_inc(per_cpu_ptr(&hazptr_torture_releases, raw_smp_processor_id()));
 	}
 }
 
@@ -422,6 +431,7 @@ static void hazptr_torture_defer(struct hazptr_pending *hppp, struct torture_ran
 	cpu = cpumask_next_wrap(cpu, cpu_online_mask);
 	llhp = per_cpu_ptr(&hazptr_pending, cpu);
 	llist_add(&hppp->hpp_node, llhp);
+	atomic_long_inc(per_cpu_ptr(&hazptr_torture_releases_defer, raw_smp_processor_id()));
 }
 
 /*
@@ -455,12 +465,17 @@ static int hazptr_torture_reader(void *arg)
 		if (irq_acquire && !(torture_random(&rand) % irq_acquire)) {
 			guard(preempt)();
 			cpu = cpumask_next_wrap(cpu, cpu_online_mask);
-			if (cpu != smp_processor_id())
+			if (cpu != smp_processor_id()) {
 				smp_call_function_single(cpu, hazptr_torture_acquire, hppp, 1);
-			else
+			} else {
 				hppp->hpp_htp = cur_ops->readlock(&hppp->hpp_hc);
+				atomic_long_inc(per_cpu_ptr(&hazptr_torture_acquires,
+							    raw_smp_processor_id()));
+			}
 		} else {
 			hppp->hpp_htp = cur_ops->readlock(&hppp->hpp_hc);
+			atomic_long_inc(per_cpu_ptr(&hazptr_torture_acquires,
+						    raw_smp_processor_id()));
 		}
 		if (!hppp->hpp_htp) {
 			// Still starting up, so get out of the way.
@@ -502,6 +517,8 @@ static void hazptr_torture_do_one_pending(int cpu, struct torture_random_state *
 		return;
 	llist_for_each_entry_safe(hppp, hppp1, llnp, hpp_node) {
 		hazptr_torture_reader_tail(hppp, trsp);
+		atomic_long_inc(per_cpu_ptr(&hazptr_torture_releases_undefer,
+					    raw_smp_processor_id()));
 		kfree(hppp);
 	}
 }
@@ -611,6 +628,13 @@ hazptr_torture_stats_print(void)
 		atomic_read(&n_hazptr_torture_alloc_fail),
 		atomic_read(&n_hazptr_torture_free));
 	torture_onoff_stats();
+	pr_cont("acq: %lld rel: %lld acqirq: %lld relirq: %lld reldefer: %lld relundefer %lld\n",
+		torture_sum_pcpu_atomic_long(&hazptr_torture_acquires),
+		torture_sum_pcpu_atomic_long(&hazptr_torture_releases),
+		torture_sum_pcpu_atomic_long(&hazptr_torture_acquires_irq),
+		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_irq),
+		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_defer),
+		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_undefer));
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (i > 1) {
diff --git a/kernel/torture.c b/kernel/torture.c
index bcd2e9c8a26356..bb9e1349418a19 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -1007,3 +1007,18 @@ void torture_sched_set_normal(struct task_struct *t, int nice)
 	sched_set_normal(t, realnice);
 }
 EXPORT_SYMBOL_GPL(torture_sched_set_normal);
+
+/*
+ * Sum the specified per-CPU atomic_long_t variable.
+ */
+s64 torture_sum_pcpu_atomic_long(atomic_long_t __percpu *pcp)
+{
+	int cpu;
+	s64 sum = 0;
+
+	for_each_possible_cpu(cpu) {
+		sum += atomic_long_read(per_cpu_ptr(pcp, cpu));
+	}
+	return sum;
+}
+EXPORT_SYMBOL_GPL(torture_sum_pcpu_atomic_long);
-- 
2.40.1

