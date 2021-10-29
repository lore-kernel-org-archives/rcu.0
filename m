Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687C7C433EF
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 09:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A01160FC0
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 09:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhJ2JoN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Oct 2021 05:44:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:50887 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231559AbhJ2JoN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Oct 2021 05:44:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="229359969"
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="229359969"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 02:41:41 -0700
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="498845430"
Received: from rdutta-mobl3.gar.corp.intel.com (HELO lkp-bingo.ccr.corp.intel.com) ([10.255.31.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 02:41:38 -0700
From:   Li Zhijian <zhijianx.li@intel.com>
To:     dave@stgolabs.net, joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
Cc:     philip.li@intel.com, lizhijian@cn.fujitsu.com,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Li Zhijian <zhijianx.li@intel.com>
Subject: [PATCH 1/6] refscale: add missing '\n' to flush message out
Date:   Fri, 29 Oct 2021 17:40:24 +0800
Message-Id: <20211029094029.22501-2-zhijianx.li@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211029094029.22501-1-zhijianx.li@intel.com>
References: <20211029094029.22501-1-zhijianx.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

add '\n' to macros directly like what torture does to flush message
for each calls

Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
---
 kernel/rcu/refscale.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index f055d168365a..ffe9e44c886c 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -44,7 +44,10 @@
 	pr_alert("%s" SCALE_FLAG s, scale_type, ## x)
 
 #define VERBOSE_SCALEOUT(s, x...) \
-	do { if (verbose) pr_alert("%s" SCALE_FLAG s, scale_type, ## x); } while (0)
+	do { \
+		if (verbose) \
+			pr_alert("%s" SCALE_FLAG s "\n", scale_type, ## x); \
+	} while (0)
 
 static atomic_t verbose_batch_ctr;
 
@@ -54,12 +57,12 @@ do {											\
 	    (verbose_batched <= 0 ||							\
 	     !(atomic_inc_return(&verbose_batch_ctr) % verbose_batched))) {		\
 		schedule_timeout_uninterruptible(1);					\
-		pr_alert("%s" SCALE_FLAG s, scale_type, ## x);				\
+		pr_alert("%s" SCALE_FLAG s "\n", scale_type, ## x);			\
 	}										\
 } while (0)
 
 #define SCALEOUT_ERRSTRING(s, x...) \
-	do { pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
+	do { pr_alert("%s" SCALE_FLAG "!!! " s "\n", scale_type, ## x); } while (0)
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
@@ -842,7 +845,7 @@ ref_scale_init(void)
 		goto unwind;
 	}
 
-	VERBOSE_SCALEOUT("Starting %d reader threads\n", nreaders);
+	VERBOSE_SCALEOUT("Starting %d reader threads", nreaders);
 
 	for (i = 0; i < nreaders; i++) {
 		firsterr = torture_create_kthread(ref_scale_reader, (void *)i,
-- 
2.32.0

