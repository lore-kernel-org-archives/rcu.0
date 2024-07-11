Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56D16E864
	for <rcu@vger.kernel.org>; Thu, 11 Jul 2024 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702909; cv=none; b=g8ovhRdrRLjtBZaBXb6Rc6KzQMkPBnClPUxoh+PvTi9UiXANevUgUtvratsVUM3iUJP69iuUrV+GK/7hTVQV7Pg3ZXkQkrUuCJfghogY4KcT1YLFwvlDIn1em5ChkRCxBzytUmZpUJ1KaFksKZiif2WLPBK3Q23UIrwPgJIqHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702909; c=relaxed/simple;
	bh=3hQTshq3j/pEAuKohadW5LUjN4RXbzUfNWbS/gaH5rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyUCwIvCrkTokphuGro8Ko/YbWtVFSGeZARcW9M6GlSEZQXU5kO6B/DD0ocaDbZlqwTj5AMJBF7BiCNhPlfWXGtHULp8jWtR6Yof6r59nQGU8ycqFROSVHzIVhPZF+rbMc2Ja+5I5wMU7E4YKulcsyqK04vFJ1Vz/RsHqXBcWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJHOr+p9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJHOr+p9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720702907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ8G2jooOuhKMZEVaAQ+rNv5KFn8ERDELUo5S05OR5Q=;
	b=TJHOr+p9M2RM+9b2Fu1C7m7km2wQ47GwHAP/A5A9EvJNo4qtYr/yn10DHVOLQ0OnHITNrr
	kUt4V+SpBRCpJBdqs0FIqhO2qS79xKc/uMfkLSZg/M4Tp1FxyNvByjcV1Yjj8SGPfJIOll
	yZAKZqXkr8BetQpypp02uJx5/bZISHY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-6BOpIVidMVuPnBl-0JpA5w-1; Thu,
 11 Jul 2024 09:01:40 -0400
X-MC-Unique: 6BOpIVidMVuPnBl-0JpA5w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E81F1944B3E;
	Thu, 11 Jul 2024 13:01:33 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.211])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23CF61956066;
	Thu, 11 Jul 2024 13:01:25 +0000 (UTC)
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
Subject: [RFC PATCH v3 07/10] sched/fair: Prepare task_change_group_fair() for per-task throttling
Date: Thu, 11 Jul 2024 15:00:01 +0200
Message-ID: <20240711130004.2157737-8-vschneid@redhat.com>
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

Add helpers to task_change_group_fair() to cover CPU cgroup
migration. If changing to a throttled taskgroup/cfs_rq, the task needs to
be throttled. Conversely, if the task is already throttled but changing to
a taskgroup/cfs_rq that still has some runtime, the task must be unthrottled.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index acac0829c71f3..ec4cf7308a586 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12935,6 +12935,14 @@ static void task_change_group_fair(struct task_struct *p)
 #endif
 	set_task_rq(p, task_cpu(p));
 	attach_task_cfs_rq(p);
+
+	if (!cfs_bandwidth_used())
+		return;
+
+	if (task_needs_throttling(p))
+		task_throttle_setup(p);
+	else
+		task_throttle_cancel(p);
 }
 
 void free_fair_sched_group(struct task_group *tg)
-- 
2.43.0

