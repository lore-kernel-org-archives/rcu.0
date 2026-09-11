Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14D73403EE
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135829; cv=none; b=TbXUtAkaKiB59sedIZWf5NVOPMW9PWlNPt5yjcurQWUjYX3PY46IbWSnKHx2m4v8oVZsp/Pw6DhvVo8vIIrXDNtq10UqZ+YUM9Q32D/wdeUoNKAm0J4dDjrZLPdHKeI9VKnVJVuwg08uGS/w/vco9XMznSo6s0XIIVf98Ro6Dx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135829; c=relaxed/simple;
	bh=782IiL7t8C+T7tHuP+fr7fuNKyJIY5LyrSPvir4aYJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XtYi25WQOX1mtZnqiY0NXuyY6CmOdCOV62TT+hnNhPEAxeEM+B9c8dbihs+QsgnRFfOdlSgofREfOrZzunDQmdt/dxIPz43wEZKzIa2iojzxKWUNvNBVdspZE2YBzalPw9nhKzdIkDrDjob7A/kSfKNotOqqL6KFKk6zT/wQ4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=hLLaGoJZ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="hLLaGoJZ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-939b5ded99dso92999285a.2
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135824; x=1789740624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WT/8H/cMArsJRoufbqdgzsmAKwU5NTozjyFMdjWjsc8=;
        b=hLLaGoJZppM4zK0atM90Nj0fQpwFsj08kX3VvrzD4jvzgzs21Z/Q39hmrmbyIItc2C
         aShIS1x6G8SXe4GGjuEtCAI9geSAnURZzQxRnzLyouKxXli0tHlnrIvAn6sUpJpkyTEV
         XBdd8IRda0wYXPgk2zKw4L+ITQviagPa944zKvrYnOZaqTvlDwLeJY5khHbqYHi0hjgI
         1gjpYIe5YegKxBIE2C6OA/J9lR1d5wdZZhrOdVaRSoKWoGNOq/ART0GjYkGjGSSmr9/M
         nvpGRr84qKU/m2R9LkOW3u6tSuRx9c4MagdFtvZA52PZIpAHLSCX2dMjZDN/AlrMqneS
         +s0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135824; x=1789740624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WT/8H/cMArsJRoufbqdgzsmAKwU5NTozjyFMdjWjsc8=;
        b=QGUC3kF/iQ62FMWxYgOxvm3CHQoQSqwvgSShIbzBWaAcWB1vfsms0ghNl2O7wpiPWS
         cjBQl5N+JOrt/WUiWyXwEAh692SI7furi/adKZy9tF570NUomalr0K4h0bmO4MC9C3Pu
         gDUGY1T8NpW9pe7u8sN5N+JIMujWXiW0pivlpK57tj9vHvyE6dMzHK2SXAo6P7TwmZix
         PCyU5snDqG0HrixKqnR/GI7cWN2v+msiCm0+yQK4DyfBZ3I9eDBtaC/ck5Lu+Buez1Bf
         X+v8XyK0hH2XbUeG0MNjDjBXYuv2uJzKLcTiRAcRKir6hr2d6hcO1HYa878GG59wsOgA
         S75w==
X-Forwarded-Encrypted: i=1; AKwUvBx+rULn26KUC6zQV/PZlQ+4cIdDdUG1tRsQre89B70MujiA/lGIRL3+ubBFj6ynsQcvDkI=@vger.kernel.org
X-Gm-Message-State: AFuF++kl6eH7tSw4kH1GW7Yay/SpmX4bbgRdh+Eu+l1vtKHu27gknwe/
	901qbbGj5Pugg8lxTpMELNtpPVBFcFpeyQ4cJaLKioAIKEH8mD0Ly8jmxd/n273HKEA=
X-Gm-Gg: AYBFou19+R9ZW8sHw0wY42orowDkfTGDUIowsYkeqvFBZuhZLqcX9dboP/dE4yigQ5j
	0Exa47HujNLKvRVPQKJGj2B7rA7D1myKLdZMR33XLj8iDyGBMsQPQHwgY7OAleM39h2c51zvyaL
	1azl/BIsZMreLyWgxasuOC/F69WmcvEGWSwrYanOa6SUzobMI4SR1j1FWbr7VsgHahKYbIcahS6
	EtI0sJrxwqJWa3LMItEv6PMlGldZ0gwn2KzmpGjCWPHaJcUciCxXvNUb+XPme8zhTLZ0hd6GJZC
	PE6UpJe0DF2bFEumGymZVrlW2724vxnf94OAD9zRa//vVzFMl8r4W4SIDTZ3sZIEYcDq61cZdqU
	b6/63UlYhrgSaOdJR7UgeHVJ9lx7cKyJALKtBdGcasl1H/N7tLIKcDZQqUzNuf3IhAUsSnsmE+R
	nQ1Y0SCPBcK43DXvtOM8L+sfuZ8Oxa2AwljUNmxYtGBDZQnfedTaB4o3+0trBy5qIwiA4WyF9Mp
	d6o8KE8Uqol0ea6qa2voK9nSjDS88iC6+Ej4jeUMNZSBv4w/zk60j8j
