Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEABC43219
	for <rcu@archiver.kernel.org>; Sun, 16 Oct 2022 16:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJPQXk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 Oct 2022 12:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJPQXj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:39 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7C436DEA
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:36 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o2so5389930qkk.10
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MoWqjHuV8nLLRCYHvb4Cnre7Xc0pX7FZvINFrXyaV4=;
        b=yj/YGf+8EA2ZpPX+5IFaseWn+7sFZFipCIU5JHL04HFdaMTYUJQQ4hCZrnCkhzCiXI
         WKJ5akQdzdCq4T8fLwF/E0+LjQ0eHnJ/viRtqu1ppvmLMWELcLSrbwMal8aPxNIfjDwO
         zk+vuG4c0Kv+ddJgdg6JRrPhXXitTZs9uaV9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MoWqjHuV8nLLRCYHvb4Cnre7Xc0pX7FZvINFrXyaV4=;
        b=5MaC46IWB588dizvaNDKHtcV8qjUSckb12PQi0PRhE6xi8UfMFeQ6IwaQv+cgWUuhJ
         CO9k8HYKpjNCpUOg1GLQGkUo+Wr5xk0nxjABaVS3PtGNPXOnNi4kGYDq/B0VeX1rEURS
         a98mQDcdfctEt5YD0oscLvyUtoYMUslA4e0v9b0fBf8sR4LK8j3NTkfZ2fpi5B7KAbim
         eCXIJ1QA/nLKS9Zp7VdjUdySb0y4UXawMEgxot4JOH+KTOVeG2llSJ/nXJ19uvGika+a
         Lb/2uDkMDReagmEXHr9e8BXymBCu5TlZ2VhlFXfDptnYsHiNNiNX6ekkF3oJrNyAagya
         OXhA==
X-Gm-Message-State: ACrzQf0PUt5anhLfX3yy7f+vKJ6oJL8eY5WV/KgZB2puf43L7uQgAOdW
        2WSb8lb3FhaU/NIsP+UTBDaqnxYGnLYhBQ==
X-Google-Smtp-Source: AMsMyM5LVAgHRQhBp2mTxAgaL/r8ze/khuNxMlzBf2KD69NQKJo3Wn9YtxLIi1gcPtC0ajxBKTzRRQ==
X-Received: by 2002:a05:620a:1729:b0:6ee:cf01:6810 with SMTP id az41-20020a05620a172900b006eecf016810mr4905001qkb.555.1665937415383;
        Sun, 16 Oct 2022 09:23:35 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:35 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v9 01/13] rcu: Fix missing nocb gp wake on rcu_barrier()
Date:   Sun, 16 Oct 2022 16:22:53 +0000
Message-Id: <20221016162305.2489629-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

In preparation of RCU lazy changes, wake up the RCU nocb gp thread if
needed after an entrain. Otherwise, the RCU barrier callback can wait in
the queue for several seconds before the lazy callbacks in front of it
are serviced.

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Change-Id: I830269cd41b18862a1a58b26ce3292c6c4457bc7
---
 kernel/rcu/tree.c      | 11 +++++++++++
 kernel/rcu/tree.h      |  1 +
 kernel/rcu/tree_nocb.h |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5ec97e3f7468..67a1ae5151f5 100644
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
@@ -3902,7 +3904,14 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
+	/*
+	 * Flush bypass and wakeup rcuog if we add callbacks to an empty regular
+	 * queue. This way we don't wait for bypass timer that can reach seconds
+	 * if it's fully lazy.
+	 */
+	was_alldone = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
+	wake_nocb = was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
@@ -3910,6 +3919,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
 	}
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
2.38.0.413.g74048e4d9e-goog

