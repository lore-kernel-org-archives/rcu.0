Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8099CC4332D
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5822123123
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbhAFRSh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbhAFRSg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:18:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 335A923142;
        Wed,  6 Jan 2021 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953434;
        bh=6OKbWmmGfB/GwekkNtyGwBSEzg6oe5RvbKvCvlyqhTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cHhe9lHb4hlMeBu3gpmZ07NcGsFPW/m4IepnRnNeNgB2TzfolH3fGkPK+KGgK/K+t
         vUrO3G1fK89METBskV6yCMSxXf8GVhlCoATrsEwrc/lm38B1JpiU3cfioFT/8kgkQI
         QpcO1NJRq6PyKxzmja9FkchlAOcEyzdVAB6VNNKvTA3g+IDN4txC1NDBDQlSjuLsAj
         9cSbnQCJmMeJSvzxny2MgksjNtn65B0Zhtn1+nnk5u4pVwW5eiSMAn4XITjFYfmCQn
         oQ5hsrZe6IYK+Rlp7xUf5RvRvJ2IsNuh46y7NP4LA2o0kb9p71xhiDq1o9QshRdHEG
         +w7k4qYja3Fzg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/17] torture: Throttle VERBOSE_TOROUT_*() output
Date:   Wed,  6 Jan 2021 09:17:05 -0800
Message-Id: <20210106171710.22239-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds kernel boot parameters torture.verbose_sleep_frequency
and torture.verbose_sleep_duration, which allow VERBOSE_TOROUT_*() output
to be throttled with periodic sleeps on large systems.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 include/linux/torture.h                         | 15 +++++++++++++--
 kernel/torture.c                                | 20 ++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 29ea816..5ce95dd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5337,6 +5337,14 @@
 			are running concurrently, especially on systems
 			with rotating-rust storage.
 
+	torture.verbose_sleep_frequency= [KNL]
+			Specifies how many verbose printk()s should be
+			emitted between each sleep.  The default of zero
+			disables verbose-printk() sleeping.
+
+	torture.verbose_sleep_duration= [KNL]
+			Duration of each verbose-printk() sleep in jiffies.
+
 	tp720=		[HW,PS2]
 
 	tpm_suspend_pcr=[HW,TPM]
diff --git a/include/linux/torture.h b/include/linux/torture.h
index 32941f8..d62d13c 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -32,9 +32,20 @@
 #define TOROUT_STRING(s) \
 	pr_alert("%s" TORTURE_FLAG " %s\n", torture_type, s)
 #define VERBOSE_TOROUT_STRING(s) \
-	do { if (verbose) pr_alert("%s" TORTURE_FLAG " %s\n", torture_type, s); } while (0)
+do {										\
+	if (verbose) {								\
+		verbose_torout_sleep();						\
+		pr_alert("%s" TORTURE_FLAG " %s\n", torture_type, s);		\
+	}									\
+} while (0)
 #define VERBOSE_TOROUT_ERRSTRING(s) \
-	do { if (verbose) pr_alert("%s" TORTURE_FLAG "!!! %s\n", torture_type, s); } while (0)
+do {										\
+	if (verbose) {								\
+		verbose_torout_sleep();						\
+		pr_alert("%s" TORTURE_FLAG "!!! %s\n", torture_type, s);	\
+	}									\
+} while (0)
+void verbose_torout_sleep(void);
 
 /* Definitions for online/offline exerciser. */
 typedef void torture_ofl_func(void);
diff --git a/kernel/torture.c b/kernel/torture.c
index 7ad5c96..93eeeb2 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -48,6 +48,12 @@ module_param(disable_onoff_at_boot, bool, 0444);
 static bool ftrace_dump_at_shutdown;
 module_param(ftrace_dump_at_shutdown, bool, 0444);
 
+static int verbose_sleep_frequency;
+module_param(verbose_sleep_frequency, int, 0444);
+
+static int verbose_sleep_duration = 1;
+module_param(verbose_sleep_duration, int, 0444);
+
 static char *torture_type;
 static int verbose;
 
@@ -58,6 +64,20 @@ static int verbose;
 static int fullstop = FULLSTOP_RMMOD;
 static DEFINE_MUTEX(fullstop_mutex);
 
+static atomic_t verbose_sleep_counter;
+
+/*
+ * Sleep if needed from VERBOSE_TOROUT*().
+ */
+void verbose_torout_sleep(void)
+{
+	if (verbose_sleep_frequency > 0 &&
+	    verbose_sleep_duration > 0 &&
+	    !(atomic_inc_return(&verbose_sleep_counter) % verbose_sleep_frequency))
+		schedule_timeout_uninterruptible(verbose_sleep_duration);
+}
+EXPORT_SYMBOL_GPL(verbose_torout_sleep);
+
 /*
  * Schedule a high-resolution-timer sleep in nanoseconds, with a 32-bit
  * nanosecond random fuzz.  This function and its friends desynchronize
-- 
2.9.5

