Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E4EC35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5937207FF
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581727046;
	bh=BOS4V9LRWUgl4TAZLJl90ngMyJMD4i27HDB4Rq6MkKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bUgr1ihLSdenSxsfRTZyd9HXRsoIjtW6HPwW9xyHILdquw+jT0IfzcSZKB8dl/Ftk
	 2iuuO1CvoYJNPcbDI973D60D3iqRnCTfsaEkz+Cc1JaotGsa/+Lko3ugib9BCxq9qw
	 eqC3MwTsU1E3K9/iOJNiUJa99snnnrsRXmAIBB2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBOAh0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:37:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbgBOAhZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:37:25 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0630020848;
        Sat, 15 Feb 2020 00:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727045;
        bh=BOS4V9LRWUgl4TAZLJl90ngMyJMD4i27HDB4Rq6MkKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kCj3HiUdi32N/nbYN/SSMzKSSONS0qDkpOrLM0O2VavelobzGPOc13CAKrsfQLOqx
         3H42hFOAQcj+7UFFJTeRk1ls2U0rivqXCrlUNyfl1YK7Opz2YQq7Leq2KYWjYc1aY6
         H7jOUzLod6Izh2PtCEATr2o5dwaP0HrJ1cMw9gBw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/18] rcutorture: Refrain from callback flooding during boot
Date:   Fri, 14 Feb 2020 16:36:56 -0800
Message-Id: <20200215003711.16463-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Additional rcutorture aggression can result in, believe it or not,
boot times in excess of three minutes on large hyperthreaded systems.
This is long enough for rcutorture to decide to do some callback flooding,
which seems a bit excessive given that userspace cannot have started
until long after boot, and it is userspace that does the real-world
callback flooding.  Worse yet, because Tiny RCU lacks forward-progress
functionality, the looping-in-the-kernel tests can also be problematic
during early boot.

This commit therefore causes rcutorture to hold off on callback
flooding until about the time that init is spawned, and the same
for looping-in-the-kernel tests for Tiny RCU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9ba4978..08fa4ef 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1994,8 +1994,11 @@ static int rcu_torture_fwd_prog(void *args)
 		schedule_timeout_interruptible(fwd_progress_holdoff * HZ);
 		WRITE_ONCE(rcu_fwd_emergency_stop, false);
 		register_oom_notifier(&rcutorture_oom_nb);
-		rcu_torture_fwd_prog_nr(rfp, &tested, &tested_tries);
-		rcu_torture_fwd_prog_cr(rfp);
+		if (!IS_ENABLED(CONFIG_TINY_RCU) ||
+		    rcu_inkernel_boot_has_ended())
+			rcu_torture_fwd_prog_nr(rfp, &tested, &tested_tries);
+		if (rcu_inkernel_boot_has_ended())
+			rcu_torture_fwd_prog_cr(rfp);
 		unregister_oom_notifier(&rcutorture_oom_nb);
 
 		/* Avoid slow periods, better to test when busy. */
-- 
2.9.5

