Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A735F199;
	Sat, 19 Sep 2026 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776065; cv=none; b=mAI0js1MaQlBtXRkgaasSpmqFKajfsFXWBNowTXMOoxt3yBVv9Cm0J2ng//qinSQ7jxYrokXBGYvmDWZ1gto1FHcaWhcF8cxBkyw0P1ZMVa57wn7f7dnl92lLfXPIzLJvO5QoqbctoS+58uf1ZUBDEHs72uokxST2s0klFMewjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776065; c=relaxed/simple;
	bh=+wGIl4VJl35HMRC0sRggvWaIg9d9Kd3cllVydeBN5Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWBCjf0g61Sjcnxr191CKJ+oWgt0wcWDPogwxqKhgmylDb7ySSnHm3nKH/oMDSJM5SC6ZYBKleg0Q2MFQSApKWXRYl16ljRDNd5/xhjciqNCdaWxCGMahrhkwbh/vEgYZSaGrtcJjoLV6NJAj1cK0Dj+tSFRo6wwEETyCDKOXNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDmseEFb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDmseEFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA611F00900;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=lptpBN2RiMuT/Hsp284DO7b/nXFKvjfkdX3nE5ykFsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FDmseEFbGR6JmGCJcqxyIlWITP8ywEwJFK2TLSCBNvLT1jGB8pvrMTnuIraU4l4Ci
	 cRSxf5oPNKBncKFAoJMPgj7thYZXjkbAWj96rtJFsDOaB84wubRo2pIOCa9b9z+DG3
	 LD5HtRII/gvrpd2HrsuH9FPsSFif1Qb7YdnjcEtFkQleb4HCyfUbNaM4kfWs5SfTxx
	 oPcq/jj6xAPVm3mc3IgN6peXdK1tm01yyBbynXYK3JZUchgFD08uQMOg1kIhdIA/oe
	 x0LSO88dAJ3RWq96Zn2/VBnwUu/ch3j0u2+aCBwMS9d93tY1wuP69zUqCt/WhmPgmb
	 GocyS6ohoLclg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7A76BCE0E5A; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 17/28] hazptrtorture: Accumulate operation statistics
Date: Fri, 18 Sep 2026 17:00:45 -0700
Message-Id: <20260919000056.3132131-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
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
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 include/linux/torture.h    |  3 +++
 kernel/rcu/hazptrtorture.c | 28 ++++++++++++++++++++++++++--
 kernel/torture.c           | 15 +++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index b8e5d0f3c2d8..1b6d5be641f8 100644
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
index 5016d04d1bae..a72375cb3221 100644
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
index 93caaa8b807e..1f5e4463b1e1 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -1012,3 +1012,18 @@ void torture_sched_set_normal(struct task_struct *t, int nice)
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

