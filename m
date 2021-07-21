Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E9EC63793
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523A361244
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbhGUTky (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233186AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6448A61263;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=eUi+q1NWFL0Tq7O9JeG4neU/i2jqbGZaXS8sKdAZc90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HoXT+VFXdf1G/k+VUY9k4gjh3n716dNBAHz8R6Yq6SZMxd0CPGfZdb3dlmDE4W1E6
         xtNgOQERlXlufPDRKbVMadzbYx9QCklVDhvjIgC9j5h73oSGR4p6WfwpgvgRAT0lk/
         n2iiiWuXD25YqOJvVpD22LxxoyFeU4BnZhxYL89g5m5qb2vGpmcyKQWh4GXlNlNkq8
         7/EM0KvoLxhY99NNVQwA6bbtB12wZr85evv8/VHoFkqWJOJloq4vQrfXb5xlMJWFro
         0XdyA/EQGyPgt6izjcLRWfVX2MArOLKgykf7AD3vDJJA3Fb56cHFEQqzuaFkRiszGW
         2sU4cJLgRF2cw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1A73E5C0BF4; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/18] rcu: Mark accesses to ->rcu_read_lock_nesting
Date:   Wed, 21 Jul 2021 13:21:13 -0700
Message-Id: <20210721202127.2129660-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

KCSAN flags accesses to ->rcu_read_lock_nesting as data races, but
in the past, the overhead of marked accesses was excessive.  However,
that was long ago, and much has changed since then, both in terms of
hardware and of compilers.  Here is data taken on an eight-core laptop
using Intel(R) Core(TM) i9-10885H CPU @ 2.40GHz with a kernel built
using gcc version 9.3.0, with all data in nanoseconds.

Unmarked accesses (status quo), measured by three refscale runs:

	Minimum reader duration:  3.286  2.851  3.395
	Median reader duration:   3.698  3.531  3.4695
	Maximum reader duration:  4.481  5.215  5.157

Marked accesses, also measured by three refscale runs:

	Minimum reader duration:  3.501  3.677  3.580
	Median reader duration:   4.053  3.723  3.895
	Maximum reader duration:  7.307  4.999  5.511

This focused microbenhmark shows only sub-nanosecond differences which
are unlikely to be visible at the system level.  This commit therefore
marks data-racing accesses to ->rcu_read_lock_nesting.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 2 +-
 kernel/rcu/tree_plugin.h | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d9680b798b211..cfeb43bfc719e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -53,7 +53,7 @@ void __rcu_read_unlock(void);
  * nesting depth, but makes sense only if CONFIG_PREEMPT_RCU -- in other
  * types of kernel builds, the rcu_read_lock() nesting depth is unknowable.
  */
-#define rcu_preempt_depth() (current->rcu_read_lock_nesting)
+#define rcu_preempt_depth() READ_ONCE(current->rcu_read_lock_nesting)
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index de1dc3bb7f701..83a702a4e2963 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -405,17 +405,20 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 
 static void rcu_preempt_read_enter(void)
 {
-	current->rcu_read_lock_nesting++;
+	WRITE_ONCE(current->rcu_read_lock_nesting, READ_ONCE(current->rcu_read_lock_nesting) + 1);
 }
 
 static int rcu_preempt_read_exit(void)
 {
-	return --current->rcu_read_lock_nesting;
+	int ret = READ_ONCE(current->rcu_read_lock_nesting) - 1;
+
+	WRITE_ONCE(current->rcu_read_lock_nesting, ret);
+	return ret;
 }
 
 static void rcu_preempt_depth_set(int val)
 {
-	current->rcu_read_lock_nesting = val;
+	WRITE_ONCE(current->rcu_read_lock_nesting, val);
 }
 
 /*
-- 
2.31.1.189.g2e36527f23

