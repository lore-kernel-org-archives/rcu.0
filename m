Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6C116D4EF
	for <rcu@vger.kernel.org>; Thu, 11 Jul 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702855; cv=none; b=mRZSLT8f3WI2H5968a/y4nWdmS4zEgInRNoy0/TChs0AMrKZG0TrE5Kw8EjVnqs350FIezqGhcTwJC8ZDlvba/PLgyn5S0YiLhJpYorv4EWQFHPPhy6U68njzpPx2/7qtxQN1uOOGf84qDMzOj0aYeq/t2YU07rrHqgWKjhSOqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702855; c=relaxed/simple;
	bh=Hm0+dnUQgdDJ2/S65Ewj7D0wEhScphLNn2S7aBT0XyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dm8b2tlQg9O9fqfIJBxFogi2ZUdE8/Y+M8l/vxcLoZLyoz2c9bVBMMAbbChU36kWzvOD61jOIj5rP5G/dMMr4XqUFcCNNvmv3x76gyf3Q9VJelyU9iGv9/3DvkG/34Qdb+NnVcJ5ydMk6XjUmvBry6OQM0bhVRKmykxORIUZyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxyK8Q+s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxyK8Q+s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720702853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nRgFpOHXJvT1VsZdQomT7n0zMUPrGpb3Ck/7bQmJ6Jw=;
	b=LxyK8Q+s7w+g2LIp6EkzB+1KpwWqNCvRvRo8RVznwY2aothzC//L/iQ5a335dKOwrT8iKA
	mP3cjTA2TrrDXY6Q0OofG3y1LG+TspREWglct6YJwPtaA/YDHIggtEyvjQnNk9vlHapdBL
	qrFam2cPVVA90OHxn2/kdggV0eINqvM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-Jyvz4PdnPuuvvJoEd6C6YA-1; Thu,
 11 Jul 2024 09:00:46 -0400
X-MC-Unique: Jyvz4PdnPuuvvJoEd6C6YA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B036419772E0;
	Thu, 11 Jul 2024 13:00:36 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.211])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 640B11955EAF;
	Thu, 11 Jul 2024 13:00:27 +0000 (UTC)
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
Subject: [RFC PATCH v3 00/10] sched/fair: Defer CFS throttle to user entry
Date: Thu, 11 Jul 2024 14:59:54 +0200
Message-ID: <20240711130004.2157737-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi folks,

The patches are based on top of tip/sched/core at:
  db43a609d01e ("sched: Update MAINTAINERS and CREDITS")
They are also available at:
  https://gitlab.com/vschneid/linux.git -b mainline/sched/fair/throttle-on-exit-all-v2

Problem statement
=================

CFS tasks can end up throttled while holding locks that other, non-throttled
tasks are blocking on.

For !PREEMPT_RT, this can be a source of latency due to the throttling causing a
resource acquisition denial.

For PREEMPT_RT, this is worse and can lead to a deadlock:
o A CFS task p0 gets throttled while holding read_lock(&lock)
o A task p1 blocks on write_lock(&lock), making further readers enter the
  slowpath
o A ktimers or ksoftirqd task blocks on read_lock(&lock)

If the cfs_bandwidth.period_timer to replenish p0's runtime is enqueued on
the same CPU as one where ktimers/ksoftirqd is blocked on read_lock(&lock),
this creates a circular dependency.

This has been observed to happen with:
o fs/eventpoll.c::ep->lock
o net/netlink/af_netlink.c::nl_table_lock (after hand-fixing the above)
but can trigger with any rwlock that can be acquired in both process and
softirq contexts.

The linux-rt tree has had
  1ea50f9636f0 ("softirq: Use a dedicated thread for timer wakeups.")
which helped this scenario for non-rwlock locks by ensuring the throttled
task would get PI'd to FIFO1 (ktimers' default priority). Unfortunately,
rwlocks cannot sanely do PI as they allow multiple readers.

