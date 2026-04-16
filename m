Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34963394487
	for <rcu@vger.kernel.org>; Thu, 16 Apr 2026 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330638; cv=none; b=qY65NAcAEdFt5GzsikRIzL3TdSx2kPLPfP0zVx8ILEssfcgK8/4ulRVkRgUUUH/gRupsKp8UqfYgGgZSgiurnM8Jr8joWX1c39QgMtnGT1+RV+EvQ8fwnGS6tl6Ui53Pp4M+pQ6sla+K5i9SDkAEo7+RMQdhzgut9dX6bC+61Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330638; c=relaxed/simple;
	bh=CMip4eFbasUIvlR3P/M8MgeOoWuXxQ2+h4ESc3P+fLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmfsU+d1fX/uVTKr+sj7xU+4IABldb2kU4AnZ+LQtgLiJ8JlGKhh1v3ibD2aveVHy++wlR17GRW2tHplb0AzG2kYafDKxwMsiVnmGKEEn7dnKpoRzneb3BjZAbOdhKi2T0TKsb26NCUFjnigWWXp/O0/jWI6goyklrjZj14mGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzdTm8vy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzdTm8vy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DAEC2BCB5;
	Thu, 16 Apr 2026 09:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776330638;
	bh=CMip4eFbasUIvlR3P/M8MgeOoWuXxQ2+h4ESc3P+fLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzdTm8vymSC+VxFzOo1Js3YnTi6dVF6shbZ6l/VJDehvH/mQ1FrHfa06im1VSLnJC
	 UKPyCeGUetbib07DdztNDaTtGQ+RyjZqxdmk7/SkahysloCxhkVRolOuwCugLHeISm
	 bTV1AS9MBHO5LMrw+mnGhRm2AVYRvdUaDsR5vAO6oRSpMfz+SU6r15xYfqlrcYNUjj
	 iJhxgw3rvBza0tjOxcML1wa/b5eh93tzfG2CBU5DkL/EaFMQPdus6usWbwcfN7qNwN
	 uSPVlTf50zFBhZ0duMG5ZpDY8E5ZK7Kk34ksviN9v/UCufWPZr+O2alERbWvMIRekI
	 d/uRojROwSwSA==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/8] mm/slab: move kfree_rcu_cpu[_work] definitions
Date: Thu, 16 Apr 2026 18:10:17 +0900
Message-ID: <20260416091022.36823-4-harry@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091022.36823-1-harry@kernel.org>
References: <20260416091022.36823-1-harry@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for defining kfree_rcu_cpu under
CONFIG_KVFREE_RCU_BATCHED=n and adding a new function common to both
configurations, move the existing kfree_rcu_cpu[_work] definitions to
just before the beginning of the kfree_rcu batching infrastructure.

Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 mm/slab_common.c | 142 ++++++++++++++++++++++++-----------------------
 1 file changed, 72 insertions(+), 70 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 85c9c2d0620e..cddbf3279c13 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1263,78 +1263,9 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
 EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
 
-#ifndef CONFIG_KVFREE_RCU_BATCHED
-
-void kvfree_call_rcu_head(struct rcu_head *head, void *ptr)
-{
-	if (head) {
-		kasan_record_aux_stack(ptr);
-		call_rcu(head, kvfree_rcu_cb);
-		return;
-	}
-
-	// kvfree_rcu(one_arg) call.
-	might_sleep();
-	synchronize_rcu();
-	kvfree(ptr);
-}
-EXPORT_SYMBOL_GPL(kvfree_call_rcu_head);
-
-void __init kvfree_rcu_init(void)
-{
-}
-
-#else /* CONFIG_KVFREE_RCU_BATCHED */
-
-/*
- * This rcu parameter is runtime-read-only. It reflects
- * a minimum allowed number of objects which can be cached
- * per-CPU. Object size is equal to one page. This value
- * can be changed at boot time.
- */
-static int rcu_min_cached_objs = 5;
-module_param(rcu_min_cached_objs, int, 0444);
-
-// A page shrinker can ask for pages to be freed to make them
-// available for other parts of the system. This usually happens
-// under low memory conditions, and in that case we should also
-// defer page-cache filling for a short time period.
-//
-// The default value is 5 seconds, which is long enough to reduce
-// interference with the shrinker while it asks other systems to
-// drain their caches.
-static int rcu_delay_page_cache_fill_msec = 5000;
-module_param(rcu_delay_page_cache_fill_msec, int, 0444);
-
-static struct workqueue_struct *rcu_reclaim_wq;
-
-/* Maximum number of jiffies to wait before draining a batch. */
-#define KFREE_DRAIN_JIFFIES (5 * HZ)
+#ifdef CONFIG_KVFREE_RCU_BATCHED
 #define KFREE_N_BATCHES 2
 #define FREE_N_CHANNELS 2
