Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49FD4BF952;
	Wed, 30 Sep 2026 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771952; cv=none; b=leKfLeje7FRXedid+FQ3Kf9PI2QYlDkBid8m35VO0MdXC3y6ZefYDV1w43ynURCdyKUsXuaDH2xyPUsba6gHOjPOU6MO5b01T3qXkGdFcXVzOOkzJW6b4Y/4ewHKH0r2Pfwb2cJrmE+UE4S6Me8tCf6dnfJ5yq9O17oJfa1uq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771952; c=relaxed/simple;
	bh=4hiPjEszyAaLpT9ecg8Fx8DWAGaetAhdRrOlpJOrvbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hm0fRI5hXk6Fe079OvSwNn/ZoGMJs8bySkjcnlqvNsjFmKuhhk3w8xmLA6TJ8geAxMo0Dg/H3omg2YG0hOI0axY3Ha3llTibqWRF6pIZtzBbpAUsLIXgf1MA/CRTFSrWfcvKY7KilegN/79KdtkRonG7NYwDEpwPvGwpmMqeYSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF1oTeP6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF1oTeP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693961F000FF;
	Wed, 30 Sep 2026 12:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790771950;
	bh=Hlaiv+oT5Ce6LSMQaIVLOoOP+S+iI50Q6hkVwSrOAME=;
	h=From:To:Cc:Subject:Date;
	b=gF1oTeP67VmGmSvt8J/YNDJmpFie7zIJlc5psFdYc1JhvwvwNVma5YEmWt8ZBoO8R
	 wtXPaN6F+heCr6YLefoJgzdAD4139ZOfjagfX4ncua5/9J/SP5wjVeBISnsb6OZY/l
	 xi+e9emrNeSNaXvjjDN6S5ZT+lbNrOvKHeuzQhQkw8kqH9DMlfh9DL9BkqK5QGlpV6
	 SWZTuEw6TxUdaswy4dZKk+Eah1HmFkWdaF2uPzVUvu9VHYMNB9F+U8yBHQmzt8zWLC
	 FNc9wfjkcvm8Xj3Wy/lEP3G20BvKK4zbRkszeOpUlZhkflq8xDMw+TNgCbqu+8w0f1
	 rP0rBFuefSnOw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Boqun Feng <boqun@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 0/1] kprobes: Make optprobe optimizer multi-generational and asynchronous
Date: Wed, 30 Sep 2026 21:39:04 +0900
Message-ID: <179077194409.424772.11709189894572687187.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 3rd version of the patch for making the optprobe optimizer
multi-generational and asynchronous.

The previous version is here:

  https://lore.kernel.org/all/179040876891.171579.9459626579461679924.stgit@devnote2/

In this version:
- Avoid 100% CPU busy-loop livelock during flushes when a generation is
  in flight (reported by Sashiko AI review[1]):
  - Make optprobe_dispatch_generation() return a boolean indicating
    whether a generation was actually dispatched.
  - In kprobe_optimizer(), only increment optimizer_passes and wake
    flushers if actual progress was made (a generation was finalized or
    dispatched).
  - In wait_for_kprobe_optimizer_locked(), only wake the optimizer kthread
    if work can be dispatched or a generation is ready, avoiding wakeups
    when a generation is merely in-flight waiting for Tasks RCU.

[1] https://lore.kernel.org/all/179072636063.409480.10967951178575355535.stgit@devnote2/

=== How the Asynchronous Multi-Generational Optimizer Works ===

1. Background & Motivation
--------------------------
Previously, kprobe_optimizer() executed synchronously:
- It acquired kprobe_mutex, text_mutex, and cpus_read_lock().
- It then called synchronize_rcu_tasks() while holding all three locks.
- Under PREEMPT_LAZY / PREEMPT kernels and CPU-heavy server workloads,
  synchronize_rcu_tasks() can stall for seconds to minutes waiting for
  voluntary context switches on all online CPUs.
- Holding text_mutex and cpus_read_lock() throughout this wait blocked
  CPU hotplug, module loading/unloading, static keys, and all subsequent
  kprobe registrations, frequently triggering hung-task watchdogs.

