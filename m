Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C9BC433E2
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2CE2083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897291;
	bh=aMf8/AiYFYSLrVdWssiu4XGuFOl8wGjwU1yeTOTTWr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gWu0rWnk/gX2DGUUr67omjzmpyWnMRKi/aEO0rqa8oOZnnMcbf1V6656jLxlOkxmM
	 VZmUR5oHYdnnJhFJGtc7P1cz1E9z+4rAr2KioyJrYnLzkR6gfComIfvS2AGXpxnpsy
	 r6ZfSRZS81KNjTOccsKvFyxpURIGKPAUkc858W3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgHaSIB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729314AbgHaSH6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:58 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858B62176B;
        Mon, 31 Aug 2020 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897275;
        bh=aMf8/AiYFYSLrVdWssiu4XGuFOl8wGjwU1yeTOTTWr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBQ9LEqvA4AgAcyC3bC96HbtfJ8mIMb68CRwZ+i5pDF9CjkWqLzkDtJmKxdTPCx6G
         def7ef8w9gMNny/C/w4UJ+d1J5sxX5fGKe3y4IHK4wP6vZOEJFNE8L9p4dYYA6pI2b
         X6geUy05VtTQJWH/ogleE9NpsrujMB/UIumhQB1g=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/19] scftorture: Add cond_resched() to test loop
Date:   Mon, 31 Aug 2020 11:07:48 -0700
Message-Id: <20200831180749.843-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Although the test loop does randomly delay, which would provide quiescent
states and so forth, it is possible for there to be a series of long
smp_call_function*() handler runtimes with no delays, which results in
softlockup and RCU CPU stall warning messages.  This commit therefore
inserts a cond_resched() into the main test loop.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index fc22bcc..554a521 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -420,6 +420,7 @@ static int scftorture_invoker(void *arg)
 			set_cpus_allowed_ptr(current, cpumask_of(cpu));
 			was_offline = false;
 		}
+		cond_resched();
 	} while (!torture_must_stop());
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d ended", scfp->cpu);
-- 
2.9.5

