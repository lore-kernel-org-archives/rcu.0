Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12E2C4332E
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44A722D6F
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbhAFBSr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:18:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbhAFBSc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 20:18:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0581722E03;
        Wed,  6 Jan 2021 01:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609895872;
        bh=89la9VIbgxJoAiOtZh6vDNKFvb9uJilRSBqp+fBr5wE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRutX3aiqUpvAG+88HkSzREaDWr0CvykHbJfeThw+zQEdcM6Ss+dif4kKlLCo5WxK
         F47Jx4OTqjDc3pBiOxKtiwGPQx4/x+anciT0ZhIbIkC7UpyWyC1+56wD6rt/FUEbt4
         AeRQTXwgZWea4Dk905NoqbyDbDR5DWWhBuzhVO2pYhRQHr1xhVcnyB3mdYH8gqblrG
         SZA6Wq7Q781/xiqCinhEIGFP5vIlds4jgSaAdtVPmKuFw2aNDT869L6YtfqX44RMa2
         IcdtRhxeAUnvtkJ0rc/YFoBg0ZB7m5njlcPli1OSsGAxNPsJSfnjNSwtxo3gTvwLMd
         o3J1vRr2mazag==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        ming.lei@redhat.com, axboe@kernel.dk, kernel-team@fb.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH mm,percpu_ref,rcu 3/6] mm: Make mem_dump_obj() handle vmalloc() memory
Date:   Tue,  5 Jan 2021 17:17:47 -0800
Message-Id: <20210106011750.13709-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106011603.GA13180@paulmck-ThinkPad-P72>
References: <20210106011603.GA13180@paulmck-ThinkPad-P72>
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
index 80c0181..c18f475 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -246,4 +246,10 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
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
index 92f23d2..5487022 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -996,18 +996,20 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
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
index 4d88fe5..c274ea4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3448,6 +3448,18 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
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

