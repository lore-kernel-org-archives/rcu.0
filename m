Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E53E16DC1E
	for <rcu@vger.kernel.org>; Thu, 11 Jul 2024 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702894; cv=none; b=qWR56AlRUdmxieIZzWj9eLthyUOQDBC0FDmk+sIAJ5ZUpFHTwD9jy/RvFfKjOv6kVVIAH5zYyvxvQdJjpaBuAwnN6g1/T0p9rbraDYAlbxc6fGd44zNyem2cTin+plL7MGsMIs+dfBW/aIQ5ce4+d3q9EKV9WchiiIX6crVPrIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702894; c=relaxed/simple;
	bh=j+9voxVbkXLZex9aF3BIDI+OpqtDuigja9qnrW3CW7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEZLBIlSiET6+3HegsuJ/rCtBhZsRU96gryY5S9cZw0x8joGdp67kevejZ0aNOo0gfgCMwlX8uwwpsdTjwYJ8Dd5xlD8NeuHZRZeAOEpwVMlS4ooauQde/7G1xy3TrOkSbWvLl4XoubgbhxPC78ptkv6OJRO9wwkX1NOXsb6QAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDQfY8Nq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDQfY8Nq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720702891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39lyjke0SXVRF7E8CxU/t0CTJvnKYmxII1z60vz/0qI=;
	b=DDQfY8NquneqW1+NZShZr0kGENS5fR6RWCJ4ZJQxkeWdCYvGwzx1skJ+Oq6ezqKsh+ZIk9
	HzFh33xclJUHbhct1Lfvl8vvN/YkyK9MuLso0mQoiiA8FuO0ZHBDx1SJBKEMuaX9dGvSwh
	p1mFspASlvhLTdX5UxNq88OSzXU6B4Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-4VTRME0cO9a6HJIqgaBDrA-1; Thu,
 11 Jul 2024 09:01:29 -0400
X-MC-Unique: 4VTRME0cO9a6HJIqgaBDrA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF9721953966;
	Thu, 11 Jul 2024 13:01:25 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.211])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A1F2195606C;
	Thu, 11 Jul 2024 13:01:18 +0000 (UTC)
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
Subject: [RFC PATCH v3 06/10] sched/fair: Prepare switched_from & switched_to for per-task throttling
Date: Thu, 11 Jul 2024 15:00:00 +0200
Message-ID: <20240711130004.2157737-7-vschneid@redhat.com>
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

Add helpers to switched_from_fair() and switched_to_fair() to cover class
changes. If switching from CFS, a task may need to be unthrottled. If
switching to CFS, a task may need to be throttled.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095357bd17f0e..acac0829c71f3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5694,6 +5694,10 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 	return cfs_bandwidth_used() && cfs_rq->throttle_count;
 }
 
+static inline bool task_needs_throttling(struct task_struct *p) { return false; }
+static inline void task_throttle_setup(struct task_struct *p) { }
+static inline void task_throttle_cancel(struct task_struct *p) { }
+
 /*
  * Ensure that neither of the group entities corresponding to src_cpu or
  * dest_cpu are members of a throttled hierarchy when performing group
@@ -6622,6 +6626,10 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	return 0;
 }
 
+static inline bool task_needs_throttling(struct task_struct *p) { return false; }
+static inline void task_throttle_setup(struct task_struct *p) { }
+static inline void task_throttle_cancel(struct task_struct *p) { }
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent) {}
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
@@ -12847,11 +12855,15 @@ static void attach_task_cfs_rq(struct task_struct *p)
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
+	if (cfs_bandwidth_used())
+		task_throttle_cancel(p);
 }
 
 static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
 	attach_task_cfs_rq(p);
+	if (cfs_bandwidth_used() && task_needs_throttling(p))
+		task_throttle_setup(p);
 
 	set_task_max_allowed_capacity(p);
 
-- 
2.43.0

