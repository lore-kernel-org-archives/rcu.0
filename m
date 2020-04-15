Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB14BC2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95EF12076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586971879;
	bh=JxgKlG4fjDGWQjaJg9tkjDnCcb/RI0ZUVz7/OvSjvBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HCH8GQUkh60975ASRCL1ysLEcesFGsHW568YGUHm0SMgwBSiLXwYFjm+IR9rYy3of
	 2tW/Jxzhrxe7KsVMgoq0VmUW8I5SUnwDpeDVZbJN1FgWPZ+Dz4SMki6x0T9jABz6Al
	 eO4gKvK4eJX5SrharzrKJPLjiyyxIttrR7/Zi+SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411151AbgDORbS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411133AbgDORbI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EA4421841;
        Wed, 15 Apr 2020 17:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971867;
        bh=JxgKlG4fjDGWQjaJg9tkjDnCcb/RI0ZUVz7/OvSjvBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JbDboS9F1QwHTfCbyD2Vuz8GDQ6UQ2oTraAm+bvYchQ47V2re10uUVjvxztgcFBZd
         ZbyS88m7Cpy8P8hZ8yWAlTLp9zBbM0NWPjDaeTL4XgOUUweFEw8YqLvG9vgChhaTvX
         FoG5ghld+hCN8CAd0/IKdpZ8NMyLU2ho/bXuPzuo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/18] rcutorture: Convert ULONG_CMP_LT() to time_before()
Date:   Wed, 15 Apr 2020 10:31:00 -0700
Message-Id: <20200415173100.9927-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit converts three ULONG_CMP_LT() invocations in rcutorture to
time_before() to reflect the fact that they are comparing timestamps to
the jiffies counter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c7b7594b..fc96147 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -848,7 +848,7 @@ static int rcu_torture_boost(void *arg)
 
 		/* Wait for the next test interval. */
 		oldstarttime = boost_starttime;
-		while (ULONG_CMP_LT(jiffies, oldstarttime)) {
+		while (time_before(jiffies, oldstarttime)) {
 			schedule_timeout_interruptible(oldstarttime - jiffies);
 			stutter_wait("rcu_torture_boost");
 			if (torture_must_stop())
@@ -858,7 +858,7 @@ static int rcu_torture_boost(void *arg)
 		/* Do one boost-test interval. */
 		endtime = oldstarttime + test_boost_duration * HZ;
 		call_rcu_time = jiffies;
-		while (ULONG_CMP_LT(jiffies, endtime)) {
+		while (time_before(jiffies, endtime)) {
 			/* If we don't have a callback in flight, post one. */
 			if (!smp_load_acquire(&rbi.inflight)) {
 				/* RCU core before ->inflight = 1. */
@@ -929,7 +929,7 @@ rcu_torture_fqs(void *arg)
 	VERBOSE_TOROUT_STRING("rcu_torture_fqs task started");
 	do {
 		fqs_resume_time = jiffies + fqs_stutter * HZ;
-		while (ULONG_CMP_LT(jiffies, fqs_resume_time) &&
+		while (time_before(jiffies, fqs_resume_time) &&
 		       !kthread_should_stop()) {
 			schedule_timeout_interruptible(1);
 		}
-- 
2.9.5

