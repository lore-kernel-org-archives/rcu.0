Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553334214A
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135805; cv=none; b=IzblXKDMmWC0j+KdsxwY2Iik7zJSVayuurnEqxz74+e+GT2zbr70t8wbn27ayaBXeLA8bJBOQbhzJjvei+OfCnnSHjUAFNA4yZAyLpBNcE4dIJLiNtEjMBJVIk8Q/zOqNgsco4F0lfpkZYLD9l6txKsYROkNDDLENSAH5s6Hjok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135805; c=relaxed/simple;
	bh=bmu7zPpxbnsCSHBhyK2WDk3M9VMJMCkgBrW5uszUBuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7XeoyvuzIlIIRBCnpSGrkXJJHGxgZEm1/VAtDepsI8A7e0JHhfUHg7AurlKETDKi6F9fDoPNGDepJLeYlG3Hn2DU4+szf06ojo2k0RO6g7CONIbhsYL9wcYaiCNFzMV1VTIL9NXhybR87bC4EiRyqu/qV/fsy267BWaOf5sRqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=mTGTM7MP; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="mTGTM7MP"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92f0b5ed131so121687785a.3
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135801; x=1789740601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sAaaOhrJ7Jcw63o+Xz8kKBY4jQKDr2HCsih3+9envV4=;
        b=mTGTM7MPxRypre8jxkaNuaTqQSAuveXI14x955eL4IqYfDTunsi4jrKR2BnXh2rB1k
         dB7y4TKv1EmPoi2sTL4TKkRLwnc9jf2i9YfPxDQUuiwjnWsZ/9Lb0SnLuIRy7ZOMUoAS
         xt9H08GFHCRfk2K10WpGyxPjW93HuVZbC6Twb0ZWDyXLait8yEJ+NQguzTUp+3sAmp5D
         T69lt0s7JWUoMLq13KkDTO1U8DsT7QgQdoHTjMLtdBqPUN+x+oTAE1hlvlod+o67/eA1
         3NdWlJArvEGRTpTfdUubVT0Z8P4wTJIgY6qrVf3JmKARZXy6RqcvfJufZv8K1BLar746
         6i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135801; x=1789740601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAaaOhrJ7Jcw63o+Xz8kKBY4jQKDr2HCsih3+9envV4=;
        b=TDGTGmY/bpmpTVaGnVcrVI+5+P9HF5jXQIoj5stMDDKnYRFgXOZu+eIpmorCdC2ll+
         J/gBALANdqpeBUsUI1YERBONPzq+AVsvX4HRfgkEmc3ksEzCv0HaKb56z9bhT3zEikGr
         LK5nqJux+LUKKHL4yxg69lxSIYmxMvK9EENylGhmIinMmpp179GOea4b2nLTupxaUTO6
         3oyu/fu2D5rPo7vA3zk9r2domkfboqFNMv83QkU4Rfbw4hx0TJMxjFE7lzjhia7IR8Xv
         GzG8g9sfntAZNTk47Y1xIMsE5/t4sFi3AdnHPLO+MJQYLCejdBl8JH215CUTWQTEC3pn
         WVuw==
X-Forwarded-Encrypted: i=1; AKwUvBxneq/YHlg8bRVHLr0pf0kgq0xXl9hgzheK/eKF9N9rDyRn0RCjHN7HNFfujQ3pT9Ll2d0=@vger.kernel.org
X-Gm-Message-State: AFuF++lMF98QJoo1L9okSbWI0K63RCSa9Sfyn9dQjR9nLgpFoUmoBPbr
	8+/lK7nP2itFgiFJEDvXLFQhgfTtVq4FNQHnEY0+IoAJZb/rxp/RYJ1QO4x99LcZHKc=