X-Received: by 2002:a05:620a:444d:b0:939:cab7:8651 with SMTP id af79cd13be357-939ea0cff3cmr508758285a.21.1789135824016;
        Fri, 11 Sep 2026 07:10:24 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80801c0sm248912485a.30.2026.09.11.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:10:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:51 +0000
Subject: [PATCH RFC v2 13/15] rcu-tasks: Treat preemption outside
 trampolines as a quiescent state
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-13-eaaa61ed2da4@toxicpanda.com>
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
In-Reply-To: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135737; l=13377;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=782IiL7t8C+T7tHuP+fr7fuNKyJIY5LyrSPvir4aYJ4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLUZnTIeq2lPY+NhGtgUM19AxK92AiGBaR4ReDiwvRRgaRGOQrROuHTyqXvXkEa5pxrRzrRbB/J
 mvbDi+9g+vAw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Tasks RCU only accepts a voluntary context switch, usermode or idle as a
quiescent state, because a task that was preempted may be sitting in a
trampoline whose text is about to be freed.  On PREEMPT_LAZY kernels,
where cond_resched() is a no-op and CPU-bound kernel threads only ever
lose the CPU through preemption, that means any long-running kthread or
kworker stalls every synchronize_rcu_tasks() caller -- BPF and LSM
program detach and DYNAMIC ftrace_ops teardown via ftrace_shutdown(),
and kprobe (un)registration via the jump optimizer, which waits under
kprobe_mutex, text_mutex and cpus_read_lock() -- for its entire run,
unless someone sprinkles cond_resched_tasks_rcu_qs() into it.  A cgroup
writeback worker draining a large cgwb for eleven minutes was enough to
back 40+ tasks up behind trampoline_mutex and trip the hung-task panic.

With the previous patches, every Tasks-RCU-protected trampoline on
x86-64 and arm64 (ftrace_caller and its dynamic copies, BPF trampoline
images, the optprobe template, out-of-line direct trampolines) holds
current->rcu_tramp_nesting across its call-out, and the irq-exit
preemption path holds it across preempt_schedule_irq() whenever the
interrupted IP is somewhere the counter cannot cover: trampoline
entry/exit instructions and other dynamically allocated text, the static
ftrace stubs and x86 return thunks on the way into a direct-call target,
modules hosting their own direct trampolines.  The kprobe
jump-optimization window, which is ordinary text a task may have been
parked in before the kprobe existed, is instead re-checked against the
recorded irq-preemption IP at each decision (rcu_tasks_irq_ip_holds()).
A task that is context-switched with the count at zero and no such IP
therefore cannot be inside, called from, or about to resume into
anything Tasks RCU protects.

So let rcu_tasks_classic_qs() clear the holdout flag on a preemption
too when rcu_tramp_nesting is zero, on architectures that select
ARCH_HAS_RCU_TASKS_PREEMPT_QS, and select it for x86-64 and for arm64
with DYNAMIC_FTRACE_WITH_ARGS.  A running holdout is already poked via
rcu_request_urgent_qs_task(), which makes the next tick set
NEED_RESCHED; the resulting preemption -- from irq exit, or synchronously
at the next preempt_enable() -- now retires it, so a Tasks RCU grace
period is bounded by roughly a tick plus the longest preempt-disabled
section instead of by the longest stretch without a voluntary schedule().
Other architectures keep the voluntary-only rule.  Update the Tasks RCU
comments, Documentation/RCU (Requirements.rst, checklist.rst) and the
FORCE_TASKS_RCU help text to match.

Cost: one load of current plus an inc/dec per trampoline entry and exit,
and on irq-exit preemption one core_kernel_text() check plus, with
OPTPROBES, MAX_OPTIMIZED_LENGTH-1 lockless kprobe hash lookups.

Not covered: x86-32 and the other GENERIC_IRQ_ENTRY architectures, and
return_to_handler / the rethook trampoline, whose C callees take the
ftrace recursion lock before touching any ops.

