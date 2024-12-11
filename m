Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F05E1DF721;
	Wed, 11 Dec 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931689; cv=none; b=PHGBYFtJIEiFgJYXiSvtCfaVeJ4m2JzQxnCq+MaG66zIK0FcDSoeXMmmtfDYDhizzIUp+LRVc6uWCDk26RNXJMdyHfgbIzJnk4t7a9VH1mqLDBfDHUkz4JPa05DW7a7kSLOEKRoL6ps5GkDr3dBJqkngb1f/MJcRa8SiZ/Va5VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931689; c=relaxed/simple;
	bh=TPwbe0h9Cn+KwklKnaILy0lnjPTSkhmgKhF6NOTZxfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSsuJMRFhPLDENEqqpUDiJXo1B45/O63NQhxVr/q5KURITCgtYmbKahtDFUS2PGz2+h+Ocf9Zgsf1g/CPf4a2tc//ZYZVsaDW3ZNnMLo5+DbVj5OGEFFERGtqmALZj4k2TJCSrJ3jhwZaNGAjD5pDT9+BrxjIzREvKCX+GqOTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eviwfq74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eviwfq74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC22C4CED2;
	Wed, 11 Dec 2024 15:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931687;
	bh=TPwbe0h9Cn+KwklKnaILy0lnjPTSkhmgKhF6NOTZxfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eviwfq74MYpDBAX1CN9ryQRu0vXShOb9xSlRAqZ9SGZIq8rPs/S+4vnZgPKFR46hr
	 H5X1VSb98zhy2Pa/K7Rn43XGq6hSEM/Pmu10T1MjKM3I88crHisNoRv6b+5tx0kdK7
	 3rvBl462adXriTT3k8xj1+g+PFeJkncx60AAF1/why5fC0EYX9w7ApLM4kJD2FJ36V
	 s/2NcFLEoTT5firOUYE/7LuN/iVKU6C/9M8PQbfeNoJjSN2SS9FjyEWslRpM26vQcB
	 nFemySdXhIP9QPqpg7g3eJPGv/MP0FeuHnh47P8X+e3vrtX+lz/Wj3letVj3Es/jMB
	 ebUgeKp4gnRyw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 17/19] kthread: Unify kthread_create_on_cpu() and kthread_create_worker_on_cpu() automatic format
Date: Wed, 11 Dec 2024 16:40:30 +0100
Message-ID: <20241211154035.75565-18-frederic@kernel.org>
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

kthread_create_on_cpu() uses the CPU argument as an implicit and unique
printf argument to add to the format whereas
kthread_create_worker_on_cpu() still relies on explicitly passing the
printf arguments. This difference in behaviour is error prone and
doesn't help standardizing per-CPU kthread names.