-
-/**
- * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
- * @list: List node. All blocks are linked between each other
- * @gp_snap: Snapshot of RCU state for objects placed to this bulk
- * @nr_records: Number of active pointers in the array
- * @records: Array of the kvfree_rcu() pointers
- */
-struct kvfree_rcu_bulk_data {
-	struct list_head list;
-	struct rcu_gp_oldstate gp_snap;
-	unsigned long nr_records;
-	void *records[] __counted_by(nr_records);
-};
-
-/*
- * This macro defines how many entries the "records" array
- * will contain. It is based on the fact that the size of
- * kvfree_rcu_bulk_data structure becomes exactly one page.
- */
-#define KVFREE_BULK_MAX_ENTR \
-	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
-
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
@@ -1402,6 +1333,77 @@ struct kfree_rcu_cpu {
 	struct llist_head bkvcache;
 	int nr_bkv_objs;
 };
+#endif
+
+#ifndef CONFIG_KVFREE_RCU_BATCHED
+
+void kvfree_call_rcu_head(struct rcu_head *head, void *ptr)
+{
+	if (head) {
+		kasan_record_aux_stack(ptr);
+		call_rcu(head, kvfree_rcu_cb);
+		return;
+	}
+
+	// kvfree_rcu(one_arg) call.
+	might_sleep();
+	synchronize_rcu();
+	kvfree(ptr);
+}
+EXPORT_SYMBOL_GPL(kvfree_call_rcu_head);
+
+void __init kvfree_rcu_init(void)
+{
+}
+
+#else /* CONFIG_KVFREE_RCU_BATCHED */
+
+/*
+ * This rcu parameter is runtime-read-only. It reflects
+ * a minimum allowed number of objects which can be cached
+ * per-CPU. Object size is equal to one page. This value
+ * can be changed at boot time.
+ */
+static int rcu_min_cached_objs = 5;
+module_param(rcu_min_cached_objs, int, 0444);
+
+// A page shrinker can ask for pages to be freed to make them
+// available for other parts of the system. This usually happens
+// under low memory conditions, and in that case we should also
+// defer page-cache filling for a short time period.
+//
+// The default value is 5 seconds, which is long enough to reduce
+// interference with the shrinker while it asks other systems to
+// drain their caches.
+static int rcu_delay_page_cache_fill_msec = 5000;
+module_param(rcu_delay_page_cache_fill_msec, int, 0444);
+
+static struct workqueue_struct *rcu_reclaim_wq;
+
+/* Maximum number of jiffies to wait before draining a batch. */
+#define KFREE_DRAIN_JIFFIES (5 * HZ)
+
+/**
+ * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
+ * @list: List node. All blocks are linked between each other
+ * @gp_snap: Snapshot of RCU state for objects placed to this bulk
+ * @nr_records: Number of active pointers in the array
+ * @records: Array of the kvfree_rcu() pointers
+ */
+struct kvfree_rcu_bulk_data {
+	struct list_head list;
+	struct rcu_gp_oldstate gp_snap;
+	unsigned long nr_records;
+	void *records[] __counted_by(nr_records);
+};
+
+/*
+ * This macro defines how many entries the "records" array
+ * will contain. It is based on the fact that the size of
+ * kvfree_rcu_bulk_data structure becomes exactly one page.
+ */
+#define KVFREE_BULK_MAX_ENTR \
+	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
 	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
-- 
2.43.0

