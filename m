Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB65C4332D
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B20F164EFE
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348963AbhCDBAq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236054AbhCDAHJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:07:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00F1D64F55;
        Wed,  3 Mar 2021 23:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614815781;
        bh=R552Tau9GrSttKxoMnF7QvSzApUBWl31xMHoL9CLHP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sWJg6b447D0dFuf+0rNd8097z7x2LVPTah1cjBE53FLnDO+Wp5s0vOz2hvv9xsT+t
         OSvznNJrLWjlVCIwqfnhmbRxOWdGWCs1+6pkF2NAnhtjhaoT4iM9NihMvINlDngDDJ
         B8OtMX6LB1Kuk6Me25ADzl7FmdYU3A4kEDIAXOEJhQbAuPjFWrYQbR0O8/j9chg7CG
         pFIA1DVc3Ek7c0uubKIL4mnGHJ2b16DozCqu3Ddt0TlP+LtqtViChi+s//aKVXMl7h
         kH5XyhebMgLsHjKcTIaxP8fiFdeNZXB3J/yaCjXExoCDvpkgA/c2S4ZJNdjZliLbG5
         DjhrR2Sf2NHWQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        paul.gortmaker@windriver.com, Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH lib/bitmap 8/9] rcu: deprecate "all" option to rcu_nocbs=
Date:   Wed,  3 Mar 2021 15:56:15 -0800
Message-Id: <20210303235616.22093-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235526.GA21868@paulmck-ThinkPad-P72>
References: <20210303235526.GA21868@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

With the core bitmap support now accepting "N" as a placeholder for
the end of the bitmap, "all" can be represented as "0-N" and has the
advantage of not being specific to RCU (or any other subsystem).

So deprecate the use of "all" by removing documentation references
to it.  The support itself needs to remain for now, since we don't
know how many people out there are using it currently, but since it
is in an __init area anyway, it isn't worth losing sleep over.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +---
 kernel/rcu/tree_plugin.h                        | 6 ++----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0454572..83e2ef1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4068,9 +4068,7 @@
 				see CONFIG_RAS_CEC help text.
 
 	rcu_nocbs=	[KNL]
-			The argument is a cpu list, as described above,
-			except that the string "all" can be used to
-			specify every CPU on the system.
+			The argument is a cpu list, as described above.
 
 			In kernels built with CONFIG_RCU_NOCB_CPU=y, set
 			the specified list of CPUs to be no-callback CPUs.
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2d60377..0b95562 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1464,14 +1464,12 @@ static void rcu_cleanup_after_idle(void)
 
 /*
  * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
- * The string after the "rcu_nocbs=" is either "all" for all CPUs, or a
- * comma-separated list of CPUs and/or CPU ranges.  If an invalid list is
- * given, a warning is emitted and all CPUs are offloaded.
+ * If the list is invalid, a warning is emitted and all CPUs are offloaded.
  */
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
-	if (!strcasecmp(str, "all"))
+	if (!strcasecmp(str, "all"))		/* legacy: use "0-N" instead */
 		cpumask_setall(rcu_nocb_mask);
 	else
 		if (cpulist_parse(str, rcu_nocb_mask)) {
-- 
2.9.5

