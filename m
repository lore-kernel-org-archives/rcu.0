Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33CD33A9E1
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135824; cv=none; b=Eky1+00nvzaQT4wiyzurNt6rcvzoQBlvxEFXYH2PFaETr5d9xWq5fblAtEVaXc/x311ixjI63z/4q4KhAY7h9Q6n3OPgHNX3LMyhMxZHekQcrd6JRW1KKbN2N5KH1XA20C4QM48wSXFlpPXweDa2ISRXrvw806y7GHF1eu13MIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135824; c=relaxed/simple;
	bh=hPcqGdFxo+b+ijS7jNB+8GMowmEDvopzKnpNmpphVrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7QcRcQVdAGsumdFuEwUQjsbHM2RlvzdLnl/4sUTqbL6br2XXglmQ+B3MIaaUO2oDfEOKM9oiZUFC1p9ZoTtCcz/wjJ28suczD2CCYeEMwh6t8GtgD0CXIMbqRuO64VFiNe33uKsPo7xQTjaBKu0VDYmXuYvQ1XCip//yTOyI9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=J6fC02vx; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="J6fC02vx"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-530d93a18ecso6610021cf.0
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135820; x=1789740620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=32pR0m9lJbbl6oefWflQ2FM2YWt9ii7Ub9HEHMaojiA=;
        b=J6fC02vxUj7R8uLNkm6j2UFmhumP9masIbwPFYObyCpfnCpl3MwEPR2KHNb3TyycME
         sNpKatHEdR199uSZcOxHQdrLrPW7i5wb1ApmozfvvD0hBYo2mTiACAsndyXwmdKVEdka
         08gLK3Be7se5sydXOPVnlve+QHJoL+v/vGwXUs7VmnoCYAYO78aZFdPbcl27Cxkq97PH
         mMXdGQjeed5kX+kAkvMU5nCtrn9ory3l/CIoX7AuYKpRmhW2FdiprLBawGjB7tYJOAnG
         if093zQPO+yjtGUUhHQemjKilV6M3h1sN/CklO3LZU1tzpqLhfQQbX+isj8hXyteX8NZ
         Oa/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135820; x=1789740620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=32pR0m9lJbbl6oefWflQ2FM2YWt9ii7Ub9HEHMaojiA=;
        b=KaCvmSgAo7UuFs9YKRufTu2uS249PcwrCZIYgDhxuIW4dx2fqFKwj5/QeyQtT75X7/
         8MmmKzA6Yv10o59pu3XM2C53PYHdxsPY4vPbjXA3zON8JqzUNfhhiV54rW0+sGk6i84V
         Z3BDNJVtGEMUknPPqy1fe7XJeUFG2mbSxVDrxnWN6tiWTf/YpLhpeSJUUxsUb+sbrByK
         +dKPzeefqQ/OG1SF4xw8GcNDhEleS+ThcpwYBBwczkgn//AjetxaJInuEzMjSkQh02m8
         1LITzxH5S0L36mF8mvPo8jfK/bxQ0wJWNXUC18zSokqmAmxWIp0GDhbpFGoIk6K3tzdC
         GacQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWuD0eFbDzpqgEnALH16rZVG2ebYJAkLAyuVzNrDrt8VtYwGKGIDK3/cHWDgCV+03sPZY=@vger.kernel.org
X-Gm-Message-State: AFuF++nIaEadWBQmUwgm4cCEEb9hcoO++NqwFLmDx54jJjMXnKBYMlj+
	tQGxRNIgx3od/hfB70Fi3uYHaVmuyxjBUmYFD+naGK8smCpQkLdBg4UZqH4GbGMyXk4=
X-Gm-Gg: AYBFou0DDU7IWCc80ex/83Lyq4KtgtEAdbWMiWsQSEznyQWV65/L0/imuFIl7I+F49I
	w2vfhTvwaOlWxgoON3J2yBoa0xw4OU68Sn74shxhL0KShfrO8uzkMFDEko7BSFS14f6M1m5fT7g
	dLx0gWm0Gym2uxm+mUyyg1Uh6h3rhiH3stBL8EHd1p0pM+sjLhna+s28wqJrt1L9DlXD4NGjxWe
	Ya9wukCCUozogE3VDJ8442J20xCbtGau2Ecf1E9/tjjjtiaZY4b4SEmI5qkflsJd+bw5uuqI4Gq
	jUptqmvWx2Xuf//gvzIAjdwS5kRPxGpMwVl6mzKVPCk8qJ8io1mER/8GCgrOugpd2Dlbf2k7WuL
	VglIEbyn5PVVwp9LdcFTLbg/L2aaTlp5z0luW23luqxoiU0Lf+2z7Dnb6tqRtT8SrLX121uz6ta
	BkJxMgRbZXZXJGjNxKelQBoA10xBmst1c9ZMVYj+aNajaQHPVIkg6anGhe615dguEbKnK8JXWd6
	pQM8TEJtDWNzoYOcJ3VGSjjvIbYBxfaKsp9vS4BIZfjxNuwvmaCWnrtGa/6/ZJ4B7k=
