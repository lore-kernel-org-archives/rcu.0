Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4A2C4321E
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619C561157
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhIOXra (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhIOXr0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:47:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36654611CE;
        Wed, 15 Sep 2021 23:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749566;
        bh=W8d0s1xjvgsX+130ZL2UE1znOG3YJWFh19XNDDcNnow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mrH6CvR0zHlJEOBwvRXyj06FNNkdx36kNvx3QSEupgkebSSXsXPYYNecboEg0KRG7
         1JUfSIqPnAadJ5wJ7Sg0nukvckg3QPcsZLT1WcAmZLjMGwPtPrhi6ge5ii180SgTts
         oQ8qLZE6TiT4BInTc+zn0fh/z6ecoTuuJ3Kqp1b3kui7YBluW/Vb/6cueE5ehfN54Y
         8sasuntnXl9XWGDUoPOncSrtyH2XEk7hslDayVPB9ZG1g2wy1FDGmjqpF69vbs7OGV
         NibK3kupMh2EWVgCThFElzt3nK/VIdq0cHMSfpaQ44a8d9KaVRIMnW3r82GZCcBKRA
         X2t5rAhjAj+KA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CA0C65C09F9; Wed, 15 Sep 2021 16:46:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/13] rcu-tasks: Fix s/rcu_add_holdout/trc_add_holdout/ typo in comment
Date:   Wed, 15 Sep 2021 16:45:58 -0700
Message-Id: <20210915234604.3907802-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7e2641783e43..75e7888b3fc9 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -991,7 +991,7 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 
 	// If this task is not yet on the holdout list, then we are in
 	// an RCU read-side critical section.  Otherwise, the invocation of
-	// rcu_add_holdout() that added it to the list did the necessary
+	// trc_add_holdout() that added it to the list did the necessary
 	// get_task_struct().  Either way, the task cannot be freed out
 	// from under this code.
 
-- 
2.31.1.189.g2e36527f23

