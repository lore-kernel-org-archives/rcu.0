Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E61FCFEF;
	Mon, 10 Aug 2026 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364893; cv=none; b=Yg24QJR3zBincvbPVxyHsNKVbvodq5H6Jp9YUujRd//n0u885ke8HEOvql26UE0nZpBhCHrLn6WsHxT+XBeK2WLuh4ZSzZTHD+Atx8gL598rQ5YPpeTWBmfttXLzyL0pJWg7NujRNN7zEbrgaHPfvbEOVMYW21NvHpcvSdE0nzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364893; c=relaxed/simple;
	bh=eRGyBWQEM0gnHVuLKLQialPF2Ca3wD2Ia9dU+ygviK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VeAesbkLTgihhtD2f8ju459zydswVpHJ5oyHYX/ucT0mL8xRiUVoQbZdGU99/dwvir36ukGSyEDGg6c3LaUEIVPO1Km0Si28KlklsOzgEOJBZfg8ETSMM0UuTdTsYW8mF3CmaaP4CzYShqNXnVG9kLSd/FMHlbsg26Lorf5j9ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5Ji6dhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5Ji6dhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B541F000E9;
	Mon, 10 Aug 2026 12:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786364891;
	bh=m5k/SSTQDqCJH4t969XIGouWDXCPz1vxVRTp52ayeI4=;
	h=From:To:Cc:Subject:Date;
	b=A5Ji6dhrYAfGsB3vwCQkxKaenIjML+0A64u51U08xANii1ogBd7QMSvIitAPIpoKh
	 aVKfUyiTDoxNtA0ol3NOSs7PKiCcLWhAx/I38ixMchNGd19n8ZBoaMLvLQ/YFDg3EL
	 Gpdsj4xuq3/X3REKgzsRrg4ejswbZODJ6vLGGHkTZVpvj5LvzLrVCGjvBEv8wrm0bj
	 IfJqUrKGvUwe1ijxeEO8pN87alnorZPEqvAqKWIGt+1Z7mCRweThhd+XyDcDVeBBco
	 BvaaZE6zOh9pbWyu/QcWL+LG2Tpbj6gbDhOH9g06O9zzxjvnBz1jCv0PYwbsTbMyfN
	 EjEHYgi9UHg6Q==
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
Subject: [PATCH v4 0/6] rcu,srcu: Make call_rcu()/call_srcu() safe from any context
Date: Mon, 10 Aug 2026 05:27:49 -0700
Message-ID: <20260810122758.183765-1-puranjay@kernel.org>
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
before.  The gate is bare irqs_disabled(), so callers that merely hold
interrupts off are deferred too and pay one irq_work hop.

CPU offline is the awkward part.  A callback can be deferred very late in
the outgoing CPU's teardown -- from do_idle() or cpuhp_ap_report_dead(),
past the CPUHP_AP_SMPCFD_DYING flush that would otherwise run the irq_work
-- so the irq_work can no longer run there to re-issue it.  rcu_barrier()
and srcu_barrier() therefore drain every CPU's deferred list themselves
before they wait.  They drain rather than wait the irq_work out because
irq_work_sync() parks on an rcuwait, which holds a single waiter, so two
concurrent barriers would clobber each other's wakeup.
rcutree_migrate_callbacks() drains the outgoing CPU's list
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
names the instrumentation responsible.  Dropping leaks that callback, and
can strand state its caller tied to it, but the alternative is a CPU that
never leaves the drain, and the producer is a BPF program that emits one
callback per enqueue, so there is nothing finite to wait for.  Only the
irq_work drain sets the flag: a direct drain from a barrier or from
CPU-offline re-issues onto the current CPU, so anything staged during it
is picked up by that CPU's own irq_work rather than feeding the drain in
progress, and no legitimate callback is dropped. Instrumenting the
irq_work machinery itself can still loop, as it can for any irq_work user,
and is not something this series can fix.

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
v3: https://lore.kernel.org/rcu/20260805122346.269445-1-puranjay@kernel.org/
Changes in v4:
- rcu_barrier() and srcu_barrier() no longer skip a CPU whose deferred
  list looks empty.  The lockless llist_empty() test added in v3 skipped
  the lock that makes a drain conclusive: a concurrent drainer can already
  have emptied the list without having re-issued yet, so the barrier could
  return before those callbacks reached a callback list.
