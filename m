Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C346C4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589B2222F9
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbhAFAy5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:54:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbhAFAy4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 19:54:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3032230FF;
        Wed,  6 Jan 2021 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894450;
        bh=Bjvtf+rxLIg7Q9NTFpiJuV2TaFGHCYK0KN9Tt3LhfeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzCAgX/TqWWqm0C5Ewnkutiv1ezbczTM0y7Ur5oKT4sQksMg7WWj1vYEk8ycu7FkU
         JJmUOI5MZalNc+Qe8ts7oiIPhTBZOlSkI5ZyB2erDF1FLpR0eOzVBjVbhMK6pJ2Vp9
         dhjJLECMdVg/qXaAuvc2Ee6XIV2t0PXMyt837aLosouykgpdR9tQ0vZsNKUrbOvx5o
         qghdWhTgubVx/SUpjHKn4VeAA8WjAtCyC1tygtTt9JXfJGhVFHnUQXkiBdVJQMoZhH
         /7MQDahTy0Y4dTB8PyBlCsvqcFSiaf+sVpSPhp+/qxo9c2Dd3213n31gS8sPTlIWTi
         tDRbolBkHWoSQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 5/8] doc: Update RCU requirements RCU_INIT_POINTER() description
Date:   Tue,  5 Jan 2021 16:54:04 -0800
Message-Id: <20210106005407.12295-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106005334.GA12159@paulmck-ThinkPad-P72>
References: <20210106005334.GA12159@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Back in the day, RCU_INIT_POINTER() was the only way to avoid
memory-barrier instructions while storing NULL to an RCU-protected
pointer.  Fortunately, in 2016, rcu_assign_pointer() started checking for
compile-time NULL pointers and omitting the memory-barrier instructions in
that case.  Unfortunately, RCU's Requirements.rst document was not updated
accordingly.  This commit therefore at long last carries out that update.

Fixes: 3a37f7275cda ("rcu: No ordering for rcu_assign_pointer() of NULL")
Link: https://lore.kernel.org/lkml/20201209230755.GV7338@casper.infradead.org/
Reported-by: Matthew Wilcox <willy@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index f32f8fa..65c7839 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1668,8 +1668,7 @@ against mishaps and misuse:
    this purpose.
 #. It is not necessary to use rcu_assign_pointer() when creating
    linked structures that are to be published via a single external
-   pointer. The RCU_INIT_POINTER() macro is provided for this task
-   and also for assigning ``NULL`` pointers at runtime.
+   pointer. The RCU_INIT_POINTER() macro is provided for this task.
 
 This not a hard-and-fast list: RCU's diagnostic capabilities will
 continue to be guided by the number and type of usage bugs found in
-- 
2.9.5

