Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD7541E59
	for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702111; cv=none; b=krB79g/997N6fr1XPicx5sAxQJbqSu5YejTLsm5pzkdaswiK9rzV1EflzXWjt8zaA/TSaEkQT+TtTZrI6oXYqnqu/Pe6ksKyntS6HjJSISIqU11vPMs7UopV6npzVPDKQe7xHa81wdBIVZ7sGou92BXAmCJyinlFYpBsDwtXkEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702111; c=relaxed/simple;
	bh=blNA9uuKvFl0Dl7FuRbhSFWaFNBJucpF0csBYMxnOwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hr6WgzJHn+hYNGQHAYjTu8aOZRWdzpeZu4ZWAH7GPnQu5YVZ2KygW3Tg1FzOldutQrJsuhGrXqAWOvDuK9ZdY11hN5e/FZPw8X3Imp6kHGqak0PZu68DVbFdaQv0QMGrG/BZ9ll/nbexZ7FDSlTJR0R60RT7TtZRhMR3Mt2VEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=rCmpcsLL; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="rCmpcsLL"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-53321c5743fso2658141cf.1
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790702108; x=1791306908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fkuFsLVIPwXfJidJpiKp96cBp3Ts4TUHwQA5DmHfwZM=;
        b=rCmpcsLL0565bVwcHUAuPLev2sT3rXdMoCZ7HRUFQWINLDpc9iJKWWF7e3nVkbOBmo
         XGB9ZV3kPgknGbut99Nuv5/Uff/tJB4AijMPJTK+RjzajZO0+dFn5XOPaeCtEcBDQ1xN
         ByouJi7Fe25YeJmN0NIRpYG/+/GKoXN695nF6ArOZezCEktYLN3os2DNrG6ZkyCea4+v
         1Ee7Z7dfYeTtZg+DNNhldTVY4RiUpM+s20Sx2b3aQh6GX87nwB4SOYrUMbDkrvYnRsGr
         FYWQb9RWvl7deNZEMOPmZHYUjT2BRhKFHYZYq4W5PIJLfiMD+nXZPGUP5IOM/LoiPsU+
         CI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790702108; x=1791306908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fkuFsLVIPwXfJidJpiKp96cBp3Ts4TUHwQA5DmHfwZM=;
        b=O/7AUtzw5+x5QG6pjYkwTsdzI+a6zHuEHSTFTfiKaxzqXL2n60AlszhU98uc0TMaeq
         himLagX1bWidwhwVJ73Qft1ZYceNFAYXixCpUZbwXrB71aEdJKflcoyNYVr53SR9SS53
         5EFLD2+ulD59bfmN813EEczQowbwnqVqCQF6wfXZjMWpQBl+kd/Mav5LZJsj8asF2Gji
         KjFoEF+/XRjDjQwYLUGSol1Jjf7XRCivCxfX+AtF7Lx0H+X0OZO+WMml7kQfk3vYgGBV
         MTom6S4/t4GHAJalpkLiVvweG+PtWsmitcIWxCOf9z1jIVMZULOqsfOsp2INOtpGNs4H
         wVQA==
X-Forwarded-Encrypted: i=1; AKwUvBzHJdvOWjMhEuwqyBwxh2nwAMXO6ttKnJINtPYQh+GKdh6ZekZS1Z2G5Sr5O+GXQyldaIU=@vger.kernel.org
X-Gm-Message-State: AFuF++nLFwvNSrDt+22ZXjDXL9qMvI7Afhgb+nNe1mArSmokEeotn+2V
	8f28Bq37A5Ygkp6eDC0RpV90hV9sfegUm1xObQyttEiOqNOnTbOp+xSAU5OpVo22vrE=
X-Gm-Gg: AYBFou0dR+u78aTxPNvRlcw31Laujitd6FQEqJUvlH4m7X25/0LCyrdctwVx76v69tX
	0lob0j5Jpw31HjIf7x8u35qadcqefDu/hAU21ibPcbccz4yH3/lDCJxAUVE370f3bl5mLTUQb9w
	MlLFmdyi0k5LC2Qb5GuR9likmz090Fx8zm9naSEytLG+Nw6CNNerbpT3WTaASpoD+TeQOuMeRZa
	s3uCJ19pqDgh608dxbn0kImSKsu7dCQS7EyXJNRh2B0sdTuh3OrEX4B60hUs109qNejMMq/FDe5
	O0vdE/dtruRxHH9lL+ZeQx4hwhrIQz1oSPwGmvHUuRZ1TzHd4xNwe+HeFsD4VisKikz2VYj68Qw
	jRwXRA+yyIrFbP2yb+jycfbaOPrGgBuJQ4PXEMAPvV0N7/jbg/ZdDGYF11m2pCt9TMwuUew81OE
	w2oueHh4I2b1w0Jcf0aJdt1NXJDv+0tuBVuGXu6P6uxzB7vEOGaL6DLE2+6/m9i5JuhYS5RZQhz
	iyIFJEdvfV/bgpEkckQQNYrNw==
