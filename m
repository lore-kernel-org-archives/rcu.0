Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1D9C433F5
	for <rcu@archiver.kernel.org>; Tue,  4 Oct 2022 02:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJDCm1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJDCmZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:25 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03C12252F
        for <rcu@vger.kernel.org>; Mon,  3 Oct 2022 19:42:22 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i3so7701072qkl.3
        for <rcu@vger.kernel.org>; Mon, 03 Oct 2022 19:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=t1sRWI94JLeivOqGAiStsd4//GuQF4cUQN0qaKICshU=;
        b=iqQbkruq9wjebYNRA1dR63vknI3QnMkNuEJKP0+iDvd99mwpNkVDoysAgfLryrxIPs
         HQYdkRZ3MIg7mM88uTrOxe+0C6+Sj6zqmZCu3+wthlU6ZsMX8qJD14yoJD5s6aP3F+zM
         Iz8I7EXmVC+GUtSCjH7vfpWW6OSzUYE82Qg8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=t1sRWI94JLeivOqGAiStsd4//GuQF4cUQN0qaKICshU=;
        b=iJToOU/txGBG1ZGhNvUiOABa/DFViDDcZOVtasXbuG03lx7HQVvaH6WFE2qcQ0PM3/
         EDirEDqIQ3JM0BH1RkCJH6zZShYO66iUMUvWOZYjiS/5d+d4fj+jyrXcR4XRD+XYBy8M
         7jxYYKouzkfQ8bw1S/98NJKCBIztnaFc85JS1irhF84NdKGKu/jG8qIqX/1yfi0tZ7pA
         +2mNbQ0OHLGfYGY/FW8Z+nfxu9Cq59MrPvQq93zJ0IQxDju5I8ZvVDrQrBpFFuQgFZhC
         RRh1jw/ffRUD9TugO/Sw+UbuGuNwjCRUD6+xUtbmBhOQHNcWRJRbu8N+w0yz88LY578g
         IjLw==
X-Gm-Message-State: ACrzQf3bQ17ZH276zFr7+eu8BAsnBIHtu6MCYVJ3mtFeEJmgtauz3f/2
        Rp9+kyR8XCF9pHB1ntK60PBUoVrZumMpEw==
X-Google-Smtp-Source: AMsMyM4V6LncNW30RUbiw1BHR20EsVMJ79f3RBH9cUQMFtVsqc2NS4WeKjSizImin1bilW9NHY+W0A==
X-Received: by 2002:a05:620a:24d1:b0:6ce:bf4f:10d6 with SMTP id m17-20020a05620a24d100b006cebf4f10d6mr15759910qkn.335.1664851341766;
        Mon, 03 Oct 2022 19:42:21 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:21 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v7 03/11] rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
Date:   Tue,  4 Oct 2022 02:41:49 +0000
Message-Id: <20221004024157.2470238-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
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
index 56616bfbe156..dfa736da68ab 100644
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
2.38.0.rc1.362.ged0d419d3c-goog

