Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A95169AE3
	for <rcu@vger.kernel.org>; Thu, 11 Jul 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702935; cv=none; b=iziyWhmZqBpcTzLoSU8dNLYSZ8IOJ9mAc+PgTvlBrW/p7aLxz+HafC8d35+BFVBLPsDrB9Xtu0G0PcKB1uRmmEM1LGCJlGS6FXQz8Jq9NVMdgS488c3PWJTldfJ+ZjL0YLMDB5fchrJYygmjZFx8PIdz7Tq8X6kc4pLGbLHLvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702935; c=relaxed/simple;
	bh=XQg0xC95fqr2rj2jwofKATx4tzAfNoZL3L3ocZIK2Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shrp0ckiOOyVr/RqxVBsdvDRVtIvvG7uOrUjkeAFeIibgGaTxVKemfHvmrQXWClQNniLZ5PUw6RV17DpmvDSsIAfjQkGTSSEcVG9zEAf8UUwPR2gVvy2oqRJ5Mi5/+HhO9WS1F4uNujzic6nbANVJKp+/2Sv9vRQ/gs/gPW0V0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jB/pIpt3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jB/pIpt3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720702932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BecpANArIMV8DYuzp7MuPwP+wsa2agRYjWQ5hatmwiA=;
	b=jB/pIpt3uPfMDsIHiRjs9JR2YjZRlzpF/RrA00y2X9fpyxpjylA9ZtiMxiT5H0qlg6jqP3
	CS5IDIvHky3EYuXBIq9NhoqKbdckb4fHWU1rD+GWtWG3xqA3We7+dSWfDfvmkEfvCUBGAQ
	8LCvFIc7Z1qZNC8OiHvCEMJdkTyssNg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-j3VMWE-ePrmUOpn0P2CXbA-1; Thu,
 11 Jul 2024 09:02:09 -0400
X-MC-Unique: j3VMWE-ePrmUOpn0P2CXbA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43DA11977006;
	Thu, 11 Jul 2024 13:02:04 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.211])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A6D51955E9F;
	Thu, 11 Jul 2024 13:01:41 +0000 (UTC)
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
Subject: [RFC PATCH v3 09/10] sched/fair: Add a class->task_woken callback in preparation for per-task throttling
Date: Thu, 11 Jul 2024 15:00:03 +0200
Message-ID: <20240711130004.2157737-10-vschneid@redhat.com>
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

Add a class->task_woken callback to handle tasks being woken into
potentially throttled cfs_rq's. Conversely, a task flagged for
throttle-at-kernel-exit may block and need to have its pending throttle
removed if runtime was replenished by the time it got woken up.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b2242307677ca..0cec3e70f1277 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5776,6 +5776,17 @@ static void task_throttle_cancel_irq_work_fn(struct irq_work *work)
        /* Write me */
 }
 
+static void task_woken_fair(struct rq *rq, struct task_struct *p)
+{
+	if (!cfs_bandwidth_used())
+		return;
+
+	if (task_needs_throttling(p))
+		task_throttle_setup(p);
+	else
+		task_throttle_cancel(p);
+}
+
 void init_cfs_throttle_work(struct task_struct *p)
 {
 	/* Protect against double add, see throttle_cfs_rq() and throttle_cfs_rq_work() */
@@ -13288,6 +13299,10 @@ DEFINE_SCHED_CLASS(fair) = {
 	.task_change_group	= task_change_group_fair,
 #endif
 
+#ifdef CONFIG_CFS_BANDWIDTH
+	.task_woken             = task_woken_fair,
+#endif
+
 #ifdef CONFIG_SCHED_CORE
 	.task_is_throttled	= task_is_throttled_fair,
 #endif
-- 
2.43.0

