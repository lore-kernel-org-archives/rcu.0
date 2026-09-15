Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E523CA487
	for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478270; cv=none; b=aVNEPFfmYVyrN1RpCfUg95O9qdxV1qEf324wn2LgeO2vptXHkq0u028uxQCkzXkFWQY0zDQnFA45iLCkdFeJGRM8KgatPsWRkKp/EoDtaoHpxf0YiqCwVlYErpnm+V6fIyZncUsS/LcWT9EvWCKlRyZVqEXHOog9V1gBV10asO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478270; c=relaxed/simple;
	bh=43eZJz07KhwqgXdlOExlWEsTOX1gVCGqU7n6x7bSOxA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UW0xZA97aw4R3CMwK8VQaJmnfytCfgy3oRLRNgr3lnOMHVM7X2p9x9n2hQIMVUlnBlsiIIc08iWsHBBN17AE/1qe4sel/vPPHv9UXj+Kt/ryMCItjMtIVvbaSNCwXyHGc2QtPxbOOcmPdGCaNB/39a9UdfjP2fTkYjPaaf71Jhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=QLXRO5B0; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="QLXRO5B0"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939695b5741so370064385a.1
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789478265; x=1790083065; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CA3eKaZE6WZpL/SGK3o3QsvQZMbyNxLDZChWtjOtLj4=;
        b=QLXRO5B0i3QWfOyzQQxeXABczGspkoAd2FMUJ69n8lPOL0a2ZaO9LwKrNBNpk8VpV1
         TeqZtvrVusyJufzrWvn3PvHh3k/z9Q0nsyB/w675G323SYcMyevazZhRz1WEyQ9+0Zz3
         PgEISHLJYBfyTjolxTZoszDNaBo4t/ch8LeAB2Qjy4V5NJMHdjQQ5Em50faQ9G4yhLyW
         6LkCNFJC6SZ2sBPdQyBWr0HjGaNr6LhtGpQIdrrHvSwQ4uyJBfGA2Vs6UhoKX5YE864b
         E+FTBqun/Ue/dwnollSRcVJi87bFs3asqdRwKL5mlM27KeUea4QNi5FJIadgzPwaYROS
         Rkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478265; x=1790083065;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CA3eKaZE6WZpL/SGK3o3QsvQZMbyNxLDZChWtjOtLj4=;
        b=dyarFWUwl+ks7RZd+dArfZNL7Gmn92FfzYsLsQtk37Y24Nc4flUv78vmvLV+bnDkE4
         jHKv4jlEL4Q4TSO3VnWs4hiWjrZeCNystY7D4siw7BDomTMpQmZIB4t4rYBPlh/HRJQt
         YXwNK2BgzxQQcUp5F5Jj7PYh98DWrcbga9RQrZvBglEMV0Sa5a+VPUqf1Scd3Vy0FjlY
         S+rDBwHsYc97ZrdELDZ64UfC3f32Jb6WwZLAVYzh8WBZGbm+ZlZUcq9BDBU7RGn6ENpX
         Zn+W/KBmsG6OodZK3p7+JDZqCOLHro+4Yq9dIjVwSL8w5BHWqZeZ3cDZDdiZNQJ2rr3j
         838w==
X-Forwarded-Encrypted: i=1; AKwUvBz4Lx+P5//+uuitIaSR+yWHsd5tue54MzYNKvQMREJ3AXOCbVuxBHvMma7TaETohY0GDLc=@vger.kernel.org
X-Gm-Message-State: AFuF++lZe+blEaOhCJyXrlkoP4tBWvxTGleRdaJoK2VNpYoLmSOefIhA
	ArLqM3CnzWCDPRrOtfRhqr2+dTALxop1hwSrifs95LeZ/FSynl1v3XYN5S/cfJuEbbo=
