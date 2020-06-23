Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D67AC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622932076A
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872216;
	bh=aN1NgEvLJWwek4oA/17xzB8fUK3W9nCdyXsLPv1nRqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2cHzV2eUfhEn+tKbrGTET/yepabgHIxaFOZwSAcTNEZOERsFVE6b5utYbwGvzOxDN
	 adMRw42qF1+zpYLwLafO/Cj/6jr2X3NcBB62LJ0wLR8fvqMB+EtmgMtJEPzdgk9GIn
	 RfnrzrHIQDIENTse7cV6uzL0487q+l0CkvYnXGY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgFWAaQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731222AbgFWAaP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:15 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA15204EC;
        Tue, 23 Jun 2020 00:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872215;
        bh=aN1NgEvLJWwek4oA/17xzB8fUK3W9nCdyXsLPv1nRqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmhObBc7tBHn9ElGasTidcvMd9n2iGHPEHpbwflwbpyZ+oD7+40aXml3fqRmQD1nP
         o62vdlZOX6ZtDaQRT8KJoGKrle5Z/H20IIkk5EWwvpzBoQm3qMy1Ol1If7mkfC/cll
         /W+C7Nzf1Bxt4ZcIGJegaSXUnqE7J/fHKLiXzJiU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/30] rcuperf: Remove useless while loops around wait_event
Date:   Mon, 22 Jun 2020 17:29:44 -0700
Message-Id: <20200623003013.26252-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

wait_event() already retries if the condition for the wake up is not
satisifed after wake up. Remove them from the rcuperf test.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuperf.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 16dd1e6..246da8f 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -576,11 +576,8 @@ static int compute_real(int n)
 static int
 rcu_perf_shutdown(void *arg)
 {
-	do {
-		wait_event(shutdown_wq,
-			   atomic_read(&n_rcu_perf_writer_finished) >=
-			   nrealwriters);
-	} while (atomic_read(&n_rcu_perf_writer_finished) < nrealwriters);
+	wait_event(shutdown_wq,
+		   atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters);
 	smp_mb(); /* Wake before output. */
 	rcu_perf_cleanup();
 	kernel_power_off();
@@ -693,11 +690,8 @@ kfree_perf_cleanup(void)
 static int
 kfree_perf_shutdown(void *arg)
 {
-	do {
-		wait_event(shutdown_wq,
-			   atomic_read(&n_kfree_perf_thread_ended) >=
-			   kfree_nrealthreads);
-	} while (atomic_read(&n_kfree_perf_thread_ended) < kfree_nrealthreads);
+	wait_event(shutdown_wq,
+		   atomic_read(&n_kfree_perf_thread_ended) >= kfree_nrealthreads);
 
 	smp_mb(); /* Wake before output. */
 
-- 
2.9.5

