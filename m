Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56287C4742C
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E9420704
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604618735;
	bh=29l9hUljo6O7lK5hq63n532gdHL+nNGyTy22VDpKtDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jAjac2bbdAQ8kL1kv2rh7+IRfaAKv7HSQtBpXdwXd7Aac8t7qoneO/33ByfQdCRXA
	 YmqwY52p12P218alCDf4p8dzy+qG8eJkDwrVkX1yWxIrgelqE59KggqBwdHqNq13kw
	 jd1FhL9gcOiYhvq91OJaw3CPaWU4Vabx4uqvBv/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732675AbgKEXZW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:25:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732577AbgKEXY5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:24:57 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2BE9221FA;
        Thu,  5 Nov 2020 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604618697;
        bh=29l9hUljo6O7lK5hq63n532gdHL+nNGyTy22VDpKtDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wipJrudIMAkSSxEeO6VkLTMDluiRpG5AitvnyhWMYz92pI5naEzTUauvIGurMKGd4
         4RrFwP580+tJQk/9Gg1UtKZD+N13hKQnj1W4F+TEsE+3skrdIm2xGcVurlwEBhJtKg
         jEgkG3p7beOuUw+98DrJSfan0O4P4kODM2TP3+/4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Jakub Kicinski <kuba@kernel.org>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/7] net: sched: Remove broken definitions and un-hide for !LOCKDEP
Date:   Thu,  5 Nov 2020 15:24:51 -0800
Message-Id: <20201105232454.19919-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105232345.GA19179@paulmck-ThinkPad-P72>
References: <20201105232345.GA19179@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

Currently, variables used only within lockdep expressions are flagged as
unused, requiring that these variables' declarations be decorated with
either #ifdef or __maybe_unused.  This results in ugly code.  This commit
therefore causes the full definitions of the lockdep_tcf_chain_is_locked()
and lockdep_tcf_proto_is_locked() functions to be visible even when
lockdep is not enabled, thus removing the need for the previous empty
functions that were provided in non-lockdep kernels.  This approach
further relies on dead-code elimination to remove any references to
functions or variables that are not available in non-lockdep kernels.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/net/sch_generic.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d8fd867..749db62 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -435,7 +435,6 @@ struct tcf_block {
 	struct mutex proto_destroy_lock; /* Lock for proto_destroy hashtable. */
 };
 
-#ifdef CONFIG_PROVE_LOCKING
 static inline bool lockdep_tcf_chain_is_locked(struct tcf_chain *chain)
 {
 	return lockdep_is_held(&chain->filter_chain_lock);
@@ -445,17 +444,6 @@ static inline bool lockdep_tcf_proto_is_locked(struct tcf_proto *tp)
 {
 	return lockdep_is_held(&tp->lock);
 }
-#else
-static inline bool lockdep_tcf_chain_is_locked(struct tcf_block *chain)
-{
-	return true;
-}
-
-static inline bool lockdep_tcf_proto_is_locked(struct tcf_proto *tp)
-{
-	return true;
-}
-#endif /* #ifdef CONFIG_PROVE_LOCKING */
 
 #define tcf_chain_dereference(p, chain)					\
 	rcu_dereference_protected(p, lockdep_tcf_chain_is_locked(chain))
-- 
2.9.5

