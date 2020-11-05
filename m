Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C543DC4742C
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7300720704
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604618715;
	bh=72KDMryKu1tt0mo33pA4uF6CDCAV0qmV/GAyH8faaTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iP2NdYhvShBvgCzHcQkvfrCZUOOzaKDCW296hqCNCfDi/N0vG5qI/LwjfHL91lLge
	 7TOf0TXQHY7/Q2tsTyvw+KbnInVhXC9UGk8c1yf/DIN6rNmYf3iKBCxeKtrntNNy2U
	 wfr4F+2GHopFyX/gp13poMDG4ISe5r+sD3vWL+GE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbgKEXZL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:25:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732623AbgKEXY6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:24:58 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76B0022210;
        Thu,  5 Nov 2020 23:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604618697;
        bh=72KDMryKu1tt0mo33pA4uF6CDCAV0qmV/GAyH8faaTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZAX5c/TADA20Ru8M+r/fl/BRSH0kvEEhPvoLSAA7CGd1advG6CrAWQPUUsIZ4QpO
         uv4AJ31vaTM8gQDBOPVpL6AglSUOrG9ZkMuBbGRPBd/jfhIywwq7nQjUhfrRSscubO
         VglPGRMRMoTNU9f1bTXl3ZuOO3ZaWd4sC1uI9o18=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Jakub Kicinski <kuba@kernel.org>, mingo@redhat.com,
        will@kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 6/7] lockdep: Provide dummy forward declaration of *_is_held() helpers
Date:   Thu,  5 Nov 2020 15:24:53 -0800
Message-Id: <20201105232454.19919-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105232345.GA19179@paulmck-ThinkPad-P72>
References: <20201105232345.GA19179@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

When CONFIG_LOCKDEP is not set, lock_is_held() and lockdep_is_held()
are not declared or defined.  This forces all callers to use #ifdefs
around these checks.

Recent RCU changes added a lot of lockdep_is_held() calls inside
rcu_dereference_protected().  This macro hides its argument on !LOCKDEP
builds, which can lead to false-positive unused-variable warnings.

This commit therefore provides forward declarations of lock_is_held()
and lockdep_is_held() but without defining them.  This way callers
(including those internal to RCU) can keep them visible to the compiler
on !LOCKDEP builds and instead depend on dead code elimination to remove
the references, which in turn prevents the linker from complaining about
the lack of the corresponding function definitions.

[ paulmck: Apply Peter Zijlstra feedback on "extern". ]
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
CC: peterz@infradead.org
CC: mingo@redhat.com
CC: will@kernel.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/lockdep.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index f559487..ccc3ce6 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -375,6 +375,12 @@ static inline void lockdep_unregister_key(struct lock_class_key *key)
 
 #define lockdep_depth(tsk)	(0)
 
+/*
+ * Dummy forward declarations, allow users to write less ifdef-y code
+ * and depend on dead code elimination.
+ */
+extern int lock_is_held(const void *);
+extern int lockdep_is_held(const void *);
 #define lockdep_is_held_type(l, r)		(1)
 
 #define lockdep_assert_held(l)			do { (void)(l); } while (0)
-- 
2.9.5

