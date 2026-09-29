Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473EA52F265
	for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702066; cv=none; b=m+/nUTXeAZijn6I3mdDqLY84AsD1nC1YjveFNpnk+RaRWcZzSZ7n/jmVpI3R+erQ3ahURWfvtnuYii0GnpRv3gzwBf52LvKSr391pYfxxcM4pCZkRiPbGHP3x6geq7PbgfuQ16q9L+eBPP5dshuU6JsFvlvU2kOcsZoPXaf3fEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702066; c=relaxed/simple;
	bh=/nFXdp2+7CXnpn3wrr9YRBYc7XNjkBVO85tcUsvfCQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QirwGyJv/gZJs8ccwrOHVUumAau/ffM7QsMFgZiYx0zGhOrBBJtJAtdu/TzWYw7Q8OLphxWpHYgYZF5D0/r17oA98UeV2c3LAV6tr539zo4WSLNOIs5hqpih3ZEk0HI7nMHqgoD0ywwTYe6hCWTrRlKBPEVJiy9IqTxueo11+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=MIn0lw8L; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="MIn0lw8L"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-53331a61f71so35155701cf.2
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 10:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790702062; x=1791306862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4VpvwKsqXhx4LZZAKqUKBgQqPC/ZBWI8Zf2OvVxiv/U=;
        b=MIn0lw8LuVVyqRMr+q2pV3OelDbHbEEXRKBHmbJ8Gfj0sZ8AmGmRSCfEkxVOg2a+dc
         9s+kt8gw+gfUiGhiw1ezetN1CvnXiGvPIo3SYre7K+40W2wg/N+6bF1iDPcQxzbgWwZ7
         fsJydzah04ChAVfhkhSTvB3BW3YINQwmuiI580vw5gbPQPMXW0SfF/cVZ8upP3c2gJgv
         BUKd/aineZJC1strUItfM2vqXNq5CWfbUX50vD+Sp87TpRyw0UAxiDNBN/EIE2UTkyoM
         +0QMC3QZDAODbhMpE+ik8l9AdpyKo5d9bM5kbKRAPNnI1zF/Y1kprxvdbnVRN6KXnFuS
         ZLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790702062; x=1791306862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4VpvwKsqXhx4LZZAKqUKBgQqPC/ZBWI8Zf2OvVxiv/U=;
        b=e8kwPAvWz+W936Bs5n6kbyqyQ/TxKP0FqH6dofIPLk1SVr2VV3TUk9YZFMQjV3/HZt
         DVqNgx4aTzL41jQ2VgN7A3Ay+p1xURo3gHPmEz74VFZqsaE3OsC0Cq4mXqBxmLJ9RHoJ
         hE3+EGH9r3ggi+8kHome3Njrc/VXYZUVwbZR8ac+kGWUGOkKTV06xm0xsyMKJOZEY3a4
         feyylotY9B+/h4dIY6gxghBGTHFGDCBI+SEsV1RCpzjoGFSAvYn0ZQn2iKvjBfN40Zrs
         WnD3HVMJZGks8BZ7cb5VeenuhhQ0mA9KUam5sEFr8aoQaMIaXVE5xbeixLxUyMS/a4Fj
         fCeQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQ2aWeuPe7QUA3HHkDfNaPuGAJDjPyJ6g+Xaody4sjJ/t5P66HgQ4agTfXKHobWm5PCWU=@vger.kernel.org
X-Gm-Message-State: AFuF++k6g6ITwgQpJpuxeuFFMJfm9f1BZY6ziJ0mfPkUqHbmEDDsfiPF
	iHCEUdGC19U/Guu/EUksInmywd/EguukFB8IbK+tu+XlqsTQNSSo9kpUk1Oj4BDvGuw=
X-Gm-Gg: AYBFou1TzYMPav5N/G1mo2sGE1ZEa4ms9TxDahsTEeDalx290x4F+vVjmGZ8c36FGqB
	4OKdtFnpKeQWhZreNqItCO6lIIKN5Lw6INIVc9z/0o+4DgH3XdUbhHFUXmkvAz7bWWRP3Fflobi
	G3wnTCru2JmxSqz8L6sY6jGZXhk+8kFyn3FpfPsUJtFNCZPwwWBSqVIwPPSgCVaNVOqHpzWAIGU
	3MDBESgSNxfKXvI/teEMtl8kbhLD8TY5TITGGpR2BsEedZY71gGgYbm3tQBVuWykEGsQFcXE2We
	zxrhU6xwv8z3jV20T94ZkFWWLNQEsb6L25/mkRmT4E/NES3G3HsGoOEjpk732PBs9GPqrsTpHjc
	JyAfggk/BmHTUQmnnhZh0vJr7DcTpd6gf62FwA1ZO/dJEY1/nDSmIjOxfBjD4faEqfqLvbTvPIE
	FqTL2c5LMJlInB08Wx6I1SgfsncRbUWF+2F2GS2mPD7dh8dSke23iqmvd8wOv7PtcNu1wEkuMM4
	lUnK+h7k++yEyg=
X-Received: by 2002:a05:6214:524a:b0:917:8aaf:bb95 with SMTP id 6a1803df08f44-9178aafc17fmr44129386d6.26.1790702062036;
        Tue, 29 Sep 2026 10:14:22 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9178d36dc53sm15238816d6.37.2026.09.29.10.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:14:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Sep 2026 17:07:26 +0000
Subject: [PATCH v6 09/14] arm64: ftrace: Take a Tasks Trace reader around
 ftrace_caller's call-out
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rcu-tasks-preempt-qs-v6-9-c111ee02caca@toxicpanda.com>
References: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
In-Reply-To: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790701681; l=8116;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=/nFXdp2+7CXnpn3wrr9YRBYc7XNjkBVO85tcUsvfCQU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPH2qB3myAhCM9h0lq6V9xVTZcnol+G/rK3mscRulBCyWlfRFbQ1RyB7+LSN3MXglxS6wem2GUr
 FtLzb1fsppgY=
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

Cost, measured as getppid() ns/call in a KVM guest on Graviton4
(Neoverse-V2) with the function tracer attached to __do_sys_getppid and
the ring buffer off: 103.7 -> 105.6 ns, i.e. about 2 ns for the
lock/unlock pair with CONFIG_TASKS_TRACE_RCU_NO_MB (the default here).

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