X-Received: by 2002:ad4:5948:0:b0:912:517b:40e7 with SMTP id 6a1803df08f44-9142f930e42mr254394946d6.46.1790702107874;
        Tue, 29 Sep 2026 10:15:07 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917987ec411sm39436d6.27.2026.09.29.10.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:15:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Sep 2026 17:07:27 +0000
Subject: [PATCH v6 10/14] bpf, arm64: Take a Tasks Trace reader in the
 trampoline around its call-outs
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rcu-tasks-preempt-qs-v6-10-c111ee02caca@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790701682; l=7777;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=blNA9uuKvFl0Dl7FuRbhSFWaFNBJucpF0csBYMxnOwE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLovRg9ILR6WHQQ+DL1aLA97uUjFbDA8n+2o8+T/kbgr+57mipMMX9+lEhXWx12OxSdwX61Ckxg
 9xK064HhI1gw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Same scheme as x86: have the arm64 BPF JIT open-code rcu_read_lock_trace()
and rcu_read_unlock_trace() in the trampoline, one reader from after the
callee-saved registers are stored to just before the original function
is called (covering __bpf_tramp_enter() and the fentry/fmod_ret programs)
and a second from just after it returns to just before those registers
are restored (covering the fexit programs and __bpf_tramp_exit()), with
the original function itself outside both and pinned by im->pcref.  The
second reader is entered before ip_after_call and the fmod_ret cbnz
lands past it still holding the first, so exactly one is held on every
path; trampolines without an original call get a single reader.

The sequence mirrors entry-ftrace.S: current via sp_el0,
trc_reader_nesting bumped, and for the outermost reader the SRCU-fast
per-CPU counter incremented LL/SC and the counter pointer stashed in
trc_reader_scp (plus the dmb when CONFIG_TASKS_TRACE_RCU_NO_MB is not
set).  x10-x15 are scratch at every emission point.  Nothing is emitted
on other configurations.

Cost, measured as getppid() ns/call in a KVM guest on Graviton4
(Neoverse-V2) with no-op programs on __do_sys_getppid and
CONFIG_TASKS_TRACE_RCU_NO_MB: fentry 101.3 -> 109.7, fexit 118.8 ->
136.2, fentry+fexit 134.1 -> 151.0, so about 8.5 ns per reader pair,
most of it the LL/SC per-CPU increment.  The C-helper placement was
measured too and is 1.5-3.5 ns slower again (111.3 / 139.3 / 154.5).

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/arm64/net/bpf_jit_comp.c | 93 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c18e005a41db..87bbcca0298f 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -14,6 +14,7 @@
 #include <linux/filter.h>
 #include <linux/memory.h>
 #include <linux/printk.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/slab.h>
 
 #include <asm/asm-extable.h>
@@ -2591,6 +2592,77 @@ static void emit_arena_arg_conv(struct jit_ctx *ctx, u8 dst, u8 src, bool nullab
 	emit(A64_SUB(0, dst, src, base_lo), ctx);
 }
 
