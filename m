Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83B4AF690
	for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743009; cv=none; b=NCtxkoWVz5/E1GUvt3pi1zPdqWEcVVG9wR0HeG2nMUIH4cRQrK5AJoHocYUDc4DyrMFnJpOfk4pw64UzqOgLvAQrTJ8AxFn6KkGeUWIn5pM7PGDnAFe4wHe87Im5dq/J/ZRuNHZunVCMRpdeA0dcQbTq2hEQ1QMICxYCE1QS0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743009; c=relaxed/simple;
	bh=Aqm0C5BBMBkqFusbG93kcm6leRi28F4VKStTPzg6dAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wfj1T6cRoc8tYzCdlNusrme49NLfB5uSNZ+xq1B5rYusrBVZ5zAQoXCSzEwG/lceibvoBHbWTeaxEGyS7U06Mu3peNyBr6WYyI6M83QOYt6vjLZXMxr/8jZMIgOSa5sdA2dVfaCrzRxxtX3Ifnb2LDq3unJxmKyO/q05y6aFWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=AyexF3lD; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="AyexF3lD"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939922847efso75293485a.0
        for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 07:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789742999; x=1790347799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ua8lq0Nx07F8Y+BgJ1JiUwgoDOin8IZmspGmQtj7ybE=;
        b=AyexF3lDDG3gwT5NW6ieFJ+0B5vIoCHqmzIILR6w4zRjhBrffJbg70uuPgKrLzPmY1
         MIkCUQ3jEj8gY9GSax/ZvCpoCVZwdxqa34lU7IfG+uFy95QziGkm+0YANEyvghHUFBjJ
         MkMeZo7o41xeavy3Ynymth+7GWQrtzBCGgZ8nEAehTa9XwWfNj1QfoGuLpuf2pNeQuTT
         xetaP/dS6OHt8/ql2oUHmpBUaATU183RIo3crkZraShZPT1DcUkIdu7uQ0r5fCOwnvkb
         DjwUPD1nj+Oi0ai920R3sie2ryPNiWczsku8N03v1dTq9QfKT2LGKukO9rjGgoVYZgdB
         aE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742999; x=1790347799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ua8lq0Nx07F8Y+BgJ1JiUwgoDOin8IZmspGmQtj7ybE=;
        b=P3BHsxydMVEdVtIjP/CfF1TNrjmMoF/SexyNAueKVd9neA9yfvS/92kNV6cSsbuJYv
         4MNxAo/75J2i78+OvaGR/l2cOOQIreYKUdaIoc86vKPKRc3rT8gMmAkVcqWle6mSZP1J
         YR6RaqQgUa+TCFZ3I/nSzZoD0OJ5GqhvRkjAW2I9Te5Un9qtmbLeg4OpDQ+V9teS5hPS
         +c/cNq6jHdZvEud5FrY0D7jRm6Bvv9//cJuB8iLCoeSUe0eH0A+EJv47GfyUBzNYKDZa
         06+kZQTPkXcs13R0L1+clxev27Vv2yQ/qo9G6G3/vKnJTN2x4xzD/h4KcmkfCQ4Xov5P
         hofA==
X-Forwarded-Encrypted: i=1; AKwUvBzSZ0juv9SLBWPpxZvqkTEadws6hOhGzM8+FedX8aGbTb/MRphmVRNpOVlQfjWZ440u56I=@vger.kernel.org
X-Gm-Message-State: AFuF++nSowqi5tz0veID3iLxSBxdGDzNQj9ZyZ4vrWCT1H2aeFsA7Vzw
	RBwx2nb8UhiT6qP1V1B827Rio9Gas2AM9zafpdfLWNhs1dkLHomK/aSMjZSnk6sTP0w=
X-Gm-Gg: AYBFou3eTQmcF11vrzM0tJDeas1AzSrVlQyU8fcl3XytashGuyHtT0hLvSEbHvedyOf
	gTUpDGFqmy9dcsSunPzMTnR57PEjrK8/RAAFR6Uwti9NJ7kXubmQQMvCIlH2moKs+YdYN/goA6y
	NvjLmnXp96Z9lVxjBxKgqFhXADZsGAah3OGOUbSG5KO17s8tZbCUxTT+nNTCuU6JIb0Cj4M4iuZ
	+n+OzIaVBZIuc1ip9+aiOKHsaSs5tesAdKYljR2CAnVvvocoTnOIYaJGgzxdWz6ptR5/cC8yKvM
	EKdIf40C29E2c6uydO+zvqUC6Yc9ucNy9j4Eyl33E2zpM34uGUR2Y/E1VbsCDJrM3ljCV2fjp5V
	tYCLCGcWIg/wKBVTMMUdUKnbeeYwThndyU97/9KHsjkICRJNsdLfYxeYAjBPd6JemUenjwc003V
	VGJVnXfTLIHfK1bxvDyyZa/k/qx9ZuIhCMDepu7G666DcOfy0nRVP8lzFiITian5MmVBpMgxwOu
	guh9JaKeqthRmyDMyBL+ied6SSk2kWYVaidXUo/q++m1qE6C19h3S06
