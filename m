Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80047F2C9
	for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742996; cv=none; b=cP5Rlc32qdFAvg3qa/w4V2dN+I1N3NVVOvA7PidVWWwkIGTjmfvq1/h+eHrISBq1yuPfhZ4dOF8OwOf0REHhVQhFL112005GXBCRg91GzD6xy+JRMaV0MmivpLMKRpkd9sfP/Ajxqdz5a7+qD2AiCmPptiGqhXUZ8JL+njNAxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742996; c=relaxed/simple;
	bh=qhXNBlJJp01Ei07kqFZDAUfEsCu0gSp6eIBNqqgCukM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2+Gzmvh+xJIgoTY5s9msG3JjRDpa4dHeGzO4VyKxIzQNMUSMrIDzYywAFxCGA5Gan2na6U7yssxCTpodiATWr7DLK5qmYmxIUEutKcktc7bKFrmgmrlLGjvXmul3EEQE2pu/8yjmZ+cB+dlBNcm3VcrKzchTgFByzRYIo4L+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=O7qjVTZE; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="O7qjVTZE"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a0299c787so63380485a.1
        for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789742988; x=1790347788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=myll629Qfz4YrwGmTVALnxB11mMoUz/LpucXoYBTMJw=;
        b=O7qjVTZEZZVg9nrIexxNs66QSwV91aC51kyoY501FP02Wsqt/4sbYBpC4hDuYEGW+w
         e9N8WAGthO1F8XRvxSRHKV3iHoKD6p8XEdrWjU2PE6ZwdDrs2AyvIBl5PgUmHguxa7Zz
         qpsmLuFNfY8V75JJHz7alQLZj8GZtkzqhutOk6G4WUsyQ/8litkVg9qVmbpVGRG9LabZ
         KT1CbYF89oX9y3Y4WYMdjV/pkszAjGvSvo3b7X4qhDGgcHOpab69A1k9JXPKn1pmsAZx
         H5dSJ9ANYDBT4UUrTIhAFvezISfWTaYPzB662tdJf6cNg9+DhKiuwA9v9229QLcI5a6m
         yX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742988; x=1790347788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myll629Qfz4YrwGmTVALnxB11mMoUz/LpucXoYBTMJw=;
        b=G2Tve8YnAQZCXS39ZNqJe2uYSEelQB1NtaBuWY7uC95nyMr4Fu7bzWfiVX3de2HPn5
         oNwmSnIiRRJXqjPaC9ywIlHbyKGzHB+zD+tIgwgyK4t3qzFVk158qEDFBqcZKawjIARe
         axG/LwvCEEsGwvaSj8MuIIm2bzZqcGXH8mi+oUFLi8j1fDoQobTn1d+MuOzQREaeQXet
         KLUKjS/+G130Nm7dPUQlSSVjDwJVRpKe/+MBWbQzk9RP/g02xJJ2ywyCFRMIcb6C2Daq
         9717pTCgEkSOxj5fR5gAM97iq0FPqP1bga9DS3ppbKGEXiviws+rInmIZQ36zWkvf+GW
         sc0A==
X-Forwarded-Encrypted: i=1; AKwUvBwh8wWJZqewBihFVDPZoFtUH7QTIE4r4kOwzPGPdhGY9VXfytiAeCOiBeyXg1YcSjicIXw=@vger.kernel.org
X-Gm-Message-State: AFuF++lot9dScPRVGxv4EUo37oqTIxgoiR9oJ/56mo48lFtjpCVUB9QI
	Gic/9eSDgEPBDH7dgUXZgMWFjyYy5INWwuMO94fDuMh7KjeVEHEqb8pMJH5K6kVcTmo=
X-Gm-Gg: AYBFou24JvYyMbKZwpyVKhiVzVGEaQg5WdKoSwCSeg8/a25RpIHUweHi0uP8aWXbvDw
	R7M/TTPBh04j8T44obD5VzuGybf7L1XO+5FGuSEVWARGbP+d5t1RMHkTucW/hRH5xJ3Fro6EQLj
	Rer6inCv8h5KPXHXgpuOprzQwk5DmwE4iUebnAQb+ikMUSZQ7MK3PIrMGeGC8Cp+EnomcoJioTc
	OpcJ2mEk+zYns+zCILdxBaQdlIu0OO89Lsjcy0+i0/RclejENXnbeOrBJRYi0ridtBMF3Goi3Am
	Sy62jrpJgC3kMQbMU7qVFQ+Gso/lIsjWfhyORPPimml1aCesdQ7PQDNgQMn0qaKegBuVR3E/7OF
	7fEDFCVznzxneknu3bykkFIDZ+x0M3ce48mYPtwuF/0q3aE3citzOqVMYKUwiX9Tll1DBwJDoxd
	TsXdcXhnw7ZfUFKO96PhicE2txJGcpxB+UDxivQ9N89LQVVGTBpd2JtoKY4Jp9p2Wxq2P/tSIwl
	/0XLifQ+XBZPoa+V4Gl0KLpPLqbxOxJKxAexGWdf9F/2q58s4hFGzqbLL36TuiVCvE=
