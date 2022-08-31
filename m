Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1C3ECAAD1
	for <rcu@archiver.kernel.org>; Wed, 31 Aug 2022 18:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiHaSYL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiHaSXz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 31 Aug 2022 14:23:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6565EFD10;
        Wed, 31 Aug 2022 11:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 328FFB82278;
        Wed, 31 Aug 2022 18:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75AFC43470;
        Wed, 31 Aug 2022 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969677;
        bh=+SH5kjmaANmozmFWfCMjL/kkQVhc+n9ENVTV79RkIn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RauIdH5VDxQB5a+js2cQ3dxl17gmiMmajkECJE6zSvXUgXi31KNdbgdputSc1MGze
         +3LHQtRIGb4dsxkyHIK+Z9V7J+TBM2aEMr9a6ZAkcP2cm2I3c54k0REYUEl3bERslX
         lQJigrerx0aeq4GsSGWEiZhjQkQITRxH6vd6c5ZSp1DIOBjLLOW/GgPgooqJCBHfBW
         pIL2MPbeOthOya8+efpFNDc3jDwe66a0p74QJsU8uzFgGHeXvD81gbRkW1ColoWCkO
         PXqK9BtChJM6VeAHPfRgyIX1MAV6HFzJOrLwpY/7etFB+pnf3cBr3mkCcAnB4YSZlm
         lfr7KIdfx5q0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7AB125C0513; Wed, 31 Aug 2022 11:14:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/4] srcu: Make Tiny SRCU use full-sized grace-period counters
Date:   Wed, 31 Aug 2022 11:14:35 -0700
Message-Id: <20220831181435.2695936-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181349.GA2695341@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181349.GA2695341@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit makes Tiny SRCU use full-sized grace-period counters to
further avoid counter-wrap issues when using polled grace-period APIs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutiny.h |  6 +++---
 kernel/rcu/srcutiny.c    | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 4fcec6f5af908..5aa5e0faf6a12 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -15,10 +15,10 @@
 
 struct srcu_struct {
 	short srcu_lock_nesting[2];	/* srcu_read_lock() nesting depth. */
-	unsigned short srcu_idx;	/* Current reader array element in bit 0x2. */
-	unsigned short srcu_idx_max;	/* Furthest future srcu_idx request. */
 	u8 srcu_gp_running;		/* GP workqueue running? */
 	u8 srcu_gp_waiting;		/* GP waiting for readers? */
+	unsigned long srcu_idx;		/* Current reader array element in bit 0x2. */
+	unsigned long srcu_idx_max;	/* Furthest future srcu_idx request. */
 	struct swait_queue_head srcu_wq;
 					/* Last srcu_read_unlock() wakes GP. */
 	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
@@ -82,7 +82,7 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
 	int idx;
 
 	idx = ((data_race(READ_ONCE(ssp->srcu_idx)) + 1) & 0x2) >> 1;
-	pr_alert("%s%s Tiny SRCU per-CPU(idx=%d): (%hd,%hd) gp: %hu->%hu\n",
+	pr_alert("%s%s Tiny SRCU per-CPU(idx=%d): (%hd,%hd) gp: %lu->%lu\n",
 		 tt, tf, idx,
 		 data_race(READ_ONCE(ssp->srcu_lock_nesting[!idx])),
 		 data_race(READ_ONCE(ssp->srcu_lock_nesting[idx])),
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index a2af24f214676..33adafdad2613 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -117,7 +117,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	struct srcu_struct *ssp;
 
 	ssp = container_of(wp, struct srcu_struct, srcu_work);
-	if (ssp->srcu_gp_running || USHORT_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
+	if (ssp->srcu_gp_running || ULONG_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
 		return; /* Already running or nothing to do. */
 
 	/* Remove recently arrived callbacks and wait for readers. */
@@ -150,17 +150,17 @@ void srcu_drive_gp(struct work_struct *wp)
 	 * straighten that out.
 	 */
 	WRITE_ONCE(ssp->srcu_gp_running, false);
-	if (USHORT_CMP_LT(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
+	if (ULONG_CMP_LT(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
 		schedule_work(&ssp->srcu_work);
 }
 EXPORT_SYMBOL_GPL(srcu_drive_gp);
 
 static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
-	unsigned short cookie;
+	unsigned long cookie;
 
 	cookie = get_state_synchronize_srcu(ssp);
-	if (USHORT_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie))
+	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie))
 		return;
 	WRITE_ONCE(ssp->srcu_idx_max, cookie);
 	if (!READ_ONCE(ssp->srcu_gp_running)) {
@@ -215,7 +215,7 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
 	barrier();
 	ret = (READ_ONCE(ssp->srcu_idx) + 3) & ~0x1;
 	barrier();
-	return ret & USHRT_MAX;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
 
@@ -240,10 +240,10 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
  */
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
 {
-	unsigned short cur_s = READ_ONCE(ssp->srcu_idx);
+	unsigned long cur_s = READ_ONCE(ssp->srcu_idx);
 
 	barrier();
-	return USHORT_CMP_GE(cur_s, cookie) || USHORT_CMP_LT(cur_s, cookie - 3);
+	return ULONG_CMP_GE(cur_s, cookie) || ULONG_CMP_LT(cur_s, cookie - 3);
 }
 EXPORT_SYMBOL_GPL(poll_state_synchronize_srcu);
 
-- 
2.31.1.189.g2e36527f23

