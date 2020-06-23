Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9F1C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47AB20720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871761;
	bh=06nohskw9PVbeNhwjbZw+7xiYph6o7ocOBTjXlS2SlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YAXbn4ykhQ1Gc//kEXEdZxlMtverZDpcEabCLQNXwA6nLbXj8nxhXKBZadESnHDOp
	 NpPgabyl3N2SvXjloBOv46sGNd+JtdLP+eo9yq48Wtpc0IDG7iiVt92l9ffv4TB8zT
	 +BOTiWl8368zcsTeMnold2p7BIsF25MIF7OOucuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbgFWAWl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731565AbgFWAVx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB86B208FE;
        Tue, 23 Jun 2020 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871712;
        bh=06nohskw9PVbeNhwjbZw+7xiYph6o7ocOBTjXlS2SlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQ+CF3l0iyXm2/yEFMJJqvmd3O9ReNCgg+Rq7WPw+vglvhbL/SL+eE+x+YZmr8brA
         8MrTwt9bXGyL1Z3VFRSLL7AZZF5Lh/H7FhCA+nTgnvJSgY5vDYowNzdmKRfOMAGZOP
         qKLL3WYbwu+mDdDxEs1sDjP8gobPcHfnjAZkhgvM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH tip/core/rcu 17/26] lockdep: Complain only once about RCU in extended quiescent state
Date:   Mon, 22 Jun 2020 17:21:38 -0700
Message-Id: <20200623002147.25750-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, lockdep_rcu_suspicious() complains twice about RCU read-side
critical sections being invoked from within extended quiescent states,
for example:

	RCU used illegally from idle CPU!
	rcu_scheduler_active = 2, debug_locks = 1
	RCU used illegally from extended quiescent state!

This commit therefore saves a couple lines of code and one line of
console-log output by eliminating the first of these two complaints.

Link: https://lore.kernel.org/lkml/87wo4wnpzb.fsf@nanos.tec.linutronix.de
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/lockdep.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 29a8de4..0a7549d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5851,9 +5851,7 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	pr_warn("\n%srcu_scheduler_active = %d, debug_locks = %d\n",
 	       !rcu_lockdep_current_cpu_online()
 			? "RCU used illegally from offline CPU!\n"
-			: !rcu_is_watching()
-				? "RCU used illegally from idle CPU!\n"
-				: "",
+			: "",
 	       rcu_scheduler_active, debug_locks);
 
 	/*
-- 
2.9.5

