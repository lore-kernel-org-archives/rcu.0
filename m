Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46187365A0F
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135819; cv=none; b=QZxd3cbh3tC4lKbAIRLngNymyeGCZgCOtP+DuCQ5QDbehlZn86MWRkKjFB/aUGJwRFAHKC9bnSFo7JJpDd/J61F6UKvwu2Rkp9u37G0tGx6nda9ifypurDR0M63oPFIkCKWQkya6or839gZg7yCO67eRKJOOMgwpPTki3rx+g4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135819; c=relaxed/simple;
	bh=MVjrbMDjnAqQ8aHx7Jc4sWMH68fI2crdoTABU++vCCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNEekXsZtplamDKMUA8qLwk6+EkP4i5zJ0n+uDCEVpDm31I7Ns0JHD18Q09W7J5unnn3CPOxbtK4MW1pYeG9lkLoSgMbeBSVIxR0oVNSBGSGPOoWt1td+TmyN9UJxdzgFrTBaTuLhGtA+ZaRUsiIhAKzIuaxZlRdfDsVjzoVySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=V/jf2qeX; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="V/jf2qeX"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadeb4so113723285a.1
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135816; x=1789740616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9b8kkjvSg0tb+ScPvKP3GAz1Pld5wxO+feqfkbC4jq4=;
        b=V/jf2qeXIvFHzb3i8uU2lXQ1gE+0HHweIvmhB2+6xvaItDBfYbudP6XTknXoUcoRpM
         JI2aM1Rb8d1vZph0Gjd1qTZRXB/t2SnAHqC0cL/3vcKY3yV7JgoElEOsFeJjz5tCP0zw
         ZR5fM5xZS9xpYPuykSOFqN4fB6PE145qsn5PXNJF+MwFexRSUvIMmBBAopiKW5l8MYOw
         1M2tzbSxQRpTD7z12U2XZxb0+EYoKwQML47Chmwx3wGnQkf6DaQOtIC9QDK0Xe9+q4Kb
         toncWkdvtv8n0BRoOYFauRuD473UYE2ErkXYDwRZ0oAs+/TL5Xt3kuOXG5/ZWl623IJY
         4N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135816; x=1789740616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9b8kkjvSg0tb+ScPvKP3GAz1Pld5wxO+feqfkbC4jq4=;
        b=crpLD72SATUh1EBGq3XTLbaw2vY97QI/NBp6zoTR61GWcNNoM3JWMuD8ThFzGeweM8
         98zbbpfgQUVWl4Y8OIfVmXr6/Ee0rN1AtShSXqIb8/RMMjfNq+c6oiu/UVWOhXujiOQ7
         OdMgiu/taAe6bsh7+k6x2krPF9ZNg4MhpLFXACQo4c1FAgU/Dm0pvXCxOg/Y5RXDoXiF
         vZ2WGDqzMXPNgglC92ZztPXVDW+ZsZab3meFPkLvSBzdqYGM7zP4aTBVljDtcFiJsDMW
         TS/vtoGCwpPtN8QJog0ziRaPJX8s6MSn8GDqnqG7mJw0LeXtxszkqP1+gJ3uHheQiMj9
         7QLg==
X-Forwarded-Encrypted: i=1; AKwUvByV7XsqMpCbQiavBli3OFwRbjcnto3+mFSXyM8tXXIQE2zL6xDiZJBREyinEBnewparm4Q=@vger.kernel.org
X-Gm-Message-State: AFuF++k+3QD08149NSKVVadxyy3uaOCC7ZC0ejjcYKEmdal+QX1hmy51
	qA4HIipW64GCxh9OT5m7S+mRzGzrp7i2jwMcExmOq/e9raO17ltbpZwCWiPPP1jrQSs=
X-Gm-Gg: AYBFou1/yAhCkGY/3SU8hX0aCWHxtV+/JmlFOTLx+3Lq1fRZ2yPPcjV/B8Xo2TU109L
	R/rjmm0IMtLXSR8RPbonZBrm3Tg0DtcApyGRtQ7pWNj0AveOBMgJJ+9lxtxMem6bENm0Fq3bH6d
	oC6OEPq0PuEoR3vUHLzyVnoYDMV36mraIA0wxWb+XqEVBiR8wFDakY2mppKrCpdupoOOMBLLyCT
	CQFOYxjKAAI51YFhHy+8ZEX9RHKLnVe2tEs4YmhQl7vtGR3xVSrBbG99ZB5AxcMczcHJJVEy8gd
	4ZQq5hwOCu+Lmo+aaK1O5vTHraIFE0+cKF5YuI98/JWtZgvZPgvVe3PHVO+jsJhyzw5tDHWNh3z
	Z69vknw9jEA6Nh4+RE5vR7pXtqKFpfzeCUzz679D8Rj0DqkH35aHVIrcM2CEP10NM7tnXsFVbam
	Bh7ygCxEL1Nrb65cuZ3VBLgPITWP4/5/7g2ZT0VKPOB6rc0wNf8dHqRXZpJ5hGs0AoQBr8AVn//
	PxX3zwukq0l2Z1cZryOOlCZPahVckhgdIvfz8j5sVodEkf8DR9OL1Vd
