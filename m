Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF6FC12002
	for <rcu@archiver.kernel.org>; Wed, 14 Jul 2021 20:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C52613D0
	for <rcu@archiver.kernel.org>; Wed, 14 Jul 2021 20:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhGNUxg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234219AbhGNUxg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Jul 2021 16:53:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9079A613CA;
        Wed, 14 Jul 2021 20:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626295844;
        bh=CtzzVdl51zx/rlsi8l05bn7zD2QP6rolv/PqX1ww260=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KSzvYnlaCw+nRDow/TZt5MQp9+BmvyuwLHlSWBsZtakmn/5kpiG2OaOwKzVSY3R5c
         3Z82VV1F2I3R9sxWJgvmtvQWyEr8l7iCr2iHhXLvXCxNbtuO2ShcOSd3KrN9G4RzOH
         sT1IzQNy2pcXlFMKbncT3ttr0ByDAGP7HR+fH27W3i8CXhsIo+N0byjfg3NXVPZli4
         aENJdo8a4CuOhG46e/b52JOJpr1Dy9EKJnBliRHwndGcUwC68IOJFLh+grMNuajCRb
         HRLmoJUSh6Z1Dc4/G9kwcOXQ+RD/mLMTVFNAUkK6v4s5hlvHg1FlJuom5zZKUXlq8P
         T13fl/tRbzURQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 648AC5C0355; Wed, 14 Jul 2021 13:50:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        valentin.schneider@arm.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu/urgent 1/2] scftorture: Avoid false-positive warnings in scftorture_invoker()
Date:   Wed, 14 Jul 2021 13:50:42 -0700
Message-Id: <20210714205043.2033697-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210714204928.GA2033276@paulmck-ThinkPad-P17-Gen-1>
References: <20210714204928.GA2033276@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If the call to set_cpus_allowed_ptr() in scftorture_invoker()
fails, a later WARN_ONCE() complains.  But with the advent of
570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread() instead of
nr_cpus_allowed"), this complaint can be drowned out by complaints from
smp_processor_id().  The rationale for this change is that scftorture's
kthreads are not marked with PF_NO_SETAFFINITY, which means that a system
administrator could change affinity at any time.

However, scftorture is a torture test, and the system administrator might
well have a valid test-the-test reason for changing affinity.  This commit
therefore changes to raw_smp_processor_id() in order to avoid the noise,
and also adds a WARN_ON_ONCE() to the call to set_cpus_allowed_ptr() in
order to directly detect immediate failure.  There is no WARN_ON_ONCE()
within the test loop, allowing human-reflex-based affinity resetting,
if desired.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 2377cbb32474..29e8fc5d91a7 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -405,15 +405,15 @@ static int scftorture_invoker(void *arg)
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d: task started", scfp->cpu);
 	cpu = scfp->cpu % nr_cpu_ids;
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
+	WARN_ON_ONCE(set_cpus_allowed_ptr(current, cpumask_of(cpu)));
 	set_user_nice(current, MAX_NICE);
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
 
-	VERBOSE_SCFTORTOUT("scftorture_invoker %d: Waiting for all SCF torturers from cpu %d", scfp->cpu, smp_processor_id());
+	VERBOSE_SCFTORTOUT("scftorture_invoker %d: Waiting for all SCF torturers from cpu %d", scfp->cpu, raw_smp_processor_id());
 
 	// Make sure that the CPU is affinitized appropriately during testing.
-	curcpu = smp_processor_id();
+	curcpu = raw_smp_processor_id();
 	WARN_ONCE(curcpu != scfp->cpu % nr_cpu_ids,
 		  "%s: Wanted CPU %d, running on %d, nr_cpu_ids = %d\n",
 		  __func__, scfp->cpu, curcpu, nr_cpu_ids);
-- 
2.31.1.189.g2e36527f23