The actual instruction modification (text-patching) takes only
microseconds. The new optimizer completely decouples instruction patching
from the Tasks RCU grace period wait using call_rcu_tasks(), dropping all
locks during the wait.

2. Architecture: Fixed Generational Ring
----------------------------------------
To ensure jump optimization never fails with -ENOMEM during tracing,
a fixed ring of generation slots is used:

  static struct optprobe_generation optprobe_gens[OPTPROBE_GEN_MAX];
  (OPTPROBE_GEN_MAX = 2)

Each generation struct contains 4 probe lists and tracking state:
- optimizing_list:
    Probes waiting to be optimized (jump installed). Text-patching is
    deferred until after the generation's Tasks RCU grace period.
- unoptimizing_list:
    Probes waiting to be unoptimized (jump replaced with breakpoint)
    prior to entering the grace period.
- cooling_list:
    In-use probes whose jumps were unoptimized, cooling down during the
    Tasks RCU grace period. Holding them on this list keeps
    list_empty(&op->list) false, preventing concurrent unregister_kprobes()
    from prematurely freeing the aggregator or detour buffer before
    preempted tasks exit.
- freeing_list:
    Cleaned/unused aggregator probes whose detour slots and memory
    will be reclaimed after the Tasks RCU grace period completes.
- rcu:
    The rcu_head passed to call_rcu_tasks().
- in_flight / ready:
    State flags indicating if the generation is currently waiting on
    Tasks RCU, or if the callback has fired and finalization is pending.

3. The "Waiting Room" Invariant
-------------------------------
optprobe_cur_gen points to the current active ingress generation.
All new optimization, unoptimization, and forced-cleanup requests from
register_kprobe(), unregister_kprobe(), and kill_optimized_kprobe() are
queued into optprobe_gens[optprobe_cur_gen].

To ensure an idle generation slot is always available to absorb incoming
requests without dynamic allocation, the last available generation slot
is never dispatched while an earlier generation is still in flight
(optprobe_can_fire() checks active_gens < OPTPROBE_GEN_MAX - 1).
It acts as a non-blocking "waiting room".

4. Execution Flow of the Optimizer Thread
-----------------------------------------
The dedicated optimizer kthread sleeps on kprobe_optimizer_wait and wakes
when kicked, when a flush is requested, or when an RCU callback completes.

                [ Probes Queued in cur_gen ]
                            |
               kprobe_optimizer_thread()
                            |
            (batching delay: OPTIMIZE_DELAY)
                            |
             kprobe_optimizer() [holds kprobe_mutex]
             +------------------------------+
             |                              |
             v                              v
   [ Step 1: Finalize ]           [ Step 2: Dispatch ]
   (for ready generations)        (for cur_gen if can_fire)
             |                              |
   - Hold text_mutex & cpus_lock  - Hold text_mutex & cpus_lock
   - arch_optimize_kprobes()      - arch_unoptimize_kprobes()
   - do_free_cleaned_kprobes()    - Move in-use to cooling_list
   - Drain cooling_list           - Advance cur_gen
   - Drop text_mutex & cpus_lock  - Drop text_mutex & cpus_lock
   - gen->in_flight = false       - call_rcu_tasks(&gen->rcu)
             +------------------------------+
                            |
                            v
                  [ Step 3: Notify ]
                  - If progress:
                      optimizer_passes++
                      wake_up_var_locked(optimizer_passes)
                  - Self-kick if more probes queued

Step 1: Finalize Ready Generations (optprobe_finalize_generation)
  Runs for any generation where the Tasks RCU callback marked ready = true:
  1. Briefly acquires text_mutex and cpus_read_lock().
  2. Calls arch_optimize_kprobes(&gen->optimizing_list) to patch the
     relative jump into target instructions.
  3. Releases text_mutex and cpus_read_lock().
  4. Calls do_free_cleaned_kprobes(&gen->freeing_list) to release detour
     buffers and free unused aggregator probes.
  5. Drains gen->cooling_list:
     - Probes unregistered while in flight (kprobe_unused()) are moved
       to cur_gen's freeing_list for the next pass.
     - Probes still in use have their disarming finalized via
       list_del_init(&op->list), and are queued for re-optimization if
       still enabled.
  6. Clears in_flight = false and ready = false, returning the slot to
     the idle pool.

