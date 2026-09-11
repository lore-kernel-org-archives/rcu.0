Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E24A33509B
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135798; cv=none; b=AMqsMSvggAaA4gtcyDyEfHKumAx9QMWSvFB8JAWa8He5RFujkFKC2CAS6T5OlTY8X9/KmDTFc4p0MAGFvsiY0ztEHDgheVg72pTHPHHPkEkoOEVksHkap7DpocPfTgAkgf5suLD/p4wPu4wtONBdTJ/X3Qt1tjL4142ip2tLQkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135798; c=relaxed/simple;
	bh=CNudSyp9EGSFLIPrtB5sqvKMksuv/pGd9p7EfdyuASs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIAwewWndU8f5aPJ3+vHjvLDupoVkzx6h+vosjwSXfBti7WmgW7KLgVZlodTo9mW61mD3iFoCD2mgB/4os1+oVuRCXf/+TdOvwDCVlFNHY8xzKLLgQrsTwWCoWugCiVGy9DucOabudlxNdJOQMKgctSVFMBDrKWtNMd/d+MUBj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=m49NHOZ4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="m49NHOZ4"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52f83889a93so12522411cf.2
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135793; x=1789740593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vr/1/6kD89CuecwWXrcFDfjNkcZoJvv75czWOOFkQAs=;
        b=m49NHOZ4v0ym6IbKk9klmPfeBYl4S5Rnq/c+suk6XnnHX/OUivGDybXsa8sbQjWkVE
         QTVlNUUTQHs/+aSdPks9LWXTr6mK2MzO0vYzWmIcAl8meRd9syCb8etfdqUuTb9EroVd
         pSFV5zgrtM0l8XHynCe14cTh4EzacaXyQ+JT/NMtKl0/n54lv86Gm8GSmaUI6G+FXycp
         HPBZG1lPyYmrYN6zsRtBHionqN5rC2LxNvuVzXQhAjkPJMkoOr09fM4+q60jpEbrzb4U
         m3Dka/XQEBu8xQUaFmtpQYTRpEMYzouSGWypMwTe6BH4OJII4kq6xeHQC6U+7/FQzznQ
         sRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135793; x=1789740593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vr/1/6kD89CuecwWXrcFDfjNkcZoJvv75czWOOFkQAs=;
        b=YhE/XAAU+4ReO5tIi5cPHoR8KZA/ekEj/0GFOFnBfkGSWC/Yl4A56VL1aQCXBGfwzp
         8mqOBCZfZpkx/QXMCaDnEbmqqiTunp5PQqMgv6PK3Mnq5CIhJQLK5DSk0IMKg49dTTmZ
         bF/8wj4S5xRMkU9OWEs8eeDMsTIdZiNEdyhMIbrZiLhSM6pv/HZ61ypDN5lnPLlbs5W3
         dMt0nqlTRtq6iCxgbtArQEARE7PYC2dF175d+oIuydGQiEUJwpEfupX7M9O6goQ4PU3l
         SmyPs3FW946L22gb9KPe3BR+b87PxU5Ml6R6UlxOKtRfHsWccJDXAL4TX3SdIduP1abm
         MZug==
X-Forwarded-Encrypted: i=1; AKwUvBzGqKZBvQM/+LoEVTuM05w/sJmZL/cFwRbM/XlXZM4QkBY74CPvd55Osn3wmVaW05V8PH4=@vger.kernel.org
X-Gm-Message-State: AFuF++lWKBW7sWuCJQOwHemnxc6RDZ28ljJ9sEcWV7hrWAAwmJSTzrg3
	1vzgAm96G19D+8WhNGTV7fNZJFcQfBz+nmdm+FtjgIDIDbAmN/ISmhRXzW7/iv08Zic=
