Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090164FD7A0
	for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743018; cv=none; b=GJxalwStgXfXoKi67EgLV7ADv6KzelxPH/+xABdaZFe/fdr8SMwTFG7qzWmfWdezSwicbUQGU/UoMKxPX9jne8OPPBkIjDuf72HzMDFBD2udRY6f2zzuQ2DB5K5sbivGFVsV6VPeL5VJ4pz8XD4xaPIaYhwbnUj5x5EK6+oi2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743018; c=relaxed/simple;
	bh=VsJyzZYJ6ksShlnC7Yiz29R4LafGY+0/mhkU2yBL4O8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nnb7wcjDilj6yYdRRlASKWYMKDGfFAC0flpVxXBGtCW+Cg4bczXRpNthCJQFhbpqoKuVERH4qfVLL4TEyU3bMSJ3S5IdskLBEyEsaKgKF28MJVAMVZWn0sNm7r7QKtuXRKgJF9TuKbL4llaz//fcbCVwlOD1p+rOwkkXKsi1ZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Neoht7TE; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Neoht7TE"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530de452c33so7709371cf.1
        for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789743011; x=1790347811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A8c5rUXaTXu9B0UqDL2lNbjmJqabE8+fQOLsAHyr+Co=;
        b=Neoht7TEqaLKVRIQNuzTTIoe7/t6oqKkItVzRom8wJ6NS1YbgDc5FeQ8ARe6Pcrbtp
         Rt4XOKSGJyPbURVZTY44kmrDZtIAoOsZtCFX/edl71VSfTv5M2GdqTa3Wu7AenzPLTAv
         NGTINwd536+m0uParamtVLnB5Zvj+GFddR+FFi4gDYlZJGuS5L2eTPbOHbq8wXFAqABP
         WQBzszGrnUCIQEi90bKAazoOdaYmrdroVX6y9n3yNhas0aBH1/Nx7FFPjkfq08JVfNnq
         qc3J+deMNsKgXetGPdDvJ4GjjaPFSF/uoi44oWx9XjIhRhgEg5yG55wBQ0tBHAQGFwQg
         nByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743011; x=1790347811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A8c5rUXaTXu9B0UqDL2lNbjmJqabE8+fQOLsAHyr+Co=;
        b=vMbie0ASw0gWl6UuDaNMCp36wnfMa7IlQXrKlq7joRXDsTNaiKtJdderTm236J4ERp
         K92FSBENk9rCSmX2txt54mGGRbb+UHVlkE+OTeZu1Dqo/pSdzIS7xgdzSVWq9iySQbcw
         io42naMaS+NCdr+8KuG5sSWTOjOUZfvisud+KJSuo9XXA31sz8qSA41v9SOC7xRivnT6
         VWYGKw9fbX/+Kc2nX8QPww0XJ2Mty6Gl2+ecFeLUgsu5ZSEJayKa4yEwIDR6Gq50H5y0
         PPfn8MlAvVBTO86GwKm/mvW4r2F65ts5kWC5sXxyk++E3K6bmZoMQLiM7YvLyRe5jF8E
         yG8w==
X-Forwarded-Encrypted: i=1; AKwUvBx4+bek0s4mPQlxaIitONHc/GP3W8s1GnVAxarFCzFhrMbbvWMXf+7PGi2dH++YcasPw1Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nqL+ZepXDK7hJgip3/QadnUebtNidO6djbLyyCKsBw4uJyheoL
	CmhfmturGCZBhHrV7anmheYfhwmUuva6+COYsjE/rd2FDvdOJRLyAdD1Sx/ue8jwPlY=
X-Gm-Gg: AYBFou2AqQdyug4dJ5910+4hWkGZt2mIunWQaDoAeKOtjkFEtewUx1tJNhlIVhB1JBv
	sXWF2aOvNwkx69fwTYpn1iOIfSw7ncsRHjB8EwA/Ai4S06egeEmgo8yFimg+DHM+DRMNhzKDx4B
	qrBeixWh+MwQZGUkcCCpTENBJm7bxFJ0cUSb9w6uJDYIAdZwJgFWui3M4UMEshFOApJJS2iPXZJ
	qVSD9WtdsAcNpZlOQmst8UgIl7fdymC83bzvIHWdDDGrLWSDHIrD4AP/KGMjrIKD9ReUirV0LxR
	uUTwWSC/mfm65feUH29Oy4V7BcsmUYbtSotAlp5TX93AZHnjF6s4DrqiSrNJRKazkfgnyxTZygc
	qcZHzrCKeZnB64+Y9uC3YX8yDJjBbc9V0rp/iQnpp31ygafmd8BlxlSe0V3jvQvgdSAsRT8uirq
	F8KQwxwSvFsmA7vuJD8LwHka/H3F+x4WtsscYU6QtgUb25gWxXS70r4UBgbm7R7tRII12PVVLTV
	A3rFL4LqJi4afcibHfkGgb2tsqI6VqcpOikJ2ompE6/cLVDcc5GmwuZ
X-Received: by 2002:a05:622a:2606:b0:532:9add:50bb with SMTP id d75a77b69052e-5329e402a69mr42121701cf.75.1789743010763;
        Fri, 18 Sep 2026 07:50:10 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532aac41311sm5612191cf.10.2026.09.18.07.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:50:09 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:32 +0000
