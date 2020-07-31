Return-Path: <SRS0=65p9=BK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8E2C433E0
	for <rcu@archiver.kernel.org>; Fri, 31 Jul 2020 00:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC4F20656
	for <rcu@archiver.kernel.org>; Fri, 31 Jul 2020 00:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sKCldL2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbgGaAk1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbgGaAk0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jul 2020 20:40:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B075C061574
        for <rcu@vger.kernel.org>; Thu, 30 Jul 2020 17:40:26 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so27398487qkc.6
        for <rcu@vger.kernel.org>; Thu, 30 Jul 2020 17:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drjhJDJmobr6Cf0JOPuS6+m62B1+L9wyxUWY4u85BkE=;
        b=sKCldL2LIUXXUCo2BchwUNCP3/p0rPpgg0Vyj0YtDpGMcMBJ8QuD7CXv0o4bMd2Q24
         UlNIT0/4AWq13RTLlibWN4aahPbqYSdMMn1uPKbrgw+Hj2+Xg3hKO5Ua6dVZCGbs8/tf
         22fWQSacDv8lev3aXHsh+L7fzcZrL4ruRQKqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drjhJDJmobr6Cf0JOPuS6+m62B1+L9wyxUWY4u85BkE=;
        b=TcdEpzYyN6qgupwNYcRxwCaGzI4py7psZ9VsBIItRDOZ1CCI5qfnpYhKRPERYFDvwL
         kGeAsVH+IX9mx+fU6QA+5Mju2ndpsIWGXUCmEceahOpZcTlxMMHO2x/QOxCjq7hJMXa2
         P+LXw0XGImaTEji4HSQ/FtRgeOYVO7u/gJY+RwF68ufAbjTJJe477J79rJh9eIn5M3lf
         0Yc6CUFyuWw6n6+O86Zj2scr5X3xUd+jBx01XpX0xLtmRUV//A9QwnABNCteZa7AZOBl
         y5hmdUZPfIlg9wCbVN5rFsup1YaKvRja0m3rADfLucVVUupoIzCLSwW4l2sQJLeO9Dcn
         59BQ==
X-Gm-Message-State: AOAM533B87bFeLAUxCqiBE7Zu6oi/XO9u/uzJtu5+vmotRAUlgBHIQHT
        uxJ8cbNqwEBz0Mtjr97VQQ+Gag==
X-Google-Smtp-Source: ABdhPJyER0460EkAGWOhiAioQHBnnIeg6fCsz0Jhul1PWp+QtaAkAG0KX4F54vRd6hJx1x/At59BVA==
X-Received: by 2002:ae9:e407:: with SMTP id q7mr1750951qkc.451.1596156025395;
        Thu, 30 Jul 2020 17:40:25 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id c5sm3077320qtp.62.2020.07.30.17.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 17:40:24 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 2/3] rcu/tree: Clarify comments about FQS loop reporting quiescent states
Date:   Thu, 30 Jul 2020 20:40:11 -0400
Message-Id: <20200731004012.2324147-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731004012.2324147-1-joel@joelfernandes.org>
References: <20200731004012.2324147-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

At least since v4.19, the FQS loop no longer reports quiescent states
unless it is a dire situation where an offlined CPU failed to report
a quiescent state. Let us clarify the comment in rcu_gp_init() inorder
to keep the comment current.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6b6fc28bb670..a621932cc385 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1701,8 +1701,8 @@ static bool rcu_gp_init(void)
 
 	/*
 	 * Apply per-leaf buffered online and offline operations to the
-	 * rcu_node tree.  Note that this new grace period need not wait
-	 * for subsequent online CPUs, and that quiescent-state forcing
+	 * rcu_node tree.  Note that this new grace period need not wait for
+	 * subsequent online CPUs, and that RCU hooks in CPU offlining path
 	 * will handle subsequent offline CPUs.
 	 */
 	rcu_state.gp_state = RCU_GP_ONOFF;
-- 
2.28.0.163.g6104cc2f0b6-goog

