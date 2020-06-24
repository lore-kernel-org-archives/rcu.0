Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E85C433DF
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59E02082F
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029549;
	bh=pGAVnC+z5QaZ+ECnRT43ezvORWhbwihBXRMZQ/7qaAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YiOne2ll/GBPtDPd2bM+0XNy8h35CVHbulA3XtAMaJ5pBMdVZ9yRcrAdUvKMGjyyW
	 auvJaQy7Eig1c/jwIACrBvYJRNEitX22ZCQS+9Y+U8ol/e8Nis7Wf3B5aYbMgfZShG
	 BD3iMriUAoVsi8ELBuP03QAUg0pel2sdy4VvFOCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406369AbgFXUM2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406251AbgFXUM2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:28 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13B3B20823;
        Wed, 24 Jun 2020 20:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029548;
        bh=pGAVnC+z5QaZ+ECnRT43ezvORWhbwihBXRMZQ/7qaAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHbmpvjVNPa/TDD+ZvaaC7Z9ZdX1Wh0NJ8OwOGBicPHM9GysD24HjMA+ye2yfaIkD
         xub2z9xjCUBBMU6z171/vykZXHtGYEyzVXPuTVSAhbun4VBJPtgIm15D/wy1kEsact
         cCy1PniSKEgWJUNakOibDaU0BWeI8UmQWupf+NQ0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/17] rcu: Fix a kernel-doc warnings for "count"
Date:   Wed, 24 Jun 2020 13:12:10 -0700
Message-Id: <20200624201226.21197-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There are some kernel-doc warnings:

	./kernel/rcu/tree.c:2915: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'

This commit therefore moves the comment for "count" to the kernel-doc
markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c716ead..912d466 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2986,6 +2986,7 @@ struct kfree_rcu_cpu_work {
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
  * @initialized: The @lock and @rcu_work fields have been initialized
+ * @count: Number of objects for which GP not started
  *
  * This is a per-CPU structure.  The reason that it is not included in
  * the rcu_data structure is to permit this code to be extracted from
@@ -3001,7 +3002,6 @@ struct kfree_rcu_cpu {
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
-	// Number of objects for which GP not started
 	int count;
 };
 
-- 
2.9.5

