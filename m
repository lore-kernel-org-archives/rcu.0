Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63062C433E2
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7982083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897341;
	bh=XG3jWVOIYHjwWZSiiTWlyu/bevtJTbO3eo5mHlAXsaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SPgfivlRC6Fqp5m2itK2nNLu7qpjltqeCmJ4HBGaocNW8CTUDcK4nLhLa3NYbdG53
	 /zJUM5dZyBofkJXdmSwhOuGSBZtOU89Jm8lcMYXPvRJhPN82oYmmmIgBWZF0tkoKp8
	 Q9ZL+aWd/WDC7zmkSKj9M7YfJgLPS7hwAw41SW14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgHaSH4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbgHaSHx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:53 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A99CC21532;
        Mon, 31 Aug 2020 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897272;
        bh=XG3jWVOIYHjwWZSiiTWlyu/bevtJTbO3eo5mHlAXsaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yMf3lsA8nPiKgVqR1b5jO90o9OwkPAol9ofL23gcc92J+lPZFp1XzRaRbZg2Oqdh0
         +MNZY63zdaJoKGNJMn0r7PiR+IRXMkagb5q53puVUR0HuKcSW6IuCncuCl6SnSWQFl
         6rINmRSUD9o+PTgXSf7cVSvR2Q1SesxqXk6Yhwxs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/19] tick-sched: Clarify "NOHZ: local_softirq_pending" warning
Date:   Mon, 31 Aug 2020 11:07:35 -0700
Message-Id: <20200831180749.843-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, can_stop_idle_tick() prints "NOHZ: local_softirq_pending HH"
(where "HH" is the hexadecimal softirq vector number) when one or more
non-RCU softirq handlers are still enabled when checking to stop the
scheduler-tick interrupt.  This message is not as enlightening as one
might hope, so this commit changes it to "NOHZ tick-stop error: Non-RCU
local softirq work is pending, handler #HH".

Reported-by: Andy Lutomirski <luto@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f0199a4..81632cd 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -927,7 +927,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 
 		if (ratelimit < 10 &&
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
-			pr_warn("NOHZ: local_softirq_pending %02x\n",
+			pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x!!!\n",
 				(unsigned int) local_softirq_pending());
 			ratelimit++;
 		}
-- 
2.9.5