Subject: [PATCH RFC v4 13/13] x86, arm64: Build Tasks RCU on Tasks Trace
 readers in trampolines
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-13-63f0e9d69661@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742980; l=6284;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=VsJyzZYJ6ksShlnC7Yiz29R4LafGY+0/mhkU2yBL4O8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEwAhBVideBDLteTwvOfpHAYkoAWUm3JvOEwqQNA35GYhU6H/frrHaAxlVzl5POPAnXUpm7Q7V1
 WCFlv6PR8OAI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With the preceding patches every trampoline whose lifetime Tasks RCU
guards on x86-64 and arm64 -- ftrace_caller and its copies, the optprobe
template, BPF trampolines, and the sample direct-call
trampolines -- is a Tasks Trace RCU reader around its call-out, and the
text outside that reader is known to rcu_tasks_trampoline_text().
Select HAVE_RCU_TRAMPOLINE_READERS on both (x86-64 with SMP for Tree
SRCU and DYNAMIC_FTRACE, which is where its ftrace_caller changes and
arch_rcu_tasks_trampoline_text() live; arm64 with
DYNAMIC_FTRACE_WITH_ARGS likewise), which switches CONFIG_TASKS_RCU to the
implementation added earlier in the series: a Tasks RCU grace period
becomes a per-CPU pass over context switches and irq-exit reschedules
outside trampoline text plus a Tasks Trace grace period, bounded by a
few jiffies and preempt-off latency instead of by the longest stretch
any task runs without sleeping.

Other architectures keep the classic implementation.  Update
Documentation/RCU and the FORCE_TASKS_RCU help text to describe the
variant and the obligation it places on trampolines.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 .../RCU/Design/Requirements/Requirements.rst       | 24 ++++++++++++++++++++++
 Documentation/RCU/checklist.rst                    |  7 ++++++-
 arch/arm64/Kconfig                                 |  1 +
 arch/x86/Kconfig                                   |  1 +
 kernel/rcu/Kconfig                                 |  6 ++++--
 5 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 8101fe6229d5..c059c463e083 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2756,6 +2756,30 @@ synchronize_rcu(), and rcu_barrier(), respectively. In
 three APIs are therefore implemented by separate functions that check
 for voluntary context switches.
 
+Architectures that select ``CONFIG_HAVE_RCU_TRAMPOLINE_READERS`` keep the
+same three APIs but implement the grace period differently
+(``CONFIG_TASKS_RCU_TRAMPOLINE_READERS``).  There, every trampoline whose
+lifetime Tasks RCU guards enters a Tasks Trace RCU read-side critical
+section (rcu_read_lock_trace() or its assembly equivalent) before calling
+out and leaves it before returning, so a task anywhere inside such a
+call-out is an ordinary Tasks Trace reader whether or not it is
+preempted.  The few trampoline instructions outside that reader can only
+be occupied by a task that was interrupted there, so the grace period
+additionally waits for each CPU to pass through a context switch, and the
+irq-exit preemption path, the only switch that can catch a task inside
+such text (rcu_tasks_trampoline_text()), briefly makes such a task a
+holdout until it is next seen elsewhere.  On such kernels an involuntary
+context switch outside trampoline text *is* a Tasks-RCU quiescent state,
+a Tasks RCU grace period no longer depends on how long any task runs
+without sleeping, cond_resched_tasks_rcu_qs() is unnecessary, and the
+obligation moves to the trampolines: anything that relies on
+synchronize_rcu_tasks() to protect code a task may be preempted in must
+take the Tasks Trace reader (see register_ftrace_direct()), or, where
+that is impossible because the code is ordinary text with no trampoline
+of its own, make it known to rcu_tasks_trampoline_text() and wait out
+tasks already parked there with rcu_tasks_wait_irq_preempted(), as the
+kprobe jump optimizer does.
+
 Tasks Rude RCU
 ~~~~~~~~~~~~~~
 
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 4b30f701225f..87dd506bffef 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -252,7 +252,12 @@ over a rather long period of time, but improvements are always welcome!
 	a.	If the updater uses synchronize_rcu_tasks() or
 		call_rcu_tasks(), then the readers must refrain from
 		executing voluntary context switches, that is, from
-		blocking.
+		blocking.  On architectures that select
+		CONFIG_HAVE_RCU_TRAMPOLINE_READERS a reader must in
+		addition be a Tasks Trace RCU reader (that is what the
+		trampolines there do around their call-outs) or be text
+		that rcu_tasks_trampoline_text() recognises; an arbitrary
+		stretch of preemptible kernel code is not protected.
 
 	b.	If the updater uses call_rcu_tasks_trace()
 		or synchronize_rcu_tasks_trace(), then the
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5a51b0ef944..bf0e56006863 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -218,6 +218,7 @@ config ARM64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_PREEMPT_DYNAMIC_KEY
+	select HAVE_RCU_TRAMPOLINE_READERS if DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 15fd9ec5ecac..64c3814eb745 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -288,6 +288,7 @@ config X86
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	select HAVE_RCU_TRAMPOLINE_READERS	if X86_64 && SMP && DYNAMIC_FTRACE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if UNWINDER_ORC || STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bbab14bc14c3..341b68b972ef 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -95,8 +95,10 @@ config FORCE_TASKS_RCU
 	help
 	  This option force-enables a task-based RCU implementation
 	  that uses only voluntary context switch (not preemption!),
-	  idle, and user-mode execution as quiescent states.  Not for
-	  manual selection in most cases.
+	  idle, and user-mode execution as quiescent states, or, on
+	  HAVE_RCU_TRAMPOLINE_READERS architectures, the variant built on
+	  Tasks Trace RCU readers in trampolines.  Not for manual
+	  selection in most cases.
 
 config NEED_TASKS_RCU
 	bool

-- 
2.55.0

