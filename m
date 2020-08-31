Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CACC433E2
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CAA20866
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897025;
	bh=e5OVjDPCTjZITnNtmjYNGHWadL20w+j7fy1feGBNUyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5gA5mYwWdjHOlva49t6+iNG5gVDLpWgS9QyfEEweie90tIkNB6XTbg4Os3qfyHQo
	 Pic3wtcHgSyrnNjiZjarFJNuI1b1Wu1bLekzJ/XDJOqkjda9/x/MejxSouSN5hipOt
	 aOb6F9ZsKwdVaA2ghEx9AC2jMfK72g4N58rFO5AY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgHaSBV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbgHaSBU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:20 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8911214D8;
        Mon, 31 Aug 2020 18:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896880;
        bh=e5OVjDPCTjZITnNtmjYNGHWadL20w+j7fy1feGBNUyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EvGgoRcxQ3yYoC52csDD4CB6grrqtbTsl7DOWNaLh+pRvwvKbZ+UDflHmmD+vBbv+
         Ou4ea+kTdXYkWMfsVt64YX8ezb9kHYPg6nZPp/uac2VG8S7eS8SHm8puk0JpaCQyLI
         aytnQnlecndrheS40UGybw6dOM4Y2kbrUmodqQe8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/24] srcu: Remove KCSAN stubs
Date:   Mon, 31 Aug 2020 11:00:55 -0700
Message-Id: <20200831180116.32690-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

KCSAN is now in mainline, so this commit removes the stubs for the
data_race(), ASSERT_EXCLUSIVE_WRITER(), and ASSERT_EXCLUSIVE_ACCESS()
macros.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c100acf..c13348e 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -29,19 +29,6 @@
 #include "rcu.h"
 #include "rcu_segcblist.h"
 
-#ifndef data_race
-#define data_race(expr)							\
-	({								\
-		expr;							\
-	})
-#endif
-#ifndef ASSERT_EXCLUSIVE_WRITER
-#define ASSERT_EXCLUSIVE_WRITER(var) do { } while (0)
-#endif
-#ifndef ASSERT_EXCLUSIVE_ACCESS
-#define ASSERT_EXCLUSIVE_ACCESS(var) do { } while (0)
-#endif
-
 /* Holdoff in nanoseconds for auto-expediting. */
 #define DEFAULT_SRCU_EXP_HOLDOFF (25 * 1000)
 static ulong exp_holdoff = DEFAULT_SRCU_EXP_HOLDOFF;
-- 
2.9.5

