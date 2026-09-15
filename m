Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6585B25B2F4
	for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478286; cv=none; b=kHH/A1T+tZWlS6l+a5SKTJDKdoPzJmeTGI6uBkNtJZ49FwZKBKSKHXr3R9+RD6k7haDKH+QjPRsC4wIR4blrSvZC5vx7jdx+owcOWmjOBT33heq91YMZDZYQZ5g6hW0+aAbpZRJ38HdohDj07Lwv1J5rKshsHNxF9FpS3fj5da8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478286; c=relaxed/simple;
	bh=EBgIXBiL5Z/I6XbFK2Nq9sAUVoT2dZ9k9OxjIjZChGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n6+YUWG8nLIIh/D7hXQ4PCVMUVoXpoFAMRmxIVnvMnFvFxfjjqsUaQLznsBUZgvm/Pvgk5e5Cqfi+9trr1AI6eCt3ku+lE6yuyVKvSjXdzF4tAD0A3m19vwZW90CUo/r8xi48RNfhsSDu3tSq5S2iq0hr+S2HKhE5rf/b68kL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=bhllt/aC; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="bhllt/aC"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6eeso34080826d6.0
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789478281; x=1790083081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPH1+eiN4EhHtK6rDK3I01/qZvQ6oNbinGntBhruq3Q=;
        b=bhllt/aCou++wklevnEOPldw39fJskHVFrCNvQEYb4AntkECIUBUpvF7rp71MaT2f+
         A2CnMRSWhgnSlQ3sibTfaLfAlito+femBXlxGILNE7yo823an9XhTaI54N5WBajAm1Rc
         4H9Z4GSg6c29Nm+BTcWetvqAsaU4AwOGL1O/EhRqY5a2Ww5puWaN0RQnAeHuohjllJ8D
         fAg+Iclrpwj+CkpwTFw63knfFkgT/HzRvI76IkIBEeya9CS9hgmTl8BCEP9Q6+T3uvN3
         92Y2mIrUV7txn44EJ5SmfH/PejQVkKYB2D0T5IlazDJeByO7FJkavmi+gjSA/wLeYRa3
         bykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478281; x=1790083081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPH1+eiN4EhHtK6rDK3I01/qZvQ6oNbinGntBhruq3Q=;
        b=2H++e2DHnPy68bVWs3Ixz5+yeyhsHotZ3z6Bde2l+RycraB/kouXdnxSUjwk+YpVnD
         mphO/ZniW8JAT1de8BxA/4dJqdLjNGkHqEO+Jq1CL4oFPda8QDcdFgmnk1+IWz4Ft1GK
         e5l/L6o9hvmBGRd4bsKRxg2sdPFcMF2vmSa+fhcQai+IT0P4gbBcqUBlsC/xD/T5mfrm
         4Mc6/4+LLLtqNUhJLUGSlzxiGpG+LCKwEcZYW6Twz4S0w2lwSNmtsQ69AGWNUgO4QaEW
         07wjk20wBEpO8z41MLWSqoLzCqPKG+6Gq6yDyTBMUcp9hVr1wIxXggbFrbqvTLTtOpKf
         WbQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEpiUlebY9kqzTrDNu0wGl08Gt/VQfTjyS5fdTdPGsk07t8TnWlIMhBHOUgnGNQQcJYDg=@vger.kernel.org
X-Gm-Message-State: AFuF++kO9cEmm52Fy0BdUhIhXeYz51XGbgt55WSZDIlXYRz/ZyDvEQuo
	hAz8GJtFEPg52efRwI0IB0bYa9W/YLMOWh08Wy0l5zxHXzxFa7hb/UiZqjAfC0gLjY8=
X-Gm-Gg: AYBFou3p/K8zuKnGI518eT7L2idD7Tw3VHPWmnBIg9bN4CKC987oBos2/hIiQ2FTJS9
	h9SImYaGRyCfqLMMrICBVg1aWv8DkxASGaDTi2HyWyIgR0FE7Kot2qAi8hLLwMVarlfDDzSXf/X
	wWqG04SEADFj2/PMnKaVWIju8OyI2GymA8X3b4cVBtZsk/4GUvnuZJeBxmbaB0y+ERQlqmAbfkR
	KRaJ7CImURai+FrXXJq2+66socuHBGTB3jj8lcXfWX9jStr6Z5r4crkr1BPmgcKdko0H0xWUp9x
	3AvKDG92dDL2saPPNeu3oh+r4EaQlDEkXRCaGfasCU5SiO/JbjLhlfs1vxTyPxpbJVV0bYrXUjn
	MF8Wm4p2Y6B+n3WjOmYTFeyUtYeYuUmM9fNbefWCcFROzUiK8NTbXrFyDi3mBHGSeVIfCB33fl3
	6/yfx4EgneVND3hMu0aQu18GtmRo4T+a6ANOgvoyV3cnyhTQYvEU2M34PcMmauLq2mmRZTAOgMm
	TfGclDP/sYk2ZfEsMCJuAJ613gS/D0vVHkLtu/s9gNiC2it7Lt5yCAt
X-Received: by 2002:a0c:f40b:0:b0:907:dd19:fcb3 with SMTP id 6a1803df08f44-9122e55d2e0mr126180476d6.24.1789478280887;
        Tue, 15 Sep 2026 06:18:00 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f47afc2sm120542886d6.20.2026.09.15.06.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:17:59 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 15 Sep 2026 13:17:34 +0000
Subject: [PATCH RFC v3 07/13] x86/ftrace: Take a Tasks Trace reader around
 ftrace_caller's call-out
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-rcu-tasks-preempt-qs-v3-7-0ad30c4c5ee7@toxicpanda.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789478262; l=9964;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=EBgIXBiL5Z/I6XbFK2Nq9sAUVoT2dZ9k9OxjIjZChGA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJJZPzWCoHiGtBk3LJYNRCR9qGstVoSpG9sCCUThRLJ2AVjOv69KNmqUSOUhIKjcnlXv6dm2yvx
 k1FTR+gbuUgc=
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
after the call returns.  The sequences are inside the region that
create_trampoline() copies for per-ops trampolines; their %rip-relative
references are fixed up by text_poke_apply_relocation() like
CALL_DEPTH_ACCOUNT's.  %rax and %rcx are dead at both points.

Two pieces of core text still run outside that reader while holding
the address of a Tasks-RCU-protected trampoline they are about to
enter: the static stubs themselves, whose direct-call tails keep a BPF
trampoline address on the stack until the final RET, and, under
CONFIG_MITIGATION_RETHUNK, the return thunk that RET expands to.  Add an
ftrace_static_tramp_end marker after ftrace_stub_direct_tramp and linker
symbols around .text..__x86.return_thunk and .text..__x86.rethunk_safe,
and provide arch_rcu_tasks_trampoline_text() covering
[ftrace_caller, ftrace_static_tramp_end) and both thunk ranges so the
irq-exit check treats a task interrupted there as a holdout.

All of this is built only under CONFIG_TASKS_RCU_TRAMPOLINE_READERS,
which x86 does not enable until a later patch.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/kernel/asm-offsets.c |  8 +++++
 arch/x86/kernel/ftrace.c      | 43 +++++++++++++++++++++++++++
 arch/x86/kernel/ftrace_64.S   | 69 +++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S |  4 +++
 4 files changed, 124 insertions(+)

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
index 17d6edfcb7e0..9babaed483eb 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -275,6 +275,49 @@ static inline void tramp_free(void *tramp)
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
+ *    target.
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

-- 
2.55.0

