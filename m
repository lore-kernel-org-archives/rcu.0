Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041053FD4E
	for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701991; cv=none; b=TIFFHmNuszypbOe73Im1P+uRd7rtnQ5pAMqTgx00VD07+TyiNvwG1C80BChvuT9AaW1sOCVaK5RCBbNx0aZkBQ7FgloiSA8hH9vodoskGugJfQhSz3G157Ly6cRySBj/neSaVmb6O7VCfEFIZjz5a6A0XHPlZKUkpvoIBphbjMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701991; c=relaxed/simple;
	bh=cyOEpv7E+99KbsYBQF12i4qmiz/SB2W5CJ1v6BiG3CI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJNNhwoUlsVejlHLG8OBfYLnabZwbYBjexGXLTOeJWGFPonGdkkZ7w9pzDC8z6JyHMvTAfu6oSeDxfy2OJJUntvKe/yauq7TPWNjXggq3IsTDdDwQn8SHIcy1hrDHAk1CXHSecWXJAGlEukX4QP9vSPBxZmjpjkmaAr+vaMepDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Josx8TFN; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Josx8TFN"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c61451de5so249739785a.2
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790701988; x=1791306788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9lDajmUPmaz8BTxhPEk6XaACKGtk0v9RwI05AN+Obys=;
        b=Josx8TFNADFHn4MGndADwv8m0cNAMz5DVvpJ94i+Nn/07RzBYPGTQ37ly1+ubPl5n2
         cXwJkptnOv5b2gITlpuzZ1ej2u9aQdxRLid7H0hsRYfoVh8dt9opfNAVLEGs6DF7VsEy
         0T+jJ5DccMOXK7MLcnukwjWxpfigioOiOvfipx9hePS1cvNL0iO4SuUKiTtw1oa4y/r1
         e0RS2dW8YAl3qXEQqd1O/nR+sM31vuBrgcQB1ck8dxaQsVD6vLekTUyTxqJm+4EVh1vj
         JsZKznmZwYJufXviKf2g+UF3UsFvETp0RLINVgwDt3K7E8EU4lRtLgbL8toBhdvfjdHe
         4B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790701988; x=1791306788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9lDajmUPmaz8BTxhPEk6XaACKGtk0v9RwI05AN+Obys=;
        b=DfGKGVY765mfp1Sy4Hw0e+0GEKJdLgbEc92icdOoer6tOwuaGVgjbKutGBLr3YkjwT
         pe/Zg05/S95wssFw0om2ThXWaLnpO3Z7UsX6Mk4CNnWwr9vDaKLLT6u6WRNvy389qXo1
         2a0J6p6tuaRS1mVWaSTTIUQYddh9WlGfyaop+BMiGVVhDroBJL2gJohCXxiUc5RmWeU3
         82d6Cx/cBQKFv+wKbL/LTpOfUng8+4uBp9AHShq0aCwYHea1VtUohaY2wogNPZJCGMzg
         rNQoeDdrHETCBfOZgA6FEoiUx4/GMhbg9k95Rj91kH3uNpnwsSkwV1lFdNffkilSOYB9
         USWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwtWxd4R1tDl3RvX9DuNU5eCwSjA12Y0CPDnHorGUpDtINxQGlQyeK3p8MMIICtRe42TYc=@vger.kernel.org
X-Gm-Message-State: AFuF++kZZjpH0k28ra+Wrr30OxNaP90F3+PYjQvo1XER8gGU+4YRcbfQ
	UVSVNNlvw8wZSPGFD4bsC47GtNe/N8bX5gDskF6LssFPi7H8mHPQk3mnVRef+z2MKZQ=
X-Gm-Gg: AYBFou3Dnzf36UcRX+D+R/uUJr1WZtKqDlsrkEjHlvWcj/khAxQ+j8ydwbQRfiDsB44
	LFn3OTKNXZ1CGNd+/dwz15HFDaFjV8uI/StgOoIyfndjnFOINquwq26X34x4attDrkmyqRmjxad
	Yh+Q6sWFpJzVT6XQvSfEN9o190JfL0MdlqZDiNNw+LFxtJauZx4c2OC6GC4SAcWHumMffaKUXyT
	DQVbZn+CqlUEnvxY4jihhbjib+amnbCz7rm9pla8VD04ciL2i/QsZwhrg9L20/D2U+53vu/fzPh
	g+1iwpCFQYaI+APOZ0ab7CRdMzWr7jQnHxsJuOwnTj4KxT1G4SQpoOniOV+ImY8eFexob7iPZUE
	I1VuPVTeu0MJzQaSrqAgo0/vP3UjcvZsOZLcR3YzjuGvloYOsF4lsxSwaV6obRY5tt6VB93SDQo
	7pPzAtq9wp4YoOPX5z2stMgDDl/r/MwTsptx2wKYzkRfUpRIUchuPcVW6mJKQntKrAqXciS1Qx8
	vocaZWOPBLGCWth
X-Received: by 2002:a05:620a:4050:b0:93c:2dae:ec5c with SMTP id af79cd13be357-93c9f8db738mr36680185a.42.1790701987489;
        Tue, 29 Sep 2026 10:13:07 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f4c4e73sm16349585a.24.2026.09.29.10.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:13:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Sep 2026 17:07:24 +0000
