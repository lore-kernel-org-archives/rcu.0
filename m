Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5947C4332F
	for <rcu@archiver.kernel.org>; Wed,  3 Nov 2021 08:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1DA60E9B
	for <rcu@archiver.kernel.org>; Wed,  3 Nov 2021 08:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhKCIek (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Nov 2021 04:34:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:30157 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhKCIej (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Nov 2021 04:34:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="212206485"
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="212206485"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 01:32:03 -0700
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="449705786"
Received: from jzhuge-mobl.ccr.corp.intel.com (HELO lkp-bingo.fnst-test.com) ([10.255.31.103])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 01:32:00 -0700
From:   Li Zhijian <zhijianx.li@intel.com>
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, lizhijian@cn.fujitsu.com,
        philip.li@intel.com, Li Zhijian <zhijianx.li@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v2 2/2] locktorture,rcutorture,torture: Always log error message
Date:   Wed,  3 Nov 2021 16:30:28 +0800
Message-Id: <20211103083028.26504-2-zhijianx.li@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211103083028.26504-1-zhijianx.li@intel.com>
References: <20211103083028.26504-1-zhijianx.li@intel.com>
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
 include/linux/torture.h      | 9 ++-------
 kernel/locking/locktorture.c | 4 ++--
 kernel/rcu/rcutorture.c      | 8 ++++----
 kernel/torture.c             | 4 ++--
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 24f58e50a94b..63fa4196e51c 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -38,13 +38,8 @@ do {										\
 		pr_alert("%s" TORTURE_FLAG " %s\n", torture_type, s);		\
 	}									\
 } while (0)
-#define VERBOSE_TOROUT_ERRSTRING(s) \
-do {										\
-	if (verbose) {								\
-		verbose_torout_sleep();						\
-		pr_alert("%s" TORTURE_FLAG "!!! %s\n", torture_type, s);	\
-	}									\
-} while (0)
+#define TOROUT_ERRSTRING(s) \
+	pr_alert("%s" TORTURE_FLAG "!!! %s\n", torture_type, s)
 void verbose_torout_sleep(void);
 
 #define torture_init_error(firsterr)						\
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 397ac13d2ef7..9c2fb613a55d 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -1047,7 +1047,7 @@ static int __init lock_torture_init(void)
 				       sizeof(writer_tasks[0]),
 				       GFP_KERNEL);
 		if (writer_tasks == NULL) {
-			VERBOSE_TOROUT_ERRSTRING("writer_tasks: Out of memory");
+			TOROUT_ERRSTRING("writer_tasks: Out of memory");
 			firsterr = -ENOMEM;
 			goto unwind;
 		}
@@ -1058,7 +1058,7 @@ static int __init lock_torture_init(void)
 				       sizeof(reader_tasks[0]),
 				       GFP_KERNEL);
 		if (reader_tasks == NULL) {
-			VERBOSE_TOROUT_ERRSTRING("reader_tasks: Out of memory");
+			TOROUT_ERRSTRING("reader_tasks: Out of memory");
 			kfree(writer_tasks);
 			writer_tasks = NULL;
 			firsterr = -ENOMEM;
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 503e14e62e8f..36a273589a35 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2774,7 +2774,7 @@ static int rcu_torture_read_exit(void *unused)
 				     &trs, "%s",
 				     "rcu_torture_read_exit_child");
 		if (IS_ERR(tsp)) {
-			VERBOSE_TOROUT_ERRSTRING("out of memory");
+			TOROUT_ERRSTRING("out of memory");
 			errexit = true;
 			tsp = NULL;
 			break;
@@ -3101,7 +3101,7 @@ rcu_torture_init(void)
 					   sizeof(fakewriter_tasks[0]),
 					   GFP_KERNEL);
 		if (fakewriter_tasks == NULL) {
-			VERBOSE_TOROUT_ERRSTRING("out of memory");
+			TOROUT_ERRSTRING("out of memory");
 			firsterr = -ENOMEM;
 			goto unwind;
 		}
@@ -3117,7 +3117,7 @@ rcu_torture_init(void)
 	rcu_torture_reader_mbchk = kcalloc(nrealreaders, sizeof(*rcu_torture_reader_mbchk),
 					   GFP_KERNEL);
 	if (!reader_tasks || !rcu_torture_reader_mbchk) {
-		VERBOSE_TOROUT_ERRSTRING("out of memory");
+		TOROUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
@@ -3136,7 +3136,7 @@ rcu_torture_init(void)
 	if (nrealnocbers > 0) {
 		nocb_tasks = kcalloc(nrealnocbers, sizeof(nocb_tasks[0]), GFP_KERNEL);
 		if (nocb_tasks == NULL) {
-			VERBOSE_TOROUT_ERRSTRING("out of memory");
+			TOROUT_ERRSTRING("out of memory");
 			firsterr = -ENOMEM;
 			goto unwind;
 		}
diff --git a/kernel/torture.c b/kernel/torture.c
index bb8f411c974b..ef27a6c82451 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -570,7 +570,7 @@ int torture_shuffle_init(long shuffint)
 	shuffle_idle_cpu = -1;
 
 	if (!alloc_cpumask_var(&shuffle_tmp_mask, GFP_KERNEL)) {
-		VERBOSE_TOROUT_ERRSTRING("Failed to alloc mask");
+		TOROUT_ERRSTRING("Failed to alloc mask");
 		return -ENOMEM;
 	}
 
@@ -934,7 +934,7 @@ int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, char *m,
 	*tp = kthread_run(fn, arg, "%s", s);
 	if (IS_ERR(*tp)) {
 		ret = PTR_ERR(*tp);
-		VERBOSE_TOROUT_ERRSTRING(f);
+		TOROUT_ERRSTRING(f);
 		*tp = NULL;
 	}
 	torture_shuffle_task_register(*tp);
-- 
2.32.0