Unify the behaviours and convert kthread_create_worker_on_cpu() to
use the printf behaviour of kthread_create_on_cpu().

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 fs/erofs/zdata.c        |  2 +-
 include/linux/kthread.h | 21 +++++++++++----
 kernel/kthread.c        | 59 ++++++++++++++++++++++++-----------------
 3 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 01f147505487..a23392327ce2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -320,7 +320,7 @@ static void erofs_destroy_percpu_workers(void)
 static struct kthread_worker *erofs_init_percpu_worker(int cpu)
 {
 	struct kthread_worker *worker =
-		kthread_create_worker_on_cpu(cpu, 0, "erofs_worker/%u", cpu);
+		kthread_create_worker_on_cpu(cpu, 0, "erofs_worker/%u");
 
 	if (IS_ERR(worker))
 		return worker;
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 30209bdf83a2..0c66e7c1092a 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -187,13 +187,24 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
 
 int kthread_worker_fn(void *worker_ptr);
 
-__printf(2, 3)
+__printf(3, 4)
+struct kthread_worker *kthread_create_worker_on_node(unsigned int flags,
+						     int node,
+						     const char namefmt[], ...);
+
+#define kthread_create_worker(flags, namefmt, ...) \
+({									   \
+	struct kthread_worker *__kw					   \
+		= kthread_create_worker_on_node(flags, NUMA_NO_NODE,	   \
+						namefmt, ## __VA_ARGS__);  \
+	if (!IS_ERR(__kw))						   \
+		wake_up_process(__kw->task);				   \
+	__kw;								   \
+})
+
 struct kthread_worker *
-kthread_create_worker(unsigned int flags, const char namefmt[], ...);
-
-__printf(3, 4) struct kthread_worker *
 kthread_create_worker_on_cpu(int cpu, unsigned int flags,
-			     const char namefmt[], ...);
+			     const char namefmt[]);
 
 bool kthread_queue_work(struct kthread_worker *worker,
 			struct kthread_work *work);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 6bb958a75a0b..429ada0dbe93 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1030,12 +1030,11 @@ int kthread_worker_fn(void *worker_ptr)
 EXPORT_SYMBOL_GPL(kthread_worker_fn);
 
 static __printf(3, 0) struct kthread_worker *
-__kthread_create_worker(int cpu, unsigned int flags,
-			const char namefmt[], va_list args)
+__kthread_create_worker_on_node(unsigned int flags, int node,
+				const char namefmt[], va_list args)
 {
 	struct kthread_worker *worker;
 	struct task_struct *task;
-	int node = NUMA_NO_NODE;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL);
 	if (!worker)
@@ -1043,20 +1042,14 @@ __kthread_create_worker(int cpu, unsigned int flags,
 
 	kthread_init_worker(worker);
 
-	if (cpu >= 0)
-		node = cpu_to_node(cpu);
-
 	task = __kthread_create_on_node(kthread_worker_fn, worker,
-						node, namefmt, args);
+					node, namefmt, args);
 	if (IS_ERR(task))
 		goto fail_task;
 
-	if (cpu >= 0)
-		kthread_bind(task, cpu);
-
 	worker->flags = flags;
 	worker->task = task;
-	wake_up_process(task);
+
 	return worker;
 
 fail_task:
@@ -1067,6 +1060,7 @@ __kthread_create_worker(int cpu, unsigned int flags,
 /**
  * kthread_create_worker - create a kthread worker
  * @flags: flags modifying the default behavior of the worker
+ * @node: task structure for the thread is allocated on this node
  * @namefmt: printf-style name for the kthread worker (task).
  *
  * Returns a pointer to the allocated worker on success, ERR_PTR(-ENOMEM)
@@ -1074,25 +1068,49 @@ __kthread_create_worker(int cpu, unsigned int flags,
  * when the caller was killed by a fatal signal.
  */
 struct kthread_worker *
-kthread_create_worker(unsigned int flags, const char namefmt[], ...)
+kthread_create_worker_on_node(unsigned int flags, int node, const char namefmt[], ...)
 {
 	struct kthread_worker *worker;
 	va_list args;
 
 	va_start(args, namefmt);
-	worker = __kthread_create_worker(-1, flags, namefmt, args);
+	worker = __kthread_create_worker_on_node(flags, node, namefmt, args);
 	va_end(args);
 
+	if (worker)
+		wake_up_process(worker->task);
+
+	return worker;
+}
+EXPORT_SYMBOL(kthread_create_worker_on_node);
+
+static __printf(3, 4) struct kthread_worker *
+__kthread_create_worker_on_cpu(int cpu, unsigned int flags,
+			       const char namefmt[], ...)
+{
+	struct kthread_worker *worker;
+	va_list args;
+
+	va_start(args, namefmt);
+	worker = __kthread_create_worker_on_node(flags, cpu_to_node(cpu),
+						 namefmt, args);
+	va_end(args);
+
+	if (worker) {
+		kthread_bind(worker->task, cpu);
+		wake_up_process(worker->task);
+	}
+
 	return worker;
 }
-EXPORT_SYMBOL(kthread_create_worker);
 
 /**
  * kthread_create_worker_on_cpu - create a kthread worker and bind it
  *	to a given CPU and the associated NUMA node.
  * @cpu: CPU number
  * @flags: flags modifying the default behavior of the worker
- * @namefmt: printf-style name for the kthread worker (task).
+ * @namefmt: printf-style name for the thread. Format is restricted
+ *	     to "name.*%u". Code fills in cpu number.
  *
  * Use a valid CPU number if you want to bind the kthread worker
  * to the given CPU and the associated NUMA node.
@@ -1124,16 +1142,9 @@ EXPORT_SYMBOL(kthread_create_worker);
  */
 struct kthread_worker *
 kthread_create_worker_on_cpu(int cpu, unsigned int flags,
-			     const char namefmt[], ...)
+			     const char namefmt[])
 {
-	struct kthread_worker *worker;
-	va_list args;
-
-	va_start(args, namefmt);
-	worker = __kthread_create_worker(cpu, flags, namefmt, args);
-	va_end(args);
-
-	return worker;
+	return __kthread_create_worker_on_cpu(cpu, flags, namefmt, cpu);
 }
 EXPORT_SYMBOL(kthread_create_worker_on_cpu);
 
-- 
2.46.0