- Tree SRCU: drain before cleanup_srcu_struct()'s "just leak it" early
  returns, and in srcu_module_going() before it frees any ->sda.  Deferral
  skips check_init_srcu_struct(), so srcu_module_going() could skip
  cleanup_srcu_struct() and free ->sda with a staged srcu_data still
  chained on a per-CPU list.
- Dropped ->defer_exp: a deferred expedited call_srcu() now completes as a
  normal grace period.  The flag lived on the srcu_data rather than on the
  callback, so it expedited whole batches; only srcu_expedite_current()
  with interrupts already disabled can reach this, so the downgrade costs
  a delay and nothing else.
- rcutorture: use a fixed perf sample period rather than .freq, which sets
  TICK_DEP_BIT_PERF_EVENTS for every CPU and pinned the tick for whole
  runs of TREE04 and TREE07.  Also document nmi_calls, and say on the
  console when there is no PMU, since the issued==invoked check then
  compares zero to zero.
- kasan_record_aux_stack() moved to __call_rcu_common(), so a
  use-after-free report names the caller rather than the irq_work.
- Known gap, documented in patch 1: a callback deferred past the
  CPUHP_AP_SMPCFD_DYING flush leaves ->defer_work claimed with its
  self-IPI lost.  rcutree_migrate_callbacks() still re-issues the
  callback, but the first deferral after that CPU comes back raises no IPI
  and waits for the next irq_work there, or for rcu_barrier().

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

Testing: rcutorture rcu, srcu, srcud and tasks-tracing, each with
nmi_calls, CPU hotplug and barriers, and nocb toggling for rcu, all
End of test: SUCCESS with the count issued from NMI equal to the count
invoked (17987, 2924, 2661 and 4412 respectively) and clean consoles,
under PROVE_LOCKING, PROVE_RAW_LOCK_NESTING and DEBUG_OBJECTS_RCU_HEAD;
SRCU-T, SRCU-U, TINY01 and TINY02 pass; the BPF reproducer passes.
Build-tested x86_64 with TREE_RCU+TREE_SRCU, TINY_RCU+TINY_SRCU and
TREE_RCU+TINY_SRCU, each with CONFIG_RCU_DEFER=y and =n, plus arm64
TREE_RCU+TREE_SRCU with RCU_NOCB_CPU and RCU_LAZY.

Puranjay Mohan (6):
  rcu: Make call_rcu() safe to call from any context
  rcu: Make Tiny call_rcu() safe to call from any context
  srcu: Make call_srcu() safe to call from any context
  srcu: Make Tiny call_srcu() safe to call from any context
  rcutorture: Exercise ->call() from NMI context
  selftests/bpf: Add a call_srcu() re-entry reproducer

 .../admin-guide/kernel-parameters.txt         |   7 +
 include/linux/srcutiny.h                      |  12 +-
 include/linux/srcutree.h                      |   4 +
 kernel/rcu/Kconfig                            |   6 +
 kernel/rcu/rcu.h                              |  14 ++
 kernel/rcu/rcutorture.c                       | 150 +++++++++++++++-
 kernel/rcu/srcutiny.c                         |  93 +++++++++-
 kernel/rcu/srcutree.c                         | 170 +++++++++++++++++-
 kernel/rcu/tiny.c                             | 127 ++++++++++---
 kernel/rcu/tree.c                             | 133 ++++++++++++--
 kernel/rcu/tree.h                             |   6 +
 .../selftests/bpf/prog_tests/rcu_reentry.c    |  93 ++++++++++
 .../testing/selftests/bpf/progs/rcu_reentry.c |  51 ++++++
 13 files changed, 818 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_reentry.c

base-commit: 9dc303e69bcd49f9668ca090ae45325269531fbb
-- 
2.53.0-Meta

