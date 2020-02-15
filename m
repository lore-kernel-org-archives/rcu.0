Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074AAC35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A9E2081E
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581727326;
	bh=oxhlemADUmmo5kgPPEvVmlOBEd90mb83mFmMiSaZH0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yjA0wCrvyCNre0bAAzF2RaFnc47Or5w8M2UzKnd3vdpN81xBDJ5FQMp4wNIuLzcvi
	 osIyFhAvXUXTkEPSnZboG7f/DE5bSFbtxqoKKspPuZtd/55jhjIi5toBg86MZPe5U3
	 w4v0pHc6kdeIo5UQSAINgXLcI+Ile4TKGlyNquGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgBOAmF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAmE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:42:04 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6CFF24670;
        Sat, 15 Feb 2020 00:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727323;
        bh=oxhlemADUmmo5kgPPEvVmlOBEd90mb83mFmMiSaZH0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPfePmB7C6YI8DCfdfJuEx/OlYhM24aH0U02uLlfkOJfQ4cYObKKH9DEuvk9DzUXs
         r3xNxrJiBw6SkXsNZgQzVbU3d3vZzauzTfSnHvj9NDmy7RLE8a1MgqLDUe9BGPqD8g
         yzKmNAGsbhcHyo9GmOUV1hP+xOauudxjlJv8UVKg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 16/18] rcutorture: Make rcu_torture_barrier_cbs() post from corresponding CPU
Date:   Fri, 14 Feb 2020 16:41:23 -0800
Message-Id: <20200215004125.16953-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, rcu_torture_barrier_cbs() posts callbacks from whatever CPU
it is running on, which means that all these kthreads might well be
posting from the same CPU, which would drastically reduce the effectiveness
of this test.  This commit therefore uses IPIs to make the callbacks be
posted from the corresponding CPU (given by local variable myid).

If the IPI fails (which can happen if the target CPU is offline or does
not exist at all), the callback is posted on whatever CPU is currently
running.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7e01e9a..f82515c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2053,6 +2053,14 @@ static void rcu_torture_barrier_cbf(struct rcu_head *rcu)
 	atomic_inc(&barrier_cbs_invoked);
 }
 
+/* IPI handler to get callback posted on desired CPU, if online. */
+static void rcu_torture_barrier1cb(void *rcu_void)
+{
+	struct rcu_head *rhp = rcu_void;
+
+	cur_ops->call(rhp, rcu_torture_barrier_cbf);
+}
+
 /* kthread function to register callbacks used to test RCU barriers. */
 static int rcu_torture_barrier_cbs(void *arg)
 {
@@ -2076,9 +2084,11 @@ static int rcu_torture_barrier_cbs(void *arg)
 		 * The above smp_load_acquire() ensures barrier_phase load
 		 * is ordered before the following ->call().
 		 */
-		local_irq_disable(); /* Just to test no-irq call_rcu(). */
-		cur_ops->call(&rcu, rcu_torture_barrier_cbf);
-		local_irq_enable();
+		if (smp_call_function_single(myid, rcu_torture_barrier1cb,
+					     &rcu, 1)) {
+			// IPI failed, so use direct call from current CPU.
+			cur_ops->call(&rcu, rcu_torture_barrier_cbf);
+		}
 		if (atomic_dec_and_test(&barrier_cbs_count))
 			wake_up(&barrier_wq);
 	} while (!torture_must_stop());
-- 
2.9.5

