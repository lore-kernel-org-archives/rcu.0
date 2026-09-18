Received: from mail-qk2-f24.google.com (mail-qk2-f24.google.com [74.125.230.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF134F96AD
	for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743027; cv=none; b=bTBEjcWMLlIoddy7QUZrCOwNvhrX6wuEUEmkSHQFmkv2sQJCit70e5pVsONCvyxBzHsIC4GAPVnoKUzVz/EqUofmYI70Ds54FgXWFrxK7Tb+58RBP4MabdJjhscGnQsqB4O0VhgNPc4VI108JJ3GHMK5j+dtqdQlTlhjCf1QrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743027; c=relaxed/simple;
	bh=I7rYeQZ4spsxQVfaE2Sayb+dFXGxTZqIS2lZCUAJvtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G4uXdWNZXxUUWlM2g8AkFd8c0vIJ8cmgWsl5zIlZWVIiO46Q814DWnkBr91fjCl27oMTrIiFjruFnfH/jpCB6EatdMUn2en4WzTOKg9Xp+7sLtdo6DuIPKTuQ8DqPpk1KVewKuWuHFv0MB6QEpjVrmyWnE/pmAyLqORTAg+wjNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=KTc1gml+; arc=none smtp.client-ip=74.125.230.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="KTc1gml+"
Received: by mail-qk2-f24.google.com with SMTP id af79cd13be357-939695b5741so77872285a.1
        for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789743003; x=1790347803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nk/uI/WquaXkRgHHd/dzhScVzrCkrWpp6IlwsBXJcUg=;
        b=KTc1gml+Cj+mjq83OyxXfRdIBjLH22GhMnuDWljVGcVK+xz5L1c78oDsUqAXosDCA5
         QIr/8S0UylysvEnhouQsVX99G7oU7Wau8wN44iW1x5cDa0SDHcANUfomHfTD3AoZTnML
         ObP8KQ14aFtcdd/8NTvU3B3z1SST1Lv4YYARkKk/+j5cXsZL1bdMW5jXSwefKLJXO5gq
         G9fCwNz8fZoQ7gfryqzMBFM6mvoLjzYquYzFec2z3AnaVOdGCjeQUUZXtc2YtNCO9Ifm
         Pv4h4FgC6LzP2MenjS1ZSk/+K8oufa3OiHspLhnF+k8DjCyfjYuMko9LwNtHbSmuLjrl
         0cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743003; x=1790347803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nk/uI/WquaXkRgHHd/dzhScVzrCkrWpp6IlwsBXJcUg=;
        b=1scr/01VoYKS3o8IRR0MLuzDX2VVeXAlHgjias/Rmgf543NIxeM3kAdVPutOFJSeQm
         Zx+/LuheiC/HTJuGDCGGwHQk8fbAhdJCtNSPEPvZH/T1cw/mxCuiOkgPREFTroLmj7r4
         Caq7h4T2NbdBSUuKFJM7VHFCOYSRDiKLGkBRFh3hKj+4R/gkpETdSxzq8YvTJl6WcRZ4
         Fpp58NqZ+afanJoqM34YjNg+DroB6v0rvMu69Vto+IxVYzU4ZG9yWJ61kmtNyPXb2jkd
         s335BIXVfhO/GE/tEKLKhajxp19obpz9IQIJTWavKLiiQiHF03VIgNuaUc/ZtB5mQXF+
         LQog==
X-Forwarded-Encrypted: i=1; AKwUvBzToB1aVqCnjNIf5/zHLGph9L3bj2WIBzzBsn513U46ANFTCWk570pQVzk5bXk+Hik1oDs=@vger.kernel.org
X-Gm-Message-State: AFuF++mz0prCkdjsIK1himraEdpE8LT0mvS/SO+AYkwY95KKNIzOmXpE
	JgNMNiak6EOR5eXVnFM/RGpwBluxI1JcMzKiMZCWoia25E/kKXC7i1Caidao81mhW2k=
X-Gm-Gg: AYBFou2s9TCMoPXppBYPPVO8dLNdkNQJTrdkzR9W1YaLGBtHEtr3mGwkxUGIff1nPQA
	7l9mgr6oghPpCeiAKy+Cxf+QFfMdiIgVUuXiVXZxOTVbsiE2Yr08U6e3LpQLeO8apBDGZ7r1ZOs
	FpMQwketo1tYxfRDhBfTcp36eSkSlxsrW41yy+E2NggIL0Y0luEBTachPuX7pyq8NrYaIqkmTrQ
	gdb9qMTFb2xEZLwZKKcZCkR/ErYOjPIqyvSZFJAaeHEzqlmZo4kReD0rWMthp8HY+VeIA8grCpe
	sfCuAiokfWZBBmIXj31kDxB4yHcX3NUttB/0PDlrUhDqBsTPX/wsjs2zW07vkaqpHlf2mWzz4Al
	sdn0AYuxadvfFe6M81qcjJq+715bdgeNHVGXOeOaG5/QprmnIKnhb7+ZDCDYO/hMvgYfWe/7ntG
	o8lGf8VOHsfh7y1DvL6k4pxNuUYGlqBf9UAsm3GkUIdSttIdPhOttcjJfufzXvgcak54ZUY0/CK
	EW4YUxYGQUXWerK+RrwL9zuur3B6Xg0Ja+xDg8ooN2Ntj7Xticz6TC3
X-Received: by 2002:a05:620a:40d1:b0:939:6dfc:8abd with SMTP id af79cd13be357-93bdc7ab0bemr371381385a.52.1789743002924;
        Fri, 18 Sep 2026 07:50:02 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0cd1807sm155785785a.4.2026.09.18.07.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:50:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:29 +0000
Subject: [PATCH RFC v4 10/13] samples: ftrace: Make the direct-call
 trampolines Tasks Trace readers
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-10-63f0e9d69661@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742980; l=13193;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=I7rYeQZ4spsxQVfaE2Sayb+dFXGxTZqIS2lZCUAJvtU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKXeVxQcH6ty+hUqDmOn27Ev2Cl/LtWOK4T4/1GJkZcNB9TzuskGzxBUIC7NaI2lvgHsCIRsimJ
 ERl1bJQ3J9QQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The sample direct trampolines are exactly the kind of out-of-line
register_ftrace_direct() user whose lifetime depends on Tasks RCU
waiting for a task inside them: nothing else stops rmmod while a task is
preempted in my_direct_func().  On HAVE_RCU_TRAMPOLINE_READERS
architectures that wait only covers Tasks Trace RCU readers, so give the
samples a small shared header with rcu_read_lock_trace() and
rcu_read_unlock_trace() open-coded as instruction strings for x86-64 and
arm64 -- the same sequences as ftrace_64.S and entry-ftrace.S, using
caller-saved non-argument scratch registers -- and bracket every
call-out with them.  The instructions outside the bracket are module
text, covered by ftrace_direct_mark_module().  Other architectures get
empty definitions.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 samples/ftrace/ftrace-direct-modify.c       |   9 ++
 samples/ftrace/ftrace-direct-multi-modify.c |   9 ++
 samples/ftrace/ftrace-direct-multi.c        |   5 ++
 samples/ftrace/ftrace-direct-too.c          |   5 ++
 samples/ftrace/ftrace-direct.c              |   5 ++
 samples/ftrace/ftrace-direct.h              | 126 ++++++++++++++++++++++++++++
 6 files changed, 159 insertions(+)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 164d9dd6fd92..937c8d8c2a1b 100644
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
+	TRACE_RCU_READ_LOCK
 "	call my_direct_func1\n"
+	TRACE_RCU_READ_UNLOCK
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp1, .-my_tramp1\n"
@@ -85,7 +88,9 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	TRACE_RCU_READ_LOCK
 "	call my_direct_func2\n"
+	TRACE_RCU_READ_UNLOCK
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp2, .-my_tramp2\n"
@@ -141,11 +146,13 @@ asm (
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
 "	hint	34\n" // bti	c
+	TRACE_RCU_READ_LOCK
 "	sub	sp, sp, #16\n"
 "	stp	x9, x30, [sp]\n"
 "	bl	my_direct_func1\n"
 "	ldp	x30, x9, [sp]\n"
 "	add	sp, sp, #16\n"
+	TRACE_RCU_READ_UNLOCK
 "	ret	x9\n"
 "	.size		my_tramp1, .-my_tramp1\n"
 
@@ -153,11 +160,13 @@ asm (
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
 "	hint	34\n" // bti	c
+	TRACE_RCU_READ_LOCK
 "	sub	sp, sp, #16\n"
 "	stp	x9, x30, [sp]\n"
 "	bl	my_direct_func2\n"
 "	ldp	x30, x9, [sp]\n"
 "	add	sp, sp, #16\n"
+	TRACE_RCU_READ_UNLOCK
 "	ret	x9\n"
 "	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index b03766c6217b..e12e5c8b83f0 100644
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
+	TRACE_RCU_READ_LOCK
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func1\n"
 "	popq %rdi\n"
+	TRACE_RCU_READ_UNLOCK
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp1, .-my_tramp1\n"
@@ -92,10 +95,12 @@ asm (
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 	CALL_DEPTH_ACCOUNT
+	TRACE_RCU_READ_LOCK
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func2\n"
 "	popq %rdi\n"
+	TRACE_RCU_READ_UNLOCK
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp2, .-my_tramp2\n"
@@ -154,6 +159,7 @@ asm (
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
 "	hint	34\n" // bti	c
+	TRACE_RCU_READ_LOCK
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
@@ -162,6 +168,7 @@ asm (
 "	ldp	x30, x9, [sp]\n"
 "	ldr	x0, [sp, #16]\n"
 "	add	sp, sp, #32\n"
+	TRACE_RCU_READ_UNLOCK
 "	ret	x9\n"
 "	.size		my_tramp1, .-my_tramp1\n"
 
@@ -169,6 +176,7 @@ asm (
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
 "	hint	34\n" // bti	c
+	TRACE_RCU_READ_LOCK
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
@@ -177,6 +185,7 @@ asm (
 "	ldp	x30, x9, [sp]\n"
 "	ldr	x0, [sp, #16]\n"
 "	add	sp, sp, #32\n"
+	TRACE_RCU_READ_UNLOCK
 "	ret	x9\n"
 "	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 3fe6ddaf0b69..a970464ed378 100644
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
+	TRACE_RCU_READ_LOCK
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func\n"
 "	popq %rdi\n"
+	TRACE_RCU_READ_UNLOCK
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
@@ -101,6 +104,7 @@ asm (
 "	.globl		my_tramp\n"
 "   my_tramp:"
 "	hint	34\n" // bti	c
+	TRACE_RCU_READ_LOCK
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
@@ -109,6 +113,7 @@ asm (
 "	ldp	x30, x9, [sp]\n"
 "	ldr	x0, [sp, #16]\n"
 "	add	sp, sp, #32\n"
+	TRACE_RCU_READ_UNLOCK
 "	ret	x9\n"
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index bf2411aa6fd7..abc098c2ab7a 100644
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
+	TRACE_RCU_READ_LOCK
 "	pushq %rdi\n"
 "	pushq %rsi\n"
 "	pushq %rdx\n"
@@ -70,6 +72,7 @@ asm (
 "	popq %rdx\n"
 "	popq %rsi\n"
 "	popq %rdi\n"
+	TRACE_RCU_READ_UNLOCK
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
@@ -110,6 +113,7 @@ asm (
 "	.globl		my_tramp\n"
 "   my_tramp:"
 "	hint	34\n" // bti	c
+	TRACE_RCU_READ_LOCK
 "	sub	sp, sp, #48\n"
 "	stp	x9, x30, [sp]\n"
 "	stp	x0, x1, [sp, #16]\n"
@@ -119,6 +123,7 @@ asm (
 "	ldp	x0, x1, [sp, #16]\n"
 "	ldp	x2, x3, [sp, #32]\n"
 "	add	sp, sp, #48\n"
+	TRACE_RCU_READ_UNLOCK
 "	ret	x9\n"
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 5368c8c39cbb..99b65ad2fccc 100644
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
+	TRACE_RCU_READ_LOCK
 "	pushq %rdi\n"
 "	call my_direct_func\n"
 "	popq %rdi\n"
+	TRACE_RCU_READ_UNLOCK
 "	leave\n"
 	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
@@ -97,6 +100,7 @@ asm (
 "	.globl		my_tramp\n"
 "   my_tramp:"
 "	hint	34\n" // bti	c
+	TRACE_RCU_READ_LOCK
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
@@ -104,6 +108,7 @@ asm (
 "	ldp	x30, x9, [sp]\n"
 "	ldr	x0, [sp, #16]\n"
 "	add	sp, sp, #32\n"
+	TRACE_RCU_READ_UNLOCK
 "	ret	x9\n"
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
diff --git a/samples/ftrace/ftrace-direct.h b/samples/ftrace/ftrace-direct.h
new file mode 100644
index 000000000000..726f67048ff5
--- /dev/null
+++ b/samples/ftrace/ftrace-direct.h
@@ -0,0 +1,126 @@
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
+ * that select HAVE_RCU_TRAMPOLINE_READERS, Tasks RCU only waits for such a
+ * task while it is a Tasks Trace RCU reader, so the trampoline must enter one
+ * before calling out and leave it afterwards, exactly like the ftrace and BPF
+ * trampolines do.  See register_ftrace_direct().  The instructions before the
+ * lock and after the unlock are covered by ftrace_direct_mark_module().
+ *
+ * These are rcu_read_lock_trace() / rcu_read_unlock_trace() open-coded as
+ * instruction strings for use inside the samples' asm() trampolines, after
+ * the versions in arch/x86/kernel/ftrace_64.S and
+ * arch/arm64/kernel/entry-ftrace.S.  The scratch registers are caller-saved
+ * and not argument registers, so they are dead on entry to and exit from an
+ * fentry trampoline; the flags are clobbered.
+ *
+ * The generated asm-offsets.h is only pulled in on the architectures that need
+ * it here: it is not generally safe to include from C (e.g. PPC32's TASK_SIZE
+ * and arm64's TRAMP_VALIAS clash with the C definitions).
+ */
+#if defined(CONFIG_TASKS_RCU_TRAMPOLINE_READERS) && defined(CONFIG_X86_64)
+
+#include <asm/asm-offsets.h>
+
+#ifndef CONFIG_TASKS_TRACE_RCU_NO_MB
+#define TRACE_RCU_MB	"	lock addl $0, -4(%rsp)\n"
+#else
+#define TRACE_RCU_MB
+#endif
+
+#define TRACE_RCU_READ_LOCK							\
+	"	movq %gs:current_task(%rip), %r11\n"					\
+	"	movl " __stringify(TASK_trc_reader_nesting) "(%r11), %r10d\n"		\
+	"	incl " __stringify(TASK_trc_reader_nesting) "(%r11)\n"		\
+	"	testl %r10d, %r10d\n"							\
+	"	jnz 771f\n"								\
+	"	movq rcu_tasks_trace_srcu_struct+" __stringify(SRCU_srcu_ctrp) "(%rip), %r10\n" \
+	"	incq %gs:" __stringify(SRCU_CTR_srcu_locks) "(%r10)\n"			\
+	"	movq %r10, " __stringify(TASK_trc_reader_scp) "(%r11)\n"		\
+	TRACE_RCU_MB								\
+	"771:\n"
+
+#define TRACE_RCU_READ_UNLOCK							\
+	"	movq %gs:current_task(%rip), %r11\n"					\
+	"	movl " __stringify(TASK_trc_reader_nesting) "(%r11), %r10d\n"		\
+	"	subl $1, %r10d\n"							\
+	"	jnz 772f\n"								\
+	"	movq " __stringify(TASK_trc_reader_scp) "(%r11), %r10\n"		\
+	"	movl $0, " __stringify(TASK_trc_reader_nesting) "(%r11)\n"		\
+	TRACE_RCU_MB								\
+	"	incq %gs:" __stringify(SRCU_CTR_srcu_unlocks) "(%r10)\n"		\
+	"	jmp 773f\n"								\
+	"772:	movl %r10d, " __stringify(TASK_trc_reader_nesting) "(%r11)\n"	\
+	"773:\n"
+
+#elif defined(CONFIG_TASKS_RCU_TRAMPOLINE_READERS) && defined(CONFIG_ARM64)
+
+#include <asm/alternative-macros.h>
+#include <asm/cpucaps.h>
+/* arm64's asm-offsets.h redefines TRAMP_VALIAS from <asm/fixmap.h>. */
+#pragma push_macro("TRAMP_VALIAS")
+#undef TRAMP_VALIAS
+#include <asm/asm-offsets.h>
+#pragma pop_macro("TRAMP_VALIAS")
+
+#ifndef CONFIG_TASKS_TRACE_RCU_NO_MB
+#define TRACE_RCU_MB	"	dmb	ish\n"
+#else
+#define TRACE_RCU_MB
+#endif
+
+#define TRACE_RCU_SRCU_CTRP	"rcu_tasks_trace_srcu_struct+" __stringify(SRCU_SRCU_CTRP)
+
+/* x14 = this CPU's offset; then atomically increment the long at x14 + \areg */
+#define TRACE_RCU_PERCPU_INC(areg)						\
+	ALTERNATIVE("	mrs	x14, tpidr_el1\n", "	mrs	x14, tpidr_el2\n",		\
+		    ARM64_HAS_VIRT_HOST_EXTN)					\
+	"	add	x14, x14, " areg "\n"						\
+	"778:	ldxr	x15, [x14]\n"							\
+	"	add	x15, x15, #1\n"							\
+	"	stxr	w16, x15, [x14]\n"						\
+	"	cbnz	w16, 778b\n"
+
+#define TRACE_RCU_READ_LOCK							\
+	"	mrs	x12, sp_el0\n"							\
+	"	ldr	w13, [x12, #" __stringify(TSK_TRC_READER_NESTING) "]\n"	\
+	"	add	w14, w13, #1\n"							\
+	"	str	w14, [x12, #" __stringify(TSK_TRC_READER_NESTING) "]\n"	\
+	"	cbnz	w13, 771f\n"							\
+	"	adrp	x13, " TRACE_RCU_SRCU_CTRP "\n"					\
+	"	ldr	x13, [x13, #:lo12:" TRACE_RCU_SRCU_CTRP "]\n"			\
+	"	str	x13, [x12, #" __stringify(TSK_TRC_READER_SCP) "]\n"		\
+	"	add	x13, x13, #" __stringify(SRCU_CTR_SRCU_LOCKS) "\n"		\
+	TRACE_RCU_PERCPU_INC("x13")						\
+	TRACE_RCU_MB								\
+	"771:\n"
+
+#define TRACE_RCU_READ_UNLOCK							\
+	"	mrs	x12, sp_el0\n"							\
+	"	ldr	w13, [x12, #" __stringify(TSK_TRC_READER_NESTING) "]\n"	\
+	"	subs	w13, w13, #1\n"							\
+	"	b.ne	772f\n"								\
+	"	ldr	x13, [x12, #" __stringify(TSK_TRC_READER_SCP) "]\n"		\
+	"	str	wzr, [x12, #" __stringify(TSK_TRC_READER_NESTING) "]\n"	\
+	TRACE_RCU_MB								\
+	"	add	x13, x13, #" __stringify(SRCU_CTR_SRCU_UNLOCKS) "\n"		\
+	TRACE_RCU_PERCPU_INC("x13")						\
+	"	b	773f\n"								\
+	"772:	str	w13, [x12, #" __stringify(TSK_TRC_READER_NESTING) "]\n"	\
+	"773:\n"
+
+#else
+
+#define TRACE_RCU_READ_LOCK
+#define TRACE_RCU_READ_UNLOCK
+
+#endif
+
+#endif /* _SAMPLES_FTRACE_DIRECT_H */

-- 
2.55.0

