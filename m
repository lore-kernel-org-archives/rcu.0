Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A944C53FD49
	for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701943; cv=none; b=pMIDHIjbnAKBHiDQLZ0anJphK7c23Ox2NvyCVE2ukIbei4zeLsVCaLv8SK5vRwPb6k6Oc4ot9BrZbdKg9MVIx79AEWyRsPDrWL4VpP7uiA19Y+WHnfZxNH9Uqa/Sk/zq8M73xCX3//McHs+RUE0mJtam9SMUTIcHIt5uJStJ+uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701943; c=relaxed/simple;
	bh=FZW4YTTBvvCPMQ/h/2nWX+gpg2Y8s/vtIMB2bcZ9F3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n1mA24x2d7275Do/i/hB/AsrLrwZZUgN3/Ah1+HEnCPFCVx3DT/5W7y/DZsy714IB3HUBakvBU6meg8AJrCDncyV4GetRQ7V/731H70YWBQI0lMsd5PTNQDXtHHcGRaFRQw9HypcfbKmUFT8bhkPqrEeESocmCz2nq7uVA4Fu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=BbGwjquC; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="BbGwjquC"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a860e532eeso40362097b3.3
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790701940; x=1791306740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jN+EKp2v4jnrDPKobE/7uiDPi0IfRYjCoLuWj+9Qpew=;
        b=BbGwjquCIQ6uomxzLnlqJZGmfn05k3aMkx0MI0Tg1mSk5HPlTx1FhVTwvoZEw+T2bd
         pMw5OpNhkWv2WQtaLBdihBgEel/Aue4v/3aaNg1EcyW3g2meHJdWw1XP6TiZNB2CwrfR
         jDEixTmeR6w+jROvdV5Thu7vBT3/jnW5tmVj9S+4mhKVGlDZiHS00tw5VyzALb9FOO83
         PLpJqq8QHKsVizYrWWJXeyN/C8pX+MbMU2z0vgptGAR+1vAPWiZtDnK3reDK34KfBlKB
         w7vJIRpHHDau303Z/XZYjyjmrynSceW4CvRhSKrQA55GhjPwPGNL1K4RMm7+WOPy6BsQ
         MOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790701940; x=1791306740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jN+EKp2v4jnrDPKobE/7uiDPi0IfRYjCoLuWj+9Qpew=;
        b=Y5NmnxsH4l3gRrFcefrjHMT3lj/LjcaYaFHLvVdoCQlBZMUnVU1b//cIvRU0ca8vFv
         ZrE0+C51tCvSngwg46hGBNqQQEJuBuODo2YTLr7DvmKn+nGimqjPU6XlV1zWGCHNxpf8
         q2QnP9BTRRsqPeIHEAlt2eshCazP8v6X3guEM7BtFndVLFZXi7WhpFaOk+YmMEg6bgxP
         ++Bv4SJwnN2kH1vapk9WX4SuDUlNCknw+5IhzhcF91SaiEPPeoOVd1ExtZR3B/ACXc++
         OT0z6SGCztOk7Ooz6ooh/BcE2uwkRzgEgfNUtNGttADPwACGtk6dhZbvmdqtvDRi6I8T
         ZHjg==
X-Forwarded-Encrypted: i=1; AKwUvBzpfbw7uP72kVJZcxon9nlVyoxIZjg64QjF0TkC4us4q4cMgTzgaYLJEsqMOn3wJSWbGw4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1QrPV0v1j7VMEOBEAGpVsB7Tvvk1JM8MAr4jii/0cHWRt/GwP
	CkPHF+vz478x8gIvWz2vIbGNZy1VMvvbolNb8kDo5xrOZKpfDNmjxIS/KsW/+M9geHA=
