Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779F26AC5
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 02:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044190; cv=none; b=fIC1L2Jo2sZa4zjmIRrGu7tBLBnAx5i17WkL0dPCSz4cmvQ26LeL8hFJ+OSxzkQIiRykoUNgb5P/a8VV+eiZAmx9UlRtxLT1EriU0S1wePVD9wxExHCccLoqQOzUXN6zqKdKA1UVbRBdOeWAtoLGr19WUsgwa+29pa2bLpc3YH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044190; c=relaxed/simple;
	bh=cyOEpv7E+99KbsYBQF12i4qmiz/SB2W5CJ1v6BiG3CI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqVaTQP9oF4VGr3O0aPMsuwhpcB6SvXEncAuhoUgl2HGTRuyUGVeanwYs0G9S2Bi1H/5npe4Z7oHSgkmcQtyG53NVWUN+TH1r79zvQiW/3xkEHd10mTrlc0CDIAoiY13U8fUUE7sMGJMHh5dyXbqWr82i+iAnKqdrvtklC2B9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=A6Iq5M5b; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="A6Iq5M5b"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-530301ff353so48222111cf.2
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 19:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790044186; x=1790648986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9lDajmUPmaz8BTxhPEk6XaACKGtk0v9RwI05AN+Obys=;
        b=A6Iq5M5bPgVhobuemnvHhFbQG6jm+RTffV5wIx7w00uz1L4YTq8GGbBw7igz3LiCes
         wCcbvC4cyYIp5FoZR9GNMoyL1DJ/1Q+QzdVJ22UXl9EvhoOpV5An4KQ5eOT7+ejxkyIF
         vGNVKA7o4FVI0yS3caZAq8TGsIjW22efro13CXYtX42w8j0O7XqlZGCsVIrhoUcb/wb0
         d8W5c6JJLWia/fftkiI/pv30B8QXOaZIds5aYcKN7SKeGCwSmu3OELlQVW8gg1C87jOC
         b0DIPyFEmMptCu7Ty1ICn14lAGrOLUjNztbZTt0kXDF3INLgfGF6k7bhGx5XTXsSZ+pd
         a5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044186; x=1790648986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9lDajmUPmaz8BTxhPEk6XaACKGtk0v9RwI05AN+Obys=;
        b=Ej12ryoyASFFkpQV9G7/ZoZm/ETPKpNqvnbUokMfkmWvQ6+RtIuSZYD43EtwfJOSE0
         NDL05gGrpHn1I84HqJ+OZCgVjU3mcto2mQab5szFaC+CFqNb8fLvxOGwAu0Uy5tU1umX
         RfUageC0LOeUxzld6Uii/jEIUGBwMQEgQDHprAD1x8pl92+gFehTRyRA2gGbrsiH/aLu
         m7+TaNScdkSy4jkg/vxk28xtWYw1iKX4Xe4rCzxAMEPjnISIjth6WgODBI3m2KR2lX2G
         2HsMZ0FsVfqDcperds/3QKZCHeOW79sSqr5RCK0swTPEOg1St+1aG5rjMAldGD0WiP3b
         wW/g==
X-Forwarded-Encrypted: i=1; AKwUvBybjm2RAqojBkdWlfzyvoIlbdfxH5DWuLRahPHlP5k6DqY2hMBvXiN9HSB2OcfRQitlKv4=@vger.kernel.org
X-Gm-Message-State: AFuF++ki2J02Ckt5jqcoisv4vfF9VgoRwLjhqbTvFHhTYjIOR2YiuZ6X
	g9jX7N58Qv/tEflvUf6g+FSQPAdszjz41WocqZ5H+zXbTNUa+qr09xyE3H0srAt5mNs=
X-Gm-Gg: AYBFou2LzLdMMs/v5h3+rhBFXdXnjbI2ZI/e2+hsdA/o/WlixkqqquhBtz2a1jbOSNp
	4QPManvpfws779wUuwwXdrAMRHKm/4Hm47LBAzZEDs1WXfIW/7kfgPKI8kpGA9Lb7KyWLOa4idA
	yHcOJhVl8D0dw6tn/th9LbhYi/29z/xRdru71vs0cbm4Bd0Lf2ubOOrLgbVsQ2gpSTysrft2WuP
	KUiHzdMRnWeyaRhRqimHemTbAzREg7OOywlpEoySyi/PA0zWlnkEYo9nc6knnioSAFjmYUxs7KF
	8WVxmGSRvTvWihgIX7z0bP0GwG1Ch4wN9axKYNUwPhQADl5xXB+DeJOoh22lTaFMkXk8tLEsYC7
	abvfXHoA8CkmoczRe5j/W4Aat26RU42DxjeeedB+DV3CQJfcf48xQWXFZgGjILjudT2JrWCckQw
	y1ER8eKgGsCXT6lMP3CngYtYJcHiGZ8VTruJEzEyrVzrp13opSKmf3rvU0zxCMzQ2+ltQzhFVVG
	dpLdiNWdukynEY=
X-Received: by 2002:a05:622a:5a19:b0:532:b3ce:f38 with SMTP id d75a77b69052e-532dd3cc9a4mr16978661cf.4.1790044186247;
        Mon, 21 Sep 2026 19:29:46 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e192c463sm1639311cf.21.2026.09.21.19.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:29:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 22 Sep 2026 02:23:25 +0000
Subject: [PATCH v5 06/13] x86/kprobes: Take a Tasks Trace reader in the
 optprobe template
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b4-rcu-tasks-preempt-qs-v5-6-410f57770bad@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790043820; l=3977;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=cyOEpv7E+99KbsYBQF12i4qmiz/SB2W5CJ1v6BiG3CI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGWEkZzmBIn08GZX0Y8n1aYaLj9DKrBu1cjgNBvrnGmt+51rXj4Tis5qLbxNWpv8gzG2Md0fp7c
 HpXWdXp6OPQc=
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

