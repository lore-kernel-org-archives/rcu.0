Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CC4C433EF
	for <rcu@archiver.kernel.org>; Tue,  1 Mar 2022 17:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiCARnq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiCARnp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 1 Mar 2022 12:43:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13951B798
        for <rcu@vger.kernel.org>; Tue,  1 Mar 2022 09:43:04 -0800 (PST)
Date:   Tue, 1 Mar 2022 18:43:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646156582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/wtmJZu9F2Ybm3e/MMxOdNdZcFqox0wl4GeyxJhlapk=;
        b=gj+73g6W+R4L3IxL2HBhoQZFsVe2Msl12iJ6227OaKHJkbLx4Dgn6No3Cdjj+6eaOI2ADR
        c7Pu1redggNI/2fGn3cSvbH/+LQMFBwsowIN/ueMRVUIrFC6si0/xFDxPJoQc+3Atd3Fu/
        YRQyCkwDTsALtr+lMc7ydeCcnLSGda7rJMOpNAmi6pW/0W+JGEXsRxnlx3y74zaEJWkozP
        c16UEaYjA5MihwCTXxVvMgVZy5IgwiD5hsHK0fObXp2X9I6N4tJJzf62dQxTHwbilJB8VB
        F2ucGSZKV/oT9UzAMYY28kE3dVr5HztYGT/uubfnFrftza5jmA2bLTi//jY9Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646156582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/wtmJZu9F2Ybm3e/MMxOdNdZcFqox0wl4GeyxJhlapk=;
        b=PtYtiBH4NSirS/rb5Hg6e7KrasJVjZinPI10OBiJmN98Zo7E8jC/9w0M0nOMZ5x/3bDVRS
        MooHdtQOSj/AG7DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <Yh5bJZmAXXGtgTIl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The RCU-sefltest expects tthe timer_list timer to be working. This isn't
the case on PREEMPT_RT at this point because it requires that ksoftirqd
is up and running.
There is no known requirement that synchronize_rcu() works at this
point.

Delay RCU-selftests until ksoftirqd is up and running.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Paul, I don't mean to be rude or anything by saying that "There is no
requirement=E2=80=A6". If my memory serves me well here (and there is no
guarantee for that) then synchronize_rcu() was required that early by
kprobes or jump labels and this requirement was lifted by the time we
discussed this. I have no idea how this discussion back then ended but
as of v5.17-rc6 that timer is still required to function in order for
the system to make progress at boot time.

 include/linux/rcupdate.h |  6 ++++++
 init/main.c              |  1 +
 kernel/rcu/tasks.h       | 10 +++-------
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 88b42eb464068..2fb1a48ca9272 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -95,6 +95,12 @@ void rcu_init_tasks_generic(void);
 static inline void rcu_init_tasks_generic(void) { }
 #endif
=20
+#if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TASKS_RCU_GENERIC)
+void rcu_tasks_initiate_self_tests(void);
+#else
+static inline void rcu_tasks_initiate_self_tests(void) {}
+#endif
+
 #ifdef CONFIG_RCU_STALL_COMMON
 void rcu_sysrq_start(void);
 void rcu_sysrq_end(void);
diff --git a/init/main.c b/init/main.c
index 65fa2e41a9c09..cfc45e47b9ca4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1600,6 +1600,7 @@ static noinline void __init kernel_init_freeable(void)
=20
 	rcu_init_tasks_generic();
 	do_pre_smp_initcalls();
+	rcu_tasks_initiate_self_tests();
 	lockup_detector_init();
=20
 	smp_init();
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d64f0b1d8cd3b..215c2c0f6c184 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1659,9 +1659,10 @@ static void test_rcu_tasks_callback(struct rcu_head =
*rhp)
 	pr_info("Callback from %s invoked.\n", rttd->name);
=20
 	rttd->notrun =3D true;
+	WARN_ON(1);
 }
=20
-static void rcu_tasks_initiate_self_tests(void)
+void rcu_tasks_initiate_self_tests(void)
 {
 	pr_info("Running RCU-tasks wait API self tests\n");
 #ifdef CONFIG_TASKS_RCU
@@ -1698,9 +1699,7 @@ static int rcu_tasks_verify_self_tests(void)
 	return ret;
 }
 late_initcall(rcu_tasks_verify_self_tests);
-#else /* #ifdef CONFIG_PROVE_RCU */
-static void rcu_tasks_initiate_self_tests(void) { }
-#endif /* #else #ifdef CONFIG_PROVE_RCU */
+#endif /* #ifdef CONFIG_PROVE_RCU */
=20
 void __init rcu_init_tasks_generic(void)
 {
@@ -1715,9 +1714,6 @@ void __init rcu_init_tasks_generic(void)
 #ifdef CONFIG_TASKS_TRACE_RCU
 	rcu_spawn_tasks_trace_kthread();
 #endif
-
-	// Run the self-tests.
-	rcu_tasks_initiate_self_tests();
 }
=20
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
--=20
2.35.1

