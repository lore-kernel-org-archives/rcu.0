Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26601C43217
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083F822E03
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbhAFA6f (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbhAFA6f (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 19:58:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CA3C230FC;
        Wed,  6 Jan 2021 00:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894658;
        bh=sx83u8RvEdCbrS0T2cs6kQ176hCXWXFL8UXSbCZYJec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G42jUYonegEgizmP8RBkUj2NTPQzvwYOK6/uiqK5TR5lzWwE6RdsFHxJ8xHBuq8QF
         qNoCHeHzjXpmSb5kxJuUEELEuQIG74ANVWO6V0GWX+Kbb5un9J88cNNbEsAhWsc6ej
         yXYP1VM8y4Ggq6vygjDvk5IL+N5hPqxv/y/sTLij6MrkquMsAzsI3IeXdkv39ovaRl
         UEEbVG3EwMqxeNfG0A+5HQYEmvE5MQCJsCzFS/wqZje8v+xziv6fIiQvhEK3JL65S5
         1NAgWD8HsI0L9diMdNBsbHYbQ/RDpSuBXtApbFEeLvzRzImmSMVMjuwSEW1n6UC/0g
         DuuF4fpzn8+gQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 5/6] rcu-tasks: Add RCU-tasks self tests
Date:   Tue,  5 Jan 2021 16:57:35 -0800
Message-Id: <20210106005736.12613-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106005713.GA12492@paulmck-ThinkPad-P72>
References: <20210106005713.GA12492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

This commit adds self tests for early-boot use of RCU-tasks grace periods.
It tests all three variants (Rude, Tasks, and Tasks Trace) and covers
both synchronous (e.g., synchronize_rcu_tasks()) and asynchronous (e.g.,
call_rcu_tasks()) grace-period APIs.

Self-tests are run only in kernels built with CONFIG_PROVE_RCU=y.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
[ paulmck: Handle CONFIG_PROVE_RCU=n and identify test cases' callbacks. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 73bbe79..74767d3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1231,6 +1231,82 @@ void show_rcu_tasks_gp_kthreads(void)
 }
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+#ifdef CONFIG_PROVE_RCU
+struct rcu_tasks_test_desc {
+	struct rcu_head rh;
+	const char *name;
+	bool notrun;
+};
+
+static struct rcu_tasks_test_desc tests[] = {
+	{
+		.name = "call_rcu_tasks()",
+		/* If not defined, the test is skipped. */
+		.notrun = !IS_ENABLED(CONFIG_TASKS_RCU),
+	},
+	{
+		.name = "call_rcu_tasks_rude()",
+		/* If not defined, the test is skipped. */
+		.notrun = !IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
+	},
+	{
+		.name = "call_rcu_tasks_trace()",
+		/* If not defined, the test is skipped. */
+		.notrun = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
+	}
+};
+
+static void test_rcu_tasks_callback(struct rcu_head *rhp)
+{
+	struct rcu_tasks_test_desc *rttd =
+		container_of(rhp, struct rcu_tasks_test_desc, rh);
+
+	pr_info("Callback from %s invoked.\n", rttd->name);
+
+	rttd->notrun = true;
+}
+
+static void rcu_tasks_initiate_self_tests(void)
+{
+	pr_info("Running RCU-tasks wait API self tests\n");
+#ifdef CONFIG_TASKS_RCU
+	synchronize_rcu_tasks();
+	call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+	synchronize_rcu_tasks_rude();
+	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
+#endif
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+	synchronize_rcu_tasks_trace();
+	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
+#endif
+}
+
+static int rcu_tasks_verify_self_tests(void)
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (!tests[i].notrun) {		// still hanging.
+			pr_err("%s has been failed.\n", tests[i].name);
+			ret = -1;
+		}
+	}
+
+	if (ret)
+		WARN_ON(1);
+
+	return ret;
+}
+late_initcall(rcu_tasks_verify_self_tests);
+#else /* #ifdef CONFIG_PROVE_RCU */
+static void rcu_tasks_initiate_self_tests(void) { }
+#endif /* #else #ifdef CONFIG_PROVE_RCU */
+
 void __init rcu_init_tasks_generic(void)
 {
 #ifdef CONFIG_TASKS_RCU
@@ -1244,6 +1320,9 @@ void __init rcu_init_tasks_generic(void)
 #ifdef CONFIG_TASKS_TRACE_RCU
 	rcu_spawn_tasks_trace_kthread();
 #endif
+
+	// Run the self-tests.
+	rcu_tasks_initiate_self_tests();
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
-- 
2.9.5

