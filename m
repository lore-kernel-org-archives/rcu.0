Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7C489871
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066289; cv=none; b=cIu+FBqK53kjuIv7B9/+qM2x/sj4iyr6bTrMNSl9HJTWPmQiyxWUixp++QZzXRG5NZmThkP37zIbtvCrRBQhd1dtzXNJjHYYt+0jl3b+eCazOye3KG3iS8OCX7yBRn/Elxxlzbpi6DNpDoVsxhBkNgitiS3ASBTU9opADFqPbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066289; c=relaxed/simple;
	bh=8cFDFeD2IXPN8Vlj1EymtW9Bi32PSZwsbXS468MRSTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n3dcGSiVPe4Ql2Vk09fw9rc3lY3C4NkEJwQvzf8WOsTbDnNibeZnkWDD1ASK9xHrV9MtV3fz94Rz//Ydd0Wlps+0JBgy8QA2BdGRbxLo2rCCXI9Gk4p1k/G8roID7FbgmMT/opmn7d5IQZ1eNsSVmAVyQB7gTNvDpjW2YPTknkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=KlOv1PKW; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="KlOv1PKW"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5306baf6b53so1611101cf.1
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066270; x=1789671070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbVlQmHCpb9zv+5BDFsE+SK081jwlXFhk4tZhnaWY5k=;
        b=KlOv1PKWx60TlqVMZSv8dWVjMDQUiRAE8Z2tHJcOR3nw4O8MzhPHzKjSrlmUOX5JXu
         okpNE9DNfiNJWMttOHV8eTGoxKJfdQcG0jqzxYC3hRTNlHoECLjhwikuXLHWy5MHzD3+
         cdQ0Gfw67t1Tx31YHrcQZOQTg54EYpys4e2QdgdwCEydMklmPqLpnWUtzsbZVvMHpgbi
         Eqc7yuC2w25hccLexA5xygFZjzzwLhYO/ecLeBpVKq1vQvcS0DKz+fMangi98LgciNnn
         hjpy+fW6LBIa0YYXyt1MbRKQ5qU626L5CvsOdzMRf90syl4RiBVnfQHhPWp/UpiSncVR
         PbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066270; x=1789671070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hbVlQmHCpb9zv+5BDFsE+SK081jwlXFhk4tZhnaWY5k=;
        b=cUsRi8/ZhDiXX3eyz2nQJll0atha6UiLwOILslYPfadx9XJ1g6przN3S/tabi04sEI
         moUCTzRLUbptC6tE9KhE7TiDLaIYH9qCVoV3CeH2jD29oNU+o+2OMhxI5obwBZLkl+t8
         TEyxaffqVB1Pnfi8o3ioPINW2i3jXCCTg13mWZAtxaYf9v7Z/HPxYImObJnrozMqm2nn
         aRjAyhrvrKCw+E0s0xalug8CX99OqWXCQqUQrbTfhxB5Jr+C9cQMjc0m+z7g6jCHKpM2
         FZcp6LKATo6nU1aubjxjZPGCOdeuzWrOyXUKqZcnHecJ+GOC4F6f7ejafwnA4rj9DEQC
         tk8g==
X-Forwarded-Encrypted: i=1; AKwUvBzi2ai42IdOtKWvCHqIrFwECEIszmwsn3J+oUGMno4fIJ9jhQMPI2M//CE0m7nYIRGg2f8=@vger.kernel.org
X-Gm-Message-State: AFuF++kyPoYaDBUBpFUGL52sbBABENgaLb7tXC6dsPMsOI+fgzu5d3+Q
	G0xaSz3XQAIX4A06slkuUc6zYOY8d9GGgugLJURxgHs62FRdZdqVhITRNCP1rLyrT94=