X-Gm-Gg: AYBFou2mUzdzkqFSFUA/zltNLBSoICIFoAjz1Ixb6c2CqlQ7Z1ZHpIy6jKpvnEBc/dJ
	LxvdxapGkkfHhA3JPkEUvy2qGEN/QyZ0Pxsyz2RYzLVgRogmjI8e23y9t2/KbKCWNZoAzW7mYlm
	7X7M2d4X7zfeVVYMpt6sxa0jCXCCcOFyz5/NivlfcnEx/QwDRbcaL/aFGpv0w+o9HXEw7WSYfch
	TjiUAXER9/Dz4lhPo3ARpoRxf4JYEVhkIPU2ZwwX6JgokkgYxNI/Aa/isWOi2n6S1RjUDSrIbi5
	UPuGnAxOezf7OssOEnlk34Trt7v5HRUM5TDK90AlX7oVBVhbwo14JulOaCgvcpru62WtcRAwGS1
	XWCOi5wdZYYO+DPuHMdVphAiLpKVbvoqgxEzaoTU+p4OlZ/0SD7XNHCGCJeYxH5dSu/fWTEC8uH
	Hy1WPbfrOWk/dcTvwrng6qExWJiDlwHkYjJ6IFr2qHjLrk9eqUVJDPFvNRi+bbDVXOSHVJjfncT
	hOTbMeO7fS28WfsZSsJ/eC3rVFrywZ+2CA6E7s4j27v9x6nb+dTrAqA
X-Received: by 2002:a05:622a:393:b0:530:a441:c52d with SMTP id d75a77b69052e-530c876307fmr64046411cf.46.1789135792869;
        Fri, 11 Sep 2026 07:09:52 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca50cd05sm20570811cf.29.2026.09.11.07.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:09:51 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:41 +0000
Subject: [PATCH RFC v2 03/15] rcu-tasks: Hold trampoline nesting across
 irq-exit preemption in trampoline text
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-3-eaaa61ed2da4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135736; l=9197;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=CNudSyp9EGSFLIPrtB5sqvKMksuv/pGd9p7EfdyuASs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDP3NG/b7q989dUqjalqec1jdmkHZIx2wGCVq3J1Gir+zOd7a4FhOwI8Us9/xLubjdPD5eVSQFN
 Ltn5AyJDBWwY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A trampoline's own rcu_tramp_nesting increment and decrement live inside
the trampoline, so there is a window of a few instructions on entry and
exit where the count is zero while the CPU is executing trampoline text
(or text on the way into one, such as a static ftrace stub holding a
direct-call target).  In that window the task has not called out, so it
can only be preempted from an interrupt, and the interrupted instruction
pointer identifies where it is.

Add rcu_tasks_ip_in_trampoline(), which treats any IP outside core
kernel and module text as potentially Tasks-RCU-protected (ftrace
trampolines, BPF images and programs, kprobe slots are all dynamically
allocated text; is_ftrace_trampoline() and friends are deliberately not
used because text being torn down may already be unregistered from them
while a task still stands on it), plus a __weak
arch_rcu_tasks_ip_in_trampoline() for core text an architecture needs
to flag.  On irq-exit preemption, if the IP matches, hold the count
elevated across preempt_schedule_irq().

