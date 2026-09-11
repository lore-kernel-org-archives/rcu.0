Received: from mta0.migadu.com (out-244.mta0.migadu.com [91.218.175.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C824582D8
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113520; cv=none; b=luqaD0JOINebtpc8c/sCzqLEQitVw2cmm9PYRJGXXxJSLm95+nYnYo65XvlDEr8zhVz+P3l8cUPa7PQOw+rAxjirqazZE6LvPpGg/qdRxGY31smE80Qti3BOZj9bUQGpFwjf0+Amz3EFG3gyBfsiRRwnBntMusDUyXKtC3QtnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113520; c=relaxed/simple;
	bh=Go12g+R4uFq+BJOyGZXb1onOnQjq2C3kX1LePEwX1Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZP82Pga/VZUi+qWdIoFVPissfJMa2TIxPwWVGQWLELcFbhZ0GBoyfpN9CSaqr92Z5hbe42s27MbCZfCGKnXAXcJa+3AtOf3zdIbsc5ntKnxKrQULEOBLUhhC+Fi8AeMVXAgWhphd382e1qqNqHaXYhKxfEMLyvk6fK942bYBlcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YDo04jKQ; arc=none smtp.client-ip=91.218.175.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YDo04jKQ"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Go12g+R4uFq+BJOyGZXb1onOnQjq2C3kX1LePEwX1Iw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113515; v=1; x=1789718315;
 b=YDo04jKQh3Y3S/7i66rcYtGSc3d7mvbF64LTRqP+Bg0FwPAfDTuo6bmkKDAwMAxUsAZx7or2
 zMu+dH4a9q3u1OXnj6JEFkEU58VsCzOFCH1suvqM1aJ/NisObpY0vo7gaGIpYNr5XcjgYdsh60x
 t3glJoKXrukMfMOVzZIr/wDI=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7120d82fe4ac0fd4;
	Fri, 11 Sep 2026 07:58:35 +0000
X-Mizu-Trace-ID: 7120d82fe4ac0fd4
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christian Brauner <brauner@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	paulmck@kernel.org,
	mingo@redhat.com,
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
Subject: [PATCH v3 01/15] sched: introduce for_each_process_rculock and for_each_thread_rculock
Date: Fri, 11 Sep 2026 15:57:46 +0800
Message-Id: <20260911075800.491472-2-ye.liu@linux.dev>
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

Introduce for_each_process_rculock(), for_each_thread_rculock() and
for_each_process_thread_rculock() macros that acquire the RCU read
lock before the iteration starts and release it when the loop is left,
so that the RCU read-side critical section is scoped to the loop body
instead of an externally managed rcu_read_lock()/rcu_read_unlock()
pair.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Changes in v3:
  - Indent loop body to show scoped_guard scope (Lorenzo Stoakes)

Changes in v2:
  - Rename macros from *_rcu to *_rculock (Steven Rostedt, Thomas Gleixner)
  - Improve comment on for_each_process_thread_rculock() double loop
  - Change prefix from mm: to sched: (Michal Hocko)
 include/linux/sched/signal.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 584ae88b435e..ea23c7e9db33 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCHED_SIGNAL_H
 #define _LINUX_SCHED_SIGNAL_H
 
+#include <linux/cleanup.h>
 #include <linux/rculist.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -663,6 +664,31 @@ extern bool current_is_single_threaded(void);
 #define for_each_process_thread(p, t)	\
 	for_each_process(p) for_each_thread(p, t)
 
+/*
+ * Variants of for_each_process(), for_each_thread() and
+ * for_each_process_thread() that automatically acquire and release the
+ * RCU read lock via scoped_guard(rcu).  The lock is held for the
+ * duration of the loop and released on exit, including via break,
+ * goto, or return.
+ */
+#define for_each_process_rculock(p) \
+	scoped_guard(rcu) \
+		for (p = &init_task ; (p = next_task(p)) != &init_task ; )
+
+#define for_each_thread_rculock(p, t) \
+	scoped_guard(rcu) \
+		__for_each_thread((p)->signal, t)
+
+/*
+ * Double loop: 'break' only exits the inner for_each_thread() loop.
+ * Use 'goto' to exit both loops; the RCU read lock is released
+ * automatically when the scoped_guard scope is left.
+ */
+#define for_each_process_thread_rculock(p, t) \
+	scoped_guard(rcu) \
+		for_each_process(p) \
+			for_each_thread(p, t)
+
 typedef int (*proc_visitor)(struct task_struct *p, void *data);
 void walk_process_tree(struct task_struct *top, proc_visitor, void *);
 
-- 
2.25.1

