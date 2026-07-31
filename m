Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13C2C0F6D;
	Fri, 31 Jul 2026 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459847; cv=none; b=WmlkDbheX0qKyGq+UFhFSPgoldSWYAoG72pXeBJnerNRtaWlrU4yGe3hXGUIslXXFs9GQIFJJrdXmru2XCrtA/uM9nDeyBzeod1vVweV3okPLjBfNbcfJ+mKV7GxLZ3KRJBQZG5XJD3gbWQj6vVrmwQT9djl7/gXWB82KzTRCB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459847; c=relaxed/simple;
	bh=4GN8E6kKtIf3UE7YFBchKGzEHDGtnnAHGAVtBMwydhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3TvilKxqdCZ/bX94duHPFiAOpnCNET2wKHvumVzB5eC9Tp7f358VICL4D44TMeHzXmi8+JxZ/sVjhiZF27REt3u4vclIH87axPznUzbddnApUiumnh3CvmtSnL/gqWYe25NTccwP3ZbfcsbDbGJFkp/6TJOdduxvT+k14IiYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY9hGLDp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY9hGLDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187BE1F01558;
	Fri, 31 Jul 2026 01:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459844;
	bh=dqH4f2gQvM3neNCaqOlG30lCQN2dfQawkc5ucXKZqXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LY9hGLDpsaQbNHg2puy7x2PbOmKB7g51AvgVMY2p60bS5J5XVoqHzigetQu+mYXwp
	 9DdHS0qp1OijuTGcXBon9Cu9OXwY78Txko45tw9rmxfgot1GsQPXiYjWlvWs0hBxx4
	 U4FOQoo/d0ESROgI+cHnMe3P2M2sz4CWqNHtXDZuOsiJ9a6gFDeIt0de4c0X1Cs3Jh
	 gCNXWB/Eth/PYmTwaIfjh+20ULuU83BczJIN1ojAysCS7yPZOIdvfWQeAXakUBqlqK
	 7d7Fl04Yn9H4Fe6Lf9Jtguxzyfhp9mo5Jqrwp3QvJGFgss92u6v87ueAvxgXmZYWSD
	 h8nbp3kjZN5qg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9F082CE14D9; Thu, 30 Jul 2026 18:04:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 09/10] rcu-tasks: Rename tasks_rcu_exit_srcu_stall_timer to tasks_rcu_exit_stall_timer
Date: Thu, 30 Jul 2026 18:04:00 -0700
Message-Id: <20260731010401.3531631-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
References: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

This 'commit 1612160b9127 ("rcu-tasks: Eliminate deadlocks involving
do_exit() and RCU tasks")' has reimplemented the rcu_tasks_postscan(),
and the synchronize_srcu() has been removed, this commit therefore
rename tasks_rcu_exit_srcu_stall_timer to tasks_rcu_exit_stall_timer.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 0306a0568f0144..fce57d90db1a60 100644
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
2.40.1

