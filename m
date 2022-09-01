Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7F3C54EE9
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 22:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiIAWSm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiIAWSK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:10 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845AC5A2D2
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 15:18:05 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id cr9so202789qtb.13
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 15:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=iF0VQ620OmNNEeBQv3gOJrSK8RXzJIsiopJiGn2gXgE=;
        b=SBhFYlQ3f3i6jV7HBq4Orbuwu/hinW5fDS4ifU7J74KEwQlKYPt/auQAncrY9fVdcu
         5aTjF9w2HhCnuHyPQCCO0vD25oTat84cFEXTuBIKNKGkVKKSvEreggR7kMkSFMbjjldR
         i8wuBUjYYWqJSbR7o2Nre3jfWKBbsb2Lamrto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=iF0VQ620OmNNEeBQv3gOJrSK8RXzJIsiopJiGn2gXgE=;
        b=wL168X8x6ORx0pO7WioIjapzP3rZeOe5jXICSsq7zlrD4tDb5JawCGHO/IlzhyZnUZ
         EVyc0Yq0jZHg4L4lIl5Ga7Vx/oDOIsWX3YfxtBCIo3uVRmeqMQoHeadn8NvRghKxzbKO
         61N+JNJskroDyJ8RAjwKGvhgfZONTgBSHy8EA0DcTGiQhrFnfKLuBa2/N9ZhfN+cEBD3
         /It7E92jHH4vDdL6NrOyUPKE/shwjHn/7MScNvGY1Unji9L+DZxVS8IUX4K6ykW/S2dL
         rwrA9FH87nUHWSzvM0pQZJfeQQjUm4Ekdr6cdIp/KRcdPstTByIVSbtxU/NckybarK7t
         qJ7g==
X-Gm-Message-State: ACgBeo0lR/9r55ddX2IcHC5hoDA3ya0rB5QW9/UUvSGtBtLET/AKlMr2
        Xzhoa64bOQVyABLZHA3DWKEt1c4IF+ZZ5g==
X-Google-Smtp-Source: AA6agR7H18+EdoJRj/8Zp5aQpkjWP9gIyH82b2JWKmLuxIWI5VEu84ZwMh5yQZdQ8rViSDXh8dHaDg==
X-Received: by 2002:a05:622a:614:b0:343:487:45d1 with SMTP id z20-20020a05622a061400b00343048745d1mr25242495qta.443.1662070684496;
        Thu, 01 Sep 2022 15:18:04 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:04 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 10/18] rcutorture: Add test code for call_rcu_lazy()
