Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009E0C0015E
	for <rcu@archiver.kernel.org>; Mon, 17 Jul 2023 18:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGQSFX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Jul 2023 14:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGQSFJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Jul 2023 14:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA601BD4;
        Mon, 17 Jul 2023 11:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DD3F611CF;
        Mon, 17 Jul 2023 18:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92600C433C9;
        Mon, 17 Jul 2023 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617095;
        bh=a+qFf3w4u9E73iijzqt1C1Oe4CG3736gzxYOpqJxCPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fqcZyjPf+/n6FWpk64kKMskETZOpf5iI5GKH2VZjLrg4eIS4o2vZqbv4Y7i2bKOBu
         Ny8uU1JsVN110wxBh6evNZLPYgDnUhk4TWfh9Xr89UIwI0WVQPn1J12SAqzKdDPvlP
         3zSq0o4dqlwg60z7+MRXZ8YUtbEA2FMY9Uzqb7YHLfMEKwQ+t7whihM73pC8Ng264q
         QAsPyFe8nRnCcFhsikv08rGsmAgJn9ox/+NcNUxIjZwLQFscXG0oVf0QfqoPmlstgX
         1gN1ZGnNQ07lpEWbBAXcaUhjIbz/+vI+FARugBDWgOkjScZTunBtAN+mhdNwTHbPNq
         mNvNP6PHAaSSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 59BB8CE0806; Mon, 17 Jul 2023 11:04:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/5] rcu-tasks: Add kernel boot parameters for callback laziness
Date:   Mon, 17 Jul 2023 11:04:52 -0700
Message-Id: <20230717180454.1097714-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds kernel boot parameters for callback laziness, allowing
the RCU Tasks flavors to be individually adjusted.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++++++++
 kernel/rcu/tasks.h                            | 15 ++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1457995fd41..a0f427e1a562 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5293,6 +5293,29 @@
 			A change in value does not take effect until
 			the beginning of the next grace period.
 
+	rcupdate.rcu_tasks_lazy_ms= [KNL]
+			Set timeout in milliseconds RCU Tasks asynchronous
+			callback batching for call_rcu_tasks().
+			A negative value will take the default.  A value
+			of zero will disable batching.	Batching is
+			always disabled for synchronize_rcu_tasks().
+
+	rcupdate.rcu_tasks_rude_lazy_ms= [KNL]
+			Set timeout in milliseconds RCU Tasks
+			Rude asynchronous callback batching for
+			call_rcu_tasks_rude().	A negative value
+			will take the default.	A value of zero will
+			disable batching.  Batching is always disabled
+			for synchronize_rcu_tasks_rude().
+
+	rcupdate.rcu_tasks_trace_lazy_ms= [KNL]
+			Set timeout in milliseconds RCU Tasks
+			Trace asynchronous callback batching for
+			call_rcu_tasks_trace().  A negative value
+			will take the default.	A value of zero will
+			disable batching.  Batching is always disabled
+			for synchronize_rcu_tasks_trace().
+
 	rcupdate.rcu_self_test= [KNL]
 			Run the RCU early boot self tests
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7eae67fbe47c..28e986627e3f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1083,11 +1083,16 @@ void rcu_barrier_tasks(void)
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 
+int rcu_tasks_lazy_ms = -1;
+module_param(rcu_tasks_lazy_ms, int, 0444);
+
 static int __init rcu_spawn_tasks_kthread(void)
 {
 	cblist_init_generic(&rcu_tasks);
 	rcu_tasks.gp_sleep = HZ / 10;
 	rcu_tasks.init_fract = HZ / 10;
+	if (rcu_tasks_lazy_ms >= 0)
+		rcu_tasks.lazy_jiffies = msecs_to_jiffies(rcu_tasks_lazy_ms);
 	rcu_tasks.pregp_func = rcu_tasks_pregp_step;
 	rcu_tasks.pertask_func = rcu_tasks_pertask;
 	rcu_tasks.postscan_func = rcu_tasks_postscan;
@@ -1236,10 +1241,15 @@ void rcu_barrier_tasks_rude(void)
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_tasks_rude);
 
+int rcu_tasks_rude_lazy_ms = -1;
+module_param(rcu_tasks_rude_lazy_ms, int, 0444);
+
 static int __init rcu_spawn_tasks_rude_kthread(void)
 {
 	cblist_init_generic(&rcu_tasks_rude);
 	rcu_tasks_rude.gp_sleep = HZ / 10;
+	if (rcu_tasks_rude_lazy_ms >= 0)
+		rcu_tasks_rude.lazy_jiffies = msecs_to_jiffies(rcu_tasks_rude_lazy_ms);
 	rcu_spawn_tasks_kthread_generic(&rcu_tasks_rude);
 	return 0;
 }
@@ -1856,6 +1866,9 @@ void rcu_barrier_tasks_trace(void)
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_tasks_trace);
 
+int rcu_tasks_trace_lazy_ms = -1;
+module_param(rcu_tasks_trace_lazy_ms, int, 0444);
+
 static int __init rcu_spawn_tasks_trace_kthread(void)
 {
 	cblist_init_generic(&rcu_tasks_trace);
@@ -1870,6 +1883,8 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 		if (rcu_tasks_trace.init_fract <= 0)
 			rcu_tasks_trace.init_fract = 1;
 	}
+	if (rcu_tasks_trace_lazy_ms >= 0)
+		rcu_tasks_trace.lazy_jiffies = msecs_to_jiffies(rcu_tasks_trace_lazy_ms);
 	rcu_tasks_trace.pregp_func = rcu_tasks_trace_pregp_step;
 	rcu_tasks_trace.postscan_func = rcu_tasks_trace_postscan;
 	rcu_tasks_trace.holdouts_func = check_all_holdout_tasks_trace;
-- 
2.40.1

