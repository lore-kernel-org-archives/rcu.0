Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C173D669A
	for <rcu@vger.kernel.org>; Mon, 20 Jul 2026 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541009; cv=none; b=NjaGH9JavOCa3noxONkTrVrkKFS5ArQK+GwD5tvDYk5E7CjvUDvrQ3/HM4VQWHoo9wpjSpTHgZEfFIw1PrfbQduJwO2Sz4O0CNLu4bYlvesvTNpCM6BeZZJf1TfqdtSm3nctBXnrZSuoyRpS89tcP+nJeQAatTXTXdumnfbE21w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541009; c=relaxed/simple;
	bh=9kX6jzE+4Tbef3wdo28BMNEN/x/GJqcMooz6U+MJc3I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QiVZbo9FL5+qw/5nG88NFx1alpyxWPLnFSA/LYiSYCOWpdt9ZAWr6vGVy9kK/fsWCLJE5cNxfe9RUZ8EJJaTxoo8e7NVYYy4zxMpj7HDUsK2uEGNDFODduliScImq9bgDhkoisZe8oYtrRuI4O36ekmoiC4CIDVjQ/UlM8kBY4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QIqPLwgw; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QIqPLwgw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784541004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=M80bIycDI9F6g+Pn95VeJgw0Pgi5hk1NBl+f+3M1AeI=;
	b=QIqPLwgw0qBO01ZOu8q8xRSLvZz8EtkF26EG91MP0cLMP99pxUGH/qnho/u7MXbvVn80OV
	WiLiG6G8MMevD2BsI5SlsYiwO8TkIYolKhnM6SM7gSrhgPUtTb4r7UMu7Sw4DRsD7zh3zr
	j3mXcgGK8OktWI5/kBW8ZO1p3euChVA=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	urezki@gmail.com,
	boqun@kernel.org
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Rename tasks_rcu_exit_srcu_stall_timer to tasks_rcu_exit_stall_timer
Date: Mon, 20 Jul 2026 17:49:58 +0800
Message-Id: <20260720094958.30587-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

This 'commit 1612160b9127 ("rcu-tasks: Eliminate deadlocks involving
do_exit() and RCU tasks")' has reimplemented the rcu_tasks_postscan(),
and the synchronize_srcu() has been removed, this commit therefore
rename tasks_rcu_exit_srcu_stall_timer to tasks_rcu_exit_stall_timer.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tasks.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ff803871b577..23c6a2fed487 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -155,8 +155,8 @@ static struct rcu_tasks rt_name =							\
 #ifdef CONFIG_TASKS_RCU
 
 /* Report delay of scan exiting tasklist in rcu_tasks_postscan(). */
-static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
-static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
+static void tasks_rcu_exit_stall(struct timer_list *unused);
+static DEFINE_TIMER(tasks_rcu_exit_stall_timer, tasks_rcu_exit_stall);
 #endif
 
 /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
@@ -1032,8 +1032,8 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	int rtsi = READ_ONCE(rcu_task_stall_info);
 
 	if (!IS_ENABLED(CONFIG_TINY_RCU)) {
-		tasks_rcu_exit_srcu_stall_timer.expires = jiffies + rtsi;
-		add_timer(&tasks_rcu_exit_srcu_stall_timer);
+		tasks_rcu_exit_stall_timer.expires = jiffies + rtsi;
+		add_timer(&tasks_rcu_exit_stall_timer);
 	}
 
 	/*
@@ -1086,7 +1086,7 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	}
 
 	if (!IS_ENABLED(CONFIG_TINY_RCU))
-		timer_delete_sync(&tasks_rcu_exit_srcu_stall_timer);
+		timer_delete_sync(&tasks_rcu_exit_stall_timer);
 }
 
 /* See if tasks are still holding out, complain if so. */
@@ -1158,7 +1158,7 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 	synchronize_rcu();
 }
 
-static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
+static void tasks_rcu_exit_stall(struct timer_list *unused)
 {
 #ifndef CONFIG_TINY_RCU
 	int rtsi;
@@ -1168,8 +1168,8 @@ static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
 		__func__, rcu_tasks.kname, rcu_tasks.tasks_gp_seq,
 		tasks_gp_state_getname(&rcu_tasks), jiffies - rcu_tasks.gp_jiffies);
 	pr_info("Please check any exiting tasks stuck between calls to exit_tasks_rcu_start() and exit_tasks_rcu_finish()\n");
-	tasks_rcu_exit_srcu_stall_timer.expires = jiffies + rtsi;
-	add_timer(&tasks_rcu_exit_srcu_stall_timer);
+	tasks_rcu_exit_stall_timer.expires = jiffies + rtsi;
+	add_timer(&tasks_rcu_exit_stall_timer);
 #endif // #ifndef CONFIG_TINY_RCU
 }
 
-- 
2.17.1

