Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C753C2F;
	Thu, 18 Dec 2025 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022344; cv=none; b=PXkvwpb9nAFExoasbYc4DB0skwZWdRQCtUIH4XiYRSk2M2f4apSd7/XIFykrexcpHsxk3aMLynZtKXg/xmW/HHN7meSjEv1xkQ2ByMz1j1/LsyTROZALwNnHGTPaWcjpdTy2wR4rawV2aTMTc2RgtnbJ85q/FdmUXFqt/Tl3JjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022344; c=relaxed/simple;
	bh=dHQOIdr80bIHg/3MJYLSrGSJkKabRTEpNIxZeMkAs7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fzk0VzEsI8xWCbtIkdtaMlD1B6vW4SFD4cBLNl3tKCQcwQ4dW+zYq0UDluqCvpcQs5mSSQ1S3zx7DD/oWA8wlt3OQrc1FWbVX5adxrMwdY7naFoRmCZV0owEge9Y7l2uNM+6j/TMDK9G4vEcNeKIASgje80+QMXfzbPtu7iyysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=E7da4dWj; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="E7da4dWj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1766022335;
	bh=R75Ozd7LaHo642pj4EdBSiV+wVzhB/Yr8urL4+DdIig=;
	h=From:To:Cc:Subject:Date:From;
	b=E7da4dWjePDgirJQpNDti55t4Lvfx7Jf81vQ36+CkIqgj9MB63WkMUWZyFQ4l1Z+R
	 fAahGYiBnYSMLbCrrkBDJ6ZjD7ZmXcT4ysvYn/d8WL5Cp84REXy/j6nLFDqEE1hYfZ
	 7HiwNvgnYjRhN05J51pvo6tSE603MTAPaFVZn8ANCAHtT3lsS1YvEiHihrhFMmnqcQ
	 8x4/LqCVunc/980kQhAzne7oIli2Lh8Rz/joV08o9AtRTTAi470vfVVLK4AgYrLA2Y
	 qQKX2wXJsJvbB4Cer/pu1bI7rx+VXl6NmGvluTrGJGf2eHLq4J4nLIfI0ZQZwT0kZL
	 ks/6qo8Hku2gA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:a253:d09e:90e7:323f])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4dWtlz1TCCzbmj;
	Wed, 17 Dec 2025 20:45:35 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@lists.linux.dev
Subject: [RFC PATCH v4 0/4] Hazard Pointers
Date: Wed, 17 Dec 2025 20:45:27 -0500
Message-Id: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here is a revisited version of my Hazard Pointers series. Boqun, Joel,
if you guys have time to try it out with your use-cases it would be
great!

This new version does the following:

- It has 8 preallocated hazard pointer slots per CPU (one cache line),
- The hazard pointer user allocates a hazard pointer context variable
  (typically on the stack), which contains the pointer to the slot *and*
  a backup slot,
- When all the per-CPU slots are in use, fallback to the backup slot.
  Chain the backup slot into per-CPU lists, each protected by a raw
  spinlock.
- The hazard pointer synchronize does a piecewise iteration on the
  per-CPU overflow slots lists, releasing the raw spinlock between
  each list item. It uses a 64-bit generation counter to check for
  concurrent list changes, and restart the traversal on generation
  counter mismatch.
- There is a new CONFIG_PREEMPT_HAZPTR config option. When enabled,
  the hazard pointer acquire/release adds and then removes the hazard
  pointer context from a per-task linked list. On context switch, the
  scheduler migrates the per-CPU slots used by the task to the backup
  per-context slots, thus making sure the per-CPU slots are not used
  by preempted and blocked tasks.

It is based on v6.18.1.

Review is very welcome,

Thanks,

Mathieu

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: John Stultz <jstultz@google.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang.zhang1211@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: maged.michael@gmail.com
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: rcu@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: lkmm@lists.linux.dev

Mathieu Desnoyers (4):
  compiler.h: Introduce ptr_eq() to preserve address dependency
  Documentation: RCU: Refer to ptr_eq()
  hazptr: Implement Hazard Pointers
  hazptr: Migrate per-CPU slots to backup slot on context switch

 Documentation/RCU/rcu_dereference.rst |  38 +++-
 include/linux/compiler.h              |  63 +++++++
 include/linux/hazptr.h                | 241 ++++++++++++++++++++++++++
 include/linux/sched.h                 |   4 +
 init/init_task.c                      |   3 +
 init/main.c                           |   2 +
 kernel/Kconfig.preempt                |  10 ++
 kernel/Makefile                       |   2 +-
 kernel/fork.c                         |   3 +
 kernel/hazptr.c                       | 150 ++++++++++++++++
 kernel/sched/core.c                   |   2 +
 11 files changed, 512 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/hazptr.h
 create mode 100644 kernel/hazptr.c

-- 
2.39.5
