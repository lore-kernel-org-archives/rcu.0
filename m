Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD0383998
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044228; cv=none; b=hDCjmSxda78iPkrOxc/33CUAMj+8CzO7SzoCF4hjOonv89NHvaoewbBenzNnQOYLOk2xq9FLIhzCZ4Lo3s2TgP+4ehJyGE6VB3gsndocv6vMAEM0GGXQg7PufI6oc2WDqpJZzQQSE523J/xtP4t12hqxjqYjYf6fFvLeFmCcgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044228; c=relaxed/simple;
	bh=EPAPVj1FhQ7/+pop5mUZQszLO5ulnMl6jVPcEL6t5Gk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eEGHXh6YO3+BAMZRYa9vecan1kykdVEDtencjdxpnXiAJ9abVLsPuU5DXeBNBT/gPl71l/9hulW6Rzxk2QZjOzH2iewYmWL3hskhLGUYLYUSoAqqPd1IOABtqjJY7BY2X303RtZnFZgM+NAgcXy8xdoVZAvkR910+O7QK+2KZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=prV/DsyD; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="prV/DsyD"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfe57a3bso29318016d6.1
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 19:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790044225; x=1790649025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EMtH/e2BOZ+5Q/fPJ0djJ3i8PvS8/cEMBigMOOsU40U=;
        b=prV/DsyDw/ndMPYWkg7lHH+Q2B149NYvbSo39qG+pRUIcK/3aF/VNkhTvJ0Ajj079C
         jIVJFgGWmvnccqBOLrHdm7QPFleFXTdkeEldYtJEZvG7mlNpSNYc4oM94PigsAcqpW+Q
         7Fi9wDmeRs3VdHcPbWTV2r/9me39NoN9SZzfgnOywZGThii9ILgiqGaZ3Oz+V/A1uKKB
         FDTjVUVyS7f4lq+et1c6ZL7+8eoyxx2UkbgwgxELdm1VahZR6BXFzVe03uJSW/e532sF
         ymNKMLqefuplISr+GDYiePrdy9tlzAgFtxRlM0T1JxNMldZxyL4X7NnRSBjAgRK5KR+/
         C7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044225; x=1790649025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EMtH/e2BOZ+5Q/fPJ0djJ3i8PvS8/cEMBigMOOsU40U=;
        b=SiMLdb+BsHoAIse3ZuH0AyRY2aLkDN1vgOj171QqZg7dCpw6DAuB+Z2VbRygd/W0aL
         qZ1avfi09+H2mJ2k1lqMAWmkdm2vykvphrbi2E5Ai45qxoJsTNHXwgu2B3fS6H1Mo3QA
         gbmehQPWsHHBlVcSHp+Unm5pGV/8nKXQk8XDA7lEMxMHZ+KkMhyZrHjy1a5WE6nvUa/t
         ZhObFyH0W4zlFY/OEpG4eQ+zDB2s1hSKs1LYEeWO78sWuUtgIQTrzTL69o2Er1dOujqr
         EuxdWATWbXViq/XFlBBWi157JGNCPMsZj2P4qDvkvsTBbjjxTNgY2EwUuXuVDBSFkXUQ
         f/Wg==
X-Forwarded-Encrypted: i=1; AKwUvBxXVNuhhVASvSen3xoKjlpXxkQUjmX/opPdJr/smWz0gRiYeu5Bm7TfgeCT67Heoz5YSSE=@vger.kernel.org
X-Gm-Message-State: AFuF++lJqffHvL5nlB36AVFXKHp5TXpJ3ehzrOb3i8c85nSjsKBZvSmu
	djjYgpZdBOI9blQ4ZX7Szg4oNxo+BDcIjNKg4wVwHgO7Ej2Nqs/VGURjPY60o6WWGPcRVsgle4K
	27IKuYTfpyw==
X-Gm-Gg: AYBFou3vjaNwrAZV1ZcTBtyTTo5Bd94wNDZulvoRsneknKwbRsSh7bJRItglZZcAmux
	uocPz/3ngTMmDltkCHJGczYmI7IF1Mr9MEi3A2r3ZJEhhEBK+5vPxMTcvGw+NzBuY1VX16KXEEr
	GHSZ2fB0h+DksIwTd0ergTVfy4T8TMQCfIvqWPxQlnyfcDsNBbW1MtHN9YQiSOXOqa8OEedPu+6
	hodbZaIO9DigGy5wdKn/WnCZTQrVoMZm11bwyPzZvQvW/CNBbZ0BKUOTBHzDMPWoXO3n+pU5sWp
	Qv02U4HbfTfdDMsue7ZpGB200stKQeCeyR7d/Bu2P6TWwq79XRE36mXjukix8E7ye8/esNKpBtz
	vyU/mO28OgPF31NtKZlFKqxQW401QZ4QR/MK2zXfMUmyfAvM1N+VzY5aCp5MOldw0Jw02sB6yWc
	h9ggnuUc6iFL7ufsuZ5jGnpl7+Dc4Y9sosHNLhIkHNroOaMiFHeJlJ5mTvwu5QJDF0RckultdZq
	ONoVomjXmdUckM=
