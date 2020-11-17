Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04828C63777
	for <rcu@archiver.kernel.org>; Tue, 17 Nov 2020 00:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A460224682
	for <rcu@archiver.kernel.org>; Tue, 17 Nov 2020 00:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmV1vbZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgKQAkz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728291AbgKQAkz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Nov 2020 19:40:55 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1EA924680;
        Tue, 17 Nov 2020 00:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605573655;
        bh=TpfrMNuka0Ma4oI14AErodgrJFZR96XY5w5QYyLPWBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmV1vbZk83uDja9SgbeeeI1Ect9tFQa602WP6FlXAU6nuvVuxZptKGZdS3uqhZj76
         9i2tQgw0I3vGR+HmVGHV3Tibof2gRShAq7mmfAccqKQABAeSt1emr0+kw1lA6Kpq74
         c35pGZepxeuhrnPYLL8dN514RX886lbgPpxOF9AM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC tip/core/rcu 2/5] srcu: Provide internal interface to start a Tiny SRCU grace period
Date:   Mon, 16 Nov 2020 16:40:49 -0800
Message-Id: <20201117004052.14758-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201117004017.GA7444@paulmck-ThinkPad-P72>
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
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

