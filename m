Received: from mta0.migadu.com (out-18.mta0.migadu.com [91.218.175.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C8F450415
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982501; cv=none; b=p5jIBCEmq5vre1PHfuKPN0X48CXqPo+zHfyXRn35p38Pjq0uU0yuxuvKLxm2ELKSc40CI77DDqn8jiJqH0j+WP2Jau8icB0pzuEGs2Q/SjxEDH/tuvtkdoNEEG6/OPVwK+qbBegLu4DTWz/SySWCitjpFMO0A9fhSVXF17aRKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982501; c=relaxed/simple;
	bh=deuDjh4KY/glu2qz4/gRNLs6D8kmr7YlUzYiZcAnK9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uRL7Pim6FBejnf2RUWipy31DjaQK/8eJl9z0m5gJ7RgiizeGnRe5lJbRnc6hHaRogXKVEbIGbLa7kf+aJUhqGtOa68ucYj7IbEUSwencxnJOczPmEHnhBgNZsA43itf6oHWQ2j8JkBmeo1vMyOH/TXCbDTqM+8L4WOrK0W9eo5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hn0kkM5t; arc=none smtp.client-ip=91.218.175.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hn0kkM5t"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=deuDjh4KY/glu2qz4/gRNLs6D8kmr7YlUzYiZcAnK9k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789982497; v=1; x=1790587297;
 b=Hn0kkM5t0LQGesojiXX8pLshJw36jegkjkCKaGlgNu2xCAE4WaKEhUgUckbHz/Xvy0O5TSDF
 YwFM1v2sQSvWzgCsRc2OJgnU4bm6GyU9TGNpZdaK/ACJJ1lxpYJwPtUNpw9wiaoGP68wqjp3N21
 yN+1G4ZWXyfYrwGBN41dGcMY=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8d62996ef121fa9e;
	Mon, 21 Sep 2026 09:21:36 +0000
X-Mizu-Trace-ID: 8d62996ef121fa9e
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christian Brauner <brauner@kernel.org>,
	Ye Liu <liuye@kylinos.cn>
Cc: Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	akpm@linux-foundation.org,
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
Subject: [PATCH v4 01/15] sched: introduce for_each_process_rculock and for_each_thread_rculock
Date: Mon, 21 Sep 2026 17:20:47 +0800
Message-Id: <20260921092101.89285-2-ye.liu@linux.dev>
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

