Return-Path: <SRS0=nsBp=BW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63928C433DF
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB5522BF5
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597273092;
	bh=p6eLETLZRYgYan2ddKnQCwn/WJxewrAyq5jfA5ROAN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BWBTfXzm/VKgEeTKP+TGUZjg4kCxFrrY14IuBqnK1GJTgW2H8Q9S9yQEQe80YVVa2
	 cQ7PYqBilmYFbQD8egtVI78rMEWSqzl+emoYFz507SW+eGkg8E0H8Jiy/z0D9ZIoWg
	 lSToqNmb6wuUv73ob/M2cjc1k8Ah+2F1Y5L1Bol4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHLW6I (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHLW5f (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Aug 2020 18:57:35 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E1C320866;
        Wed, 12 Aug 2020 22:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597273055;
        bh=p6eLETLZRYgYan2ddKnQCwn/WJxewrAyq5jfA5ROAN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFIyMDWMKGs7fkdoK0DpEhYOUUYl0iUdYsfDAv+xCGVl3tPKAVDl6Q682ZlvVM0Nu
         Pn8yAL9cL5KHPR7KOOCSVC4kU4PGmmCxKb17RDjqZbt40wMlKshno7HjaBXkayEjyu
         saV9YtusV3spYIC9CKU+4PvW0tz7ca5vuD7q4HpQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        elver@google.com, dvyukov@google.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/12] rcu: Force DEFAULT_RCU_BLIMIT to 1000 for strict RCU GPs
Date:   Wed, 12 Aug 2020 15:57:24 -0700
Message-Id: <20200812225732.20068-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200812225632.GA19759@paulmck-ThinkPad-P72>
References: <20200812225632.GA19759@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The value of DEFAULT_RCU_BLIMIT is normally set to 10, the idea being to
avoid needless response-time degradation due to RCU callback invocation.
However, when CONFIG_RCU_STRICT_GRACE_PERIOD=y it is better to avoid
throttling callback execution in order to better detect pointer
leaks from RCU read-side critical sections.  This commit therefore
sets the value of DEFAULT_RCU_BLIMIT to 1000 in kernels built with
CONFIG_RCU_STRICT_GRACE_PERIOD=y.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d333f1b..08cc91c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -454,17 +454,18 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
 }
 
-#define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch ... */
-#define DEFAULT_MAX_RCU_BLIMIT 10000 /* ... even during callback flood. */
+#define DEFAULT_RCU_BLIMIT (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ? 1000 : 10)
+				// Maximum callbacks per rcu_do_batch ...
+#define DEFAULT_MAX_RCU_BLIMIT 10000 // ... even during callback flood.
 static long blimit = DEFAULT_RCU_BLIMIT;
-#define DEFAULT_RCU_QHIMARK 10000 /* If this many pending, ignore blimit. */
+#define DEFAULT_RCU_QHIMARK 10000 // If this many pending, ignore blimit.
 static long qhimark = DEFAULT_RCU_QHIMARK;
-#define DEFAULT_RCU_QLOMARK 100   /* Once only this many pending, use blimit. */
+#define DEFAULT_RCU_QLOMARK 100   // Once only this many pending, use blimit.
 static long qlowmark = DEFAULT_RCU_QLOMARK;
 #define DEFAULT_RCU_QOVLD_MULT 2
 #define DEFAULT_RCU_QOVLD (DEFAULT_RCU_QOVLD_MULT * DEFAULT_RCU_QHIMARK)
-static long qovld = DEFAULT_RCU_QOVLD; /* If this many pending, hammer QS. */
-static long qovld_calc = -1;	  /* No pre-initialization lock acquisitions! */
+static long qovld = DEFAULT_RCU_QOVLD; // If this many pending, hammer QS.
+static long qovld_calc = -1;	  // No pre-initialization lock acquisitions!
 
 module_param(blimit, long, 0444);
 module_param(qhimark, long, 0444);
-- 
2.9.5

