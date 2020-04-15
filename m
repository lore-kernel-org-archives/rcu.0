Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46309C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083E32173E
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586971871;
	bh=Utyg9ngIx0ziDdQ3mpsqWdXEIHJ4s2ZMjUBM8EJtyOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WL5dQ/1RxelBsHx9VFF3dPjMWX6UpCcmy1swzNJr+Z7CC5ckha5C/tJ/rXIMtt2jc
	 8VyeIQBSrbFnG4arxip54Ne6uxqi3Pn/Je05G6pbvXTtjxqaFhDGP60A02z6nRBDeQ
	 TexRb+xDlG/BAPgkBRKGXQYUNBbiIpB73WAvRd8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411125AbgDORbH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411102AbgDORbC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:02 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE7F22076D;
        Wed, 15 Apr 2020 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971862;
        bh=Utyg9ngIx0ziDdQ3mpsqWdXEIHJ4s2ZMjUBM8EJtyOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SzC0EPsOWpvCHvZxXMVJEgnfWqqP3WdYq5XDEAiHLbNuAgQPkqqKsbAji5Q8yQf31
         n/KBKyhObpLNFxEoAza8XBaaKMIJpRzHBSUby8U6o5aL1PKFGLlfLMbFS/eQf92wJd
         DukB79Uw2uqcHsm1PrYSjQw/WbghHlGrmN7JGh5g=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/18] rcutorture: Add KCSAN stubs
Date:   Wed, 15 Apr 2020 10:30:43 -0700
Message-Id: <20200415173100.9927-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds stubs for KCSAN's data_race(), ASSERT_EXCLUSIVE_WRITER(),
and ASSERT_EXCLUSIVE_ACCESS() macros to allow code using these macros to
move ahead.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5453bd5..7e2ea0c5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -51,6 +51,18 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@joshtriplett.org>");
 
+#ifndef data_race
+#define data_race(expr)							\
+	({								\
+		expr;							\
+	})
+#endif
+#ifndef ASSERT_EXCLUSIVE_WRITER
+#define ASSERT_EXCLUSIVE_WRITER(var) do { } while (0)
+#endif
+#ifndef ASSERT_EXCLUSIVE_ACCESS
+#define ASSERT_EXCLUSIVE_ACCESS(var) do { } while (0)
+#endif
 
 /* Bits for ->extendables field, extendables param, and related definitions. */
 #define RCUTORTURE_RDR_SHIFT	 8	/* Put SRCU index in upper bits. */
-- 
2.9.5