X-Gm-Gg: AYBFou1QJLZQG/wUKhVeVCfcX0kmUGXqXc9dJwBJwHJe6GxkM694y1MAdfPZTYanCPd
	r5ltH49Cflc/I7xxVDPN5PoWYhz2b0g75x6nhxiR5TpcAx5nMbv6fiPkU89aN4/l2s/fRmifYtd
	OlrQxuwrjymxg2RAPBBPuuq2UrTRzqF6aXFTG17o0rpqbHkZiT+Xyyyu/C3kU/xjqd0HWUWk1cv
	jK9YmsfUhTt7qn4vAZJYEKT7AA89srk+ZLRgr9e5TQFE2MVdDOE0jV4euOs6723pDtxzZTQBpKo
	Yak+HjKCOzTP0aYwHm14+kt36BMI7Kss+kkpldPkdrjqV5+r1IP9q2Vs7ddQGBZDrtpyWxT91Yw
	blFIxvJ5R+RHDUxzNBP75WuqBvU2XIzIgTAIMoz83/DbBjPiIVCK82igF6hVsQuGOV/kgmKnEYv
	/gjqqCzm2kPs/uHe9dVU2oPgWA9KCCvwthK0bSA+c6jzySJwKTDK6x8w7AnjfYF/qSMZzfHOsqK
	BOn/d8tuoBbt7ImOXtEy5rar+mjseVRUQ9QzDpBjnzjy3CIFqPol+ED
X-Received: by 2002:a05:620a:2589:b0:939:112:d526 with SMTP id af79cd13be357-939ea07c29cmr585929585a.18.1789135800554;
        Fri, 11 Sep 2026 07:10:00 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939fd0ebaf6sm17627485a.35.2026.09.11.07.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:09:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:44 +0000
Subject: [PATCH RFC v2 06/15] x86/ftrace: Maintain Tasks RCU trampoline
 nesting in ftrace_caller
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-6-eaaa61ed2da4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135736; l=7822;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=bmu7zPpxbnsCSHBhyK2WDk3M9VMJMCkgBrW5uszUBuU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHW3FDsl5CxgF20PG9LmVTMTg46RLyWS2XjYhSinsXHd+9ujqg/53BxxPRKz/SrjYV+XGJTF9Bc
 FIbELyLBq3wc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Bracket the call out to the ftrace_ops callback in ftrace_caller and
ftrace_regs_caller with an increment/decrement of
current->rcu_tramp_nesting.  The instructions sit inside the region that
create_trampoline() copies for per-ops dynamic trampolines, so those
inherit them; the %rip-relative per-CPU reference to current_task is
fixed up by text_poke_apply_relocation() like CALL_DEPTH_ACCOUNT's.
%rdx is dead at both points (about to be loaded with the ops pointer on
entry, restored by restore_mcount_regs on exit).

Two pieces of core text still run with the count at zero while holding
the address of a Tasks-RCU-protected trampoline they are about to
enter: the static stubs themselves, whose direct-call tails keep a BPF
trampoline address on the stack until the final RET, and, under
CONFIG_MITIGATION_RETHUNK, the return thunk that RET expands to.  Add an
ftrace_static_tramp_end marker after ftrace_stub_direct_tramp and linker
symbols around .text..__x86.return_thunk and .text..__x86.rethunk_safe,
and provide arch_rcu_tasks_ip_in_trampoline() covering
[ftrace_caller, ftrace_static_tramp_end) and both thunk ranges so the
irq-exit check treats a task interrupted there as still inside a
trampoline.

The hook is built only under CONFIG_RCU_TASKS_PREEMPT_QS, which x86 does
not select until a later patch.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/kernel/asm-offsets.c |  3 +++
 arch/x86/kernel/ftrace.c      | 37 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/ftrace_64.S   | 43 +++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S |  4 ++++
 4 files changed, 87 insertions(+)

diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 081816888f7a..4f3b1caa5a30 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -46,6 +46,9 @@ static void __used common(void)
 #ifdef CONFIG_STACKPROTECTOR
 	OFFSET(TASK_stack_canary, task_struct, stack_canary);
 #endif
+#ifdef CONFIG_TASKS_RCU
+	OFFSET(TASK_rcu_tramp_nesting, task_struct, rcu_tramp_nesting);
+#endif
 
 	BLANK();
 	OFFSET(pbe_address, pbe, address);
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 17d6edfcb7e0..8f63cd4b543c 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -275,6 +275,43 @@ static inline void tramp_free(void *tramp)
 	execmem_free(tramp);
 }
 
