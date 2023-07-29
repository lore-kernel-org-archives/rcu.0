Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE38C001DF
	for <rcu@archiver.kernel.org>; Sat, 29 Jul 2023 14:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjG2O2F (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 29 Jul 2023 10:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjG2O2C (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 29 Jul 2023 10:28:02 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1F32686
        for <rcu@vger.kernel.org>; Sat, 29 Jul 2023 07:28:01 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-348dfefd1a4so14299165ab.1
        for <rcu@vger.kernel.org>; Sat, 29 Jul 2023 07:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690640880; x=1691245680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV1mKGTo1HAZ4CYm++JYZHEnfRnVP5qO40eCYy1XceI=;
        b=S7Lx25DBRYt0tjnRLA8AhoSntDcL9y6o1ekAFGNTXrA+Mf8j2i9gpElBv/rLiVGE+U
         zWI6Fe+2ZdWxeJeiB7VSx4TdmVubfqmVlZqJL446+4d/C1CxnIvrOkDkUtLpNqsM04VS
         C7GzcZjEatmp3kLZRPfZhDK8JUcMEnuxVNDUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690640880; x=1691245680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV1mKGTo1HAZ4CYm++JYZHEnfRnVP5qO40eCYy1XceI=;
        b=RrsKkiIk6u0CbGcyEgegprDBSgOAXGH0KKHGVhTK+Jl9gEw34ePpsgdOYIVhDBNAEK
         7Sj0yocwDLq5NhIE0vmvqmvH4CP1QxY+L4vrD2EOw+no/df7HsTx6YeaWCGavzkI5Pmj
         FUOBfb8z24uk6tFWKoWS2QU+IDzjUZmgeeeZvZuVUigEsXWwpySyVV3MUAxyDpE6OL2S
         y8Sj/ZoX2l+p9m/Q2hEaZUOXN+RxD3HZO/kpkPUjKH51k1t4f0lmLvz1w5AOLSS+5u+H
         fUxWZwH8pSxZgvT6rfR4JrpRqDlqHK/DDFAUXejP+/xH+BJLXqywuL8/NiYSmfRbmXyB
         upIQ==
X-Gm-Message-State: ABy/qLYBWMRIyb5z82pl+jpt0Qpu/YxMKqw1Q6CpDj7O8ZNfz780jkqT
        02gqjLcINjWCtT6rl8morfZmQQ==
X-Google-Smtp-Source: APBJJlGsHpfOeIUPjpE/9g13bl9f1kfstD5OXUxuEldNz7Kdcq/S8OFlgCGXB+OArZ2BznN4qPVMaQ==
X-Received: by 2002:a92:c566:0:b0:345:df7f:efc4 with SMTP id b6-20020a92c566000000b00345df7fefc4mr3289147ilj.27.1690640880705;
        Sat, 29 Jul 2023 07:28:00 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id q9-20020a0566380ec900b0042b35c7b8c5sm1855362jas.61.2023.07.29.07.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 07:28:00 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 5/5] rcu/tree: Remove superfluous return from void call_rcu* functions
Date:   Sat, 29 Jul 2023 14:27:36 +0000
Message-ID: <20230729142738.222208-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230729142738.222208-1-joel@joelfernandes.org>
References: <20230729142738.222208-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The return keyword is not needed here.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..7c79480bfaa0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2713,7 +2713,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
  */
 void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
 {
-	return __call_rcu_common(head, func, false);
+	__call_rcu_common(head, func, false);
 }
 EXPORT_SYMBOL_GPL(call_rcu_hurry);
 #endif
@@ -2764,7 +2764,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	return __call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
+	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
-- 
2.41.0.487.g6d72f3e995-goog

