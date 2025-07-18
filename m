Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379419F137
	for <rcu@vger.kernel.org>; Fri, 18 Jul 2025 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752806545; cv=none; b=b9cd9vYDnjHNfqElfyMyRJgMavZVJkju15/J6QjqpW59eqJeizMyB+0Corqbv/NCwyWNVC0SLi68oIZrGNWWWYygQhmYa1YNF1xzew60ZdrolvkOc1uBf8LMU8QiA/V+4fVLL5PDq1nZ2WWXlVojIJS5PPE7acC7n/Pe0mXNsl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752806545; c=relaxed/simple;
	bh=1q9nTy6bjkYnpdPdD5bIaq1harlEkcTnLyzp577t9Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVW/FjH4SjW5TjCH7ZIYpp6SHDdA7ZYgzUk14kPsI6ron1l3ihChF4lHkY7qmHNVGo+eZBde8QhfbMhOf4arhFqiZK3/HdoTD8SE+DBLqQ0vVGQu+jtXEMwCpPsgO8ucANg+qNcAcJ2IvSsSQQtlIhxCgM6wViukBrfT2ffG4bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+z0v/Bt; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+z0v/Bt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752806531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=165mTwuoOHXsCCkCN512tFxf4UxYV8qKAC9hxkL+/Lk=;
	b=C+z0v/BtEiiH9bIvE3RyS1HXloAmCIbAStbntjBf2mzpaCnw8iYPm5/ned/zGKD+pvLvtb
	0Q4d6uYcc7MHKk3uuNZ5T1hA/mtaOkIqc1xQhfbN62oCCmiUeuMA2fvAkJjqtY6Jx0EbXK
	2itEeFIJViPwTpLZiavmpOzp9/s1548=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ye Liu <liuye@kylinos.cn>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH] mm: Replace (20 - PAGE_SHIFT) with common macros for pages<->MB conversion
Date: Fri, 18 Jul 2025 10:41:32 +0800
Message-ID: <20250718024134.1304745-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Replace repeated (20 - PAGE_SHIFT) calculations with standard macros:
- MB_TO_PAGES(mb)    converts MB to page count
- PAGES_TO_MB(pages) converts pages to MB

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 include/linux/mm.h    | 9 +++++++++
 kernel/rcu/rcuscale.c | 2 +-
 kernel/sched/fair.c   | 5 ++---
 mm/backing-dev.c      | 2 +-
 mm/huge_memory.c      | 2 +-
 mm/swap.c             | 2 +-
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 957acde6ae62..0c1b2c074142 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -69,6 +69,15 @@ static inline void totalram_pages_add(long count)
 
 extern void * high_memory;
 
+/*
+ * Convert between pages and MB
+ * 20 is the shift for 1MB (2^20 = 1MB)
+ * PAGE_SHIFT is the shift for page size (e.g., 12 for 4KB pages)
+ * So (20 - PAGE_SHIFT) converts between pages and MB
+ */
+#define PAGES_TO_MB(pages) ((pages) >> (20 - PAGE_SHIFT))
+#define MB_TO_PAGES(mb)    ((mb) << (20 - PAGE_SHIFT))
+
 #ifdef CONFIG_SYSCTL
 extern int sysctl_legacy_va_layout;
 #else
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index b521d0455992..7484d8ad5767 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -796,7 +796,7 @@ kfree_scale_thread(void *arg)
 		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
 		       (unsigned long long)(end_time - start_time), kfree_loops,
 		       rcuscale_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
-		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
+		       PAGES_TO_MB(mem_begin - mem_during));
 
 		if (shutdown) {
 			smp_mb(); /* Assign before wake. */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b9b4bbbf0af6..ae1d9a7ef202 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1489,7 +1489,7 @@ static unsigned int task_nr_scan_windows(struct task_struct *p)
 	 * by the PTE scanner and NUMA hinting faults should be trapped based
 	 * on resident pages
 	 */
-	nr_scan_pages = sysctl_numa_balancing_scan_size << (20 - PAGE_SHIFT);
+	nr_scan_pages = MB_TO_PAGES(sysctl_numa_balancing_scan_size);
 	rss = get_mm_rss(p->mm);
 	if (!rss)
 		rss = nr_scan_pages;
@@ -1926,8 +1926,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 		}
 
 		def_th = sysctl_numa_balancing_hot_threshold;
-		rate_limit = sysctl_numa_balancing_promote_rate_limit << \
-			(20 - PAGE_SHIFT);
+		rate_limit = MB_TO_PAGES(sysctl_numa_balancing_promote_rate_limit);
 		numa_promotion_adjust_threshold(pgdat, rate_limit, def_th);
 
 		th = pgdat->nbp_threshold ? : def_th;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 783904d8c5ef..e4d578e6121c 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -510,7 +510,7 @@ static void wb_update_bandwidth_workfn(struct work_struct *work)
 /*
  * Initial write bandwidth: 100 MB/s
  */
-#define INIT_BW		(100 << (20 - PAGE_SHIFT))
+#define INIT_BW		MB_TO_PAGES(100)
 
 static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 		   gfp_t gfp)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 389620c65a5f..dcc33d9c300f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -911,7 +911,7 @@ static int __init hugepage_init(void)
 	 * where the extra memory used could hurt more than TLB overhead
 	 * is likely to save.  The admin can still enable it through /sys.
 	 */
-	if (totalram_pages() < (512 << (20 - PAGE_SHIFT))) {
+	if (totalram_pages() < MB_TO_PAGES(512)) {
 		transparent_hugepage_flags = 0;
 		return 0;
 	}
diff --git a/mm/swap.c b/mm/swap.c
index 3632dd061beb..cb164f9ef9e3 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1096,7 +1096,7 @@ static const struct ctl_table swap_sysctl_table[] = {
  */
 void __init swap_setup(void)
 {
-	unsigned long megs = totalram_pages() >> (20 - PAGE_SHIFT);
+	unsigned long megs = PAGES_TO_MB(totalram_pages());
 
 	/* Use a smaller cluster for small-memory machines */
 	if (megs < 16)
-- 
2.43.0

