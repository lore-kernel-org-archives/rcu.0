Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E83C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E17208E0
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586973404;
	bh=sUHNjfvt9VKaKe+T+Qzf/rdzfqwH/hiNXXR9xBQTwIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I6Nn0H9LnUx66W/LKKoLDIbGyi0+NbsCRQUUL7wiOgbannAt1nL075QylpbURFUqX
	 qwIYXvBfLw1bwm/wXG9z/ct6MX0f3GK0oLwTPl3R7cf9lUuVsFNOwKFx3csY+vSy1B
	 CZV+HzkIqf6tsX5aWoepXSTOjMDKQ1UHLlXM8MpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411518AbgDOR4i (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416570AbgDOR4S (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:56:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EA65208FE;
        Wed, 15 Apr 2020 17:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586973377;
        bh=sUHNjfvt9VKaKe+T+Qzf/rdzfqwH/hiNXXR9xBQTwIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQ+7QExFC2QhNHllaTm8WBY4TY046QPL8IRheK2dC8J5I9xnjORPOCgge2/mR83/L
         nQrWB2t7mtlHma2oDkRWxjAWkjbAGitB0jAs4TL6JRJvdrx/I4yrjRO4lA4IYbQ6wh
         P6CiRJc7qLa01ZGlmYFz3KufsegiOibrr65rCDGY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/6] rcu: Remove unused ->rcu_read_unlock_special.b.deferred_qs field
Date:   Wed, 15 Apr 2020 10:56:12 -0700
Message-Id: <20200415175614.10837-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415175543.GA10416@paulmck-ThinkPad-P72>
References: <20200415175543.GA10416@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The ->rcu_read_unlock_special.b.deferred_qs field is set to true in
rcu_read_unlock_special() but never set to false.  This is not
particularly useful, so this commit removes this field.

The only possible justification for this field is to ease debugging
of RCU deferred quiscent states, but the combination of the other
->rcu_read_unlock_special fields plus ->rcu_blocked_node and of course
->rcu_read_lock_nesting should cover debugging needs.  And if this last
proves incorrect, this patch can always be reverted, along with the
required setting of ->rcu_read_unlock_special.b.deferred_qs to false
in rcu_preempt_deferred_qs_irqrestore().

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/sched.h    | 2 +-
 kernel/rcu/tree_plugin.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5c..a4b727f5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -613,7 +613,7 @@ union rcu_special {
 		u8			blocked;
 		u8			need_qs;
 		u8			exp_hint; /* Hint for performance. */
-		u8			deferred_qs;
+		u8			pad; /* No garbage from compiler! */
 	} b; /* Bits. */
 	u32 s; /* Set of bits. */
 };
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 263c766..f31c599 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -634,7 +634,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
 		}
-		t->rcu_read_unlock_special.b.deferred_qs = true;
 		local_irq_restore(flags);
 		return;
 	}
-- 
2.9.5

