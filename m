Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BD8C433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1355A2053B
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872422;
	bh=e5OVjDPCTjZITnNtmjYNGHWadL20w+j7fy1feGBNUyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=baa9SS1qEkoWWWiRT66EXCFfUxeafSZjf9RVTWWQQ14S60qaEWBbNtv9yXUMgDnsB
	 D4k/fAhTCE0UbQOSfAFixk8wS9XCoMkmxS6EHGMLT9cm3bdlaTWyJErOXIJ5nEvaCV
	 +8haZPQtnx9IHmUwZcMpaq2JH1Xh1xgTz8KvxgOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgFWAdl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731740AbgFWAdf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:33:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1105720890;
        Tue, 23 Jun 2020 00:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872415;
        bh=e5OVjDPCTjZITnNtmjYNGHWadL20w+j7fy1feGBNUyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTRm5EQAQVNAUTn+08RnsBB9Eym4xFcbB7v1kPMctWMMlLs3nfdLlpZLV3VJkVHBl
         B/wmElQtNerKPo8as8wzfGN2bqX0PsJXvziLpuyAlV2B+2MLWXzo1GBpbVbvEWQG+5
         47kwgEy0u08AAFxO/NH+loVtFkVm3tIr4HKf39JI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/3] srcu: Remove KCSAN stubs
Date:   Mon, 22 Jun 2020 17:33:33 -0700
Message-Id: <20200623003333.26611-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003310.GA26539@paulmck-ThinkPad-P72>
References: <20200623003310.GA26539@paulmck-ThinkPad-P72>
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