X-Gm-Gg: AYBFou2a4vzAp5tYTp8sFqA9iLuKTRMZrnyFssXr4TIrlEVTvL5c+YLwMWuTI134Dmr
	KstSzfDkNQOCOCWOIcft/dth82hWX/Jvae1XDLny1Fq8qxoCvkQgBNX4IkaP+yalLjn4lMltvCJ
	6IINcJkS5K7ZFRSMK0t7ZUQctfClUfnAV94tM2PRdB278WhDHA27EKB22PGDt8PcpRK+6dsnJcD
	Bk6vTeg3Q6JVbhrEDomElsL5OaVKZtY/Mg0Vf9pwUGUmrS6G/ElfuAHkRzynrfFT+uhywPfh2dd
	DXr7e5qHLr1fU2JgvRlmJEobDyTVZ6fRR5MyzpLbKl1lxyWBHDhjZMHV6kEKNkOPWgbKfZX/BM9
	5Ay2/ek0mFajRDUdQ5r5vg9BEYlwnRoNXSQk9CBZ/3oYldoe5VsKGwbk7t9BzbhHylaSlOjo3da
	ExpwBtuS8lT7qumCQmzt4pGrHYq6rLNGgcrqBB9aJ/TNLV0NbvL9ehE2bbHuh5OuA+h5UEIbLbC
	nTa32u3Bq3ijAY=
X-Received: by 2002:a05:690c:dd6:b0:89a:63da:fa91 with SMTP id 00721157ae682-8a648ec364cmr72334707b3.76.1790701940283;
        Tue, 29 Sep 2026 10:12:20 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9178d36b0f2sm15009076d6.34.2026.09.29.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:12:18 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Sep 2026 17:07:23 +0000
Subject: [PATCH v6 06/14] x86/ftrace: Take a Tasks Trace reader around
 ftrace_caller's call-out
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rcu-tasks-preempt-qs-v6-6-c111ee02caca@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790701681; l=11992;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=FZW4YTTBvvCPMQ/h/2nWX+gpg2Y8s/vtIMB2bcZ9F3k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBtuW4V8/fvX2eeWNRKpMKk3AcKPvBATtnFJ4wim7KKluOFxXt8orrwiPuO4Tel4Ca/VOMbEsQN
 58nz6PanZcAc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

For HAVE_RCU_TRAMPOLINE_READERS the ftrace trampolines must be Tasks
Trace RCU readers while they call out, since that -- and not the absence
of a voluntary context switch -- is what synchronize_rcu_tasks() will
wait for before ftrace_shutdown() frees a dynamic trampoline or its ops.

Open-code rcu_read_lock_trace() and rcu_read_unlock_trace() in
ftrace_caller and ftrace_regs_caller: bump current->trc_reader_nesting
and, for the outermost reader, do the SRCU-fast per-CPU increment on
rcu_tasks_trace_srcu_struct and stash the counter pointer in
current->trc_reader_scp, exactly as the C inlines do (including the
smp_mb() when CONFIG_TASKS_TRACE_RCU_NO_MB is not set).  The lock sits
before the function_trace_op load, because between that load and the
call the ops pointer is protected only by Tasks RCU, and the unlock
after the call returns.  Note at rcu_read_lock_trace() that it now has
open-coded copies that have to be kept in step.  The sequences are inside the region that
create_trampoline() copies for per-ops trampolines; their %rip-relative
references are fixed up by text_poke_apply_relocation() like
CALL_DEPTH_ACCOUNT's.  %rax and %rcx are dead at both points.

Some core text still runs outside that reader while holding the
address of a Tasks-RCU-protected trampoline it is about to enter or
return to: the static stubs themselves, whose direct-call tails keep a
BPF trampoline address on the stack until the final RET; under
CONFIG_MITIGATION_RETHUNK, the return thunk that RET expands to; and
under CONFIG_FINEIBT_BHI, the __bhi_args thunks that a struct_ops BPF
trampoline's CFI preamble calls before it can take its reader.  Add an
ftrace_static_tramp_end marker after ftrace_stub_direct_tramp and linker
symbols around .text..__x86.return_thunk and .text..__x86.rethunk_safe,
and provide arch_rcu_tasks_trampoline_text() covering
[ftrace_caller, ftrace_static_tramp_end), both thunk ranges and
[__bhi_args, __bhi_args_end) so the irq-exit check treats a task
interrupted there as a holdout.