+#ifdef CONFIG_RCU_TASKS_PREEMPT_QS
+extern void ftrace_static_tramp_end(void);
+extern char __return_thunk_start[], __return_thunk_end[];
+extern char __rethunk_safe_start[], __rethunk_safe_end[];
+
+/*
+ * See rcu_tasks_ip_in_trampoline().  Some core kernel text behaves like a
+ * trampoline for Tasks RCU purposes because a task executing there with
+ * rcu_tramp_nesting == 0 may still be about to enter a Tasks-RCU-protected
+ * trampoline whose address it already holds:
+ *
+ *  - the static ftrace_caller / ftrace_regs_caller / ftrace_stub_direct_tramp
+ *    stubs, which carry a direct-call target on the stack until their final
+ *    RET, and
+ *  - the return thunks that RET expands to under CONFIG_MITIGATION_RETHUNK,
+ *    which run after leaving the stubs above and before landing in that
+ *    target.
+ */
+bool arch_rcu_tasks_ip_in_trampoline(unsigned long ip)
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
+#endif /* CONFIG_RCU_TASKS_PREEMPT_QS */
+
 /* Defined as markers to the end of the ftrace default trampolines */
 extern void ftrace_regs_caller_end(void);
 extern void ftrace_caller_end(void);
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 62c1c93aa1c6..902472c41798 100644
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
@@ -145,6 +146,27 @@ SYM_FUNC_END(ftrace_stub_graph)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
+/*
+ * Tasks RCU trampoline nesting, see rcu_tasks_trampoline_enter().  These live
+ * inside the region copied into dynamic trampolines; the %rip-relative per-CPU
+ * reference is fixed up by text_poke_apply_relocation() in create_trampoline().
+ * The increment must precede the function_trace_op load: between that load and
+ * the call, the ops pointer in %rdx is protected only by Tasks RCU.
+ */
+.macro RCU_TASKS_TRAMP_ENTER reg:req
+#ifdef CONFIG_TASKS_RCU
+	movq PER_CPU_VAR(current_task), \reg
+	incl TASK_rcu_tramp_nesting(\reg)
+#endif
+.endm
+
+.macro RCU_TASKS_TRAMP_EXIT reg:req
+#ifdef CONFIG_TASKS_RCU
+	movq PER_CPU_VAR(current_task), \reg
+	decl TASK_rcu_tramp_nesting(\reg)
+#endif
+.endm
+
 SYM_FUNC_START(__fentry__)
 	ANNOTATE_NOENDBR
 	CALL_DEPTH_ACCOUNT
@@ -163,6 +185,8 @@ SYM_FUNC_START(ftrace_caller)
 	leaq MCOUNT_REG_SIZE+8(%rsp), %rcx
 	movq %rcx, RSP(%rsp)
 
+	RCU_TASKS_TRAMP_ENTER %rdx
+
 SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
@@ -181,6 +205,8 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	call ftrace_stub
 
+	RCU_TASKS_TRAMP_EXIT %rdx
+
 	/* Handlers can change the RIP */
 	movq RIP(%rsp), %rax
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
@@ -209,6 +235,8 @@ SYM_FUNC_START(ftrace_regs_caller)
 
 	CALL_DEPTH_ACCOUNT
 
+	RCU_TASKS_TRAMP_ENTER %rdx
+
 SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
@@ -246,6 +274,8 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	call ftrace_stub
 
+	RCU_TASKS_TRAMP_EXIT %rdx
+
 	/* Copy flags back to SS, to restore them */
 	movq EFLAGS(%rsp), %rax
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
@@ -328,6 +358,19 @@ SYM_FUNC_START(ftrace_stub_direct_tramp)
 	RET
 SYM_FUNC_END(ftrace_stub_direct_tramp)
 
+/*
+ * [ftrace_caller, ftrace_static_tramp_end) is treated as trampoline text by
+ * rcu_tasks_ip_in_trampoline(): after RCU_TASKS_TRAMP_EXIT the stubs may
+ * still hold a direct-call target (a BPF trampoline) on the stack until the
+ * final RET, and that target's lifetime is guarded by Tasks RCU.  With
+ * return thunks the RET itself runs elsewhere; arch_rcu_tasks_ip_in_trampoline()
+ * covers the thunk text too.
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

