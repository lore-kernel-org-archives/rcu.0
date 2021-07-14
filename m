Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05C2C47E48
	for <rcu@archiver.kernel.org>; Wed, 14 Jul 2021 20:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCA0613D0
	for <rcu@archiver.kernel.org>; Wed, 14 Jul 2021 20:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhGNUxh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234229AbhGNUxg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Jul 2021 16:53:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 942A0613C9;
        Wed, 14 Jul 2021 20:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626295844;
        bh=N4KlIPh5PrSGMYjvvd0AGTVj4PtDoBEX4kkmgF9jlpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mm7mIEvCYUqRxaTftdlNpojJW9+MO1+3J68GOfJGbRlFXh9J3BAHTfcWOed3bBUGI
         hKD+Zt/BcCJ/354Ys8FFcOzOO3dwYUCh5pbzV2XcGEGZ9E1jrn9AXyb32xOnJ7FoJR
         mPdppLKk/5c0RgBiHjLvFX4NkvoRTWsnUgOqoeFSjbZCHkuXf32jZmm9R13VyQ4OyH
         iSDBk+MymUeK5cR+Y47m6Oy3gDYy9420zgbahe9xkwTw5z6kBobacWsPBX0L1/7hJI
         Tpmsnoek9oHTRuiAkQ3kfpAnNT4ea8/pn7Y2h8wYV9OawoJKrhejBMLg6VhIlIqzZS
         rTuawjkzPdQDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 677AB5C037D; Wed, 14 Jul 2021 13:50:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        valentin.schneider@arm.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu/urgent 2/2] refscale: Avoid false-positive warnings in ref_scale_reader()
Date:   Wed, 14 Jul 2021 13:50:43 -0700
Message-Id: <20210714205043.2033697-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210714204928.GA2033276@paulmck-ThinkPad-P17-Gen-1>
References: <20210714204928.GA2033276@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If the call to set_cpus_allowed_ptr() in ref_scale_reader()
fails, a later WARN_ONCE() complains.  But with the advent of
570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread() instead of
nr_cpus_allowed"), this complaint can be drowned out by complaints from
smp_processor_id().  The rationale for this change is that refscale's
kthreads are not marked with PF_NO_SETAFFINITY, which means that a system
administrator could change affinity at any time.

However, refscale is a performance/stress test, and the system
administrator might well have a valid test-the-test reason for changing
affinity.  This commit therefore changes to raw_smp_processor_id()
in order to avoid the noise, and also adds a WARN_ON_ONCE() to the
call to set_cpus_allowed_ptr() in order to directly detect immediate
failure.  There is no WARN_ON_ONCE() within the test loop, allowing
human-reflex-based affinity resetting, if desired.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 313d4547cbc7..d998a76fb542 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -487,13 +487,13 @@ ref_scale_reader(void *arg)
 	s64 duration;
 
 	VERBOSE_SCALEOUT_BATCH("ref_scale_reader %ld: task started", me);
-	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	WARN_ON_ONCE(set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids)));
 	set_user_nice(current, MAX_NICE);
 	atomic_inc(&n_init);
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
 repeat:
-	VERBOSE_SCALEOUT_BATCH("ref_scale_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
+	VERBOSE_SCALEOUT_BATCH("ref_scale_reader %ld: waiting to start next experiment on cpu %d", me, raw_smp_processor_id());
 
 	// Wait for signal that this reader can start.
 	wait_event(rt->wq, (atomic_read(&nreaders_exp) && smp_load_acquire(&rt->start_reader)) ||
@@ -503,7 +503,7 @@ ref_scale_reader(void *arg)
 		goto end;
 
 	// Make sure that the CPU is affinitized appropriately during testing.
-	WARN_ON_ONCE(smp_processor_id() != me);
+	WARN_ON_ONCE(raw_smp_processor_id() != me);
 
 	WRITE_ONCE(rt->start_reader, 0);
 	if (!atomic_dec_return(&n_started))
-- 
2.31.1.189.g2e36527f23

