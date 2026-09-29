Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8170A51FCD1
	for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702027; cv=none; b=sb5TLfeiaLB52UH1l400PySX8uYC1hU+odRoINMkMqNZVi2yl6D2fFyTP99mj4Nz2UQSyXgS4ZuF65eUn0b5RoWTuB6O1q22bOIohU3cOceAanRcAFYcDnZ9bkognfZNsclTxGRGVG6DL4ZpEy9xDiTIQqMjNQ9evDS95FVk1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702027; c=relaxed/simple;
	bh=qaq7vXKrTcRs0lT22A7BxgOv3HC+TKoraaCGEC+rqIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucmik4nWmUXH8LEpvCra+zS7Yh/nvLUB9LHVCttLuuD/2MsjUZfeoRoLUboqI//yNJN67FvJjTbQdKufLXWPTqYQ353Xj2bNgTegwcxx982NcfUU3pFouspVPXkdP8n/4M6oj5HnqDd9KoHU1Kd1jUcLK7jHxb1RO1+Itf2xxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=LOWD9JvG; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="LOWD9JvG"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532c7643bc4so53824031cf.3
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790702024; x=1791306824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uYjUQGHfzhj5gynV2AmfUxbdkizsyoj3O1ANYrGlCk0=;
        b=LOWD9JvGF1Uwa6vrEpiXimOcflVmYvYYs39PF/E4eSxXSbPKL8xqV/6oksCmaASqGY
         m9nhmNlA9GFmOX7p6Hom9gxvhAGTF5BurMCu6+F8L/sOGkk0pQRERyZZifL5/YDSbVJ1
         VK/9cBPrZ8Drw/FJAqegAfqQbyP97uXKxE1briUOXcsXndyvM7Yt/rXusrl9nvWzqiAj
         5gjAuvodtULowopXTQYzQ00/i9EzpvNG5CrZzf9TQcD4ORdxkVYVvIqf7Nal1rN08eyA
         5Y1e9/aBGZe81oOZXWAo4MmXj4qGuUXjZyG4qL+7/u0+kbcB02EomDKSS7XauRn+JBP2
         MMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790702024; x=1791306824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uYjUQGHfzhj5gynV2AmfUxbdkizsyoj3O1ANYrGlCk0=;
        b=GhkACqRKZIreQk9k6e+nDkldgrH0N81aHZJoeYoP67N3JMlTskcskzDo8+Bc/NBt0y
         +h5X1TYod38a/S5Vpgju0L0MRXBpvkRtL/ymbF8uyZgtviRjAOpIuyXr2HLo62QgpYM/
         vUnWogrvQkQR19DYqA7OCoZEkSeprhUJtRxvD2R/lFekncpYJuxiz7FNLFt9JZq12a7H
         jSMuFDI3yLlmgRx5Fs95Qmls9cJS6JpimbayNHKVjPergJ4CwbsgQMJC1uC174hnsbOJ
         rVGF4f5vHVDmcGU32cX8zImJflrQRZD8apaw0XgqWYB5iLMrmSd8dNepwSGasv0uZs89
         Nj0w==
X-Forwarded-Encrypted: i=1; AKwUvBzoIBCrSLrAnVCHSUl618Ho0DF2bPvKeTw261OfgRGfj8MOxvELbXDMNpHc2afEo/xLcns=@vger.kernel.org
X-Gm-Message-State: AFuF++kALY3f6LLCOSWTf2Dha4okghSas4Mkr+acpBWh6stufHsKWz3w
	DM9YaTagfZzTIsSAM2i2lrTVolLYBag8Ms9U8jVcwLdijpT3o3w/LC7uR7inU8od+VE=
X-Gm-Gg: AYBFou17I/B7cXgIU+ntgwyURcf0Ak6BvQUN388ld+Z/vTey5/0wCYjmEAKNr7R1igx
	xjph2uZfpSfyAVUm8TKvwFJcXYq2/hQvj4pwEpoEAcWRXF7EeMwRarZ3oJx1QabZuaGUQVG/gM8
	WOeAGzINaXmklCZ6U89u6a5Gr9S+MuzRy0QjSrQwYSuMPod3tbCJh4RoQ+3D481X8ggosZOBPRE
	S9kfwoA0MegKPCiwxdIjU7NkX7TiKj6sXsv74mhg9ftxZ+Yu8uOXXJMUD32q8tYbCXG3Sht+H2t
	Aru1f8VdMsX+N2cBd4eqCdjYj8EjQhHjWsUsvVfmMHWvNudqFP7j7F5+WcTCdMFp6TMby24wv99
	kwBu7x797UTTgti73u3oAtLSebVFs1mXMBjPNNw4kkgqphIRpFItblou614X+YSMENhHCM8XexW
	toFwh65XvMe+M4ud3zGNLzBilsqfyLEtkb80KCDOZZ8wRn21QRYlyqJ6gRXk1bgnwSgEw+GVMd5
	lQnZb0D/Ru1MZQ=
X-Received: by 2002:a05:622a:4d47:b0:530:de54:ff67 with SMTP id d75a77b69052e-5330b695d1emr295247061cf.50.1790702024347;
        Tue, 29 Sep 2026 10:13:44 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53369b8b1a0sm50661cf.18.2026.09.29.10.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:13:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Sep 2026 17:07:25 +0000
Subject: [PATCH v6 08/14] bpf, x86: Take a Tasks Trace reader in the
 trampoline around its call-outs
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rcu-tasks-preempt-qs-v6-8-c111ee02caca@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790701681; l=8650;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=qaq7vXKrTcRs0lT22A7BxgOv3HC+TKoraaCGEC+rqIk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEQt37JUXrwy2GgKdB/PPXs+iZJTGjwigLz9Gr9rllLCaK7CB1KYxIOvuMI61BlHvWRzYlEymmV
 gogPoz4WzfgY=
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

Cost, measured as getppid() ns/call in a KVM guest on a Xeon 8375C with
no-op programs on __do_sys_getppid and CONFIG_TASKS_TRACE_RCU_NO_MB:
fentry 77.0 -> 77.9, fexit 78.4 -> 80.7, fentry+fexit 83.2 -> 85.6, so
about 1 ns per reader pair.  Taking the reader in __bpf_tramp_enter()/
__bpf_tramp_exit() plus before/after-orig-call C helpers instead was
measured too and is no cheaper (78.3 / 80.5 / 85.5).

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

