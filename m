Received: from mta0.migadu.com (out-19.mta0.migadu.com [91.218.175.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03945D93E
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113630; cv=none; b=ZU3uVWgdK5V0pH9LOpPAKyNe1jYcye38DL886xNOe1rSPba2GBs/sH8GFRMhpgfoJBFbCEaSzAqVD0ArarB4zPGWn+8p8czYcP4UbiJxK6z+VlzbBOeBr0xydpGHgD+gbHOBCiHWO5KmX4wfBQBvgKzToqCmdFOB9dr2+UmmSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113630; c=relaxed/simple;
	bh=3Bhv7ooPs5BmI+z9HsPTzdGyyICD44dDZ6H03uBSzOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2Vez09lWaA/jvFTvpZAiP5FziTe8/XgkIDFDP3/yzkHK0wDMwYM4LTOoFmqV9o8CSu0qJmOFZk3ItqAuFfZCADGAKOKxD6/lph3UjjDl6WmrSG29eO9vH9XMhDceWd536rKzTYBw414qGCn3gHSAZ5IjddWVKzrJmO6SaXVUfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RDyI7eaN; arc=none smtp.client-ip=91.218.175.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RDyI7eaN"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3Bhv7ooPs5BmI+z9HsPTzdGyyICD44dDZ6H03uBSzOI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113626; v=1; x=1789718426;
 b=RDyI7eaNTOGIMLMjkQCsB+pcnkWFA0PC+iMZyZsJDfn8aJjINLZtSpdjtpnSHdwb7IjsX5Se
 HI1beyyiFz2Q2oWYQhoihIiG5242gvgaOT2TzQlWl1fkN8xDQ/pbX48g03SzUyYNAfODC4YTUNy
 GdtNK5kUXCWjqFOtxYL3sVcw=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 430f4ef2b443db4c;
	Fri, 11 Sep 2026 08:00:00 +0000
X-Mizu-Trace-ID: 430f4ef2b443db4c
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
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
Subject: [PATCH v3 07/15] hung_task: convert process/thread iterators to for_each_*_rculock
Date: Fri, 11 Sep 2026 15:57:52 +0800
Message-Id: <20260911075800.491472-8-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260911075800.491472-1-ye.liu@linux.dev>
References: <20260911075800.491472-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ye Liu <liuye@kylinos.cn>

Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
with for_each_process_thread() loop in kernel/hung_task.c with
for_each_process_thread_rculock(), which scopes the RCU read lock
to the loop body via scoped_guard(rcu).

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
  - Rename stale 'unlock:' label to 'out:' in hung_task.c (Günther Noack)
 kernel/hung_task.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 6fcc94ce4ca9..73a5ad3be9a8 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -315,13 +315,12 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 		return;
 
 	this_round_count = 0;
-	rcu_read_lock();
-	for_each_process_thread(g, t) {
+	for_each_process_thread_rculock(g, t) {
 		if (!max_count--)
-			goto unlock;
+			goto out;
 		if (time_after(jiffies, last_break + HUNG_TASK_LOCK_BREAK)) {
 			if (!rcu_lock_break(g, t))
-				goto unlock;
+				goto out;
 			last_break = jiffies;
 		}
 
@@ -337,9 +336,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 			hung_task_info(t, timeout, this_round_count);
 		}
 	}
- unlock:
-	rcu_read_unlock();
-
+out:
 	if (!this_round_count)
 		return;
 
-- 
2.25.1

