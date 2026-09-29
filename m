Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0633D9DDE
	for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702262; cv=none; b=eSSewQBzMAi6cy0RF59hddILVXtfyIJvDIpxhdDZ4RSSLFQdce/+5qWl6e6rvUcZ/PipP22g6muSsnY3TqT9iNsCAipl2CnQtwy6OuZj7d49SBFnG/tkj7kho83DgxwTuaVTv58zSpeqnn56BL7i2idbGAsERDjsihi1Bhgfi/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702262; c=relaxed/simple;
	bh=FBu4wPNvp6XKLCksA/EO6fe2fqobXZ0aLWTgQ92ND/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2g0cY+ixrDWa+JBNlXonrCq0cOACqP3g+GD8D5Q4GGPVDh/pjRvguUo4/ZwL4O1GYCkCfHJq3ULuebz2rlMRt2p5PQU4MsOjmKe4C/0gxL610Gy/MRdllgIRWVVmZKumB0dreojuFD66yaayFaBmMJKxxIZSUJ4XFmOecc6gCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=QkaQ8dsy; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="QkaQ8dsy"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5bda9b8aso146521985a.1
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 10:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790702260; x=1791307060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fe4PBb/Hf6DUzcCJY1sqn5uC1SzSruVIKDxh26oxA4E=;
        b=QkaQ8dsyTXQVnIPhmhgLcJHSnjAiLwSdZa24Rg6kfD5SKAUvSCWi92I9hBP1DzcuXz
         wrb80zT/eGo8arA4YZg83v4Fa58UkDB0tPvi/Cg5WhgBwmK6d03io4lyvzPVEa5DtnIh
         vdLtlrkorAQfh9rjV5LFceHdX6e9QSB6ZLxTPuBYhzJOlBRSjr78mJQpMSpGc/bN+IgD
         Wajv8oYEg658x0eaX483yZJJPzdgp7vW2SuwIj5ydgK3kij6VU4ORoZiYS6qymmIk0dd
         L6fVdGPJytT38Pb3n47Y5FbxM+ljDwJSH2TdhEtPqP9ihiXbGBLvnTYXgzMLchL4ozGI
         xEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790702260; x=1791307060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fe4PBb/Hf6DUzcCJY1sqn5uC1SzSruVIKDxh26oxA4E=;
        b=fZBTdHrB74HjntfnZDfmpNVGQSJLAdN3xxSD0ROsqPV2pnC35Yugh9dFCmlTO7FLLm
         uC217I5F4ICDa0HfqCrGfbRnIe9FJo8PH8TQHPsu+xC2CwrACLMntLttW5RizpY9i0Z3
         +sFIoqPtTE9Sf7f0YrKYmfEHfTy7a8YSk1tjxIYmhhmwFT2TolvnpfCz4OuIQWpzKONL
         YDD1aXjbfOxPnRz6/Smn8JgSyM4bRXJj2RITLDUWvcaK8IK3ZGrxfTI2YDf9BMRI4pBB
         nFLYR5ELx6QQiew+ihJVYWNRwt/klw125G2LQ2lcBwIvDWHwPvqq1+gyr3qG0XHPVj1d
         sn0g==
X-Forwarded-Encrypted: i=1; AKwUvByWTI+xxRWvrY3yQbqmKBfhAExk2ZDEpqP72i/ttfH+6LIlsGt/92fpJhVrt3oO8L8L1AU=@vger.kernel.org
X-Gm-Message-State: AFuF++lA/ypyBFagc8LvM4590SIrie09F9bBI+QsgwinVZOCI+0kz7xO
	yh7kZ29ZCd9SzvC8qNxyVp3olehFgAHqrevpqjbKjuV86tQqHBd3CoGQZAR896xM4mE=
X-Gm-Gg: AYBFou0ul3c/eRMFBjYNXI8Zw6bbH01z0lunwq10qY2CLvlLRjhuIhmtbleZYmNI0HC
	kh2T4J/plM+2e0zeSPcWAT5s+Juen8KvuR9CaIbHoARhA21CkkdIJTjA0xKvfbsQKxpjiqkH9sV
	AFineFQdk1HVDLdUrGXjTbj4Eey1Cm5Ic/3sXVQpyE7UdRJgM/evxHL2Bv9Wim2V+ZlYc1gm/Af
	UeBFqIxyj2Ykj+QhQSlLVXmLB11dLJcKoKAOGua5ClW0cgKsC25Iu6fKAqprGWUSe1E+mAIe8XJ
	j0r6bGaLQSeIh2qYQIqYYDvIY6gbYCZ9gaTw64CCDaqcARKD+ItSW401Xqd4NkRPHO38UYyeUKY
	U/RgtrVR7jkHGgaqtOj52+dr38A/RG2AAdU4brKICjbknaWC2mknrC6Gi5w6SiIWociShAArMYs
	t0GUO92wOD3x+TiYC2Q+1QoGmPl0cREUr78Eq3teSNZUw87czHQk/LwXLxY2YExJ70rEJzF1eNx
	mArSvQ5gYorfdg=
X-Received: by 2002:a05:620a:1451:b0:93c:2670:2c28 with SMTP id af79cd13be357-93c9f9846a4mr28084685a.10.1790702259614;
        Tue, 29 Sep 2026 10:17:39 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f503457sm17417585a.27.2026.09.29.10.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:17:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Sep 2026 17:07:31 +0000
Subject: [PATCH v6 14/14] x86, arm64: Build Tasks RCU on Tasks Trace
 readers in trampolines
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rcu-tasks-preempt-qs-v6-14-c111ee02caca@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790701682; l=6284;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=FBu4wPNvp6XKLCksA/EO6fe2fqobXZ0aLWTgQ92ND/M=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM5aKK+gCbm3N+QZV9FJaROou1WOBBTQcvS6L+bOjkJ3lKBVKqJiXBvlyBo1oNNPHF0Pr3LTzCa
 TSaSfpKWd7AA=
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
index e3dc348bff29..abff3a924e1e 100644
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

