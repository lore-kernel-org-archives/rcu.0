Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55123C433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF4720738
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872745;
	bh=59g/82BSlaIY56f9P3jZTbbeHHZU54Rs4Q/8tqRRM1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CFRv5NdmZEzTqkJM5JaXoVNOV7quzXj8KjsUH6WKKufS34nZLsFUxQq7wAkEbEEHh
	 kYokcb+DSfy0YZ5P+8y0pOp7V0ubUHVSh1d/B5ySutynKfXBSc4gyQliysT91c6m2n
	 7Eb0oeRY63V+LSyGPhiKcq3s6rdT2tOr36NJlIQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgFWAjC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732024AbgFWAhz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5853E20B80;
        Tue, 23 Jun 2020 00:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872675;
        bh=59g/82BSlaIY56f9P3jZTbbeHHZU54Rs4Q/8tqRRM1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4cxGF3DvowyXFJbsJUsP7YdCgPUg03IC627MVC08/MMYV3P1oeoX6BdYO8xd3Dbk
         lCw+dvzLUiBjaYKYRTlXZkRJB960lrY9cCKKSeifp2m901RrIUOYaBJWQsg6o/KmzN
         yyF7QJdUrnNNTunFeZydG/Jj4FEAV3z5r9I5ZxDY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/23] rcutorture: NULL rcu_torture_current earlier in cleanup code
Date:   Mon, 22 Jun 2020 17:37:36 -0700
Message-Id: <20200623003752.26872-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the rcu_torture_current variable remains non-NULL until after
all readers have stopped.  During this time, rcu_torture_stats_print()
will think that the test is still ongoing, which can result in confusing
dmesg output.  This commit therefore NULLs rcu_torture_current immediately
after the rcu_torture_writer() kthread has decided to stop, thus informing
rcu_torture_stats_print() much sooner.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2621a33..5911207 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1172,6 +1172,7 @@ rcu_torture_writer(void *arg)
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
 				}
 	} while (!torture_must_stop());
+	rcu_torture_current = NULL;  // Let stats task know that we are done.
 	/* Reset expediting back to unexpedited. */
 	if (expediting > 0)
 		expediting = -expediting;
@@ -2473,7 +2474,6 @@ rcu_torture_cleanup(void)
 					     reader_tasks[i]);
 		kfree(reader_tasks);
 	}
-	rcu_torture_current = NULL;
 
 	if (fakewriter_tasks) {
 		for (i = 0; i < nfakewriters; i++) {
-- 
2.9.5

