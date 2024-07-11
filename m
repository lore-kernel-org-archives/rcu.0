Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95316DC2B
	for <rcu@vger.kernel.org>; Thu, 11 Jul 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702895; cv=none; b=Fi/z+dY5cw7C2wXmTA+7/yYNkylaizEFlfbTFYEQLFA+NEcveRpJT1jSga4BxoWL+wqLoqxGz9MEFX5ddV0VuO5GqK3H/msuXf/d8FV2Q4Ml1p/oG2shDQfiSHjxQegt2YuPSU1PNjishtv6uAhdPUWsHwVi+7nB53KXBY7BLd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702895; c=relaxed/simple;
	bh=8ueQdFLG87p+qfy4yt6xngF+VdvTIn2SFkuPJ3FVakA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vg6xrPCBxbDHoTSn0nok4qKdmeIOpngiaJUPoYHl+/etz/F+v/JPndn9twjhp51spuktLNg4nAEp+xSh5OQRXkvDUMNlwHHEOEn/V3GxisM9EY//SxP+c6IbFm5TrMo4MDYlko/KpH/OVwQx0XPw03LxmY5PIrIoEGQD+il/aaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnS/AEfI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnS/AEfI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720702892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYNML39erjHIQYIq2MzxI1f2C9g8cKZz+w3h5LIB8k4=;
	b=YnS/AEfID74W0dSUJ4M4g2Pr7GTdi3RBUQQBV1npdH4oRG6jLAXwIqdjls5FJI9OhqdRU5
	QtWSWsqKUs2ZQ4a70b5+bYTRllUfcu6h1Gws1kuKpgS+poTvT78KDZz1UjhOLCntzP/jXW
	2BwW5p0catHSlUdljzzIA/kmw0nCHNI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-jRWigaaEPvK4-17APSOBkg-1; Thu,
 11 Jul 2024 09:01:29 -0400
X-MC-Unique: jRWigaaEPvK4-17APSOBkg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 403CE1954B0C;
	Thu, 11 Jul 2024 13:01:18 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.211])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EACDC1955E9F;
	Thu, 11 Jul 2024 13:01:10 +0000 (UTC)
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
Subject: [RFC PATCH v3 05/10] sched/fair: Introduce an irq_work for cancelling throttle task_work
Date: Thu, 11 Jul 2024 14:59:59 +0200
Message-ID: <20240711130004.2157737-6-vschneid@redhat.com>
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

Moving towards per-task throttling, the soon-to-be task_work used for the
actual throttling will need to be cancelled when a task is moving out of a
throttled cfs_rq and into a non-throttled cfs_rq (or out of CFS
altogether).

Such code paths will have at least the rq lock held, sometimes both the rq
and the p->pi_lock locks held. Functions such as migrate_task_rq_fair()
don't have guarantees as to which of the two is held, as such the
cancellation will need to happen in a separate context.

It will be punted to irq_work context, the groundwork is added here and the
irq_work callback will be implemented when switching to per-task
throttling.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/sched.h | 4 ++++
 kernel/sched/fair.c   | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a4976eb5065fc..99a1e77d769db 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -46,6 +46,7 @@
 #include <linux/livepatch_sched.h>
 #include <linux/uidgid_types.h>
 #include <asm/kmap_size.h>
+#include <linux/irq_work_types.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -813,6 +814,9 @@ struct task_struct {
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
 	struct callback_head            sched_throttle_work;
+#ifdef CONFIG_CFS_BANDWIDTH
+	struct irq_work                 unthrottle_irq_work;
+#endif
 #endif
 
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 775547cdd3ce0..095357bd17f0e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5764,11 +5764,17 @@ static void throttle_cfs_rq_work(struct callback_head *work)
 
 }
 
+static void task_throttle_cancel_irq_work_fn(struct irq_work *work)
+{
+       /* Write me */
+}
+
 void init_cfs_throttle_work(struct task_struct *p)
 {
 	/* Protect against double add, see throttle_cfs_rq() and throttle_cfs_rq_work() */
 	p->sched_throttle_work.next = &p->sched_throttle_work;
 	init_task_work(&p->sched_throttle_work, throttle_cfs_rq_work);
+	p->unthrottle_irq_work = IRQ_WORK_INIT_HARD(task_throttle_cancel_irq_work_fn);
 }
 
 static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
-- 
2.43.0

