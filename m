Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D94248F72
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135786; cv=none; b=DZfV9KTQXUKF8fZ05Jy0fQqWZidv8Cn4HtxbczDFqkLRdBLluNbJMhyx6ioKgTflyUNBD/trEgKmIaNS2AzVC8+kmmiUVGEMHPvIqf7xk48C0zDdm9XnOtPpdVi4+8nYApm78IWJkfz5iFed//9Vm8iImkh5L+LY3XsWP+Va7NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135786; c=relaxed/simple;
	bh=ciq/+qqHqSRSh7FRYtq3aWelW6Wh5G33c0OaJbqUUSk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O+6wTuhQSTOF2U8KPw2tUfm3eEUa1BB8PMALW5s4QDJ7836KMrg84DufqyN1WEPUAXf7IzfOkRvJs8T3R43kIlOwNYnoQx2sBh+M6nsMNJQHOEUp5qM4Vou3wlhPjxTqdatnSV0gfIKmMjC+4snW0qybbZn+I0Ta6RDJNaJaYTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=DFGJgU7t; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="DFGJgU7t"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-855c26cf490so5669807b3.0
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135784; x=1789740584; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HYwKQGYnNu1I2ntnnDPNcKeVNgWeStLdN/CP2LgAeVM=;
        b=DFGJgU7tetnlOWunNDJ7nxnwE03Gae7pMcCYJQRLH02qHnZzFhLC0KvqcYSOgicXGK
         vvB66QBgC1MrfUPP2GmgGpdQ2sqds+jDUj7bE5inVXUS+F2S5DkpvtPoIAkl2dP2L7Ea
         yT6tYnslpn64YZDZbLDGamhk/VOAtyDIYFSr8XiIuWxDi14b/SQzENnCavQ07fr1UvL7
         oQri8GfXOKJxqYYctq3rbcsbgJPEBh/7lBDkIsr+BFync+plECVYazCnoovtBNpF0gmM
         FCB/TDalkKwxBw1ofWz0h8kcxosqconDkQlTDo61CufE45Plmnt1TxavNJsLqyMYBI9a
         Evhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135784; x=1789740584;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HYwKQGYnNu1I2ntnnDPNcKeVNgWeStLdN/CP2LgAeVM=;
        b=onBt3I9vorJkGseH7DpMiT5+br0tvn3OVupZjkLe0yj/I+PZIcWWp1b5x9CxxFp9lS
         5erUQjqzo0Rnqjf5fAdziW2MVMAWOQxxwAIbQjw99rEQglm2EbLXjQ+/JMpL4LK6TCtZ
         DINcaz0zEugfVe4Iz1J9PSD6HavM3dJZWNKgbMwY5pU2SVzDK0YM6yAsRrjf3ufvN6Oh
         4Cbsr6fMUSQqh6XTNp6euKEw18QoyIiIcoOJQ5GGtVPqasfEs6dr734U8P9WCwouGOLc
         vDG480xyrg1/ouXT5465m0VZDrfColC51HJz4dSRHPFtXvRbnzQZYAQfKP5VvieneqfJ
         A4xA==
X-Forwarded-Encrypted: i=1; AKwUvBx8Qzccdv1Om0V8Nh8ziagJGoR9dmf/zbc6f6qt2tWq/pBpxXNNcxzpae4wWFJd4sNxaHU=@vger.kernel.org
X-Gm-Message-State: AFuF++mFUh+YDoo11Frm+JcjwyZQZAdEA8HoA3cxsjOS/iOcXGAqCgVs
	jx2Pp2M33wWctNpPtGyX05u45Zx1x9Sg49NAgIGxj3+tTfYpHyokxL15dLPL6yaVtzk=
X-Gm-Gg: AYBFou3nne5KZAfQjLouAOZfpHDV4vwLuHnZQ/6w3/hQYU2veRZkdfetEDikFZhTKN8
	yK6iVRFWhjTvSvE+us9ehMYgPJVFXFLfHA04A2bfR1zrOu7+XrjVSQkZNUENtRaH1Iaj71+0Iot
	2htCc+YZukLnH75w9gH5UtavWNK/WrSpuh95kJP6mCGU4lRbshbCugpIPlpqaD8vMS148vL2Ve/
	Fm07JpN/MiJ4qAWZLPtgS78KyinFzHFlHspMXA+2IEOZYYPuHDAp1XdDGYycb0CshkPkyaBR1to
	ESi1FiYbc0nwTHqNG64wjDPu+wdoxPuly39pLQX0qByVVU2RtKM9EnZh+1fGYQt7THghb5QGdDB
	TVmxfRVeEhSxz6wW9HM7Oee0Oy74scAeIvOYvDLlmy49S31jkOIBjvqHgjrkfsWsCHYYOpdvVVM
	f4TLrDUakNVv1Wd2+H1hUxCoZDm51N7fLc6XZg7FJeugJoBYUwiHLdQ3qaIJlfEWM5dfld+PB4S
	2MNe6ZqKhQtMr+w2Va/nGxZyt0u/qSBN8NGePbjc/NkXeBgw91+aTD7
