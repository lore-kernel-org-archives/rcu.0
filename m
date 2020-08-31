Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621E8C433E7
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C98D2083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897095;
	bh=nh1GGNKPbtqYSrwuoMf0Ipvgb15nX5tMd1UAwYKuSvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ngZVck82vyJW0T/khoW4Jv3Cgt/qUCXwUGhynPnRJ5oOKJSSjLKLVyZt/5Sn4yljf
	 NvU+VtUWZWh4gZgIhCLZcqR87Cuu6vsbUNeSrHQXzNwxqjEZw3ArdFho3muJtVx0Nb
	 zWWpnG8XKkVYGs+Q9PZ+z5Lqp7kBNT17Hqq19xPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgHaSEi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbgHaSEL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:11 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6CE12158C;
        Mon, 31 Aug 2020 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897051;
        bh=nh1GGNKPbtqYSrwuoMf0Ipvgb15nX5tMd1UAwYKuSvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aAoEHOi6xCG+5OdN7NZvbkJvxCT5suIaFcHYRcPgS707aK2y9n35V6nFL/JptLMZg
         CtjcrP7eXo8X46yx6OMGzUuVDey3hZugPGkrwBDHd+7UYNnhOpMDq/vx83nPB2pLpk
         MR7mbAxfResIYhUwViXfK0DPeIds+DtGEKI3Q9vY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/14] rcutorture: Properly set rcu_fwds for OOM handling
Date:   Mon, 31 Aug 2020 11:04:01 -0700
Message-Id: <20200831180406.494-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The conversion of rcu_fwds to dynamic allocation failed to actually
allocate the required structure.  This commit therefore allocates it,
frees it, and updates rcu_fwds accordingly.  While in the area, it
abstracts the cleanup actions into rcu_torture_fwd_prog_cleanup().

Fixes: 5155be9994e5 ("rcutorture: Dynamically allocate rcu_fwds structure")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c8206ff..7942be4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2148,9 +2148,20 @@ static int __init rcu_torture_fwd_prog_init(void)
 		return -ENOMEM;
 	spin_lock_init(&rfp->rcu_fwd_lock);
 	rfp->rcu_fwd_cb_tail = &rfp->rcu_fwd_cb_head;
+	rcu_fwds = rfp;
 	return torture_create_kthread(rcu_torture_fwd_prog, rfp, fwd_prog_task);
 }
 
+static void rcu_torture_fwd_prog_cleanup(void)
+{
+	struct rcu_fwd *rfp;
+
+	torture_stop_kthread(rcu_torture_fwd_prog, fwd_prog_task);
+	rfp = rcu_fwds;
+	rcu_fwds = NULL;
+	kfree(rfp);
+}
+
 /* Callback function for RCU barrier testing. */
 static void rcu_torture_barrier_cbf(struct rcu_head *rcu)
 {
@@ -2448,7 +2459,7 @@ rcu_torture_cleanup(void)
 	show_rcu_gp_kthreads();
 	rcu_torture_read_exit_cleanup();
 	rcu_torture_barrier_cleanup();
-	torture_stop_kthread(rcu_torture_fwd_prog, fwd_prog_task);
+	rcu_torture_fwd_prog_cleanup();
 	torture_stop_kthread(rcu_torture_stall, stall_task);
 	torture_stop_kthread(rcu_torture_writer, writer_task);
 
-- 
2.9.5

