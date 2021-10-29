Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF01DC433EF
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 09:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85CB61157
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 09:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhJ2JoZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Oct 2021 05:44:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:50910 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231667AbhJ2JoX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Oct 2021 05:44:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="229360076"
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="229360076"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 02:41:53 -0700
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="498845489"
Received: from rdutta-mobl3.gar.corp.intel.com (HELO lkp-bingo.ccr.corp.intel.com) ([10.255.31.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 02:41:50 -0700
From:   Li Zhijian <zhijianx.li@intel.com>
To:     dave@stgolabs.net, joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
Cc:     philip.li@intel.com, lizhijian@cn.fujitsu.com,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Li Zhijian <zhijianx.li@intel.com>
Subject: [PATCH 4/6] scftorture: always log error message
Date:   Fri, 29 Oct 2021 17:40:27 +0800
Message-Id: <20211029094029.22501-5-zhijianx.li@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211029094029.22501-1-zhijianx.li@intel.com>
References: <20211029094029.22501-1-zhijianx.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Generally, error message should be logged anyhow.

Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
---
 kernel/scftorture.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 5fb15492999b..8ef7888d78cc 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -41,8 +41,7 @@
 #define VERBOSE_SCFTORTOUT(s, x...) \
 	do { if (verbose) pr_alert(SCFTORT_FLAG s "\n", ## x); } while (0)
 
-#define VERBOSE_SCFTORTOUT_ERRSTRING(s, x...) \
-	do { if (verbose) pr_alert(SCFTORT_FLAG "!!! " s "\n", ## x); } while (0)
+#define SCFTORTOUT_ERRSTRING(s, x...) pr_alert(SCFTORT_FLAG "!!! " s "\n", ## x)
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
@@ -583,14 +582,14 @@ static int __init scf_torture_init(void)
 	if (weight_single1 == 0 && weight_single_rpc1 == 0 && weight_single_wait1 == 0 &&
 	    weight_many1 == 0 && weight_many_wait1 == 0 &&
 	    weight_all1 == 0 && weight_all_wait1 == 0) {
-		VERBOSE_SCFTORTOUT_ERRSTRING("all zero weights makes no sense");
+		SCFTORTOUT_ERRSTRING("all zero weights makes no sense");
 		firsterr = -EINVAL;
 		goto unwind;
 	}
 	if (IS_BUILTIN(CONFIG_SCF_TORTURE_TEST))
 		scf_sel_add(weight_resched1, SCF_PRIM_RESCHED, false);
 	else if (weight_resched1)
-		VERBOSE_SCFTORTOUT_ERRSTRING("built as module, weight_resched ignored");
+		SCFTORTOUT_ERRSTRING("built as module, weight_resched ignored");
 	scf_sel_add(weight_single1, SCF_PRIM_SINGLE, false);
 	scf_sel_add(weight_single_rpc1, SCF_PRIM_SINGLE_RPC, true);
 	scf_sel_add(weight_single_wait1, SCF_PRIM_SINGLE, true);
@@ -621,7 +620,7 @@ static int __init scf_torture_init(void)
 		nthreads = num_online_cpus();
 	scf_stats_p = kcalloc(nthreads, sizeof(scf_stats_p[0]), GFP_KERNEL);
 	if (!scf_stats_p) {
-		VERBOSE_SCFTORTOUT_ERRSTRING("out of memory");
+		SCFTORTOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
-- 
2.32.0

