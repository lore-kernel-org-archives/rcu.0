Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE65947F0
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066292; cv=none; b=UIcje7KBbsoTt870Nrn2XVAspGb31QHTUPzHrNf+7BanKiBbglAn4CgSZiq8KNIxQlHv7lFKqLDgKOxNtrW+FU1JG06XG+2qDEAayY4I6YZDLRdb81LvmsH5wz2SqdT5ty/dfINQrmQrPTW269Av15UPFva9wiHEUXyRUrvWDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066292; c=relaxed/simple;
	bh=xqTPn5S4ER1XAZhtIYfJFNG5V6jdP8hXJAwXIfHAJeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h/itXP26/TJ/Dn8AjMVVgKIyqtHD7J6RYBQwvFQEARMLyYfVjC9RSl1YNGX0IAOWwQGFFJ8+tbdLl8hrHjpf0OD8RhJGdMZUVbRp/IwD7q/skWLNgPcKPJD1GRKzAqE/kVklyWfKL92qJVeUs8xjQMrwZb7+wa6Ax2B+abiWApA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=oujyAnKR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="oujyAnKR"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9399c77e2ebso11235185a.1
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066274; x=1789671074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q0Z6kl89L/mcJKSDFUzFWtYRNb/tGGuag8yv3GYWCr4=;
        b=oujyAnKRPUzGJo8p+a9zB0a+kQomXrMS3koDRM+QzaqanK94n+oQhbtQtKFriiLVGE
         z9vKezOkvptmtuA05b8aWGmrgWREz0qI+IURwht0y+/rswQBA5RdGPDVJGgu/NSsPxKG
         yd+TAmbcoZq0Z77THs13b2/EEzNuSBZSzip2bytBD/3b3/NSzHm1g8zyEzMvhJSuTMw3
         oqwx8AaNex2r+VcB1f97bsThC6TL5PTPd+8i0bKpygdicQA2Q/HORcfECIyRzwoGpWna
         by4evNiU5ZPzeDjYXmJxIJIYhnxcIU9PyB3afxB9uEXGN7oh0EDQOCoif3KKD1pOYT6X
         5p7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066274; x=1789671074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0Z6kl89L/mcJKSDFUzFWtYRNb/tGGuag8yv3GYWCr4=;
        b=ZZQ7C2iVjnIhXigi9/Nc/XPt10On51s8T2JmmqZPRFe/o3WWiaUSCDSL0YtedWtlh0
         LS50LmyoTroscyvbHFO6y2kUwtcoigEyANAzUV60euNqYzWalLaBB8TfDwGmIbrxCuAL
         17FEsuzAKBtwIRyvC8a4JkwdLO0joFkbSiC7GSqEfMvIDzeGoGUoLx88auUwLpPFLR1n
         O1IkUnKaY2sLWeyK3jd0WYIs207L+ooLu3oRiAZZRKXJFy65WwZIvugXkiFyR8bazCJZ
         djruh7z/sr3LcCXwzyAUVdRzsfiSBiQjH5Giqwz891Le8/0tBYvF2zKwNlXfiHrYGzHj
         7xDA==
X-Forwarded-Encrypted: i=1; AKwUvBxK2zx1unTP9tG/0ACN4yAASNMJ1+rxTXQ8DzUum5KYNtnnpNrmOPg9pl88h8urtwvNMto=@vger.kernel.org
X-Gm-Message-State: AFuF++mM8YSSW5MjytqmNKN7R/oMhvXiJDda/e+Q6kUuyW8ymFP1phcv
	qDANR6Yjk7Kwd7QXq61jRhQ31DqDaEt/dchj7s36/NpVMWg5IxELLJu9+Glihkh2Z0I=
X-Gm-Gg: AYBFou3cRahby2K97OT8S5jHxGpC1StTN+mUyvtkiZrR1llzK3+gDJ3bqvEIQAWoAN/
	OhPta7kzVjhBwop52fUquS73xJjHLyIb0E0p225IIhIU4e+8zTS5ipL5B3q6WAMXPSoWgPj6uD0
	lBhLHaN+lhxgaS61Jqghihi99DwjIuptKxP5PSykmCVQ/5SBQfeArcXVj6WiyIp75WPPEcuSZcP
	IC/NsJ/5lrG36t4rHvnLdAl8qH+GyiJpvMkI5YveeuY/BFU6JbZfFIqYkbP3XbjWR3u3fsxbtfu
	pbhAMK7l25dkEHVBhe/YB1WAlJxvKfDNES0l2wAkMs4S8dzI/bV8GcjZc/6WPgeQYj+ckFb7EOf
	ucj9rB7o8sSfcHcSlxLnvdj48zLb/07moWxP33zWrWzfLyieEgbIjMDhll9xnkDtMzu2V5McAEy
	B3KKwr+vP6444BbgX3IQwnM4Rq9gZ61YN5iyeE4GI7P48JF8tMv4G/CCAExa7jibzCQfwy2HQ44
	+L6ZR3BbwFLqEwKz1maTNWges/GPlwDWVb7jp+sNvhVDgDGDsAA+nx4+uF67nXJq14=
X-Received: by 2002:a05:620a:1a0a:b0:939:ca72:bef8 with SMTP id af79cd13be357-939d7fe4f58mr706492885a.41.1789066269332;
        Thu, 10 Sep 2026 11:51:09 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f1da12sm50063385a.9.2026.09.10.11.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:51:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 10 Sep 2026 18:50:32 +0000