X-Received: by 2002:a05:620a:2983:b0:93b:d7a3:45d3 with SMTP id af79cd13be357-93bdc8b6a27mr357058685a.60.1789742988018;
        Fri, 18 Sep 2026 07:49:48 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9125800e368sm14410356d6.8.2026.09.18.07.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:49:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:21 +0000
Subject: [PATCH RFC v4 02/13] rcu-tasks: Add a Tasks RCU implementation for
 reader-marked trampolines
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-2-63f0e9d69661@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742979; l=31523;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=qhXNBlJJp01Ei07kqFZDAUfEsCu0gSp6eIBNqqgCukM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKxRe2CaBiEe6pLgkvnyEKMb+x/jOl++z2W4Kx5A0gKz1iBWZzIljfaAJXHRJiKTIhXpTun61uP
 /1AaTpYl8kwI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Tasks RCU waits for every task to pass through a voluntary context
switch, usermode or idle, because a preempted task might be sitting in a
trampoline that is about to be freed and nothing marks it as such.  With
PREEMPT_LAZY that is a poor fit for servers: cond_resched() is a no-op,
so a CPU-bound kthread only ever leaves the CPU by preemption, and one
such kthread holds every synchronize_rcu_tasks() caller -- ftrace and
BPF trampoline teardown under their mutexes, the kprobe jump optimizer
under text_mutex and cpus_read_lock() -- hostage for as long as it runs.

Following the discussion on v2, take the other road: let the
architecture make its trampolines Tasks Trace RCU readers.  When an
architecture selects HAVE_RCU_TRAMPOLINE_READERS it promises that every
trampoline whose lifetime Tasks RCU guards enters rcu_read_lock_trace()
(or its assembly equivalent) before calling out and leaves it before
returning, so a task anywhere inside such a call-out, preempted or not,
is an ordinary Tasks Trace reader.

That leaves the few instructions of trampoline text before the reader is
entered and after it is left (plus, in a later patch, the bytes a kprobe
jump optimization is about to overwrite). A task can only linger there
by being interrupted there, and such text never calls anything that
schedules, so instead of tracking tasks we track CPUs: every pass
through __schedule() is a per-CPU quiescent event, except that the one
context switch that can catch a task at an arbitrary instruction -- a
preemption from irq exit -- first records the interrupted IP in the task
and parks it on a per-CPU list for the duration (reusing the fields and
lists the classic flavor keeps for its exit-path bookkeeping), and, if
the IP is inside such "unmarked" text, puts the task on a short holdout
list; the task takes itself off at its next context switch outside such
a preemption or irq-exit check that finds it elsewhere. Usermode (the
existing tick hook, or a nohz_full CPU in an RCU extended quiescent
state) and idle count as well. rcu_tasks_trampoline_text() does the
classification: anything outside core and module text, plus an arch hook
for things like static ftrace stubs and return thunks.

The grace period, run by the existing rcu_tasks kthread so that
call_rcu_tasks(), synchronize_rcu_tasks() and rcu_barrier_tasks() keep
their names and callers, is: wait for every online CPU to context switch
or be seen in an RCU extended quiescent state (nudging stragglers with
resched_cpu() after a jiffy), drain the holdout list as it stood,
synchronize_rcu_tasks_trace() for everything inside the readers, then
one more CPU pass and drain for tasks that have since left the reader
into the trailing instructions. That is bounded by a few jiffies,
preempt-off latency and an SRCU grace period rather than by the longest
stretch any task runs without sleeping, needs no per-task scan, and
makes cond_resched_tasks_rcu_qs() unnecessary on such architectures.
Unlike the classic flavor it also waits for an idle task caught in a
trampoline, since an idle CPU only counts while RCU is not watching it.
rcu_tasks_wait_irq_preempted() walks the parked lists for the one caller
(the kprobe jump optimizer, later in the series) that makes ordinary
text unsafe to be parked in and so has to wait out tasks that were
preempted there before it said so.

The classic implementation is untouched and remains the default; the
new one is built only as CONFIG_TASKS_RCU_TRAMPOLINE_READERS when the
architecture opts in and uses the generic irq entry code, whose
reschedule check gains the rcu_tasks_irq_resched() call.  Nothing
selects it yet.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/rcupdate.h |  24 ++-
 include/linux/sched.h    |   1 +
 kernel/entry/common.c    |   8 +-
 kernel/fork.c            |   1 +
 kernel/rcu/Kconfig       |  22 +++
 kernel/rcu/tasks.h       | 459 ++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/update.c      |   2 +
 7 files changed, 508 insertions(+), 9 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 44c07a66edff..79e4b14f83b9 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -50,6 +50,23 @@ token_context_lock_instance(RCU, RCU_BH);
 /* Exported common interfaces */
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
 void rcu_barrier_tasks(void);
