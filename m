Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F92DC4363C
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB5061932
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhEKXNn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230336AbhEKXNd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90FB561963;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=ooQpLhakMF+iC+06mvjV16KpkMzrtX0sKaEg6443Vp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbzlOW/dTaZfj3bXtw/hVUHgmSSJMxMXwJqXtXCr0DWMFn+PtRyZYr0cuGcaWsvwM
         xWb3wIeHH8mZb1lbDXTvXDT8YPMrG6yiqJLEbc4JFx6fhjiEaLBmFJOQp3RqA94aXR
         spvm5rXf11Ocm4xbWL1aZZN8g/T7dHQYBY/6Ugyj7yxGPzh0sxeGh6N/GmIrtDIzyy
         kg+f8zOAVrg4m3TM42I/PyGBV8P/7sEofqyuiUQkFVhBKcMTMsvfzrO92mqNNspLLA
         NlfOwsE2B4fnqq7BKpeoOV44+dLobcN1f8zfaoo1v97HC4vV7zYTDPwQD6uEF4YaE/
         N7IScI7TSCmmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 974735C0EBE; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 25/26] rcutorture: Move mem_dump_obj() tests into separate function
Date:   Tue, 11 May 2021 16:12:22 -0700
Message-Id: <20210511231223.2895398-25-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

To make the purpose of the code more apparent, this commit moves the
tests of mem_dump_obj() to a new rcu_torture_mem_dump_obj() function
and calls it from rcu_torture_cleanup().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 81 +++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8b347b9659aa..ec69273898af 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1868,48 +1868,49 @@ rcu_torture_stats(void *arg)
 		torture_shutdown_absorb("rcu_torture_stats");
 	} while (!torture_must_stop());
 	torture_kthread_stopping("rcu_torture_stats");
-
-	{
-		struct rcu_head *rhp;
-		struct kmem_cache *kcp;
-		static int z;
-
-		kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);
-		rhp = kmem_cache_alloc(kcp, GFP_KERNEL);
-		pr_alert("mem_dump_obj() slab test: rcu_torture_stats = %px, &rhp = %px, rhp = %px, &z = %px\n", stats_task, &rhp, rhp, &z);
-		pr_alert("mem_dump_obj(ZERO_SIZE_PTR):");
-		mem_dump_obj(ZERO_SIZE_PTR);
-		pr_alert("mem_dump_obj(NULL):");
-		mem_dump_obj(NULL);
-		pr_alert("mem_dump_obj(%px):", &rhp);
-		mem_dump_obj(&rhp);
-		pr_alert("mem_dump_obj(%px):", rhp);
-		mem_dump_obj(rhp);
-		pr_alert("mem_dump_obj(%px):", &rhp->func);
-		mem_dump_obj(&rhp->func);
-		pr_alert("mem_dump_obj(%px):", &z);
-		mem_dump_obj(&z);
-		kmem_cache_free(kcp, rhp);
-		kmem_cache_destroy(kcp);
-		rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
-		pr_alert("mem_dump_obj() kmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
-		pr_alert("mem_dump_obj(kmalloc %px):", rhp);
-		mem_dump_obj(rhp);
-		pr_alert("mem_dump_obj(kmalloc %px):", &rhp->func);
-		mem_dump_obj(&rhp->func);
-		kfree(rhp);
-		rhp = vmalloc(4096);
-		pr_alert("mem_dump_obj() vmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
-		pr_alert("mem_dump_obj(vmalloc %px):", rhp);
-		mem_dump_obj(rhp);
-		pr_alert("mem_dump_obj(vmalloc %px):", &rhp->func);
-		mem_dump_obj(&rhp->func);
-		vfree(rhp);
-	}
-
 	return 0;
 }
 
+/* Test mem_dump_obj() and friends.  */
+static void rcu_torture_mem_dump_obj(void)
+{
+	struct rcu_head *rhp;
+	struct kmem_cache *kcp;
+	static int z;
+
+	kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);
+	rhp = kmem_cache_alloc(kcp, GFP_KERNEL);
+	pr_alert("mem_dump_obj() slab test: rcu_torture_stats = %px, &rhp = %px, rhp = %px, &z = %px\n", stats_task, &rhp, rhp, &z);
+	pr_alert("mem_dump_obj(ZERO_SIZE_PTR):");
+	mem_dump_obj(ZERO_SIZE_PTR);
+	pr_alert("mem_dump_obj(NULL):");
+	mem_dump_obj(NULL);
+	pr_alert("mem_dump_obj(%px):", &rhp);
+	mem_dump_obj(&rhp);
+	pr_alert("mem_dump_obj(%px):", rhp);
+	mem_dump_obj(rhp);
+	pr_alert("mem_dump_obj(%px):", &rhp->func);
+	mem_dump_obj(&rhp->func);
+	pr_alert("mem_dump_obj(%px):", &z);
+	mem_dump_obj(&z);
+	kmem_cache_free(kcp, rhp);
+	kmem_cache_destroy(kcp);
+	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
+	pr_alert("mem_dump_obj() kmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
+	pr_alert("mem_dump_obj(kmalloc %px):", rhp);
+	mem_dump_obj(rhp);
+	pr_alert("mem_dump_obj(kmalloc %px):", &rhp->func);
+	mem_dump_obj(&rhp->func);
+	kfree(rhp);
+	rhp = vmalloc(4096);
+	pr_alert("mem_dump_obj() vmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
+	pr_alert("mem_dump_obj(vmalloc %px):", rhp);
+	mem_dump_obj(rhp);
+	pr_alert("mem_dump_obj(vmalloc %px):", &rhp->func);
+	mem_dump_obj(&rhp->func);
+	vfree(rhp);
+}
+
 static void
 rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 {
@@ -2825,6 +2826,8 @@ rcu_torture_cleanup(void)
 	if (cur_ops->cleanup != NULL)
 		cur_ops->cleanup();
 
+	rcu_torture_mem_dump_obj();
+
 	rcu_torture_stats_print();  /* -After- the stats thread is stopped! */
 
 	if (err_segs_recorded) {
-- 
2.31.1.189.g2e36527f23