Tested under QEMU (x86-64, PREEMPT_LAZY, PREEMPT_RCU=n, PROVE_RCU, with
and without PREEMPT_DYNAMIC) against a kthread spinning in-kernel for
30s with the function tracer, an ftrace kprobe, an optimized kprobe and
fentry/fexit programs live: synchronize_rcu_tasks() 29.7s -> 0.1-0.3s,
ftrace_shutdown() of a DYNAMIC ops 27s -> 0.2-0.8s, the ftrace-direct
sample modules load/fire/unload in ~2.5s each during the spin, no
warnings.  arm64 is build-tested only.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 .../RCU/Design/Requirements/Requirements.rst       | 28 ++++++++++++++++------
 Documentation/RCU/checklist.rst                    |  8 ++++++-
 arch/arm64/Kconfig                                 |  1 +
 arch/x86/Kconfig                                   |  1 +
 include/linux/rcupdate.h                           | 15 +++++++++++-
 kernel/rcu/Kconfig                                 |  7 +++---
 kernel/rcu/tasks.h                                 | 15 ++++++++----
 7 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 8101fe6229d5..428b5e8f4b4e 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2739,13 +2739,27 @@ userspace execution also delimit tasks-RCU read-side critical sections.
 Idle tasks are ignored by Tasks RCU, and Tasks Rude RCU may be used to
 interact with them.
 
-Note well that involuntary context switches are *not* Tasks-RCU quiescent
-states.  After all, in preemptible kernels, a task executing code in a
-trampoline might be preempted.  In this case, the Tasks-RCU grace period
-clearly cannot end until that task resumes and its execution leaves that
-trampoline.  This means, among other things, that cond_resched() does
-not provide a Tasks RCU quiescent state.  (Instead, use rcu_softirq_qs()
-from softirq or rcu_tasks_classic_qs() otherwise.)
+Note well that, by default, involuntary context switches are *not*
+Tasks-RCU quiescent states.  After all, in preemptible kernels, a task
+executing code in a trampoline might be preempted.  In this case, the
+Tasks-RCU grace period clearly cannot end until that task resumes and its
+execution leaves that trampoline.  This means, among other things, that
+cond_resched() does not provide a Tasks RCU quiescent state.  (Instead,
+use rcu_softirq_qs() from softirq or rcu_tasks_classic_qs() otherwise.)
+
+Architectures that select ``CONFIG_ARCH_HAS_RCU_TASKS_PREEMPT_QS`` relax
+this: there, every trampoline whose lifetime Tasks RCU guards (the ftrace
+and BPF trampolines, optprobe slots, out-of-line ftrace direct-call
+trampolines) increments ``current->rcu_tramp_nesting`` before calling out
+and decrements it before returning, and the irq-exit preemption path
+covers the few instructions the counter cannot (see
+rcu_tasks_ip_in_trampoline() and rcu_tasks_irq_ip_holds()).  A task that
+is preempted with that count at zero is therefore known not to be in, or
+called from, any trampoline, and such a preemption *is* a Tasks-RCU
+quiescent state.  The obligation moves to the trampolines: anything that
+relies on synchronize_rcu_tasks() to protect code a task may be preempted
+in must maintain the count (see register_ftrace_direct()), or Tasks RCU
+will not wait for it on those architectures.
 
 The tasks-RCU API is quite compact, consisting only of
 call_rcu_tasks(), synchronize_rcu_tasks(), and
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 4b30f701225f..28df48fecac7 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -252,7 +252,13 @@ over a rather long period of time, but improvements are always welcome!
 	a.	If the updater uses synchronize_rcu_tasks() or
 		call_rcu_tasks(), then the readers must refrain from
 		executing voluntary context switches, that is, from
-		blocking.
+		blocking.  On architectures that select
+		CONFIG_ARCH_HAS_RCU_TASKS_PREEMPT_QS an involuntary
+		context switch is also a quiescent state unless
+		current->rcu_tramp_nesting is non-zero, so a reader
+		there is a trampoline that maintains that count (see
+		rcu_tasks_trampoline_enter()), not an arbitrary
+		stretch of kernel code.
 
 	b.	If the updater uses call_rcu_tasks_trace()
 		or synchronize_rcu_tasks_trace(), then the
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5a51b0ef944..0e6c1e0b236f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -44,6 +44,7 @@ config ARM64
 	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTDUMP
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_RCU_TASKS_PREEMPT_QS if DYNAMIC_FTRACE_WITH_ARGS
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_DIRECT_MAP
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 15fd9ec5ecac..0a6427019345 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -99,6 +99,7 @@ config X86
 	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTDUMP
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_RCU_TASKS_PREEMPT_QS	if X86_64
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 4cfe096d624f..9509f99ec965 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -210,6 +210,11 @@ bool arch_rcu_tasks_ip_in_trampoline(unsigned long ip);
  * preemption and rcu_tasks_irq_ip_holds() checks it at every quiescent-state
  * decision, locally and from the grace-period kthread.
  *