+
+/*
+ * Trampoline-reader Tasks RCU (CONFIG_TASKS_RCU_TRAMPOLINE_READERS), see
+ * kernel/rcu/tasks.h.  rcu_tasks_irq_resched_enter()/_exit() bracket the
+ * irq-exit preemption; rcu_tasks_trampoline_text() and the arch_ override
+ * classify an interrupted IP; rcu_tasks_wait_irq_preempted() lets a caller
+ * wait out tasks already preempted somewhere it is about to make unsafe.
+ */
+void rcu_tasks_irq_resched_enter(unsigned long ip);
+void rcu_tasks_irq_resched_exit(void);
+bool rcu_tasks_trampoline_text(unsigned long ip);
+bool arch_rcu_tasks_trampoline_text(unsigned long ip);
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+void rcu_tasks_wait_irq_preempted(bool (*inside)(unsigned long ip));
+#else
+static inline void rcu_tasks_wait_irq_preempted(bool (*inside)(unsigned long ip)) { }
+#endif
 void synchronize_rcu(void);
 
 /*
@@ -180,11 +197,16 @@ static inline void rcu_nocb_flush_deferred_wakeup(void) { }
 #ifdef CONFIG_TASKS_RCU_GENERIC
 
 # ifdef CONFIG_TASKS_RCU
-# define rcu_tasks_classic_qs(t, preempt)				\
+#  ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+void rcu_tasks_note_qs(struct task_struct *t, bool preempt);
+#  define rcu_tasks_classic_qs(t, preempt) rcu_tasks_note_qs((t), (preempt))
+#  else
+#  define rcu_tasks_classic_qs(t, preempt)				\
 	do {								\
 		if (!(preempt) && READ_ONCE((t)->rcu_tasks_holdout))	\
 			WRITE_ONCE((t)->rcu_tasks_holdout, false);	\
 	} while (0)
+#  endif
 void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks(void);
 void rcu_tasks_torture_stats_print(char *tt, char *tf);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8b3d47a325cc..15beb44caa2c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -957,6 +957,7 @@ struct task_struct {
 	u8				rcu_tasks_holdout;
 	u8				rcu_tasks_idx;
 	int				rcu_tasks_idle_cpu;
+	unsigned long			rcu_tasks_irq_ip;
 	struct list_head		rcu_tasks_holdout_list;
 	int				rcu_tasks_exit_cpu;
 	struct list_head		rcu_tasks_exit_list;
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e4acd50bd81a..94318519998c 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -6,6 +6,7 @@
 #include <linux/jump_label.h>
 #include <linux/kmsan.h>
 #include <linux/livepatch.h>
+#include <linux/rcupdate.h>
 #include <linux/resume_user_mode.h>
 #include <linux/tick.h>
 
@@ -141,8 +142,13 @@ void raw_irqentry_exit_cond_resched(struct pt_regs *regs)
 		rcu_irq_exit_check_preempt();
 		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 			WARN_ON_ONCE(!on_thread_stack());
-		if (need_resched() && arch_irqentry_exit_need_resched())
+		if (need_resched() && arch_irqentry_exit_need_resched()) {
+			if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
+				rcu_tasks_irq_resched_enter(instruction_pointer(regs));
 			preempt_schedule_irq();
+			if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
+				rcu_tasks_irq_resched_exit();
+		}
 	}
 }
 #ifdef CONFIG_PREEMPT_DYNAMIC
diff --git a/kernel/fork.c b/kernel/fork.c
index 416758c8a3d4..8077336bb136 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1871,6 +1871,7 @@ static inline void rcu_copy_process(struct task_struct *p)
 	p->rcu_tasks_holdout = false;
 	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
 	p->rcu_tasks_idle_cpu = -1;
+	p->rcu_tasks_irq_ip = 0;
 	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_TRACE_RCU
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 332df7a7a634..bbab14bc14c3 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -107,6 +107,28 @@ config TASKS_RCU
 	default NEED_TASKS_RCU && PREEMPTION
 	select IRQ_WORK
 
+config HAVE_RCU_TRAMPOLINE_READERS
+	bool
+	help
+	  Select this if the architecture uses the generic irq entry code and
+	  every trampoline whose lifetime Tasks RCU guards on it (ftrace
+	  trampolines, kprobe out-of-line and optimized-probe slots, BPF
+	  trampolines, out-of-line ftrace direct-call trampolines) enters a
+	  Tasks Trace RCU read-side critical section before calling out of
+	  the trampoline and leaves it before returning, and any core text
+	  that runs on behalf of such a trampoline outside that reader is
+	  reported by arch_rcu_tasks_trampoline_text().  The assembly readers
+	  use the this_cpu_inc() form of SRCU-fast, hence !NEED_SRCU_NMI_SAFE.
+
+config TASKS_RCU_TRAMPOLINE_READERS
+	def_bool TASKS_RCU && HAVE_RCU_TRAMPOLINE_READERS && GENERIC_IRQ_ENTRY && !NEED_SRCU_NMI_SAFE
+	select TASKS_TRACE_RCU
+	help
+	  Implement the Tasks RCU grace period as a per-CPU pass over
+	  context switches and irq-exit reschedules outside trampoline text
+	  plus a Tasks Trace RCU grace period, instead of waiting for every
+	  task to voluntarily context switch.  See kernel/rcu/tasks.h.
+
 config FORCE_TASKS_RUDE_RCU
 	bool "Force selection of Tasks Rude RCU"
 	depends on RCU_EXPERT
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 627295396cd9..f03be742be48 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -152,7 +152,7 @@ static struct rcu_tasks rt_name =							\
 	.kname = #rt_name,								\
 }
 
-#ifdef CONFIG_TASKS_RCU
+#if defined(CONFIG_TASKS_RCU) && !defined(CONFIG_TASKS_RCU_TRAMPOLINE_READERS)
 
 /* Report delay of scan exiting tasklist in rcu_tasks_postscan(). */
 static void tasks_rcu_exit_stall(struct timer_list *unused);
