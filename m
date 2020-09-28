Return-Path: <SRS0=f31y=DF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25531C4727F
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13952076A
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601335904;
	bh=JH/J9/6wuVHqPxSYPfW2zgjfovn0kmrxHsx8CKz0VzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=os2y2EXtauxCHbuLNmuMVgpmDz+Dp0kKtFnZdHdttTU6NwpNi8NRtJ2x0U4fr2HHG
	 r4EAT0aJVORe+BeMrasIornfUba++OSS63XN0HNbXjGbldPoZdumxkTGtMziBzL62+
	 SonOQSdMVOVgXWMTT+6FVI5nzXysbqOWtMgoL5cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgI1Xbe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbgI1XbH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Sep 2020 19:31:07 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2511B23A58;
        Mon, 28 Sep 2020 23:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335867;
        bh=JH/J9/6wuVHqPxSYPfW2zgjfovn0kmrxHsx8CKz0VzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nivVrDAexucq1UyNDS1d7tR5pueQYYif/FLddVquBvz/ThtvWNb+yIwaDZ6eev4xv
         CnTxb5p5SDdn9mQyT8t9P3JcqlOJOu5Gsszq9Ac6zqoVW60etqdB9sTCaWis8lGfJZ
         BiSQuwJAC8DWLwLrfFmVHIevu4sVqJlI79KZFc9M=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/15] preempt: Remove PREEMPT_COUNT from Kconfig
Date:   Mon, 28 Sep 2020 16:31:00 -0700
Message-Id: <20200928233102.24265-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200928233041.GA23230@paulmck-ThinkPad-P72>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

All conditionals and irritations are gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/Kconfig.preempt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 3f4712f..120b63f 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -74,8 +74,5 @@ config PREEMPT_RT
 
 endchoice
 
-config PREEMPT_COUNT
-       def_bool y
-
 config PREEMPTION
        bool
-- 
2.9.5

