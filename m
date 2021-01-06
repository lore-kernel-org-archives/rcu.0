Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCD1C433E6
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F3E23134
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbhAFQ4R (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbhAFQ4N (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:56:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B0DD23131;
        Wed,  6 Jan 2021 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609952132;
        bh=ON+PXvvASQe6LEBvelS1pa78+3hw2E2zllQlQEFRths=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=STNGRKUEIv6p9eL/zifItAiECNI0qomEzXwlOsl/VMyyUHn59hQ/H2GDHNKu6Op41
         bPcAshWwL+ydr8s5DDFMPu9pvDHLkuWf+rWaZSogo88NBawyfTAP8pXTLyMHZIP6ez
         HXPez5IGnC56vAn3G93Ajnm12BrPH++VwDEzPi+KdPLCPF6hNCIiHZH/CevKMnrgh0
         fBDvEJPcbJ5yfI6vSlzd8G/e6qhSwi02tjXieszWkxGAb8ZpyY58+THD5Wnk0G4kyL
         BtZJbBZdXPUPKNrp0od54YJKuws8fU03lhTGgpTLAqoh/WeKEOGoL+LydVeybryDZK
         5jpyZE6ohcHdw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/10] srcu: Make Tiny SRCU use multi-bit grace-period counter
Date:   Wed,  6 Jan 2021 08:55:22 -0800
Message-Id: <20210106165531.20697-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106165511.GA20555@paulmck-ThinkPad-P72>
References: <20210106165511.GA20555@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

There is a need for a polling interface for SRCU grace periods.  This
polling needs to distinguish between an SRCU instance being idle on the
one hand or in the middle of a grace period on the other.  This commit
therefore converts the Tiny SRCU srcu_struct structure's srcu_idx from
a defacto boolean to a free-running counter, using the bottom bit to
indicate that a grace period is in progress.  The second-from-bottom
bit is thus used as the index returned by srcu_read_lock().

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
[ paulmck: Fix ->srcu_lock_nesting[] indexing per Neeraj Upadhyay. ]
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutiny.h | 6 +++---
 kernel/rcu/srcutiny.c    | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 5a5a194..b8b42d0 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -15,7 +15,7 @@
 
 struct srcu_struct {
 	short srcu_lock_nesting[2];	/* srcu_read_lock() nesting depth. */
-	short srcu_idx;			/* Current reader array element. */
+	unsigned short srcu_idx;	/* Current reader array element in bit 0x2. */
 	u8 srcu_gp_running;		/* GP workqueue running? */
 	u8 srcu_gp_waiting;		/* GP waiting for readers? */
 	struct swait_queue_head srcu_wq;
@@ -59,7 +59,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 {
 	int idx;
 
-	idx = READ_ONCE(ssp->srcu_idx);
+	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
 	return idx;
 }
@@ -80,7 +80,7 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
 {
 	int idx;
 
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
+	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
 	pr_alert("%s%s Tiny SRCU per-CPU(idx=%d): (%hd,%hd)\n",
 		 tt, tf, idx,
 		 READ_ONCE(ssp->srcu_lock_nesting[!idx]),
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 6208c1d..5598cf6 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -124,11 +124,12 @@ void srcu_drive_gp(struct work_struct *wp)
 	ssp->srcu_cb_head = NULL;
 	ssp->srcu_cb_tail = &ssp->srcu_cb_head;
 	local_irq_enable();
-	idx = ssp->srcu_idx;
-	WRITE_ONCE(ssp->srcu_idx, !ssp->srcu_idx);
+	idx = (ssp->srcu_idx & 0x2) / 2;
+	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
 	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
 	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
+	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 
 	/* Invoke the callbacks we removed above. */
 	while (lh) {
-- 
2.9.5