+/*
+ * Open-coded rcu_read_lock_trace() / rcu_read_unlock_trace() for the
+ * trampoline, see CONFIG_HAVE_RCU_TRAMPOLINE_READERS and the equivalent macros
+ * in arch/arm64/kernel/entry-ftrace.S.  The SRCU-fast per-CPU increment is an
+ * LL/SC add on this CPU's counter; being migrated between reading the per-CPU
+ * offset and the store-exclusive only means another CPU's counter is
+ * incremented atomically instead, which SRCU sums over anyway.  Uses x10-x15,
+ * which are scratch at every emission point, and the flags.
+ */
+static void emit_trace_rcu_reader(struct jit_ctx *ctx, bool lock)
+{
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	const int nesting_off = offsetof(struct task_struct, trc_reader_nesting);
+	const int scp_off = offsetof(struct task_struct, trc_reader_scp);
+	const int ctr_off = lock ? offsetof(struct srcu_ctr, srcu_locks)
+			       : offsetof(struct srcu_ctr, srcu_unlocks);
+	const bool mb = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB);
+	const u8 tsk = A64_R(10), n = A64_R(11), tmp = A64_R(12);
+	const u8 ctr = A64_R(13), addr = A64_R(14), val = A64_R(15);
+
+	/* The plain this_cpu_inc() form of __srcu_read_lock_fast(). */
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE));
+	/* LDR/STR (immediate, unsigned offset) ranges */
+	BUILD_BUG_ON((nesting_off & 3) || nesting_off >= SZ_16K ||
+		     (scp_off & 7) || scp_off >= SZ_32K);
+
+	emit(A64_MRS_SP_EL0(tsk), ctx);			/* current */
+	emit(A64_LDR32I(n, tsk, nesting_off), ctx);
+	if (lock) {
+		emit(A64_ADD_I(0, tmp, n, 1), ctx);
+		emit(A64_STR32I(tmp, tsk, nesting_off), ctx);
+		/* interrupted a reader: done (branch to 1:) */
+		emit(A64_CBNZ(0, n, 13 + mb), ctx);
+		/* scp = rcu_tasks_trace_srcu_struct.srcu_ctrp; current->trc_reader_scp = scp */
+		emit_addr_mov_i64(ctr, (u64)&rcu_tasks_trace_srcu_struct.srcu_ctrp, ctx);
+		emit(A64_LDR64I(ctr, ctr, 0), ctx);
+		emit(A64_STR64I(ctr, tsk, scp_off), ctx);
+	} else {
+		emit(A64_SUB_I(0, n, n, 1), ctx);
+		/* still nested: just store the count (branch to 2:) */
+		emit(A64_CBNZ(0, n, 11 + mb), ctx);
+		/* outermost: pick up scp before an interrupt can see nesting == 0 */
+		emit(A64_LDR64I(ctr, tsk, scp_off), ctx);
+		emit(A64_STR32I(A64_ZR, tsk, nesting_off), ctx);
+		if (mb)
+			emit(A64_DMB_ISH, ctx);
+	}
+	/* this_cpu_inc(scp->srcu_locks / scp->srcu_unlocks) */
+	if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
+		emit(A64_MRS_TPIDR_EL2(addr), ctx);
+	else
+		emit(A64_MRS_TPIDR_EL1(addr), ctx);
+	emit(A64_ADD(1, addr, addr, ctr), ctx);
+	emit(A64_ADD_I(1, addr, addr, ctr_off), ctx);
+	emit(A64_LDXR(1, val, addr), ctx);
+	emit(A64_ADD_I(1, val, val, 1), ctx);
+	emit(A64_STXR(1, val, addr, tmp), ctx);
+	emit(A64_CBNZ(0, tmp, -3), ctx);
+	if (lock) {
+		if (mb)
+			emit(A64_DMB_ISH, ctx);
+		/* 1: */
+	} else {
+		emit(A64_B(2), ctx);
+		/* 2: */
+		emit(A64_STR32I(n, tsk, nesting_off), ctx);
+		/* 3: */
+	}
+#endif
+}
+
 static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
 		      const struct btf_func_model *m, const struct arg_aux *a,
 		      bool for_call_origin, bool is_struct_ops, u64 arena_base)
@@ -2854,6 +2926,16 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
 	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
 
+	/*
+	 * Tasks RCU keeps this image alive only while we are a Tasks Trace
+	 * reader; the instructions before this point (and after the final
+	 * unlock) are covered by the irq-exit IP check.  One reader spans
+	 * __bpf_tramp_enter() and the fentry/fmod_ret progs, a second one the
+	 * fexit progs and __bpf_tramp_exit(); the original function runs
+	 * outside both, with the image pinned by im->pcref instead.
+	 */
+	emit_trace_rcu_reader(ctx, true);
+
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* for the first pass, assume the worst case */
 		if (!ctx->image)
@@ -2898,12 +2980,20 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* the original func takes kernel addresses, never converted ones */
 		save_args(ctx, bargs_off, oargs_off, m, a, true, is_struct_ops, 0);
+		emit_trace_rcu_reader(ctx, false);
 		/* call original func */
 		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
 		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
 		emit(A64_RET(A64_R(10)), ctx);
 		/* store return value */
 		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
+		/*
+		 * Second reader.  Taken before ip_after_call so that the branch
+		 * to the epilogue patched in at teardown is inside it too; the
+		 * fmod_ret early exit lands past this still holding the first
+		 * reader, so either way exactly one is held.
+		 */
+		emit_trace_rcu_reader(ctx, true);
 		/* reserve a nop for bpf_tramp_image_put */
 		im->ip_after_call = ctx->ro_image + ctx->idx;
 		emit(A64_NOP, ctx);
@@ -2945,6 +3035,9 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_args(ctx, bargs_off, a->regs_for_args);
 
+	/* Remaining instructions are covered by the irq-exit IP check. */
+	emit_trace_rcu_reader(ctx, false);
+
 	/* restore callee saved register x19 and x20 */
 	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
 	emit(A64_LDR64I(A64_R(20), A64_SP, regs_off + 8), ctx);

-- 
2.55.0

