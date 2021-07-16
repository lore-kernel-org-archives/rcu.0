Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB74C07E95
	for <rcu@archiver.kernel.org>; Fri, 16 Jul 2021 05:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED0F613D4
	for <rcu@archiver.kernel.org>; Fri, 16 Jul 2021 05:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhGPFoW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Jul 2021 01:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhGPFoW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Jul 2021 01:44:22 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E8C061760
        for <rcu@vger.kernel.org>; Thu, 15 Jul 2021 22:41:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id u14so8876105pga.11
        for <rcu@vger.kernel.org>; Thu, 15 Jul 2021 22:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4myuWkA9xB+cjc0XD5MczNyScf1c1ZlV8jj86wi9jI0=;
        b=Cc+oIpxiJq7lvKQ9o7sx7yagPWlMIilCxXgJd8Tfhj8hVMEdbOtsRW7iocFBmrbAcH
         tENgsXAfC3+uzB1p9mu4EKmU+sWiNeFrFozzzMiK2dq9rJx5BjEpx+I/DDzq9N0V4F9Y
         lvpczMYU9kmxQdtAJcw73T/LmUMexjNIGaLwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4myuWkA9xB+cjc0XD5MczNyScf1c1ZlV8jj86wi9jI0=;
        b=U7eUFbF4Gui3Oz7FCoSt7a9FRGdNmN0PasuFkVgYKjcKoxPh4wyqA8u2es52M43rOo
         PLayy9wGbp0JwETABiDpDimHFYljnBf3OKw5+IwqZEiBrIy47GfJ6NDYFl8x0FP00gI9
         z/Lu1vXSzLVxNz90u83CaHctWwFKM9zScBWwliP/l2zMssBew6LTTOXhij14YassvsiM
         NTIHVj9dtnbFP91hKAhRWEM5OYPasR5n5+q3UE1No166Bu3xD6PE9f3Pu+R3BWZxfSAu
         NRJQyslGsbEoSM6d1O/AMbMbtW3w/k9caHddqaHpCJnbEDnDIyC5bki97LC/uOS3+hZw
         ZlEA==
X-Gm-Message-State: AOAM532BCKQErCx2iqSrsaxI+kh0zl286i9VXiVy9yxJciolFWSkceVz
        UwDmltEnZJAv6mYks3RILbhtYg==
X-Google-Smtp-Source: ABdhPJxUByLMN1y1QO9dDiTq4b2c5IDX5aUojwQ0pcUb0FGmZU5XQKCcL6+wGtnezmgPbtz6oSPBHg==
X-Received: by 2002:a63:d014:: with SMTP id z20mr8179873pgf.203.1626414087462;
        Thu, 15 Jul 2021 22:41:27 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:d1af:356e:50a6:75e8])
        by smtp.gmail.com with ESMTPSA id o25sm9664412pgd.21.2021.07.15.22.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 22:41:26 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH] rcu: call kvm_check_and_clear_guest_paused unconditionally
Date:   Fri, 16 Jul 2021 14:41:13 +0900
Message-Id: <20210716054113.1244529-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Do not call kvm_check_and_clear_guest_paused() only from the
stall branch (which requires an active grace period in the
first place), but instead handle PVCLOCK_GUEST_STOPPED as
early as possible.

pvclock_touch_watchdogs() touches various watchdogs, which
have different timeouts, so the earlier we handle stopped
VCPU the better (lockup watchdog does the same).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 677ee3d8671b..5dd6ea2ead0c 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -657,6 +657,13 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	unsigned long js;
 	struct rcu_node *rnp;
 
+	/*
+	 * If a virtual machine is stopped by the host it can look to
+	 * the watchdog like an RCU stall. Check to see if the host
+	 * stopped the vm.
+	 */
+	kvm_check_and_clear_guest_paused();
+
 	lockdep_assert_irqs_disabled();
 	if ((rcu_stall_is_suppressed() && !READ_ONCE(rcu_kick_kthreads)) ||
 	    !rcu_gp_in_progress())
@@ -699,14 +706,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
 	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
-		/*
-		 * If a virtual machine is stopped by the host it can look to
-		 * the watchdog like an RCU stall. Check to see if the host
-		 * stopped the vm.
-		 */
-		if (kvm_check_and_clear_guest_paused())
-			return;
-
 		/* We haven't checked in, so go dump stack. */
 		print_cpu_stall(gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
@@ -717,14 +716,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
 		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
-		/*
-		 * If a virtual machine is stopped by the host it can look to
-		 * the watchdog like an RCU stall. Check to see if the host
-		 * stopped the vm.
-		 */
-		if (kvm_check_and_clear_guest_paused())
-			return;
-
 		/* They had a few time units to dump stack, so complain. */
 		print_other_cpu_stall(gs2, gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
-- 
2.32.0.402.g57bb445576-goog