X-Gm-Gg: AYBFou2aB3F6RrOi4VhIp/KODZuZHE0u9oHkiS5OcKaZTPgZp0MsMlK89MC44gEAz8m
	03zvP83uo8+fxQ+q6fNAOXIxKZUHEgwAXpLfdmDjzFb8K8NSDCNvHB7L4e1cYsb7jWFZLYmF8sN
	AbEQUfLIEcSmMbknE+d34gtSfUD2ULmn6JoCrKTHAteD0nVAdAVx8uVHKqgwhFBBGaTRY0MySys
	rOtBZWJunmNUAH9BlGMoy2W6VTB5zf3izKTjEmw/HqwnB0irptdZgAgKeeUDuw5Zou3l7yDSx8V
	WDg50udkytYo8m26qHAhs7rPFtDy1it5pgifd9ObfIolh+uW0hIZfLj5sjQ+793aNmwz0fzYL3I
	CmrqPRK+xJwezGWKtti1YHrltPdn7T/HJEWvFX+eK+xIzKPpFVtJecVUT4Py67Ka3md1tTJ0x5T
	Esghbyyq1AuRlIJ1b79jVH0q0/b5EvYXnqphRt+tnFr6GKN3hWRMNpRyPBB7CxXyeflaTRmO1gH
	nTGBrbvFi/zxSHomnYfW15tUNfdwRoD6Drd2QYHHrl1nL9tJTqZ8In6
X-Received: by 2002:a05:622a:1309:b0:530:42e4:effc with SMTP id d75a77b69052e-530c87566f0mr10949261cf.41.1789066264886;
        Thu, 10 Sep 2026 11:51:04 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca47efa2sm216291cf.11.2026.09.10.11.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:51:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 10 Sep 2026 18:50:30 +0000
Subject: [PATCH RFC 07/13] x86/kprobes: Maintain Tasks RCU trampoline
 nesting in the optprobe template
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-7-d4469f4cc101@toxicpanda.com>
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

The jump-optimized kprobe template calls optimized_callback() with
preemption still enabled for its first few instructions, so bracket the
call with an increment/decrement of current->rcu_tramp_nesting.  The
template lives in .rodata and is memcpy()d into each optinsn slot without
relocation processing, so the per-CPU reference to current_task must be
an absolute %gs: address (R_X86_64_32S, relocated for KASLR like any
other) rather than %rip-relative.  %rax has already been saved by
SAVE_REGS_STRING and is dead after the call.

The slot itself is dynamically allocated text, so the instructions before
the increment and after the decrement are covered by the irq-exit IP
check.  64-bit only; 32-bit x86 does not take part.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/kernel/kprobes/opt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 3f8fea52619f..f722520bb989 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -31,6 +31,7 @@
 #include <asm/set_memory.h>
 #include <asm/sections.h>
 #include <asm/nospec-branch.h>
+#include <asm/asm-offsets.h>
 
 #include "common.h"
 
@@ -101,6 +102,23 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 	*(unsigned long *)addr = val;
 }
 
+/*
+ * Tasks RCU trampoline nesting, see rcu_tasks_trampoline_enter().  The
+ * template is memcpy()d into the slot without relocation processing, so the
+ * per-CPU reference must be absolute, not %rip-relative.
+ */
+#if defined(CONFIG_TASKS_RCU) && defined(CONFIG_X86_64)
+#define OPTPROBE_RCU_TASKS_ENTER					\
+			"	movq %gs:current_task, %rax\n"		\
+			"	incl " __stringify(TASK_rcu_tramp_nesting) "(%rax)\n"
+#define OPTPROBE_RCU_TASKS_EXIT					\
+			"	movq %gs:current_task, %rax\n"		\
+			"	decl " __stringify(TASK_rcu_tramp_nesting) "(%rax)\n"
+#else
+#define OPTPROBE_RCU_TASKS_ENTER
+#define OPTPROBE_RCU_TASKS_EXIT
+#endif
+
 asm (
 			".pushsection .rodata\n"
 			".global optprobe_template_entry\n"
@@ -114,6 +132,7 @@ asm (
 			"optprobe_template_clac:\n"
 			ASM_NOP3
 			SAVE_REGS_STRING
+			OPTPROBE_RCU_TASKS_ENTER
 			"	movq %rsp, %rsi\n"
 			".global optprobe_template_val\n"
 			"optprobe_template_val:\n"
@@ -122,6 +141,7 @@ asm (
 			".global optprobe_template_call\n"
 			"optprobe_template_call:\n"
 			ASM_NOP5
+			OPTPROBE_RCU_TASKS_EXIT
 			/* Copy 'regs->flags' into 'regs->ss'. */
 			"	movq 18*8(%rsp), %rdx\n"
 			"	movq %rdx, 20*8(%rsp)\n"

-- 
2.55.0

