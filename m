Return-Path: <SRS0=1SSE=BR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC847C433E3
	for <rcu@archiver.kernel.org>; Fri,  7 Aug 2020 17:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95061221E5
	for <rcu@archiver.kernel.org>; Fri,  7 Aug 2020 17:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Q/KGFW4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgHGRI1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgHGRHb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 7 Aug 2020 13:07:31 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E32C061A2B
        for <rcu@vger.kernel.org>; Fri,  7 Aug 2020 10:07:31 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s16so1785119qtn.7
        for <rcu@vger.kernel.org>; Fri, 07 Aug 2020 10:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DWbloqsrP0AQsrj6SmmxzbX/ZWsrIvuOIBVWCascTtc=;
        b=Q/KGFW4zhhUvta6vR2CwSlNmcirLLQgN1UHKs1PAFMVRyM5AmvjqxtwQuc7zhSovGO
         ly9olFSHeHS0YAa+ZOraTOjnV5sE16p3X03nyz5uOiIugMnTcjuCsf9fkLhGjwlnByxU
         WJ4Zmlf/GRbSE4zEj22vV00mE/cMixdWHS0Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWbloqsrP0AQsrj6SmmxzbX/ZWsrIvuOIBVWCascTtc=;
        b=l39c+k7IEbmu0ZjeL6semgrEuh1dvK4BCvScq+LFBDE+uWJiSm1aPYkT1jnrOTUg+v
         EyBYWxo7egZTAG4NYFA9zP64xM3XkKvq59JsFlpXHKq4PWpGQzVGjqLqM55Q4fVfNwWF
         bzAanXQaC6yj6+Xq6B5b+ZQ39TVWp8DGMTsKF1UFP7eZwRJ+2wipd7Kmi9ngKdZVV1+9
         fKfNAp63KcyX24rV6+iYWkrdtgnUTSEL3KH+1puagm+gqICYWYYgMyp/g20SmPqFGxJr
         9F7Q/LmiC8NWOHGGbhNqX+eox5SOZEUgI6Xn6JK4ywt3LmgIn8u36daktwZsRxTvD7YG
         MnmA==
X-Gm-Message-State: AOAM532Pd9wTSJCC2nQgj7gBc/8Cn6z0pJ/Yezbt4txv5P/CVpJdJwxB
        6mAt+CEdJUKiLEqAZ4gQEwLJ3w==
X-Google-Smtp-Source: ABdhPJx3f6sCntEP3jmyqzNa+3yifVW0H++FgQSlZMWDjMxxvQUVR4wb+sfKmy+A4/cj+TLqN0mOkQ==
X-Received: by 2002:ac8:45c3:: with SMTP id e3mr5903192qto.149.1596820050230;
        Fri, 07 Aug 2020 10:07:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id w18sm8559905qtk.1.2020.08.07.10.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 10:07:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        neeraju@codeaurora.org, "Paul E. McKenney" <paulmck@kernel.org>,
        peterz@infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, vineethrp@gmail.com
Subject: [PATCH v4 2/5] rcu/tree: Clarify comments about FQS loop reporting quiescent states
Date:   Fri,  7 Aug 2020 13:07:19 -0400
Message-Id: <20200807170722.2897328-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
In-Reply-To: <20200807170722.2897328-1-joel@joelfernandes.org>
References: <20200807170722.2897328-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

At least since v4.19, the FQS loop no longer reports quiescent states
for offline CPUs unless it is an emergency.

This commit therefore fixes the comment in rcu_gp_init() to match the
current code.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a49fa3b60faa..2fb66cdbfa25 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1701,9 +1701,11 @@ static bool rcu_gp_init(void)
 
 	/*
 	 * Apply per-leaf buffered online and offline operations to the
-	 * rcu_node tree.  Note that this new grace period need not wait
-	 * for subsequent online CPUs, and that quiescent-state forcing
-	 * will handle subsequent offline CPUs.
+	 * rcu_node tree. Note that this new grace period need not wait for
+	 * subsequent online CPUs, and that RCU hooks in the CPU offlining
+	 * path, when combined with checks in this function, will handle CPUs
+	 * that are currently going offline or that go offline later. Refer to
+	 * RCU's Requirements documentation about hotplug requirements as well.
 	 */
 	rcu_state.gp_state = RCU_GP_ONOFF;
 	rcu_for_each_leaf_node(rnp) {
-- 
2.28.0.236.gb10cc79966-goog

