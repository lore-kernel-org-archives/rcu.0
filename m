Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500CCC433E6
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C7664EC4
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhCDBAf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352887AbhCDACj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:02:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8FC464F6F;
        Thu,  4 Mar 2021 00:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816023;
        bh=K3LgN3CSo9jrMGbQykhZPsfvYjBGit2jcAroL7W7KhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzHz2SCCvtCPzkPoWGTXh4ynYAmbYNbDZSJtEHY32oc76sSkHEAlOdNjY0JJR2P79
         10ZuYrU+3Q/TDJGySJskAbjplsttjeuH7bUs4Sc87Hc7NWn3mbu4raqKWJ5c767LUl
         PiDBjwFL07q4O/V/5YlTSWYXuR9aibjC7YHlPNWkkvSWcftkWT3fW/xqUBkwYtIx79
         Mmy52v+pcipq/xBGfhzFrs1RupEWTAjhFjVLKeSAZlAw4evzvqeQzQqrtp+LBhPBiD
         hQNR4mEd0LwZqOZ8+RV/Yu3LRyp5yfUy0lE0VSb2v9hHqZjV0y8AXgiMNnTq4301+s
         JM4n4tC2t3hLA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/10] softirq: Don't try waking ksoftirqd before it has been spawned
Date:   Wed,  3 Mar 2021 16:00:15 -0800
Message-Id: <20210304000019.22459-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235958.GA22373@paulmck-ThinkPad-P72>
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

If there is heavy softirq activity, the softirq system will attempt
to awaken ksoftirqd and will stop the traditional back-of-interrupt
softirq processing.  This is all well and good, but only if the
ksoftirqd kthreads already exist, which is not the case during early
boot, in which case the system hangs.

One reproducer is as follows:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y CONFIG_NO_HZ_IDLE=y CONFIG_HZ_PERIODIC=n" --bootargs "threadirqs=1" --trust-make

This commit therefore adds a couple of existence checks for ksoftirqd
and forces back-of-interrupt softirq processing when ksoftirqd does not
yet exist.  With this change, the above test passes.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reported-by: Uladzislau Rezki <urezki@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
[ paulmck: Remove unneeded check per Sebastian Siewior feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9908ec4a..bad14ca 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -211,7 +211,7 @@ static inline void invoke_softirq(void)
 	if (ksoftirqd_running(local_softirq_pending()))
 		return;
 
-	if (!force_irqthreads) {
+	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
 		/*
 		 * We can safely execute softirq on the current stack if
-- 
2.9.5

