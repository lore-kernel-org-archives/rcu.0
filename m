Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08A0C5517A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8870920715
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617819;
	bh=VwjH8Shn9EAOIdA9q7NYvzwFSupY43r8X8G6THvMPWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XxtpAFngxHmfhg+GtXGikNigfUuLdCcKDiD5oAZ3aNw5Xyx3QYwiKk5Sz/mcu8ud6
	 /IEP3kEAAtNTWrt9z3od/IZYvmX10+Jn0A8sngyuuqufoIn03AFIZgxMhJ4VOGzPAb
	 xNCNBLhax3lfTXwSeoJD5Fy1KwX8hnDuIcTHjTAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbgKEXKS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732181AbgKEXJZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD9121556;
        Thu,  5 Nov 2020 23:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617764;
        bh=VwjH8Shn9EAOIdA9q7NYvzwFSupY43r8X8G6THvMPWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ViCNPhSxxV16lrSXLhKOFd2taJ3WSKFF2JulViaJiid+OP0P9a+Igl7Hwk6r5amxv
         xss/j+5n3FnKObO4taxPtu5qi/1dWv+JLTbcDSoX0Dp2tEzX09LkAhxyEPO6Gyvcan
         pY+cNAhKnBavyNE/1U7RspA0hxe7IkhDt7v1i/3Q=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, chao <chao@eero.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/16] rcu: Panic after fixed number of stalls
Date:   Thu,  5 Nov 2020 15:09:08 -0800
Message-Id: <20201105230921.19017-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: chao <chao@eero.com>

Some stalls are transient, so that system fully recovers.  This commit
therefore allows users to configure the number of stalls that must happen
in order to trigger kernel panic.

Signed-off-by: chao <chao@eero.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kernel.h  |  1 +
 kernel/rcu/tree_stall.h |  6 ++++++
 kernel/sysctl.c         | 11 +++++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2f05e91..4b5fd3d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -536,6 +536,7 @@ extern int panic_on_warn;
 extern unsigned long panic_on_taint;
 extern bool panic_on_taint_nousertaint;
 extern int sysctl_panic_on_rcu_stall;
+extern int sysctl_max_rcu_stall_to_panic;
 extern int sysctl_panic_on_stackoverflow;
 
 extern bool crash_kexec_post_notifiers;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index ca21d28..70d48c5 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -13,6 +13,7 @@
 
 /* panic() on RCU Stall sysctl. */
 int sysctl_panic_on_rcu_stall __read_mostly;
+int sysctl_max_rcu_stall_to_panic __read_mostly;
 
 #ifdef CONFIG_PROVE_RCU
 #define RCU_STALL_DELAY_DELTA		(5 * HZ)
@@ -106,6 +107,11 @@ early_initcall(check_cpu_stall_init);
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
 static void panic_on_rcu_stall(void)
 {
+	static int cpu_stall;
+
+	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
+		return;
+
 	if (sysctl_panic_on_rcu_stall)
 		panic("RCU Stall\n");
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index afad085..c9fbdd8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2650,6 +2650,17 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
+#if defined(CONFIG_TREE_RCU)
+	{
+		.procname	= "max_rcu_stall_to_panic",
+		.data		= &sysctl_max_rcu_stall_to_panic,
+		.maxlen		= sizeof(sysctl_max_rcu_stall_to_panic),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
+	},
+#endif
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 	{
 		.procname	= "stack_erasing",
-- 
2.9.5

