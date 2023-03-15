Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A387C7618A
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 19:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjCOTpJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjCOTom (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 15:44:42 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839CA6EA7
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 12:44:34 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t9so1349773qtx.8
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 12:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThU1XJtO1aLExHCNuOZtJgSY8HbvsH7BE8/boByrYno=;
        b=ag5X7WW6rfx5+7t1/eBsvLbRkB0y7Vb/fHHyhSxrRthTHHyDI7UjKzwlHHipX9cFtF
         Kka1hk8oKQDU69luA4VDWIBakHNnDiGrOW8TUl6Tbt1TJYOVUHXpB2E2TdW5uov5uc98
         nrZnUhAVT3BLC9hxVe2eeMxuyFGzvMETCnPyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThU1XJtO1aLExHCNuOZtJgSY8HbvsH7BE8/boByrYno=;
        b=RAe37afrysbkmNfVwzBAykJJxcEQ+XWYYGNpCZBD78ktWDayWlJN7ZF3OelkeJqO3A
         LclM8dthn6ZhWxq2XRsG4xgPa9uYJoWF3C82OJudLIFyIpW0orIO+1YPeL6FN3cevP50
         gDRAfrgdy0snw+PUUAqTfqpS5LlDPATp1ccAgrgiXDuhODXWql+7PfG8Fu+K8Blvw1PL
         +A0qtLfffSacyn7qqE92nEM89G2pzWPZMW/JALvFHTXwkIGbvYkfXj8svV5Y/RCyMCVh
         2bcC8zYCrauo5uL6Sq6okB+ox27643LHyZCsMY39fONBJ+tSAH/j+jKY1oG030fr/Ois
         qPDg==
X-Gm-Message-State: AO0yUKUV0CwicexTzy9dirv6uWm6kQb7BvvejsjNpEtKaifiKGlB4o0W
        gMOPcxCQNBxfYpgHGlO69n1FAw==
X-Google-Smtp-Source: AK7set9eHeATCHiRK0lgFQHYvnJM3VGTCsQZJTXU87E+PPKBbb5RQF3SZBaL8sWIrBT9HAPSQX7+ug==
X-Received: by 2002:a05:622a:1902:b0:3b6:93fe:443c with SMTP id w2-20020a05622a190200b003b693fe443cmr1567792qtc.32.1678909473597;
        Wed, 15 Mar 2023 12:44:33 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id c15-20020ac8660f000000b003b86b088755sm4346666qtp.15.2023.03.15.12.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:44:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
Subject: [PATCH 5/9] rcu: Remove never-set needwake assignment from rcu_report_qs_rdp()
Date:   Wed, 15 Mar 2023 19:43:45 +0000
Message-Id: <20230315194349.10798-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315194349.10798-1-joel@joelfernandes.org>
References: <20230315194349.10798-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

The rcu_accelerate_cbs() function is invoked by rcu_report_qs_rdp()
only if there is a grace period in progress that is still blocked
by at least one CPU on this rcu_node structure.  This means that
rcu_accelerate_cbs() should never return the value true, and thus that
this function should never set the needwake variable and in turn never
invoke rcu_gp_kthread_wake().

This commit therefore removes the needwake variable and the invocation
of rcu_gp_kthread_wake() in favor of a WARN_ON_ONCE() on the call to
rcu_accelerate_cbs().  The purpose of this new WARN_ON_ONCE() is to
detect situations where the system's opinion differs from ours.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e880c09ab59..e80e8f128c57 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1955,7 +1955,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
-	bool needwake = false;
 	bool needacc = false;
 	struct rcu_node *rnp;
 
@@ -1987,7 +1986,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		 * NOCB kthreads have their own way to deal with that...
 		 */
 		if (!rcu_rdp_is_offloaded(rdp)) {
-			needwake = rcu_accelerate_cbs(rnp, rdp);
+			/*
+			 * The current GP has not yet ended, so it
+			 * should not be possible for rcu_accelerate_cbs()
+			 * to return true.  So complain, but don't awaken.
+			 */
+			WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
 		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
 			/*
 			 * ...but NOCB kthreads may miss or delay callbacks acceleration
@@ -1999,8 +2003,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
-		if (needwake)
-			rcu_gp_kthread_wake();
 
 		if (needacc) {
 			rcu_nocb_lock_irqsave(rdp, flags);
-- 
2.40.0.rc1.284.g88254d51c5-goog

