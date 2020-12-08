Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CB1C2BBCA
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 10:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB63A23AA7
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 10:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgLHKdY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 05:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgLHKdX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 05:33:23 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A35C06179C;
        Tue,  8 Dec 2020 02:32:43 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id 2so11952574ilg.9;
        Tue, 08 Dec 2020 02:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G0rmrX5wn8MCZBEoYSwDODhrHjeVyvrtreyjSLUldbY=;
        b=aoYGaxDEY5D2eBsez+wGB4CpTw3vKkIO/brLeUwGzmUKo8teulX/BI1Fsc2uC9QsM2
         ZI2BejER+3Gc7uSXig7V+AV0qCkD96KPbsI/IDDGEof36B6zsSjWkXvsAVN22GWNwxUb
         jNaCYFBQJe41OlFaIim2HfLdtMpRTaqYAP+oVF3kaXZcV18aUH9i9SUfYyuE0yHI7MBS
         bdwgKPvZpM/JI7aD7daq2xdqrQjcUS8MI/er6IvsfMR/NyQd3epxtd/fS6fKKsrTkY9j
         KVLVqzL5IGI4uPjfAeGw+PNn9ddcX3D/fR81lPtRaf+R108A9eZdnoReBRxb9EEDUh80
         z0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G0rmrX5wn8MCZBEoYSwDODhrHjeVyvrtreyjSLUldbY=;
        b=YTq1YxCtEDtxufCHabBrO9D2z249i459PPwtkDkTQwRFQxRdCXJxnpjF6gXFYI5Ga2
         Jie0KxQLQ70W3msNNO+pWF1GUOs71U07u2f4z83m3Bs22Db6+vB0wLSyyWSrvI6Y2SDV
         O2vP8wQ7Z82o1MQ+vjGIRVf2NixD5dE2czuvUa6/crClLeb0VnXwDt4jJERzNwu1g9qH
         vaMRmHWOAldXETUwTi5beNSueHJRHJ12ZOUdEssZNOuHMeyyTxZaY57FFBNJDjrL6FnE
         WEx147OfIpfbrjctHQXX5SoiyTZgljzmGyBLEGrI8io9ar1pGfV/fSGzhT3euLXeGY5b
         iyNQ==
X-Gm-Message-State: AOAM530HlkIIwfw34cnCd9q7TST8MQlKcWePS6MxnLwsA9jOKfZHRLDS
        1cN2nj4m64Pw6l15MQYhIMk=
X-Google-Smtp-Source: ABdhPJyfWDDrzpI3yRc5dYv73OYjl1jM8JkTfhU3LPvFEItEYhhNemdmysxpSbfaVxrzpbXnXEhEuw==
X-Received: by 2002:a92:b107:: with SMTP id t7mr6843677ilh.255.1607423562626;
        Tue, 08 Dec 2020 02:32:42 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w16sm3626562ilj.36.2020.12.08.02.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 02:32:41 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 23C1927C005C;
        Tue,  8 Dec 2020 05:32:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 08 Dec 2020 05:32:40 -0500
X-ME-Sender: <xms:R1bPX0b_2rC6ThFLAryk0BOWzJBaG_yjgO_d3s3Od1oFln4RnTprMw>
    <xme:R1bPX_awFV-1eJmrLrn-m5_mSCKyAqMiYNgVp8uvyKprk297UhrXLVssXo6Y9P6oF
    BXn1DbeQCWRx-zzSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduieejrddvvddtrddvrdduvdeinecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:R1bPX--0YWc9ZaGmUhqxGPEHmgVhDGdnKmvopmZKOe6znbFjhVbkPQ>
    <xmx:R1bPX-ovYCCAiu_QaGuDYiJPsKFcoaDywNl5QSinVxhdAkZRJPBJxA>
    <xmx:R1bPX_pm_IcAg8iJ2SphqagzHxJZZDkgPv_3lk-YheMgcQFwqsaLZQ>
    <xmx:SFbPX8irknlvu2YQn9w_mdPvpHcNc9go37l2Rf7zkMliA_h0095nSYPK5II>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id AE4DA240057;
        Tue,  8 Dec 2020 05:32:39 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC lockdep 4/4] lockdep/selftest: Add wait context selftests
Date:   Tue,  8 Dec 2020 18:31:12 +0800
Message-Id: <20201208103112.2838119-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208103112.2838119-1-boqun.feng@gmail.com>
References: <20201208103112.2838119-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