+ * With both in place, on architectures that select
+ * ARCH_HAS_RCU_TASKS_PREEMPT_QS, a preemption with rcu_tramp_nesting == 0 is
+ * a Tasks RCU quiescent state, and a CPU-bound kernel thread no longer needs
+ * to volunteer one via cond_resched_tasks_rcu_qs().
+ *
  * Only current writes the count and only current (or an interrupt on the same
  * CPU) reads it, so plain accesses suffice.
  */
@@ -241,9 +246,17 @@ static __always_inline void rcu_tasks_note_irq_ip(unsigned long ip)
 	WRITE_ONCE(current->rcu_tasks_irq_ip, ip);
 }
 
+#ifdef CONFIG_RCU_TASKS_PREEMPT_QS
+#define rcu_tasks_preempt_is_qs(t)					\
+	(!READ_ONCE((t)->rcu_tramp_nesting) && !rcu_tasks_irq_ip_holds(t))
+#else
+#define rcu_tasks_preempt_is_qs(t)	false
+#endif
+
 # define rcu_tasks_classic_qs(t, preempt)				\
 	do {								\
-		if (!(preempt) && READ_ONCE((t)->rcu_tasks_holdout))	\
+		if (READ_ONCE((t)->rcu_tasks_holdout) &&		\
+		    (!(preempt) || rcu_tasks_preempt_is_qs(t)))		\
 			WRITE_ONCE((t)->rcu_tasks_holdout, false);	\
 	} while (0)
 void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 999f8228a13d..8e7c94329105 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -94,9 +94,10 @@ config FORCE_TASKS_RCU
 	default n
 	help
 	  This option force-enables a task-based RCU implementation
-	  that uses only voluntary context switch (not preemption!),
-	  idle, and user-mode execution as quiescent states.  Not for
-	  manual selection in most cases.
+	  that uses only voluntary context switch (not preemption, unless
+	  the architecture selects ARCH_HAS_RCU_TASKS_PREEMPT_QS and the
+	  task is outside any trampoline), idle, and user-mode execution
+	  as quiescent states.  Not for manual selection in most cases.
 
 config NEED_TASKS_RCU
 	bool
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 1b9fe1bfa591..bab08a666dc0 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -905,7 +905,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 //
 // Simple variant of RCU whose quiescent states are voluntary context
 // switch, cond_resched_tasks_rcu_qs(), user-space execution, and idle.
-// As such, grace periods can take one good long time.  There are no
+// With CONFIG_RCU_TASKS_PREEMPT_QS, a preemption taken while the task is
+// not inside a trampoline (current->rcu_tramp_nesting == 0, see
+// rcu_tasks_trampoline_enter()) is a quiescent state as well; without it,
+// grace periods can take one good long time.  There are no
 // read-side primitives similar to rcu_read_lock() and rcu_read_unlock()
 // because this implementation is intended to get the system into a safe
 // state for some of the manipulations involved in tracing and the like.
@@ -1263,8 +1266,11 @@ static void tasks_rcu_exit_stall(struct timer_list *unused)
  * period elapses, in other words after all currently executing rcu-tasks
  * read-side critical sections have completed. call_rcu_tasks() assumes
  * that the read-side critical sections end at a voluntary context
- * switch (not a preemption!), cond_resched_tasks_rcu_qs(), entry into idle,
- * or transition to usermode execution.  As such, there are no read-side
+ * switch, cond_resched_tasks_rcu_qs(), entry into idle, transition to
+ * usermode execution, or, with CONFIG_RCU_TASKS_PREEMPT_QS, a preemption
+ * taken outside any trampoline (current->rcu_tramp_nesting == 0, see
+ * rcu_tasks_trampoline_enter()); otherwise a preemption is not a
+ * quiescent state.  As such, there are no read-side
  * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
  * this primitive is intended to determine that all tasks have passed
  * through a safe state, not so much for data-structure synchronization.
@@ -1286,7 +1292,8 @@ EXPORT_SYMBOL_GPL(call_rcu_tasks);
  * executing rcu-tasks read-side critical sections have elapsed.  These
  * read-side critical sections are delimited by calls to schedule(),
  * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
- * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
+ * to synchronize_rcu_tasks(), (in theory, anyway) cond_resched(), and,
+ * with CONFIG_RCU_TASKS_PREEMPT_QS, preemption outside any trampoline.
  *
  * This is a very specialized primitive, intended only for a few uses in
  * tracing and other situations requiring manipulation of function

-- 
2.55.0