X-Gm-Gg: AYBFou122yX6CZex7t2383xTjsRCVuMfX43Loz0wDWyZDrlBMmBnsnBB7mvXgYXYMZg
	O0+f73jTm0MUNLUkBPYcxVTcYWnmOJOuwJ91DlmT3I/k1zLyW0Z7RHwjJC3setN02K2Upikjj+H
	mo/ZnPJAgKly/s25cIQGDo5Y5Z7Bq25Cp4OAbdVntG86XuXBhbE2BeAg6lYob97irYfEScMO/Re
	po8IkWAtxuU8aMZhjP5Ng6zFNOGSUgexhg1yKkh75Ju4IrGH7SAM6aQ65Q6ctwg5wLMxdqs1IkG
	ULgus+1eTUS20Srvq5XA0DZ+GKjbZhg6H/RxmTHZfPjtDJ4TaQRunY1bbEFBzdPbw9iPj/IKQnR
	VJQwvkOyPUHkswTmVBJA4Fde2JBwCnaBOTRLtWoH74YmhGPIF3+GkyHpvbrZ8auWUw2xcSKNlKq
	vOwjjEEuc9Huf4hZPJon9bvAFofRVek7r1tbxxtiV4Ep4gfK2cS2FiuL33pLxl+t88MHa4phS6T
	cbl0Bwkj17PmiQxkTjUIvzXXZ8YgZZwL9tg/iNES+TW3Rgp9pduvnns
X-Received: by 2002:a05:620a:470e:b0:939:abe1:ed1b with SMTP id af79cd13be357-93a294d965amr1123242485a.0.1789478264913;
        Tue, 15 Sep 2026 06:17:44 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e86b7424sm1246323785a.32.2026.09.15.06.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:17:44 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v3 00/13] rcu-tasks: build Tasks RCU on Tasks Trace
 readers in trampolines
Date: Tue, 15 Sep 2026 13:17:27 +0000
Message-Id: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGlFqWoC/4WOwU7DMBBEf6XymW1t1w0qJyQkPoAr6mG93hADT
 YLXjVpV+Xccc0ECxHFmZ97OVQmnyKLuVleVeIoSh76I7c1KUYf9C0MMRSurbaP3RoN3kOgEGeV
 NYEzMxzHDh4DTpm3dzjU7ulWlXU5tPFfys3p6fFCHL1NO/pUpL8wl5lEYfMKeusV6Hzfebar52
 5el0UXJQ7rUxZOp+H/HTQY0BOeafeuIjDb3eThHGrEPuKbhWMdN9jvM/A2zBcaI2BgONqD7AZv
 n+RPLhkj2WQEAAA==
X-Change-ID: 20260910-b4-rcu-tasks-preempt-qs-401ff45465c7
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789478261; l=22161;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=43eZJz07KhwqgXdlOExlWEsTOX1gVCGqU7n6x7bSOxA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIUmgCqbuHwL4lKDJsIWfwnYKIqMjOtPbbw4D7yPVkPP1w3qdsMr95Lcgdt8uokycoTCZZYcBR+
 nlRJ2PahVqAY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com/
v2: https://lore.kernel.org/all/20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com/

v2->v3:
- Reworked along the lines Alexei and Paul discussed: no new per-task
  counter, trampolines take rcu_read_lock_trace() (open-coded in asm for
  ftrace_caller, the optprobe template and the sample direct trampolines;
  in the existing C glue for BPF, so the JITs are untouched).
- Tasks RCU on x86-64/arm64 becomes a per-CPU pass over context switches
  and irq-exit reschedules outside trampoline text plus
  synchronize_rcu_tasks_trace(), keeping the call_rcu_tasks() API and
  callers as they are. Classic stays for everyone else.
- Dropped the v2 QS-rule, holdout-scan and resched-kick patches, they are
  subsumed by the above.
- Moved the lockdep annotations in rcu_read_lock_trace()/unlock inside the
  reader and made it (and __srcu_read_lock_fast()) __always_inline so
  nothing runs out of line before the reader is entered.
- Addressed AI review on the staging branch: kprobe optimizer waits out
  tasks already preempted in the jump window; fentry-only BPF images take
  one Tasks RCU round per prog on teardown; holds are released on any
  non-irq context switch (PREEMPT_DYNAMIC none/voluntary); nohz_full user
  CPUs and the user tick count as quiescent; Kconfig excludes
  NEED_SRCU_NMI_SAFE; x86 select depends on DYNAMIC_FTRACE.
