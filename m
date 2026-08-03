Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C24156C5;
	Mon,  3 Aug 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764938; cv=none; b=tA1QVDxL8o37sEFK8ziUs3/yLyHTI8jqkT5VK2KEVXLAX/YNVZe9UgaedzZffekSpEYRAPdyRpLIzg/jgImk+QdiSCB9iiLf7jtpKiBw0D1OZd24dNb7SpxgHmLQP8EZeaC7p9z1a5ogP1GRmsPrjk4Tlt3a+Z45VT7mbuX7FCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764938; c=relaxed/simple;
	bh=y2vq0Rtvi23xC3UBGRZhXisy0K7tCU/fz7MqhkHwOeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jAYJx2JLNrhnmGLr1e4kyJZWAHZwRW6jB4mqBUjRuioY/ks3HFfKQsUd7gL2D6j/K4+kZbnRelDyB4IqR+AJrFsfPsUjWPA0EZ/PX+RdoMhUP0/BAp4/fZt0UUiJsIJlcjFiuLPqO/qsLaLGtmLkUhq6u4ae3rBKI7RNKzbEx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+Fvwqim; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+Fvwqim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38C41F000E9;
	Mon,  3 Aug 2026 13:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785764937;
	bh=Jxuvs5IAsxwP+L5G5fsI4l4NRqBN57QdSr9PqE5QsQY=;
	h=From:To:Cc:Subject:Date;
	b=c+FvwqimBWULXLkd1RWk3on+ftVmi/q5Q3qJBY9Ku7w2vVepH8QwJ1B3HjPMZJ7i2
	 wQzf2cfUCz8LBJsowngZ4+vsz7D5uivFi+vcj+Z7G+V3aSuqSS4ziVMuUgmtKQJOwZ
	 dfzrAFHZhOw+MZziW1BIDiAJS11YF1SU9d3BLRowSKXBDR18n8/tu02pE+zZkilke0
	 6mSY+JP9MwuV7/qbPSowsRu2RNYMld8eNF0tTvNDVr3c0qdgQjrBRQRnaddy5Wf6aH
	 qRWFASAkmWEwAuqD1YyXbaAlYuRMNj9JofarISmgI3Z6uMUCfmri9NLwYDfqpCKcpn
	 R1qY+KBm6awzg==
From: Puranjay Mohan <puranjay@kernel.org>
To: "Lai Jiangshan" <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Josh Triplett" <josh@joshtriplett.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	"Frederic Weisbecker" <frederic@kernel.org>,
	"Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
	"Joel Fernandes" <joelagnelf@nvidia.com>,
	"Boqun Feng" <boqun@kernel.org>,
	"Uladzislau Rezki" <urezki@gmail.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v2 0/6] rcu,srcu: Make call_rcu()/call_srcu() safe from any context
Date: Mon,  3 Aug 2026 06:48:16 -0700
Message-ID: <20260803134839.2103051-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

call_rcu() and call_srcu() only ever touch their per-CPU callback lists
with interrupts disabled: the enqueue runs under local_irq_save() (and the
nocb locks when offloaded), and so do callback invocation and grace-period
work.  That is fine as long as call_rcu() itself is invoked with
interrupts enabled, but it is not always.  An NMI handler can call
call_rcu(), and instrumentation can reenter it.  The case that prompted
this is a BPF program attached to rcu_segcblist_enqueue() that frees an
object: the free reaches call_rcu_tasks_trace(), which is call_srcu()
under the hood, back on the same CPU with the srcu_data lock already held,
and it deadlocks on that lock.  Either way, enqueuing directly can corrupt
the list or deadlock.

Rather than scatter context checks through the enqueue, make it defer
whenever interrupts are disabled: stage the callback on a per-CPU lockless
list and re-issue it from an irq_work once interrupts are back on, going
straight to the enqueue helper so the re-issue cannot defer again.  Only
the drain side takes a lock; the staging is a bare llist_add() and stays
safe from NMI.  This is behind a new hidden CONFIG_RCU_DEFER, which is set
wherever a reentrant enqueue is possible (HAVE_NMI, KPROBES,
FUNCTION_TRACER or TRACEPOINTS); without it call_rcu() enqueues exactly as
before.