These tests are added for two purposes:

*	Test the implementation of wait context checks and related
	annotations.

*	Semi-document the rules for wait context nesting when
	PROVE_RAW_LOCK_NESTING=y.

The test cases are only avaible for PROVE_RAW_LOCK_NESTING=y, as wait
context checking makes more sense for that configuration.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 232 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 0af91a07fd18..c00ef4e69637 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -63,6 +63,9 @@ static DEFINE_SPINLOCK(lock_B);
 static DEFINE_SPINLOCK(lock_C);
 static DEFINE_SPINLOCK(lock_D);
 
+static DEFINE_RAW_SPINLOCK(raw_lock_A);
+static DEFINE_RAW_SPINLOCK(raw_lock_B);
+
 static DEFINE_RWLOCK(rwlock_A);
 static DEFINE_RWLOCK(rwlock_B);
 static DEFINE_RWLOCK(rwlock_C);
@@ -1306,6 +1309,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define I_SPINLOCK(x)	lockdep_reset_lock(&lock_##x.dep_map)
+# define I_RAW_SPINLOCK(x)	lockdep_reset_lock(&raw_lock_##x.dep_map)
 # define I_RWLOCK(x)	lockdep_reset_lock(&rwlock_##x.dep_map)
 # define I_MUTEX(x)	lockdep_reset_lock(&mutex_##x.dep_map)
 # define I_RWSEM(x)	lockdep_reset_lock(&rwsem_##x.dep_map)
@@ -1315,6 +1319,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
 #endif
 #else
 # define I_SPINLOCK(x)
+# define I_RAW_SPINLOCK(x)
 # define I_RWLOCK(x)
 # define I_MUTEX(x)
 # define I_RWSEM(x)
@@ -1358,9 +1363,12 @@ static void reset_locks(void)
 	I1(A); I1(B); I1(C); I1(D);
 	I1(X1); I1(X2); I1(Y1); I1(Y2); I1(Z1); I1(Z2);
 	I_WW(t); I_WW(t2); I_WW(o.base); I_WW(o2.base); I_WW(o3.base);
+	I_RAW_SPINLOCK(A); I_RAW_SPINLOCK(B);
 	lockdep_reset();
 	I2(A); I2(B); I2(C); I2(D);
 	init_shared_classes();
+	raw_spin_lock_init(&raw_lock_A);
+	raw_spin_lock_init(&raw_lock_B);
 
 	ww_mutex_init(&o, &ww_lockdep); ww_mutex_init(&o2, &ww_lockdep); ww_mutex_init(&o3, &ww_lockdep);
 	memset(&t, 0, sizeof(t)); memset(&t2, 0, sizeof(t2));
@@ -2358,6 +2366,226 @@ static void queued_read_lock_tests(void)
 	pr_cont("\n");
 }
 
