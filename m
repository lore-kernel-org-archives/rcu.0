Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A0AC63798
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A9561244
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbhGUTk7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240371AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA5BF61378;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=SdrpdiqsOqw1ZsbcidRIoS1RHh9baiBuMisVCrPhoEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCzu80q9eWNODF2A5llLlQ8BqcIW1MMrXhKi/HljySv1nw6DYNJl6yXfMUjaCQZdN
         6Y2KIz4oduKC2tcgDXp2+G0qQLrqOfc0x5Q7phqA1TVc9Vy8Nnhr0dAQn0eU5kMT8B
         FchlLVid0zxXjlPNgM43EMf0Zr/EfKjDUNvSswaLuGoLWByut80ydW3VU5tEkUxw74
         0QPmr2wiZ6vO8RizgAyXEG6FQjyC2Z0v6JP4YK4ztzjqVnmzjRSuAx1FOPffcATpef
         aEWkaDoewd27GWsPqqrB7By9uMCD+KWAB7xyi9MmqTQUHfMFI9I3Lf2ona3pXJflHG
         rEBLdDdabEj/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4975A5C10AA; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Liu Song <liu.song11@zte.com.cn>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 16/18] rcu: Use per_cpu_ptr to get the pointer of per_cpu variable
Date:   Wed, 21 Jul 2021 13:21:24 -0700
Message-Id: <20210721202127.2129660-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Liu Song <liu.song11@zte.com.cn>

There are a few remaining locations in kernel/rcu that still use
"&per_cpu()".  This commit replaces them with "per_cpu_ptr(&)", and does
not introduce any functional change.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Liu Song <liu.song11@zte.com.cn>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h      | 2 +-
 kernel/rcu/tree.c       | 2 +-
 kernel/rcu/tree_stall.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 8536c55df5142..21f00194e69d7 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -920,7 +920,7 @@ static void trc_read_check_handler(void *t_in)
 	// Allow future IPIs to be sent on CPU and for task.
 	// Also order this IPI handler against any later manipulations of
 	// the intended task.
-	smp_store_release(&per_cpu(trc_ipi_to_cpu, smp_processor_id()), false); // ^^^
+	smp_store_release(per_cpu_ptr(&trc_ipi_to_cpu, smp_processor_id()), false); // ^^^
 	smp_store_release(&texp->trc_ipi_to_cpu, -1); // ^^^
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7b65ac3f49e5a..888efad0361d3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1292,7 +1292,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 */
 	jtsq = READ_ONCE(jiffies_to_sched_qs);
 	ruqp = per_cpu_ptr(&rcu_data.rcu_urgent_qs, rdp->cpu);
-	rnhqp = &per_cpu(rcu_data.rcu_need_heavy_qs, rdp->cpu);
+	rnhqp = per_cpu_ptr(&rcu_data.rcu_need_heavy_qs, rdp->cpu);
 	if (!READ_ONCE(*rnhqp) &&
 	    (time_after(jiffies, rcu_state.gp_start + jtsq * 2) ||
 	     time_after(jiffies, rcu_state.jiffies_resched) ||
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index a8d0fcf0826f4..677ee3d8671bf 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -351,7 +351,7 @@ static void rcu_dump_cpu_stacks(void)
 
 static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 {
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
 	sprintf(cp, "last_accelerate: %04lx/%04lx dyntick_enabled: %d",
 		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
-- 
2.31.1.189.g2e36527f23