Step 2: Dispatch the Waiting Room (optprobe_dispatch_generation)
  If the waiting room has queued probes and active_gens < OPTPROBE_GEN_MAX - 1:
  1. Briefly acquires text_mutex and cpus_read_lock().
  2. Calls do_unoptimize_kprobes(): executes arch_unoptimize_kprobes() to
     replace relative jumps with breakpoints.
  3. Probes that are unused are moved to gen->freeing_list and removed
     from the kprobe hash table (hlist_del_rcu).
  4. Probes still in use are moved to gen->cooling_list.
  5. Releases text_mutex and cpus_read_lock().
  6. Advances optprobe_cur_gen to the next generation slot.
  7. Marks gen->in_flight = true, gen->ready = false.
  8. Calls call_rcu_tasks(&gen->rcu, optprobe_generation_rcu_cb) and
     immediately returns. kprobe_mutex is completely released while
     Tasks RCU runs asynchronously in the background.

Step 3: Pass Completion & Flusher Notification
  1. If any generation was finalized or dispatched (progress was made),
     increments optimizer_passes and wakes waiters sleeping on
     wait_for_kprobe_optimizer().
  2. If the waiting room still has queued probes and another generation
     can fire immediately (e.g. sibling probes retrying optimization),
     it kicks itself for another pass.

5. Concurrency & Preemption Safety (The cooling_list)
-----------------------------------------------------
Under CONFIG_PREEMPTION=y, a task can be preempted inside an optprobe detour
buffer (or the detour template). When a probe is disabled, its jump is
reverted to an int3 breakpoint, but the detour buffer cannot be freed until
all preempted tasks have executed a voluntary context switch (Tasks RCU).

Because kprobe_mutex is dropped during the grace period, concurrent
unregister_kprobes() could run. Previously, unregister_kprobes() checked
kprobe_disarmed(ap), which evaluates:
  kprobe_disabled(p) && list_empty(&op->list)

If unoptimized in-use probes were simply detached (list_del_init),
kprobe_disarmed() would become true prematurely, allowing
free_aggr_kprobe() to free the detour buffer and kfree(op) while a
preempted task was still inside the detour buffer.

By placing unoptimized in-use probes onto gen->cooling_list:
- They are kept off unoptimizing_list so arch_unoptimize_kprobes() will
  never be called twice on them.
- list_empty(&op->list) remains false throughout the Tasks RCU grace period.
- unregister_kprobes() sees !kprobe_disarmed() and defers deleting the
  aggregator.
- When optprobe_finalize_generation() runs after the grace period, it
  safely reclaims or disarms them without any use-after-free window.

6. Flush Synchronization (Andrea Parri's Wait Queue Fix)
--------------------------------------------------------
When wait_for_kprobe_optimizer() flushes the optimizer:
- It checks optprobe_optimizer_busy():
    optprobe_has_queued_probes() || (optprobe_active_gens_count() > 0)
- Instead of using a completion (which suffered from concurrent-waiter
  init_completion() clobber races), it monitors the monotonic counter
  optimizer_passes.
- If work can be dispatched or a generation is ready, it wakes the
  optimizer thread. Otherwise, if a generation is merely in flight, it
  avoids redundant wakeups.
- It sleeps via wait_var_event_mutex(&optimizer_passes, ..., &kprobe_mutex).
  This cleanly releases kprobe_mutex while sleeping and wakes only when
  actual progress is made, preventing CPU-bound spinloops until all
  in-flight and queued generations drain.


Thank you,

---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e

Masami Hiramatsu (Google) (1):
      kprobes: Make optprobe optimizer multi-generational and asynchronous


 kernel/kprobes.c |  420 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 319 insertions(+), 101 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
