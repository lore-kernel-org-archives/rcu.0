Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7409CC433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D86361606
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhEKXEr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhEKXEp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:04:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E28A61626;
        Tue, 11 May 2021 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774218;
        bh=MKDEyn07H856J79eXBWwH+gz3Akdvzc+XZmnv3OdUo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XdHrdD1/HNJ3ednl+C1UeDJsFuhjC+fjQNzCJLEeFc1WsQArDSx86W/E51RZws4od
         80fzxNXfzyaxYHZpTiwB6BNelj3gji4Cea98o6hcfhD+aKxCM6U4qL3PmT7jv/9a34
         aWJDNqZat3fyHnEvPz+ClzrbF6mTfFzYJSKlF9ydqdWCfNTSkUoMqnudhBf0T/qx3/
         QTl9kJ3qM18JlSvGbFwrWFwF8OtaXdnaiJ5FZUhuWX6peAynoJv7/VA4eH7vNksFLm
         fwBv4Hqbj/GuR3HvuNGQYvnM/TKTaIkRFmnVez2+BIsrvQTebpspc9CV/64wPC04qI
         eGIyJzPdN6ZKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5B3E05C014E; Tue, 11 May 2021 16:03:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/10] timer: Revert "timer: Add timer_curr_running()"
Date:   Tue, 11 May 2021 16:03:28 -0700
Message-Id: <20210511230336.2894314-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

This reverts commit dcd42591ebb8a25895b551a5297ea9c24414ba54.
The only user was RCU/nocb.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/timer.h |  2 --
 kernel/time/timer.c   | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 4118a97e62fb..fda13c9d1256 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -192,8 +192,6 @@ extern int try_to_del_timer_sync(struct timer_list *timer);
 
 #define del_singleshot_timer_sync(t) del_timer_sync(t)
 
-extern bool timer_curr_running(struct timer_list *timer);
-
 extern void init_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d111adf4a0cb..84332f01dc57 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1237,20 +1237,6 @@ int try_to_del_timer_sync(struct timer_list *timer)
 }
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
-bool timer_curr_running(struct timer_list *timer)
-{
-	int i;
-
-	for (i = 0; i < NR_BASES; i++) {
-		struct timer_base *base = this_cpu_ptr(&timer_bases[i]);
-
-		if (base->running_timer == timer)
-			return true;
-	}
-
-	return false;
-}
-
 #ifdef CONFIG_PREEMPT_RT
 static __init void timer_base_init_expiry_lock(struct timer_base *base)
 {
-- 
2.31.1.189.g2e36527f23