X-Received: by 2002:a05:6214:3ca0:b0:912:435f:1a8b with SMTP id 6a1803df08f44-913fc8d3895mr33550386d6.22.1790044225028;
        Mon, 21 Sep 2026 19:30:25 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914024a1b21sm4504326d6.15.2026.09.21.19.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:30:24 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 22 Sep 2026 02:23:26 +0000
Subject: [PATCH v5 07/13] bpf, x86: Take a Tasks Trace reader in the
 trampoline around its call-outs
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b4-rcu-tasks-preempt-qs-v5-7-410f57770bad@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790043820; l=8237;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=EPAPVj1FhQ7/+pop5mUZQszLO5ulnMl6jVPcEL6t5Gk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKeNfl/NvsHWWZiu8ABGjBm0Ik1LIwwY7PXte5+OSYt8vF7GS12LYmo7jIhnhxlZSNoBmV+d/6B
 f4uZu/duViwk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

On HAVE_RCU_TRAMPOLINE_READERS kernels Tasks RCU keeps a BPF trampoline
image allocated only while a task using it is a Tasks Trace RCU reader
or is executing text that rcu_tasks_trampoline_text() recognises.  The
image itself is such text, but the C glue and the programs it calls are
not, and only sleepable programs take rcu_read_lock_trace() today.

Have the x86-64 JIT open-code rcu_read_lock_trace() and
rcu_read_unlock_trace() in the trampoline, as ftrace_64.S does for
ftrace_caller: one reader from just after the frame is set up to just
before the original function is called, covering __bpf_tramp_enter()
and the fentry and fmod_ret programs, and a second one from just after
the original function returns to just before the final register
restore, covering the fexit programs and __bpf_tramp_exit().  The
original function itself runs outside both, since it may run for a long
time and the image is pinned by im->pcref across it.  Trampolines that
do not call the original function get a single reader around all their
programs.  The second reader is entered before ip_after_call, so the
ip_after_call -> ip_epilogue jump that bpf_tramp_image_put() patches in
is inside it, and the fmod_ret early-exit branch lands after that point
still holding the first reader, so exactly one is held on every path.

The sequence uses r10 and r11, which are scratch at each emission point,
and references current_task and rcu_tasks_trace_srcu_struct by absolute
sign-extended address, the form the JIT already relies on for
this_cpu_off.  Sleepable programs' own rcu_read_lock_trace() simply
nests.  Nothing is emitted on other configurations.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/net/bpf_jit_comp.c | 107 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2853e87797a7..b77e29c9599d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -14,6 +14,7 @@
 #include <linux/memory.h>
 #include <linux/sort.h>
 #include <linux/execmem.h>
+#include <linux/rcupdate_trace.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
@@ -722,6 +723,91 @@ static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
 	*pprog = prog;
 }
 
