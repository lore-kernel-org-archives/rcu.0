Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ECEC433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C6A61942
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhEKXIz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKXIz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:08:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 338B361626;
        Tue, 11 May 2021 23:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774468;
        bh=E0gmLJvxyAnv6Mg9LTaM5QzAhb1R3n/zNTGJbx6TRvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PXw65D/7XS3zkNQBjf7fWOqK0J/xafe9jSy9kTVENtwCG1nSHSsJEsDYf+hRjeO5H
         Klnr/a7J+2TWfWSxzoroaswTxaxj9Wz5LkYLkn88/pmRJ3NxL9cIpcQq+FrybWajY6
         idMk/gEPy5reF8N+uNGkC/74nv3x3rgJFzxCettVfCFTurRiGaJwkZTtgkORc//1cR
         7KIlC2ziET3mfCdqa/9dRQfMvIfODmn9IHPpYXFUnQ7FjSf1vbHCvNFBAd3ItWrbXV
         0DavslqyafzjdDg8nq/Ym+wvZI6KrcZonfz9frzeIXJKYc8Q/dRTh9oVrEnTkGhGti
         2IWHzKaJ5yfTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DEB065C09EF; Tue, 11 May 2021 16:07:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/6] srcu: Unconditionally embed struct lockdep_map
Date:   Tue, 11 May 2021 16:07:42 -0700
Message-Id: <20210511230745.2894650-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Since struct lockdep_map has zero size when CONFIG_DEBUG_LOCK_ALLOC=n,
this commit removes the #ifdef from the srcu_struct structure's ->dep_map.
This change will simplify further manipulations of this field.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 9cfcc8a756ae..cb1f4351e8ba 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -82,9 +82,7 @@ struct srcu_struct {
 						/*  callback for the barrier */
 						/*  operation. */
 	struct delayed_work work;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
-#endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 };
 
 /* Values for state variable (bottom bits of ->srcu_gp_seq). */
-- 
2.31.1.189.g2e36527f23

