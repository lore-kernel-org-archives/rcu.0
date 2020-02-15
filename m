Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAC5C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F51207FF
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581726580;
	bh=EJexEEpX+GQ8fYQ/Mz/rgmbw0ukwN9BOCgXLakmHZOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zb+RnEmvlRSn0Elm41SB/YngCLc85FDrKmmrNJ/kR5eJUJZYEm3kQWAOZmwLSuN1h
	 Kzed43JhyldJU0UC/USmhBwfco3SNvQBWkQh+GFPZKz4b/fEIMV14KnKAzFrNHoW2O
	 QlR5T4L2RD1/FnmU83AYSubX36tcGYZ8tIosqUvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgBOA3k (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:29:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbgBOA3k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:29:40 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A707F206D7;
        Sat, 15 Feb 2020 00:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726579;
        bh=EJexEEpX+GQ8fYQ/Mz/rgmbw0ukwN9BOCgXLakmHZOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgHIuvl0TVeJ66h6B8sC5QGWe4hy1JFmcByEx7BUKTJjk+71nbZFLzhZqnPbNQe+Y
         IjsY1cfYNnaZSOtSXFJhSxAYgpTeS4aj3+AZ4FNaphueOjbCfdmgGBYQA3xZZaJ5QE
         auNZmYqUwU+RmBX/o55LI5cBz+EQyjJP/6sJV6WQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/4] srcu: Fix __call_srcu()/process_srcu() datarace
Date:   Fri, 14 Feb 2020 16:29:29 -0800
Message-Id: <20200215002932.15976-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215002907.GA15895@paulmck-ThinkPad-P72>
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The srcu_node structure's ->srcu_gp_seq_needed_exp field is accessed
locklessly, so updates must use WRITE_ONCE().  This commit therefore
adds the needed WRITE_ONCE() invocations.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 657e6a7..b1edac9 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -550,7 +550,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 		snp->srcu_have_cbs[idx] = gpseq;
 		rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
 		if (ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, gpseq))
-			snp->srcu_gp_seq_needed_exp = gpseq;
+			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
 		mask = snp->srcu_data_have_cbs[idx];
 		snp->srcu_data_have_cbs[idx] = 0;
 		spin_unlock_irq_rcu_node(snp);
@@ -660,7 +660,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		if (snp == sdp->mynode)
 			snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
 		if (!do_norm && ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, s))
-			snp->srcu_gp_seq_needed_exp = s;
+			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
 		spin_unlock_irqrestore_rcu_node(snp, flags);
 	}
 
-- 
2.9.5

