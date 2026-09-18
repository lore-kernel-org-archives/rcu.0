Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91F14E780B
	for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743006; cv=none; b=ZFw84mnMsCGYfXyP+EXz0eeN232phn9NSsXb7t6IeLrDIa2q66Iwg3x2RXNhV8Cjr4F7mvVYWJ7f4p8ipv8TbWvcupCYnvMiLPKfbjkLusVTBxND71onVHDsZsE+2QJXL6aO+gFfJVfZwTTLrlA5PwtFBlUoGK3ub0NOfHLQ5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743006; c=relaxed/simple;
	bh=JGl/QtTBddM7nyy/qfbMR7PzifAXs0WCS5aHiUuitqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bRlexdnWXdZK7ZM2NE9A8kFAW5VDES39OyZ/EgEpxnzdKvyzM+xvqIKGBU1jFhWJgKQ+qZ7H+DEEOTImOaBviGaUKw4zzvaZ9jAjsBiTk2uUnQlfAqJMotDHEyb4zbmpiw5XmlXMOBD1MeEGsv14+sgVwRuvP7Qoc3r7MWlB5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=aoXnmoLB; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="aoXnmoLB"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5306abbdccbso9058031cf.1
        for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789742997; x=1790347797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tx2UYwtxbz9ZqVNvSp5mlXDS3jyz+Ej3sfBe8tuEQZo=;
        b=aoXnmoLBCWcHlcLHBDXw0sTh7OrPW6c4NDfCGR0aVzQWqKHg6tr0UlNBbwhCWqq4GV
         CgSoOKxX2bNbFrXXUnbQ3Y2mR35hLEz9GkGfAdJDSBaSHbV31IO2cn2WBPquHo+ryCai
         7CVfvxWuJIlCTiYTJuMN9hmaEPJf6fHcrzwFaPBKy1Hk+UWBmA9X3QptjZIfsg1LUk2w
         3zr2VL6XMmfEtOmu21puuyEJ5pmLSOThqJlfnGPuZJJ9XLq0mel1cVkYO+7ke3blrsUg
         K29Po0IrucGy1jK2S97qzNmGRcMwj7oxbY9bCFlWe0aSU7GTzyxGV8nr1xrjpewl9m4e
         rHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742997; x=1790347797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tx2UYwtxbz9ZqVNvSp5mlXDS3jyz+Ej3sfBe8tuEQZo=;
        b=DWr71I2TLXOKb6z9odTbX8jHKFkLeqdP9KRsAfnVDzhfFISaNHtURaEgDaCMLX5uVQ
         xeyNHRS0pMgOyb0DefrWt4395pcbTYbEKJIHoImfwEuUDgYyFd0mfmavka4CGD73zSHn
         aW7LVPl1ITPnTMulFV73MnGYZNggOB/wqz3Op2rxE9BKHX7aFRwaCQjWJ1YzhwvCLMGp
         WHQAvBgcVH9ZylA6bJB60TVubMBeofK26EHiClcnF0ZXb+XyPL/AloXvNDgHUMMJcsBE
         hwlbzYzt80mxwyZgUXkjCnJngcWqvihJR1Y9vvS0UzoVY43Gu9oprHcwdGiN2XpeexHW
         +p8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzcygkVDY8yCWBhTwzYw3HDD5nENekrL+UTB1Ee2epTT4c8IhDzKy0CstkPJTT9m2sGJCE=@vger.kernel.org
X-Gm-Message-State: AFuF++mUcfrm/6Cx5GfiwAGOUq6FfbxYtwFXfWLN8n0Ky7YZwCYxHQzE
	f/BIhae0NLeQsCyYVlFUBRbPH5H6+D2r/wKCIM5YwVTw9HJ7cJ0BpPAwAkVFLoFsPYE=
X-Gm-Gg: AYBFou0BQq0kIDmcROxE18W6CDDmQjRzBEiWG6zylOnXvS+pVbEllxY9Tprx0bt+A/q
	R6AGNwH/tqo6TpKRLBSmnDQGsH//ZvZF4sgPaQnYMU2NVgygjOuJbM7ytlUkUF9XC6/9vNoaXoj
	4pt+TsNs4lnhWdXTCny1vEZZeEK2z+FVuQ7QEEpZzKRxCb+e/mdozv6mDx07S/yvenQzgO0Ln+b
	gluClSx5fX4WSjK2p36nCUCJ+KUpJA+Cck9A3IByQ9utw3yL4tIs6t4XFcGSOug2DTVsvW0QGc7
	6Uygg5jPKSgQzV1oCXc0w+aUdyIk/UehYiOBfNVjaou1fok+D6OpoHY+dx9dwrGz3aZ9favoiVa
	Z/4Ezu5/yXLMgPGtlmbXhyqPtxSYHLjQEBCpHbscgFUxP8T+UieUCna06yLfAuiuS7m2dkA0aOV
	/IziD5cGLx+JJ06uHJk+Ed5vj/26zrHQgNBarP39VhI9Hx/vZ9rgOrZxP/4QWXrzcEFNmtqDZtw
	ke1AWCz5nZ7/ADQlXyWiyXEh8+WakLV4TTqoGEUqMYME9WDE1H8fEoo
