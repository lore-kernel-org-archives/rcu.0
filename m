Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4A3C388F7
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EAF42085B
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMB/TnqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgKMMOj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbgKMMOj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:14:39 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA33C22254;
        Fri, 13 Nov 2020 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269678;
        bh=pzg3H1SAcQ8CRdYtrrU6JJlUNejMzIJGGg1ue4KpFhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TMB/TnqB1v9MjDexs/G4Bh7e8tB4UZnxViI0IhHN+drwBLwyMP638LELGa7NRsKic
         3nlIh1Im99gyl8/tvZXEEO3n2inNdnuqLV7JamIWLrGEcx+BEFXBtZdjYuq1ROrLXM
         N4Q6SOFrDsFIYvJZGY4cDhfVWeJKD8cZgt3X9JLY=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH 18/19] timer: Add timer_curr_running()
Date:   Fri, 13 Nov 2020 13:13:33 +0100
Message-Id: <20201113121334.166723-19-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU needs to check if the current code is running a specific timer
callback, in the middle of other conditions to check the sanity of
RCU-nocb. Provide a helper for that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/timer.h |  2 ++
 kernel/time/timer.c   | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index d10bc7e73b41..c75dbf7d118f 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -192,6 +192,8 @@ extern int try_to_del_timer_sync(struct timer_list *timer);
 
 #define del_singleshot_timer_sync(t) del_timer_sync(t)
 
+extern bool timer_curr_running(struct timer_list *timer);
+
 extern void init_timers(void);
 extern void run_local_timers(void);
 struct hrtimer;
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index de37e33a868d..9d41e4c4cfd4 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1242,6 +1242,19 @@ int try_to_del_timer_sync(struct timer_list *timer)
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
2.25.1

