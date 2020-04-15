Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1E1C2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337A120784
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974842;
	bh=QIr3q6WJeHBwvcnpzSb8RI7xT1nOvA436IPTiIBNnsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=165AJJQrITBDecDe+LzXm5TaH98pmqGQ+4hvS7YeGEQT8hG7Nxfwi4lhJFnURGr4z
	 RGbuxwut/ArQT4ph4T8kq+Nji+27wNfc+g8JeVXKv9kJLDsjkEo4rbPVMUAf+C7plm
	 +DHPNw5xmxrhEiKRu6GgK65obuPQJWWPPh11MuhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441379AbgDOSUk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441397AbgDOSTz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E534321D93;
        Wed, 15 Apr 2020 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974795;
        bh=QIr3q6WJeHBwvcnpzSb8RI7xT1nOvA436IPTiIBNnsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GW2zFVczztjN4bJY29efVzzIVHx41bxIYv3It+siKOgBy6eWZGZsrfaxYP3digHN+
         8K3X4+q+5D+5yJU9N4UYCon/17El19C4wUEbWvY12dLjMN/iPsmqtDRukSJkBnKYBE
         /+v07pfADZKi63oUrq3w9VAzpGitfke/6cALb0VU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 33/38] rcu-tasks: Add count for idle tasks on offline CPUs
Date:   Wed, 15 Apr 2020 11:19:36 -0700
Message-Id: <20200415181941.11653-33-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
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
index b51f19a..43cac4b 100644
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