X-Received: by 2002:a05:690c:397:b0:869:1ab2:33aa with SMTP id 00721157ae682-884afd12eb1mr15658867b3.20.1789135783644;
        Fri, 11 Sep 2026 07:09:43 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ecc38105sm175654485a.4.2026.09.11.07.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:09:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v2 00/15] rcu-tasks: let preemption outside trampolines
 be a quiescent state
Date: Fri, 11 Sep 2026 14:08:38 +0000
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGgLpGoC/4WOzQ6CMBCEX8Xs2ZWWFAyeTEx8AK+GQ7sUqT+A3
 UowhHcX8GricWZnvp0B2HpnGXarAbztHLumnkS8XgFVur5YdMWkIRZxKjIp0Cj09MKg+cbYems
 fbcAnoxKyLFWi0oS2MLWnU+n6hXyG0/EA+dfkl7laCjNzjhnNFo3XNVWzdW8jo6LF/PVlblSOQ
 +Pfy+JOLvi/4zqJAgul0qxURFLIfWh6R62uC72h5gH5OI4f1jKPpQwBAAA=
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
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135736; l=9888;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ciq/+qqHqSRSh7FRYtq3aWelW6Wh5G33c0OaJbqUUSk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAo5VaRxmnCLTA74sHK3/IXlJk4maBdHJ/o8BcYQaWxLTsL0V/6t0pY/lmq70yYasPVK7mviH+F
 JmwKt5LbXdQw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com/

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
Josef Bacik (15):
      rcu-tasks: Add per-task trampoline nesting count
      entry: Pass pt_regs to irqentry_exit_cond_resched()
      rcu-tasks: Hold trampoline nesting across irq-exit preemption in trampoline text
      kprobes: Let Tasks RCU recognise tasks preempted in an optprobe jump window
      ftrace: Mark modules hosting direct-call trampolines for Tasks RCU
      x86/ftrace: Maintain Tasks RCU trampoline nesting in ftrace_caller
      x86/kprobes: Maintain Tasks RCU trampoline nesting in the optprobe template
      bpf, x86: Maintain Tasks RCU trampoline nesting in the BPF trampoline
      arm64: ftrace: Maintain Tasks RCU trampoline nesting in ftrace_caller
      bpf, arm64: Maintain Tasks RCU trampoline nesting in the BPF trampoline
      samples: ftrace: Maintain Tasks RCU trampoline nesting in direct-call trampolines
      rcutorture: Bracket Tasks RCU readers with trampoline nesting
      rcu-tasks: Treat preemption outside trampolines as a quiescent state
      rcu-tasks: Retire switched-out tasks with no trampoline nesting at scan time
      rcu-tasks: Kick running holdouts through the scheduler

 .../RCU/Design/Requirements/Requirements.rst       |  28 +++-
 Documentation/RCU/checklist.rst                    |   8 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/kernel/asm-offsets.c                    |   3 +
 arch/arm64/kernel/entry-ftrace.S                   |  35 +++++
 arch/arm64/kernel/ftrace.c                         |  16 +++
 arch/arm64/net/bpf_jit_comp.c                      |  46 +++++++
 arch/x86/Kconfig                                   |   1 +
 arch/x86/kernel/asm-offsets.c                      |   3 +
 arch/x86/kernel/ftrace.c                           |  37 ++++++
 arch/x86/kernel/ftrace_64.S                        |  43 +++++++
 arch/x86/kernel/kprobes/opt.c                      |  20 +++
 arch/x86/kernel/vmlinux.lds.S                      |   4 +
 arch/x86/net/bpf_jit_comp.c                        |  43 +++++++
 arch/x86/xen/enlighten_pv.c                        |   2 +-
 include/linux/irq-entry-common.h                   |  14 +-
 include/linux/kprobes.h                            |   8 +-
 include/linux/module.h                             |   7 +
 include/linux/rcupdate.h                           |  86 ++++++++++++-
 include/linux/sched.h                              |   2 +
 include/linux/trace_recursion.h                    |  11 ++
 kernel/entry/common.c                              |  38 +++++-
 kernel/fork.c                                      |   2 +
 kernel/kprobes.c                                   |  46 +++++++
 kernel/rcu/Kconfig                                 |  17 ++-
 kernel/rcu/rcutorture.c                            |   6 +
 kernel/rcu/tasks.h                                 | 141 ++++++++++++++++++++-
 kernel/rcu/update.c                                |   2 +
 kernel/trace/ftrace.c                              |  39 ++++++
 samples/ftrace/ftrace-direct-modify.c              |   9 ++
 samples/ftrace/ftrace-direct-multi-modify.c        |   9 ++
 samples/ftrace/ftrace-direct-multi.c               |   5 +
 samples/ftrace/ftrace-direct-too.c                 |   5 +
 samples/ftrace/ftrace-direct.c                     |   5 +
 samples/ftrace/ftrace-direct.h                     |  64 ++++++++++
 35 files changed, 776 insertions(+), 30 deletions(-)
---
base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
change-id: 20260910-b4-rcu-tasks-preempt-qs-401ff45465c7

Best regards,
--  
Josef Bacik <josef@toxicpanda.com>

