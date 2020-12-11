Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64024C4361B
	for <rcu@archiver.kernel.org>; Fri, 11 Dec 2020 01:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FCF23DE8
	for <rcu@archiver.kernel.org>; Fri, 11 Dec 2020 01:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394765AbgLKBVl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Dec 2020 20:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404801AbgLKBUq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Dec 2020 20:20:46 -0500
From:   paulmck@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, iamjoonsoo.kim@lge.com,
        andrii@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        linux-mm@kvack.org
Subject: [PATCH v3 sl-b 3/6] mm: Make mem_dump_obj() handle vmalloc() memory
Date:   Thu, 10 Dec 2020 17:20:00 -0800
Message-Id: <20201211012003.16473-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201211011907.GA16110@paulmck-ThinkPad-P72>
References: <20201211011907.GA16110@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds vmalloc() support to mem_dump_obj().  Note that the
vmalloc_dump_obj() function combines the checking and dumping, in
contrast with the split between kmem_valid_obj() and kmem_dump_obj().
The reason for the difference is that the checking in the vmalloc()
case involves acquiring a global lock, and redundant acquisitions of
global locks should be avoided, even on not-so-fast paths.

Note that this change causes on-stack variables to be reported as
vmalloc() storage from kernel_clone() or similar, depending on the degree
of inlining that your compiler does.  This is likely more helpful than
the earlier "non-paged (local) memory".

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/vmalloc.h |  6 ++++++
 mm/util.c               | 14 ++++++++------
 mm/vmalloc.c            | 12 ++++++++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 938eaf9..c89c2be 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -248,4 +248,10 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 int register_vmap_purge_notifier(struct notifier_block *nb);
 int unregister_vmap_purge_notifier(struct notifier_block *nb);
 
+#ifdef CONFIG_MMU
+bool vmalloc_dump_obj(void *object);
+#else
+static inline bool vmalloc_dump_obj(void *object) { return false; }
+#endif
+
 #endif /* _LINUX_VMALLOC_H */
diff --git a/mm/util.c b/mm/util.c
index f7c94c8..dcde696 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -984,18 +984,20 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
  */
 void mem_dump_obj(void *object)
 {
+	if (kmem_valid_obj(object)) {
+		kmem_dump_obj(object);
+		return;
+	}
+	if (vmalloc_dump_obj(object))
+		return;
 	if (!virt_addr_valid(object)) {
 		if (object == NULL)
 			pr_cont(" NULL pointer.\n");
 		else if (object == ZERO_SIZE_PTR)
 			pr_cont(" zero-size pointer.\n");
 		else
-			pr_cont(" non-paged (local) memory.\n");
-		return;
-	}
-	if (kmem_valid_obj(object)) {
-		kmem_dump_obj(object);
+			pr_cont(" non-paged memory.\n");
 		return;
 	}
-	pr_cont(" non-slab memory.\n");
+	pr_cont(" non-slab/vmalloc memory.\n");
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6ae491a..7421719 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3431,6 +3431,18 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 }
 #endif	/* CONFIG_SMP */
 
+bool vmalloc_dump_obj(void *object)
+{
+	struct vm_struct *vm;
+	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
+
+	vm = find_vm_area(objp);
+	if (!vm)
+		return false;
+	pr_cont(" vmalloc allocated at %pS\n", vm->caller);
+	return true;
+}
+
 #ifdef CONFIG_PROC_FS
 static void *s_start(struct seq_file *m, loff_t *pos)
 	__acquires(&vmap_purge_lock)
-- 
2.9.5