+#define __guard(cleanup) __maybe_unused __attribute__((__cleanup__(cleanup)))
+
+static void hardirq_exit(int *_)
+{
+	HARDIRQ_EXIT();
+}
+
+#define HARDIRQ_CONTEXT(name, ...)					\
+	int hardirq_guard_##name __guard(hardirq_exit);			\
+	HARDIRQ_ENTER();
+
+#define NOTTHREADED_HARDIRQ_CONTEXT(name, ...)				\
+	int notthreaded_hardirq_guard_##name __guard(hardirq_exit);	\
+	local_irq_disable();						\
+	__irq_enter();							\
+	WARN_ON(!in_irq());
+
+static void softirq_exit(int *_)
+{
+	SOFTIRQ_EXIT();
+}
+
+#define SOFTIRQ_CONTEXT(name, ...)				\
+	int softirq_guard_##name __guard(softirq_exit);		\
+	SOFTIRQ_ENTER();
+
+static void rcu_exit(int *_)
+{
+	rcu_read_unlock();
+}
+
+#define RCU_CONTEXT(name, ...)					\
+	int rcu_guard_##name __guard(rcu_exit);			\
+	rcu_read_lock();
+
+static void rcu_bh_exit(int *_)
+{
+	rcu_read_unlock_bh();
+}
+
+#define RCU_BH_CONTEXT(name, ...)				\
+	int rcu_bh_guard_##name __guard(rcu_bh_exit);		\
+	rcu_read_lock_bh();
+
+static void rcu_sched_exit(int *_)
+{
+	rcu_read_unlock_sched();
+}
+
+#define RCU_SCHED_CONTEXT(name, ...)				\
+	int rcu_sched_guard_##name __guard(rcu_sched_exit);	\
+	rcu_read_lock_sched();
+
+static void rcu_callback_exit(int *_)
+{
+	rcu_lock_release(&rcu_callback_map);
+}
+
+#define RCU_CALLBACK_CONTEXT(name, ...)					\
+	int rcu_callback_guard_##name __guard(rcu_callback_exit);	\
+	rcu_lock_acquire(&rcu_callback_map);
+
+
+static void raw_spinlock_exit(raw_spinlock_t **lock)
+{
+	raw_spin_unlock(*lock);
+}
+
+#define RAW_SPINLOCK_CONTEXT(name, lock)						\
+	raw_spinlock_t *raw_spinlock_guard_##name __guard(raw_spinlock_exit) = &(lock);	\
+	raw_spin_lock(&(lock));
+
+static void spinlock_exit(spinlock_t **lock)
+{
+	spin_unlock(*lock);
+}
+
+#define SPINLOCK_CONTEXT(name, lock)						\
+	spinlock_t *spinlock_guard_##name __guard(spinlock_exit) = &(lock);	\
+	spin_lock(&(lock));
+
+static void mutex_exit(struct mutex **lock)
+{
+	mutex_unlock(*lock);
+}
+
+#define MUTEX_CONTEXT(name, lock)					\
+	struct mutex *mutex_guard_##name __guard(mutex_exit) = &(lock);	\
+	mutex_lock(&(lock));
+
+#define GENERATE_2_CONTEXT_TESTCASE(outer, outer_lock, inner, inner_lock)	\
+										\
+static void __maybe_unused inner##_in_##outer(void)				\
+{										\
+	outer##_CONTEXT(_, outer_lock);						\
+	{									\
+		inner##_CONTEXT(_, inner_lock);					\
+	}									\
+}
+
+/*
+ * wait contexts (considering PREEMPT_RT)
+ *
+ * o: inner is allowed in outer
+ * x: inner is disallowed in outer
+ *
+ *       \  inner |  RCU  | RAW_SPIN | SPIN | MUTEX
+ * outer  \       |       |          |      |
+ * ---------------+-------+----------+------+-------
+ * HARDIRQ        |   o   |    o     |  o   |  x
+ * ---------------+-------+----------+------+-------
+ * NOTTHREADED_IRQ|   o   |    o     |  x   |  x
+ * ---------------+-------+----------+------+-------
+ * SOFTIRQ        |   o   |    o     |  o   |  x
+ * ---------------+-------+----------+------+-------
+ * RCU            |   o   |    o     |  o   |  x
+ * ---------------+-------+----------+------+-------
+ * RCU_BH         |   o   |    o     |  o   |  x
+ * ---------------+-------+----------+------+-------
+ * RCU_CALLBACK   |   o   |    o     |  o   |  x
+ * ---------------+-------+----------+------+-------
+ * RCU_SCHED      |   o   |    o     |  x   |  x
+ * ---------------+-------+----------+------+-------
+ * RAW_SPIN       |   o   |    o     |  x   |  x
+ * ---------------+-------+----------+------+-------
+ * SPIN           |   o   |    o     |  o   |  x
+ * ---------------+-------+----------+------+-------
+ * MUTEX          |   o   |    o     |  o   |  o
+ * ---------------+-------+----------+------+-------
+ */
+
+#define GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(inner, inner_lock)		\
+GENERATE_2_CONTEXT_TESTCASE(HARDIRQ, , inner, inner_lock)			\
+GENERATE_2_CONTEXT_TESTCASE(NOTTHREADED_HARDIRQ, , inner, inner_lock)		\
+GENERATE_2_CONTEXT_TESTCASE(SOFTIRQ, , inner, inner_lock)			\
+GENERATE_2_CONTEXT_TESTCASE(RCU, , inner, inner_lock)				\
+GENERATE_2_CONTEXT_TESTCASE(RCU_BH, , inner, inner_lock)			\
+GENERATE_2_CONTEXT_TESTCASE(RCU_CALLBACK, , inner, inner_lock)			\
+GENERATE_2_CONTEXT_TESTCASE(RCU_SCHED, , inner, inner_lock)			\
+GENERATE_2_CONTEXT_TESTCASE(RAW_SPINLOCK, raw_lock_A, inner, inner_lock)	\
+GENERATE_2_CONTEXT_TESTCASE(SPINLOCK, lock_A, inner, inner_lock)		\
+GENERATE_2_CONTEXT_TESTCASE(MUTEX, mutex_A, inner, inner_lock)
+
+GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(RCU, )
+GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(RAW_SPINLOCK, raw_lock_B)
+GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(SPINLOCK, lock_B)
+GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(MUTEX, mutex_B)
+
+/* the outer context allows all kinds of preemption */
+#define DO_CONTEXT_TESTCASE_OUTER_PREEMPTIBLE(outer)			\
+	dotest(RCU_in_##outer, SUCCESS, LOCKTYPE_RWLOCK);		\
+	dotest(RAW_SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);	\
+	dotest(SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);		\
+	dotest(MUTEX_in_##outer, SUCCESS, LOCKTYPE_MUTEX);		\
+
+/*
+ * the outer context only allows the preemption introduced by spinlock_t (which
+ * is a sleepable lock for PREEMPT_RT)
+ */
+#define DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(outer)		\
+	dotest(RCU_in_##outer, SUCCESS, LOCKTYPE_RWLOCK);		\
+	dotest(RAW_SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);	\
+	dotest(SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);		\
+	dotest(MUTEX_in_##outer, FAILURE, LOCKTYPE_MUTEX);		\
+
+/* the outer doesn't allows any kind of preemption */
+#define DO_CONTEXT_TESTCASE_OUTER_NOT_PREEMPTIBLE(outer)			\
+	dotest(RCU_in_##outer, SUCCESS, LOCKTYPE_RWLOCK);		\
+	dotest(RAW_SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);	\
+	dotest(SPINLOCK_in_##outer, FAILURE, LOCKTYPE_SPIN);		\
+	dotest(MUTEX_in_##outer, FAILURE, LOCKTYPE_MUTEX);		\
+
+static void wait_context_tests(void)
+{
+	printk("  --------------------------------------------------------------------------\n");
+	printk("  | wait context tests |\n");
+	printk("  --------------------------------------------------------------------------\n");
+	printk("                                 | rcu  | raw  | spin |mutex |\n");
+	printk("  --------------------------------------------------------------------------\n");
+	print_testname("in hardirq context");
+	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(HARDIRQ);
+	pr_cont("\n");
+
+	print_testname("in hardirq context (not threaded)");
+	DO_CONTEXT_TESTCASE_OUTER_NOT_PREEMPTIBLE(NOTTHREADED_HARDIRQ);
+	pr_cont("\n");
+
+	print_testname("in softirq context");
+	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(SOFTIRQ);
+	pr_cont("\n");
+
+	print_testname("in RCU context");
+	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(RCU);
+	pr_cont("\n");
+
+	print_testname("in RCU-bh context");
+	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(RCU_BH);
+	pr_cont("\n");
+
+	print_testname("in RCU callback context");
+	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(RCU_CALLBACK);
+	pr_cont("\n");
+
+	print_testname("in RCU-sched context");
+	DO_CONTEXT_TESTCASE_OUTER_NOT_PREEMPTIBLE(RCU_SCHED);
+	pr_cont("\n");
+
+	print_testname("in RAW_SPINLOCK context");
+	DO_CONTEXT_TESTCASE_OUTER_NOT_PREEMPTIBLE(RAW_SPINLOCK);
+	pr_cont("\n");
+
+	print_testname("in SPINLOCK context");
+	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(SPINLOCK);
+	pr_cont("\n");
+
+	print_testname("in MUTEX context");
+	DO_CONTEXT_TESTCASE_OUTER_PREEMPTIBLE(MUTEX);
+	pr_cont("\n");
+}
+
 void locking_selftest(void)
 {
 	/*
@@ -2479,6 +2707,10 @@ void locking_selftest(void)
 	if (IS_ENABLED(CONFIG_QUEUED_RWLOCKS))
 		queued_read_lock_tests();
 
+	/* Wait context test cases that are specific for RAW_LOCK_NESTING */
+	if (IS_ENABLED(CONFIG_PROVE_RAW_LOCK_NESTING))
+		wait_context_tests();
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;
-- 
2.29.2

