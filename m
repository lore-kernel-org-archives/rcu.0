Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FD758E2CD
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066272; cv=none; b=S3iJ3g+I1ITrvz1tIfeb7J4KKnPnBN+uSorHMQIiiYnyHht/xDrCY/+nAJnKrj0hvvjKo6UcLD284ciOSvh2oUPUybP6DeQ0GdOuKuEQxfp4uuGx+5d9rYLycqZfHJbKNJXhayWZTgc8vevNF9UTTRSCrdMLX3NGWoRdgDZdk5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066272; c=relaxed/simple;
	bh=bmu7zPpxbnsCSHBhyK2WDk3M9VMJMCkgBrW5uszUBuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4VVUT9zpRrm0I9JojCNR/XCE7RhMGsPxmrsR+UPWjoUwclZCWBesa85/MscyVA2jxOJSdWeUL9S5H0+qD06VGkeljDXvDpsMii70aliVjWWSnndm3KaEBs2ev6Six6J0K13wJSFqBP6X20EOJHFGzy1h7EqOGDZzBgWkXg+rTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=N6WQL5gZ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="N6WQL5gZ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-52d7a3defe8so1556811cf.0
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 11:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066263; x=1789671063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sAaaOhrJ7Jcw63o+Xz8kKBY4jQKDr2HCsih3+9envV4=;
        b=N6WQL5gZMClnsrkfEj+Hr3ZLy2BVKgqAHi5x62pDA/nP9WZXgF2d0gwGqqCQF2hNKw
         6QHxECldF3kRcZweckcO8RGHwQ0Vehf9wUF2wxEVJCyztvyMfRYQz17LB5pHXs5KAEnT
         vIm2LsRZ/lksvkmy/ig0s47igDed1knKewR37Kjc/Ror/afPQPI4j/hhiJAqzXfq7KGK
         HHbmHvYqlEEvt0/qAsO7MeVwvEbJDjKwY8GrWviICmLy4WIoZl2jGILEZKN8yGMEPI/Z
         nkqpBOBy/XkxNe8sP52Abt+4RQH/HfTevSa9mXBO8p0o69kmEME+aMLdeK6k1IvLaCJw
         6K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066263; x=1789671063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAaaOhrJ7Jcw63o+Xz8kKBY4jQKDr2HCsih3+9envV4=;
        b=TmApWzio9FAiVI3nptZV0nQyJulBlmAGBb7SsKwlVKYG4HcGQIyf0hpSq+/Y7fce/K
         8ME1zTOMgQmpHAM0Whg87lFDCpFurSc7kROUuqsgCLKFxsSVys5obJV9l10SDag1aTfy
         fAIm1aEWartg4A6C08a9euvGkpc5wmljf4GWC4pvjCIEDf2jUboGcuozQb08GUXQ06Ka
         F2E/OoGQdH7MF//Bq8h7x9kqJTJ+V30A/gwTmK2D5lrH9o7fyr04SJBhdyPfi+9i95w9
         Zip/5fUumNArAQhoPOUtJQh+YGhMlm9i0NTsxcKYOw5C1MIp/Bx5HtqT9mStzWRVuRyj
         hTWg==
X-Forwarded-Encrypted: i=1; AKwUvBztICmhvefWG11SwCkwMlAAgVao4ur7ArIibaD0/fZ4MIRnOR2H3gnXxjfKvBp6R6TWXqk=@vger.kernel.org
X-Gm-Message-State: AFuF++l5xykhPAKOPtRDQbym8zhqE66Q7DHQ7nGc7+R9JBtPod7ATrXz
	5L984er2y6A0h2Ynx+Eo8RjARf56LXDeSDAR3WfoeOLrPBh0Y19eXYr2A1N6qKyECWE=
X-Gm-Gg: AYBFou0N7C1SU1Bb04V5jV1o2mDsAOnaXxPNAcOaPat+ogdvp2P26ZE2Ffq5NIXzUCP
	5vRL0m4KB7zQr6P0jwl+Fx0axSNF9qd8Ev/bjCpI2a2STk/7xlrr8ECy4Swmvd0N5PBJuhh0VoG
	IxB9s2YHEq7/demZe1e323mm9L+YtcZ2K2Ao0ZlA5j4ADKbLBRQHnqKK9IO/NJatKgL6Jnhg4aF
	Ot/FXbCvDGXgLQFCb/+rSOZX04F+0mCpRSDV+ExgK06Pk0ql4DxUDysEMsO0uhsnXCU96s2ieEa
	+EbVtQEt0g1/uUcwbOyeSpm8bsBINToIyDOGeLTcV0luiL7gosqbP9LsqERJdF4xHW8DDcJqPbi
	JumAJicprbKKDTG6SWSfUuLipv3zXOL5EH3umGiw+nhT49TPKDUVWt0CYxa5+vmqUHzvSsJAoI1
	f4MqhYV4q47jPyYpyfq5S1+uDYD6fCfQUKJuR6zuONCxS81HVZPceDi0dB22CNcKPyfjiCYmY4/
	+A/mfddDPAeF2r3w0k5MRIP/wFDPza1XYo0jRs6gENyvw2if7683gNC
X-Received: by 2002:a05:622a:1309:b0:530:42d4:4c98 with SMTP id d75a77b69052e-530c8756e8amr10238141cf.42.1789066262237;
        Thu, 10 Sep 2026 11:51:02 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45a780sm2547836d6.10.2026.09.10.11.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:51:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 10 Sep 2026 18:50:29 +0000
Subject: [PATCH RFC 06/13] x86/ftrace: Maintain Tasks RCU trampoline
 nesting in ftrace_caller
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-6-d4469f4cc101@toxicpanda.com>
References: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
In-Reply-To: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
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

