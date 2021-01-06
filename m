Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87339C4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EEE622BF3
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbhAFEuT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:50:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbhAFEuT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFC3B23103;
        Wed,  6 Jan 2021 04:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908538;
        bh=xJqTvU6hV/6IKsNxicmVJ556aYjrYxXI9GgfdbOKU0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1HI1VMadFQgilVCKqWMn5L8a2vnDBEeorqKkOTu4s2EHBf5H7BGZfuDy6uu34DJx
         MOYIKgjUS193/xXLrjs0KcB2wTWFM8K8Vn27fr6Y99NgFmo9tEaIqt6ULzeEan7xCW
         cj14Ye2ModhExGWc69mITHBjmKH/xwIZ4BIedcPRT1TRaJ8FjUKLKEx5hOPtP4+bpZ
         r66U1E3zmiyoyNszsPkcaY5OtBMkgksYaDgPKdlLO0Xj9+LoOv0ZfUAjrZzHLln0Ss
         4G3955I3LGpkAWxnSGZDRidaqhiu8buamvsECNlnvjAmNKyGAqd6Bv0xLAgwTPFt3P
         BRMMYJk9uF5TQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/21] timer: Add timer_curr_running()
Date:   Tue,  5 Jan 2021 20:48:47 -0800
Message-Id: <20210106044853.20812-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

This commit adds a timer_curr_running() function that verifies that the
current code is running in the context of the specified timer's handler.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/timer.h |  2 ++
 kernel/time/timer.c   | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index fda13c9..4118a97 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -192,6 +192,8 @@ extern int try_to_del_timer_sync(struct timer_list *timer);
 
 #define del_singleshot_timer_sync(t) del_timer_sync(t)
 
+extern bool timer_curr_running(struct timer_list *timer);
+
 extern void init_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 8dbc008..f9b2096 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1237,6 +1237,19 @@ int try_to_del_timer_sync(struct timer_list *timer)
 }
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
+bool timer_curr_running(struct timer_list *timer)
+{
+	int i;
+
+	for (i = 0; i < NR_BASES; i++) {
+		struct timer_base *base = this_cpu_ptr(&timer_bases[i]);
+		if (base->running_timer == timer)
+			return true;
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_PREEMPT_RT
 static __init void timer_base_init_expiry_lock(struct timer_base *base)
 {
-- 
2.9.5

