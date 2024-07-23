Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107C158D86
	for <rcu@vger.kernel.org>; Tue, 23 Jul 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758271; cv=none; b=tcrjQbpL0T3KaC99teQOr3W2aOeTElbu7hlt/98tuRaDEkHfYGRrYx5/tujz72Z+x6ZQx65C7jZ0FuUYcIq8q/a2vPS3KNTyiLwDOlAbaPsL4wcq6U64zJGnKPs8GUAFme/pwgFpSVa/FGiyVj2CtbL3+mPRFgvXgnypAnKtHUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758271; c=relaxed/simple;
	bh=VRBTGVO9finuATEk7IeKaKm67Vfc4trallaTRuvxj0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inOfbptB9bL+MGKmJbnYMvHlcbwfn1EauQz5q+OpMQsYq5CoJHFpPQG8wvOt8RiDPtGF+DjXVJzJzvOQreATztxBDW0TWGb7v5EGdTf16LTXZror7R04xySXSohuKnUa/2EhJDZCcKFuzNiF9H2i5CmHhxISD66kexG5HN+BU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TeO67aWx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeO67aWx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721758268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ffMpgOtmXBm5a0CfOpLwlrEzFuWrHbIAzPb58NyTvMU=;
	b=TeO67aWxq6D2P5ESjesT5v24rTd3hNgT6uOgtxx8WyFA/VM2vA9tddb/eWCRLFWq2nT6HO
	m7VulfkTISuWEV4eKYycKbwhFETOe9vNY57wyO39UhIvQLboypvwRJuA0Sc0ew/DQObvGB
	w+RiAvxb54UWxbknSYWMhli9k2/C8+Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-1qFj8Yq0PJOa3RqrCV5low-1; Tue,
 23 Jul 2024 14:11:04 -0400
X-MC-Unique: 1qFj8Yq0PJOa3RqrCV5low-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 996131955D42;
	Tue, 23 Jul 2024 18:11:02 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.107])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 072BC1955E7D;
	Tue, 23 Jul 2024 18:10:58 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vratislav Bendel <vbendel@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] rcu: Use system_unbound_wq to avoid disturbing isolated CPUs
Date: Tue, 23 Jul 2024 14:10:25 -0400
Message-ID: <20240723181025.187413-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

It was discovered that isolated CPUs could sometimes be disturbed by
kworkers processing kfree_rcu() works causing higher than expected
latency. It is because the RCU core uses "system_wq" which doesn't have
the WQ_UNBOUND flag to handle all its work items. Fix this violation of
latency limits by using "system_unbound_wq" in the RCU core instead.
This will ensure that those work items will not be run on CPUs marked
as isolated.

Beside the WQ_UNBOUND flag, the other major difference between system_wq
and system_unbound_wq is their max_active count. The system_unbound_wq
has a max_active of WQ_MAX_ACTIVE (512) while system_wq's max_active
is WQ_DFL_ACTIVE (256) which is half of WQ_MAX_ACTIVE.

Reported-by: Vratislav Bendel <vbendel@redhat.com>
Closes: https://issues.redhat.com/browse/RHEL-50220
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/rcu/tasks.h | 4 ++--
 kernel/rcu/tree.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..494aa9513d0b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3539,10 +3539,10 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 	if (delayed_work_pending(&krcp->monitor_work)) {
 		delay_left = krcp->monitor_work.timer.expires - jiffies;
 		if (delay < delay_left)
-			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
+			mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
 		return;
 	}
-	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
+	queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
 }
 
 static void
@@ -3634,7 +3634,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
 		}
 	}
 
@@ -3704,7 +3704,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
 		if (atomic_read(&krcp->backoff_page_cache_fill)) {
-			queue_delayed_work(system_wq,
+			queue_delayed_work(system_unbound_wq,
 				&krcp->page_cache_work,
 					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
 		} else {
-- 
2.43.5