Proposed approach
=================

Peter mentioned [1] that there have been discussions on changing /when/ the
throttling happens: rather than have it be done immediately upon updating
the runtime statistics and realizing the cfs_rq has depleted its quota, we wait
for the task to be about to return to userspace: if it's in userspace, it can't
hold any in-kernel lock.

Ben Segall proposed a different approach [2] which I worked on at [3], but I
eventually lost faith in all the .*nr_running hackery that it required.
Furthermore, talking about this at OSPM24, I felt like the first approach had
more appeal, so guess who's back (back again).

See the last patch for implementation considerations.

I've tried splitting this into as many bite-size patches as possible, but it's
tricky to further split that one last patch switching from cfs_rq-wide throttling
to per-task throttling, apologies for the big diff.

Testing
=======

Tested on QEMU via the below with the usual DEBUG options enabled.

  mount -t cgroup -o cpu none /root/cpu

  mkdir /root/cpu/cg0
  echo 10000 >  /root/cpu/cg0/cpu.cfs_period_us
  echo 1000 > /root/cpu/cg0/cpu.cfs_quota_us

  mkdir /root/cpu/cg0/cg00
  mkdir /root/cpu/cg0/cg01

  mkdir /root/cpu/cg0/cg00/cg000
  mkdir /root/cpu/cg0/cg00/cg001

  spawn() {
      while true; do cat /sys/devices/system/cpu/smt/active &>/dev/null; done &
      PID=$!
      echo "Starting PID${PID}"
      echo $PID > $1
  }

  spawn cpu/cg0/tasks
  spawn cpu/cg0/tasks
  spawn cpu/cg0/tasks
  spawn cpu/cg0/tasks

  spawn cpu/cg0/cg01/tasks

  spawn cpu/cg0/cg00/cg000/tasks
  spawn cpu/cg0/cg00/cg001/tasks

  sleep 120

  kill $(jobs -p)  

I've also looked at the PELT side of things using rt-app + LISA. The PELT behaviour
itself looks mostly the same, but the execution patterns change, again see last
patch for details.
  
Links
=====
  
[1]: https://lore.kernel.org/lkml/20231031160120.GE15024@noisy.programming.kicks-ass.net/
[2]: http://lore.kernel.org/r/xm26edfxpock.fsf@bsegall-linux.svl.corp.google.com
[3]: https://lore.kernel.org/lkml/20240202080920.3337862-1-vschneid@redhat.com/

Valentin Schneider (10):
  rcuwait: Split type definition to its own header
  irq_work: Split type definition to its own header
  task_work, sched: Add a _locked variant to task_work_cancel()
  sched/fair: Introduce sched_throttle_work
  sched/fair: Introduce an irq_work for cancelling throttle task_work
  sched/fair: Prepare switched_from & switched_to for per-task
    throttling
  sched/fair: Prepare task_change_group_fair() for per-task throttling
  sched/fair: Prepare migrate_task_rq_fair() for per-task throttling
  sched/fair: Add a class->task_woken callback in preparation for
    per-task throttling
  sched/fair: Throttle CFS tasks on return to userspace

 include/linux/irq_work.h       |   8 +-
 include/linux/irq_work_types.h |  14 +
 include/linux/rcuwait.h        |   9 +-
 include/linux/rcuwait_types.h  |  16 ++
 include/linux/sched.h          |   6 +
 kernel/sched/core.c            |   4 +
 kernel/sched/fair.c            | 497 +++++++++++++++++++++++++--------
 kernel/sched/sched.h           |   6 +
 kernel/sched/task_work_sched.h |  14 +
 kernel/task_work.c             |  67 ++++-
 10 files changed, 499 insertions(+), 142 deletions(-)
 create mode 100644 include/linux/irq_work_types.h
 create mode 100644 include/linux/rcuwait_types.h
 create mode 100644 kernel/sched/task_work_sched.h

--
2.43.0

