Received: from mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE66459AC7
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113741; cv=none; b=K8shNbrk/GC4Vy+om/+7FkCsQq9y5fsRJjkW5cKhGbJ91GTCxVxq0auZSpo+RsyDu/eA69ZYLeq3Kgm8xlm/EqPLDSTa8tGmYTEy6nnT6wPtzQ7+Nl8NVxHX6p34dhCs6J4q7fKBbCkyt8GjMb8qK6LwOYCTfUWwOaK0CF90+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113741; c=relaxed/simple;
	bh=qoSX5ca3+2R9T/SC58K8tjc6WdOgd2bgxhEA3kDokIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yzt5/zyq6k0utpFvIFRy0IyZ12A6ZUBnajCtCMbMKsQEdTeis6MggGmPDwSpBjcTvxtmIKOnkzRc52g0PxXt+kq2DI05litcGD1RvvtF9xXJZDToCOqQYM8LEYBIZIemUw5bbAzRlTUOJKiXaT2hd7Mr1wQhHu1hNp3Tjr71kBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uBbKjQP2; arc=none smtp.client-ip=91.218.175.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uBbKjQP2"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qoSX5ca3+2R9T/SC58K8tjc6WdOgd2bgxhEA3kDokIM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113735; v=1; x=1789718535;
 b=uBbKjQP2EUFEE5hOrKY945vscJ8EiZRp/QjlrT/nUA2uof7ObFLnaQTzIwtMWoB5PtPeBbY8
 Hz6PB2TrYIwKc3fkuv1VVm53juNElXExAWWjrPSz8LRPnN2oVGZ9IB+rPFrpL6gltcZ+dyuDjxC
 KftX2UpgqD5WH7VnNstP7CiI=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7d384f5229d115c0;
	Fri, 11 Sep 2026 08:02:14 +0000
X-Mizu-Trace-ID: 7d384f5229d115c0
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	x86@kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Oleg Nesterov <oleg@redhat.com>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	tglx@kernel.org,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	gnoack3000@gmail.com,
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
Subject: [PATCH v3 13/15] fs: convert process/thread iterators to for_each_*_rculock
Date: Fri, 11 Sep 2026 15:57:58 +0800
Message-Id: <20260911075800.491472-14-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260911075800.491472-1-ye.liu@linux.dev>
References: <20260911075800.491472-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Liu <liuye@kylinos.cn>

Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
with for_each_process() and for_each_process_thread() loops in fs/
with the for_each_*_rculock() macros, which scope the RCU read lock
to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Changes in v2:
  - Rename *_rcu to *_rculock
 fs/proc/base.c        | 4 +---
 fs/resctrl/rdtgroup.c | 8 ++------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6a39de424f62..3de4f4557e4c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1160,8 +1160,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
 	if (mm) {
 		struct task_struct *p;
 
-		rcu_read_lock();
-		for_each_process(p) {
+		for_each_process_rculock(p) {
 			if (same_thread_group(task, p))
 				continue;
 
@@ -1177,7 +1176,6 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
 			}
 			task_unlock(p);
 		}
-		rcu_read_unlock();
 		mmdrop(mm);
 	}
 err_unlock:
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 5dcbb0a964e8..b14df8b23f1a 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -709,14 +709,12 @@ int rdtgroup_tasks_assigned(struct rdtgroup *r)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	rcu_read_lock();
-	for_each_process_thread(p, t) {
+	for_each_process_thread_rculock(p, t) {
 		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
 			ret = 1;
 			break;
 		}
 	}
-	rcu_read_unlock();
 
 	return ret;
 }
@@ -826,15 +824,13 @@ static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
 	struct task_struct *p, *t;
 	pid_t pid;
 
-	rcu_read_lock();
-	for_each_process_thread(p, t) {
+	for_each_process_thread_rculock(p, t) {
 		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
 			pid = task_pid_vnr(t);
 			if (pid)
 				seq_printf(s, "%d\n", pid);
 		}
 	}
-	rcu_read_unlock();
 }
 
 static int rdtgroup_tasks_show(struct kernfs_open_file *of,
-- 
2.25.1

