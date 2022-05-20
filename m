Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B293CC433EF
	for <rcu@archiver.kernel.org>; Fri, 20 May 2022 08:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiETImB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 May 2022 04:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347458AbiETIl5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 May 2022 04:41:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2E055485;
        Fri, 20 May 2022 01:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653036116; x=1684572116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NqHGDulwUCbqHCOAD7aKEAe3Uyje2uxsYHPQO/MzEKc=;
  b=gkqZaK7C57x5NwX/ZWVk9KtNl7wsUfdOoK2WBmKSOt9BHw0DYCDHY3CD
   VWn5cuFHaah9XNjGzu+MN9wxEKjjUXEV0HJrbyKHUJeFo29zV+26lDDul
   pA4PavdSin6iUVHsN862uSktmqiK8JeCiHZcVIEBtz4mrzaNPWgld7WB1
   oiYfyNLXGl13uvgfHt94HEukSWwOchTGwsEFFLkYGgWjiI7B+ksnvl+me
   TspcBhmAZTW8DQK5b4KO9/bbVrsnT9e34nziiz9W0RD7nU/NaHsWO8RNz
   V+jgxFkdT0bSIrNc69zhVBcxVRfnMicOQ4kORZO45v6wPoVjdwu058Vpy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="260121463"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="260121463"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 01:41:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="546581854"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 01:41:54 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] rcu-tasks: Stop RCU Tasks scanning tasks which record on dyntick-idle entry
Date:   Fri, 20 May 2022 16:41:55 +0800
Message-Id: <20220520084155.1745726-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When the RCU Tasks scanning on-rq tasks, there is no need to scanning
tasks which record on dyntick-idle entry, at this time, these tasks are
not remain within an RCU Tasks read-side critical section.

This commit skip scanning tasks which record on dyntick-idle entry in
rcu_tasks_pertask().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 fix build test ERROR due to CONFIG_TASKS_RCU=n

 kernel/rcu/tasks.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f6459343e4b6..7cb0f922478e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -809,10 +809,17 @@ static void rcu_tasks_pregp_step(struct list_head *hop)
 	synchronize_rcu();
 }
 
+static bool task_is_on_dyntick_idle(struct task_struct *t)
+{
+	return IS_ENABLED(CONFIG_NO_HZ_FULL) && !is_idle_task(t) &&
+				t->rcu_tasks_idle_cpu >= 0;
+}
+
 /* Per-task initial processing. */
 static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 {
-	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
+	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t) &&
+				!task_is_on_dyntick_idle(t)) {
 		get_task_struct(t);
 		t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
 		WRITE_ONCE(t->rcu_tasks_holdout, true);
@@ -842,8 +849,7 @@ static void check_holdout_task(struct task_struct *t,
 	if (!READ_ONCE(t->rcu_tasks_holdout) ||
 	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
 	    !READ_ONCE(t->on_rq) ||
-	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
-	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
+	    task_is_on_dyntick_idle(t)) {
 		WRITE_ONCE(t->rcu_tasks_holdout, false);
 		list_del_init(&t->rcu_tasks_holdout_list);
 		put_task_struct(t);
-- 
2.25.1

