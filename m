Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23488C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D4E20787
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974893;
	bh=rL98/HL+UUL0mOeFE8KjUqsAvfPDg01xPNXPs8cMccg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dINsttXBjzEpi63ExhhHhffXMiJ4jy5HbrCv8ddBLzNm+p9nUEaXbzz4vt2ZXi8Hj
	 d1K43b+bk3SWPQLnyBgAeuQqpinbMXkZMB2fijcnod08QOU/fHN+qP8JYufMSebMX3
	 jWUrGdDy5fCn+sKi3umKKelvF8iv5u9/dI5W1DuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441460AbgDOSV3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441392AbgDOSTy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD80321D7D;
        Wed, 15 Apr 2020 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974794;
        bh=rL98/HL+UUL0mOeFE8KjUqsAvfPDg01xPNXPs8cMccg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1csMPNJtZhuaz2V1Vpli/hx3AngkOTaIGHKVXERRoMNNeGk/uEFNSx0X7/f4MRSo
         mhn30WAA7ukBnaDy+vAjOR1AvxMOGvgUz5eZU4zARXJftunw5SgozCa/kSLiHw6HjU
         N3nSOCcBwlAq6+T2PVMJON2Li2d1DzImG0heFPAM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 30/38] rcu-tasks: Handle the running-offline idle-task special case
Date:   Wed, 15 Apr 2020 11:19:33 -0700
Message-Id: <20200415181941.11653-30-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The idle task corresponding to an offline CPU can appear to be running
while that CPU is offline.  This commit therefore adds checks for this
situation, treating it as a quiescent state.  Because the tasklist scan
and the holdout-list scan now exclude CPU-hotplug operations, readers
on the CPU-hotplug paths are still waited for.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e8c03bd..1888a49 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -818,16 +818,20 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 {
 	int cpu = task_cpu(t);
 	bool in_qs = false;
+	bool ofl = cpu_is_offline(cpu);
 
 	if (task_curr(t)) {
+		WARN_ON_ONCE(ofl & !is_idle_task(t));
+
 		// If no chance of heavyweight readers, do it the hard way.
-		if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+		if (!ofl && !IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
 			return false;
 
 		// If heavyweight readers are enabled on the remote task,
 		// we can inspect its state despite its currently running.
 		// However, we cannot safely change its state.
-		if (!rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
+		if (!ofl && // Check for "running" idle tasks on offline CPUs.
+		    !rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
 			return false; // No quiescent state, do it the hard way.
 		in_qs = true;
 	} else {
-- 
2.9.5

