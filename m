Received: from mta0.migadu.com (out-168.mta0.migadu.com [91.218.175.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CE045FFA9
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113575; cv=none; b=KeP/hIVzHY6i02vU7Zm0Fh1mLS8nsXXJ5aI3Wk1DLde4rhBsHfN+Z2+ANAax7jciFksCIugbfnNp4FDJquFwiP6ANVQoDIwpZ8wUEt6TJOUXezPRwtIER8Ym35fuAqnkqgQ2Pi+0gEf97gXCcWuO7nKXPpTrdWklUSAxBaQG884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113575; c=relaxed/simple;
	bh=hw2TjBAqEOVWc+zu96DY/c0ZeYo5WpD38F+07ZSfH/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C0rgS/L+7SqoSaMiNyOKap5KcNiBoyt3qVUqWut2qFJxK7Ag8zfl+uYfbrZw2B3WtYpPDcdG4nIxyRlkwLhZUFAYFntb12fjSvTTCujxsGrIrmnulTxwCe7C/nlgOmJOMy4i++/wiNVObzeQ6iCNbweYcmXqfho5bfHCPD08/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D65qpbOS; arc=none smtp.client-ip=91.218.175.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D65qpbOS"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hw2TjBAqEOVWc+zu96DY/c0ZeYo5WpD38F+07ZSfH/w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113571; v=1; x=1789718371;
 b=D65qpbOSyBxEKN3XOVZrQzcIrNiHdrCIiKIFKQ5w9q6yoj6XymHoRvuxPsguJWTKmV1OwcYo
 3eIfb9i8n2UKi1KwJ/Cd7hNNEHwD83Rzm37VXBKrskmn8DtRRwcfwHYJ0bu+tou4jg4sTTOX4f5
 8yEp4uVIzM4G8Fo7s/ZTfots=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 31e1e1833329852b;
	Fri, 11 Sep 2026 07:59:30 +0000
X-Mizu-Trace-ID: 31e1e1833329852b
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
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
Subject: [PATCH v3 05/15] cpu/hotplug: convert thread iterator to for_each_thread_rculock
Date: Fri, 11 Sep 2026 15:57:50 +0800
Message-Id: <20260911075800.491472-6-ye.liu@linux.dev>
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

Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
with for_each_thread() loop in kernel/cpu.c with for_each_thread_rculock(),
which scopes the RCU read lock to the loop body via scoped_guard(rcu).

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
 kernel/cpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index b3c8553d7bd6..00638d2abc0f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1254,8 +1254,7 @@ void clear_tasks_mm_cpumask(int cpu)
 	 * full-fledged tasklist_lock.
 	 */
 	WARN_ON(cpu_online(cpu));
-	rcu_read_lock();
-	for_each_process(p) {
+	for_each_process_rculock(p) {
 		struct task_struct *t;
 
 		/*
@@ -1268,7 +1267,6 @@ void clear_tasks_mm_cpumask(int cpu)
 		arch_clear_mm_cpumask_cpu(cpu, t->mm);
 		task_unlock(t);
 	}
-	rcu_read_unlock();
 }
 
 /* Take this CPU down. */
-- 
2.25.1

