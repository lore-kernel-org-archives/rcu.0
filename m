Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68752C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1702076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974988;
	bh=hSbQDuf8vTlOMjI6rgIo5X6FzzD0x98qmRWJGH4U1u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CcCVXeKmjrz0NhjUN5Fkdv2ZXZ2UaH0UWiyMpiLXoqCHOFXhnKmk4K6ylzXQ5nvxL
	 QKx1k6Gi2O/Q8f2vRn4TVUk316mUqgCGv6SV9ycQxs2TQDWGFBJme1f1TQA+cS3qBS
	 N64CmIB/X2vg+8xnoHShFonUg5EHE+A8jbzQBl4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416652AbgDOSW6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:22:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441095AbgDOSTq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B38A821655;
        Wed, 15 Apr 2020 18:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974786;
        bh=hSbQDuf8vTlOMjI6rgIo5X6FzzD0x98qmRWJGH4U1u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GsqOUteXvHNROMWJanc5JFgaCij6vuSKRe4gKgkpgKpEms/SUzvMXaN6haw0yGNnY
         L27ht5flMiSTFA9ofiq822sjlEZ8+6aJsSGVJh0z+xyEpId8NEsgasunwtDOcfCU00
         zY+dFpfZmKom0zHm7F2cG0hH14+0fOKRqNKv4Ka8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 07/38] rcu: Reinstate synchronize_rcu_mult()
Date:   Wed, 15 Apr 2020 11:19:10 -0700
Message-Id: <20200415181941.11653-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

With the advent and likely usage of synchronize_rcu_rude(), there is
again a need to wait on multiple types of RCU grace periods, for
example, call_rcu_tasks() and call_rcu_tasks_rude().  This commit
therefore reinstates synchronize_rcu_mult() in order to allow these
grace periods to be straightforwardly waited on concurrently.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_wait.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index c0578ba..699b938 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -31,4 +31,23 @@ do {									\
 
 #define wait_rcu_gp(...) _wait_rcu_gp(false, __VA_ARGS__)
 
+/**
+ * synchronize_rcu_mult - Wait concurrently for multiple grace periods
+ * @...: List of call_rcu() functions for different grace periods to wait on
+ *
+ * This macro waits concurrently for multiple types of RCU grace periods.
+ * For example, synchronize_rcu_mult(call_rcu, call_rcu_tasks) would wait
+ * on concurrent RCU and RCU-tasks grace periods.  Waiting on a given SRCU
+ * domain requires you to write a wrapper function for that SRCU domain's
+ * call_srcu() function, with this wrapper supplying the pointer to the
+ * corresponding srcu_struct.
+ *
+ * The first argument tells Tiny RCU's _wait_rcu_gp() not to
+ * bother waiting for RCU.  The reason for this is because anywhere
+ * synchronize_rcu_mult() can be called is automatically already a full
+ * grace period.
+ */
+#define synchronize_rcu_mult(...) \
+	_wait_rcu_gp(IS_ENABLED(CONFIG_TINY_RCU), __VA_ARGS__)
+
 #endif /* _LINUX_SCHED_RCUPDATE_WAIT_H */
-- 
2.9.5

