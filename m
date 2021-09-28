Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CC5C433EF
	for <rcu@archiver.kernel.org>; Tue, 28 Sep 2021 00:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B9C60E05
	for <rcu@archiver.kernel.org>; Tue, 28 Sep 2021 00:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhI1AXP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbhI1AXO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Sep 2021 20:23:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F605C061575;
        Mon, 27 Sep 2021 17:21:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t4so13016946plo.0;
        Mon, 27 Sep 2021 17:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rXOyN7cYCqXSX6iikjn82iMAk6UNThUEEXx7lGzOOt4=;
        b=J9KhDMLtVd5tT704X9aixuqITekkPkwRti5OjR8DcJSr+LTxrPZbORu3dQg6BSo5gL
         EGwMMyw6516Texb/atKCACgde3F+p+wnqDchLMi6bpxiLrU9K7qZO4Oahx0+IanSxaGD
         yxovs7s4/xWgYQKG/+/BuI21oQpXuSJ2QryT1OdUY2+vtjCBAhrhVNcK7tbyYurTWVjf
         zN1ykmCfadZb59q34g3MySnqibs5WfMjhmDY6P5G8GlbqhKSvHSbSHvTlTdH+Vet4aKd
         olj39wNQb5wk4yoOV2OUBen/tNQnJYM9ir71KnwnkmcC1vpS9caa0s6CJCL1/zW8NCMk
         waBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rXOyN7cYCqXSX6iikjn82iMAk6UNThUEEXx7lGzOOt4=;
        b=YbvuzfqBZiv6w36/UZ89CpoIW/gFvtilzfi0cBoT3JWRg0SDXrQpueOYHIMiWj6183
         E293HgbysyFrc+dKlw14zDPmRI2lvtP0SgoWmmr7Uf3/7cR4ig043yA/3zma3CAqqmBh
         AZJNdZ+lgDaDWfTgAneztuBbNOS3rP4fTX/DZGn/nDIdNJeFEKjvkd44UNHvl7xcQmKh
         Rid385PDuO/Ck1OrjEAfuFLwpJJONs8oZq1sqbBUc59UuP8t1Pe1hfrwx61R4HnYxu8e
         MvOCaSIpqy9srUSC5I9k6scHOl1pstIyLqIzI9F8fMfRgFLtu2YgE+XtIfaGo6qj2l9b
         gxgQ==
X-Gm-Message-State: AOAM532Gu8+3tvOEgpqfrw2/JZWxnQl8C7+0T/FJKbXHoBLdJLaA8l4m
        BfGhwlwmf+v4Abby4MoQ1LA=
X-Google-Smtp-Source: ABdhPJzfyG+PLLZ1NxOQUYogdGiadh+1ePkj9Sr+jegfcTFCzKP/FpyWzcTKx3eKBLXzQzZG4SvRSQ==
X-Received: by 2002:a17:90a:4983:: with SMTP id d3mr2095484pjh.53.1632788495597;
        Mon, 27 Sep 2021 17:21:35 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id n205sm18771916pfd.38.2021.09.27.17.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 17:21:35 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] rcu: in_irq() cleanup
Date:   Tue, 28 Sep 2021 08:21:28 +0800
Message-Id: <20210928002128.4501-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 include/linux/rcutiny.h  | 2 +-
 kernel/rcu/tree.c        | 2 +-
 kernel/rcu/tree_plugin.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 9be015305f9f..858f4d429946 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -85,7 +85,7 @@ static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
 static inline void rcu_irq_exit_check_preempt(void) { }
 #define rcu_is_idle_cpu(cpu) \
-	(is_idle_task(current) && !in_nmi() && !in_irq() && !in_serving_softirq())
+	(is_idle_task(current) && !in_nmi() && !in_hardirq() && !in_serving_softirq())
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bce848e50512..b53dd00975ab 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1471,7 +1471,7 @@ static void rcu_gp_kthread_wake(void)
 {
 	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
 
-	if ((current == t && !in_irq() && !in_serving_softirq()) ||
+	if ((current == t && !in_hardirq() && !in_serving_softirq()) ||
 	    !READ_ONCE(rcu_state.gp_flags) || !t)
 		return;
 	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d070059163d7..727bf14c9a63 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -642,7 +642,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
 			    t->rcu_blocked_node);
 		// Need to defer quiescent state until everything is enabled.
-		if (use_softirq && (in_irq() || (expboost && !irqs_were_disabled))) {
+		if (use_softirq && (in_hardirq() || (expboost && !irqs_were_disabled))) {
 			// Using softirq, safe to awaken, and either the
 			// wakeup is free or there is either an expedited
 			// GP in flight or a potential need to deboost.
-- 
2.32.0