All of this is built only under CONFIG_TASKS_RCU_TRAMPOLINE_READERS,
which x86 does not enable until a later patch.

Cost, measured as getppid() ns/call in a KVM guest on a Xeon 8375C with
the function tracer attached to __do_sys_getppid and the ring buffer
off: 87.2 -> 88.0 ns, i.e. under 1 ns for the lock/unlock pair with
CONFIG_TASKS_TRACE_RCU_NO_MB (the default here); a kprobe event on the
same function via ftrace_regs_caller: 119.9 -> 123.2 ns.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/kernel/asm-offsets.c  |  8 +++++
 arch/x86/kernel/ftrace.c       | 52 +++++++++++++++++++++++++++++++
 arch/x86/kernel/ftrace_64.S    | 69 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S  |  4 +++
 include/linux/rcupdate_trace.h |  6 ++++
 5 files changed, 139 insertions(+)

diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 081816888f7a..876c3986419a 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -9,6 +9,7 @@
 #include <linux/crypto.h>
 #include <crypto/aria.h>
 #include <linux/sched.h>
+#include <linux/srcu.h>
 #include <linux/stddef.h>
 #include <linux/hardirq.h>
 #include <linux/suspend.h>
@@ -46,6 +47,13 @@ static void __used common(void)
 #ifdef CONFIG_STACKPROTECTOR
 	OFFSET(TASK_stack_canary, task_struct, stack_canary);
 #endif
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	OFFSET(TASK_trc_reader_nesting, task_struct, trc_reader_nesting);
+	OFFSET(TASK_trc_reader_scp, task_struct, trc_reader_scp);
+	OFFSET(SRCU_srcu_ctrp, srcu_struct, srcu_ctrp);
+	OFFSET(SRCU_CTR_srcu_locks, srcu_ctr, srcu_locks);
+	OFFSET(SRCU_CTR_srcu_unlocks, srcu_ctr, srcu_unlocks);
+#endif
 
 	BLANK();
 	OFFSET(pbe_address, pbe, address);
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 17d6edfcb7e0..598b819b14cb 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -29,6 +29,7 @@
 
 #include <trace/syscall.h>
 
+#include <asm/cfi.h>
 #include <asm/kprobes.h>
 #include <asm/ftrace.h>
 #include <asm/nops.h>
