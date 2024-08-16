Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD837D07E;
	Fri, 16 Aug 2024 04:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723783203; cv=none; b=TkmHmUQC0ucdMhrvBh0oKRKZKER/Sl+ZUrHKoP3LxqIov27dSciz/d9DkpN3HUVBpSSgrPU/Tax9d84QRT43Inhx+kH2RLYj6zp0RooYL3fZrOcyyq4gJ65iwOXVyZZ+1mDEcrh9KNNvz+vEc3celcgE7uw+DiXmu4c8rCLlr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723783203; c=relaxed/simple;
	bh=J89s7BvJjaodUbVqWIXuLyWtkXirVXq4up0wxHeWgqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NSUTaLlImmNhwPfMCLLUuSsvmmZKQ463+xopUcz15iG3xy5OdLL56ufwL2+rFUiFvFV9sYG/McaINh6pkVyjVeGq2FJFQ/dZPnZoYAaTp9ZppmD7Z7G+mngXiNdKqlu+VDhAsGgVYOEGTe6NQJBe2SGaNaPxONyzNddXa0ib/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkZ4HP88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkZ4HP88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61278C4AF0E;
	Fri, 16 Aug 2024 04:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723783203;
	bh=J89s7BvJjaodUbVqWIXuLyWtkXirVXq4up0wxHeWgqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkZ4HP88N78dCZAVe35PCZTIyGNM95HZt0VsuJbh2C8s0mK3XxkNdiJcpBSCt22Or
	 J3+w+iKZb7BluE5Cp09vdLhUnzlCN6wERR2ziEiuUX7NWFNY3FdGYO+9Z9/WWn+k98
	 B1kg6IZmQPVP2zB+QprbxcWB1mOBM32vGBlMd56I0Dj6ZW8v8vnZIGb3/YXGosG2mT
	 WylPPpsJefVeXKH/84sLVSwcGCjLWIiR8qeZkrV4UDKNboXc+pC/vQiMMeF5sYyb+U
	 8Grzv4iKrVatpUUO8s+mrxROfjOqG2JKQnDlU9LDsdsAH9ZNWVmAXsmD5AI6MHhjbE
	 Phg+33rqHZn+g==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	mingo@kernel.org,
	peterz@infradead.org,
	leobras@redhat.com,
	imran.f.khan@oracle.com,
	riel@surriel.com,
	tglx@linutronix.de
Subject: [PATCH rcu 2/4] locking/csd_lock: Provide an indication of ongoing CSD-lock stall
Date: Fri, 16 Aug 2024 10:09:15 +0530
Message-Id: <20240816043917.26537-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816043600.GA25206@neeraj.linux>
References: <20240816043600.GA25206@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

If a CSD-lock stall goes on long enough, it will cause an RCU CPU
stall warning.  This additional warning provides much additional
console-log traffic and little additional information.  Therefore,
provide a new csd_lock_is_stuck() function that returns true if there
is an ongoing CSD-lock stall.  This function will be used by the RCU
CPU stall warnings to provide a one-line indication of the stall when
this function returns true.

[ neeraj.upadhyay: Apply Rik van Riel feedback. ]
[ neeraj.upadhyay: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Imran Khan <imran.f.khan@oracle.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/smp.h |  6 ++++++
 kernel/smp.c        | 16 ++++++++++++++++
 lib/Kconfig.debug   |  1 +
 3 files changed, 23 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index fcd61dfe2af3..3871bd32018f 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -294,4 +294,10 @@ int smpcfd_prepare_cpu(unsigned int cpu);
 int smpcfd_dead_cpu(unsigned int cpu);
 int smpcfd_dying_cpu(unsigned int cpu);
 
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+bool csd_lock_is_stuck(void);
+#else
+static inline bool csd_lock_is_stuck(void) { return false; }
+#endif
+
 #endif /* __LINUX_SMP_H */
diff --git a/kernel/smp.c b/kernel/smp.c
index e87953729230..202cda4d2a55 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -208,6 +208,19 @@ static int csd_lock_wait_getcpu(call_single_data_t *csd)
 	return -1;
 }
 
+static atomic_t n_csd_lock_stuck;
+
+/**
+ * csd_lock_is_stuck - Has a CSD-lock acquisition been stuck too long?
+ *
+ * Returns @true if a CSD-lock acquisition is stuck and has been stuck
+ * long enough for a "non-responsive CSD lock" message to be printed.
+ */
+bool csd_lock_is_stuck(void)
+{
+	return !!atomic_read(&n_csd_lock_stuck);
+}
+
 /*
  * Complain if too much time spent waiting.  Note that only
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
@@ -229,6 +242,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 		cpu = csd_lock_wait_getcpu(csd);
 		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
 			 *bug_id, raw_smp_processor_id(), cpu);
+		atomic_dec(&n_csd_lock_stuck);
 		return true;
 	}
 
@@ -252,6 +266,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
 		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), (s64)ts_delta,
 		 cpu, csd->func, csd->info);
+	if (firsttime)
+		atomic_inc(&n_csd_lock_stuck);
 	/*
 	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
 	 * to become unstuck. Use a signed comparison to avoid triggering
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..4e5f61cba8e4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1614,6 +1614,7 @@ config SCF_TORTURE_TEST
 config CSD_LOCK_WAIT_DEBUG
 	bool "Debugging for csd_lock_wait(), called from smp_call_function*()"
 	depends on DEBUG_KERNEL
+	depends on SMP
 	depends on 64BIT
 	default n
 	help
-- 
2.40.1