X-Received: by 2002:ac8:5f4f:0:b0:531:e51:12f9 with SMTP id d75a77b69052e-5328cfc0a9fmr106591791cf.24.1789742997160;
        Fri, 18 Sep 2026 07:49:57 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ac48df0fsm2560241cf.6.2026.09.18.07.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:49:56 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:26 +0000
Subject: [PATCH RFC v4 07/13] bpf, x86: Take a Tasks Trace reader in the
 trampoline around its call-outs
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-7-63f0e9d69661@toxicpanda.com>
References: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
In-Reply-To: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742980; l=8086;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=JGl/QtTBddM7nyy/qfbMR7PzifAXs0WCS5aHiUuitqA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIEBfe7NVaGlqFqLQwZKbFw8BpHmlfuvIjJBnOTYn9qtDCjTJL+2uxQrDvhCu7CSaCn6ZdAis0V
 Bpsr/bJffvAk=
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
 arch/x86/net/bpf_jit_comp.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2853e87797a7..c991f7ceacdf 100644
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
@@ -722,6 +723,97 @@ static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
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
+ *   mov  r10d, [r11+nesting]               mov  r10d, [r11+nesting]
+ *   inc  dword ptr [r11+nesting]           sub  r10d, 1
+ *   test r10d, r10d                        jnz  2f
+ *   jnz  1f                                mov  r10, [r11+scp]
+ *   mov  r10, [&srcu.srcu_ctrp]            mov  dword ptr [r11+nesting], 0
+ *   inc  qword ptr gs:[r10+locks]          (smp_mb)
+ *   mov  [r11+scp], r10                    inc  qword ptr gs:[r10+unlocks]
+ *   (smp_mb)                               jmp  3f
+ * 1:                                     2: mov [r11+nesting], r10d
+ *                                        3:
+ */
+static void emit_trace_rcu_reader(u8 **pprog, bool lock)
+{
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	const u32 nesting = offsetof(struct task_struct, trc_reader_nesting);
+	const u32 scp = offsetof(struct task_struct, trc_reader_scp);
+	const bool mb = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB);
+	u8 *prog = *pprog;
+
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE));
+	BUILD_BUG_ON(offsetof(struct srcu_ctr, srcu_locks) != 0);
+	BUILD_BUG_ON(offsetof(struct srcu_ctr, srcu_unlocks) != 8);
+
+	/* mov r11, gs:[abs32 current_task] */
+	EMIT2(0x65, 0x4C);
+	EMIT3(0x8B, 0x1C, 0x25);
+	EMIT((u32)(unsigned long)&current_task, 4);
+	/* mov r10d, dword ptr [r11 + nesting] */
+	EMIT3(0x45, 0x8B, 0x93);
+	EMIT(nesting, 4);
+
+	if (lock) {
+		/* inc dword ptr [r11 + nesting] */
+		EMIT3(0x41, 0xFF, 0x83);
+		EMIT(nesting, 4);
+		/* test r10d, r10d */
+		EMIT3(0x45, 0x85, 0xD2);
+		/* jnz 1f */
+		EMIT2(X86_JNE, 8 + 4 + 7 + (mb ? 6 : 0));
+		/* mov r10, qword ptr [abs32 &rcu_tasks_trace_srcu_struct.srcu_ctrp] */
+		EMIT4(0x4C, 0x8B, 0x14, 0x25);
+		EMIT((u32)(unsigned long)&rcu_tasks_trace_srcu_struct.srcu_ctrp, 4);
+		/* inc qword ptr gs:[r10] */
+		EMIT4(0x65, 0x49, 0xFF, 0x02);
+		/* mov qword ptr [r11 + scp], r10 */
+		EMIT3(0x4D, 0x89, 0x93);
+		EMIT(scp, 4);
+		/* smp_mb(): lock add dword ptr [rsp - 4], 0 */
+		if (mb)
+			EMIT2_off32(0xF0, 0x83, 0x00FC2444);
+		/* 1: */
+	} else {
+		/* sub r10d, 1 */
+		EMIT4(0x41, 0x83, 0xEA, 0x01);
+		/* jnz 2f */
+		EMIT2(X86_JNE, 7 + 11 + (mb ? 6 : 0) + 5 + 2);
+		/* mov r10, qword ptr [r11 + scp] */
+		EMIT3(0x4D, 0x8B, 0x93);
+		EMIT(scp, 4);
+		/* mov dword ptr [r11 + nesting], 0 */
+		EMIT3(0x41, 0xC7, 0x83);
+		EMIT(nesting, 4);
+		EMIT(0, 4);
+		if (mb)
+			EMIT2_off32(0xF0, 0x83, 0x00FC2444);
+		/* inc qword ptr gs:[r10 + 8] */
+		EMIT4(0x65, 0x49, 0xFF, 0x42);
+		EMIT1(0x08);
+		/* jmp 3f */
+		EMIT2(0xEB, 7);
+		/* 2: mov dword ptr [r11 + nesting], r10d */
+		EMIT3(0x45, 0x89, 0x93);
+		EMIT(nesting, 4);
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
@@ -3610,6 +3702,16 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
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
@@ -3660,6 +3762,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		emit_trace_rcu_reader(&prog, false);
 		restore_regs(m, &prog, regs_off);
 		save_args(m, &prog, arg_stack_off, true, flags, 0);
 
@@ -3682,6 +3785,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
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
@@ -3737,6 +3847,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
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

