Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB983A6B7F
	for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701721; cv=none; b=NOi8zFwuyZvF3BP8o6t7dXP/+HkPZsue9sCFo1AIoTblHzLvwHukOJXyxC4s4X7owrlYEizyJOH3ANjDpXwqakHTU4f6psz6/GWYGKoqquj0dsSQXata/5Xtqq5vagz6PpTPeE+qJWnVVClcvZWrqozhFnmPrQo8rulRJZCpJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701721; c=relaxed/simple;
	bh=x05sLz026DuYGlUHpgPWY+eL4sujIHS80K0KlkZowcs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VgG+bfsqx7jkFlW+AZeX+CvjpzBxZaeEAc/61cjJjgWWl2R8zDK+P4BpYi2DYidSpbkeNs9yyNaprg/HAtT1HjheqDaxtceOqX6CcMWClznuus3vta7+jMecVYSUeKiVAiqtYtGeCB8WiRs3c20sghP4a3ylPZRvLx9yhSu/0NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=BVvHjzKw; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="BVvHjzKw"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93be29bb454so646729885a.1
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790701717; x=1791306517; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NXGmGXAhzufjE2WXuYgrhg2tIz1+eqndfL3/qHkLVjs=;
        b=BVvHjzKwMhG8UFM3M3RZEX1d4LMUfrhVvVkYhRdwa8swE5vvf0OOCfpvdP+p+FnQd8
         UsDj4UetqA0OZhcfA1w4qbZq7lVjjHBuyQYkYwWS0qwSVBzubIrlGUxlnL3daGmy9dDF
         af4noIL2PkXxxx9nyWVv1pciTSNq5Os1xzQtGOVqwjRm58lmMR5qFjxRYVXfe5Ei3vMv
         XvcCfAM7kJZ1q6j14pjrtvQNGmLiMf7l/64HidsJ0IQ2C4MpTBoGvGUrhIOXWlRmfKk5
         TNa2MFD5wI7nGgGZQzpcCu2ryUcwHGroCmw6X+YB1+FML+1vSUvurrMUAGPmuQ/7AXvO
         hhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790701717; x=1791306517;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NXGmGXAhzufjE2WXuYgrhg2tIz1+eqndfL3/qHkLVjs=;
        b=LP26KzXerNPPmT1u68iAUusBCYivD4IsLxMEUtMOX9Vvgn1X7BqK+IIfO7g3CQhqJP
         0HiQbs0gMV8zUKqv0Os5Q1OhxqY1hKV0H562wHohMcsC+i89fbR7TtUV3OoHnWrAnN9y
         xLOnCvnnnDAG9Te8hb8MM+e/QKuJTiSg+XEhRdqrDTI9Ew+tNZa6Y/RdSd46YmVnIkLR
         FFGSrFvBY6Apn6jTTRobH3y2S8W7ma/pI24ecfO6bH43TOzMmwNR4m25xcM3bnj1it3s
         e56zAFSRjm0Lv2LQiouiiqH5I3I2gWamkCsLUuFoNw6wq5GBak8tW70ffww4Qb0fYp1y
         u98A==
X-Forwarded-Encrypted: i=1; AKwUvBybC4c1Sf1chKg5ukLbwN6Z10jCMlo5v8lLUsUenQOQVD7ydKu2doW7CdNryQe1ey2axyI=@vger.kernel.org
X-Gm-Message-State: AFuF++n/S7OD1BnFyNntj+t5LYpczxLseVq1mPqJWQV8FV1ZokKWDczH
	577uQchKqkWfijEFaEAqjxkfCN4e7r/zr47yDTFYEfy8i/H1UkUWtistip/8ntphsnU=
