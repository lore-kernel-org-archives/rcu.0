Received: from mta0.migadu.com (out-112.mta0.migadu.com [91.218.175.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489E45DF63
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982565; cv=none; b=ZgI0NP3SFTU2fee/t5kMz6mfRNhNe9HKIC8/q7vsB8xwDJJIPDmw3evcWA+MRX7c5uLmtg05LtcAXSXok0+576ztkXGZEz+Svf8dSZEBJ4J3MK5CuNtn1ml11Ijuk+SG234zhIHN8PSCRhX4zG15fVx1x6KVKYgI5VY6Adj8T6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982565; c=relaxed/simple;
	bh=FGT5bYNhb7F30R7KVhWzfpI91BeKfJqsry/WZ5Za0+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ACFvXygYynrkIDwSFfB+Dy1u8u02BRwT0TGfLkiCvzJoBvJBJijpFvHsrjJw+2KD1Ip4uu6dhNLH3i1ZMQ2A1BDKNT5gCgD0cph0xpUWdodgjPHiwXbRFunpIW2iEJVVKXxQ9Q5eF5n5/gm3AXfPXdB0JlnkOY9vE3k0pUbgI2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cbeFATl/; arc=none smtp.client-ip=91.218.175.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cbeFATl/"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FGT5bYNhb7F30R7KVhWzfpI91BeKfJqsry/WZ5Za0+s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789982560; v=1; x=1790587360;
 b=cbeFATl/S/mO56iCGH+rcO9I9RDaMqRXPfnxr9OtC/n7BpWdSxMIb7F73keo7iHEgeIWKLj7
 w5IkbclUpZdkLKPGFHVcCkayQUatur6sUPPjGy1YUvMqirnPoAQwi1F5AWevXbPOkyrxWXxMsgL
 0NnzqRhYOJVlNlh/TecAs9B4=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 311c3a7172cefc8c;
	Mon, 21 Sep 2026 09:22:40 +0000
X-Mizu-Trace-ID: 311c3a7172cefc8c
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	gnoack3000@gmail.com,
	gourry@gourry.net,
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
Subject: [PATCH v4 05/15] cpu/hotplug: convert process iterator to for_each_process_rculock
Date: Mon, 21 Sep 2026 17:20:51 +0800
Message-Id: <20260921092101.89285-6-ye.liu@linux.dev>
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

Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
with for_each_process() loop in kernel/cpu.c with for_each_process_rculock(),
which scopes the RCU read lock to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
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

