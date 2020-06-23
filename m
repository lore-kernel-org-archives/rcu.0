Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2FBC433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C951D2053B
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872285;
	bh=HAS4qKnnRBhugP+ZvtmNNZcrbU4ltYBHsKHxblEzTk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZI5mBTx83zXfZeAJvbrbjpkhd5TJr4BbCoS9ABeLZSx8KSKAJ43kkdzqaCTTJKXRK
	 lSw7t/eRJ040FMBg6ugCcnQMFtUpWCDRB6M16SBnY6J+t1w6ybpRM2CfP5n1nxOAhC
	 5yAgMKTx6NPbiiJ2Hxk4c6ACDcXdzYb6LjQM/5c0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbgFWAbZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731676AbgFWAaT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D40820EDD;
        Tue, 23 Jun 2020 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872218;
        bh=HAS4qKnnRBhugP+ZvtmNNZcrbU4ltYBHsKHxblEzTk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XReSa3XArAS8trhFo9pU5TChytKDykjy2RSEWz0zLGt6Y+zs6CG9DF9KegOfpjtka
         RPzsx8OPhqJL2tQwghwL2MNFIiDclHCLLz/TQA80rzRraGoLyAhdhwCuzjLCyC7QFw
         cgxSxH3BvS0Bw1RfzNOjMnhr+YAx1X57vm9cTbRg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 16/30] refperf: Add warmup and cooldown processing phases
Date:   Mon, 22 Jun 2020 17:29:59 -0700
Message-Id: <20200623003013.26252-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit causes all the readers to start running unmeasured load
until all readers have done at least one such run (thus having warmed
up), then run the measured load, and then run unmeasured load until all
readers have completed their measured load.  This approach avoids any
thread running measured load while other readers are idle.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 234bb0e..445190b 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -100,6 +100,8 @@ static atomic_t nreaders_exp;
 // Use to wait for all threads to start.
 static atomic_t n_init;
 static atomic_t n_started;
+static atomic_t n_warmedup;
+static atomic_t n_cooleddown;
 
 // Track which experiment is currently running.
 static int exp_idx;
@@ -260,8 +262,15 @@ ref_perf_reader(void *arg)
 
 	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
 
-	// To prevent noise, keep interrupts disabled. This also has the
-	// effect of preventing entries into slow path for rcu_read_unlock().
+
+	// To reduce noise, do an initial cache-warming invocation, check
+	// in, and then keep warming until everyone has checked in.
+	cur_ops->readsection(loops);
+	if (!atomic_dec_return(&n_warmedup))
+		while (atomic_read_acquire(&n_warmedup))
+			cur_ops->readsection(loops);
+	// Also keep interrupts disabled.  This also has the effect
+	// of preventing entries into slow path for rcu_read_unlock().
 	local_irq_save(flags);
 	start = ktime_get_mono_fast_ns();
 
@@ -271,6 +280,11 @@ ref_perf_reader(void *arg)
 	local_irq_restore(flags);
 
 	rt->last_duration_ns = WARN_ON_ONCE(duration < 0) ? 0 : duration;
+	// To reduce runtime-skew noise, do maintain-load invocations until
+	// everyone is done.
+	if (!atomic_dec_return(&n_cooleddown))
+		while (atomic_read_acquire(&n_cooleddown))
+			cur_ops->readsection(loops);
 
 	if (atomic_dec_and_test(&nreaders_exp))
 		wake_up(&main_wq);
@@ -372,6 +386,8 @@ static int main_func(void *arg)
 		reset_readers();
 		atomic_set(&nreaders_exp, nreaders);
 		atomic_set(&n_started, nreaders);
+		atomic_set(&n_warmedup, nreaders);
+		atomic_set(&n_cooleddown, nreaders);
 
 		exp_idx = exp;
 
-- 
2.9.5