v1->v2:
- Only walk the kprobe hash while the optimizer is actually waiting (Sashiko).
- Re-check the kprobe jump window at every QS decision instead of once at
  preemption time (AI review).
- Updated Documentation/RCU for the new rule (AI review).
- Added 14/15 and 15/15 to address Paul's comments.
- Added a comment in trace_recursion.h per Steve.
- No change for the arm64 ftrace_static_tramp_end report, the Kconfig
  dependency already covers it (Sashiko).
- Re-ran the x86-64 QEMU tests, still 0.2-0.3s and clean.

--- What v3 does ---

Following the v2 thread, this version takes Alexei's and Paul's
suggestion: instead of teaching classic Tasks RCU about a new per-task
"in trampoline" count, make the trampolines Tasks Trace RCU readers and
build the Tasks RCU grace period on top of that.

 - Every trampoline whose lifetime Tasks RCU guards enters
   rcu_read_lock_trace() before calling out and leaves it before
   returning. For BPF that is done in the existing __bpf_prog_enter/exit
   and __bpf_tramp_enter/exit glue (the sleepable paths already did), so
   the JIT-emitted trampolines do not change. ftrace_caller (x86-64 and
   arm64), the x86 optprobe template and the samples' direct trampolines
   get the reader open-coded in assembly: trc_reader_nesting++ plus the
   SRCU-fast per-CPU increment, same as the C inline.

 - That leaves the handful of trampoline instructions before the reader
   is entered and after it is left, the BPF glue's own prologue (placed
   in a new .text..rcu_tramp section so it can be recognised), the static
   ftrace stubs and x86 return thunks that carry a trampoline address,
   and the kprobe jump-optimization window, which has no trampoline at
   all. A task can only linger in any of those by being interrupted
   there, and a pure SRCU grace period cannot see it. Such text never
   calls anything that schedules, so the grace period also waits, per CPU
   rather than per task, for a context switch; the one switch that can
   catch a task at an arbitrary instruction, irq-exit preemption, checks
   the interrupted IP first (rcu_tasks_trampoline_text()) and puts a task
   it finds inside on a short holdout list until a later voluntary switch
   or irq-exit check finds it elsewhere. CPUs that have not switched
   after a jiffy get resched_cpu().

 - A grace period is then: CPU pass, drain holdouts,
   synchronize_rcu_tasks_trace(), and one more CPU pass and drain for
   tasks that have since left the reader into the trailing instructions.
   It runs from the existing rcu_tasks kthread, so call_rcu_tasks(),
   synchronize_rcu_tasks() and rcu_barrier_tasks() keep their names and
   every caller is untouched (fentry-only BPF images, which have no
   percpu_ref and one reader per prog, requeue for one grace period per
   prog before freeing). It is bounded by a few jiffies, preempt-off
   latency and an SRCU grace period, independent of how long any task
   runs without sleeping, needs no per-task scan, and makes
   cond_resched_tasks_rcu_qs() unnecessary on these architectures.

 - x86-64 and arm64 select HAVE_RCU_TRAMPOLINE_READERS in the last patch;
   everything before that is inert. Other architectures keep the classic
   implementation unchanged.

Same QEMU test as before (x86-64, PREEMPT_LAZY with PREEMPT_RCU=n and
with PREEMPT_DYNAMIC/PREEMPT_RCU=y, PROVE_RCU, lockdep; 30s in-kernel
spinner with the function tracer, an ftrace kprobe, an optimized kprobe
and the direct samples cycling): synchronize_rcu_tasks() is now 20-25ms
against the spinner (classic: 29.7s; v2: 0.2-0.3s), ftrace instance
teardown ~0.2s, optprobe register+unregister ~0.6s, samples load and
unload in about a second, no warnings and the new return-to-user
assertion quiet. arm64 is build-tested; hardware numbers for both are
still owed.

