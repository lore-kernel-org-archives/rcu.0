Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B24C4742C
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35852071A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604618711;
	bh=LIiilgoGSYaATGF2lDwSnd1M+ECqzED51HPEBNoU9kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wRDhE0lANjwSTr9jVCgSa9jTjC9+Zp3cFAEgl/AR3tA8KC+UPMqe8H7hk7xVV5UTy
	 gYwW/IkVxS3aMPR6r93ZQeCG2xhjkOxP2Dgp4X5fg4QKEj7v6M4+bgLUmpdQYefQkx
	 2WorfDwoAUa/pGTuCqmHR577g68qK/qwzakFB+oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbgKEXZD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:25:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEXY6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:24:58 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7BCB2222B;
        Thu,  5 Nov 2020 23:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604618698;
        bh=LIiilgoGSYaATGF2lDwSnd1M+ECqzED51HPEBNoU9kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DonUjdDrX3u6slJyLkQrXAyXjn20F5PB9MWBz9zE0jywQ5pDetsKkTQ72zRKAwnXp
         7swVxhlp16vdomVhtFNKGVXyvCiuYeHFgyExApa/4kXH6fWYzxhkjPzJRpWcTNf1pY
         +VNGb5lHu1whFG2U2hdyTZoX2rwZz+FCr+P8zBfI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Jakub Kicinski <kuba@kernel.org>, paulmck@kernel.org
Subject: [PATCH tip/core/rcu 7/7] rcu: Prevent RCU_LOCKDEP_WARN() from swallowing the condition
Date:   Thu,  5 Nov 2020 15:24:54 -0800
Message-Id: <20201105232454.19919-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105232345.GA19179@paulmck-ThinkPad-P72>
References: <20201105232345.GA19179@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

We run into a unused variable warning in bridge code when variable is
only used inside the condition of rcu_dereference_protected().

 #define mlock_dereference(X, br) \
	rcu_dereference_protected(X, lockdep_is_held(&br->multicast_lock))

Since on builds with CONFIG_PROVE_RCU=n rcu_dereference_protected()
compiles to nothing the compiler doesn't see the variable use.

This commit therefore prevents this warning by adding the condition as
dead code.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
CC: paulmck@kernel.org
CC: josh@joshtriplett.org
CC: rostedt@goodmis.org
CC: mathieu.desnoyers@efficios.com
CC: joel@joelfernandes.org
CC: jiangshanlai@gmail.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f9533bb..de08264 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -328,7 +328,7 @@ static inline void rcu_preempt_sleep_check(void) { }
 
 #else /* #ifdef CONFIG_PROVE_RCU */
 
-#define RCU_LOCKDEP_WARN(c, s) do { } while (0)
+#define RCU_LOCKDEP_WARN(c, s) do { } while (0 && (c))
 #define rcu_sleep_check() do { } while (0)
 
 #endif /* #else #ifdef CONFIG_PROVE_RCU */
-- 
2.9.5

