Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600344D6B2;
	Wed,  5 Aug 2026 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932639; cv=none; b=atknTFUFHZLxZ1eIiNkwz3ruKg/vMioU/ZIbwL7QhIP3dv4lld1IM5WUuLx313Ru+CWpEMc831sBoeMz1ja8IypZ6chp+TwPiflEySIJr0TrfXV10w19qS4v35EFQ4aXlr9RoVjYU5rfEf0UPfgRHOXx1jMONpqvvxOzEDI500A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932639; c=relaxed/simple;
	bh=VeElGqguBk+YXhLI8UFgRHxKSBcI5iq35tO6dwjE9NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kk9uyHDt6Igq3Jbg/FiMhxQGsZ3l6YzmaD5bR3hnaEOQl3mcQ96cSdF0UZ/izsMWlMdCvom5de3YT2pqUWthp8h1LO0nX0yzeNbCcts4yeZqxj9r5bOWvbKFYkym7TF6ZCvJjvtZ/UBJOla5jZl/ymewtkEU6dg+85Km6xeqz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2DLiXmE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2DLiXmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2113B1F00A3A;
	Wed,  5 Aug 2026 12:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785932637;
	bh=KXA4mx2u1Ug+n11pC4xoYwZgkkYLBLqEcht23v1f4Ns=;
	h=From:To:Cc:Subject:Date;
	b=O2DLiXmEXwcYxEcyf9RjSistfKslNKrdA+AY8sSFcOiH/o2/XrAG88t7/0Ice7G7W
	 QP3k8DQYPrOIp5NszBkcNo8WZeb97dCePyVrxmtUIiErO5s7MewO1Uti+XgJGKZn1U
	 mGg0c7bN0HagbweJHROieKwQJ/2HeC9x3WNXRfZLk91FbHxIOEPJ7HN4lrWoVBEak5
	 tUFIip5cWm/wq5sAK+ma4V1doLdFJGBxARSZOyfjj344eHztStwAAAZoqlHluMWyam
	 r/wQIMtQs8YXysGnRUNgDeMWBCrVruzKt3blFbsD6/rbPKHPmLutIlQO+p9SY4GCi4
	 jp7OpWq9X8nFQ==
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
Subject: [PATCH v3 0/6] rcu,srcu: Make call_rcu()/call_srcu() safe from any context
Date: Wed,  5 Aug 2026 05:23:37 -0700
Message-ID: <20260805122346.269445-1-puranjay@kernel.org>
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
and srcu_barrier() therefore drain every CPU's deferred list themselves
before they wait.  They drain rather than wait the irq_work out because
irq_work_sync() parks on an rcuwait, which holds a single waiter, so two
concurrent barriers would clobber each other's wakeup; a lockless
llist_empty() test keeps the common case (nothing ever deferred) to one
load per CPU.  rcutree_migrate_callbacks() drains the outgoing CPU's list
too, so a late deferral still lands on a callback list even when nobody
calls a barrier.  To keep those drainers from stepping on each other, the
drain holds a per-CPU raw lock across the llist_del_all() and the
re-issue, so a drainer never returns having pulled callbacks off the
deferred list but not yet put them on a callback list.  Every lock the
re-issue touches (nocb, rcu_node, srcu_data) is already raw, so the
nesting is fine.

The drain re-issues with interrupts disabled, so instrumentation on the
enqueue path can re-enter call_rcu()/call_srcu() from inside it, stage
another callback, re-raise the irq_work, and the drain never finishes.  A
per-CPU flag catches that: a deferral that arrives while that CPU is
inside its own irq_work drain, and is not from an NMI, is dropped rather
than staged, with a WARN_ONCE() under CONFIG_PROVE_RCU whose backtrace
names the instrumentation responsible.  Dropping leaks that callback, but
the alternative is a CPU that never leaves the drain, and the producer is
a BPF program that emits one callback per enqueue, so there is nothing
finite to wait for.  Only the irq_work drain sets the flag: a direct drain
from a barrier or from CPU-offline re-issues onto the current CPU, so
anything staged during it is picked up by that CPU's own irq_work rather
than feeding the drain in progress, and no legitimate callback is dropped.
Instrumenting the irq_work machinery itself can still loop, as it can for
any irq_work user, and is not something this series can fix.

The irq_work is IRQ_WORK_INIT_HARD in all four flavors.  It is not needed
for correctness, but a non-HARD irq_work runs from a kthread on
PREEMPT_RT and can be delayed under load, letting deferred callbacks pile
up; running the re-issue in hard-irq context keeps that from turning into
an OOM.

