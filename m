Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3482C4167B
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF33F61157
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhIOXr2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233101AbhIOXr0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:47:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26500611C7;
        Wed, 15 Sep 2021 23:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749566;
        bh=r6pUJPLUCsV/sWOj6NTvOqUI8rHTlmQvqmYyZZMHEGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaidTUPAIouXgN54Z4xP6+XvkwPL84mDvLI7EPjg7D5fPhPs2f/aq5p17qsD3R914
         1qzQUOvKporhMRd29qjoHX5NF1lCp0yAm0HaWymVMTFY88ZPgrTylOm75klroFwF3E
         jmNcN/0MO+bslS063EVIUn9Yed5r/89RPQSSEZxMPYVk5/3FCXqnqd/F3QWM0m3ncF
         w2t26y0Fqb1X/p4r0Pw2PRb2/t8UUVS6S4r2bYB6Z2oJwIiZ1W6KI6DhLgdcqikxWy
         5CIN7X9Iy1pA7S8aJLMhEweSiq9B9BVGgzAveNtyO3pVfFMgi6l1n2wpZMdrAYG8E3
         jV7TvhM5PNNJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C841A5C0954; Wed, 15 Sep 2021 16:46:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH rcu 06/13] rcu-tasks: Move RTGS_WAIT_CBS to beginning of rcu_tasks_kthread() loop
Date:   Wed, 15 Sep 2021 16:45:57 -0700
Message-Id: <20210915234604.3907802-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Early in debugging, it made some sense to differentiate the first
iteration from subsequent iterations, but now this just causes confusion.
This commit therefore moves the "set_tasks_gp_state(rtp, RTGS_WAIT_CBS)"
statement to the beginning of the "for" loop in rcu_tasks_kthread().

Reported-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 43c0f715ac63..7e2641783e43 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -197,6 +197,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	 * This loop is terminated by the system going down.  ;-)
 	 */
 	for (;;) {
+		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 
 		/* Pick up any new callbacks. */
 		raw_spin_lock_irqsave(&rtp->cbs_lock, flags);
@@ -236,8 +237,6 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		}
 		/* Paranoid sleep to keep this from entering a tight loop */
 		schedule_timeout_idle(rtp->gp_sleep);
-
-		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 	}
 }
 
-- 
2.31.1.189.g2e36527f23

