Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB31DC7EE22
	for <rcu@archiver.kernel.org>; Thu,  4 May 2023 21:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjEDVBe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 May 2023 17:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjEDVBS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 4 May 2023 17:01:18 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E8313C10;
        Thu,  4 May 2023 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683230732;
        bh=D/NfiDdblr1nISgkSaCGt1uzTz4bykGLb/1bVKOEMww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N0jaaMPNt4wgec6S+UXVf+cRhRvvT7e7d14PG5ZkCYpwfQLOYyu0n1nDOZ8A6bhye
         ut3K1V5mWn/K8ziXFRU222jQPbdpUQti5+xKhlOuewRc8MWNrqDlJsRURvhWRSVT0t
         JMUnH3+xGstJ6bHBVPMTU8yrcg37TV3CFoIK0/1pOgHNMP8MxJbMQvtiqUiUAX5vjB
         Frip0V51Cjqsk/ZCtfgWKK0tjDkrEEN7Uj22K+8O2hqobuOOuAEzgaeKRgXU1cIAou
         ze0+ixYVLRr909UzlBGQf6Z4zQu4zA8gsElrCqoImMeu58ksiVa6D5N6HXYmnUdgvj
         sxdzMviQL1VRw==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QC4Ym3GV2z122c;
        Thu,  4 May 2023 16:05:32 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
Subject: [RFC PATCH 03/13] rculist_nulls.h: Add parentheses around macro pointer parameter use
Date:   Thu,  4 May 2023 16:05:17 -0400
Message-Id: <20230504200527.1935944-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add parentheses around use of macro argument "tpos" in those patterns to
ensure operator precedence behaves as expected:

- typeof(*tpos)

The typeof(*tpos) lack of parentheses around "tpos" is not an issue per se
in the specific macros modified here because "tpos" is used as an lvalue,
which should prevent use of any operator causing issue. Still add the
extra parentheses for consistency with other list iteration code across
the kernel tree.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang1.zhang@intel.com>
Cc: rcu@vger.kernel.org
---
 include/linux/rculist_nulls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index ba4c00dd8005..6e56dd2daecf 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -168,7 +168,7 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
 	for (({barrier();}),							\
 	     pos = rcu_dereference_raw(hlist_nulls_first_rcu(head));		\
 		(!is_a_nulls(pos)) &&						\
-		({ tpos = hlist_nulls_entry(pos, typeof(*tpos), member); 1; }); \
+		({ tpos = hlist_nulls_entry(pos, typeof(*(tpos)), member); 1; }); \
 		pos = rcu_dereference_raw(hlist_nulls_next_rcu(pos)))
 
 /**
@@ -183,7 +183,7 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
 	for (({barrier();}),							\
 	     pos = rcu_dereference_raw(hlist_nulls_first_rcu(head));		\
 		(!is_a_nulls(pos)) &&						\
-		({ tpos = hlist_nulls_entry(pos, typeof(*tpos), member);	\
+		({ tpos = hlist_nulls_entry(pos, typeof(*(tpos)), member);	\
 		   pos = rcu_dereference_raw(hlist_nulls_next_rcu(pos)); 1; });)
 #endif
 #endif
-- 
2.25.1

