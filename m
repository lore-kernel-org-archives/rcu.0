Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B93FC433F5
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0917261186
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhIOXr2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233099AbhIOXrZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:47:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB59461164;
        Wed, 15 Sep 2021 23:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749566;
        bh=qKrNGYdVp+q2UuFHn2XnoECwSrmo1kzVZw4Sm4qt0Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZDLllULJyQDlU0Ztsx7sE/OLhhg11PJrp/Y7FM5mfy10IFzBSHcAYApApLUOac+R
         FZmZ4bkGd2HdVh440ScSgPeX50WW4UNdnZyEppViGLbM6a1/STW0lIQk2z5g2rhey5
         +N/Ng077Gu8iCkZYhLgcONmgG8QhSJcXxMoYfr50hWZ0sFYSriQgBZJp53iWzOSGn0
         v6FNDgO2vkXcR+sHCzJKbIAxdUl74q8SDuQA752TCh+ysdd/dqTK1PX7dKduCpThN9
         LMjGzCjnCXpr00Tv4yb9gHCRTRITbr8hyOUyyAInCPxer6mAZFKacwSpOn077lwgVB
         1lDLwnVBf+f/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C634D5C0926; Wed, 15 Sep 2021 16:46:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/13] rcu-tasks: Fix s/instruction/instructions/ typo in comment
Date:   Wed, 15 Sep 2021 16:45:56 -0700
Message-Id: <20210915234604.3907802-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a3f4f9bd8c67..43c0f715ac63 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -758,7 +758,7 @@ EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
 // 2.	Protects code in the idle loop, exception entry/exit, and
 //	CPU-hotplug code paths, similar to the capabilities of SRCU.
 //
-// 3.	Avoids expensive read-side instruction, having overhead similar
+// 3.	Avoids expensive read-side instructions, having overhead similar
 //	to that of Preemptible RCU.
 //
 // There are of course downsides.  The grace-period code can send IPIs to
-- 
2.31.1.189.g2e36527f23

