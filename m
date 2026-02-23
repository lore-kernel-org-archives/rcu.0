Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322843793CD;
	Mon, 23 Feb 2026 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879471; cv=none; b=u8Hrs1HVvwWsfoKyX1LanS2LP/rcvzGJ6xjVliwb00ZO27w99EB3DizjGfYyCwno4vqCVpVhUuJL1ytCE5OJM345JyhC0ZtU0868atFxBxYlPiT5XkqtvQNm8UxL5ytcwy8hZD4qkyBTApn+TAKsZ6UUxeZOrAia81EP2p+q8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879471; c=relaxed/simple;
	bh=g+FaGF4g9w6n1f27Rf1cUEUGTAf2ELZ5LZvlfDFrTtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t0qpKpBP/vXQXPgX6KN1YHYqGjBatKdrbMfC8pv8uzlOxAbb13MJinmVPB/zchhHZk59Xnuis1bMUn0N24Snj/CzYcv6UClNkVFDptRWtSZCPwsb+RG0d2uTZwAX/mbaaZ13RLbBvZYB+81Pyum1uUXzehQGcjvKBGhLDRL8MwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=g58SLHS1; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="g58SLHS1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1771879461;
	bh=LzrTBUBA9Xan0G/6dErkCnhzk9YByLdnZjMaMmM4OD0=;
	h=From:To:Cc:Subject:Date:From;
	b=g58SLHS1WmcC/+tCAn/vwRtUYUR4EZ2G+eGA0Mm7zzs/IussNdmSyMeyLoFZ8Kn5F
	 XUB8ixuMvQDjZaYpxqzzezrqkImKDTttx9YQoKIjKaKPjnGjs5uzSDK+YAQkiC71GY
	 BmOkvqpJ3JwovwqCqCS2uQv3mEuylEA9nRYly6n8Bmnes8Tvn8rDlkdNhws98NBd1A
	 RTiIB4o0E7k8/t1nxbZRt3EbxASXbrj5kyNFLitbO/fv0kggeeqvHQUSvk4hXXoRI8
	 1UbdHbXT1gXNPgJS7Q6xvrSwmo9FU/uz2qS4XZRnF1HL2GRcQJeGbT7pKzYWa/yEl+
	 T1yceLaLrW/jA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4fKXs10WhhzGXN;
	Mon, 23 Feb 2026 15:44:21 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
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
Subject: [RFC PATCH v5 0/2] Hazard Pointers
Date: Mon, 23 Feb 2026 15:44:16 -0500
Message-Id: <20260223204418.1429025-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is a v5 of my Hazard Pointers series. I know Boqun has a use case
for it for lockdep.

This new version has those significant changes since v4:

- Fold scheduler integration.
- Actually set ctx slot to backup slot on context switch.
- Remove CONFIG_PREEMPT_HAZPTR config option.
- Use per-cpu ctx pointers for context switch slot tracking
  rather than per-task lists. This accelerates the hazptr
  acquire/release fast-path.
- Guarantee scan forward progress with two-lists scheme.
- Reimplement the hazptr acquire with a temporary wildcard
  to eliminate a dependency on the addr_p load, likely to
  cause a pipeline stall due to the needed memory barrier.
  This simplifies the algorithm, removes the need for pointer
  re-load + comparison, and is expected to be faster on some
  architectures.
- Reduce number of percpu slots to 4, introduce a hazptr_slot_item
  struct to contain both the slot and ctx pointers. Reducing number
  of slots to 4 makes sure all the slot and ctx pointers fit in a
  single cache line.
- Rebased on v7.0-rc1.

Feedback is welcome,

Thanks,

Mathieu

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: John Stultz <jstultz@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
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

Mathieu Desnoyers (2):
  hazptr: Implement Hazard Pointers
  hazptr: Add refscale test

 include/linux/hazptr.h | 197 +++++++++++++++++++++++++++++++++
 init/main.c            |   2 +
 kernel/Makefile        |   2 +-
 kernel/hazptr.c        | 242 +++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/refscale.c  |  43 ++++++++
 kernel/sched/core.c    |   2 +
 6 files changed, 487 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/hazptr.h
 create mode 100644 kernel/hazptr.c

-- 
2.39.5