CPU offline is the awkward part.  A callback can be deferred very late in
the outgoing CPU's teardown -- from do_idle() or cpuhp_ap_report_dead(),
past the CPUHP_AP_SMPCFD_DYING flush that would otherwise run the irq_work
-- so the irq_work can no longer run there to re-issue it.  rcu_barrier()
and srcu_barrier() therefore drain the deferred lists themselves before
they wait: for online CPUs they wait the irq_work out, and for offline
ones they drain the list directly, since that irq_work may never run
again.  rcutree_migrate_callbacks() drains the outgoing CPU's list too, so
a late deferral still lands on a callback list even when nobody calls a
barrier.  To keep those three drainers from stepping on each other, the
drain holds a per-CPU raw lock across the llist_del_all() and the
re-issue, so a drainer never returns having pulled callbacks off the
deferred list but not yet put them on a callback list.  Every lock the
re-issue touches (nocb, rcu_node, srcu_data) is already raw, so the
nesting is fine.

The drain re-issues with interrupts disabled, so instrumentation on the
enqueue path can re-enter call_rcu()/call_srcu() from inside it, stage
another callback, re-raise the irq_work, and the drain never finishes.  A
per-CPU flag set across the re-issue catches that: a deferral that arrives
while this CPU is draining, and is not from an NMI, is dropped with a
warning instead of staged.  Dropping leaks that callback, but the
alternative is a CPU that never leaves the drain, and the producer is a
BPF program that emits one callback per enqueue, so there is nothing
finite to wait for.  Instrumenting the irq_work machinery itself can still
loop, as it can for any irq_work user, and is not something this series
can fix.

The irq_work is IRQ_WORK_INIT_HARD.  It is not needed for correctness, but
a non-HARD irq_work runs from a kthread on PREEMPT_RT and can be delayed
under load, letting deferred callbacks pile up; running the re-issue in
hard-irq context keeps that from turning into an OOM.

Patches 1 and 2 do Tree and Tiny RCU, 3 and 4 Tree and Tiny SRCU.  Patch 5
teaches rcutorture to issue ->call() from a perf-overflow NMI -- the
nmi_calls parameter, on by default -- on the flavors that advertise it,
and checks that every callback issued from NMI is later invoked.  Patch 6
adds the BPF reentry reproducer described above.

Changelog:
v1: https://lore.kernel.org/all/20260729162207.1567770-1-puranjay@kernel.org/
Changes in v2:
- Fixed the re-entry livelock Zqiang spotted: a BPF program on the enqueue
  path re-enters call_srcu() from inside srcu_defer_drain(), stages another
  callback and re-raises the irq_work, so the drain never finishes.  A
  per-CPU flag now drops such a deferral, with a warning, unless it comes
  from an NMI.
- cleanup_srcu_struct(): drain the deferred callbacks before syncing
  ->irq_work rather than after, since re-issuing one can start a grace
  period and re-queue that irq_work (Zqiang).
- Tiny SRCU: sync ->defer_iw in cleanup_srcu_struct() as well, so a
  deferred callback is re-issued onto ->srcu_cb_head where the leak checks
  can see it instead of being stranded on a soon-to-be-freed srcu_struct.
- Added Kumar's ack to the BPF selftest patch.

Puranjay Mohan (6):
  rcu: Make call_rcu() safe to call from any context
  rcu: Make Tiny call_rcu() safe to call from any context
  srcu: Make call_srcu() safe to call from any context
  srcu: Make Tiny call_srcu() safe to call from any context
  rcutorture: Exercise ->call() from NMI context
  selftests/bpf: Add a call_srcu() re-entry reproducer

 include/linux/srcutiny.h                      |  11 +-
 include/linux/srcutree.h                      |   4 +
 kernel/rcu/Kconfig                            |   6 +
 kernel/rcu/rcu.h                              |  17 ++
 kernel/rcu/rcutorture.c                       | 112 +++++++++++++
 kernel/rcu/srcutiny.c                         |  63 +++++++-
 kernel/rcu/srcutree.c                         | 150 +++++++++++++++++-
 kernel/rcu/tiny.c                             | 104 +++++++++---
 kernel/rcu/tree.c                             | 132 +++++++++++++--
 kernel/rcu/tree.h                             |   5 +
 .../selftests/bpf/prog_tests/rcu_reentry.c    |  58 +++++++
 .../testing/selftests/bpf/progs/rcu_reentry.c |  45 ++++++
 12 files changed, 666 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_reentry.c
--
2.53.0-Meta

