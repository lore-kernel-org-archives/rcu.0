Received: from mta1.migadu.com (out-234.mta1.migadu.com [95.215.58.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6191B46D086
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982689; cv=none; b=QcPXnp47K640H41w/hJeo1m3rAu1PBPpQErEORUW0LqCPjpgSo8wWKEQ4BCg5hz55/z8m5N6/rcvTPhipc4pEmt+vfSI+KCOCIZRc8svTO6s9KvzlKOut7HoRJSYikHnAP6coBeYqFgiQGcRgn1fNRczuw7Oji2KcfkFcGGsLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982689; c=relaxed/simple;
	bh=0W3ikDRTYv+yUei/a0Mgw/XZMKUGQdz8H5UTyurLOdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rq7BpSQPHYPFSBWiMfxhmc8lIaYi0B91PpHNNbbr+6Abra6uW11ihAFcRbPN7cOTpdxbR6K665sU/anbPZ/ZWXPNdjQBlDeArLy9MAGWe64H4ghnhZDyz9afqMM0nO1fewFuw4SbwTpwlWBcXKNmAnf/3ZwgYm/qmlV/7KhJhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FwBQ5bUJ; arc=none smtp.client-ip=95.215.58.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FwBQ5bUJ"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0W3ikDRTYv+yUei/a0Mgw/XZMKUGQdz8H5UTyurLOdI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789982684; v=1; x=1790587484;
 b=FwBQ5bUJzvbXiqI9kD+wPhtVGOuCgPk1yXA85jK65Zfk/fS84cAx1DRDcN1z+BQfS6fqe8KG
 lw/9Re1fKjn+4IxvMEqA4ZemhWuaz+d8OSSmQAsLLhLR7o3XAfn8zNE2JCr3l5Y1yomBUVHs4wo
 N6g5GQ1OMsEaArKSb4YSh+Mc=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c113fa249d93a37b;
	Mon, 21 Sep 2026 09:24:43 +0000
X-Mizu-Trace-ID: c113fa249d93a37b
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	x86@kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Ye Liu <liuye@kylinos.cn>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
Subject: [PATCH v4 13/15] fs: convert process/thread iterators to for_each_*_rculock
Date: Mon, 21 Sep 2026 17:20:59 +0800
Message-Id: <20260921092101.89285-14-ye.liu@linux.dev>
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