Introduce ARCH_HAS_RCU_TASKS_PREEMPT_QS / RCU_TASKS_PREEMPT_QS to gate
this; no architecture selects it yet, so the check compiles away and
there is no functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/rcupdate.h | 17 +++++++++++++++++
 kernel/entry/common.c    | 23 ++++++++++++++++++++++-
 kernel/rcu/Kconfig       | 10 ++++++++++
 kernel/rcu/tasks.h       | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/rcu/update.c      |  2 ++
 5 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index b5c666c82479..0a408e36ea15 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -173,6 +173,9 @@ static inline void rcu_nocb_flush_deferred_wakeup(void) { }
 
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
+/* Arch hook for rcu_tasks_ip_in_trampoline(); see kernel/rcu/tasks.h. */
+bool arch_rcu_tasks_ip_in_trampoline(unsigned long ip);
+
 /*
  * Note a quasi-voluntary context switch for RCU-tasks's benefit.
  * This is a macro rather than an inline function to avoid #include hell.
@@ -189,6 +192,16 @@ static inline void rcu_nocb_flush_deferred_wakeup(void) { }
  * or was called from, such text and an involuntary context switch must not be
  * treated as a Tasks RCU quiescent state.
  *
+ * The increment and decrement themselves live inside the trampoline, so there
+ * is a window of a few instructions at entry (before the increment) and exit
+ * (after the decrement) where the count is zero but the CPU is executing
+ * trampoline text, or text on the way into one (a static ftrace stub or a
+ * return thunk holding the trampoline's address).  In that window the task
+ * cannot be preempted synchronously, only from an interrupt, so the irq-exit
+ * preemption path covers it by checking regs->ip with
+ * rcu_tasks_ip_in_trampoline() and holding the count elevated across
+ * preempt_schedule_irq() when it matches.
+ *
  * Only current writes the count and only current (or an interrupt on the same
  * CPU) reads it, so plain accesses suffice.
  */
@@ -211,6 +224,8 @@ static __always_inline void rcu_tasks_trampoline_assert_none(void)
 		WARN_ON_ONCE(current->rcu_tramp_nesting);
 }
 
+bool rcu_tasks_ip_in_trampoline(unsigned long ip);
+
 # define rcu_tasks_classic_qs(t, preempt)				\
 	do {								\
 		if (!(preempt) && READ_ONCE((t)->rcu_tasks_holdout))	\
@@ -226,6 +241,7 @@ void rcu_tasks_torture_stats_print(char *tt, char *tf);
 static inline void rcu_tasks_trampoline_enter(void) { }
 static inline void rcu_tasks_trampoline_exit(void) { }
 static inline void rcu_tasks_trampoline_assert_none(void) { }
+static inline bool rcu_tasks_ip_in_trampoline(unsigned long ip) { return false; }
 # endif
 
 #define rcu_tasks_qs(t, preempt) rcu_tasks_classic_qs((t), (preempt))
@@ -245,6 +261,7 @@ void exit_tasks_rcu_finish(void);
 static inline void rcu_tasks_trampoline_enter(void) { }
 static inline void rcu_tasks_trampoline_exit(void) { }
 static inline void rcu_tasks_trampoline_assert_none(void) { }
+static inline bool rcu_tasks_ip_in_trampoline(unsigned long ip) { return false; }
 #define call_rcu_tasks call_rcu
 #define synchronize_rcu_tasks synchronize_rcu
 static inline void exit_tasks_rcu_start(void) { }
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e4acd50bd81a..cd3feaca6420 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -134,6 +134,27 @@ static inline bool arch_irqentry_exit_need_resched(void);
 static inline bool arch_irqentry_exit_need_resched(void) { return true; }
 #endif
 
+/*
+ * Preempt the interrupted kernel context.  If the interrupt landed in text
+ * that may be a Tasks-RCU-protected trampoline (see
+ * rcu_tasks_trampoline_enter()), hold current->rcu_tramp_nesting elevated
+ * across the context switch so that it is not mistaken for a Tasks RCU
+ * quiescent state.  This closes the few-instruction windows at trampoline
+ * entry/exit where the trampoline's own increment has not yet run or its
+ * decrement already has.
+ */
+static void irqentry_preempt(struct pt_regs *regs)
+{
+	bool in_tramp = IS_ENABLED(CONFIG_RCU_TASKS_PREEMPT_QS) &&
+			rcu_tasks_ip_in_trampoline(instruction_pointer(regs));
+
+	if (in_tramp)
+		rcu_tasks_trampoline_enter();
+	preempt_schedule_irq();
+	if (in_tramp)
+		rcu_tasks_trampoline_exit();
+}
+
 void raw_irqentry_exit_cond_resched(struct pt_regs *regs)
 {
 	if (!preempt_count()) {
@@ -142,7 +163,7 @@ void raw_irqentry_exit_cond_resched(struct pt_regs *regs)
 		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 			WARN_ON_ONCE(!on_thread_stack());
 		if (need_resched() && arch_irqentry_exit_need_resched())
-			preempt_schedule_irq();
+			irqentry_preempt(regs);
 	}
 }
 #ifdef CONFIG_PREEMPT_DYNAMIC
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 332df7a7a634..999f8228a13d 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -107,6 +107,16 @@ config TASKS_RCU
 	default NEED_TASKS_RCU && PREEMPTION
 	select IRQ_WORK
 
+# Selected by architectures whose ftrace, BPF and kprobe trampolines maintain
+# current->rcu_tramp_nesting and which use the generic irqentry code, so that
+# a preemption outside any trampoline can be treated as a Tasks RCU
+# quiescent state.  See rcu_tasks_trampoline_enter().
+config ARCH_HAS_RCU_TASKS_PREEMPT_QS
+	bool
+
+config RCU_TASKS_PREEMPT_QS
+	def_bool TASKS_RCU && ARCH_HAS_RCU_TASKS_PREEMPT_QS && GENERIC_IRQ_ENTRY
+
 config FORCE_TASKS_RUDE_RCU
 	bool "Force selection of Tasks Rude RCU"
 	depends on RCU_EXPERT
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 1662ba18bf34..a801ec4a951b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1089,6 +1089,44 @@ static void rcu_tasks_postscan(struct list_head *hop)
 		timer_delete_sync(&tasks_rcu_exit_stall_timer);
 }
 