Patches 1 and 2 do Tree and Tiny RCU, 3 and 4 Tree and Tiny SRCU.  Patch 5
teaches rcutorture to issue ->call() from a perf-overflow NMI -- the
nmi_calls parameter, on by default -- on the flavors that advertise it,
and checks that every callback issued from NMI is later invoked.  Patch 6
adds the BPF reentry reproducer described above.

Changelog:
v2: https://lore.kernel.org/rcu/20260803134839.2103051-1-puranjay@kernel.org/
Changes in v3:
- Barriers no longer call irq_work_sync() on an online CPU's ->defer_work.
  irq_work_sync() waits on an rcuwait, which holds exactly one task, so two
  concurrent rcu_barrier()s syncing the same per-CPU irq_work could lose a
  wakeup and hang.  Both flushes now drain every CPU directly, guarded by a
  lockless llist_empty() test so the no-deferrals case stays cheap.
- The re-entry guard is now set only by the irq_work drain, which always
  runs on the CPU owning the list it drains.  In v2 a barrier draining a
  remote CPU set the flag on the draining CPU, so an unrelated irqs-off
  call_rcu() there was dropped and leaked even though it could not have fed
  the drain.
- The drain clears ->next before re-issuing.  A double call_rcu() on a head
  that is already debug-object-active makes llist_add() self-link it, and
  rcu_do_enqueue()'s double-free path returns without clearing ->next, so
  the drain span looped forever with interrupts disabled.
- An expedited call_srcu() is no longer silently downgraded: ->defer_exp
  records it per srcu_data and the batch is re-issued expedited.  Only
  srcu_expedite_current() is affected, __synchronize_srcu() sleeps and so
  is never deferred.
- The drop is now WARN_ONCE() under CONFIG_PROVE_RCU rather than an
  unconditional WARN, so instrumentation cannot reboot a panic_on_warn
  kernel; the backtrace is what identifies the offending program.
- Tiny RCU and Tiny SRCU use IRQ_WORK_INIT_HARD like the Tree flavors, and
  READ_ONCE()/WRITE_ONCE() on their draining flags.  TINY_SRCU is
  "default y if !SMP" with no PREEMPT_RT dependency, so it really can be
  built on RT where a non-HARD irq_work waits on the irq_workd kthread.
- Tiny SRCU: cleanup_srcu_struct() drains *and* irq_work_sync()s
  ->defer_iw.  That irq_work is embedded in the srcu_struct the caller is
  about to free, unlike the Tree flavors' static per-CPU ones.
- rcutorture: drive the perf counters from CPU-hotplug callbacks.  The
  one-shot for_each_online_cpu() loop lost them at the first CPU offline,
  after which the end-of-test issued==invoked check compared 0 == 0.
- rcutorture: per-CPU rcu_head instead of one global, so several CPUs can
  race the drain; count the call before issuing it so mid-run stats cannot
  show nmi-cbs > nmi-calls; release the perf events on the
  torture_cleanup_begin() early-return path; print nmi_calls in the module
  banner; report when nmi_calls is set but no NMI ->call() ever happened;
  and drop sample_freq to 100, since 1000 made perf lower the system-wide
  perf_event_max_sample_rate tenfold.
- selftests/bpf: the old ASSERT_EQ(reentered, 1) could not fail, and an
  atomic allocation failure in the nested task-storage delete made the test
  pass without ever re-entering call_srcu().  It now records and asserts
  the helper return values, probes for rcu_segcblist_enqueue() up front so
  a Tiny kernel skips instead of failing, and restores the CPU affinity it
  changes.

Testing: rcutorture rcu/srcu/srcud/tasks-tracing with nmi_calls, hotplug,
barriers and nocb toggling issued ~81000 callbacks from NMI with none lost,
under PROVE_LOCKING, PROVE_RAW_LOCK_NESTING, DEBUG_OBJECTS_RCU_HEAD and
RCU_LAZY, with no lockdep reports; SRCU-T, SRCU-U, TINY01 and TINY02 pass;
the BPF reproducer passes.

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

 include/linux/srcutiny.h                      |  12 +-
 include/linux/srcutree.h                      |   5 +
 kernel/rcu/Kconfig                            |   6 +
 kernel/rcu/rcu.h                              |  18 ++
 kernel/rcu/rcutorture.c                       | 154 +++++++++++++++-
 kernel/rcu/srcutiny.c                         |  79 +++++++-
 kernel/rcu/srcutree.c                         | 171 +++++++++++++++++-
 kernel/rcu/tiny.c                             | 117 ++++++++++--
 kernel/rcu/tree.c                             | 141 ++++++++++++++-
 kernel/rcu/tree.h                             |   6 +
 .../selftests/bpf/prog_tests/rcu_reentry.c    |  95 ++++++++++
 .../testing/selftests/bpf/progs/rcu_reentry.c |  51 ++++++
 12 files changed, 812 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_reentry.c

--
2.53.0-Meta