X-Received: by 2002:a05:620a:1a05:b0:939:733d:cbe0 with SMTP id af79cd13be357-93bdc65cdefmr384366585a.3.1789742998818;
        Fri, 18 Sep 2026 07:49:58 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0edf295sm154059185a.33.2026.09.18.07.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:49:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:27 +0000
Subject: [PATCH RFC v4 08/13] arm64: ftrace: Take a Tasks Trace reader
 around ftrace_caller's call-out
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-8-63f0e9d69661@toxicpanda.com>
References: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
In-Reply-To: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742980; l=7839;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Aqm0C5BBMBkqFusbG93kcm6leRi28F4VKStTPzg6dAE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBDwhofZWNUZ4nqzwdQchm82AWmFCaXImzqI0Y5t/lZTWR+xCeGh1w/K8fFkLJ01W3nr6p09Evj
 VkL1iXbfRFwc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

For HAVE_RCU_TRAMPOLINE_READERS the ftrace trampoline must be a Tasks
Trace RCU reader while it calls out, since that is what
synchronize_rcu_tasks() will wait for before ftrace_shutdown() frees an
ftrace_ops (or, with CALL_OPS, lets its owner free it) under a task
preempted in the callback.

Open-code rcu_read_lock_trace() and rcu_read_unlock_trace() around the
call to ops->func in ftrace_caller: bump current->trc_reader_nesting via
sp_el0 and, for the outermost reader, do the SRCU-fast per-CPU increment
on rcu_tasks_trace_srcu_struct and stash the counter pointer in
current->trc_reader_scp, as the C inlines do (including the dmb when
CONFIG_TASKS_TRACE_RCU_NO_MB is not set).  The per-CPU increment is an
LL/SC add on this CPU's counter; being migrated between reading the
per-CPU offset and the store-exclusive only means another CPU's counter
is incremented atomically instead, which SRCU sums over anyway.
x12-x16 are free at both points.

arm64 has no return thunks and, with CALL_OPS, no dynamic ftrace
trampolines, but ftrace_caller itself carries the ops pointer in x11
from before the reader is entered and a direct-call BPF trampoline
address in x17 until the final br/ret after it is left, so mark the end
of the static trampoline text and provide arch_rcu_tasks_trampoline_text()
covering [ftrace_caller, ftrace_static_tramp_end).

Built only under CONFIG_TASKS_RCU_TRAMPOLINE_READERS, which arm64 does
not enable until a later patch.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/arm64/kernel/asm-offsets.c  |  8 +++++
 arch/arm64/kernel/entry-ftrace.S | 74 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c       | 20 +++++++++++
 3 files changed, 102 insertions(+)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 9c853ed3ceab..f6a8fb1f9b43 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -10,6 +10,7 @@
 
 #include <linux/arm_sdei.h>
 #include <linux/sched.h>
+#include <linux/srcu.h>
 #include <linux/ftrace.h>
 #include <linux/kexec.h>
 #include <linux/mm.h>
@@ -39,6 +40,13 @@ int main(void)
   DEFINE(TSK_STACK,		offsetof(struct task_struct, stack));
 #ifdef CONFIG_STACKPROTECTOR
   DEFINE(TSK_STACK_CANARY,	offsetof(struct task_struct, stack_canary));
+#endif
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+  DEFINE(TSK_TRC_READER_NESTING,	offsetof(struct task_struct, trc_reader_nesting));
+  DEFINE(TSK_TRC_READER_SCP,	offsetof(struct task_struct, trc_reader_scp));
+  DEFINE(SRCU_SRCU_CTRP,	offsetof(struct srcu_struct, srcu_ctrp));
+  DEFINE(SRCU_CTR_SRCU_LOCKS,	offsetof(struct srcu_ctr, srcu_locks));
+  DEFINE(SRCU_CTR_SRCU_UNLOCKS,	offsetof(struct srcu_ctr, srcu_unlocks));
 #endif
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 025140caafe7..fc2805eb9e15 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -14,6 +14,72 @@
 #include <asm/insn.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
