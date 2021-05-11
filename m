Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E6EC433B4
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE47C61625
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhEKW7V (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhEKW7U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:59:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8546661285;
        Tue, 11 May 2021 22:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773893;
        bh=hB/Ip9DddFZ8yj0PiQROHL7HE1jxW94s0lwjTYckcv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hf/C2FYUkbM8eG1plSMfYR2IOm4yqw8eZHwsUJDzq1DASIlyCCEc5ImbnRQzPmMWw
         HbBsTWe0AiLC7j4q+SHRfeL1JybG2Gavz9qvJ6tPe7/UzhZ7ObNvkl1jLYaZLj0/yN
         5g5YbaGrHF6jQgIfoq+XNjkw97OGaln3ZV+6A35au+0CDo3IZESIo/14JOtiZYhVTt
         GnOEi/KPbo8yJzKyh+Ydif1QkPU3jp7CQDg6NC2hizv3sbu6tHRhoncXpAZsv9Jijr
         1JB5/nce9sWQ+RWNiOVoSJz4RDeGEI9faL2jP1BMABgWg55FufTXjkjBLZMtCRlrrt
         G6T3ld2m8ztDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5B0715C014E; Tue, 11 May 2021 15:58:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vaneet Narang <v.narang@samsung.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/2] mm/slub: Add Support for free path information of an object
Date:   Tue, 11 May 2021 15:58:11 -0700
Message-Id: <20210511225811.2893697-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225744.GA2893615@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225744.GA2893615@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Maninder Singh <maninder1.s@samsung.com>

This commit adds enables a stack dump for the last free of an object:

slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 0 size 64 allocated at meminfo_proc_show+0x40/0x4fc
[   20.192078]     meminfo_proc_show+0x40/0x4fc
[   20.192263]     seq_read_iter+0x18c/0x4c4
[   20.192430]     proc_reg_read_iter+0x84/0xac
[   20.192617]     generic_file_splice_read+0xe8/0x17c
[   20.192816]     splice_direct_to_actor+0xb8/0x290
[   20.193008]     do_splice_direct+0xa0/0xe0
[   20.193185]     do_sendfile+0x2d0/0x438
[   20.193345]     sys_sendfile64+0x12c/0x140
[   20.193523]     ret_fast_syscall+0x0/0x58
[   20.193695]     0xbeeacde4
[   20.193822]  Free path:
[   20.193935]     meminfo_proc_show+0x5c/0x4fc
[   20.194115]     seq_read_iter+0x18c/0x4c4
[   20.194285]     proc_reg_read_iter+0x84/0xac
[   20.194475]     generic_file_splice_read+0xe8/0x17c
[   20.194685]     splice_direct_to_actor+0xb8/0x290
[   20.194870]     do_splice_direct+0xa0/0xe0
[   20.195014]     do_sendfile+0x2d0/0x438
[   20.195174]     sys_sendfile64+0x12c/0x140
[   20.195336]     ret_fast_syscall+0x0/0x58
[   20.195491]     0xbeeacde4

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/slab.h        |  1 +
 mm/slab_common.c | 12 +++++++++++-
 mm/slub.c        |  7 +++++++
 mm/util.c        |  2 +-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 18c1927cd196..7189daa0c586 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -640,6 +640,7 @@ struct kmem_obj_info {
 	struct kmem_cache *kp_slab_cache;
 	void *kp_ret;
 	void *kp_stack[KS_ADDRS_COUNT];
+	void *kp_free_stack[KS_ADDRS_COUNT];
 };
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page);
 #endif
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f8833d3e5d47..92e3aa78bb4d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -564,7 +564,7 @@ EXPORT_SYMBOL_GPL(kmem_valid_obj);
  * depends on the type of object and on how much debugging is enabled.
  * For a slab-cache object, the fact that it is a slab object is printed,
  * and, if available, the slab name, return address, and stack trace from
- * the allocation of that object.
+ * the allocation and last free path of that object.
  *
  * This function will splat if passed a pointer to a non-slab object.
  * If you are not sure what type of object you have, you should instead
@@ -609,6 +609,16 @@ void kmem_dump_obj(void *object)
 			break;
 		pr_info("    %pS\n", kp.kp_stack[i]);
 	}
+
+	if (kp.kp_free_stack[0])
+		pr_cont(" Free path:\n");
+
+	for (i = 0; i < ARRAY_SIZE(kp.kp_free_stack); i++) {
+		if (!kp.kp_free_stack[i])
+			break;
+		pr_info("    %pS\n", kp.kp_free_stack[i]);
+	}
+
 }
 EXPORT_SYMBOL_GPL(kmem_dump_obj);
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index 8f2d13508ec9..deec894a1345 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4011,6 +4011,13 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 		if (!kpp->kp_stack[i])
 			break;
 	}
+
+	trackp = get_track(s, objp, TRACK_FREE);
+	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
+		kpp->kp_free_stack[i] = (void *)trackp->addrs[i];
+		if (!kpp->kp_free_stack[i])
+			break;
+	}
 #endif
 #endif
 }
diff --git a/mm/util.c b/mm/util.c
index a8bf17f18a81..0b6dd9d81da7 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -983,7 +983,7 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
  * depends on the type of object and on how much debugging is enabled.
  * For example, for a slab-cache object, the slab name is printed, and,
  * if available, the return address and stack trace from the allocation
- * of that object.
+ * and last free path of that object.
  */
 void mem_dump_obj(void *object)
 {
-- 
2.31.1.189.g2e36527f23