+/*
+ * Open-coded rcu_read_lock_trace() / rcu_read_unlock_trace() for the
+ * trampoline, see CONFIG_HAVE_RCU_TRAMPOLINE_READERS and the equivalent
+ * macros in arch/x86/kernel/ftrace_64.S.  The image is not relocated, so
+ * current_task and rcu_tasks_trace_srcu_struct are referenced by absolute
+ * (sign-extended 32-bit) address, the form the JIT already relies on for
+ * this_cpu_off.  Uses r10 and r11, which are scratch at every emission
+ * point, and clobbers flags.
+ *
+ * lock:                                  unlock:
+ *   mov  r11, gs:[current_task]            mov  r11, gs:[current_task]
+ *   mov  r10d, [r11+nesting_off]           mov  r10d, [r11+nesting_off]
+ *   inc  dword ptr [r11+nesting_off]       sub  r10d, 1
+ *   test r10d, r10d                        jnz  2f
+ *   jnz  1f                                mov  r10, [r11+scp_off]
+ *   mov  r10, [&srcu.srcu_ctrp]            mov  dword ptr [r11+nesting_off], 0
+ *   inc  qword ptr gs:[r10+locks_off]      (smp_mb)
+ *   mov  [r11+scp_off], r10                inc  qword ptr gs:[r10+unlocks_off]
+ *   (smp_mb)                               jmp  3f
+ * 1:                                     2: mov [r11+nesting_off], r10d
+ *                                        3:
+ */
+static void emit_trace_rcu_reader(u8 **pprog, bool lock)
+{
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	const u32 nesting_off = offsetof(struct task_struct, trc_reader_nesting);
+	const u32 scp_off = offsetof(struct task_struct, trc_reader_scp);
+	const u32 locks_off = offsetof(struct srcu_ctr, srcu_locks);
+	const u32 unlocks_off = offsetof(struct srcu_ctr, srcu_unlocks);
+	const bool mb = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB);
+	u8 *prog = *pprog;
+
+	/* The plain this_cpu_inc() form of __srcu_read_lock_fast(). */
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE));
+
+	/* mov r11, gs:[abs32 current_task] */
+	EMIT2(0x65, 0x4C);
+	EMIT3(0x8B, 0x1C, 0x25);
+	EMIT((u32)(unsigned long)&current_task, 4);
+	/* mov r10d, dword ptr [r11 + nesting_off] */
+	EMIT3_off32(0x45, 0x8B, 0x93, nesting_off);
+
+	if (lock) {
+		/* inc dword ptr [r11 + nesting_off] */
+		EMIT3_off32(0x41, 0xFF, 0x83, nesting_off);
+		/* test r10d, r10d */
+		EMIT3(0x45, 0x85, 0xD2);
+		/* jnz 1f */
+		EMIT2(X86_JNE, 8 + 8 + 7 + (mb ? 6 : 0));
+		/* mov r10, qword ptr [abs32 &rcu_tasks_trace_srcu_struct.srcu_ctrp] */
+		EMIT4(0x4C, 0x8B, 0x14, 0x25);
+		EMIT((u32)(unsigned long)&rcu_tasks_trace_srcu_struct.srcu_ctrp, 4);
+		/* inc qword ptr gs:[r10 + locks_off] */
+		EMIT4_off32(0x65, 0x49, 0xFF, 0x82, locks_off);
+		/* mov qword ptr [r11 + scp_off], r10 */
+		EMIT3_off32(0x4D, 0x89, 0x93, scp_off);
+		/* smp_mb(): lock add dword ptr [rsp - 4], 0 */
+		if (mb)
+			EMIT2_off32(0xF0, 0x83, 0x00FC2444);
+		/* 1: */
+	} else {
+		/* sub r10d, 1 */
+		EMIT4(0x41, 0x83, 0xEA, 0x01);
+		/* jnz 2f */
+		EMIT2(X86_JNE, 7 + 11 + (mb ? 6 : 0) + 8 + 2);
+		/* mov r10, qword ptr [r11 + scp_off] */
+		EMIT3_off32(0x4D, 0x8B, 0x93, scp_off);
+		/* mov dword ptr [r11 + nesting_off], 0 */
+		EMIT3_off32(0x41, 0xC7, 0x83, nesting_off);
+		EMIT(0, 4);
+		if (mb)
+			EMIT2_off32(0xF0, 0x83, 0x00FC2444);
+		/* inc qword ptr gs:[r10 + unlocks_off] */
+		EMIT4_off32(0x65, 0x49, 0xFF, 0x82, unlocks_off);
+		/* jmp 3f */
+		EMIT2(0xEB, 7);
+		/* 2: mov dword ptr [r11 + nesting_off], r10d */
+		EMIT3_off32(0x45, 0x89, 0x93, nesting_off);
+		/* 3: */
+	}
+
+	*pprog = prog;
+#endif
+}
+
 static void emit_return(u8 **pprog, u8 *ip)
 {
 	u8 *prog = *pprog;
@@ -3610,6 +3696,16 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
+	/*
+	 * Tasks RCU keeps this image alive only while we are a Tasks Trace
+	 * reader; the instructions before this point (and after the final
+	 * unlock) are covered by the irq-exit IP check.  One reader spans
+	 * __bpf_tramp_enter() and the fentry/fmod_ret progs, a second one
+	 * the fexit progs and __bpf_tramp_exit(); the original function runs
+	 * outside both, with the image pinned by im->pcref instead.
+	 */
+	emit_trace_rcu_reader(&prog, true);
+
 	func_meta = nr_regs;
 	/* Store number of argument registers of the traced function */
 	emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);
@@ -3660,6 +3756,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		emit_trace_rcu_reader(&prog, false);
 		restore_regs(m, &prog, regs_off);
 		save_args(m, &prog, arg_stack_off, true, flags, 0);
 
@@ -3682,6 +3779,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 		/* remember return value in a stack for bpf prog to access */
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+		/*
+		 * Second reader.  Taken before ip_after_call so that the
+		 * ip_after_call -> ip_epilogue jump patched in at teardown is
+		 * inside it too; the fmod_ret early exit jumps past this still
+		 * holding the first reader, so either way exactly one is held.
+		 */
+		emit_trace_rcu_reader(&prog, true);
 		im->ip_after_call = image + (prog - (u8 *)rw_image);
 		emit_nops(&prog, X86_PATCH_SIZE);
 	}
@@ -3737,6 +3841,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
 	}
 
+	/* Remaining instructions are covered by the irq-exit IP check. */
+	emit_trace_rcu_reader(&prog, false);
+
 	/* restore return value of orig_call or fentry prog back into RAX */
 	if (save_ret)
 		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);

-- 
2.55.0

