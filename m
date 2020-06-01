Return-Path: <SRS0=avCC=7O=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A868C433DF
	for <rcu@archiver.kernel.org>; Mon,  1 Jun 2020 18:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 049BB206C3
	for <rcu@archiver.kernel.org>; Mon,  1 Jun 2020 18:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg3D+wHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgFASqh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgFASqP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 1 Jun 2020 14:46:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B74C03E96F;
        Mon,  1 Jun 2020 11:46:14 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v19so519000wmj.0;
        Mon, 01 Jun 2020 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hJp2ZjtOYUiPR+RzNNoJ5Ibq8AZ/CLg09w6+zqv3O4s=;
        b=Dg3D+wHocJvZsHivriwfg0RRFtY7NI35fI2KR5NyR9JxiOu0SNmfDKsUdwiEwqHbiX
         c9tDt8rNdM6LGJecc9awddOyKIATMHJg7GVQ3Pni/8/qoSHoNT5skwdpDVtDkQFGhqWq
         aVssyRd60yeWEMTXIaZ3zuMur0b8ztAbtYXg46N07/6jjrspfKmGx4uFxa3dZUS2Y8S1
         adBadO6+BDs+iNcDTUf7vIVnkfA+JQVUHdXpoWV/285PMRNbwSXf1YbAhuHqoJM/JfZx
         nNUF30k8jzLhDslPNAxDHAlXu2KPr2/uQjB4itgCsgY7+G0GWKk8Kt8OisFxx1qGNKBj
         gJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hJp2ZjtOYUiPR+RzNNoJ5Ibq8AZ/CLg09w6+zqv3O4s=;
        b=dbpzeZodnjY/FZELKAEQmnFObX1vNU4EQwmTIdH27NJQPn8m+flvE5NgXZOLTEK9yi
         hc390Du+ByLS8aJHQIyJMxdyNYjxDmMC+83Ig1YMNEEy3Qmf0VU/WWiFOUHjch2fqpbz
         XJt2yy/oF04nksjI/S3ItkPQZfm9fnjqFA43Rad7HjCzbclXxGO30uLEXuSBCNg5E0Gw
         9tXYhZ4MvD7QDV0f+DpYlznBd4bkIa5SoSZGcvydWaongnKS0KoUU3Z6Xk3zq2F/DObz
         4ybUDDxi7rFK14izKoAdIy8/uVB3Azvs7Cb0YZETpDfyavSSF0uvnLcK4jZ3+9Nr9ybA
         YObA==
X-Gm-Message-State: AOAM532DacG+0iS50bLrk4rlUARqjtqnJObbU1NoxAmHNG5HC5i8cf2d
        fc8Q51RNb9b6pQp/qrbMjsqZ/VQ6VQ/4
X-Google-Smtp-Source: ABdhPJy5Tf+kWCTOUilgIKj5/UCgCVwphb0tSKUwSZOuDsIQLq/Isy+3f1imXqdG/EdvMAnbpemHgw==
X-Received: by 2002:a1c:c908:: with SMTP id f8mr606567wmb.150.1591037173064;
        Mon, 01 Jun 2020 11:46:13 -0700 (PDT)
Received: from earth3.lan (host-92-15-172-76.as43234.net. [92.15.172.76])
        by smtp.googlemail.com with ESMTPSA id 23sm302229wmg.10.2020.06.01.11.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:46:12 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, paulmck@kernel.org, mingo@redhat.com,
        boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU))
Subject: [PATCH 3/5] rcu: replace + with |
Date:   Mon,  1 Jun 2020 19:45:50 +0100
Message-Id: <20200601184552.23128-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200601184552.23128-1-jbi.octave@gmail.com>
References: <20200601184552.23128-1-jbi.octave@gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Coccinelle reports warnings at rcu_preempt_ctxt_queue()

WARNING: sum of probable bitmasks, consider |

The root cause is the use of addition operator + for bitmask defined macros variables
Replacing + with | fixes the issue.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/rcu/tree_plugin.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 097635c41135..a20135ece06a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -153,9 +153,9 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	switch (blkd_state) {
 	case 0:
 	case                RCU_EXP_TASKS:
-	case                RCU_EXP_TASKS + RCU_GP_BLKD:
+	case                RCU_EXP_TASKS | RCU_GP_BLKD:
 	case RCU_GP_TASKS:
-	case RCU_GP_TASKS + RCU_EXP_TASKS:
+	case RCU_GP_TASKS | RCU_EXP_TASKS:
 
 		/*
 		 * Blocking neither GP, or first task blocking the normal
@@ -168,10 +168,10 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	case                                              RCU_EXP_BLKD:
 	case                                RCU_GP_BLKD:
-	case                                RCU_GP_BLKD + RCU_EXP_BLKD:
-	case RCU_GP_TASKS +                               RCU_EXP_BLKD:
-	case RCU_GP_TASKS +                 RCU_GP_BLKD + RCU_EXP_BLKD:
-	case RCU_GP_TASKS + RCU_EXP_TASKS + RCU_GP_BLKD + RCU_EXP_BLKD:
+	case                                RCU_GP_BLKD | RCU_EXP_BLKD:
+	case RCU_GP_TASKS |                               RCU_EXP_BLKD:
+	case RCU_GP_TASKS |                 RCU_GP_BLKD | RCU_EXP_BLKD:
+	case RCU_GP_TASKS | RCU_EXP_TASKS | RCU_GP_BLKD | RCU_EXP_BLKD:
 
 		/*
 		 * First task arriving that blocks either GP, or first task
@@ -184,9 +184,9 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 		list_add_tail(&t->rcu_node_entry, &rnp->blkd_tasks);
 		break;
 
-	case                RCU_EXP_TASKS +               RCU_EXP_BLKD:
-	case                RCU_EXP_TASKS + RCU_GP_BLKD + RCU_EXP_BLKD:
-	case RCU_GP_TASKS + RCU_EXP_TASKS +               RCU_EXP_BLKD:
+	case                RCU_EXP_TASKS |               RCU_EXP_BLKD:
+	case                RCU_EXP_TASKS | RCU_GP_BLKD | RCU_EXP_BLKD:
+	case RCU_GP_TASKS | RCU_EXP_TASKS |               RCU_EXP_BLKD:
 
 		/*
 		 * Second or subsequent task blocking the expedited GP.
@@ -197,8 +197,8 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 		list_add(&t->rcu_node_entry, rnp->exp_tasks);
 		break;
 
-	case RCU_GP_TASKS +                 RCU_GP_BLKD:
-	case RCU_GP_TASKS + RCU_EXP_TASKS + RCU_GP_BLKD:
+	case RCU_GP_TASKS |                 RCU_GP_BLKD:
+	case RCU_GP_TASKS | RCU_EXP_TASKS | RCU_GP_BLKD:
 
 		/*
 		 * Second or subsequent task blocking the normal GP.
-- 
2.18.2

