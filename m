Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114CB13B287;
	Sat, 13 Jul 2024 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720889977; cv=none; b=R+zXDOlUNYjd3qddZYjGIIA0w+yCVvVTyqha7ZtgFkYrNLr7ad172Qsujuo8TUNPBBlRZF+lJe/wVApnY6kGsR7waGJ5P+NPQu45REclTbutbNA2vSVMrgATxrCIkOrWGzydzA6VJmwOut5745CpqPL6v12FLrjDuM6vvGbhQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720889977; c=relaxed/simple;
	bh=TcTKuYb/T3TiNi95YK/ATJr+aH6f3xo82T3OOyXeLDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iXFCf/4TiGT9zrEH4FG1QJyHpFOlMMez51q8VuM0/KYX3cKZtwzndo+nCv0UNbNCrQJ+ih6Ajk+A+LM4p2QJ0xfoEnCVOEHlK3OX4Tw3531SUJdwcch3rGuOiZhOklt5YpdKeZYOIeX/Sh9VTL4iigHCHmcOuIPRPHZttDScOvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0fbpG8q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0fbpG8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D130C32781;
	Sat, 13 Jul 2024 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720889976;
	bh=TcTKuYb/T3TiNi95YK/ATJr+aH6f3xo82T3OOyXeLDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0fbpG8qQirQk8feTGjpFY02fyuc0mVKjAKBkKo/N+FJTtWMj0Ruvbsfagt9LH5RH
	 XqEQzqx4NWcZ6ho0utqjKWCGG0YFJc498P5cEte+5x79z/gFdvM/lvkB1ghr0P0Y84
	 YDO0qF7EghCSEHxjDKcKEI71WSL/deSJRzYIsw6g+EuYHpkQL3AnipOGXdd65dSQYa
	 LQHPG7bU1EE9uB6WYZLG0rdo7brKuk2LXGkQMqXoMS3BEWzEsqXIlIHce7UchkV8WP
	 NdDweL6GtNxEWw2BawsIuTY5JhatYtg2lF4EXBva2pULVkOCLVcj+Emp4cx6IWpK9W
	 BelPT7o+yuDRw==
From: neeraj.upadhyay@kernel.org
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	mingo@kernel.org,
	peterz@infradead.org,
	paulmck@kernel.org,
	leobras@redhat.com,
	imran.f.khan@oracle.com,
	riel@surriel.com,
	neeraj.upadhyay@kernel.org
Subject: [PATCH  2/3] locking/csd_lock: Provide an indication of ongoing CSD-lock stall
Date: Sat, 13 Jul 2024 22:28:45 +0530
Message-Id: <20240713165846.216174-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240713165642.GA215331@neeraj.linux>
References: <20240713165642.GA215331@neeraj.linux>
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
 2 files changed, 22 insertions(+)

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
index 81f7083a53e2..c3e8241e9cbb 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -207,6 +207,19 @@ static int csd_lock_wait_getcpu(call_single_data_t *csd)
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
@@ -228,6 +241,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 		cpu = csd_lock_wait_getcpu(csd);
 		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
 			 *bug_id, raw_smp_processor_id(), cpu);
+		atomic_dec(&n_csd_lock_stuck);
 		return true;
 	}
 
@@ -251,6 +265,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
 		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), (s64)ts_delta,
 		 cpu, csd->func, csd->info);
+	if (firsttime)
+		atomic_dec(&n_csd_lock_stuck);
 	/*
 	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
 	 * to become unstuck. Use a signed comparison to avoid triggering
-- 
2.40.1

