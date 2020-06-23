Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541B5C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 291462053B
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872284;
	bh=kYiQhMrNluGmJ/gH/lJElNvisMeCFkHWqBFYmA0RsSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NYyB4BDpiftboSMgglxVIRKF8TvVKUUBU4cyRZrTlK8CRMIXfOT1ZCwsttaZ8fL5K
	 Srtxke6YzuzPjtTd63iztJEcN464PYMnyuXnqhbP3OFCFi9nnna3EW4kVTtkrjpbCq
	 eFttWV6PfaragG8p6abv0mVj5zgecwwnAjsKwFM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgFWAbL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731716AbgFWAaU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 734892100A;
        Tue, 23 Jun 2020 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872220;
        bh=kYiQhMrNluGmJ/gH/lJElNvisMeCFkHWqBFYmA0RsSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUd852T7roU9GgtDSLSmezRpfvEPxLihZ7g2DqSsaukAztKX4/YoxgwCSKw0mtp8t
         mCzEMKcL5+qlzuYD3JsCGsq8OWdhOW7n1B8WI1c9nDz8BJKccXcaUairBuLJLk4miR
         ESsi4+xBwAZgfchQf+BR/zlegUp/TWngip5eA7Zk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 26/30] refperf: Add test for RCU Tasks readers
Date:   Mon, 22 Jun 2020 17:30:09 -0700
Message-Id: <20200623003013.26252-26-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds testing for RCU Tasks readers to the refperf module.
This also applies to RCU Rude readers, as both flavors have empty
(as in non-existent) read-side markers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index da7de9a..2bfdcdc 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -192,6 +192,31 @@ static struct ref_perf_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+// Definitions for RCU Tasks ref perf testing: Empty read markers.
+// These definitions also work for RCU Rude readers.
+static void rcu_tasks_ref_perf_read_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--)
+		continue;
+}
+
+static void rcu_tasks_ref_perf_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--)
+		un_delay(udl, ndl);
+}
+
+static struct ref_perf_ops rcu_tasks_ops = {
+	.init		= rcu_sync_perf_init,
+	.readsection	= rcu_tasks_ref_perf_read_section,
+	.delaysection	= rcu_tasks_ref_perf_delay_section,
+	.name		= "rcu-tasks"
+};
+
 // Definitions for RCU Tasks Trace ref perf testing.
 static void rcu_trace_ref_perf_read_section(const int nloops)
 {
@@ -613,7 +638,8 @@ ref_perf_init(void)
 	long i;
 	int firsterr = 0;
 	static struct ref_perf_ops *perf_ops[] = {
-		&rcu_ops, &srcu_ops, &rcu_trace_ops, &refcnt_ops, &rwlock_ops, &rwsem_ops,
+		&rcu_ops, &srcu_ops, &rcu_trace_ops, &rcu_tasks_ops,
+		&refcnt_ops, &rwlock_ops, &rwsem_ops,
 	};
 
 	if (!torture_init_begin(perf_type, verbose))
-- 
2.9.5