@@ -802,7 +802,7 @@ static void rcu_tasks_torture_stats_print_generic(struct rcu_tasks *rtp, char *t
 
 #endif // #ifndef CONFIG_TINY_RCU
 
-#if defined(CONFIG_TASKS_RCU)
+#if defined(CONFIG_TASKS_RCU) && !defined(CONFIG_TASKS_RCU_TRAMPOLINE_READERS)
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -897,10 +897,444 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	rtp->postgp_func(rtp);
 }
 
-#endif /* #if defined(CONFIG_TASKS_RCU) */
+#endif /* #if defined(CONFIG_TASKS_RCU) && !defined(CONFIG_TASKS_RCU_TRAMPOLINE_READERS) */
 
 #ifdef CONFIG_TASKS_RCU
 
+static int rcu_tasks_lazy_ms = -1;
+module_param(rcu_tasks_lazy_ms, int, 0444);
+
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+
+////////////////////////////////////////////////////////////////////////
+//
+// Tasks RCU for architectures whose trampolines are Tasks Trace RCU
+// readers (CONFIG_HAVE_RCU_TRAMPOLINE_READERS).
+//
+// On these architectures every piece of text whose lifetime Tasks RCU
+// guards -- ftrace trampolines, kprobe optinsn slots, BPF trampoline
+// images, out-of-line ftrace direct-call trampolines -- enters a Tasks
+// Trace RCU read-side critical section before calling out of itself and
+// leaves it before returning, so a task anywhere inside such a call-out,
+// preempted or not, is an ordinary rcu_read_lock_trace() reader and
+// synchronize_rcu_tasks_trace() waits for it.
+//
+// What that cannot cover is the handful of instructions in the trampoline
+// before the reader is entered and after it is left, and the one user that
+// has no trampoline at all: the bytes after a kprobe that the jump
+// optimizer is about to overwrite.  A task can only linger in such
+// "unmarked" text by being interrupted there; unmarked text never calls
+// anything that could schedule.  So a context switch on a CPU tells us that
+// whatever that CPU was running is out of unmarked text, with one
+// exception: a preemption from the irq-exit path, which can happen at any
+// instruction boundary.  That path has the interrupted pt_regs in hand, so
+// just before it preempts it records the IP in the task and checks it
+// (rcu_tasks_trampoline_text()); if it is inside unmarked text the task
+// goes on a short holdout list first, and takes itself off again at its
+// next context switch outside such a preemption or its next irq-exit
+// check that finds it elsewhere.  With that, every pass through
+// __schedule() is a per-CPU quiescent event, as are usermode and idle.
+//
+// A grace period is then:
+//
+//  1. Wait for every online CPU to context switch or be found in an RCU
+//     extended quiescent state (deep idle, nohz_full userspace), nudging
+//     stragglers with resched_cpu().  Afterwards no task is in the leading
+//     unmarked instructions of a dying trampoline unless it is on the
+//     holdout list.
+//  2. Wait for the holdout list (as it stood) to drain.
+//  3. synchronize_rcu_tasks_trace(), for everything inside the readers.
+//  4. Repeat 1 and 2 for tasks that have since left the reader and are in
+//     the trailing unmarked instructions.
+//
+// which is bounded by a few jiffies plus preempt-off latency plus an SRCU
+// grace period, independent of how long any task runs without sleeping.
+// Unlike the classic implementation this does wait for an idle task caught
+// in a trampoline, since an idle CPU only counts while RCU is not watching
+// it.
+
+static void rcu_tasks_tramp_wait_gp(struct rcu_tasks *rtp);
+void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
+DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_tramp_wait_gp, call_rcu_tasks, "RCU Tasks");
+
+/* Per-CPU count of Tasks RCU quiescent events, and the GP kthread's snapshot. */
+static DEFINE_PER_CPU(unsigned long, rcu_tasks_qs_seq);
+static DEFINE_PER_CPU(unsigned long, rcu_tasks_qs_snap);
+
+/*
+ * Tasks currently switched out by an irq-exit preemption are kept, with the
+ * interrupted IP, on the per-CPU rtp_exit_list of the CPU that preempted them
+ * (reusing the list, lock and task_struct fields the classic flavor uses for
+ * its exit-path bookkeeping, which this flavor does not need), so that
+ * rcu_tasks_wait_irq_preempted() can find them without a tasklist scan and
+ * regardless of where they are in exit.
+ */
+
+/* Tasks last seen preempted inside unmarked trampoline text. */
+static LIST_HEAD(rcu_tasks_tramp_holdouts);
+static DEFINE_RAW_SPINLOCK(rcu_tasks_tramp_lock);
+
+/* CPUs / holdouts the current grace period is still waiting for. */
+static struct cpumask rcu_tasks_pending_cpus;
+static LIST_HEAD(rcu_tasks_gp_holdouts);
+
+/**
+ * arch_rcu_tasks_trampoline_text - Does the architecture treat @ip as unmarked trampoline text?
+ * @ip: kernel text address inside core kernel text
+ *
+ * See rcu_tasks_trampoline_text().  Architectures override this to flag
+ * core text that runs on behalf of a trampoline outside its Tasks Trace
+ * reader, e.g. static ftrace entry stubs or return thunks that hold a
+ * trampoline address they are about to jump to.
+ */
+bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
+{
+	return false;
+}
+
+/**
+ * rcu_tasks_trampoline_text - Is @ip in text Tasks RCU protects but no reader marks?
+ * @ip: an interrupted instruction pointer
+ *
+ * True when a task interrupted at @ip may be executing, or about to enter
+ * or return into, text whose lifetime depends on synchronize_rcu_tasks()
+ * without being inside the Tasks Trace reader that text takes around its
+ * call-outs:
+ *
+ *  - anything outside core kernel and module text (ftrace and BPF
+ *    trampolines, kprobe slots and other dynamically allocated text; this
+ *    deliberately does not ask is_ftrace_trampoline() and friends, since
+ *    text being torn down may already be unregistered there);
+ *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text().
+ *
+ * A false positive only makes the task a holdout until its next quiescent
+ * event.  Called with interrupts disabled from the irq-exit path.
+ */
+bool rcu_tasks_trampoline_text(unsigned long ip)
+{
+	if (core_kernel_text(ip))
+		return arch_rcu_tasks_trampoline_text(ip);
+	return !is_module_text_address(ip);
+}
+NOKPROBE_SYMBOL(rcu_tasks_trampoline_text);
+
+/* Note a Tasks RCU quiescent event on this CPU. */
+static void rcu_tasks_qs_event(void)
+{
+	unsigned long *seq;
+
+	guard(preempt_notrace)();
+	seq = this_cpu_ptr(&rcu_tasks_qs_seq);
+	/* Order a preceding rcu_tasks_tramp_hold() before the count. */
+	smp_store_release(seq, *seq + 1);
+}
+
+static void rcu_tasks_tramp_hold(struct task_struct *t)
+{
+	unsigned long flags;
+
+	if (t->rcu_tasks_holdout)
+		return;
+	raw_spin_lock_irqsave(&rcu_tasks_tramp_lock, flags);
+	list_add_tail(&t->rcu_tasks_holdout_list, &rcu_tasks_tramp_holdouts);
+	WRITE_ONCE(t->rcu_tasks_holdout, true);
+	raw_spin_unlock_irqrestore(&rcu_tasks_tramp_lock, flags);
+}
+
+static void rcu_tasks_tramp_release(struct task_struct *t)
+{
+	unsigned long flags;
+
+	if (likely(!t->rcu_tasks_holdout))
+		return;
+	raw_spin_lock_irqsave(&rcu_tasks_tramp_lock, flags);
+	list_del_init(&t->rcu_tasks_holdout_list);
+	WRITE_ONCE(t->rcu_tasks_holdout, false);
+	raw_spin_unlock_irqrestore(&rcu_tasks_tramp_lock, flags);
+}
+
+/**
+ * rcu_tasks_irq_resched_enter - Tasks RCU hook for the irq-exit reschedule check
+ * @ip: instruction pointer of the interrupted (task-level) context
+ *
+ * Called with interrupts disabled when an interrupt returning to kernel
+ * mode is about to preempt_schedule_irq(), the one context switch that can
+ * catch a task inside unmarked trampoline text.  Record where the task is
+ * parked for as long as it is (rcu_tasks_wait_irq_preempted() looks at
+ * that), and if it is inside such text make it a holdout before
+ * __schedule() reports the quiescent event; if it is not, this is as good
+ * as a voluntary switch for ending an earlier hold.
+ */
+void rcu_tasks_irq_resched_enter(unsigned long ip)
+{
+	struct task_struct *t = current;
+	struct rcu_tasks_percpu *rtpcp = this_cpu_ptr(rcu_tasks.rtpcpu);
+
+	lockdep_assert_irqs_disabled();
+	WRITE_ONCE(t->rcu_tasks_irq_ip, ip);
+	t->rcu_tasks_exit_cpu = smp_processor_id();
+	raw_spin_lock_rcu_node(rtpcp);
+	list_add(&t->rcu_tasks_exit_list, &rtpcp->rtp_exit_list);
+	raw_spin_unlock_rcu_node(rtpcp);
+
+	if (unlikely(rcu_tasks_trampoline_text(ip)))
+		rcu_tasks_tramp_hold(t);
+	else
+		rcu_tasks_tramp_release(t);
+}
+NOKPROBE_SYMBOL(rcu_tasks_irq_resched_enter);
+
+/**
+ * rcu_tasks_irq_resched_exit - preempt_schedule_irq() has returned
+ *
+ * The task is running again (possibly elsewhere) and about to return to the
+ * interrupted context; it is no longer parked anywhere.
+ */
+void rcu_tasks_irq_resched_exit(void)
+{
+	struct task_struct *t = current;
+	struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, t->rcu_tasks_exit_cpu);
+
+	lockdep_assert_irqs_disabled();
+	raw_spin_lock_rcu_node(rtpcp);
+	list_del_init(&t->rcu_tasks_exit_list);
+	raw_spin_unlock_rcu_node(rtpcp);
+	WRITE_ONCE(t->rcu_tasks_irq_ip, 0);
+}
+NOKPROBE_SYMBOL(rcu_tasks_irq_resched_exit);
+
+/**
+ * rcu_tasks_note_qs - Tasks RCU hook for a context switch or explicit QS
+ * @t: current
+ * @preempt: this is a preemption rather than a voluntary switch
+ *
+ * Every pass through __schedule() (and cond_resched_tasks_rcu_qs(), and a
+ * tick from userspace or idle) is a quiescent event for this CPU: unmarked
+ * trampoline text never calls anything that schedules, and the irq-exit
+ * path has already made @t a holdout if it is preempting inside such text.
+ * Any of these outside an irq-exit preemption also shows @t itself to be
+ * outside, ending an earlier hold -- including cond_resched() under
+ * PREEMPT_DYNAMIC's none/voluntary modes, where the irq-exit path is off.
+ */
+void rcu_tasks_note_qs(struct task_struct *t, bool preempt)
+{
+	WARN_ON_ONCE(t != current);
+	if (!READ_ONCE(t->rcu_tasks_irq_ip))
+		rcu_tasks_tramp_release(t);
+	rcu_tasks_qs_event();
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_note_qs);	/* cond_resched_tasks_rcu_qs() */
+
+/**
+ * rcu_tasks_wait_irq_preempted - wait for tasks irq-preempted inside @inside
+ * @inside: predicate on a task's recorded irq-exit preemption IP
+ *
+ * For a caller about to make some ordinary text unsafe to be parked in
+ * (the kprobe jump optimizer): once the caller has arranged for
+ * rcu_tasks_trampoline_text() to cover that text, new irq-exit preemptions
+ * there become holdouts, but a task preempted there earlier is invisible
+ * to the grace period.  Wait until no parked task's recorded preemption IP
+ * is inside; a following synchronize_rcu_tasks() then covers the rest.
+ * The leading synchronize_rcu() orders the caller's arrangement against
+ * preemptions in flight, which run with interrupts disabled.
+ */
+void rcu_tasks_wait_irq_preempted(bool (*inside)(unsigned long ip))
+{
+	struct task_struct *t;
+	unsigned long flags;
+	int cpu, kick;
+	bool found;
+
+	synchronize_rcu();
+	for (;;) {
+		found = false;
+		for_each_possible_cpu(cpu) {
+			struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
+
+			kick = -1;
+			raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+			list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
+				if (inside(READ_ONCE(t->rcu_tasks_irq_ip))) {
+					found = true;
+					if (task_curr(t))
+						kick = task_cpu(t);
+				}
+			}
+			raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+			if (kick >= 0)
+				resched_cpu(kick);
+		}
+		if (!found)
+			return;
+		schedule_timeout_uninterruptible(1);
+	}
+}
+
+/* Has @cpu passed a quiescent event since the snapshot, or need it not? */
+static bool rcu_tasks_cpu_quiescent(int cpu)
+{
+	if (!cpu_online(cpu))
+		return true;
+	/* Pairs with the release in rcu_tasks_qs_event(). */
+	if (smp_load_acquire(per_cpu_ptr(&rcu_tasks_qs_seq, cpu)) !=
+	    per_cpu(rcu_tasks_qs_snap, cpu))
+		return true;
+	/*
+	 * Idle or nohz_full userspace in an RCU extended quiescent state: no
+	 * task-level kernel frames can be live in a trampoline there, and
+	 * whatever ran before has switched out.  An idle CPU that RCU is
+	 * watching (an interrupt from idle, or the traceable part of the idle
+	 * loop) is deliberately not let through: the idle task may be in a
+	 * trampoline with that interrupt on top, and since it is never
+	 * preempted from irq exit nothing else would catch it.  It gets the
+	 * resched_cpu() like anyone else and counts once the idle loop itself
+	 * schedules, which it cannot do from inside a trampoline.
+	 */
+	return !(ct_rcu_watching_cpu(cpu) & CT_RCU_WATCHING);
+}
+
+/* Rate-limited stall report; returns true if the caller should add detail. */
+static bool rcu_tasks_tramp_stall(struct rcu_tasks *rtp, unsigned long *lastreport,
+				  const char *what)
+{
+	int rtst = READ_ONCE(rcu_task_stall_timeout);
+
+	if (rtst <= 0 || !time_after(jiffies, *lastreport + rtst))
+		return false;
+	*lastreport = jiffies;
+	pr_err("INFO: %s: %s, grace period %lu is %lu jiffies old\n", rtp->kname,
+	       what, rcu_seq_current(&rtp->tasks_gp_seq), jiffies - rtp->gp_start);
+	return true;
+}
+
+/*
+ * Steps 1/4: wait until every online CPU has context switched or is in an
+ * RCU extended quiescent state.  A CPU that has neither after a jiffy is
+ * asked to switch with resched_cpu(), which takes it through
+ * rcu_tasks_irq_resched_enter() and __schedule() (or, from userspace, a
+ * guest or the idle loop, straight to __schedule()).
+ */
+static void rcu_tasks_tramp_wait_cpus(struct rcu_tasks *rtp, unsigned long *lastreport)
+{
+	struct cpumask *pending = &rcu_tasks_pending_cpus;
+	unsigned long start;
+	int cpu;
+
+	/*
+	 * The quiescent events run with preemption (in practice interrupts)
+	 * disabled, so after this any event we go on to count began after the
+	 * caller's updates -- the unpublished trampoline, and whatever
+	 * rcu_tasks_trampoline_text() consults -- were visible to it.
+	 */
+	synchronize_rcu();
+
+	start = jiffies;
+	for_each_online_cpu(cpu) {
+		per_cpu(rcu_tasks_qs_snap, cpu) = READ_ONCE(per_cpu(rcu_tasks_qs_seq, cpu));
+		__cpumask_set_cpu(cpu, pending);
+	}
+	/* Snapshots before the checks below; pairs with rcu_tasks_qs_event(). */
+	smp_mb();
+
+	for (;;) {
+		for_each_cpu(cpu, pending)
+			if (rcu_tasks_cpu_quiescent(cpu))
+				__cpumask_clear_cpu(cpu, pending);
+		if (cpumask_empty(pending))
+			break;
+		if (time_after(jiffies, start)) {
+			for_each_cpu(cpu, pending)
+				resched_cpu(cpu);
+			rtp->n_ipis += cpumask_weight(pending);
+		}
+		schedule_timeout_idle(1);
+		if (rcu_tasks_tramp_stall(rtp, lastreport, "CPUs without a quiescent event"))
+			pr_err("\tCPUs: %*pbl\n", cpumask_pr_args(pending));
+	}
+}
+
+/*
+ * Steps 2/4: wait for the tasks that were holdouts when we looked to stop
+ * being holdouts.  They are moved to a private list so that tasks becoming
+ * holdouts later (in live trampolines) cannot keep us here; each removes
+ * itself via rcu_tasks_tramp_release() wherever it is queued.
+ */
+static void rcu_tasks_tramp_wait_holdouts(struct rcu_tasks *rtp, unsigned long *lastreport)
+{
+	struct task_struct *t;
+	unsigned long flags;
+	int cpu;
+
+	raw_spin_lock_irqsave(&rcu_tasks_tramp_lock, flags);
+	list_splice_tail_init(&rcu_tasks_tramp_holdouts, &rcu_tasks_gp_holdouts);
+	raw_spin_unlock_irqrestore(&rcu_tasks_tramp_lock, flags);
+
+	for (;;) {
+		struct cpumask *kick = &rcu_tasks_pending_cpus;
+		struct task_struct *show[8];
+		int nshow = 0, i;
+		bool empty, report;
+
+		report = rcu_tasks_tramp_stall(rtp, lastreport,
+					       "tasks preempted in trampoline text");
+		cpumask_clear(kick);
+		raw_spin_lock_irqsave(&rcu_tasks_tramp_lock, flags);
+		empty = list_empty(&rcu_tasks_gp_holdouts);
+		list_for_each_entry(t, &rcu_tasks_gp_holdouts, rcu_tasks_holdout_list) {
+			if (task_curr(t))
+				__cpumask_set_cpu(task_cpu(t), kick);
+			if (report && nshow < ARRAY_SIZE(show))
+				show[nshow++] = get_task_struct(t);
+		}
+		raw_spin_unlock_irqrestore(&rcu_tasks_tramp_lock, flags);
+		/* Never printk under the lock the irq-exit path takes. */
+		for (i = 0; i < nshow; i++) {
+			sched_show_task(show[i]);
+			put_task_struct(show[i]);
+		}
+		if (empty)
+			break;
+		for_each_cpu(cpu, kick)
+			resched_cpu(cpu);
+		rtp->n_ipis += cpumask_weight(kick);
+		schedule_timeout_idle(1);
+	}
+}
+
+/* Wait for one trampoline-reader Tasks RCU grace period. */
+static void rcu_tasks_tramp_wait_gp(struct rcu_tasks *rtp)
+{
+	unsigned long lastreport = jiffies;
+
+	set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
+	rcu_tasks_tramp_wait_cpus(rtp, &lastreport);
+	rcu_tasks_tramp_wait_holdouts(rtp, &lastreport);
+
+	set_tasks_gp_state(rtp, RTGS_WAIT_READERS);
+	synchronize_rcu_tasks_trace();
+
+	set_tasks_gp_state(rtp, RTGS_SCAN_HOLDOUTS);
+	rcu_tasks_tramp_wait_cpus(rtp, &lastreport);
+	rcu_tasks_tramp_wait_holdouts(rtp, &lastreport);
+
+	set_tasks_gp_state(rtp, RTGS_POST_GP);
+}
+
+static int __init rcu_spawn_tasks_kthread(void)
+{
+	rcu_tasks.gp_sleep = HZ / 10;
+	if (rcu_tasks_lazy_ms >= 0)
+		rcu_tasks.lazy_jiffies = msecs_to_jiffies(rcu_tasks_lazy_ms);
+	rcu_tasks.wait_state = TASK_IDLE;
+	rcu_spawn_tasks_kthread_generic(&rcu_tasks);
+	return 0;
+}
+
+void exit_tasks_rcu_start(void) { }
+void exit_tasks_rcu_finish(void) { }
+
+#else /* #ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS */
+
 ////////////////////////////////////////////////////////////////////////
 //
 // Simple variant of RCU whose quiescent states are voluntary context
