Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120B15AAD3
	for <rcu@vger.kernel.org>; Thu, 11 Jul 2024 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702913; cv=none; b=riuJ64m+JnDAp25Db+6i4XUyvrjMg71MAx8nOX4UuPhYkxbs5KDk6zCYFyaI+6pXxrum+NkBfIoXmf3kftzz1nVaK/I75LfrR3LH8JJKYDmL5uFOOccsNSEabA95FOmZ1fXt/BQNmUOIj2QtGqakity7lplGd52V+WF48oOVl1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702913; c=relaxed/simple;
	bh=kEbqFbMAMRFPsL2Ni9U3GMlxwu2JbJXIf/1GDFAi7j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Knk0X1SyjLZ4l9B+p6EuJOA+EhJMoLJ9UfsMJWCArMioySoWpvddkJrNaqluK1ommH7wv6Y9Y9HO/8ym4b16VgtCyWLPnBZfOYVe0CFBjC16vRJSn3rHy+uObB/IgnGXmFiADFbg1UOewAQDgFkK+JU0CczLC6tx1q8Tx1390lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4Tforgx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4Tforgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720702910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bo6AeZ1jwJY+2L4Z28XS0rJC0wllWNmRErvAYHJbVJg=;
	b=g4TforgxcNNMG6GREnuqwlaZiGqQ37DLsaXtD8/dFAz5+2MuxhI8i6uscDRYWVl75tZS2F
	1+7BvfB8kHc/CcetNcOi8OVOj8CtVTwjCh9FzasTip8l2E0IT9ddM5rn2OeVnk9WxeKJkf
	WF/j4Wnq1tzP20KsroJBn53nMxgM+ZQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-AnhaU64YN2SPdUPPEE27_Q-1; Thu,
 11 Jul 2024 09:01:46 -0400
X-MC-Unique: AnhaU64YN2SPdUPPEE27_Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2102919236B1;
	Thu, 11 Jul 2024 13:01:41 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.211])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1D4119560AA;
	Thu, 11 Jul 2024 13:01:33 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Phil Auld <pauld@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH v3 08/10] sched/fair: Prepare migrate_task_rq_fair() for per-task throttling
Date: Thu, 11 Jul 2024 15:00:02 +0200
Message-ID: <20240711130004.2157737-9-vschneid@redhat.com>
In-Reply-To: <20240711130004.2157737-1-vschneid@redhat.com>
References: <20240711130004.2157737-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Later commits will change CFS bandwidth control throttling from a
per-cfs_rq basis to a per-task basis. This means special care needs to be
taken around any transition a task can have into and out of a cfs_rq.

To ease reviewing, the transitions are patched with dummy-helpers that are
implemented later on.

Add helpers to migrate_task_rq_fair() to cover CPU migration. Even if the
task stays within the same taskgroup, each cfs_rq has its own runtime
accounting, thus the task needs to be throttled or unthrottled
accordingly.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ec4cf7308a586..b2242307677ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5694,8 +5694,11 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 	return cfs_bandwidth_used() && cfs_rq->throttle_count;
 }
 
+static inline bool task_has_throttle_work(struct task_struct *p) { return false; }
 static inline bool task_needs_throttling(struct task_struct *p) { return false; }
+static inline bool task_needs_migrate_throttling(struct task_struct *p, unsigned int dst_cpu) { return false; }
 static inline void task_throttle_setup(struct task_struct *p) { }
+static inline void task_throttle_cancel_migrate(struct task_struct *p, int dst_cpu) { }
 static inline void task_throttle_cancel(struct task_struct *p) { }
 
 /*
@@ -6626,8 +6629,11 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	return 0;
 }
 
+static inline bool task_has_throttle_work(struct task_struct *p) { return false; }
 static inline bool task_needs_throttling(struct task_struct *p) { return false; }
+static inline bool task_needs_migrate_throttling(struct task_struct *p, unsigned int dst_cpu) { return false; }
 static inline void task_throttle_setup(struct task_struct *p) { }
+static inline void task_throttle_cancel_migrate(struct task_struct *p, int dst_cpu) { }
 static inline void task_throttle_cancel(struct task_struct *p) { }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -8308,6 +8314,24 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	se->avg.last_update_time = 0;
 
 	update_scan_period(p, new_cpu);
+
+	if (!cfs_bandwidth_used())
+		return;
+	/*
+	 * When the runtime within a cfs_bandwidth is depleted, all underlying
+	 * cfs_rq's can have (approximately) sched_cfs_bandwidth_slice() runtime
+	 * remaining.
+	 *
+	 * This means all tg->cfs_rq[]'s do not get throttled at the exact same
+	 * time: some may still have a bit of runtime left. Thus, even if the
+	 * task is staying within the same cgroup, and under the same
+	 * cfs_bandwidth, the cfs_rq it migrates to might have a different
+	 * throttle status - resync is needed.
+	 */
+	if (task_needs_migrate_throttling(p, new_cpu))
+		task_throttle_setup(p);
+	else if (task_has_throttle_work(p))
+		task_throttle_cancel_migrate(p, new_cpu);
 }
 
 static void task_dead_fair(struct task_struct *p)
-- 
2.43.0

