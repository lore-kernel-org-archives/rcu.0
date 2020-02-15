Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F97C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D912082F
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581727322;
	bh=0me1sJ+gS24N/k3cGzSFkeJDlsEwUYBh4lmMD3tXXHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m5cQKFewhBhofaoUTuuZ87ksfPiVUxQFMe0TntOENvTPzpzo8Pny5ySFQfn3J0yyf
	 OcQRMrYgAIg/SGIdALAHUg5cxKHKmPevFhmeXXnLLW8mgfVwT0AsCsO+Fb76l7QKjI
	 JKG/7I9+1n37lzAWx3KTjoKcztJIW+MajzuPl8fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgBOAmB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAmB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:42:01 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E6F9206CC;
        Sat, 15 Feb 2020 00:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727320;
        bh=0me1sJ+gS24N/k3cGzSFkeJDlsEwUYBh4lmMD3tXXHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tB8Hu/IRPceHO8bXCV4drfZYOD93McL6Qe0PLR0t0S96+afRvD6g6jzbY/Mp5SD9P
         CeL3ZELBAA+oqc62hTdKPdNDMTVj4Lbr1ANAET7CwlMv29LtEMSzOD2dQrabyVRDKK
         wCxa9KyHb2IpNzwoUB/ovVXLAR3BS5K9gwUujM7A=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/18] rcuperf: Measure memory footprint during kfree_rcu() test
Date:   Fri, 14 Feb 2020 16:41:22 -0800
Message-Id: <20200215004125.16953-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

During changes to kfree_rcu() code, we often check the amount of free
memory.  As an alternative to checking this manually, this commit adds a
measurement in the test itself.  It measures four times during the test
for available memory, digitally filters these measurements to produce a
running average with a weight of 0.5, and compares this digitally filtered
value with the amount of available memory at the beginning of the test.

Something like the following is printed at the end of the run:

Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuperf.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index da94b89..a4a8d09 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/err.h>
@@ -611,6 +612,7 @@ kfree_perf_thread(void *arg)
 	long me = (long)arg;
 	struct kfree_obj *alloc_ptr;
 	u64 start_time, end_time;
+	long long mem_begin, mem_during = 0;
 
 	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
@@ -626,6 +628,12 @@ kfree_perf_thread(void *arg)
 	}
 
 	do {
+		if (!mem_during) {
+			mem_during = mem_begin = si_mem_available();
+		} else if (loop % (kfree_loops / 4) == 0) {
+			mem_during = (mem_during + si_mem_available()) / 2;
+		}
+
 		for (i = 0; i < kfree_alloc_num; i++) {
 			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
 			if (!alloc_ptr)
@@ -645,9 +653,11 @@ kfree_perf_thread(void *arg)
 		else
 			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
 
-		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
+		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
 		       (unsigned long long)(end_time - start_time), kfree_loops,
-		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
+		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
+		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
+
 		if (shutdown) {
 			smp_mb(); /* Assign before wake. */
 			wake_up(&shutdown_wq);
-- 
2.9.5