X-Received: by 2002:a05:622a:4114:b0:530:da2a:757 with SMTP id d75a77b69052e-530da2a1198mr24113211cf.33.1789135818762;
        Fri, 11 Sep 2026 07:10:18 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530e0aaddbdsm2707391cf.2.2026.09.11.07.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:10:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:49 +0000
Subject: [PATCH RFC v2 11/15] samples: ftrace: Maintain Tasks RCU
 trampoline nesting in direct-call trampolines
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-11-eaaa61ed2da4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135737; l=10811;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=hPcqGdFxo+b+ijS7jNB+8GMowmEDvopzKnpNmpphVrY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKhN0qkThHUh5I4+Grit8p3XEg0LAgV/aMtyHMka/HOmaDw0JgyPUhuISBQoEJ4d9x0FD6DquBp
 sygcZlr+QrA8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Follow the register_ftrace_direct() contract in the sample modules: on
x86-64 and arm64, have each hand-written trampoline increment
current->rcu_tramp_nesting before calling its C handler and decrement it
before returning, via a small shared samples/ftrace/ftrace-direct.h.
%r11 and x12/w13 are used as scratch; both are caller-saved, non-argument
registers and therefore dead on entry to and exit from an fentry
trampoline.

The header pulls in the generated asm-offsets.h only on those two
architectures, since it is not generally safe to include from C (PPC32's
TASK_SIZE and arm64's TRAMP_VALIAS clash with the C definitions; the
latter is worked around locally with push_macro/pop_macro).  Other
architectures get empty macros and are unchanged.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 samples/ftrace/ftrace-direct-modify.c       |  9 ++++
 samples/ftrace/ftrace-direct-multi-modify.c |  9 ++++
 samples/ftrace/ftrace-direct-multi.c        |  5 +++
 samples/ftrace/ftrace-direct-too.c          |  5 +++
 samples/ftrace/ftrace-direct.c              |  5 +++
 samples/ftrace/ftrace-direct.h              | 64 +++++++++++++++++++++++++++++
 6 files changed, 97 insertions(+)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 164d9dd6fd92..eb8230fa4242 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#include "ftrace-direct.h"
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
@@ -73,7 +74,9 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	call my_direct_func1\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp1, .-my_tramp1\n"
@@ -85,7 +88,9 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	call my_direct_func2\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp2, .-my_tramp2\n"
@@ -141,11 +146,13 @@ asm (
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #16\n"
 "	stp	x9, x30, [sp]\n"
 "	bl	my_direct_func1\n"
 "	ldp	x30, x9, [sp]\n"
 "	add	sp, sp, #16\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp1, .-my_tramp1\n"
 
@@ -153,11 +160,13 @@ asm (
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #16\n"
 "	stp	x9, x30, [sp]\n"
 "	bl	my_direct_func2\n"
 "	ldp	x30, x9, [sp]\n"
 "	add	sp, sp, #16\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index b03766c6217b..c8f1062e5d1a 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#include "ftrace-direct.h"
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
@@ -77,10 +78,12 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func1\n"
 "	popq %rdi\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp1, .-my_tramp1\n"
@@ -92,10 +95,12 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func2\n"
 "	popq %rdi\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp2, .-my_tramp2\n"
@@ -154,6 +159,7 @@ asm (
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
@@ -162,6 +168,7 @@ asm (
 "	ldp	x30, x9, [sp]\n"
 "	ldr	x0, [sp, #16]\n"
 "	add	sp, sp, #32\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp1, .-my_tramp1\n"
 
@@ -169,6 +176,7 @@ asm (
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
@@ -177,6 +185,7 @@ asm (
 "	ldp	x30, x9, [sp]\n"
 "	ldr	x0, [sp, #16]\n"
 "	add	sp, sp, #32\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 3fe6ddaf0b69..bc6a88dd4ffc 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -3,6 +3,7 @@
 
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
+#include "ftrace-direct.h"
 #include <linux/sched/stat.h>
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
@@ -56,10 +57,12 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func\n"
 "	popq %rdi\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
@@ -101,6 +104,7 @@ asm (
 "	.globl		my_tramp\n"
 "   my_tramp:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
@@ -109,6 +113,7 @@ asm (
 "	ldp	x30, x9, [sp]\n"
 "	ldr	x0, [sp, #16]\n"
 "	add	sp, sp, #32\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index bf2411aa6fd7..247e418644a2 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -3,6 +3,7 @@
 
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
+#include "ftrace-direct.h"
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
@@ -61,6 +62,7 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	pushq %rdi\n"
 "	pushq %rsi\n"
 "	pushq %rdx\n"
@@ -70,6 +72,7 @@ asm (
 "	popq %rdx\n"
 "	popq %rsi\n"
 "	popq %rdi\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
@@ -110,6 +113,7 @@ asm (
 "	.globl		my_tramp\n"
 "   my_tramp:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #48\n"
 "	stp	x9, x30, [sp]\n"
 "	stp	x0, x1, [sp, #16]\n"
@@ -119,6 +123,7 @@ asm (
 "	ldp	x0, x1, [sp, #16]\n"
 "	ldp	x2, x3, [sp, #32]\n"
 "	add	sp, sp, #48\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 5368c8c39cbb..9e1964baf28b 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -3,6 +3,7 @@
 
 #include <linux/sched.h> /* for wake_up_process() */
 #include <linux/ftrace.h>
+#include "ftrace-direct.h"
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
@@ -54,9 +55,11 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	RCU_TASKS_TRAMP_ENTER
 "	pushq %rdi\n"
 "	call my_direct_func\n"
 "	popq %rdi\n"
+	RCU_TASKS_TRAMP_EXIT
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
@@ -97,6 +100,7 @@ asm (
 "	.globl		my_tramp\n"
 "   my_tramp:"
 "	hint	34\n" // bti	c
+	RCU_TASKS_TRAMP_ENTER
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
@@ -104,6 +108,7 @@ asm (
 "	ldp	x30, x9, [sp]\n"
 "	ldr	x0, [sp, #16]\n"
 "	add	sp, sp, #32\n"
+	RCU_TASKS_TRAMP_EXIT
 "	ret	x9\n"
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct.h b/samples/ftrace/ftrace-direct.h
new file mode 100644
index 000000000000..d0313f33f47f
--- /dev/null
+++ b/samples/ftrace/ftrace-direct.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _SAMPLES_FTRACE_DIRECT_H
+#define _SAMPLES_FTRACE_DIRECT_H
+
+#include <linux/stringify.h>
+
+/*
+ * A direct-call trampoline is entered with no lock, refcount or RCU marker
+ * held; only Tasks RCU keeps it (and, for a module, its text) alive while a
+ * task is inside it or preempted in something it called.  On architectures
+ * that select ARCH_HAS_RCU_TASKS_PREEMPT_QS a preemption is a Tasks RCU
+ * quiescent state unless current->rcu_tramp_nesting is non-zero, so the
+ * trampoline must raise it before calling out and drop it afterwards, exactly
+ * like the ftrace and BPF trampolines do.  See rcu_tasks_trampoline_enter()
+ * and register_ftrace_direct().  The instructions before the increment and
+ * after the decrement are covered by ftrace_direct_mark_module().
+ *
+ * These expand to instruction strings for use inside the samples' asm()
+ * trampolines.  The scratch register is caller-saved and not an argument
+ * register, so it is dead on entry to and exit from an fentry trampoline.
+ *
+ * The generated asm-offsets.h is only pulled in on the architectures that need
+ * it here: it is not generally safe to include from C (e.g. PPC32's TASK_SIZE
+ * and arm64's TRAMP_VALIAS clash with the C definitions), which is why the
+ * samples themselves guard their own include of it.
+ */
+#if defined(CONFIG_TASKS_RCU) && defined(CONFIG_X86_64)
+
+#include <asm/asm-offsets.h>
+
+#define RCU_TASKS_TRAMP_ENTER						\
+	"	movq %gs:current_task(%rip), %r11\n"				\
+	"	incl " __stringify(TASK_rcu_tramp_nesting) "(%r11)\n"
+#define RCU_TASKS_TRAMP_EXIT						\
+	"	movq %gs:current_task(%rip), %r11\n"				\
+	"	decl " __stringify(TASK_rcu_tramp_nesting) "(%r11)\n"
+
+#elif defined(CONFIG_TASKS_RCU) && defined(CONFIG_ARM64)
+
+/* arm64's asm-offsets.h redefines TRAMP_VALIAS from <asm/fixmap.h>. */
+#pragma push_macro("TRAMP_VALIAS")
+#undef TRAMP_VALIAS
+#include <asm/asm-offsets.h>
+#pragma pop_macro("TRAMP_VALIAS")
+
+#define RCU_TASKS_TRAMP_ENTER						\
+	"	mrs	x12, sp_el0\n"						\
+	"	ldr	w13, [x12, #" __stringify(TSK_RCU_TRAMP_NESTING) "]\n"	\
+	"	add	w13, w13, #1\n"						\
+	"	str	w13, [x12, #" __stringify(TSK_RCU_TRAMP_NESTING) "]\n"
+#define RCU_TASKS_TRAMP_EXIT						\
+	"	mrs	x12, sp_el0\n"						\
+	"	ldr	w13, [x12, #" __stringify(TSK_RCU_TRAMP_NESTING) "]\n"	\
+	"	sub	w13, w13, #1\n"						\
+	"	str	w13, [x12, #" __stringify(TSK_RCU_TRAMP_NESTING) "]\n"
+
+#else
+
+#define RCU_TASKS_TRAMP_ENTER
+#define RCU_TASKS_TRAMP_EXIT
+
+#endif
+
+#endif /* _SAMPLES_FTRACE_DIRECT_H */

-- 
2.55.0

