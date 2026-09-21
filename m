Received: from mta0.migadu.com (out-212.mta0.migadu.com [91.218.175.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4074246984F
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982623; cv=none; b=ifCGHjXBqSQRs4PUxOUc/3O794GT8KgX4kRl7yZ7dctGLcDl/x5WsIYbAM6ndy8G6GIxlpMNq76kD+koREyCyUWJAex/2MPZjGH3cEiqOkMHU57jBm1va96FF2rtxYY7KIrSYRARJPQgsksBOO8I/BDABOGcOnjADXdba7Z3IvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982623; c=relaxed/simple;
	bh=7BvEFNtRHP1Kn+ktJB3UzR2F40Rkin63WssI085fxec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCPMl+g5GruqRHu5qqut2B0W02R2e7UMZpPCUItvI91l91DqAWb109OXeBZJ5fDy9CDB6y7tCkHjBwa0PtUbkksqj8MN1rUfvcIGXN0KzQpCCAnr/XLV+wBOIXiMAUe7GZxO0l+wxIoHL1ZjvWpb27ESSqsCCBoKh5zWqDyRdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aNL80u/d; arc=none smtp.client-ip=91.218.175.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aNL80u/d"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7BvEFNtRHP1Kn+ktJB3UzR2F40Rkin63WssI085fxec=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789982619; v=1; x=1790587419;
 b=aNL80u/d2xopWc0w5ukYZmXhzLYGrq0EySqesrxN6WairP9Dxruzh1fnrHZf47uyRdgaSdZ9
 45AeJg7NBDWk2IXtOdkMEvqovo1HShggNq/Vez0GuMgc+UsWRt4eQzLEfisti2zoqLkrfQUj5eG
 1XygJB7dl9Z6g7gpP5LCpjLI=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 04c788aff0412b12;
	Mon, 21 Sep 2026 09:23:38 +0000
X-Mizu-Trace-ID: 04c788aff0412b12
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	akpm@linux-foundation.org,
	peterz@infradead.org,
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
Subject: [PATCH v4 09/15] rcu: convert process/thread iterator to for_each_process_thread_rculock
Date: Mon, 21 Sep 2026 17:20:55 +0800
Message-Id: <20260921092101.89285-10-ye.liu@linux.dev>
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
with for_each_process_thread() loop in kernel/rcu/update.c with
for_each_process_thread_rculock(), which scopes the RCU read lock
to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/rcu/update.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 2a778b8ab4ad..d8e0b5896db9 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -548,15 +548,13 @@ void synchronize_rcu_trivial_preempt(void)
 	struct task_struct *t;
 
 	smp_mb(); // Order prior accesses before grace-period start.
-	rcu_read_lock(); // Protect task list.
-	for_each_process_thread(g, t) {
+	for_each_process_thread_rculock(g, t) {
 		if (t == current)
 			continue;  // Don't deadlock on ourselves!
 		// Order later rcu_read_lock() on other tasks after QS.
 		while (smp_load_acquire(&t->rcu_trivial_preempt_nesting))
 			continue;
 	}
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_trivial_preempt);
 #endif // #if IS_ENABLED(CONFIG_TRIVIAL_PREEMPT_RCU)
-- 
2.25.1

