Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE67C4332F
	for <rcu@archiver.kernel.org>; Sun, 16 Oct 2022 16:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJPQXn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 Oct 2022 12:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJPQXm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:42 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363833D58C
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:37 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s3so6487465qtn.12
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZziBLLlKHVzOSjc34J63Rv49GuOQiJ4SzWGeYcNVKSE=;
        b=o6NYymtWFFRcLKV9JGD5gsps1y6NUcfW3Qzq/Gg3Yy9WqLVAYmQJiUhHhH5CPhF1zT
         jD1drN+HTN1kjbs9R/euhIkLJH4lJwAj2TE2k+jfgEO5Ur65OpUgLvUANNWx1opLesWd
         Wld0TrKwgvAVFfLEx4dsPDGhvzbHH2nbeQwaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZziBLLlKHVzOSjc34J63Rv49GuOQiJ4SzWGeYcNVKSE=;
        b=dKo1szrdlCn2TfBO3qtWvEddsJ4TuS078uCs7SwDDFARFZFQuSFFFXUoEX4JjSM1NI
         VoJlsLP5MOGgTbRZh93Ig6aC0xLzQ7bPKkuJm8KRfuVsAxepXpB1PrLzgpDg25x32k+d
         sykC3TWPjGWF9Ei6J0UPdj/R52TH8XKG8mOlyh+BrMeZfaKGTW8lejFKEl8YSayDTSgg
         vQuAsRBa994TPHSWBu3QNid7aIlDo5u6meWALjeaQRbqi5FfJXgz2GioqbrMAaw3A5lP
         x9S3ktl1elUWdm1hHjKlkGtBRR1qTbdwVaHC7+YKhHrsKSJDeloUJYsdb6+MswBVmvOQ
         1+Pw==
X-Gm-Message-State: ACrzQf2ZSpI/hn8do6edErFTxxLtbwprFY9WFb0NjWqPBpYjsF4rkZvt
        DfQAl+3fSLegZu4JVJVoHpyWpc4zx977+g==
X-Google-Smtp-Source: AMsMyM6BpO5nJQWqvmtG5gYtmpUCnZfEfU4OBQ3KZPiWvRfXnvnofryXy47gwmof+ExXw5hThAdqhQ==
X-Received: by 2002:a05:622a:283:b0:39c:d772:7e02 with SMTP id z3-20020a05622a028300b0039cd7727e02mr5663660qtw.369.1665937416460;
        Sun, 16 Oct 2022 09:23:36 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v9 03/13] rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
Date:   Sun, 16 Oct 2022 16:22:55 +0000
Message-Id: <20221016162305.2489629-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This consolidates the code a bit and makes it cleaner. Functionally it
is the same.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index ab9ce0ebec23..717c0591c037 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -327,10 +327,11 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
  *
  * Note that this function always returns true if rhp is NULL.
  */
-static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
+static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_in,
 				     unsigned long j, bool lazy)
 {
 	struct rcu_cblist rcl;
+	struct rcu_head *rhp = rhp_in;
 
 	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
 	rcu_lockdep_assert_cblist_protected(rdp);
@@ -345,16 +346,16 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 
 	/*
 	 * If the new CB requested was a lazy one, queue it onto the main
-	 * ->cblist so we can take advantage of a sooner grade period.
+	 * ->cblist so that we can take advantage of the grace-period that will
+	 * happen regardless. But queue it onto the bypass list first so that
+	 * the lazy CB is ordered with the existing CBs in the bypass list.
 	 */
 	if (lazy && rhp) {
-		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
-		rcu_cblist_enqueue(&rcl, rhp);
-		WRITE_ONCE(rdp->lazy_len, 0);
-	} else {
-		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
-		WRITE_ONCE(rdp->lazy_len, 0);
+		rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
+		rhp = NULL;
 	}
+	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
+	WRITE_ONCE(rdp->lazy_len, 0);
 
 	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
 	WRITE_ONCE(rdp->nocb_bypass_first, j);
-- 
2.38.0.413.g74048e4d9e-goog