X-Gm-Gg: AYBFou1M+yI8Yo2fFGsNUk7MtYFUdNAXo0dl2Q9R4S6qBQe18KpEkJ1QOyMyaCM1Z0l
	ihQoFJRvsDWoz9RLFwvgHqeS3whCOKpCA/dlEG3mZ72Dze8BnGEpOCIEMRZaRMe9I4iWPnHgpNG
	NJBP0eMtVEIZ2ykKFMWFB+DBfhnP65rPisyvyRvpCtK2uZMlq3S0yUQ2qWoymD3Lcdx1un80PR8
	fVN47qH9X17vXHSpLdpqHariPOqwYt2QNFubBGyL2go162TYJ1yPl2+Qop8MgSdmlH+8M+pqTv8
	rU7jZ6k7jtFCrgnVcC/OlTzUshVjWxQJ6PzotAbjexwkBi/pKswK2z6iedER0ElHx8YQuv4wutp
	tAd3Z/yI91rHkH+vbMT08skVDk/YT5/z5vZ8vkxkbB4g54y9AgPKzqQC/jF92ApN/vgUOyLyLIZ
	qijf1Jqe9kks46RnuRvmYz11LjEO3jNOXt4ZmYHbQYxUjE6Vt8yJUGZzbwQiEDizWa6UK/h3zAr
	z0wZaCpmtCWpAA=
X-Received: by 2002:a05:620a:2988:b0:939:1864:343e with SMTP id af79cd13be357-93c9fb8ed6amr19965085a.40.1790701716969;
        Tue, 29 Sep 2026 10:08:36 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f4601a9sm15957985a.13.2026.09.29.10.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:08:35 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v6 00/14] rcu-tasks: build Tasks RCU on Tasks Trace readers
 in trampolines
Date: Tue, 29 Sep 2026 17:07:17 +0000
Message-Id: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEbwu2oC/4XPwU7EIBAG4FfZcBYX6ECtJ9/DeJjC4KK7bYVus
 2bTdxfqpYltPP4D8/FzZ4lioMSeD3cWaQop9F0O5uHA7Am7d+LB5cyUUEY0UvAWeLRXPmL6THy
 IRJdh5F+Jg5Degwajbc3ydj7y4bbIr2+/OV3bD7Jj4cqNFhPxNmJnT2V0Ho4tHJfh1gNl4xTS2
 Mfvpewki/x/r0lywR2AaTxYK4V8GftbsAN2Dh9tf2Gl3KTWmNzHVMYIEY0kpxzCJlatMb2PVRk
 T6CphwWqiehODNfa0j0HGTOUFNc40xmx/U68wpfYxnTGQwuu6rkWL7g82z/MPFmPAxTsCAAA=
X-Change-ID: 20260910-b4-rcu-tasks-preempt-qs-401ff45465c7
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Boqun Feng <boqun@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 rcu@vger.kernel.org, bpf@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790701681; l=14794;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=x05sLz026DuYGlUHpgPWY+eL4sujIHS80K0KlkZowcs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKojAkS12poS7JsTmhTE5Kqm+Meq6titsqb3cAPUtExA0/WxS02Nd+sjslEIG5dow4LDijv6NHR
 OSqbdwM07Pwc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com/
v2: https://lore.kernel.org/all/20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com/
v3: https://lore.kernel.org/all/20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com/
v4: https://lore.kernel.org/all/20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com/
v5: https://lore.kernel.org/all/20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com/

v5->v6:
- New 1/14: let TASKS_TRACE_RCU_NO_MB's ARCH_WANTS_NO_INSTR default apply
  without RCU_EXPERT; before it every reader here carried two smp_mb()s on
  a normal config.
- Bare-metal numbers (Graviton4, Ice Lake) below and in the arch patches,
  including Alexei's suggested C-helper placement for BPF (Masami, Alexei).
- irq-exit hook is now just the IP store plus the text check, no per-CPU
  list; rcu_tasks_wait_irq_preempted() scans the task list and the classic
  exit lists instead (Frederic).
- x86: also treat the FineIBT-BHI __bhi_args thunks as trampoline text,
  since a struct_ops trampoline's CFI preamble calls them before it can
  take its reader (BPF CI bot).
- Rename rcu_tasks_trace_assert_idle() to _assert_not_held(); consolidate
  the kprobe_optimizer_waiting comments (BPF CI bot).