X-Received: by 2002:a05:620a:4103:b0:939:7f14:ebc6 with SMTP id af79cd13be357-939ea036d6cmr589566285a.3.1789135815998;
        Fri, 11 Sep 2026 07:10:15 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80bc225sm248184485a.36.2026.09.11.07.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:10:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:48 +0000
Subject: [PATCH RFC v2 10/15] bpf, arm64: Maintain Tasks RCU trampoline
 nesting in the BPF trampoline
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-10-eaaa61ed2da4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135736; l=4364;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=MVjrbMDjnAqQ8aHx7Jc4sWMH68fI2crdoTABU++vCCI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLeRHDw//rEtUsP8CEBuDuvfZIDhzXHIZMrHDgrgPTpnzRVCinhLEvplAgnBDiwNcYGB3QeJu+7
 QOU1v97vhHA4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Same scheme as x86: emit "mrs x10, sp_el0; ldr/add|sub/str w11" to bump
current->rcu_tramp_nesting after the callee-saved registers are stored
and to drop it before they are restored, and release it around the call
to the original function, which im->pcref protects and which must not
pin a Tasks RCU grace period.  x10/x11 are scratch at every emission
point; the fmod_ret cbnz target lies after the decrement/increment pair
around the original call, and the ip_after_call nop follows the
re-increment, so the count is balanced on every path.  BUILD_BUG_ON
guards the LDR/STR immediate range for the task_struct offset.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/arm64/net/bpf_jit_comp.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c18e005a41db..5c9a7bde5cc9 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2591,6 +2591,34 @@ static void emit_arena_arg_conv(struct jit_ctx *ctx, u8 dst, u8 src, bool nullab
 	emit(A64_SUB(0, dst, src, base_lo), ctx);
 }
 
+/*
+ * Tasks RCU trampoline nesting, see rcu_tasks_trampoline_enter().
+ *
+ *   mrs  x10, sp_el0
+ *   ldr  w11, [x10, #offsetof(struct task_struct, rcu_tramp_nesting)]
+ *   add/sub w11, w11, #1
+ *   str  w11, [x10, #...]
+ *
+ * x10/x11 are scratch in the trampoline at every point this is emitted.
+ */
+static void emit_rcu_tasks_tramp_nesting(struct jit_ctx *ctx, bool enter)
+{
+#ifdef CONFIG_TASKS_RCU
+	const int off = offsetof(struct task_struct, rcu_tramp_nesting);
+	const u8 tsk = A64_R(10), cnt = A64_R(11);
+
+	BUILD_BUG_ON(off & 3 || off >= SZ_16K);	/* LDR/STR (imm12, scaled) */
+
+	emit(A64_MRS_SP_EL0(tsk), ctx);
+	emit(A64_LDR32I(cnt, tsk, off), ctx);
+	if (enter)
+		emit(A64_ADD_I(0, cnt, cnt, 1), ctx);
+	else
+		emit(A64_SUB_I(0, cnt, cnt, 1), ctx);
+	emit(A64_STR32I(cnt, tsk, off), ctx);
+#endif
+}
+
 static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
 		      const struct btf_func_model *m, const struct arg_aux *a,
 		      bool for_call_origin, bool is_struct_ops, u64 arena_base)
@@ -2854,6 +2882,13 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
 	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
 
+	/*
+	 * From here until the matching decrement in the epilogue, a preemption
+	 * of this task is not a Tasks RCU quiescent state.  The instructions
+	 * above this point are covered by the irq-exit IP check.
+	 */
+	emit_rcu_tasks_tramp_nesting(ctx, true);
+
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* for the first pass, assume the worst case */
 		if (!ctx->image)
@@ -2898,12 +2933,20 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* the original func takes kernel addresses, never converted ones */
 		save_args(ctx, bargs_off, oargs_off, m, a, true, is_struct_ops, 0);
+		/*
+		 * The original function may run for a long time without
+		 * sleeping; do not let it pin a Tasks RCU grace period.  The
+		 * trampoline frame above it is held by im->pcref
+		 * (__bpf_tramp_enter()), not by Tasks RCU, across the call.
+		 */
+		emit_rcu_tasks_tramp_nesting(ctx, false);
 		/* call original func */
 		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
 		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
 		emit(A64_RET(A64_R(10)), ctx);
 		/* store return value */
 		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
+		emit_rcu_tasks_tramp_nesting(ctx, true);
 		/* reserve a nop for bpf_tramp_image_put */
 		im->ip_after_call = ctx->ro_image + ctx->idx;
 		emit(A64_NOP, ctx);
@@ -2945,6 +2988,9 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_args(ctx, bargs_off, a->regs_for_args);
 
+	/* Remaining instructions are covered by the irq-exit IP check. */
+	emit_rcu_tasks_tramp_nesting(ctx, false);
+
 	/* restore callee saved register x19 and x20 */
 	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
 	emit(A64_LDR64I(A64_R(20), A64_SP, regs_off + 8), ctx);

-- 
2.55.0

