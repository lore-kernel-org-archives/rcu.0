Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF30B58E2C4
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066255; cv=none; b=H97ZtT5iMB3xTfy6TSThaIr6Li+q97ehbIkX4pws2TEb/V1+rcBZ+OnYS/2EGcyKRF5vFoYvovOU4sBr0eVS+/8mjAb0O9tB3UaiVe4UYLwr/fkB05YQijxMy1DFKD+25pB/BSTM8haId8HjCm066FF+sNXMqmA+7E9GpTcyYA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066255; c=relaxed/simple;
	bh=5rKSSYdl2NLVDmAkfdBaLImmLnTw/j3b/n1VGeW4msc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f+4JNgQVz+aYUFZsd8dOC5A/SCMXtRluu6B0Hs/3hdkb0a9PwA+KH4wVQ+fqMU8e1FtEVnfW50RbSIXTZmSkpCq3BQqUDuVW/ZNtNDy2R5S/RVUACyV05GdZKIN5rVkvgfnlCqSw7au4RcNdT4JeBXV8DQ5fPb4x1oqieOJiFl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=jz9Gm+cg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="jz9Gm+cg"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-939adff838bso1707485a.0
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066249; x=1789671049; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=04sGP5fC6+EWQ5zQqoL4aDa3rNDPdOaXISOWt+zm6Kw=;
        b=jz9Gm+cgGUs1xQF2/GuzRkLxBAc8+mpQ1Tc1X4EWpBhkou2Pak3LzXFYAG0MGdvUs+
         juIKQIdd0GMSDi6czQ0RgJjM0w5aBjyUGYhgfMBOSOiLX7g4dB13PU2ZtY8gMBohqLwP
         oG4mOOZwciiL/oltcklCn3c4JyqBBMQsiZapKQzaPB2A9JEEUm2/oTQPPBWAKltm0KiO
         S5zSvn4g7fDJxB/9RH4LYft1/nZGp0TNpd0qPPwfGcaMYbLU2Xt7yg5r0C1gU5byDYmk
         nwdyWzq0cqDyAHfmvLDknLHsoAbVK6iuG0x+jLZAF1EQOsz/9uECot6OgEkLnSadHFUE
         2bjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066249; x=1789671049;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=04sGP5fC6+EWQ5zQqoL4aDa3rNDPdOaXISOWt+zm6Kw=;
        b=lpgu1fFTRqKi2HNfieLvT9Yqd+RBwqgYs+t9bLQD3+gFGWpaBndjk5MIje14vn4aXN
         PMa4IVo2WhbEBKOdqupZU4b8uomOM+ci03xxf7yn49lEB6Xlpl+gJTAxTduBsTe53GoI
         bTwcXRWCN9D7gNoiT+uyNqmm00P0ddFoKVnxQqOlCWPd6KsMGL1FZ3xLYG5+4hh8GIqh
         edmGUde3uyJw7RxblrFVFj1FLZQV4LQmOuNcc80uMpNALoW8L97Cs4j46jJIeXmgEUwI
         WOAA+b8cBrqz4SaJ+5DcxI5ofX3vhAw92yjjkyWXY0PQ8IoDacEAzEbfmS8lXFnpthAY
         294w==
X-Forwarded-Encrypted: i=1; AKwUvBzwjru5t9vVcVTa4dLKJIiqsetiiERxSsmdHdFlf7AytzdEH4kB4ZdysvI8sgeHoC8VYXg=@vger.kernel.org
X-Gm-Message-State: AFuF++nEckppnzd9ey+94acQwUhjSgCYrLFMLlz4pX2/27lS89fZO80M
	cKxhr9PXe7IG9R0ooFByR1Luo1V6adaauPGTGv7E/8hJB+2b0i9cc5SSG/X6v00W35A=
