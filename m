Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE0EC433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25B72053B
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872342;
	bh=3Oi1QCFDmxnGuJzvayyzGYUVZCZRr+L2VMWhGOQX91U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DyC0uVOL9zt0tsRDMFTtiuZsZ2SMGarQp8MkEjRTd7FRRQGd9AL/QsEgkI/ctAZHS
	 l0hnH3jESVHm55gAIMMBwja3+e+fpEnRhvavGKubGptqtIOH6KHw/jn/Sh1XBLeEd9
	 OAQoOJgCwJMA68/ZddCPEzMIREABNOuECZu8xBKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbgFWAcP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731611AbgFWAaQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:16 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0E582076E;
        Tue, 23 Jun 2020 00:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872215;
        bh=3Oi1QCFDmxnGuJzvayyzGYUVZCZRr+L2VMWhGOQX91U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CLDEyjwrUO341U/hWG+Ms1CHSy93p+/wP+nf5aa/Kk68xvxEKaLQ7LgVRHJ+hDfYy
         yE5q2QQHfoNHzBGLGfktRtMJf8oCjkcaLudIxru7QLDmXEerwgSlOcAtGTQFQMfleF
         JieMaHRn+eDsqgepx+CpcclOhh4GtcLU1PQybuEs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/30] rcuperf: Add comments explaining the high reader overhead
Date:   Mon, 22 Jun 2020 17:29:46 -0700
Message-Id: <20200623003013.26252-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds comments explaining why the readers have otherwise insane
levels of measurement overhead, namely that they are intended as a test
load for update-side performance measurements, not as a straight-up
read-side performance test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuperf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 246da8f..d906ca9 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -69,6 +69,11 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
  *	value specified by nr_cpus for a read-only test.
  *
  * Various other use cases may of course be specified.
+ *
+ * Note that this test's readers are intended only as a test load for
+ * the writers.  The reader performance statistics will be overly
+ * pessimistic due to the per-critical-section interrupt disabling,
+ * test-end checks, and the pair of calls through pointers.
  */
 
 #ifdef MODULE
@@ -309,8 +314,10 @@ static void rcu_perf_wait_shutdown(void)
 }
 
 /*
- * RCU perf reader kthread.  Repeatedly does empty RCU read-side
- * critical section, minimizing update-side interference.
+ * RCU perf reader kthread.  Repeatedly does empty RCU read-side critical
+ * section, minimizing update-side interference.  However, the point of
+ * this test is not to evaluate reader performance, but instead to serve
+ * as a test load for update-side performance testing.
  */
 static int
 rcu_perf_reader(void *arg)
-- 
2.9.5

