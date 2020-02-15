Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8A7C3F68F
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0542083B
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581726592;
	bh=XdMJOms8RbFN2DS7z+iHuxwTOky+fnSYiXiwhbUyJSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NqDOu4gb5OeYKVejrf43QbDqh0ZmGgmBC+/bYqSV0XhVc0K5DN/vnx7XehPzLH1xi
	 Shcvo52oWH9TNcnuzDqewt4MUxq+wxoUD0gk9hgvl2MTmrGZTnZ18el/M6k338E113
	 ixUSjZF9TLomxa480RgQbNodw6nOcYK8pd5XaT1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgBOA3v (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:29:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbgBOA3v (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:29:51 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65FBD207FF;
        Sat, 15 Feb 2020 00:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726590;
        bh=XdMJOms8RbFN2DS7z+iHuxwTOky+fnSYiXiwhbUyJSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBc9XNaWmAo84NIbK+z57M9ndzCt02Wr0Tq8K5wUjl1p0dCbCSvp5PPa/7vja6j5b
         LA5gIhZnfuijWpaXS1RfjkBZ2DAmfJ5lSZE51/3orm15eh++gR4Vbo8KHhk4ltgjn0
         YhfbGVG5X+T28xIjTXMOaZet9iq5nquRbvrMI8JU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/4] srcu: Add READ_ONCE() to srcu_struct ->srcu_gp_seq load
Date:   Fri, 14 Feb 2020 16:29:32 -0800
Message-Id: <20200215002932.15976-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215002907.GA15895@paulmck-ThinkPad-P72>
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The load of the srcu_struct structure's ->srcu_gp_seq field in
srcu_funnel_gp_start() is lockless, so this commit adds the requisite
READ_ONCE().

This data race was reported by KCSAN.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 119a373..90ab475 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -678,7 +678,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 
 	/* If grace period not already done and none in progress, start it. */
 	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
-	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
+	    rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_IDLE) {
 		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
 		srcu_gp_start(ssp);
 		if (likely(srcu_init_done))
-- 
2.9.5

