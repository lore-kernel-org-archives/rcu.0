Return-Path: <SRS0=KYXL=5M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC3CC2D0E5
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A082073B
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585347937;
	bh=yBox/4GWVJ8ewhqBGhJZd6XuRgqwee8Uc9VXqctFhDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UqSjelqkbfPbJhkRGPBgDBkezVJywPUvdz/ymvuvb8836gg/Hdon03qCfqIm6TniQ
	 qWCRDYCTirKE0JTi/x9V+ZWM6e0K7ch13XupunMJplR9Kplpx/YPRdHyXCRNf9hBf3
	 RSdNA12N8SVZGTcvkH+4b0I9yHgFycGAYmHeC1T8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgC0WZK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbgC0WZK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1286121775;
        Fri, 27 Mar 2020 22:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347909;
        bh=yBox/4GWVJ8ewhqBGhJZd6XuRgqwee8Uc9VXqctFhDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6rZPslJAC8t5VhpKpG1VVSOv5LybYgM4RZ6cq6QQGtS0T//U0QxuMlNkWyfW4bHc
         T7/wCy/unkacM8TeNeChXez6ZsBkU2UUaDaK3y7g/5Udn60OQF3qmBoKGtpsiZmcKg
         K5fYC7a/7ugOpstHTXiqXcYVpRHPtTLKZGBUAqco=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 32/34] rcu-tasks: Add count for idle tasks on offline CPUs
Date:   Fri, 27 Mar 2020 15:24:54 -0700
Message-Id: <20200327222456.12470-32-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a counter for the number of times the quiescent state
was an idle task associated with an offline CPU, and prints this count
at the end of rcutorture runs and at stall time.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index c1a0706..06fe0c4 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -729,6 +729,7 @@ static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
 // heavyweight readers executing explicit memory barriers.
 unsigned long n_heavy_reader_attempts;
 unsigned long n_heavy_reader_updates;
+unsigned long n_heavy_reader_ofl_updates;
 
 void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
@@ -840,6 +841,8 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 		    !rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
 			return false; // No quiescent state, do it the hard way.
 		n_heavy_reader_updates++;
+		if (ofl)
+			n_heavy_reader_ofl_updates++;
 		in_qs = true;
 	} else {
 		in_qs = likely(!t->trc_reader_nesting);
@@ -1152,7 +1155,8 @@ static void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
-	sprintf(buf, "N%d h:%lu/%lu", atomic_read(&trc_n_readers_need_end),
+	sprintf(buf, "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
+		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
 		data_race(n_heavy_reader_attempts));
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
-- 
2.9.5

