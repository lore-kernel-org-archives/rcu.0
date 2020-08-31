Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA8AC433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387AE20866
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897292;
	bh=hhasqB04qNI05WUYruSzF5s0ZxVOSwtaVWgIBlobBw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uYdi/n8bvqLCN4Z47RIYrrLefIKOR+R794cmZ3YyxW9dnlP+7HFDS6CbFZPHC00pn
	 d+74VNb0XpSMvksjYXOb8e0aF217QVkF/i+jZFUcUlsliFhU3Wwj6SYz3VNPXwbFhY
	 E2YIlMv4PnWrgG0K/C0Peyyhl0vyNhtt72czex8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgHaSIL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729239AbgHaSH4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B17021655;
        Mon, 31 Aug 2020 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897274;
        bh=hhasqB04qNI05WUYruSzF5s0ZxVOSwtaVWgIBlobBw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=edb4k70hZsaVKeTwt6NWY8egxFAiGru+P8nSVv/Fnv19cDM+yzke/hZQE3WMUd1yi
         O4aVLpR7NHDP6VlxR426XT3yYraU6bGnAmP1OS/nVLv4j1JMVxsUXFnnX3q1p/peSH
         bIDfXkU9tLaUG32Yb6axnRBwnbb2OtLu3/dG1wsM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/19] scftorture: Prevent compiler from reducing race probabilities
Date:   Mon, 31 Aug 2020 11:07:43 -0700
Message-Id: <20200831180749.843-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Detecting smp_call_function() memory misordering requires close timing,
so it is necessary to have the checks immediately before and after
the call to the smp_call_function*() function under test.  This commit
therefore inserts barrier() calls to prevent the compiler from optimizing
memory-misordering detection down into the zone of extreme improbability.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 880c2ce..8349681 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -322,6 +322,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfp->n_single++;
 		if (scfcp) {
 			scfcp->scfc_cpu = cpu;
+			barrier(); // Prevent race-reduction compiler optimizations.
 			scfcp->scfc_in = true;
 		}
 		ret = smp_call_function_single(cpu, scf_handler_1, (void *)scfcp, scfsp->scfs_wait);
@@ -339,8 +340,10 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfp->n_many_wait++;
 		else
 			scfp->n_many++;
-		if (scfcp)
+		if (scfcp) {
+			barrier(); // Prevent race-reduction compiler optimizations.
 			scfcp->scfc_in = true;
+		}
 		smp_call_function_many(cpu_online_mask, scf_handler, scfcp, scfsp->scfs_wait);
 		break;
 	case SCF_PRIM_ALL:
@@ -348,8 +351,10 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfp->n_all_wait++;
 		else
 			scfp->n_all++;
-		if (scfcp)
+		if (scfcp) {
+			barrier(); // Prevent race-reduction compiler optimizations.
 			scfcp->scfc_in = true;
+		}
 		smp_call_function(scf_handler, scfcp, scfsp->scfs_wait);
 		break;
 	}
@@ -358,6 +363,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			atomic_inc(&n_mb_out_errs); // Leak rather than trash!
 		else
 			kfree(scfcp);
+		barrier(); // Prevent race-reduction compiler optimizations.
 	}
 	if (use_cpus_read_lock)
 		cpus_read_unlock();
-- 
2.9.5

