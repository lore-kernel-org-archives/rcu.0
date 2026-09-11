Received: from mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196B42E433
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113684; cv=none; b=b3wHedkXcqOTyBDxILDoDw94eIJJJhDMULqSqoElucv2Kz/cjyPIm0pKwKiuPMSB0IOqO95TNRe0VJwl5JZ3fkGAsFmYuqTxwCQ+Oyf3cDSRmYA7eRj7oRoiDo08DmNvm2JDOWcTRmpXcXoRrKJpkp2fVotB3DG07ciUbR87FaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113684; c=relaxed/simple;
	bh=0hlRYPmyXV54QvYh0kyMJR49RsE/MghM4TVAvWeaXWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q8CY3/I0s5s8HlzebtMhLsi9Eh/DoS3RhG/ZkAMOtF9GLlAUqk7g9YIuePr+viF8YQcKzX1FrR4vPFjsKise/Ze4xoIFp1rj0A/YDeU832RGbJExrtWfuPzOiXvD59CslFfkLHdukKacOD2DkMyzSantbaMql+bRNM8UqFB1nLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K0T4axFF; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K0T4axFF"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0hlRYPmyXV54QvYh0kyMJR49RsE/MghM4TVAvWeaXWw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113678; v=1; x=1789718478;
 b=K0T4axFFAV3j7dfLX72ytjaA4PfYKcc7fDPwlpRoDhS5ZtKFLL72iTWfjc5JT7ObaS5kfWfY
 SF2ow5NZ3X/1EZmte6oABZ5GCFHu6htIjR1bkG25/nEvSny+T9P/ph9hxk3E+OM8taNI1ShcJdp
 A/0fvg7g+ehqYaK9EjeNApMw=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e4dd3759505df11b;
	Fri, 11 Sep 2026 08:01:17 +0000
X-Mizu-Trace-ID: e4dd3759505df11b
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	paulmck@kernel.org,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	tglx@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	gnoack3000@gmail.com,
	gourry@gourry.net,
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
Subject: [PATCH v3 10/15] sched: convert process/thread iterators to for_each_*_rculock
Date: Fri, 11 Sep 2026 15:57:55 +0800
Message-Id: <20260911075800.491472-11-ye.liu@linux.dev>
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

Replace the manual rcu_read_lock()/rcu_read_unlock() and guard(rcu)
pairs combined with for_each_process_thread() loops in kernel/sched/
with for_each_process_thread_rculock(), which scopes the RCU read
lock to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
Changes in v3:
  - Split from kernel/ patch in v2 (Peter Zijlstra, Steven Rostedt)

Changes in v2:
  - Rename *_rcu to *_rculock
 kernel/sched/core.c  | 3 +--
 kernel/sched/debug.c | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0697ed0f1c3d..fd5bdd2cb798 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2005,8 +2005,7 @@ static void uclamp_sync_util_min_rt_default(void)
 	smp_mb__after_spinlock();
 	read_unlock(&tasklist_lock);
 
-	guard(rcu)();
-	for_each_process_thread(g, p)
+	for_each_process_thread_rculock(g, p)
 		uclamp_update_util_min_rt_default(p);
 }
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 72236db67983..cdae165b98f7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1029,14 +1029,12 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 #endif
 		   "\n");
 
-	rcu_read_lock();
-	for_each_process_thread(g, p) {
+	for_each_process_thread_rculock(g, p) {
 		if (task_cpu(p) != rq_cpu)
 			continue;
 
 		print_task(m, rq, p);
 	}
-	rcu_read_unlock();
 }
 
 void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
-- 
2.25.1

