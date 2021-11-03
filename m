Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E169C433EF
	for <rcu@archiver.kernel.org>; Wed,  3 Nov 2021 08:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3277B61175
	for <rcu@archiver.kernel.org>; Wed,  3 Nov 2021 08:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhKCIeh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Nov 2021 04:34:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:30157 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhKCIeh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Nov 2021 04:34:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="212206473"
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="212206473"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 01:32:00 -0700
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="449705757"
Received: from jzhuge-mobl.ccr.corp.intel.com (HELO lkp-bingo.fnst-test.com) ([10.255.31.103])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 01:31:57 -0700
From:   Li Zhijian <zhijianx.li@intel.com>
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, lizhijian@cn.fujitsu.com,
        philip.li@intel.com, Li Zhijian <zhijianx.li@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v2 1/2] scftorture: Always log error message
Date:   Wed,  3 Nov 2021 16:30:27 +0800
Message-Id: <20211103083028.26504-1-zhijianx.li@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Unconditionally log messages corresponding to errors.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Li Zhijian <zhijianx.li@intel.com>

---
V2: rebase against rcu tree
---
 kernel/scftorture.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index a0df767897a1..dcb0410950e4 100644
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
@@ -584,14 +583,14 @@ static int __init scf_torture_init(void)
 	if (weight_resched1 == 0 && weight_single1 == 0 && weight_single_rpc1 == 0 &&
 	    weight_single_wait1 == 0 && weight_many1 == 0 && weight_many_wait1 == 0 &&
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
@@ -622,7 +621,7 @@ static int __init scf_torture_init(void)
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

