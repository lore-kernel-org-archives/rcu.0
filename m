Received: from mta1.migadu.com (out-224.mta1.migadu.com [95.215.58.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E3466AE5
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982517; cv=none; b=nKRMa324BH+35pvO785sZy/ELMuA8M59AT4RXTw0Gy0uBkCLBn8nKaGjS4YzTlFjW9eM8QsmvAAWybTkHostn/tn6SwUAf1m63YW1GdXz8tPdHMjogQhQ3iH4jsA6JRcY6aTwtIkjX3u2WWlaWpqmPEhl9qeZ6Cl1kjhQG3UlsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982517; c=relaxed/simple;
	bh=ftt2VmSueNigEmRUzim7RcAInXHUvUyDkJasA+sP/sI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOtGeorUdmfBtLsCGJN8Rfgy8flxeRWnmybxU1oMLLwzsrbvxzHEDo9kAqlrur+3k6uzEvvdZXyQAFUFoonXII+r8sw4M48qFsedlnjrXzqB/M9S2Q87Z6QKf/VC9Lg5bESHOrjBKGTVs6Eu3VmU59h0fCZulPVwaD172S7W8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jWsbvQJn; arc=none smtp.client-ip=95.215.58.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jWsbvQJn"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ftt2VmSueNigEmRUzim7RcAInXHUvUyDkJasA+sP/sI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789982513; v=1; x=1790587313;
 b=jWsbvQJno9CuCyQVTZB9lhN7qsOidsqwQTyAIOnMC7/GD/rn2vKIe+LgRS26jI5FcznCU58R
 mIUL3pOsfkgA9Jr6AuJrp73cNcmcaSTvjS0o1R5wKXId1z/TjWu1fFmM0N1QApAjsWPJrdeFXv3
 L2EIteOtnYoad3rIZ50U9dg0=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 63f02883ed771dab;
	Mon, 21 Sep 2026 09:21:53 +0000
X-Mizu-Trace-ID: 63f02883ed771dab
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	SJ Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
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
	babu.moger@amd.com
Subject: [PATCH v4 02/15] mm/oom_kill: convert process/thread iterators to for_each_*_rculock
Date: Mon, 21 Sep 2026 17:20:48 +0800
Message-Id: <20260921092101.89285-3-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260921092101.89285-1-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
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
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
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

