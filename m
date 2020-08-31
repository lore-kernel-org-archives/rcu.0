Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B64C433E7
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102352083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897506;
	bh=BrvLViBsThaXkvt7qUFESDZ3SWqAijf66Epo+FLqfRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZDp9miVsXDTI2NCPMRUF73RBaadPgXvjD7W143KBIG8vYgdeUrWkn115Qd8I7On+H
	 0MM5FUjwxxvKK2Wr3jmhAwXqSjHnwwF2eX9UBI3iYCIsFxbuFqfTM3MnEuUlcPfxy5
	 ZXwAvlr5IoihbSB+rlQftiZ220EZmnc8+wT2X7Zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgHaSL3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728973AbgHaSLX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:11:23 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 968FD21527;
        Mon, 31 Aug 2020 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897482;
        bh=BrvLViBsThaXkvt7qUFESDZ3SWqAijf66Epo+FLqfRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRXQyfBl7ufLW4JZc5lugfOqhqVasBvOlpmFo7YnGNUucqh74XfB9spFuD8qm73kD
         n7v45sKwgu0EVy8VhDElHXl/Dsaqifct5Z5yKk3jtAz8Z0YVrSaE+eywtF5W9SpKHn
         jmPuUX9yN91y2wuOGP9z2g34egKFbTBR3CSQDnw8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/13] rcu: Force DEFAULT_RCU_BLIMIT to 1000 for strict RCU GPs
Date:   Mon, 31 Aug 2020 11:11:11 -0700
Message-Id: <20200831181120.1044-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181101.GA950@paulmck-ThinkPad-P72>
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
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
index 8551159..4436857 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -468,17 +468,18 @@ static int rcu_is_cpu_rrupt_from_idle(void)
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

