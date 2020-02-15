Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B262C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64188222C4
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581725033;
	bh=oE+tuDXUM8zX3a79hYiiMgfhDS4aNiQe0Cl9TFrDGXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bU8WCtFal6h0sQUtQ1B2UxddNxmhmES+QIP2xxU97hb74UJS8ICFRzDGgVD9l1FSI
	 A0k6NmGuXshYTDaon+/f/l4mQ89rUOOzMyRu/W9ThMUO99J4IvsiKhA0ou3QvhE9OE
	 sN7yeFDmN4aMzwZ+U/Ht4O47m75Iqn+CcR7PbjSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgBOADx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:03:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbgBOADx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:03:53 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C3A92187F;
        Sat, 15 Feb 2020 00:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725032;
        bh=oE+tuDXUM8zX3a79hYiiMgfhDS4aNiQe0Cl9TFrDGXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0BlRvTeanvtRPrmIMJMGQxdmvd8ygzHn88Rk4E1h6jsAKs/lGVoptPfs20h0x5UW
         xwdfiFlMbY3IRdizqD68zJuA392m7mq1vkVkrIJameKDHxDy+T/mWK3bYQ0tK76gmi
         F2cEAcO6i6JHaO12LvWvMVSp4kjxxJAV+7iujEC4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/4] locktorture: Use private random-number generators
Date:   Fri, 14 Feb 2020 16:03:36 -0800
Message-Id: <20200215000337.14667-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215000312.GA14585@paulmck-ThinkPad-P72>
References: <20200215000312.GA14585@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Both lock_torture_writer() and lock_torture_reader() use the "static"
keyword on their DEFINE_TORTURE_RANDOM(rand) declarations, which means
that a single instance of a random-number generator are shared among all
the writers and another is shared among all the readers.  Unfortunately,
this random-number generator was not designed for concurrent access.
This commit therefore removes both "static" keywords so that each reader
and each writer gets its own random-number generator.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 687c1d8..5baf904 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -618,7 +618,7 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
 static int lock_torture_writer(void *arg)
 {
 	struct lock_stress_stats *lwsp = arg;
-	static DEFINE_TORTURE_RANDOM(rand);
+	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
 	set_user_nice(current, MAX_NICE);
@@ -655,7 +655,7 @@ static int lock_torture_writer(void *arg)
 static int lock_torture_reader(void *arg)
 {
 	struct lock_stress_stats *lrsp = arg;
-	static DEFINE_TORTURE_RANDOM(rand);
+	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("lock_torture_reader task started");
 	set_user_nice(current, MAX_NICE);
-- 
2.9.5

