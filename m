Received: from mta0.migadu.com (out-113.mta0.migadu.com [91.218.175.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09CA3803C3
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113662; cv=none; b=KvXnufpvHst9tBzdVWbBpQyOnzojS9dDNKa/+t2HuoKqr94kFHRAM5ALc5iOiAmvM+WrP2XzyjWqpijpWt/uhBug2kHlAtAOAJf3megOA0KIH50t235lERWE0oGe3yNvKZgR8plFW0dg63aKTN5W5l2AROWDqhQCdv4r1BZv4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113662; c=relaxed/simple;
	bh=vF8dJvwfO0k4j+Rhq4+Quj7N58x+aoewGF5Ku9uTa1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WA9zceVkt5cU6ShBu7uft3cqVs6dFszFNdLr7a6ByJJVWisO1gAaCKFwWTeupWadSUzcmXtuK2hKiOv14M6bOv3hTvsjm7oWQ4GHDwHzzoenqregEJuDTQYwlisKWnJQZpErybxDBKePHnvhWuUxdrfzNr4+p79hl3YatvptWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A6hbrXjd; arc=none smtp.client-ip=91.218.175.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A6hbrXjd"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vF8dJvwfO0k4j+Rhq4+Quj7N58x+aoewGF5Ku9uTa1M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113658; v=1; x=1789718458;
 b=A6hbrXjdaYwOiLJSDe7TOU9PsjCWf5OW+mLhRmRQxMucHYFrxyHpVebShWu9ekIdqL0jHu83
 TA8an366u9lAd/jZ67vI2+RiKBrsdTjyTFz3XvwcPjegGOcrs3Gv9NmU3ygz50zPPXMnFPI6ASa
 blmtB2Ak94TtPCXxOrLUEMWU=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 92b4a417acb68777;
	Fri, 11 Sep 2026 08:00:58 +0000
X-Mizu-Trace-ID: 92b4a417acb68777
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
	peterz@infradead.org,
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
	gourry@gourry.net,
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
	babu.moger@amd.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 09/15] rcu: convert process/thread iterator to for_each_process_thread_rculock
Date: Fri, 11 Sep 2026 15:57:54 +0800
Message-Id: <20260911075800.491472-10-ye.liu@linux.dev>
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
Changes in v3:
  - Split from kernel/ patch in v2 (Peter Zijlstra, Steven Rostedt)

Changes in v2:
  - Rename *_rcu to *_rculock
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

