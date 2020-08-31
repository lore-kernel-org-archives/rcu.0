Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F88C433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18AB2083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598896978;
	bh=OmfxcQkO9tPXDAZoIKbop8+V1AlPI5ns3hO/MeI9xj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lOEaqR27AAr/fPNeu9CeXWc7j0pICSyg1M5EerWJHpGGIqtfQ8FlZEm86E64MrVFH
	 PKGcUT+H0zu3N7Y5nVk7BjupSIoj1G3rW8hB3vd6SyUZwVCXc+8L/cLDxbCmstCdbv
	 ZER3GMnWZeKth2kCDLv/aN6fUs16WjtZwjcZqNig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgHaSC4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbgHaSB0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A104F21655;
        Mon, 31 Aug 2020 18:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896884;
        bh=OmfxcQkO9tPXDAZoIKbop8+V1AlPI5ns3hO/MeI9xj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zyPH6g52qSxkUx762cYe0ColQOdT6q4zZ5yBzIJPZRfPooWPDnW1xOAAI0pb3r6HK
         53SsZ8DETvQS1IM/+NVg9UbBQtpA9D85y3hUJ2jTPWTn6/7HwdzbA3DdPjhH6sGFoW
         8/W0v++d1fEcNCphQDwvpp8qouBuE7pSSEGxq7wU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Tobias Klauser <tklauser@distanz.ch>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/24] rcu: Fix kerneldoc comments in rcupdate.h
Date:   Mon, 31 Aug 2020 11:01:07 -0700
Message-Id: <20200831180116.32690-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Tobias Klauser <tklauser@distanz.ch>

This commit fixes the kerneldoc comments for rcu_read_unlock_bh(),
rcu_read_unlock_sched() and rcu_head_after_call_rcu() so they e.g. get
properly linked in the API documentation. Also add parenthesis after
function names to match the notation used in other kerneldoc comments in
the same file.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d15d46d..b47d6b6 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -709,8 +709,8 @@ static inline void rcu_read_lock_bh(void)
 			 "rcu_read_lock_bh() used illegally while idle");
 }
 
-/*
- * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
+/**
+ * rcu_read_unlock_bh() - marks the end of a softirq-only RCU critical section
  *
  * See rcu_read_lock_bh() for more information.
  */
@@ -751,10 +751,10 @@ static inline notrace void rcu_read_lock_sched_notrace(void)
 	__acquire(RCU_SCHED);
 }
 
-/*
- * rcu_read_unlock_sched - marks the end of a RCU-classic critical section
+/**
+ * rcu_read_unlock_sched() - marks the end of a RCU-classic critical section
  *
- * See rcu_read_lock_sched for more information.
+ * See rcu_read_lock_sched() for more information.
  */
 static inline void rcu_read_unlock_sched(void)
 {
@@ -945,7 +945,7 @@ static inline void rcu_head_init(struct rcu_head *rhp)
 }
 
 /**
- * rcu_head_after_call_rcu - Has this rcu_head been passed to call_rcu()?
+ * rcu_head_after_call_rcu() - Has this rcu_head been passed to call_rcu()?
  * @rhp: The rcu_head structure to test.
  * @f: The function passed to call_rcu() along with @rhp.
  *
-- 
2.9.5