@@ -1173,6 +1607,8 @@ static void tasks_rcu_exit_stall(struct timer_list *unused)
 #endif // #ifndef CONFIG_TINY_RCU
 }
 
+#endif /* #else #ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS */
+
 /**
  * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
  * @rhp: structure to be used for queueing the RCU updates.
@@ -1187,6 +1623,12 @@ static void tasks_rcu_exit_stall(struct timer_list *unused)
  * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
  * this primitive is intended to determine that all tasks have passed
  * through a safe state, not so much for data-structure synchronization.
+ * On CONFIG_TASKS_RCU_TRAMPOLINE_READERS kernels a preemption outside
+ * trampoline text also ends one, and a reader whose protected window
+ * spans preemptible code must additionally be a Tasks Trace RCU reader
+ * (rcu_read_lock_trace(), as the trampolines there take around their
+ * call-outs); an arbitrary stretch of preemptible kernel code is not
+ * protected.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -1205,7 +1647,9 @@ EXPORT_SYMBOL_GPL(call_rcu_tasks);
  * executing rcu-tasks read-side critical sections have elapsed.  These
  * read-side critical sections are delimited by calls to schedule(),
  * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
- * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
+ * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched();
+ * on CONFIG_TASKS_RCU_TRAMPOLINE_READERS kernels also by preemption
+ * outside trampoline text, see call_rcu_tasks().
  *
  * This is a very specialized primitive, intended only for a few uses in
  * tracing and other situations requiring manipulation of function
@@ -1233,9 +1677,7 @@ void rcu_barrier_tasks(void)
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 
-static int rcu_tasks_lazy_ms = -1;
-module_param(rcu_tasks_lazy_ms, int, 0444);
-
+#ifndef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
 static int __init rcu_spawn_tasks_kthread(void)
 {
 	rcu_tasks.gp_sleep = HZ / 10;
@@ -1251,6 +1693,7 @@ static int __init rcu_spawn_tasks_kthread(void)
 	rcu_spawn_tasks_kthread_generic(&rcu_tasks);
 	return 0;
 }
+#endif /* #ifndef CONFIG_TASKS_RCU_TRAMPOLINE_READERS */
 
 #if !defined(CONFIG_TINY_RCU)
 void show_rcu_tasks_classic_gp_kthread(void)
@@ -1279,6 +1722,7 @@ void rcu_tasks_get_gp_data(int *flags, unsigned long *gp_seq)
 }
 EXPORT_SYMBOL_GPL(rcu_tasks_get_gp_data);
 
+#ifndef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
 /*
  * Protect against tasklist scan blind spot while the task is exiting and
  * may be removed from the tasklist.  Do this by adding the task to yet
@@ -1322,6 +1766,7 @@ void exit_tasks_rcu_finish(void)
 	list_del_init(&t->rcu_tasks_exit_list);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 }
+#endif /* #ifndef CONFIG_TASKS_RCU_TRAMPOLINE_READERS */
 
 #else /* #ifdef CONFIG_TASKS_RCU */
 void exit_tasks_rcu_start(void) { }
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index b62735a67884..a122b8d1effb 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -40,7 +40,9 @@
 #include <linux/tick.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/isolation.h>
+#include <linux/context_tracking_state.h>
 #include <linux/kprobes.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/irq_work.h>
 #include <linux/rcupdate_trace.h>

-- 
2.55.0