Subject: [PATCH v6 07/14] x86/kprobes: Take a Tasks Trace reader in the
 optprobe template
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rcu-tasks-preempt-qs-v6-7-c111ee02caca@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790701681; l=3977;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=cyOEpv7E+99KbsYBQF12i4qmiz/SB2W5CJ1v6BiG3CI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDWamZGwRXHqlZDYRICgP71g719tFuAgZKe5M/0MnijoM4CsVGa3hA93Sod04FIiuoO+tFQoc5F
 zV/o3zGZ2BQo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The jump-optimized kprobe template calls optimized_callback() from a
dynamically allocated slot with preemption enabled, and only Tasks RCU
keeps that slot alive under a task preempted in the callback.  For
HAVE_RCU_TRAMPOLINE_READERS that means the template must be a Tasks
Trace reader across the call, so open-code rcu_read_lock_trace() and
rcu_read_unlock_trace() around it as ftrace_64.S does.  The template
lives in .rodata and is memcpy()d into each slot without relocation
processing, so the references to current_task and
rcu_tasks_trace_srcu_struct are absolute (R_X86_64_32S, relocated for
KASLR like any other) rather than %rip-relative.  %rax and %rcx have
already been saved by SAVE_REGS_STRING and are dead after the call.

The slot itself is dynamically allocated text, so the instructions
before the lock and after the unlock are covered by the irq-exit check.
64-bit only; 32-bit x86 does not take part.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/kernel/kprobes/opt.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 3f8fea52619f..68a5de6cdabe 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -31,6 +31,7 @@
 #include <asm/set_memory.h>
 #include <asm/sections.h>
 #include <asm/nospec-branch.h>
+#include <asm/asm-offsets.h>
 
 #include "common.h"
 
@@ -101,6 +102,47 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 	*(unsigned long *)addr = val;
 }
 
+/*
+ * Open-coded rcu_read_lock_trace() / rcu_read_unlock_trace() around the call
+ * to optimized_callback(), see CONFIG_HAVE_RCU_TRAMPOLINE_READERS and the
+ * equivalent macros in ftrace_64.S.  The template is memcpy()d into the slot
+ * without relocation processing, so memory references must be absolute
+ * rather than %rip-relative.  %rax and %rcx are free at both points.
+ */
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+#ifndef CONFIG_TASKS_TRACE_RCU_NO_MB
+#define OPTPROBE_TRACE_RCU_MB	"	lock addl $0, -4(%rsp)\n"
+#else
+#define OPTPROBE_TRACE_RCU_MB
+#endif
+#define OPTPROBE_TRACE_RCU_READ_LOCK						\
+		"	movq %gs:current_task, %rcx\n"				\
+		"	movl " __stringify(TASK_trc_reader_nesting) "(%rcx), %eax\n"	\
+		"	incl " __stringify(TASK_trc_reader_nesting) "(%rcx)\n"	\
+		"	testl %eax, %eax\n"						\
+		"	jnz 1f\n"							\
+		"	movq rcu_tasks_trace_srcu_struct+" __stringify(SRCU_srcu_ctrp) ", %rax\n" \
+		"	incq %gs:" __stringify(SRCU_CTR_srcu_locks) "(%rax)\n"		\
+		"	movq %rax, " __stringify(TASK_trc_reader_scp) "(%rcx)\n"	\
+		OPTPROBE_TRACE_RCU_MB						\
+		"1:\n"
+#define OPTPROBE_TRACE_RCU_READ_UNLOCK						\
+		"	movq %gs:current_task, %rcx\n"				\
+		"	movl " __stringify(TASK_trc_reader_nesting) "(%rcx), %eax\n"	\
+		"	subl $1, %eax\n"						\
+		"	jnz 2f\n"							\
+		"	movq " __stringify(TASK_trc_reader_scp) "(%rcx), %rax\n"	\
+		"	movl $0, " __stringify(TASK_trc_reader_nesting) "(%rcx)\n"	\
+		OPTPROBE_TRACE_RCU_MB						\
+		"	incq %gs:" __stringify(SRCU_CTR_srcu_unlocks) "(%rax)\n"	\
+		"	jmp 3f\n"							\
+		"2:	movl %eax, " __stringify(TASK_trc_reader_nesting) "(%rcx)\n"	\
+		"3:\n"
+#else
+#define OPTPROBE_TRACE_RCU_READ_LOCK
+#define OPTPROBE_TRACE_RCU_READ_UNLOCK
+#endif
+
 asm (
 			".pushsection .rodata\n"
 			".global optprobe_template_entry\n"
@@ -114,6 +156,7 @@ asm (
 			"optprobe_template_clac:\n"
 			ASM_NOP3
 			SAVE_REGS_STRING
+			OPTPROBE_TRACE_RCU_READ_LOCK
 			"	movq %rsp, %rsi\n"
 			".global optprobe_template_val\n"
 			"optprobe_template_val:\n"
@@ -122,6 +165,7 @@ asm (
 			".global optprobe_template_call\n"
 			"optprobe_template_call:\n"
 			ASM_NOP5
+			OPTPROBE_TRACE_RCU_READ_UNLOCK
 			/* Copy 'regs->flags' into 'regs->ss'. */
 			"	movq 18*8(%rsp), %rdx\n"
 			"	movq %rdx, 20*8(%rsp)\n"

-- 
2.55.0

