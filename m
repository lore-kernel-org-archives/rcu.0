Received: from mta1.migadu.com (out-154.mta1.migadu.com [95.215.58.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A499438483
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768861; cv=none; b=g+MeYpvQXT6kuRGuZww5nMwGwwBvhhT2o5NiWHBpOIcpzsX/YMEgEjoO88TRBLezlZlFlQer3rI+hmXf8QfiNWYp2IOkpUwSJHRZcwj6Gu1Zi0rd5WZL4bv4yPghEc1mi8WLZ6Co+UaPnal2Lo7LYa3ZkwRTmkqnkwnKfcao4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768861; c=relaxed/simple;
	bh=ASmH7PI5FjNsmJJfvtLeEl3jMhKoYtXHiDpYlixm7NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kODb5/F4Bt03lNHQ8NMl8ogIhZVimXJWEuNJyF6OT00GTeCkcu4LbePTWqjDL1bdWmtO6106xBeyThs84tFU4FtdIi0rDtjC9M1E+h06q8Ih08PNrcyUol8gpUNIMbIHvq49l0ttxlyrI57evj/m6XtqmqdeyPYVtdPjU4Pw7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PkoZv9VB; arc=none smtp.client-ip=95.215.58.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PkoZv9VB"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ASmH7PI5FjNsmJJfvtLeEl3jMhKoYtXHiDpYlixm7NE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788768857; v=1; x=1789373657;
 b=PkoZv9VByCYw+CljyqOF9vhxvVFtrnkwU1ESoTtbbzZMX+REPxlmCfAl3qLoVoYKZPvAzwyh
 +1BeCydxCCbXVJCnECU0fqJmK8b9xDXFZiRik0vgS6hFllrBdVgmpVU9EDMs9z6FOcnl8W+AaKl
 pj4TF64ee11t915IW3tj1a7M=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id be9bc340ab630053;
	Mon, 07 Sep 2026 08:14:16 +0000
X-Mizu-Trace-ID: be9bc340ab630053
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	SJ Park <sj@kernel.org>,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	oleg@redhat.com,
	tglx@kernel.org,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	gnoack3000@gmail.com,
	ljs@kernel.org,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	will@kernel.org,
	boqun@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	x86@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	pavel@kernel.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	pmladek@suse.com,
	longman@redhat.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	mark.rutland@arm.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/8] mm/oom_kill: convert process/thread iterators to for_each_*_rculock
Date: Mon,  7 Sep 2026 16:13:28 +0800
Message-Id: <20260907081334.1152889-3-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260907081334.1152889-1-ye.liu@linux.dev>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Liu <liuye@kylinos.cn>

Replace the manual rcu_read_lock()/rcu_read_unlock() pairs wrapping
for_each_process()/for_each_thread() loops with for_each_process_rculock()
and for_each_thread_rculock(), which scope the RCU read lock to the
loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: SJ Park <sj@kernel.org>
---
Changes in v2:
  - Rename *_rcu to *_rculock
 mm/oom_kill.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5f372f6e26fa..ef2e1c423c1d 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -94,8 +94,7 @@ static bool oom_cpuset_eligible(struct task_struct *start,
 	bool ret = false;
 	const nodemask_t *mask = oc->nodemask;
 
-	rcu_read_lock();
-	for_each_thread(start, tsk) {
+	for_each_thread_rculock(start, tsk) {
 		if (mask) {
 			/*
 			 * If this is a mempolicy constrained oom, tsk's
@@ -114,7 +113,6 @@ static bool oom_cpuset_eligible(struct task_struct *start,
 		if (ret)
 			break;
 	}
-	rcu_read_unlock();
 
 	return ret;
 }
@@ -368,11 +366,9 @@ static void select_bad_process(struct oom_control *oc)
 	else {
 		struct task_struct *p;
 
-		rcu_read_lock();
-		for_each_process(p)
+		for_each_process_rculock(p)
 			if (oom_evaluate_task(p, oc))
 				break;
-		rcu_read_unlock();
 	}
 }
 
@@ -430,14 +426,12 @@ static void dump_tasks(struct oom_control *oc)
 		struct task_struct *p;
 		int i = 0;
 
-		rcu_read_lock();
-		for_each_process(p) {
+		for_each_process_rculock(p) {
 			/* Avoid potential softlockup warning */
 			if ((++i & 1023) == 0)
 				touch_softlockup_watchdog();
 			dump_task(p, oc);
 		}
-		rcu_read_unlock();
 	}
 }
 
@@ -894,8 +888,7 @@ static bool task_will_free_mem(struct task_struct *task)
 	 * are dying as well to make sure that a) nobody pins its mm and
 	 * b) the task is also reapable by the oom reaper.
 	 */
-	rcu_read_lock();
-	for_each_process(p) {
+	for_each_process_rculock(p) {
 		if (!process_shares_mm(p, mm))
 			continue;
 		if (same_thread_group(task, p))
@@ -904,7 +897,6 @@ static bool task_will_free_mem(struct task_struct *task)
 		if (!ret)
 			break;
 	}
-	rcu_read_unlock();
 
 	return ret;
 }
@@ -960,8 +952,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	 * That thread will now get access to memory reserves since it has a
 	 * pending fatal signal.
 	 */
-	rcu_read_lock();
-	for_each_process(p) {
+	for_each_process_rculock(p) {
 		if (!process_shares_mm(p, mm))
 			continue;
 		if (same_thread_group(p, victim))
@@ -982,7 +973,6 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 			continue;
 		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
 	}
-	rcu_read_unlock();
 
 	if (can_oom_reap)
 		queue_oom_reaper(victim);
-- 
2.25.1