X-Gm-Gg: AYBFou0Y6AfjSNRF4XgfJJJfJHXETwZhZwpy/c1amKHicF5L62HeG6SV5ANHRcmXNYy
	AsiqO0W8U2ZNdl59RZEjtujqOGALK5tDVQB9ZqOhgOLPQLog4afL5KiAMC2ev/kWAFu4+qJiEjt
	F7suh6ovqDdCWdZ7F+G2uKDiuPMQdz9OHPLaPcDtGkLGQqb54CaTMKlA3SxH78PHpaTAptviW0y
	j10oWgamOu/3LY8MYhYRvM4DLPWzWJD5nM1ROibFvEqNiorDZTuVYQDrhr5PDYbSG2XMPiXCKnd
	KjzlKPsw/P6ioaPAfCdzegPQld8R9DPdJDtggxekbujdb1lcwhWnzgRmkj5FsrZpkZD+VNVhgH3
	HOhKY2Jj40JqXH2AHlOlFcyc1jGQPq+23TkGT2v+ATg0iqzRo/NusheLzVjUFDWi4m1GCu4sSyk
	ta8RODySDxhYM/SQHy1lo4cIFNlyjbrR0arYsA4rlt/sRutQYAK3sGBrn8AK8X0JA9nPIC7jWwh
	jlTmFuik5RNQigWKj8otHcsvTnOdxAyaLN4Rup7PI1ZDgaL+v6yRQI9
X-Received: by 2002:a05:620a:454a:b0:939:8e05:27e0 with SMTP id af79cd13be357-939ea013111mr26869085a.1.1789066249021;
        Thu, 10 Sep 2026 11:50:49 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e86b7424sm40754785a.32.2026.09.10.11.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:50:48 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC 00/13] rcu-tasks: let preemption outside trampolines be
 a quiescent state
Date: Thu, 10 Sep 2026 18:50:23 +0000
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPH7omoC/22Nyw7CIBBFf6WZtZPShtbo1sQPcGtcAA4WH4gMN
 SZN/12oW5f33NcETNERw7aaINLbsXv6LJpVBWZQ/kLozllDK9pebBqBWmI0IybFN8YQiR4h4Yt
 RisZa2cm+M2vI7WxZ91mWj3DY7+D0gzzqK5lUNktMKybUUXkzFHQPtZb1Av+9wDx/AYKBPpKyA
 AAA
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

 arch/arm64/Kconfig                          |  1 +
 arch/arm64/kernel/asm-offsets.c             |  3 ++
 arch/arm64/kernel/entry-ftrace.S            | 35 +++++++++++++
 arch/arm64/kernel/ftrace.c                  | 16 ++++++
 arch/arm64/net/bpf_jit_comp.c               | 46 ++++++++++++++++
 arch/x86/Kconfig                            |  1 +
 arch/x86/kernel/asm-offsets.c               |  3 ++
 arch/x86/kernel/ftrace.c                    | 37 +++++++++++++
 arch/x86/kernel/ftrace_64.S                 | 43 +++++++++++++++
 arch/x86/kernel/kprobes/opt.c               | 20 +++++++
 arch/x86/kernel/vmlinux.lds.S               |  4 ++
 arch/x86/net/bpf_jit_comp.c                 | 43 +++++++++++++++
 arch/x86/xen/enlighten_pv.c                 |  2 +-
 include/linux/irq-entry-common.h            | 14 ++---
 include/linux/kprobes.h                     |  8 ++-
 include/linux/module.h                      |  7 +++
 include/linux/rcupdate.h                    | 70 ++++++++++++++++++++++++-
 include/linux/sched.h                       |  1 +
 kernel/entry/common.c                       | 29 +++++++++--
 kernel/fork.c                               |  1 +
 kernel/kprobes.c                            | 24 +++++++++
 kernel/rcu/Kconfig                          | 17 ++++--
 kernel/rcu/rcutorture.c                     |  6 +++
 kernel/rcu/tasks.h                          | 81 +++++++++++++++++++++++++++--
 kernel/rcu/update.c                         |  2 +
 kernel/trace/ftrace.c                       | 39 ++++++++++++++
 samples/ftrace/ftrace-direct-modify.c       |  9 ++++
 samples/ftrace/ftrace-direct-multi-modify.c |  9 ++++
 samples/ftrace/ftrace-direct-multi.c        |  5 ++
 samples/ftrace/ftrace-direct-too.c          |  5 ++
 samples/ftrace/ftrace-direct.c              |  5 ++
 samples/ftrace/ftrace-direct.h              | 64 +++++++++++++++++++++++
 32 files changed, 629 insertions(+), 21 deletions(-)
---
base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
change-id: 20260910-b4-rcu-tasks-preempt-qs-401ff45465c7

Best regards,
--  
Josef Bacik <josef@toxicpanda.com>

