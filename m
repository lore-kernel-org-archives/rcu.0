Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630EF1DF274;
	Tue,  8 Oct 2024 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395571; cv=none; b=WyjRsFfHtlcw+ECnhygMrMN4rjZ0ApxhlRF0SsuIIhJFcAjqaaczMQ83jr2URUuDsW1QPtOEhksD4u3qO3xIK1QqcdEe3mkGPvomcB7Tb52m808GxRYsxgXSlYMAQwr1rzFDaGka8/vcfo/t1MLoEWcZujBzE1jPKzpZ4HOCLUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395571; c=relaxed/simple;
	bh=FurOAuuDNyUm/lojkmHDOe6nk3DPDbcIuia0hHtIFVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PY1PBE2ib/c0YPQCulNWEZCjJFGqkJtBnxU89E8U10xrm/UrUO2yZ6I1p3++K7VW0TLFI7t18M2b1TxLfjL4zUDPnhUJLION1ILto/xTwx27ajBHUPdoNcSYYG1VI5WUAEzFzzJKcU31xumwQcwhjeHPboplS825E9st/cHCwOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=V+pRK6MX; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="V+pRK6MX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728395561;
	bh=FurOAuuDNyUm/lojkmHDOe6nk3DPDbcIuia0hHtIFVU=;
	h=From:To:Cc:Subject:Date:From;
	b=V+pRK6MX3xsgw8mxC5ocgt9ecpxOaeYcizHJSHxGqKPMB55/9+VVRyH9/BYKf0/WU
	 XCehtZvwFLdGZX/66cztTUcV4wgveUeHlWDezPzi/wkbZchF1sV+l1th68dF/+I6aK
	 llRpK/GzhQa6Pgsq+ofQZL/XxPGJ1rjsQSt7Q8ApI5LeDq7tlRP08bG20BL8U8e0pe
	 yGz5e3/I1IgzfXIHWgrKByaJzrdjcVMQ9p2MMDjR1M0KPzpLVis9Zsq411lu97IUu9
	 cUmQLDT4zwhuwsGaE3W5RGABiDB9Dknne7FMg+T+41f8OLi3mgqe7puL+Qafdu257a
	 FO7e4tun0B3mw==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNHX8539XzLqn;
	Tue,  8 Oct 2024 09:52:40 -0400 (EDT)
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
Subject: [RFC PATCH v3 0/4] sched+mm: Track lazy active mm existence with hazard pointers
Date: Tue,  8 Oct 2024 09:50:30 -0400
Message-Id: <20241008135034.1982519-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[
  I'm posting a v3 taking care of feedback from Peter Zijlstra and Paul
  E. McKenney in case it can be useful to try hazard pointers with other
  use-cases, or for further benchmarking of active mm tracking impact.
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
  hazptr: Implement Hazard Pointers
  sched+mm: Use hazard pointers to track lazy active mm existence

 Documentation/RCU/rcu_dereference.rst |  38 +++++-
 Documentation/mm/active_mm.rst        |   9 +-
 arch/Kconfig                          |  32 -----
 arch/powerpc/Kconfig                  |   1 -
 arch/powerpc/mm/book3s64/radix_tlb.c  |  23 +---
 include/linux/compiler.h              |  63 ++++++++++
 include/linux/hazptr.h                | 165 ++++++++++++++++++++++++++
 include/linux/mm_types.h              |   3 -
 include/linux/sched/mm.h              |  68 ++++-------
 kernel/Makefile                       |   2 +-
 kernel/exit.c                         |   4 +-
 kernel/fork.c                         |  47 ++------
 kernel/hazptr.c                       |  51 ++++++++
 kernel/sched/sched.h                  |   8 +-
 lib/Kconfig.debug                     |  10 --
 15 files changed, 358 insertions(+), 166 deletions(-)
 create mode 100644 include/linux/hazptr.h
 create mode 100644 kernel/hazptr.c

-- 
2.39.2
