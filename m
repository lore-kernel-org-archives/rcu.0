Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BCCC35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07FB206B6
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724578;
	bh=7CNvii9CnoOApIZ3tmG1GiK1b7u2u/vdaOrCJaOUH0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=alD5rI17NTX+P82z72yY9qfL471VE7e/IdjcY1r7LQh5onshW9y2rHaYISPBHmym2
	 GnFSICX7/WaoVWnXS056U35KSfUqIzJNpzitkhZefJIL4CiQSqSwd7EWrcZuBp/5/b
	 SP3xR4KLQlQZwtLFc5bH870MA70jCTUeJZcBjaaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgBNX4S (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:56:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbgBNX4S (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:56:18 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A70217F4;
        Fri, 14 Feb 2020 23:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724577;
        bh=7CNvii9CnoOApIZ3tmG1GiK1b7u2u/vdaOrCJaOUH0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M34dHv1Zd/268Ul+GZqPtZR52ytj7JztwlSxiYUUBl6//8EuaCTbtxJX6KqstIkOw
         S48mWMucx9/92ZGFIF4PUNflzSH/8cDB2yNb8IwWH5esC1b1MOzwSnFONkoSDbSUcn
         Gas6RFJsr7SbgGb+21UVnyw1kmuHwhHpIWwt4W1w=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/30] rcu: Warn on for_each_leaf_node_cpu_mask() from non-leaf
Date:   Fri, 14 Feb 2020 15:55:39 -0800
Message-Id: <20200214235607.13749-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The for_each_leaf_node_cpu_mask() and for_each_leaf_node_possible_cpu()
macros must be invoked only on leaf rcu_node structures.  Failing to
abide by this restriction can result in infinite loops on systems with
more than 64 CPUs (or for more than 32 CPUs on 32-bit systems).  This
commit therefore adds WARN_ON_ONCE() calls to make misuse of these two
macros easier to debug.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 05f936e..f6ce173 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -325,7 +325,8 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
  * Iterate over all possible CPUs in a leaf RCU node.
  */
 #define for_each_leaf_node_possible_cpu(rnp, cpu) \
-	for ((cpu) = cpumask_next((rnp)->grplo - 1, cpu_possible_mask); \
+	for (WARN_ON_ONCE(!rcu_is_leaf_node(rnp)), \
+	     (cpu) = cpumask_next((rnp)->grplo - 1, cpu_possible_mask); \
 	     (cpu) <= rnp->grphi; \
 	     (cpu) = cpumask_next((cpu), cpu_possible_mask))
 
@@ -335,7 +336,8 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
 #define rcu_find_next_bit(rnp, cpu, mask) \
 	((rnp)->grplo + find_next_bit(&(mask), BITS_PER_LONG, (cpu)))
 #define for_each_leaf_node_cpu_mask(rnp, cpu, mask) \
-	for ((cpu) = rcu_find_next_bit((rnp), 0, (mask)); \
+	for (WARN_ON_ONCE(!rcu_is_leaf_node(rnp)), \
+	     (cpu) = rcu_find_next_bit((rnp), 0, (mask)); \
 	     (cpu) <= rnp->grphi; \
 	     (cpu) = rcu_find_next_bit((rnp), (cpu) + 1 - (rnp->grplo), (mask)))
 
-- 
2.9.5

