Received: from mail-qk2-f36.google.com (mail-qk2-f36.google.com [74.125.230.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2EC377AA7
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044267; cv=none; b=faRE7iIlgAZqWnsHDAOpoG/+1VhnLES7w1czpVr18B6p8gsoBAT7opklxCxT+pv8efFNT8Lw/dmao2jc5tF+AXg3/TF83sAi6NevKF/yXZob6aWfcKR5qREFbDL6UokmeIfv+RcrSbDZ0YLQtES7tMYJJPIuwnoTuHl8rGNN6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044267; c=relaxed/simple;
	bh=Aqm0C5BBMBkqFusbG93kcm6leRi28F4VKStTPzg6dAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pAc5s2p44RcIrQl5mZoQSj5oyA7gWzt4SvusOxfe8hlLoqfUeXiT3S73D1q65AQwuX9AmtTYtUZVHtXnzO1bod7ibv5YMJDhCNq/XrAtVa6wmP4om9zGtY9M6N/w66UKXTZUROqhRZGrpiJh/tsys9H9Ay5M5/tJRRBx8Z3umMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=JJF7HRNU; arc=none smtp.client-ip=74.125.230.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="JJF7HRNU"
Received: by mail-qk2-f36.google.com with SMTP id af79cd13be357-93910cadeb7so369328385a.0
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 19:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790044264; x=1790649064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ua8lq0Nx07F8Y+BgJ1JiUwgoDOin8IZmspGmQtj7ybE=;
        b=JJF7HRNUj4Rg+u6UUnt5B/1+Cg9nERrChWYvF9PRZpo17wYkti0nxO4fiuYGiK/2+w
         vim9WVpcTdwvRlI+hsJ4EW7IuPQVS4wYM3vwK9UG20WVAsa9risAu7/vYvBgvLHu0qtY
         0DUpbd0omYtFH8oM4rV76gR93YsZkZAZ0LB3mW2u9SPgecxfi+P6f1JUqZHdRKfJGY3S
         ZFjF2Ezp86/ruhdAT1LBjSjr3SEEd5DR+Pn3PMWTm53QBnerKFWilA6tN9vigEA50ZYg
         X7Wf5/fGEsGQLLHEO8HQe1fkY/kLmwWofn0PzJqw3Xd83p4l5BOz5ImDh3Pm10Zn2VU6
         YliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044264; x=1790649064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ua8lq0Nx07F8Y+BgJ1JiUwgoDOin8IZmspGmQtj7ybE=;
        b=f7Lldob63CialMP2pxtoO4q8iX3H2IQMpvchZSw8ROimhttVRSO2uFJD/TIg52rqnx
         TcC3KL8vI9GfOPzB9kvNtS6u06AnHydu128p8cqzxw5Ba+o8S3IEk5SpSlAjG/NiteDT
         D+JNkJN3QAQrZnc91cjOK4xkvYaK9H3orJpBpto2bZuV5UzWlOA/KLeJHftuoNpdVARj
         TiGEZPbvopyCCzqwHxuzCZqQFN0wdXJDpJptv2NEqJ9rEAsVuCUUwZ385nh2DhJscYHG
         i7LlrV6eui2tA+Z0SAcl5dIPDSmeXjx+1JKiXbMnMYCGTNYGtLQ0y2kMKpVhrFyJ1x0R
         U+8A==
X-Forwarded-Encrypted: i=1; AKwUvBzagfcK4X1SGXKASHyrAxZYmh6GffcD0n5/nmPMkgwVr1nVLOtd8TA6fy2deXcr0YPvwCw=@vger.kernel.org
X-Gm-Message-State: AFuF++ljzYT0m8XBJ0nFIiBqe3hKeGnzVS2ppGdrHwPNokYh8RKKOXik
	2KVWeZIguOJUWeDyzLLAmJqvODUtHfrQ3YrEgwJOMVK8e0iwUsxPUWiE08AX7dghx0M=
X-Gm-Gg: AYBFou2Ijt0wPIb/XS+reyHHtGDpfq4cPcYgAJuutXVbMhx98DrZ4OdtGzvS8VnY/9P
	iPZIKVlVgsLsH0vfwNi391BR5FSd2TsBoWLLbU5UxuoaWjh5wloNjUGNDzh8U5RSTYHWgHPhDxB
	4udNxI62yaE1QRRVjJHWQQVzjBcDqCWixXw/UlxxicnftSLy8WznPKnnq9JcuKaBhCQwix0Znps
	vf8HRS3QuoDI+Qi1r53pRk1JXNzv3ShwokjYphsHpSLo6O/U7MJSfeMNlq7SV4MqjdK43Crkj2m
	innQq608+1JbmpIrRyQhwe8ME7aevyv64Tpiv1pC1tFTyuxHQDacyxK1dQAs/FqgrnraZxaahY0
	AHB/vyzMbfJfsFKy/vW29ppspyRjbQ7okoBCuzjC/U38m4PXSg4cbgoirbXITyFmTwn9wsKqWcP
	WyReLi+7ZM18eehwx1HqLaljW5+iAIf1cl1GGDRH/f1gqIEdl9ETaZB3Y6bntmHnFRvrIx0GVLz
	phM1HjvL8tPSwmlsu2gB90EtA==
X-Received: by 2002:a05:620a:3199:b0:936:b923:4832 with SMTP id af79cd13be357-93c15db3eecmr402787485a.28.1790044264382;
        Mon, 21 Sep 2026 19:31:04 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d18725esm22523185a.22.2026.09.21.19.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:31:03 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 22 Sep 2026 02:23:27 +0000
Subject: [PATCH v5 08/13] arm64: ftrace: Take a Tasks Trace reader around
 ftrace_caller's call-out
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b4-rcu-tasks-preempt-qs-v5-8-410f57770bad@toxicpanda.com>
References: <20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com>
In-Reply-To: <20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790043820; l=7839;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Aqm0C5BBMBkqFusbG93kcm6leRi28F4VKStTPzg6dAE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLzF5n3GUkTWLii3NiHsvpD1TinWMCM9IV4Llmu+a7yPt78yVhVhsGdhEjVxKNXB2QbrNgDy62p
 d2pOMkWs6WwQ=
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

