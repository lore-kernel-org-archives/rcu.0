Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82BEC388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953812073A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620144;
	bh=oUwhdbK9KSe3gQBR4CXLgvIUkHvmer6tKhM7vfbOvtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MiLBxookN2RR2taqVGPD8KvognnWjE56Hagk+gIJ/oOrF+BEdvkurAM7j7dQSnUqi
	 lxy+464UJ8xyxJP79O2ORagq+0ZVlfp1huUNhxLoDet3mxEiVyknfGB64924MxcPro
	 bRPezXj/ZkgrVjqjDmKCK7X4VcRKPxbFZ76jNiNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbgKEXtD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEXrX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:23 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C383320A8B;
        Thu,  5 Nov 2020 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620043;
        bh=oUwhdbK9KSe3gQBR4CXLgvIUkHvmer6tKhM7vfbOvtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3TlvljVeMGS6Rgdh1YntakbpDGFjMdmkcDyRzreqkAidPqSaOWI068F4Tvd9P2gD
         bLCJhfE48jUYj4u+P84RGk/7aP0+uV0980fgQqc2UWT3+SbGMeXg5W3L5NWKa6ndaV
         grgmmailze6Wqncfwvx2ki7WoIdkQfq1jZ5BlFbw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH tip/core/rcu 03/28] locktorture: Track time of last ->writeunlock()
Date:   Thu,  5 Nov 2020 15:46:54 -0800
Message-Id: <20201105234719.23307-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a last_lock_release variable that tracks the time of
the last ->writeunlock() call, which allows easier diagnosing of lock
hangs when using a kernel debugger.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 62d215b..316531d 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -60,6 +60,7 @@ static struct task_struct **reader_tasks;
 
 static bool lock_is_write_held;
 static bool lock_is_read_held;
+static unsigned long last_lock_release;
 
 struct lock_stress_stats {
 	long n_lock_fail;
@@ -632,6 +633,7 @@ static int lock_torture_writer(void *arg)
 		lwsp->n_lock_acquired++;
 		cxt.cur_ops->write_delay(&rand);
 		lock_is_write_held = false;
+		WRITE_ONCE(last_lock_release, jiffies);
 		cxt.cur_ops->writeunlock();
 
 		stutter_wait("lock_torture_writer");
-- 
2.9.5

