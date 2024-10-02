Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11DC1FA4;
	Wed,  2 Oct 2024 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831088; cv=none; b=dwThXYwPCc0UTrrg02v7Y20jIj4wL5Dv0WxYjyqn3A6HRB7rhXzal/sq/TKL5sonsC0YbnB5Dg5vi9PV9qHEFk5dsBMonOF7w0LXwjYpnOLQBs38Cpf3Erb25rN4m4xbzYYRtAOpWMDsOsgsOvjO2zpjXxpyXHxE43+RS4DJxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831088; c=relaxed/simple;
	bh=J51FMx4u1uRwSJbEetHZdnjtpXGbFPkERKfeCfiiqus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mm44jnugkvLqoukol8RNeEBOkTx2SlAk65urcZTtDe3G7TvNDzZSqCBtynwLkiFqb2LVpQO9GfT5kOPhQDN0IEhsKcJzVdhPEp3e7kklwMirI0i1zZgHgEI524MQ3R9LqvJd0V6GkEO8H6XzwZZXaT/F0yw8UqQnG4tnaXJgbBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=TGhD7H5X; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TGhD7H5X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727831079;
	bh=J51FMx4u1uRwSJbEetHZdnjtpXGbFPkERKfeCfiiqus=;
	h=From:To:Cc:Subject:Date:From;
	b=TGhD7H5XV7sXJ2UOhd0QN1oCgZ4X3l3FJkSwgCDmK2mSObo/ze5XmJ4d8HPy9YAo/
	 vNyCiu3tAQQyRumTv0VJ8b7L6Q3X+NK6Voe62j22Mh+BlMxyB75hk8bKvUOQnVfBwK
	 HhRhBBhe17phxfKic1PIy0jpLfY0a5g5TVS72Rcslgj2e2gx6emKYi1ErXgxGL6o/d
	 h5E1+a94T0qou4+pMkXA6n6vg/aAiummFJKDdwWmZZaZ8JRzdFFphPzFLaqidd33JQ
	 UQpeY8wou7/5x0/Vm4GcEFMCA9hxmxnXMu1K90cWpCR6BorSYelOZ3Ile+6sXnrq3n
	 s12Q+UJZ2FBnA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XJGml3JF0zjVM;
	Tue,  1 Oct 2024 21:04:39 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
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
Subject: [RFC PATCH 0/4] sched+mm: Track lazy active mm existence with hazard pointers
Date: Tue,  1 Oct 2024 21:02:01 -0400
Message-Id: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hazard pointers appear to be a good fit for replacing refcount based lazy
active mm tracking.

Highlight:

will-it-scale context_switch1_threads

nr threads (-t)     speedup
    24                +3%
    48               +12%
    96               +21%
   192               +28%

I'm curious to see what the build bots have to say about this.

This series applies on top of v6.11.1.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: John Stultz <jstultz@google.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
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
  hp: Implement Hazard Pointers
  sched+mm: Use hazard pointers to track lazy active mm existence

 Documentation/RCU/rcu_dereference.rst |  38 ++++++-
 Documentation/mm/active_mm.rst        |   9 +-
 arch/Kconfig                          |  32 ------
 arch/powerpc/Kconfig                  |   1 -
 arch/powerpc/mm/book3s64/radix_tlb.c  |  23 +---
 include/linux/compiler.h              |  63 +++++++++++
 include/linux/hp.h                    | 154 ++++++++++++++++++++++++++
 include/linux/mm_types.h              |   3 -
 include/linux/sched/mm.h              |  71 +++++-------
 kernel/Makefile                       |   2 +-
 kernel/exit.c                         |   4 +-
 kernel/fork.c                         |  47 ++------
 kernel/hp.c                           |  46 ++++++++
 kernel/sched/sched.h                  |   8 +-
 lib/Kconfig.debug                     |  10 --
 15 files changed, 346 insertions(+), 165 deletions(-)
 create mode 100644 include/linux/hp.h
 create mode 100644 kernel/hp.c

-- 
2.39.2
