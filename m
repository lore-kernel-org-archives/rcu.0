Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC599C35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4BB222C4
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724638;
	bh=/CZ6brnT2OOOiZ54KLSqe6C3gg9LefVC3f18wiX3jVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EmVrdvMegP9gFwkW5guRYi0/DBNfn4+KxUazWFTuq2gwxYon26lchQgvLC9RT0b7Q
	 hHHeB3cMfPlaSaoNWQGjspMcmyWNO7GOmeKJEaKZYAKu60RREMOIzVaMoQYmOt7Vgm
	 YQj6tNhqcAmktK7HilxcLvj/QRZQKSsjFh6WIvU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgBNX5S (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:57:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgBNX5R (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:17 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 321892081E;
        Fri, 14 Feb 2020 23:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724636;
        bh=/CZ6brnT2OOOiZ54KLSqe6C3gg9LefVC3f18wiX3jVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJwiL7dlF/ZIcOiJkKqclOfHkrOEW+ySNVvzk7WA8hr6qSlJghUSaon2yZ2WAH5Kr
         9c4GFRTbj7LruKv/0p81Yqkf8S5w9ZL133mjATpvnX2TAocXSfFDtelBhLYrMysJNS
         f5k8XJtbnOsQaxRd5Cqqw2P4JSAYcKq035meqDqo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/30] rcu: Remove dead code from rcu_segcblist_insert_pend_cbs()
Date:   Fri, 14 Feb 2020 15:55:55 -0800
Message-Id: <20200214235607.13749-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_segcblist_insert_pend_cbs() function currently (partially)
initializes the rcu_cblist that it pulls callbacks from.  However, all
the resulting stores are dead because all callers pass in the address of
an on-stack cblist that is not used afterwards.  This commit therefore
removes this pointless initialization.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 426a472..9a0f661 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -381,8 +381,6 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 		return; /* Nothing to do. */
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
-	rclp->head = NULL;
-	rclp->tail = &rclp->head;
 }
 
 /*
-- 
2.9.5