@@ -275,6 +276,57 @@ static inline void tramp_free(void *tramp)
 	execmem_free(tramp);
 }
 
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+extern void ftrace_static_tramp_end(void);
+extern char __return_thunk_start[], __return_thunk_end[];
+extern char __rethunk_safe_start[], __rethunk_safe_end[];
+
+/*
+ * The SRCU-fast increments in TRACE_RCU_READ_LOCK/UNLOCK (ftrace_64.S) are the
+ * this_cpu_inc() form.
+ */
+static_assert(!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE));
+
+/*
+ * See rcu_tasks_trampoline_text().  Some core kernel text behaves like a
+ * trampoline for Tasks RCU purposes because a task executing there outside
+ * any Tasks Trace reader may still be about to enter a Tasks-RCU-protected
+ * trampoline whose address it already holds:
+ *
+ *  - the static ftrace_caller / ftrace_regs_caller / ftrace_stub_direct_tramp
+ *    stubs, which carry a direct-call target on the stack until their final
+ *    RET, and
+ *  - the return thunks that RET expands to under CONFIG_MITIGATION_RETHUNK,
+ *    which run after leaving the stubs above and before landing in that
+ *    target, and
+ *  - the FineIBT-BHI __bhi_args thunks, which a struct_ops BPF trampoline's
+ *    CFI preamble calls before the trampoline has taken its reader, with the
+ *    return address pointing back into the trampoline image.
+ */
+bool arch_rcu_tasks_trampoline_text(unsigned long ip)
+{
+	if (ip >= (unsigned long)ftrace_caller &&
+	    ip <  (unsigned long)ftrace_static_tramp_end)
+		return true;
+#ifdef CONFIG_MITIGATION_RETPOLINE
+	if (ip >= (unsigned long)__return_thunk_start &&
+	    ip <  (unsigned long)__return_thunk_end)
+		return true;
+#endif
+#ifdef CONFIG_MITIGATION_SRSO
+	if (ip >= (unsigned long)__rethunk_safe_start &&
+	    ip <  (unsigned long)__rethunk_safe_end)
+		return true;
+#endif
+#ifdef CONFIG_FINEIBT_BHI
+	if (ip >= (unsigned long)__bhi_args &&
+	    ip <  (unsigned long)__bhi_args_end)
+		return true;
+#endif
+	return false;
+}
+#endif /* CONFIG_TASKS_RCU_TRAMPOLINE_READERS */
+
 /* Defined as markers to the end of the ftrace default trampolines */
 extern void ftrace_regs_caller_end(void);
 extern void ftrace_caller_end(void);
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 62c1c93aa1c6..5d8cb3861978 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -7,6 +7,7 @@
 #include <linux/cfi_types.h>
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
+#include <asm/percpu.h>
 #include <asm/ptrace.h>
 #include <asm/ftrace.h>
 #include <asm/nospec-branch.h>
@@ -145,6 +146,53 @@ SYM_FUNC_END(ftrace_stub_graph)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
+/*
+ * Open-coded rcu_read_lock_trace() / rcu_read_unlock_trace(), see
+ * include/linux/rcupdate_trace.h and CONFIG_HAVE_RCU_TRAMPOLINE_READERS: the
+ * trampoline and the ftrace_ops it is about to load are kept alive by Tasks
+ * RCU only while we are inside this reader, so the lock must precede the
+ * function_trace_op load and the unlock must follow the call.  These live
+ * inside the region copied into dynamic trampolines; the %rip-relative
+ * references are fixed up by text_poke_apply_relocation() in
+ * create_trampoline().  Clobbers %rax, %rcx and flags.
+ */
+.macro TRACE_RCU_READ_LOCK
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	movq	PER_CPU_VAR(current_task), %rcx
+	movl	TASK_trc_reader_nesting(%rcx), %eax
+	incl	TASK_trc_reader_nesting(%rcx)
+	testl	%eax, %eax
+	jnz	.Ltrl_nested_\@
+	movq	rcu_tasks_trace_srcu_struct+SRCU_srcu_ctrp(%rip), %rax
+	incq	%gs:SRCU_CTR_srcu_locks(%rax)
+	movq	%rax, TASK_trc_reader_scp(%rcx)
+#ifndef CONFIG_TASKS_TRACE_RCU_NO_MB
+	lock addl $0, -4(%rsp)		/* smp_mb() */
+#endif
+.Ltrl_nested_\@:
+#endif
+.endm
+
+.macro TRACE_RCU_READ_UNLOCK
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	movq	PER_CPU_VAR(current_task), %rcx
+	movl	TASK_trc_reader_nesting(%rcx), %eax
+	subl	$1, %eax
+	jnz	.Ltru_nested_\@
+	/* Outermost: pick up scp before an interrupt can see nesting == 0. */
+	movq	TASK_trc_reader_scp(%rcx), %rax
+	movl	$0, TASK_trc_reader_nesting(%rcx)
+#ifndef CONFIG_TASKS_TRACE_RCU_NO_MB
+	lock addl $0, -4(%rsp)		/* smp_mb() */
+#endif
+	incq	%gs:SRCU_CTR_srcu_unlocks(%rax)
+	jmp	.Ltru_done_\@
+.Ltru_nested_\@:
+	movl	%eax, TASK_trc_reader_nesting(%rcx)
+.Ltru_done_\@:
+#endif
+.endm
+
 SYM_FUNC_START(__fentry__)
 	ANNOTATE_NOENDBR
 	CALL_DEPTH_ACCOUNT