+/*
+ * Architectures selecting ARCH_HAS_RCU_TASKS_PREEMPT_QS override this to flag
+ * core kernel text that must be treated like a trampoline, e.g. static ftrace
+ * entry stubs and return thunks that run with a trampoline address in hand.
+ */
+bool __weak arch_rcu_tasks_ip_in_trampoline(unsigned long ip)
+{
+	return false;
+}
+
+/**
+ * rcu_tasks_ip_in_trampoline - Could a task interrupted at @ip be a Tasks RCU reader?
+ * @ip: interrupted instruction pointer
+ *
+ * Called from the irq-exit preemption path with interrupts disabled, to decide
+ * whether the imminent preemption may be reported as a Tasks RCU quiescent
+ * state when current->rcu_tramp_nesting is zero.  Returns true, meaning "do
+ * not report", when @ip is:
+ *
+ *  - outside static kernel and module text, i.e. possibly in an ftrace
+ *    trampoline, BPF trampoline image or program, kprobe insn/optinsn slot or
+ *    other dynamically allocated text whose lifetime Tasks RCU guards.  This
+ *    deliberately does not consult is_ftrace_trampoline() and friends: text
+ *    being torn down may already be unregistered there while a task still
+ *    stands on it;
+ *  - in core text the architecture flags via arch_rcu_tasks_ip_in_trampoline().
+ *
+ * A false positive only defers the quiescent state to the task's next
+ * context switch.
+ */
+bool rcu_tasks_ip_in_trampoline(unsigned long ip)
+{
+	if (core_kernel_text(ip))
+		return arch_rcu_tasks_ip_in_trampoline(ip);
+	return !is_module_text_address(ip);
+}
+NOKPROBE_SYMBOL(rcu_tasks_ip_in_trampoline);
+
 /* See if tasks are still holding out, complain if so. */
 static void check_holdout_task(struct task_struct *t,
 			       bool needreport, bool *firstreport)
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index b62735a67884..23be7e97c3b5 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -41,6 +41,8 @@
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/isolation.h>
 #include <linux/kprobes.h>
+#include <linux/kallsyms.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/irq_work.h>
 #include <linux/rcupdate_trace.h>

-- 
2.55.0

