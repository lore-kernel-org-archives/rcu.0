Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D7EC4332E
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B08664F70
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbhCDBAz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1447185AbhCDATs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:19:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3A9C64EDF;
        Thu,  4 Mar 2021 00:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817051;
        bh=6wzCHalKqT2clkokLo4omnOXU5pJLA0F5TQZMCcWLXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/Obcz3f1aVbUXAvmSPSRcjZGU1B0DzIbew3vG4t59pPvKVIsQLG3lDB8kF8/dE3Z
         2nOll+zDI1MuyrAbW78SULUHmbNoQTnjrN/m9RqeSCx1j7vXye/WNfjAYQrz2mpq3f
         JXa17O8QLi6Hf+A59zaUqyj4k1hn60B6TYvOy4GKaQymGQwyPFYfRMHMZDje5Nl+bu
         dQs/b+23Rel0kHl2229Dx0oLg0ekdVb4TkIEhRgE67nAhMR0+tycM2EkU3g93EOT3E
         k7rLPparOkER3p1YKYk1aUBmEKeLH3n+KdVfAXLAJ0vrZ8P1KZwqMdv55Dd6ZJKZR2
         WGdHtZwFShWKQ==
From:   paulmck@kernel.org
To:     linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        kernel-team@fb.com, mingo@kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/2] rcutorture: Add crude tests for mem_dump_obj()
Date:   Wed,  3 Mar 2021 16:17:28 -0800
Message-Id: <20210304001728.23321-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304001623.GA23196@paulmck-ThinkPad-P72>
References: <20210304001623.GA23196@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a few crude tests for mem_dump_obj() to rcutorture
runs.  Just to prevent bitrot, you understand!

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 39 +++++++++++++++++++++++++++++++++++++++
 mm/slab_common.c        |  2 ++
 mm/util.c               |  1 +
 3 files changed, 42 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 99657ff..8e93f2e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1861,6 +1861,45 @@ rcu_torture_stats(void *arg)
 		torture_shutdown_absorb("rcu_torture_stats");
 	} while (!torture_must_stop());
 	torture_kthread_stopping("rcu_torture_stats");
+
+	{
+		struct rcu_head *rhp;
+		struct kmem_cache *kcp;
+		static int z;
+
+		kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);
+		rhp = kmem_cache_alloc(kcp, GFP_KERNEL);
+		pr_alert("mem_dump_obj() slab test: rcu_torture_stats = %px, &rhp = %px, rhp = %px, &z = %px\n", stats_task, &rhp, rhp, &z);
+		pr_alert("mem_dump_obj(ZERO_SIZE_PTR):");
+		mem_dump_obj(ZERO_SIZE_PTR);
+		pr_alert("mem_dump_obj(NULL):");
+		mem_dump_obj(NULL);
+		pr_alert("mem_dump_obj(%px):", &rhp);
+		mem_dump_obj(&rhp);
+		pr_alert("mem_dump_obj(%px):", rhp);
+		mem_dump_obj(rhp);
+		pr_alert("mem_dump_obj(%px):", &rhp->func);
+		mem_dump_obj(&rhp->func);
+		pr_alert("mem_dump_obj(%px):", &z);
+		mem_dump_obj(&z);
+		kmem_cache_free(kcp, rhp);
+		kmem_cache_destroy(kcp);
+		rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
+		pr_alert("mem_dump_obj() kmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
+		pr_alert("mem_dump_obj(kmalloc %px):", rhp);
+		mem_dump_obj(rhp);
+		pr_alert("mem_dump_obj(kmalloc %px):", &rhp->func);
+		mem_dump_obj(&rhp->func);
+		kfree(rhp);
+		rhp = vmalloc(4096);
+		pr_alert("mem_dump_obj() vmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
+		pr_alert("mem_dump_obj(vmalloc %px):", rhp);
+		mem_dump_obj(rhp);
+		pr_alert("mem_dump_obj(vmalloc %px):", &rhp->func);
+		mem_dump_obj(&rhp->func);
+		vfree(rhp);
+	}
+
 	return 0;
 }
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index cec9536..4c6107e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -545,6 +545,7 @@ bool kmem_valid_obj(void *object)
 	page = virt_to_head_page(object);
 	return PageSlab(page);
 }
+EXPORT_SYMBOL_GPL(kmem_valid_obj);
 
 /**
  * kmem_dump_obj - Print available slab provenance information
@@ -601,6 +602,7 @@ void kmem_dump_obj(void *object)
 		pr_info("    %pS\n", kp.kp_stack[i]);
 	}
 }
+EXPORT_SYMBOL_GPL(kmem_dump_obj);
 #endif
 
 #ifndef CONFIG_SLOB
diff --git a/mm/util.c b/mm/util.c
index 2d497fe..c37e24d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1014,4 +1014,5 @@ void mem_dump_obj(void *object)
 	}
 	pr_cont(" non-slab/vmalloc memory.\n");
 }
+EXPORT_SYMBOL_GPL(mem_dump_obj);
 #endif
-- 
2.9.5

