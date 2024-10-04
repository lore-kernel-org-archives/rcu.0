Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1A1E2604;
	Fri,  4 Oct 2024 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066585; cv=none; b=l6Q6lQCYEhYvBWPrvWDgnc02vnaFFL9iYLS8HT3CIGDYFmmZOtCdAPiHerRxVJsb7nTX3KX0EIfJ7M/32f4QF4iKDIjL2wdO0MrmfBJCG6S8X6VodGD4jU3UukJQ2VU9qJEX9VGSBkc/NcYtwl5jA1Oad4X4A3SprR8mwbjH5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066585; c=relaxed/simple;
	bh=MWud5rJYcp01tmdb0smF8P75Q+GNmRWixrTxRl8zMFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k203EypCK+9jkFRvjOEShpO71x5fn1HYla6ckqIgp+aaWX+AMfBQewk6X48SuzNTI5xGlhdHr2y6tOyXzUay3PgQhDxjTT53FwnVoC/xLtaWwCx3M1shoGWIE6YoOnvHhV5xQ7XELBdlHSK1UbRKDhtJWHqU753PIwVmzS5q70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VS52UYd6; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VS52UYd6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728066582;
	bh=MWud5rJYcp01tmdb0smF8P75Q+GNmRWixrTxRl8zMFk=;
	h=From:To:Cc:Subject:Date:From;
	b=VS52UYd6+pQ4D/wAPhBdWsqtEtpep/nQzQlFII7jB0tQjkbxdphiSbOO47RuvZJr5
	 YoKQkqOk6PPn6iN5nZRaPyW59k2aH2pVMplcLapIJhKo0GeF1q0uU2qsuZh7nxpe3y
	 7fklJJTiI+F7n4MJvqrALtgx0pn+a9fqvrfcIwZiVJf0CZFirgN6tGC/Kue7bQAG18
	 pMTIXQ6GiKQhpKcp0qC9687F5LVTmryf7P585gxI9MUzdnM6bvYVNYp8lGHPbgPO9h
	 lqXRJBJIMftkexbY+fkLFpO5yRRPPKtOR+iGJp3jTyclNd6g14SyTS0wYtIQ2axrKk
	 pK3SuYKswUsLg==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKxsd5z2nzMpK;
	Fri,  4 Oct 2024 14:29:41 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
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
Subject: [RFC PATCH v2 0/4] sched+mm: Track lazy active mm existence with hazard pointers
Date: Fri,  4 Oct 2024 14:27:30 -0400
Message-Id: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Based on recent discussion with Linus, it appears that this series
  just proves that it's time to get rid of active mm altogether:

  https://lore.kernel.org/lkml/CAHk-=wgztWbA4z85xKob4eS9P=Nt5h4j=HnN+Pc90expskiCRA@mail.gmail.com/

  I'm posting a v2 fixing minor issues from v1 in case it can be useful
  to try hazard pointers with other use-cases, or for further
  benchmarking of active mm tracking impact.
]

Hazard pointers appear to be a good fit for replacing refcount based lazy
active mm tracking.

Highlight:

will-it-scale context_switch1_threads

nr threads (-t)     speedup
     1                -0.2%
     2                +0.4%
     3                +0.2%
     6                +0.6%
    12                +0.8%
    24                +3%
    48               +12%
    96               +21%
   192               +28%
   384                +4%
   768                -0.6%

This series applies on top of v6.11.1.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
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
 include/linux/compiler.h              |  63 ++++++++++
 include/linux/hp.h                    | 158 ++++++++++++++++++++++++++
 include/linux/mm_types.h              |   3 -
 include/linux/sched/mm.h              |  71 +++++-------
 kernel/Makefile                       |   2 +-
 kernel/exit.c                         |   4 +-
 kernel/fork.c                         |  47 ++------
 kernel/hp.c                           |  46 ++++++++
 kernel/sched/sched.h                  |   8 +-
 lib/Kconfig.debug                     |  10 --
 15 files changed, 350 insertions(+), 165 deletions(-)
 create mode 100644 include/linux/hp.h
 create mode 100644 kernel/hp.c

-- 
2.39.2
