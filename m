Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA88C433E7
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984102083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897015;
	bh=NHb/uTlI4XHsRb/k0hOwL2ogF8mCSlrEuc3/2RLkKwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yd2YN/ZpEss0rxl10ibPt8SvtkRWyqNZVC97dMGInYOkkgWssF0Gb1XV3CYMeJYsW
	 UOqwkrcBw+eBrm4MtuifD8Vq3vNtUx/+W7ijOFc2LbnUyfsOEsERBGpS1vW4Rgu9+W
	 lPin4b8Us4PWBqA6Rth/XDg1GHuugn2iU1DDTH9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgHaSC5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgHaSB0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BBD21582;
        Mon, 31 Aug 2020 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896886;
        bh=NHb/uTlI4XHsRb/k0hOwL2ogF8mCSlrEuc3/2RLkKwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBPmO5/kGI8gApBVBahCdZgxKSWm5wQnN4i/V76N5DT9AdUokBFaTWrtKWjgmcwln
         6pNXdmmrxbZh+8GUWBmvDAVGTtoEWjdjD3N/8jWn31bucAXC/0lpJtT2IhQJTSe0zx
         CCFiBgRVQukHJrJTskeT6Nx+RpxcE+sHSv6PZvA4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/24] rcu: Move rcu_cpu_started per-CPU variable to rcu_data
Date:   Mon, 31 Aug 2020 11:01:10 -0700
Message-Id: <20200831180116.32690-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

When the rcu_cpu_started per-CPU variable was added by commit
f64c6013a202 ("rcu/x86: Provide early rcu_cpu_starting() callback"),
there were multiple sets of per-CPU rcu_data structures.  Therefore, the
rcu_cpu_started flag was added as a separate per-CPU variable.  But now
there is only one set of per-CPU rcu_data structures, so this commit
moves rcu_cpu_started to a new ->cpu_started field in that structure.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 11 ++++-------
 kernel/rcu/tree.h |  1 +
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da05afc..52108dd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3967,8 +3967,6 @@ int rcutree_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
-static DEFINE_PER_CPU(int, rcu_cpu_started);
-
 /*
  * Mark the specified CPU as being online so that subsequent grace periods
  * (both expedited and normal) will wait on it.  Note that this means that
@@ -3988,12 +3986,11 @@ void rcu_cpu_starting(unsigned int cpu)
 	struct rcu_node *rnp;
 	bool newcpu;
 
-	if (per_cpu(rcu_cpu_started, cpu))
+	rdp = per_cpu_ptr(&rcu_data, cpu);
+	if (rdp->cpu_started)
 		return;
+	rdp->cpu_started = true;
 
-	per_cpu(rcu_cpu_started, cpu) = 1;
-
-	rdp = per_cpu_ptr(&rcu_data, cpu);
 	rnp = rdp->mynode;
 	mask = rdp->grpmask;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -4053,7 +4050,7 @@ void rcu_report_dead(unsigned int cpu)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	raw_spin_unlock(&rcu_state.ofl_lock);
 
-	per_cpu(rcu_cpu_started, cpu) = 0;
+	rdp->cpu_started = false;
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index c96ae35..309bc7f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -156,6 +156,7 @@ struct rcu_data {
 	bool		beenonline;	/* CPU online at least once. */
 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
 	bool		exp_deferred_qs; /* This CPU awaiting a deferred QS? */
+	bool		cpu_started;	/* RCU watching this onlining CPU. */
 	struct rcu_node *mynode;	/* This CPU's leaf of hierarchy */
 	unsigned long grpmask;		/* Mask to apply to leaf qsmask. */
 	unsigned long	ticks_this_gp;	/* The number of scheduling-clock */
-- 
2.9.5