+/*
+ * Open-coded rcu_read_lock_trace() / rcu_read_unlock_trace(), see
+ * include/linux/rcupdate_trace.h and CONFIG_HAVE_RCU_TRAMPOLINE_READERS.  The
+ * whole of ftrace_caller is treated as trampoline text by the irq-exit check
+ * (see arch_rcu_tasks_trampoline_text()), so these only need to bracket the
+ * call out to ops->func; everything before the lock and after the unlock,
+ * including the direct-call tails that carry a BPF trampoline address in x17,
+ * is covered by that.
+ *
+ * The SRCU-fast per-CPU increment is done LL/SC on this CPU's counter; being
+ * migrated between reading the per-CPU offset and the store-exclusive only
+ * means another CPU's counter is (atomically) incremented, which SRCU sums
+ * over anyway.  Ordering between the nesting count and the scp stash only
+ * matters against interrupts on this CPU, which observe program order.
+ * Clobbers x12-x16 and the flags.
+ */
+	.macro trace_rcu_srcu_inc, addr:req, tmp:req, wtmp2:req
+8888:	ldxr	\tmp, [\addr]
+	add	\tmp, \tmp, #1
+	stxr	\wtmp2, \tmp, [\addr]
+	cbnz	\wtmp2, 8888b
+	.endm
+
+	.macro trace_rcu_read_lock
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	mrs	x12, sp_el0				// current
+	ldr	w13, [x12, #TSK_TRC_READER_NESTING]
+	add	w14, w13, #1
+	str	w14, [x12, #TSK_TRC_READER_NESTING]
+	cbnz	w13, .Ltrl_nested\@		// interrupted a reader: done
+	ldr_l	x13, rcu_tasks_trace_srcu_struct + SRCU_SRCU_CTRP
+	str	x13, [x12, #TSK_TRC_READER_SCP]
+	get_this_cpu_offset x14
+	add	x14, x14, x13
+	add	x14, x14, #SRCU_CTR_SRCU_LOCKS
+	trace_rcu_srcu_inc x14, x15, w16
+#ifndef CONFIG_TASKS_TRACE_RCU_NO_MB
+	dmb	ish
+#endif
+.Ltrl_nested\@:
+#endif
+	.endm
+
+	.macro trace_rcu_read_unlock
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	mrs	x12, sp_el0				// current
+	ldr	w13, [x12, #TSK_TRC_READER_NESTING]
+	subs	w13, w13, #1
+	b.ne	.Ltru_nested\@
+	/* Outermost: pick up scp before an interrupt can see nesting == 0. */
+	ldr	x14, [x12, #TSK_TRC_READER_SCP]
+	str	wzr, [x12, #TSK_TRC_READER_NESTING]
+#ifndef CONFIG_TASKS_TRACE_RCU_NO_MB
+	dmb	ish
+#endif
+	get_this_cpu_offset x15
+	add	x14, x14, x15
+	add	x14, x14, #SRCU_CTR_SRCU_UNLOCKS
+	trace_rcu_srcu_inc x14, x15, w16
+	b	.Ltru_done\@
+.Ltru_nested\@:
+	str	w13, [x12, #TSK_TRC_READER_NESTING]
+.Ltru_done\@:
+#endif
+	.endm
+
 /*
  * Due to -fpatchable-function-entry=2, the compiler has placed two NOPs before
  * the regular function prologue. For an enabled callsite, ftrace_init_nop() and
@@ -94,6 +160,8 @@ SYM_CODE_START(ftrace_caller)
 	stp	x29, x30, [sp, #FREGS_SIZE]
 	add	x29, sp, #FREGS_SIZE
 
+	trace_rcu_read_lock
+
 	/* Prepare arguments for the tracer func */
 	sub	x0, x30, #AARCH64_INSN_SIZE		// ip (callsite's BL insn)
 	mov	x1, x9					// parent_ip (callsite's LR)
@@ -111,6 +179,8 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	bl      ftrace_stub				// func(ip, parent_ip, op, regs)
 #endif
 
+	trace_rcu_read_unlock
+
 /*
  * At the callsite x0-x8 and x19-x30 were live. Any C code will have preserved
  * x19-x29 per the AAPCS, and we created frame records upon entry, so we need
@@ -178,6 +248,10 @@ SYM_CODE_START(ftrace_stub_direct_tramp)
 SYM_CODE_END(ftrace_stub_direct_tramp)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
+/* End of [ftrace_caller, ...) for arch_rcu_tasks_trampoline_text(). */
+SYM_CODE_START(ftrace_static_tramp_end)
+SYM_CODE_END(ftrace_static_tramp_end)
+
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
 /*
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index e1a3c0b3a051..5f4193f15cd9 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -17,6 +17,26 @@
 #include <asm/insn.h>
 #include <asm/text-patching.h>
 
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+extern void ftrace_static_tramp_end(void);
+
+/* The SRCU-fast increments in entry-ftrace.S are the this_cpu_inc() form. */
+static_assert(!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE));
+
+/*
+ * See rcu_tasks_trampoline_text().  ftrace_caller and ftrace_stub_direct_tramp
+ * are core kernel text but must be treated as trampolines: a task interrupted
+ * in them outside the Tasks Trace reader may be carrying an ops pointer (x11)
+ * or a direct-call BPF trampoline address (x17) whose lifetime is guarded only
+ * by Tasks RCU.
+ */
+bool arch_rcu_tasks_trampoline_text(unsigned long ip)
+{
+	return ip >= (unsigned long)ftrace_caller &&
+	       ip <  (unsigned long)ftrace_static_tramp_end;
+}
+#endif
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 struct fregs_offset {
 	const char *name;

-- 
2.55.0