@@ -163,6 +211,8 @@ SYM_FUNC_START(ftrace_caller)
 	leaq MCOUNT_REG_SIZE+8(%rsp), %rcx
 	movq %rcx, RSP(%rsp)
 
+	TRACE_RCU_READ_LOCK
+
 SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
@@ -181,6 +231,8 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	call ftrace_stub
 
+	TRACE_RCU_READ_UNLOCK
+
 	/* Handlers can change the RIP */
 	movq RIP(%rsp), %rax
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
@@ -209,6 +261,8 @@ SYM_FUNC_START(ftrace_regs_caller)
 
 	CALL_DEPTH_ACCOUNT
 
+	TRACE_RCU_READ_LOCK
+
 SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
@@ -246,6 +300,8 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	call ftrace_stub
 
+	TRACE_RCU_READ_UNLOCK
+
 	/* Copy flags back to SS, to restore them */
 	movq EFLAGS(%rsp), %rax
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
@@ -328,6 +384,19 @@ SYM_FUNC_START(ftrace_stub_direct_tramp)
 	RET
 SYM_FUNC_END(ftrace_stub_direct_tramp)
 
+/*
+ * [ftrace_caller, ftrace_static_tramp_end) is treated as trampoline text by
+ * rcu_tasks_trampoline_text(): outside TRACE_RCU_READ_LOCK/UNLOCK the stubs
+ * may still hold a direct-call trampoline address (ORIG_RAX / the return
+ * address they RET to) that only Tasks RCU keeps alive.  With return thunks
+ * the RET itself runs elsewhere; arch_rcu_tasks_trampoline_text() covers
+ * those too.
+ */
+SYM_CODE_START_NOALIGN(ftrace_static_tramp_end)
+	UNWIND_HINT_UNDEFINED
+	ANNOTATE_NOENDBR
+SYM_CODE_END(ftrace_static_tramp_end)
+
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
 SYM_FUNC_START(__fentry__)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 2438b89a4620..e546283dc267 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -151,7 +151,9 @@ SECTIONS
 		 * definition.
 		 */
 		. = srso_alias_untrain_ret | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
+		__rethunk_safe_start = .;
 		*(.text..__x86.rethunk_safe)
+		__rethunk_safe_end = .;
 #endif
 		ALIGN_ENTRY_TEXT_END
 
@@ -162,7 +164,9 @@ SECTIONS
 		SOFTIRQENTRY_TEXT
 #ifdef CONFIG_MITIGATION_RETPOLINE
 		*(.text..__x86.indirect_thunk)
+		__return_thunk_start = .;
 		*(.text..__x86.return_thunk)
+		__return_thunk_end = .;
 #endif
 		STATIC_CALL_TEXT
 		*(.gnu.warning)
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 273c59a03251..dcdb11643496 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -92,6 +92,12 @@ static inline void rcu_read_unlock_tasks_trace(struct srcu_ctr __percpu *scp)
  * the all the other tasks exit their critical sections.
  *
  * For more details, please see the documentation for rcu_read_lock().
+ *
+ * CONFIG_HAVE_RCU_TRAMPOLINE_READERS architectures open-code this pair in
+ * their ftrace and BPF trampolines (arch/x86/kernel/ftrace_64.S,
+ * arch/x86/kernel/kprobes/opt.c, arch/x86/net/bpf_jit_comp.c,
+ * arch/arm64/kernel/entry-ftrace.S, arch/arm64/net/bpf_jit_comp.c,
+ * samples/ftrace/ftrace-direct.h); changes here need to be mirrored there.
  */
 static inline void rcu_read_lock_trace(void)
 {

-- 
2.55.0

