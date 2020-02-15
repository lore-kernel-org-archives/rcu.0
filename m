Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEA1C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113EA207FF
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581725949;
	bh=TBTCEPrwPzdXs9MSdBvieX7bU/zW2vmrQGdVui/stFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OQUTMfhwyFXnzSJLBB13V3KB80V+9C7r7d0r3xBI/Km4aQU2wVyYN1hgx+EAMWrBC
	 7VV3T64qmlpI1M8eXmiKSG8Qvq5lmt2njYfM6hS5SpLS+ZP+JMDRdkW0geK38lTf6M
	 fmtJeCg6E8JeIzj8mQtyvOXJPxmIW9lB4GOivFSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgBOATI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:19:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOATI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:19:08 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCCC524654;
        Sat, 15 Feb 2020 00:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725948;
        bh=TBTCEPrwPzdXs9MSdBvieX7bU/zW2vmrQGdVui/stFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VmdkbrpjPQZczvpNcjpGVTWCb2PrN3a/Cm0aJ63MY68QQqD+UMrbccyZZF9ssOEgj
         1NI8DEjDZXYPbt4j2Uf6bG7AtCftbcRpIvvqxlEOHuXiXrmb/qv313TTSWFkazmSpK
         CqYF0C/SzDVNmBMO3z58sZ+lDFPwBeL4rNXP3X4c=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 5/5] rcu: Update __call_rcu() comments
Date:   Fri, 14 Feb 2020 16:18:45 -0800
Message-Id: <20200215001845.15432-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215001816.GA15284@paulmck-ThinkPad-P72>
References: <20200215001816.GA15284@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The __call_rcu() function's header comment refers to a cpu argument
that no longer exists, and the comment of the return path from
rcu_nocb_try_bypass() ignores the non-no-CBs CPU case.  This comit
therefore update both comments.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 48fba22..0a9de9f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2642,12 +2642,7 @@ static void check_cb_ovld(struct rcu_data *rdp)
 	raw_spin_unlock_rcu_node(rnp);
 }
 
-/*
- * Helper function for call_rcu() and friends.  The cpu argument will
- * normally be -1, indicating "currently running CPU".  It may specify
- * a CPU only if that CPU is a no-CBs CPU.  Currently, only rcu_barrier()
- * is expected to specify a CPU.
- */
+/* Helper function for call_rcu() and friends.  */
 static void
 __call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
@@ -2688,7 +2683,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 	check_cb_ovld(rdp);
 	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
 		return; // Enqueued onto ->nocb_bypass, so just leave.
-	/* If we get here, rcu_nocb_try_bypass() acquired ->nocb_lock. */
+	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
 	if (__is_kfree_rcu_offset((unsigned long)func))
 		trace_rcu_kfree_callback(rcu_state.name, head,
-- 
2.9.5

