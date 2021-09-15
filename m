Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006D3C433FE
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20F461247
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhIOXfK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232982AbhIOXfF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:35:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73A6461251;
        Wed, 15 Sep 2021 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748825;
        bh=r+HrfQUOvVIdcRSQOW//s01d+ygSv0BpWvlQuKsQZ2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvvGz6DqhY1rVxhrygPbdXnNjd3wXD5UYBC/fux+SAu42FqCtxN+ufyTtKIT/+CDI
         ZgO+6QQvvcKExu3Mil+eRu1XAf64CUz1WJ6bnj4VDCv9KMM3eiAjaqFw81XesX+Oay
         yWoeghod6t0WeHkNqA1SnIw8wweY1w6fwfyStipIIcJ3QrN2E5UnGdAJ0DQjF73eLt
         4x+cC6Yz832xwOJlXmwYevyR0mFJ46lPUuw9U8ro93e3mgwXf11a7icJYyk/zYVlGk
         MLK30sIYTa9qLzjXdciix6rILSypwE43RxX+v+WtCa9+LTPpf7A0ClOydc35l4/gTK
         ncHIApWBm/Xkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D47A35C0F2F; Wed, 15 Sep 2021 16:33:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Waiman Long <longman@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 14/14] rcu: Avoid unneeded function call in rcu_read_unlock()
Date:   Wed, 15 Sep 2021 16:33:43 -0700
Message-Id: <20210915233343.3906738-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Waiman Long <longman@redhat.com>

Since commit aa40c138cc8f3 ("rcu: Report QS for outermost PREEMPT=n
rcu_read_unlock() for strict GPs") the function rcu_read_unlock_strict()
is invoked by the inlined rcu_read_unlock() function.  However,
rcu_read_unlock_strict() is an empty function in production kernels,
which are built with CONFIG_RCU_STRICT_GRACE_PERIOD=n.

There is a mention of rcu_read_unlock_strict() in the BPF verifier,
but this is in a deny-list, meaning that BPF does not care whether
rcu_read_unlock_strict() is ever called.

This commit therefore provides a slight performance improvement
by hoisting the check of CONFIG_RCU_STRICT_GRACE_PERIOD from
rcu_read_unlock_strict() into rcu_read_unlock(), thus avoiding the
pointless call to an empty function.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 3 ++-
 kernel/rcu/tree_plugin.h | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 434d12fe2d4f..5e0beb5c5659 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -71,7 +71,8 @@ static inline void __rcu_read_lock(void)
 static inline void __rcu_read_unlock(void)
 {
 	preempt_enable();
-	rcu_read_unlock_strict();
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		rcu_read_unlock_strict();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d070059163d7..1a6fdb03d0a5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -814,8 +814,7 @@ void rcu_read_unlock_strict(void)
 {
 	struct rcu_data *rdp;
 
-	if (!IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
-	   irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
 		return;
 	rdp = this_cpu_ptr(&rcu_data);
 	rcu_report_qs_rdp(rdp);
-- 
2.31.1.189.g2e36527f23

