Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671CAC55ABD
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BE92073A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620107;
	bh=9AGY6DA5OVMpS1095TpRRCpJtZFekTi8ozI5Zdqjq68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CDneL5nBoZcykcwlo3IKEjzEF5RwqfqfTLi7S6wM+6mjjI6+hwFSPFZmgLag24iva
	 qYoj0QWc+FjYzlXp5mAuzrJJMvN7vMbumBeCMDEQHYT9qtFGR0n4jNQotA4rddIqLs
	 bAFE5hHN5g2aXCKqE2fbPqIs1JaQTbhvPmiAPJkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbgKEXs0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:48:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732778AbgKEXra (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96DC222244;
        Thu,  5 Nov 2020 23:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620049;
        bh=9AGY6DA5OVMpS1095TpRRCpJtZFekTi8ozI5Zdqjq68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OS4ZqLS8J45wnrbG1GyCM02HwfxJvlA6gGkDEz6VO4voH0esOnq3un38U5QCEBBJS
         OkrE1zQUBT4oOyiFNBoBF7O0mW5drZYDvDNZMqlnbyBGtnPWq0HM+If3Uy2gRgkcOv
         3NIjFfka8cwlhyx26Lc6Nm63sQbgc43eo+VCYME8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 22/28] scftorture: Add full-test stutter capability
Date:   Thu,  5 Nov 2020 15:47:13 -0800
Message-Id: <20201105234719.23307-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In virtual environments on systems with hardware assist, inter-processor
interrupts must do very different things based on whether the target
vCPU is running or not.  This commit therefore enables torture-test
stuttering to better test these running/not-running transitions.

Suggested-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 3fbb7a7..d55a9f8 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -59,7 +59,7 @@ torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (s), 0=disable");
 torture_param(int, shutdown_secs, 0, "Shutdown time (ms), <= zero to disable.");
 torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s.");
-torture_param(int, stutter_cpus, 5, "Number of jiffies to change CPUs under test, 0=disable");
+torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
 torture_param(bool, use_cpus_read_lock, 0, "Use cpus_read_lock() to exclude CPU hotplug.");
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 torture_param(int, weight_resched, -1, "Testing weight for resched_cpu() operations.");
@@ -436,6 +436,7 @@ static int scftorture_invoker(void *arg)
 			was_offline = false;
 		}
 		cond_resched();
+		stutter_wait("scftorture_invoker");
 	} while (!torture_must_stop());
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d ended", scfp->cpu);
@@ -448,8 +449,8 @@ static void
 scftorture_print_module_parms(const char *tag)
 {
 	pr_alert(SCFTORT_FLAG
-		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter_cpus=%d use_cpus_read_lock=%d, weight_resched=%d, weight_single=%d, weight_single_wait=%d, weight_many=%d, weight_many_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
-		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter_cpus, use_cpus_read_lock, weight_resched, weight_single, weight_single_wait, weight_many, weight_many_wait, weight_all, weight_all_wait);
+		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d use_cpus_read_lock=%d, weight_resched=%d, weight_single=%d, weight_single_wait=%d, weight_many=%d, weight_many_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
+		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter, use_cpus_read_lock, weight_resched, weight_single, weight_single_wait, weight_many, weight_many_wait, weight_all, weight_all_wait);
 }
 
 static void scf_cleanup_handler(void *unused)
@@ -558,6 +559,11 @@ static int __init scf_torture_init(void)
 		if (firsterr)
 			goto unwind;
 	}
+	if (stutter > 0) {
+		firsterr = torture_stutter_init(stutter, stutter);
+		if (firsterr)
+			goto unwind;
+	}
 
 	// Worker tasks invoking smp_call_function().
 	if (nthreads < 0)
-- 
2.9.5