v4->v5:
- Dropped the RFC tag.
- JIT emitters: *_off naming and offsetof() for the srcu_ctr counters
  instead of hardcoded 0/8 (Alexei); note the open-coded copies at
  rcu_read_lock_trace().
v3->v4:
- BPF: the reader is emitted by the x86-64/arm64 JIT around the
  fentry/fmod_ret and fexit regions instead of taken in the C glue (Alexei).
- An idle CPU only counts as quiescent while in an RCU EQS (Sashiko).
- Dropped the rcu_read_lock_trace() lockdep/inline patch; BPF CI bot nits.
v2->v3:
- Reworked per Alexei and Paul: trampolines take rcu_read_lock_trace(),
  and Tasks RCU on x86-64/arm64 becomes a per-CPU pass plus a Tasks Trace
  grace period instead of a new per-task counter.
v1->v2:
- Sashiko/AI review fixes, Paul's and Steve's comments (see v2 changelog).

What it does now:

Every trampoline whose lifetime Tasks RCU guards (ftrace_caller and its
copies, the optprobe template, BPF trampolines, out-of-line direct-call
trampolines) takes rcu_read_lock_trace() around its call-out, open-coded
in asm / by the JIT. That leaves the few trampoline instructions outside
the reader, the static ftrace stubs and x86 return thunks that carry a
trampoline address, and the kprobe jump-optimization window. A task can
only linger in those by being interrupted there, so on x86-64 and arm64
the Tasks RCU grace period becomes: wait for every CPU to pass through
__schedule() or sit in an EQS (the irq-exit preemption checks the
interrupted IP first and briefly makes a task caught in such text a
holdout), then synchronize_rcu_tasks_trace(), then one more pass for the
trailing instructions. It runs from the existing rcu_tasks kthread, so
call_rcu_tasks() and friends keep their names and callers; there is no
task-list scan and no dependence on voluntary context switches, and
cond_resched_tasks_rcu_qs() becomes unnecessary there. Other
architectures keep the classic implementation.

Testing, on bare metal this time (KVM guests, 4 vCPUs, on an AWS
Graviton4 c8gd.metal-24xl and an Ice Lake 8375C c6id.metal), PREEMPT_LAZY
with PREEMPT_RCU=n. Functional, with PROVE_RCU and lockdep:
synchronize_rcu_tasks() against a 30s in-kernel spinner goes from 29.6s
to 60/316ms (arm64, plain loop / spinlock loop) and 29.5s to 18/100ms
(x86-64); ftrace instance teardown, optprobe register+unregister, the
direct-call samples and fentry/fexit attach+detach all complete in well
under a second with the spinner running; no warnings, return-to-user
reader assertion quiet.

Cost of the readers, as getppid() ns/call with things attached to
__do_sys_getppid, no lockdep, CONFIG_TASKS_TRACE_RCU_NO_MB=y (median of 6
runs of 5s, base -> this series; "C" is the same with the BPF reader taken
in __bpf_tramp_enter/exit + before/after-orig-call helpers as Alexei
suggested, instead of emitted by the JIT):

                   Graviton4                  Xeon 8375C
                   base   series   C          base   series   C
  nothing          87.0    87.8   87.7        70.3    70.5   69.8
  function tracer 103.7   105.6  105.9        87.2    88.0   88.2
  kprobe event    215.5   215.6  216.4       119.9   123.2  124.7
  fentry          101.3   109.7  111.3        77.0    77.9   78.3
  fexit           118.8   136.2  139.3        78.4    80.7   80.5
  fentry+fexit    134.1   151.0  154.5        83.2    85.6   85.5

So roughly 1ns per lock/unlock pair on x86-64 and 2ns (ftrace_caller) to
8.5ns (BPF trampoline) on arm64, where it is dominated by the LL/SC
per-CPU increment; fexit has two pairs (the arm64 kprobe is BRK-based
and does not go through a trampoline, hence no change there). The
C-helper placement is never
cheaper and costs an extra 1.5-3.5ns on arm64, so v6 keeps the reader in
the JIT; happy to switch if the lockdep visibility is judged worth it.
Without 1/14 (i.e. with the smp_mb()s) the same table read +10-12ns per
pair on both machines, which is what a distro config got until now.

