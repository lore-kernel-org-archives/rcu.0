Return-Path: <SRS0=/cn9=WN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25372C3A59B
	for <rcu@archiver.kernel.org>; Sat, 17 Aug 2019 04:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D932075E
	for <rcu@archiver.kernel.org>; Sat, 17 Aug 2019 04:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="o5xNnlpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfHQEWd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Aug 2019 00:22:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46267 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfHQEWd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Aug 2019 00:22:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so4102331pfc.13
        for <rcu@vger.kernel.org>; Fri, 16 Aug 2019 21:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNiU5F55TizZiRI5gbYafvWHVAa62ZcoOzkHgapO5wE=;
        b=o5xNnlpGQL+fDemNR6wSt63dQkXzhIH9xEnjXJagP7txkSr+kU3GcfjJYfzcdiovfN
         CG/r6GiGseH/NQ0Os3LIj1MzMcW+0I/TJCfgmCjjCjCxf0RPB1fqhgZrpD1dL4bB5IoZ
         4AWUjLlS0b8pXsA8i5HDF9hAVsRSvvkOwGpgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNiU5F55TizZiRI5gbYafvWHVAa62ZcoOzkHgapO5wE=;
        b=CepHnbZPTex13KaB5DPEeAWNMIUR33O87sNgcb3CUWnOdr4onQ5zDUFwRUDO2U3KTM
         1I01K4vbSrzwAJ1S2H5bYnqqyyQyH1lL7nSlZRDmBPCb+tQeQGI7wY4jqHiKcBlbi7Uv
         OyCLPBNPTeFZvMLQIrR6Ik4aLURIPJgym60gjF4jVZXnjVD0jA9GGwcok002NNdAxtfQ
         FkCxpFoKy3UnmDnQMSFiCQR2F9QgI3WWZLIUdBWQYsLfeG/RbC3oa7uZzHAM4E0hXuiz
         6TqzwcssxIXts64vcJaVWte8oHJttTz9vcZizvdfxzpVmoBNsH3lEmG2x0wIl0pb14BZ
         n+bA==
X-Gm-Message-State: APjAAAW4KxmPUiEWnGQ7dt7ai5OeIpSTea930eOGimzwqm0enKf7jHN/
        rEzoPYkCo9XHCya5noQzZS0bZA==
X-Google-Smtp-Source: APXvYqz0oiVjr7zsDWR7MC9l/HOfgMLZAZFrJn7ljUMoToAu8YgHmP4NeF5JmOSLAVN8ZWqh52AXWQ==
X-Received: by 2002:aa7:925a:: with SMTP id 26mr14128895pfp.198.1566015752452;
        Fri, 16 Aug 2019 21:22:32 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id 131sm6485365pge.37.2019.08.16.21.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 21:22:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, rcu@vger.kernel.org
Subject: [PATCH -rcu/dev] Please squash: fixup! rcu/tree: Add basic support for kfree_rcu() batching
Date:   Sat, 17 Aug 2019 00:22:11 -0400
Message-Id: <20190817042211.137149-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

xchg() on a bool is causing issues on riscv and arm32. Please squash
this into the -rcu dev branch to resolve the issue.

Please squash this fix.

Fixes: -rcu dev commit 3cbd3aa7d9c7bdf ("rcu/tree: Add basic support for kfree_rcu() batching")

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4f7c3096d786..33192a58b39a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2717,7 +2717,7 @@ struct kfree_rcu_cpu {
 	 * is busy, ->head just continues to grow and we retry flushing later.
 	 */
 	struct delayed_work monitor_work;
-	bool monitor_todo;	/* Is a delayed work pending execution? */
+	int monitor_todo;	/* Is a delayed work pending execution? */
 };
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
@@ -2790,7 +2790,7 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 	/* Previous batch that was queued to RCU did not get free yet, let us
 	 * try again soon.
 	 */
-	if (!xchg(&krcp->monitor_todo, true))
+	if (!xchg(&krcp->monitor_todo, 1))
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	spin_unlock_irqrestore(&krcp->lock, flags);
 }
@@ -2806,7 +2806,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 						 monitor_work.work);
 
 	spin_lock_irqsave(&krcp->lock, flags);
-	if (xchg(&krcp->monitor_todo, false))
+	if (xchg(&krcp->monitor_todo, 0))
 		kfree_rcu_drain_unlock(krcp, flags);
 	else
 		spin_unlock_irqrestore(&krcp->lock, flags);
@@ -2858,7 +2858,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	krcp->head = head;
 
 	/* Schedule monitor for timely drain after KFREE_DRAIN_JIFFIES. */
-	if (!xchg(&krcp->monitor_todo, true))
+	if (!xchg(&krcp->monitor_todo, 1))
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 
 	spin_unlock(&krcp->lock);
-- 
2.23.0.rc1.153.gdeed80330f-goog