Subject: [PATCH RFC 09/13] arm64: ftrace: Maintain Tasks RCU trampoline
 nesting in ftrace_caller
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-9-d4469f4cc101@toxicpanda.com>
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

Bracket the call out to the ftrace_ops callback in ftrace_caller with an
increment/decrement of current->rcu_tramp_nesting, using x12/w13 which
are scratch there.  The read-modify-write is not atomic, but only current
modifies the count and every interrupting user is balanced, so nothing is
lost.

ftrace_caller itself, including the early CALL_OPS direct path and the
late direct tail that carry a BPF trampoline address in x17 with the
count at zero, is static kernel text: add an ftrace_static_tramp_end
marker after ftrace_stub_direct_tramp and provide
arch_rcu_tasks_ip_in_trampoline() covering
[ftrace_caller, ftrace_static_tramp_end) so the irq-exit check treats a
task interrupted anywhere in it as inside a trampoline.

The hook is built only under CONFIG_RCU_TASKS_PREEMPT_QS, which arm64
does not select until a later patch.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/arm64/kernel/asm-offsets.c  |  3 +++
 arch/arm64/kernel/entry-ftrace.S | 35 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c       | 16 ++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 9c853ed3ceab..f6655a284f18 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -39,6 +39,9 @@ int main(void)
   DEFINE(TSK_STACK,		offsetof(struct task_struct, stack));
 #ifdef CONFIG_STACKPROTECTOR
   DEFINE(TSK_STACK_CANARY,	offsetof(struct task_struct, stack_canary));
+#endif
+#ifdef CONFIG_TASKS_RCU
+  DEFINE(TSK_RCU_TRAMP_NESTING,	offsetof(struct task_struct, rcu_tramp_nesting));
 #endif
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 025140caafe7..46a102e7199a 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -14,6 +14,33 @@
 #include <asm/insn.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
+/*
+ * Tasks RCU trampoline nesting, see rcu_tasks_trampoline_enter().  The whole
+ * of ftrace_caller is treated as trampoline text by the irq-exit IP check (see
+ * arch_rcu_tasks_ip_in_trampoline()), so these only need to bracket the call
+ * out to ops->func; everything before the increment and after the decrement,
+ * including the direct-call tails that carry a BPF trampoline address in x17,
+ * is covered by that.  The count is only modified by current and every nested
+ * user (interrupts) is balanced, so a plain ldr/add/str is sufficient.
+ */
+	.macro rcu_tasks_tramp_enter, tsk:req, tmp:req
+#ifdef CONFIG_TASKS_RCU
+	mrs	\tsk, sp_el0
+	ldr	\tmp, [\tsk, #TSK_RCU_TRAMP_NESTING]
+	add	\tmp, \tmp, #1
+	str	\tmp, [\tsk, #TSK_RCU_TRAMP_NESTING]
+#endif
+	.endm
+
+	.macro rcu_tasks_tramp_exit, tsk:req, tmp:req
+#ifdef CONFIG_TASKS_RCU
+	mrs	\tsk, sp_el0
+	ldr	\tmp, [\tsk, #TSK_RCU_TRAMP_NESTING]
+	sub	\tmp, \tmp, #1
+	str	\tmp, [\tsk, #TSK_RCU_TRAMP_NESTING]
+#endif
+	.endm
+
 /*
  * Due to -fpatchable-function-entry=2, the compiler has placed two NOPs before
  * the regular function prologue. For an enabled callsite, ftrace_init_nop() and
@@ -94,6 +121,8 @@ SYM_CODE_START(ftrace_caller)
 	stp	x29, x30, [sp, #FREGS_SIZE]
 	add	x29, sp, #FREGS_SIZE
 
+	rcu_tasks_tramp_enter x12, w13
+
 	/* Prepare arguments for the tracer func */
 	sub	x0, x30, #AARCH64_INSN_SIZE		// ip (callsite's BL insn)
 	mov	x1, x9					// parent_ip (callsite's LR)
@@ -111,6 +140,8 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	bl      ftrace_stub				// func(ip, parent_ip, op, regs)
 #endif
 
+	rcu_tasks_tramp_exit x12, w13
+
 /*
  * At the callsite x0-x8 and x19-x30 were live. Any C code will have preserved
  * x19-x29 per the AAPCS, and we created frame records upon entry, so we need
@@ -178,6 +209,10 @@ SYM_CODE_START(ftrace_stub_direct_tramp)
 SYM_CODE_END(ftrace_stub_direct_tramp)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
+/* End of [ftrace_caller, ...) for arch_rcu_tasks_ip_in_trampoline(). */
+SYM_CODE_START(ftrace_static_tramp_end)
+SYM_CODE_END(ftrace_static_tramp_end)
+
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
 /*
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index e1a3c0b3a051..1b7ac2afed0d 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -17,6 +17,22 @@
 #include <asm/insn.h>
 #include <asm/text-patching.h>
 
+#ifdef CONFIG_RCU_TASKS_PREEMPT_QS
+extern void ftrace_static_tramp_end(void);
+
+/*
+ * See rcu_tasks_ip_in_trampoline().  ftrace_caller and ftrace_stub_direct_tramp
+ * are core kernel text but must be treated as trampolines: a task preempted in
+ * them may be carrying an ops pointer (x11) or a direct-call BPF trampoline
+ * address (x17) whose lifetime is guarded only by Tasks RCU.
+ */
+bool arch_rcu_tasks_ip_in_trampoline(unsigned long ip)
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