Things I would like opinions on:

 - Paul: whether hanging this off the rcu_tasks kthread as an alternate
   gp_func is acceptable, or you would rather see classic go away
   outright on these architectures and the API become thin wrappers.
 - The open-coded rcu_read_lock_trace() in ftrace_caller is ~9
   instructions each side versus 2 in v2; it is what "use the existing
   Tasks Trace infrastructure" costs in asm. On arm64 the per-CPU
   increment is an LL/SC add (David's point about per-CPU ops applies).
 - CONFIG_TASKS_TRACE_RCU_NO_MB depends on RCU_EXPERT, so a non-expert
   x86/arm64 build gets the smp_mb() in rcu_read_lock_trace() even
   though ARCH_WANTS_NO_INSTR; the asm follows the C here but that looks
   unintended.
 - Alexei: the non-sleepable BPF enter/exit glue now takes
   rcu_read_lock_trace() on these architectures (compiled out
   elsewhere), and __bpf_tramp_enter/exit bracket the percpu_ref get/put
   with it. Nothing is added to the JITed image.

--- Original email (v1) ---

Tasks RCU only treats a voluntary context switch, usermode or idle as a
quiescent state, because a preempted task may be sitting in a trampoline
that is about to be freed. That was a fine trade when PREEMPT_NONE
servers compiled Tasks RCU away and PREEMPT desktops rarely ran
long-lived in-kernel loops. PREEMPT_LAZY changes both halves at once:
Tasks RCU is now real on server configs, and cond_resched() is a no-op,
so a CPU-bound kthread or kworker only ever loses the CPU by being
preempted, which is exactly the event Tasks RCU refuses to count.

The way this showed up for us was a cgroup writeback worker draining a
very large cgwb for around eleven minutes on an arm64 box. Nothing wrong
with that on its own, but a BPF program detach on another CPU went
bpf_trampoline_update() -> ftrace_shutdown() -> synchronize_rcu_tasks()
while holding trampoline_mutex, forty-odd tasks piled up behind the
mutex, and the hung task detector panicked the machine. The kprobe jump
optimizer is worse in principle: it does synchronize_rcu_tasks() under
kprobe_mutex, text_mutex and cpus_read_lock(), so one long-running
kthread can stall static key updates and CPU hotplug for its whole run.
The current answer is to find each such loop and add
cond_resched_tasks_rcu_qs() to it, which is the kind of annotation
PREEMPT_LAZY was supposed to let us stop writing.

This series tries the other direction: have the trampolines say when a
task is inside them, so that a preemption anywhere else can be a
quiescent state.

 - task_struct grows an int, rcu_tramp_nesting. Every trampoline whose
   lifetime Tasks RCU guards increments it before calling out and
   decrements it before returning: ftrace_caller and its dynamic copies,
   the BPF trampoline (which drops it again around the call to the
   original function, since im->pcref covers that), the x86 optprobe
   template, and out-of-line register_ftrace_direct() trampolines. Only
   current writes it and nested users are balanced, so it is a plain
   non-atomic inc/dec, one load of current plus one RMW per entry/exit.

 - The inc/dec are inside the trampoline, so there is a window of a few
   instructions on each side where the count is zero but the task is in
   (or on its way into) trampoline text. Nothing there can be preempted
   synchronously, only from an interrupt, so the irq-exit preemption path
   looks at regs->ip and holds the count across preempt_schedule_irq()
   when the IP is somewhere the counter cannot cover: outside core and
   module text (all the dynamically allocated trampolines and slots), in
   the static ftrace stubs or the x86 return thunks that still hold a
   direct-call target, in a module that hosts its own direct trampoline,
   or inside the bytes after a kprobe that the jump optimizer may be
   about to rewrite (the one synchronize_rcu_tasks() user that is not
   about trampolines at all).

 - With those in place, rcu_tasks_classic_qs() also clears the holdout
   flag on a preemption when the count is zero, on architectures that
   opt in. x86-64 and arm64 do so here. Everyone else keeps the
   voluntary-only rule and is untouched apart from the (unused) field.

A running holdout already gets poked via rcu_request_urgent_qs_task(),
which makes the next tick set NEED_RESCHED, so with this the resulting
preemption retires it and a Tasks RCU grace period is bounded by roughly
a tick plus the longest preempt-off section rather than by the longest
stretch without a voluntary schedule().

Patches 1-12 are scaffolding and change no behaviour on their own; patch
13 flips the rule and selects the option for the two architectures.

Testing so far is QEMU only: x86-64, PREEMPT_LAZY with PREEMPT_RCU=n,
PROVE_RCU and lockdep, with and without PREEMPT_DYNAMIC. A kthread
spinning in-kernel for 30s with the function tracer, an ftrace kprobe,
an optimized kprobe and fentry/fexit programs attached:
synchronize_rcu_tasks() goes from 29.7s to 0.1-0.3s, tearing down a
DYNAMIC ftrace_ops (tracefs instance function -> nop) from 27s to
0.2-0.8s, and the ftrace-direct sample modules load, fire and unload in
about 2.5s each while the spinner runs, with no warnings and the new
return-to-user assertion quiet. arm64 is build-tested only at this
point; real hardware numbers for both are the obvious next step and I
did not want to sit on the idea waiting for them.

Things I would particularly like opinions on:

 - Whether hooking rcu_tasks_classic_qs() is the right place, or whether
   Paul would rather see this expressed differently inside Tasks RCU.
 - return_to_handler and the rethook/kretprobe trampolines are not
   instrumented. Their C callees take the ftrace recursion lock before
   touching any ops and the trampolines themselves are static text, so I
   believe they do not need it, but I would like Steven and Masami to
   confirm.
 - The register_ftrace_direct() contract change: out-of-line direct
   trampolines now have to maintain the count themselves (the samples
   are converted). I do not know of out-of-tree users beyond BPF, but
   this is the one place an existing user could be silently weakened.
 - Whether arm64 folks are comfortable with the ldr/add/str in
   ftrace_caller and the BPF trampoline, and with treating all of
   ftrace_caller as trampoline text for the IP check.
 - If this holds up, cond_resched_tasks_rcu_qs() and
   rcu_softirq_qs_periodic() become unnecessary on the opted-in
   architectures; I have not touched them here.

Based on v7.3-rc2+ (893e11787f78).

rcu-tasks: let preemption outside trampolines be a quiescent state

v1: https://lore.kernel.org/all/20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com/
v2: https://lore.kernel.org/all/20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com/

v1->v2:
- Only walk the kprobe hash while the optimizer is actually waiting (Sashiko).
- Re-check the kprobe jump window at every QS decision instead of once at
  preemption time (AI review).
- Updated Documentation/RCU for the new rule (AI review).
- Added 14/15 and 15/15 to address Paul's comments.
- Added a comment in trace_recursion.h per Steve.
- No change for the arm64 ftrace_static_tramp_end report, the Kconfig
  dependency already covers it (Sashiko).
- Re-ran the x86-64 QEMU tests, still 0.2-0.3s and clean.
v2->v3:
- Reworked 15/15 to batch resched_cpu() per scan with a cpumask and skip it
  for young grace periods, per Paul.
- Folded Paul's WARN_ON_ONCE() nit into 1/15.

--- Original email ---

Tasks RCU only treats a voluntary context switch, usermode or idle as a
quiescent state, because a preempted task may be sitting in a trampoline
that is about to be freed. That was a fine trade when PREEMPT_NONE
servers compiled Tasks RCU away and PREEMPT desktops rarely ran
long-lived in-kernel loops. PREEMPT_LAZY changes both halves at once:
Tasks RCU is now real on server configs, and cond_resched() is a no-op,
so a CPU-bound kthread or kworker only ever loses the CPU by being
preempted, which is exactly the event Tasks RCU refuses to count.

The way this showed up for us was a cgroup writeback worker draining a
very large cgwb for around eleven minutes on an arm64 box. Nothing wrong
with that on its own, but a BPF program detach on another CPU went
bpf_trampoline_update() -> ftrace_shutdown() -> synchronize_rcu_tasks()
while holding trampoline_mutex, forty-odd tasks piled up behind the
mutex, and the hung task detector panicked the machine. The kprobe jump
optimizer is worse in principle: it does synchronize_rcu_tasks() under
kprobe_mutex, text_mutex and cpus_read_lock(), so one long-running
kthread can stall static key updates and CPU hotplug for its whole run.
The current answer is to find each such loop and add
cond_resched_tasks_rcu_qs() to it, which is the kind of annotation
PREEMPT_LAZY was supposed to let us stop writing.

This series tries the other direction: have the trampolines say when a
task is inside them, so that a preemption anywhere else can be a
quiescent state.

 - task_struct grows an int, rcu_tramp_nesting. Every trampoline whose
   lifetime Tasks RCU guards increments it before calling out and
   decrements it before returning: ftrace_caller and its dynamic copies,
   the BPF trampoline (which drops it again around the call to the
   original function, since im->pcref covers that), the x86 optprobe
   template, and out-of-line register_ftrace_direct() trampolines. Only
   current writes it and nested users are balanced, so it is a plain
   non-atomic inc/dec, one load of current plus one RMW per entry/exit.

 - The inc/dec are inside the trampoline, so there is a window of a few
   instructions on each side where the count is zero but the task is in
   (or on its way into) trampoline text. Nothing there can be preempted
   synchronously, only from an interrupt, so the irq-exit preemption path
   looks at regs->ip and holds the count across preempt_schedule_irq()
   when the IP is somewhere the counter cannot cover: outside core and
   module text (all the dynamically allocated trampolines and slots), in
   the static ftrace stubs or the x86 return thunks that still hold a
   direct-call target, in a module that hosts its own direct trampoline,
   or inside the bytes after a kprobe that the jump optimizer may be
   about to rewrite (the one synchronize_rcu_tasks() user that is not
   about trampolines at all).

 - With those in place, rcu_tasks_classic_qs() also clears the holdout
   flag on a preemption when the count is zero, on architectures that
   opt in. x86-64 and arm64 do so here. Everyone else keeps the
   voluntary-only rule and is untouched apart from the (unused) field.

A running holdout already gets poked via rcu_request_urgent_qs_task(),
which makes the next tick set NEED_RESCHED, so with this the resulting
preemption retires it and a Tasks RCU grace period is bounded by roughly
a tick plus the longest preempt-off section rather than by the longest
stretch without a voluntary schedule().

Patches 1-12 are scaffolding and change no behaviour on their own; patch
13 flips the rule and selects the option for the two architectures.

Testing so far is QEMU only: x86-64, PREEMPT_LAZY with PREEMPT_RCU=n,
PROVE_RCU and lockdep, with and without PREEMPT_DYNAMIC. A kthread
spinning in-kernel for 30s with the function tracer, an ftrace kprobe,
an optimized kprobe and fentry/fexit programs attached:
synchronize_rcu_tasks() goes from 29.7s to 0.1-0.3s, tearing down a
DYNAMIC ftrace_ops (tracefs instance function -> nop) from 27s to
0.2-0.8s, and the ftrace-direct sample modules load, fire and unload in
about 2.5s each while the spinner runs, with no warnings and the new
return-to-user assertion quiet. arm64 is build-tested only at this
point; real hardware numbers for both are the obvious next step and I
did not want to sit on the idea waiting for them.

Things I would particularly like opinions on:

 - Whether hooking rcu_tasks_classic_qs() is the right place, or whether
   Paul would rather see this expressed differently inside Tasks RCU.
 - return_to_handler and the rethook/kretprobe trampolines are not
   instrumented. Their C callees take the ftrace recursion lock before
   touching any ops and the trampolines themselves are static text, so I
   believe they do not need it, but I would like Steven and Masami to
   confirm.
 - The register_ftrace_direct() contract change: out-of-line direct
   trampolines now have to maintain the count themselves (the samples
   are converted). I do not know of out-of-tree users beyond BPF, but
   this is the one place an existing user could be silently weakened.
 - Whether arm64 folks are comfortable with the ldr/add/str in
   ftrace_caller and the BPF trampoline, and with treating all of
   ftrace_caller as trampoline text for the IP check.
 - If this holds up, cond_resched_tasks_rcu_qs() and
   rcu_softirq_qs_periodic() become unnecessary on the opted-in
   architectures; I have not touched them here.

Based on v7.3-rc2+ (893e11787f78).

---
Josef Bacik (13):
      entry: Pass pt_regs to irqentry_exit_cond_resched()
      rcu-tasks-trace: Inline rcu_read_lock_trace() and annotate inside the reader
      rcu-tasks: Add a Tasks RCU implementation for reader-marked trampolines
      kprobes: Expose the optprobe jump window to Tasks RCU
      ftrace: Mark modules hosting direct-call trampolines for Tasks RCU
      bpf: Take a Tasks Trace reader in the trampoline glue
      x86/ftrace: Take a Tasks Trace reader around ftrace_caller's call-out
      x86/kprobes: Take a Tasks Trace reader in the optprobe template
      arm64: ftrace: Take a Tasks Trace reader around ftrace_caller's call-out
      samples: ftrace: Make the direct-call trampolines Tasks Trace readers
      rcutorture: Make Tasks RCU readers Tasks Trace readers where required
      rcu-tasks-trace: Assert no reader is held on return to userspace
      x86, arm64: Build Tasks RCU on Tasks Trace readers in trampolines

 .../RCU/Design/Requirements/Requirements.rst       |  20 +
 Documentation/RCU/checklist.rst                    |   7 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/kernel/asm-offsets.c                    |   8 +
 arch/arm64/kernel/entry-ftrace.S                   |  74 ++++
 arch/arm64/kernel/ftrace.c                         |  20 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/kernel/asm-offsets.c                      |   8 +
 arch/x86/kernel/ftrace.c                           |  43 ++
 arch/x86/kernel/ftrace_64.S                        |  69 +++
 arch/x86/kernel/kprobes/opt.c                      |  44 ++
 arch/x86/kernel/vmlinux.lds.S                      |   4 +
 arch/x86/xen/enlighten_pv.c                        |   2 +-
 include/asm-generic/vmlinux.lds.h                  |  11 +
 include/linux/bpf.h                                |   1 +
 include/linux/irq-entry-common.h                   |  14 +-
 include/linux/kprobes.h                            |   8 +-
 include/linux/module.h                             |   7 +
 include/linux/rcupdate.h                           |  32 +-
 include/linux/rcupdate_trace.h                     |  29 +-
 include/linux/sched.h                              |   1 +
 include/linux/srcutiny.h                           |   4 +-
 include/linux/srcutree.h                           |   5 +-
 kernel/bpf/trampoline.c                            | 107 ++++-
 kernel/entry/common.c                              |  14 +-
 kernel/fork.c                                      |   1 +
 kernel/kprobes.c                                   |  50 +++
 kernel/rcu/Kconfig                                 |  28 +-
 kernel/rcu/rcutorture.c                            |  10 +
 kernel/rcu/tasks.h                                 | 480 ++++++++++++++++++++-
 kernel/rcu/update.c                                |   2 +
 kernel/trace/ftrace.c                              |  39 ++
 samples/ftrace/ftrace-direct-modify.c              |   9 +
 samples/ftrace/ftrace-direct-multi-modify.c        |   9 +
 samples/ftrace/ftrace-direct-multi.c               |   5 +
 samples/ftrace/ftrace-direct-too.c                 |   5 +
 samples/ftrace/ftrace-direct.c                     |   5 +
 samples/ftrace/ftrace-direct.h                     | 126 ++++++
 38 files changed, 1241 insertions(+), 62 deletions(-)
---
base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
change-id: 20260910-b4-rcu-tasks-preempt-qs-401ff45465c7

Best regards,
--  
Josef Bacik <josef@toxicpanda.com>

