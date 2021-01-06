Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0948FC433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD87C23132
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbhAFQ4N (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:56:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbhAFQ4N (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:56:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B65EA23135;
        Wed,  6 Jan 2021 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609952132;
        bh=PeB1pkBYXrt2BgHO69ieVhW/gbMfxEe9BOFQd3aOSf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxwQnTpOoqOi+WpN+5c3Hde9pSlBYTUTvVdwlCAOO+nK2QslpzrJLjNNsVZDBjiUz
         KH+G68cRwVxfyDlCTTkayCQwvltzKRrqNMil9CJe0wTkaNvRS1tsgyQhNpzX4uqQoe
         RikxN6WLvJ9tBK4mhIJ8zpFmxo2FV+LULgE0x1VOEzVqH3bNtDcZD6ED/uZLkHAqvx
         jzeu3y0g8PmMe+46xeWRTMPtdNLuon+PqwmD1vPEU6UJ4KUuBzwsxl3DmUX1GyIAwo
         XAW1cWMqjC53k+qrRiCZlvcB9+jTgsl/nyDOwLiJ1Clvo0RJsbiCwpJph7cNqOVzJL
         tLp21GyfNgC1w==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/10] srcu: Provide internal interface to start a Tiny SRCU grace period
Date:   Wed,  6 Jan 2021 08:55:23 -0800
Message-Id: <20210106165531.20697-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106165511.GA20555@paulmck-ThinkPad-P72>
References: <20210106165511.GA20555@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

There is a need for a polling interface for SRCU grace periods.
This polling needs to initiate an SRCU grace period without
having to queue (and manage) a callback.  This commit therefore
splits the Tiny SRCU call_srcu() function into callback-queuing and
start-grace-period portions, with the latter in a new function named
srcu_gp_start_if_needed().

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutiny.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 5598cf6..3bac1db 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -152,6 +152,16 @@ void srcu_drive_gp(struct work_struct *wp)
 }
 EXPORT_SYMBOL_GPL(srcu_drive_gp);
 
+static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
+{
+	if (!READ_ONCE(ssp->srcu_gp_running)) {
+		if (likely(srcu_init_done))
+			schedule_work(&ssp->srcu_work);
+		else if (list_empty(&ssp->srcu_work.entry))
+			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
+	}
+}
+
 /*
  * Enqueue an SRCU callback on the specified srcu_struct structure,
  * initiating grace-period processing if it is not already running.
@@ -167,12 +177,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	*ssp->srcu_cb_tail = rhp;
 	ssp->srcu_cb_tail = &rhp->next;
 	local_irq_restore(flags);
-	if (!READ_ONCE(ssp->srcu_gp_running)) {
-		if (likely(srcu_init_done))
-			schedule_work(&ssp->srcu_work);
-		else if (list_empty(&ssp->srcu_work.entry))
-			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
-	}
+	srcu_gp_start_if_needed(ssp);
 }
 EXPORT_SYMBOL_GPL(call_srcu);
 
-- 
2.9.5

