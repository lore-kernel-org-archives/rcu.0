Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0D9C43331
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A71123123
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbhAFRSe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbhAFRSd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:18:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 555792313B;
        Wed,  6 Jan 2021 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953433;
        bh=3kX2wJM1kITf2v3KhETDs7iJ4JMm4wxmLsyNdpPrfQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/3Fa5dN5IrPkFjfhBtsP8HDLj/OcG49LU7MAK/vG2+Uvm4+cObmlFiA6m8usM3yy
         FayjC+s+T+xdEOwKIybFY///W8m+Bui0uKlC50JBL4b5Ugi2vbXtGHT6us9KWizLEu
         2lic9LKqo97hNtfoLpnqe2bZS+hKWmIHsH1lcaZHI7n3fiI0MEBBXwqQG2hG1Zd2Tt
         +tWqJA/HJfMlDjcTu6u+6UVRD9IBOPVe3zcPur5uqwLEfu/erHYZpGwhnK5TIZI73H
         SEz0gQdii1bWEEKlbwPqbXk99aqFCSsFrxcapqIb5WDXvlA4tsdeQ0jIj9OU8OuBUd
         kYKKDTkOXA2dw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/17] torture: Add fuzzed hrtimer-based sleep functions
Date:   Wed,  6 Jan 2021 09:17:00 -0800
Message-Id: <20210106171710.22239-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds torture_hrtimeout_ns(), torture_hrtimeout_us(),
torture_hrtimeout_ms(), torture_hrtimeout_jiffies(), and
torture_hrtimeout_s(), each of which uses hrtimers to block for a fuzzed
time interval.  These functions are intended to be used by the various
torture tests to decouple wakeups from the timer wheel, thus providing
more opportunity for Murphy to insert destructive race conditions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/torture.h |  7 +++++
 kernel/torture.c        | 75 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 7f65bd1..32941f8 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -61,6 +61,13 @@ static inline void torture_random_init(struct torture_random_state *trsp)
 	trsp->trs_count = 0;
 }
 
+/* Definitions for high-resolution-timer sleeps. */
+int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, struct torture_random_state *trsp);
+int torture_hrtimeout_us(u32 baset_us, u32 fuzzt_ns, struct torture_random_state *trsp);
+int torture_hrtimeout_ms(u32 baset_ms, u32 fuzzt_us, struct torture_random_state *trsp);
+int torture_hrtimeout_jiffies(u32 baset_j, struct torture_random_state *trsp);
+int torture_hrtimeout_s(u32 baset_s, u32 fuzzt_ms, struct torture_random_state *trsp);
+
 /* Task shuffler, which causes CPUs to occasionally go idle. */
 void torture_shuffle_task_register(struct task_struct *tp);
 int torture_shuffle_init(long shuffint);
diff --git a/kernel/torture.c b/kernel/torture.c
index 8562ac18..7548634 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -58,6 +58,81 @@ static int verbose;
 static int fullstop = FULLSTOP_RMMOD;
 static DEFINE_MUTEX(fullstop_mutex);
 
+/*
+ * Schedule a high-resolution-timer sleep in nanoseconds, with a 32-bit
+ * nanosecond random fuzz.  This function and its friends desynchronize
+ * testing from the timer wheel.
+ */
+int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, struct torture_random_state *trsp)
+{
+	ktime_t hto = baset_ns;
+
+	if (trsp)
+		hto += (torture_random(trsp) >> 3) % fuzzt_ns;
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	return schedule_hrtimeout(&hto, HRTIMER_MODE_REL);
+}
+EXPORT_SYMBOL_GPL(torture_hrtimeout_ns);
+
+/*
+ * Schedule a high-resolution-timer sleep in microseconds, with a 32-bit
+ * nanosecond (not microsecond!) random fuzz.
+ */
+int torture_hrtimeout_us(u32 baset_us, u32 fuzzt_ns, struct torture_random_state *trsp)
+{
+	ktime_t baset_ns = baset_us * NSEC_PER_USEC;
+
+	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, trsp);
+}
+EXPORT_SYMBOL_GPL(torture_hrtimeout_us);
+
+/*
+ * Schedule a high-resolution-timer sleep in milliseconds, with a 32-bit
+ * microsecond (not millisecond!) random fuzz.
+ */
+int torture_hrtimeout_ms(u32 baset_ms, u32 fuzzt_us, struct torture_random_state *trsp)
+{
+	ktime_t baset_ns = baset_ms * NSEC_PER_MSEC;
+	u32 fuzzt_ns;
+
+	if ((u32)~0U / NSEC_PER_USEC < fuzzt_us)
+		fuzzt_ns = (u32)~0U;
+	else
+		fuzzt_ns = fuzzt_us * NSEC_PER_USEC;
+	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, trsp);
+}
+EXPORT_SYMBOL_GPL(torture_hrtimeout_ms);
+
+/*
+ * Schedule a high-resolution-timer sleep in jiffies, with an
+ * implied one-jiffy random fuzz.  This is intended to replace calls to
+ * schedule_timeout_interruptible() and friends.
+ */
+int torture_hrtimeout_jiffies(u32 baset_j, struct torture_random_state *trsp)
+{
+	ktime_t baset_ns = jiffies_to_nsecs(baset_j);
+
+	return torture_hrtimeout_ns(baset_ns, jiffies_to_nsecs(1), trsp);
+}
+EXPORT_SYMBOL_GPL(torture_hrtimeout_jiffies);
+
+/*
+ * Schedule a high-resolution-timer sleep in milliseconds, with a 32-bit
+ * millisecond (not second!) random fuzz.
+ */
+int torture_hrtimeout_s(u32 baset_s, u32 fuzzt_ms, struct torture_random_state *trsp)
+{
+	ktime_t baset_ns = baset_s * NSEC_PER_SEC;
+	u32 fuzzt_ns;
+
+	if ((u32)~0U / NSEC_PER_MSEC < fuzzt_ms)
+		fuzzt_ns = (u32)~0U;
+	else
+		fuzzt_ns = fuzzt_ms * NSEC_PER_MSEC;
+	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, trsp);
+}
+EXPORT_SYMBOL_GPL(torture_hrtimeout_s);
+
 #ifdef CONFIG_HOTPLUG_CPU
 
 /*
-- 
2.9.5

