Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CF1C433EF
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 09:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0825960FC0
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 09:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhJ2Joe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Oct 2021 05:44:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:50910 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbhJ2Job (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Oct 2021 05:44:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="229360160"
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="229360160"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 02:42:01 -0700
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="498845574"
Received: from rdutta-mobl3.gar.corp.intel.com (HELO lkp-bingo.ccr.corp.intel.com) ([10.255.31.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 02:41:57 -0700
From:   Li Zhijian <zhijianx.li@intel.com>
To:     dave@stgolabs.net, joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
Cc:     philip.li@intel.com, lizhijian@cn.fujitsu.com,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Li Zhijian <zhijianx.li@intel.com>
Subject: [PATCH 6/6] locktorture,rcutorture,torture: always log error message
Date:   Fri, 29 Oct 2021 17:40:29 +0800
Message-Id: <20211029094029.22501-7-zhijianx.li@intel.com>
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
 include/linux/torture.h      | 9 ++-------
 kernel/locking/locktorture.c | 4 ++--
 kernel/rcu/rcutorture.c      | 8 ++++----
 kernel/torture.c             | 4 ++--
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 0910c5803f35..1d2e6c4c38fa 100644
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
 
 /* Definitions for online/offline exerciser. */
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 7c5a4a087cc7..6752ce3ac424 100644
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
index ab4215266ebe..9197ce5c7a7d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2717,7 +2717,7 @@ static int rcu_torture_read_exit(void *unused)
 				     &trs, "%s",
 				     "rcu_torture_read_exit_child");
 		if (IS_ERR(tsp)) {
-			VERBOSE_TOROUT_ERRSTRING("out of memory");
+			TOROUT_ERRSTRING("out of memory");
 			errexit = true;
 			tsp = NULL;
 			break;
@@ -3044,7 +3044,7 @@ rcu_torture_init(void)
 					   sizeof(fakewriter_tasks[0]),
 					   GFP_KERNEL);
 		if (fakewriter_tasks == NULL) {
-			VERBOSE_TOROUT_ERRSTRING("out of memory");
+			TOROUT_ERRSTRING("out of memory");
 			firsterr = -ENOMEM;
 			goto unwind;
 		}
@@ -3060,7 +3060,7 @@ rcu_torture_init(void)
 	rcu_torture_reader_mbchk = kcalloc(nrealreaders, sizeof(*rcu_torture_reader_mbchk),
 					   GFP_KERNEL);
 	if (!reader_tasks || !rcu_torture_reader_mbchk) {
-		VERBOSE_TOROUT_ERRSTRING("out of memory");
+		TOROUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
@@ -3079,7 +3079,7 @@ rcu_torture_init(void)
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

