Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13A2C433FE
	for <rcu@archiver.kernel.org>; Tue, 11 Oct 2022 18:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJKSCl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiJKSCf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:35 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4816DF8B
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:20 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id bb5so3413380qtb.11
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plappG9k77YdtIag7crhL391J4nyLb085zqdNeDp75Y=;
        b=hdR5ajjxAIVul5tbbOlnvwSo9I3DYSzxoY1xcR4eb6jwny5twe0ISmcZU/UkvYSarB
         zPYDTi8JRgtYy+9hdDKCGqtfNv2u7kEvfMptXFynVnjFxBv+Gz4AZ4l3ZmHFHrujL9Sq
         CVXxzoJQg8eV2S7xKrypckY7eWh/m7S+d6s3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plappG9k77YdtIag7crhL391J4nyLb085zqdNeDp75Y=;
        b=GaO//q+a3N0rrCq+AWBgVpwfsZ2OdMATzw7M6893qusqBUOKL0gADyaWpWg0vS6fXx
         nNrSicviE4ih1mDPxtaWLDmVDaMP8H0JRIqFc/8oGNyHjbb+1buhzr42r4JRn6mq9ZoY
         Wp3n2LbXuc90myav7wueCX+WuEag7WW5PxwYw2tEnzWLoPqF0PV0VYfXHj9CKDQPa1V6
         aLm9VIyX4k/RSZtiYckaLOX2YW947Y/xhYAafIHDFB6upNI0dm7wKADsc2GDR3qGHLA8
         5WEDYH6JDSwjmoLkdfLZ4zopV/P0XqvmSclv3e39mD42MSAt6ZksmwvanN4VXwJXoPc5
         ObzA==
X-Gm-Message-State: ACrzQf2WRT9PG5un7wGk/KKKlZWgVQj+9SItiQ0RG5CWwhwDOtZLCXLD
        YUDRdKmN+V+f6RuFG0E5Z0zvrUgvkNyQmw==
X-Google-Smtp-Source: AMsMyM7BnUkoissgJv6orkY/9/7uhJIZVeiqkHXGayZHB3g/p1Eam6+J5dDPIVOEfZpATHpYmeoJPA==
X-Received: by 2002:ac8:5e4a:0:b0:35c:d4ee:532f with SMTP id i10-20020ac85e4a000000b0035cd4ee532fmr20343714qtx.18.1665511329346;
        Tue, 11 Oct 2022 11:02:09 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:08 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com, Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v8 01/13] rcu: Fix missing nocb gp wake on rcu_barrier()
Date:   Tue, 11 Oct 2022 18:01:30 +0000
Message-Id: <20221011180142.2742289-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Upon entraining a callback to a NOCB CPU, no further wake up is
issued on the corresponding nocb_gp kthread. As a result, the callback
and all the subsequent ones on that CPU may be ignored, at least until
an RCU_NOCB_WAKE_FORCE timer is ever armed or another NOCB CPU belonging
to the same group enqueues a callback on an empty queue.

Here is a possible bad scenario:

1) CPU 0 is NOCB unlike all other CPUs.
2) CPU 0 queues a callback
2) The grace period related to that callback elapses
3) The callback is moved to the done list (but is not invoked yet),
   there are no more pending callbacks for CPU 0
4) CPU 1 calls rcu_barrier() and sends an IPI to CPU 0
5) CPU 0 entrains the callback but doesn't wake up nocb_gp
6) CPU 1 blocks forever, unless CPU 0 ever queues enough further
   callbacks to arm an RCU_NOCB_WAKE_FORCE timer.

Make sure the necessary wake up is produced whenever necessary.

This is also required to make sure lazy callbacks in future patches
don't end up making rcu_barrier() wait for multiple seconds.

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c      | 6 ++++++
 kernel/rcu/tree.h      | 1 +
 kernel/rcu/tree_nocb.h | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5ec97e3f7468..dc1c502216c7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3894,6 +3894,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 {
 	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
 	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
+	bool wake_nocb = false;
+	bool was_alldone = false;
 
 	lockdep_assert_held(&rcu_state.barrier_lock);
 	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
@@ -3902,6 +3904,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
+	was_alldone = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
@@ -3909,7 +3912,10 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 		debug_rcu_head_unqueue(&rdp->barrier_head);
 		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
 	}
+	wake_nocb = was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
 	rcu_nocb_unlock(rdp);
+	if (wake_nocb)
+		wake_nocb_gp(rdp, false);
 	smp_store_release(&rdp->barrier_seq_snap, gseq);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d4a97e40ea9c..925dd98f8b23 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -439,6 +439,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
+static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j);
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f77a6d7e1356..094fd454b6c3 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1558,6 +1558,11 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
+static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+{
+	return false;
+}
+
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j)
 {
-- 
2.38.0.rc1.362.ged0d419d3c-goog