Notes:
 - This is the alternate-gp_func-on-the-rcu_tasks-kthread form; folding
   the IP check into core RCU along the lines Frederic sketched is left as
   the follow-on Paul suggested.
 - The open-coded reader is ~9 instructions each side in ftrace_caller and
   at four points in the BPF trampoline. rcu_read_lock_tasks_trace() would
   be shorter but needs a slot for the cookie; also a possible follow-on.

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

---
Josef Bacik (14):
      rcu-tasks-trace: Let TASKS_TRACE_RCU_NO_MB default on without RCU_EXPERT
      entry: Pass pt_regs to irqentry_exit_cond_resched()
      rcu-tasks: Add a Tasks RCU implementation for reader-marked trampolines
      kprobes: Expose the optprobe jump window to Tasks RCU
      ftrace: Mark modules hosting direct-call trampolines for Tasks RCU
      x86/ftrace: Take a Tasks Trace reader around ftrace_caller's call-out
      x86/kprobes: Take a Tasks Trace reader in the optprobe template
      bpf, x86: Take a Tasks Trace reader in the trampoline around its call-outs
      arm64: ftrace: Take a Tasks Trace reader around ftrace_caller's call-out
      bpf, arm64: Take a Tasks Trace reader in the trampoline around its call-outs
      samples: ftrace: Make the direct-call trampolines Tasks Trace readers
      rcutorture: Make Tasks RCU readers Tasks Trace readers where required
      rcu-tasks-trace: Assert no reader is held on return to userspace
      x86, arm64: Build Tasks RCU on Tasks Trace readers in trampolines

 .../RCU/Design/Requirements/Requirements.rst       |  24 ++
 Documentation/RCU/checklist.rst                    |   7 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/kernel/asm-offsets.c                    |   8 +
 arch/arm64/kernel/entry-ftrace.S                   |  74 ++++
 arch/arm64/kernel/ftrace.c                         |  20 +
 arch/arm64/net/bpf_jit_comp.c                      |  93 +++++
 arch/x86/Kconfig                                   |   1 +
 arch/x86/kernel/asm-offsets.c                      |   8 +
 arch/x86/kernel/ftrace.c                           |  52 +++
 arch/x86/kernel/ftrace_64.S                        |  69 ++++
 arch/x86/kernel/kprobes/opt.c                      |  44 ++
 arch/x86/kernel/vmlinux.lds.S                      |   4 +
 arch/x86/net/bpf_jit_comp.c                        | 107 +++++
 arch/x86/xen/enlighten_pv.c                        |   2 +-
 include/linux/irq-entry-common.h                   |  15 +-
 include/linux/kprobes.h                            |   8 +-
 include/linux/module.h                             |   7 +
 include/linux/rcupdate.h                           |  24 +-
 include/linux/rcupdate_trace.h                     |  13 +
 include/linux/sched.h                              |   1 +
 kernel/entry/common.c                              |  14 +-
 kernel/fork.c                                      |   1 +
 kernel/kprobes.c                                   |  44 ++
 kernel/rcu/Kconfig                                 |  32 +-
 kernel/rcu/rcutorture.c                            |  10 +
 kernel/rcu/tasks.h                                 | 458 ++++++++++++++++++++-
 kernel/rcu/update.c                                |   2 +
 kernel/trace/ftrace.c                              |  39 ++
 samples/ftrace/ftrace-direct-modify.c              |   9 +
 samples/ftrace/ftrace-direct-multi-modify.c        |   9 +
 samples/ftrace/ftrace-direct-multi.c               |   5 +
 samples/ftrace/ftrace-direct-too.c                 |   5 +
 samples/ftrace/ftrace-direct.c                     |   5 +
 samples/ftrace/ftrace-direct.h                     | 126 ++++++
 35 files changed, 1315 insertions(+), 26 deletions(-)
---
base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
change-id: 20260910-b4-rcu-tasks-preempt-qs-401ff45465c7

