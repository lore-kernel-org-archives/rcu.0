Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9521364EAF;
	Fri,  2 Oct 2026 04:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916526; cv=none; b=Iq3fjjoNcf14Irq743YiVfFWX1ksSPQwgTTHzsYBkRZYk4qUq4Wc96fHW2bFsEU80rkoVaZqXU+48i4cfT8itlLOzDeD93G5o6emBjtPmlItEQ3cBO7AQW2K3d0zxfQw6EntyIb/deCF/dycvEZuB9kQi6NnDmirjULMSdQ+Yqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916526; c=relaxed/simple;
	bh=9BokZxA+KUEVU6EbIXOKQdvXERT3s2BxlDbgsQY2trM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hIeiMcmaAzmUbhU72dns08SxMGz9zTJnyKmWZvHKcZM+AyavL/Eu/t/U50lvqcAVVnU7tdsfOlbQXewpIlWKTjam0lUqcQbRX/guRgyVJ1AmLymHMTh/HZ5DgZj65JV/L6X6PqlMc8AZfelDqHpKQBS1IaXRTJitavABfJkVHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYyNYkhS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYyNYkhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A210E1F000FF;
	Fri,  2 Oct 2026 04:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790916524;
	bh=8JQfx3UqxXtPcM7mzUe1J4JBA7Yl9XeKiBpSr0NipXc=;
	h=From:To:Cc:Subject:Date;
	b=OYyNYkhSTvQeWZ0ZvPAVxTotg8hF58akQv5+5Vkl34XEDG8h89WEMFmlfDYc4I5aS
	 S+93g1eNMs+nxF6qUqoaA+d2jqOvEPFLOwdtyaF7B2xhheihu4vTxOtv0iNe8fKIfR
	 HmBMdNEdZEQ8lBwjFaY+Ts9eHait5hKz/AgruDLNO7LnBPAiwvngPRD7j81k7S9MNA
	 WOgVE2OdK1iOFzN0CaOSQywKuOU5t9GGSeurVIibKvfxCO59FIS9Ggrvbip2TginD3
	 C5OMHp66MgKj/cnA+QLmBmma8uFRHnts/NqaVziSVQML3NcCmd/150Ma+o1bc7IXpV
	 ibuz1y1ivP7XA==
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
Subject: [PATCH v5 0/1] kprobes: Make optprobe optimizer multi-generational and asynchronous
Date: Fri,  2 Oct 2026 13:48:37 +0900
Message-ID: <179091651785.526694.220518880874223221.stgit@devnote2>
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

Here is the 5th version of the patch for making the optprobe optimizer
multi-generational and asynchronous.

The previous version is here:

  https://lore.kernel.org/all/179081403098.474106.12959530220684805449.stgit@devnote2/

Changes in v5:
 - Fix comments for each list in optprobe_generation.
 - Rename kprobe_queued() to kprobe_queued_unopt() and make it check
   optprobe_queued_unopt() instead of !list_empty(&op->list).
 - In unoptimize_kprobe(), check !list_empty(&op->list) before
   !kprobe_optimized(p) so that cooling probes (whose OPTIMIZED flag is
   already cleared) are correctly handled rather than returning early.
 - Make sure the probes in freeing_list are removed from hash table
   and disarmed.


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
    Probes waiting for the Tasks RCU grace period to drain all tasks from
    the original instruction bytes before installing the relative jump.
- unoptimizing_list:
    Staging queue for batching unoptimization requests (replacing jumps
    with breakpoints). This is not a wait queue for a grace period; text
    unoptimization happens immediately upon generation dispatch.
- cooling_list:
    In-use probes whose jumps were unoptimized, waiting for the Tasks RCU
    grace period to drain all tasks from the optinsn detour slot.
    Holding them on this list keeps list_empty(&op->list) false, preventing
    concurrent unregister_kprobes() from prematurely freeing the
    aggregator or detour buffer before preempted tasks exit.
- freeing_list:
    Unused aggregator probes that are already unhashed from kprobe_table[]
    and waiting for batch release (freeing detour slots and memory) after
    the grace period completes.
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
     - Probes unregistered while in flight (kprobe_unused()) are
       unhashed with hlist_del_init_rcu() and moved to cur_gen's
       freeing_list for the next pass.
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
     from the kprobe hash table (hlist_del_init_rcu).
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


 kernel/kprobes.c |  471 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 353 insertions(+), 118 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
