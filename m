Return-Path: <SRS0=zrtj=4W=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3275C3F2CD
	for <rcu@archiver.kernel.org>; Thu,  5 Mar 2020 08:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B65A2073D
	for <rcu@archiver.kernel.org>; Thu,  5 Mar 2020 08:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="jSZV6G8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCEIS5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:18:57 -0500
Received: from mail-m963.mail.126.com ([123.126.96.3]:33768 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCEIS5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Mar 2020 03:18:57 -0500
X-Greylist: delayed 1919 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 03:18:49 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=k9HkUhFYn1+h3FUkrG
        ApXkMLDxlEv2B5rAwCtF/NaqQ=; b=jSZV6G8wQJFoTL3AUqBp248iCElFbcoL0t
        6c77OFpy7vZH0KQa4AdH2Ztd+ISy1SiiJUU6TmLFZ8eWNK2sC568G171JbSiiV8e
        szW6pA53Sitv+rxY+vMzsGS5bURWI3e/oZJ5GaUld3BVzmR2VVvIKAwQvxBXGtAz
        XTa9BeMOA=
Received: from pek-lpd-ccm2.wrs.com (unknown [60.247.85.82])
        by smtp8 (Coremail) with SMTP id NORpCgDH1toYrmBeqjl1GQ--.6848S2;
        Thu, 05 Mar 2020 15:45:34 +0800 (CST)
From:   Zhaolong Zhang <zhangzl2013@126.com>
To:     Zhaolong Zhang <zhangzl2013@126.com.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Fix the (t=0 jiffies) false positive
Date:   Thu,  5 Mar 2020 15:45:57 +0800
Message-Id: <1583394357-11767-1-git-send-email-zhangzl2013@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: NORpCgDH1toYrmBeqjl1GQ--.6848S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr48tr4DKrWxAw1DZr4kCrg_yoW8Kr17pa
        y7Ka47ta1UJF1vva47t3s5Xr1UJr4kXa47ta9Fy34Fva15JF4FqF90v34UKrWUur93WrWa
        vFyFyF9rAw4ktFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2_M3UUUUU=
X-Originating-IP: [60.247.85.82]
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbitQTdz1pEAlS7TwAAsf
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Calculate 't' with the previously recorded 'gps' instead of 'gp_start'.

Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
---
 kernel/rcu/tree_stall.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 55f9b84..4223b8b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -371,7 +371,7 @@ static void rcu_check_gp_kthread_starvation(void)
 	}
 }
 
-static void print_other_cpu_stall(unsigned long gp_seq)
+static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
 	int cpu;
 	unsigned long flags;
@@ -408,7 +408,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_cont("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n",
-	       smp_processor_id(), (long)(jiffies - rcu_state.gp_start),
+	       smp_processor_id(), (long)(jiffies - gps),
 	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 	if (ndetected) {
 		rcu_dump_cpu_stacks();
@@ -442,7 +442,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 	rcu_force_quiescent_state();  /* Kick them all. */
 }
 
-static void print_cpu_stall(void)
+static void print_cpu_stall(unsigned long gps)
 {
 	int cpu;
 	unsigned long flags;
@@ -467,7 +467,7 @@ static void print_cpu_stall(void)
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_cont("\t(t=%lu jiffies g=%ld q=%lu)\n",
-		jiffies - rcu_state.gp_start,
+		jiffies - gps,
 		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 
 	rcu_check_gp_kthread_starvation();
@@ -546,7 +546,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
 		/* We haven't checked in, so go dump stack. */
-		print_cpu_stall();
+		print_cpu_stall(gps);
 		if (rcu_cpu_stall_ftrace_dump)
 			rcu_ftrace_dump(DUMP_ALL);
 
@@ -555,7 +555,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
 		/* They had a few time units to dump stack, so complain. */
-		print_other_cpu_stall(gs2);
+		print_other_cpu_stall(gs2, gps);
 		if (rcu_cpu_stall_ftrace_dump)
 			rcu_ftrace_dump(DUMP_ALL);
 	}
-- 
1.8.3.1

