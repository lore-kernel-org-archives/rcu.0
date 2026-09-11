Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B2035B653
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135809; cv=none; b=qWojKLybhHXme3QUZXhj36K4tmFdKjrET2x9X0D/HJXmLW0y8sFLBSRAy+cQTlCjXB7CC2J/tGOt3yZDkTUkIaB7WHOWVqQ+1njoK4m4sILNhSkN+hAou3ToNDCr79FBbK5IqRSqwXzY/cvZIugJnqjHQhwg0+2Znvgfxf3ABo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135809; c=relaxed/simple;
	bh=8cFDFeD2IXPN8Vlj1EymtW9Bi32PSZwsbXS468MRSTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DBUzyeWtGIMF0q8z6+A3reymDi/pkuiiKiv8yO7nmaXyxvn4BSgCdE4SvbW4m+NrzkLRI/fbZC0wWha/0CU2k0cwGHd+T95umZSTpp+6E4rAGuwdtARbjumzhkh48txSG/0zXIVNSz+OmP/a9/pNaqKKcYrBh/GGqSb7+AmmWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=AO0u/AX8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="AO0u/AX8"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9399798ca61so108285085a.1
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135804; x=1789740604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbVlQmHCpb9zv+5BDFsE+SK081jwlXFhk4tZhnaWY5k=;
        b=AO0u/AX8T2KO9cUT21S8NZRAtESkc/8lg+v96HISVkTT7B10Mjmvm8BmfwPFrST/Ea
         eHAw7XB0udEm4icZnkQxCqHzVeES3CSJFA/jmnILW85HT4C+GozarSvEh+N3OPILfXNn
         Hb2DXQGzHE07x0W/wCsgPkopcf60quSzzFv7BjvxE9CQ29+58ttPSF+RleZKLtOAvJL5
         xDjsow38dudkVjd+2EjMtOniOpMgAJ6gvOdCW6m+1L8UD8/XeCmjM9IQNUVeoLFPBUjI
         +2qLeWf9wL+LL1De3OC7dOk9Rek4M4/hZTsrTcsUl520tXWy37O4+V/SmPQZ9SGRmGsU
         WdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135804; x=1789740604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hbVlQmHCpb9zv+5BDFsE+SK081jwlXFhk4tZhnaWY5k=;
        b=o5Qr52JHwqeIwGx5ZHUTPlT8FAKjf8BvpRTK9UNS2VZTCt/SRoMe1py5skOlZTtV1v
         SDNatYrRhZU1nZwDLKcM9df7vXmRFsWxM0RGr8Lzo0uYuJVFMfC4K/gxIrkImnCLT8LB
         fMBDwBlC7vzhtNMFLSsYJO9GxkUENeYBpgEOm4TulWrj1TpooIurriDjBInzt+cGsAsx
         5RwAxIHJvex1lgwsGCAxEO4nzPGVYORB7A2Svd+2LqFpOMTasNRLabgBlcmX4pLvdm4M
         sFDK4C1BUM/YP27f0mZe+19ODNpDpdnU4qgVHl6FFiPZ5XPbWqv416qbX1F5hxBq5X9o
         ahrQ==
X-Forwarded-Encrypted: i=1; AKwUvBymCViLHWiNL9BgHq1byHAo6CDrboOOsWmv2/A4wJOvf9dVlpTbUFrxKlWHeucu5Va9aH4=@vger.kernel.org
X-Gm-Message-State: AFuF++nkZIQtVFXF1LrhenjR2JM7NGEWu0jSaDQ1/lH9qJYHjqhdcCS8
	HSszTdL7RBJa0ZhyAuHHDKz24K9xEcsigBcpIfX0kiG2BpYZ8xWXdJafjr2VjJDTo+4=
X-Gm-Gg: AYBFou2URX5weu7FQEZo1zWtDwHNnMegg6isvwhrXkX7OKZ9O+bTUuXRhBub77EBkvU
	PQoIdUpV1jESJ9RVyP1LqBKIqqPqdgdjnzQImditedMilWSW01HTqey9oK3rGcqRAssGgiWaY3p
	qgT/XmqC74lFrMpyWhJxjUtAveaq6OMYiKc6xRNC21XRBszDNPBklKULqlf+L1HV9dcUD3Sh0Au
	WlxS9KCQz5gDDOWUwDBhd+kEeREFPLyzbdgjM7ZxrgvSZ1qYp67UmLroyAskbdyo2ZOj3qoyIuQ
	IsFL42NkczJCQzeySQldHnTHEXIuTYUjwaQmysQ7BJpSPmwIi3WWZXIu9jw+WsWEVHCG5HMwDdQ
	kZQQCr+VKfMvTqTV4Le/sZ+/2ZeRuZYURKhwyk8myHojJKUsMwLY5DYYXocsf2rtEdtuA9qfoVD
	fhS/n+ZKcpPkNDkRoXA7UMN1h+DOTZnYa6x4EOBsJAVk7cn29GcrlcmPnM6TrUQ6cIQoHiOXszS
	FNfDm7XzvyCjTtEFGY9awbh38mQ6YnUPxHWjAbsk46VM7S+qK3hXQoO
X-Received: by 2002:a05:620a:198d:b0:939:3a81:326 with SMTP id af79cd13be357-939ea18c166mr526461185a.37.1789135803738;
        Fri, 11 Sep 2026 07:10:03 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939f1dd527asm125166385a.16.2026.09.11.07.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:10:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:45 +0000
Subject: [PATCH RFC v2 07/15] x86/kprobes: Maintain Tasks RCU trampoline
 nesting in the optprobe template
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-7-eaaa61ed2da4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135736; l=2636;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8cFDFeD2IXPN8Vlj1EymtW9Bi32PSZwsbXS468MRSTs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE88Fo4D8KnMZviii3UcxtNsSOWitctfeeqTUeKrfDl5ze3tUkJnL+Us2LrW6ea29znHZAO8PVa
 SQS9QIpNv5Ao=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

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