Date:   Thu,  1 Sep 2022 22:17:12 +0000
Message-Id: <20220901221720.1105021-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We add a new RCU type to test call_rcu_lazy(). This allows us to just
override the '.call' callback. To compensate for the laziness, we force
the laziness to a small number of jiffies. The idea of this test is to
stress the new code paths for stability and ensure it at least is providing
behavior in parity with, or similar to, call_rcu(). The actual check for
amount of laziness is in another test (rcuscale).

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h                              |  1 +
 kernel/rcu/rcutorture.c                       | 60 ++++++++++++++++++-
 kernel/rcu/tree.c                             |  1 +
 .../selftests/rcutorture/configs/rcu/CFLIST   |  1 +
 .../selftests/rcutorture/configs/rcu/TREE11   | 18 ++++++
 .../rcutorture/configs/rcu/TREE11.boot        |  8 +++
 6 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 94675f14efe8..a6efb831673f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -471,6 +471,7 @@ enum rcutorture_type {
 	RCU_TASKS_TRACING_FLAVOR,
 	RCU_TRIVIAL_FLAVOR,
 	SRCU_FLAVOR,
+	RCU_LAZY_FLAVOR,
 	INVALID_RCU_FLAVOR
 };
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9ad5301385a4..b4114f29ab61 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -927,6 +927,64 @@ static struct rcu_torture_ops tasks_rude_ops = {
 
 #endif // #else #ifdef CONFIG_TASKS_RUDE_RCU
 
+#ifdef CONFIG_RCU_LAZY
+
+/*
+ * Definitions for lazy RCU torture testing.
+ */
+static unsigned long orig_jiffies_till_flush;
+
+static void rcu_sync_torture_init_lazy(void)
+{
+	rcu_sync_torture_init();
+
+	orig_jiffies_till_flush = rcu_lazy_get_jiffies_till_flush();
+	rcu_lazy_set_jiffies_till_flush(50);
+}
+
+static void rcu_lazy_cleanup(void)
+{
+	rcu_lazy_set_jiffies_till_flush(orig_jiffies_till_flush);
+}
+
+static struct rcu_torture_ops rcu_lazy_ops = {
+	.ttype			= RCU_LAZY_FLAVOR,
+	.init			= rcu_sync_torture_init_lazy,
+	.cleanup		= rcu_lazy_cleanup,
+	.readlock		= rcu_torture_read_lock,
+	.read_delay		= rcu_read_delay,
+	.readunlock		= rcu_torture_read_unlock,
+	.readlock_held		= torture_readlock_not_held,
+	.get_gp_seq		= rcu_get_gp_seq,
+	.gp_diff		= rcu_seq_diff,
+	.deferred_free		= rcu_torture_deferred_free,
+	.sync			= synchronize_rcu,
+	.exp_sync		= synchronize_rcu_expedited,
+	.get_gp_state		= get_state_synchronize_rcu,
+	.start_gp_poll		= start_poll_synchronize_rcu,
+	.poll_gp_state		= poll_state_synchronize_rcu,
+	.cond_sync		= cond_synchronize_rcu,
+	.call			= call_rcu_lazy,
+	.cb_barrier		= rcu_barrier,
+	.fqs			= rcu_force_quiescent_state,
+	.stats			= NULL,
+	.gp_kthread_dbg		= show_rcu_gp_kthreads,
+	.check_boost_failed	= rcu_check_boost_fail,
+	.stall_dur		= rcu_jiffies_till_stall_check,
+	.irq_capable		= 1,
+	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
+	.extendables		= RCUTORTURE_MAX_EXTEND,
+	.name			= "rcu_lazy"
+};
+
+#define LAZY_OPS &rcu_lazy_ops,
+
+#else // #ifdef CONFIG_RCU_LAZY
+
+#define LAZY_OPS
+
+#endif // #else #ifdef CONFIG_RCU_LAZY
+
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 
@@ -3466,7 +3524,7 @@ rcu_torture_init(void)
 	unsigned long gp_seq = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops, &busted_srcud_ops,
-		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
+		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS LAZY_OPS
 		&trivial_ops,
 	};
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8111d9f37621..08bafe13c3ad 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -537,6 +537,7 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 {
 	switch (test_type) {
 	case RCU_FLAVOR:
+	case RCU_LAZY_FLAVOR:
 		*flags = READ_ONCE(rcu_state.gp_flags);
 		*gp_seq = rcu_seq_current(&rcu_state.gp_seq);
 		break;
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index 98b6175e5aa0..609c3370616f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -5,6 +5,7 @@ TREE04
 TREE05
 TREE07
 TREE09
+TREE11
 SRCU-N
 SRCU-P
 SRCU-T
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE11 b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
new file mode 100644
index 000000000000..436013f3e015
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
@@ -0,0 +1,18 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+#CHECK#CONFIG_PREEMPT_RCU=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_TRACE=y
+CONFIG_HOTPLUG_CPU=y
+CONFIG_MAXSMP=y
+CONFIG_CPUMASK_OFFSTACK=y
+CONFIG_RCU_NOCB_CPU=y
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_LAZY=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
new file mode 100644
index 000000000000..9b6f720d4ccd
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
@@ -0,0 +1,8 @@
+maxcpus=8 nr_cpus=43
+rcutree.gp_preinit_delay=3
+rcutree.gp_init_delay=3
+rcutree.gp_cleanup_delay=3
+rcu_nocbs=0-7
+rcutorture.torture_type=rcu_lazy
+rcutorture.nocbs_nthreads=8
+rcutorture.fwd_progress=0
-- 
2.37.2.789.g6183377224-goog

