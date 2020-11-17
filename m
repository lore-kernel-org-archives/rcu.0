Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05EDC64E7B
	for <rcu@archiver.kernel.org>; Tue, 17 Nov 2020 00:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C167C2467F
	for <rcu@archiver.kernel.org>; Tue, 17 Nov 2020 00:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1btShJJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgKQAkz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgKQAkz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Nov 2020 19:40:55 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C633A2467C;
        Tue, 17 Nov 2020 00:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605573654;
        bh=GeQfY/vDr3vesCD54jxeYoWSz1TIHVZ8Gt83T3OCOS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1btShJJi/YQv7fivePpJyBPmxtO5P8to2N0d1+9mZRJLQ0GntgDtwgHXXm0+cjRDC
         swlYMm/65faEeWMf61s5FfBEcTiSmiqjX1+DZsa4bECJ0NRVaC8RO9Z4NGHEhOin8a
         TBJQNae1SGAvZNWlXMgyy3BR2ui/DfmBVdHqauKM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC tip/core/rcu 1/5] srcu: Make Tiny SRCU use multi-bit grace-period counter
Date:   Mon, 16 Nov 2020 16:40:48 -0800
Message-Id: <20201117004052.14758-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201117004017.GA7444@paulmck-ThinkPad-P72>
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutiny.h | 4 ++--
 kernel/rcu/srcutiny.c    | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 5a5a194..fed4a2d 100644
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
+	idx = (READ_ONCE(ssp->srcu_idx) & 0x2) / 2;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
 	return idx;
 }
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

