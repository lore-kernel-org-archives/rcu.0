Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BE6C433EF
	for <rcu@archiver.kernel.org>; Wed, 22 Jun 2022 22:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359796AbiFVWvx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Jun 2022 18:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347009AbiFVWvt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Jun 2022 18:51:49 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8DC41302
        for <rcu@vger.kernel.org>; Wed, 22 Jun 2022 15:51:48 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id o43so27421109qvo.4
        for <rcu@vger.kernel.org>; Wed, 22 Jun 2022 15:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oulAy7NlmqgAX/AG2BIWch0UpN6lWOBq/Xx+LqGxyiU=;
        b=Zd4Acj6vFejlAuM4LGySk0mn5EpwW09kqb0tPrWdZuUSIL1zdVj6CpnngjAG5CU35U
         9yra0A4qcuU3QelVy9Thq3pL7e37068nnzNVRkCJG9aRq+zBR8VCYjCfHgtlXa90Ue4H
         IGj41tdwPLrWondJBlm13KXtRnLZJprFieFjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oulAy7NlmqgAX/AG2BIWch0UpN6lWOBq/Xx+LqGxyiU=;
        b=XjMsobBfkwY8fjURtmK4/VmmfT1nJ4mh74czP4kS3JWKkcu/robF7DpaGx4NB/eM6f
         V3y4g8C2ys0k7nVONCoMoLrA5Qxcp0AzFjD8QwXMj/7eVnXv2cdti2xLihvASQtP7QYe
         IIsAsqeKUQ6YIU4TPEmLXoxUylD0nWP5aki2hXIdXjIQnoqC42YQ+M6TgITL9tTqXt6L
         z6Opfkyxp1IhOzoM+AB4qd9OH9Sp9/x7C4/XUZqOvsierrkGFJjQeK+5BLTuCGXWV9GF
         qwq9ktKF3OqCJUo/Kn8JnYrJBwXQqCxBlJyhj/Hgw+Yq4Mn4Htz2uKWsDv1xoV+gYwYq
         +38A==
X-Gm-Message-State: AJIora/fhHHev9Cmrhc7pzOJr7xdKs0gV6GjYqXTBwOoBr1MDuzuOX2i
        6pFWjt00rfF/NaVNFgA1b1zdo+ZyhyG7dg==
X-Google-Smtp-Source: AGRyM1uNf6I5+fQ6KcX/9MOZDknEktSDE/Z0l3YRPxDg86JuWUz6QknaienDhYHazulLUj/lBR6DPA==
X-Received: by 2002:a0c:9066:0:b0:470:2b7a:2078 with SMTP id o93-20020a0c9066000000b004702b7a2078mr22020533qvo.51.1655938307947;
        Wed, 22 Jun 2022 15:51:47 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k66-20020a37a145000000b006ab91fd03fasm1794022qke.19.2022.06.22.15.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:51:47 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 7/8] rcu/nocb: Rewrite deferred wake up logic to be more clean
Date:   Wed, 22 Jun 2022 22:51:01 +0000
Message-Id: <20220622225102.2112026-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622225102.2112026-1-joel@joelfernandes.org>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There are 2 things this function does:
1. modify the gp wake timer.
2. save the value of the strongest requested wake up so far.

The strongest is "wake force" and the weakest is "lazy".

The existing logic already does the following:
1. if the existing deferred wake is stronger than the requested one
   (requested in waketype), modify the gp timer to be more in the
   future. For example, if the existing one is WAKE and the new waketype
   requested is BYPASS, then the timer is made to expire later than
   earlier.

2. even though the timer is modified in #1, a weaker waketype does not
   end up changing rdp->nocb_gp_defer to be weaker. In other words,
   ->nocb_gp_defer records the strongest waketype requested so far,
   even though the timer may or may not be the soonest expiry possible.

For simplicity, we write this logic using switch statements and
consolidate some of the timer modification operations.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 255f2945b0fc..67b0bd5d233a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -282,6 +282,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 {
 	unsigned long flags;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
+	unsigned long mod_jif = 0;
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 
@@ -289,19 +290,31 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	 * Bypass wakeup overrides previous deferments. In case
 	 * of callback storm, no need to wake up too early.
 	 */
-	if (waketype == RCU_NOCB_WAKE_LAZY) {
-		mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
-		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
-	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
-		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
-		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
-	} else {
-		if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
-			mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
-		if (rdp_gp->nocb_defer_wakeup < waketype)
-			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+	switch (waketype) {
+		case RCU_NOCB_WAKE_LAZY:
+			mod_jif = jiffies_till_flush;
+			break;
+
+		case RCU_NOCB_WAKE_BYPASS:
+			mod_jif = 2;
+			break;
+
+		case RCU_NOCB_WAKE:
+		case RCU_NOCB_WAKE_FORCE:
+			// If the type of deferred wake is "stronger"
+			// than it was before, make it wake up the soonest.
+			if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
+				mod_jif = 1;
+			break;
 	}
 
+	if (mod_jif)
+		mod_timer(&rdp_gp->nocb_timer, jiffies + mod_jif);
+
+	// If new type of wake up is strong than before, promote.
+	if (rdp_gp->nocb_defer_wakeup < waketype)
+		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, reason);
-- 
2.37.0.rc0.104.g0611611a94-goog

