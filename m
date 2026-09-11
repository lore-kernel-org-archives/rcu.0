Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52033343C
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135791; cv=none; b=WUpnbntgEBntHGH/o4E3mTqkQ+tqVthShFbR44tdk2/jMhg/61wwuCH/lLvYNmNoxu9IShPZ4Bh6/WjEuvJnZBRzFh6xFgsLHHBsIrZr65oqexZ4SYEc71DfYjXSigRqEkiU4cPX88AaGJDsN28VdmBpVyZ5kWXjSByPo6GUv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135791; c=relaxed/simple;
	bh=5hfL8mlrp+YP87pgAlSpHeSx0zMtfymEMHCNh6a40UA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WOn13RhjDrbnKkUQedcwvu/BVO+w+0MGTeBNpn7qbfG/wIy9H6X1otoabthdcNqJxhp7hXqfThegjKiZ7aWlTpaX179Y0WU8GaCe3d3JfISZy3dVedkSP88aFJ782+AFbER4E227op57IafaPMiosRnhz1jNI9vYd+RckBEdXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=rL/Jkys8; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="rL/Jkys8"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66825847b2cso689658d50.3
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135787; x=1789740587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+LMR5vylWFXJjVBWLTvtKp/AcLzLdtKKT/apfY5nlpQ=;
        b=rL/Jkys8kUnRUc5oaWZuIw6ckkTOVgM9b/UQszIZ32je8SZe4cN6gctpBEZy3KFQ3i
         YWdIOVjBOPOjntucHlNhZERqEWMLx2ErceOxXOMNQAUvTlybqQxQoPt7trDUx4MO3/Mm
         UmJM20Fr0NuLoD7dyuDxEOqxkurv2UR8DMrCeV77GCDTROTnjRaKJuUmnXHw4yAtHIek
         vV3LV5Mn/LgGLcw4uoMiJXso8HSLW4zqBczEp6i2+FnjPFwD2ZtxD/Nli7xEAI+k6Dk2
         9mboyx+kv3M27MU0+i21r6nkGD6fAbygHthiXn/iSBW8s3UEA/5wfcchTfB/6spMrRfo
         OpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135787; x=1789740587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+LMR5vylWFXJjVBWLTvtKp/AcLzLdtKKT/apfY5nlpQ=;
        b=bzh7SVIe7PtVF4ROiKzKfqKKSqzrTeglMp6ZW+XlqUUT9LTtfDbqegJIGIiJDB+PPb
         XWjlpWEgUikCjtIibz//X/L7Xx5zMtFAJR6wX+WjDEZNQcFtH5RcQ7Ja29HTkPazskIa
         xW8MsF91Cb48dRjYac7Yi18XOEJAvCrEISWeKbh1HMRtQG2Ea0Nxt8NAU+Co2nL9NLSz
         my43pNCBlHiKMGnV3oPXZ0w3uo6paWLIVuCzmUF50Zubm43dRYqG1EX3antLZ0ZC/LVn
         qOAeHRzPL1D/+AGF4l64T73G/LeMmcsQ0GuGkGNNenh9HWxeG3nxJvbjYMvMhbGBpbvU
         WWJA==
X-Forwarded-Encrypted: i=1; AKwUvBxtyWF4abLEpYYtDpk2kd4nk4pdMRseL0F9DTj2mZ8Dx7M3sb70AwQNsZfqiBk16RtJBK4=@vger.kernel.org
X-Gm-Message-State: AFuF++mOTJfVbdUQqdcDSrzZO9AYc5RtOh6nHL/Q0oc9c/rdfv2bQb8Y
	Ii1y7+Z/7+zCBdQuleWQQ28eGDoyVs3I9OvxAWTwDHz3EiGAm6BMyzHsrhAsOF3Tzag=
X-Gm-Gg: AYBFou0//DTur/QlGnqcfv5zFgxvDXAx4VjHFI1TPTw2bYJqWx6y206929KD6EzUV3T
	MqsprfS/ksFimAMKyUwIzzTN93tYA5rgEAbdNWA9mMQFBNei3xXvAUXuOx8PZrjSIvp5ARmqfMi
	Gdnvl73EByqVLx5RtkTW7ONV65BnlgMlCUSdpC252NgxoNrtuLhSSBPOVnAgHs5DagzE1PUf47t
	dlLa4cKaVhOQKx0+HqcEQJt2OGZ/FwSXrekllNttF6D2RS5xOAKdwSglJJ8enzSlew7fuU4c6aa
	e4RyzZa0k2KsspQfA4t43XnYdppBar98STxHN5QqQeY4cwGIWvyrCdGsTe/Kmo42w7OxkJi3wjD
	JRGaqLLMKg5DY4mJn2mkottzGAR8DBfHlitVeKZRpMPZtw7rn5gki+ExmJ43qFTmtaoHXQnvd82
	XErIiZw98ul+PQjHTLFgao/sLJ5AAguZ8Uj1IxRiqm01TF0QNstHLUD91KCJuLNM4hCSo6isb/+
	DvbKg2rbSCpaO+0M37M3nx8m7sFWFaT58a4+nRz+Hirrrdt3b0sE9he1I05WaTpV9k=
X-Received: by 2002:a53:ac84:0:b0:671:2bb8:ceb0 with SMTP id 956f58d0204a3-6712bb8d198mr592173d50.65.1789135786904;
        Fri, 11 Sep 2026 07:09:46 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120ef650a6sm22355976d6.0.2026.09.11.07.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:09:44 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:39 +0000
Subject: [PATCH RFC v2 01/15] rcu-tasks: Add per-task trampoline nesting
 count
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-1-eaaa61ed2da4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135736; l=7684;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=5hfL8mlrp+YP87pgAlSpHeSx0zMtfymEMHCNh6a40UA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPWvMx3TEehoRUZzyZvbL0GIDlx2yxh9C8YdBR0qgc4jATwF0zYzIPzSM+uo5u0rpazhBa063Yn
 SUZFFg50YiQg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Tasks RCU exists so that ftrace, BPF and kprobes can free trampoline
text once no task can still be executing in it.  Today the only way a
task tells Tasks RCU "I am not in a trampoline" is a voluntary context
switch, so a preempted task is always assumed to be inside one.

Add task_struct::rcu_tramp_nesting so that trampolines can say so
directly: a trampoline increments it before calling out and decrements
it before returning, and while it is non-zero the task must not be
treated as Tasks-RCU quiescent.  Provide rcu_tasks_trampoline_enter()
and rcu_tasks_trampoline_exit() for C users, report the count in the
Tasks RCU stall output, and, under CONFIG_PROVE_RCU, assert that it is
zero on every return to userspace since no task can legitimately reach
userspace with a trampoline on its stack.

Only current ever writes the count and every nested user (interrupts
running their own trampolines) is balanced, so plain accesses suffice.

The callbacks reached from static trampolines (return_to_handler, the
rethook and kretprobe trampolines) are covered by the preempt_disable()
in the ftrace recursion protection rather than by the count; note that
dependency in trace_recursion.h so it is not lost if the
preempt_disable() is ever removed from there.

Nothing increments the count and nothing consults it for quiescent-state
decisions yet; both come in later patches.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/irq-entry-common.h |  2 ++
 include/linux/rcupdate.h         | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/sched.h            |  1 +
 include/linux/trace_recursion.h  | 11 +++++++++++
 kernel/fork.c                    |  1 +
 kernel/rcu/tasks.h               |  3 ++-
 6 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 0bb6c03481fa..8da571622000 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -5,6 +5,7 @@
 #include <linux/context_tracking.h>
 #include <linux/hrtimer_rearm.h>
 #include <linux/kmsan.h>
+#include <linux/rcupdate.h>
 #include <linux/rseq_entry.h>
 #include <linux/static_call_types.h>
 #include <linux/syscalls.h>
@@ -214,6 +215,7 @@ static __always_inline void __exit_to_user_mode_validate(void)
 {
 	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
+	rcu_tasks_trampoline_assert_none();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 }
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 44c07a66edff..b5c666c82479 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -180,6 +180,37 @@ static inline void rcu_nocb_flush_deferred_wakeup(void) { }
 #ifdef CONFIG_TASKS_RCU_GENERIC
 
 # ifdef CONFIG_TASKS_RCU
+
+/*
+ * Trampoline nesting: dynamically allocated text (ftrace trampolines, BPF
+ * trampoline images, kprobe optinsn slots) that relies on Tasks RCU for its
+ * lifetime brackets itself with an increment/decrement of
+ * current->rcu_tramp_nesting.  While the count is non-zero the task is inside,
+ * or was called from, such text and an involuntary context switch must not be
+ * treated as a Tasks RCU quiescent state.
+ *
+ * Only current writes the count and only current (or an interrupt on the same
+ * CPU) reads it, so plain accesses suffice.
+ */
+static __always_inline void rcu_tasks_trampoline_enter(void)
+{
+	current->rcu_tramp_nesting++;
+	barrier();
+}
+
+static __always_inline void rcu_tasks_trampoline_exit(void)
+{
+	barrier();
+	current->rcu_tramp_nesting--;
+}
+
+/* A task must never reach userspace with a trampoline on its stack. */
+static __always_inline void rcu_tasks_trampoline_assert_none(void)
+{
+	if (IS_ENABLED(CONFIG_PROVE_RCU))
+		WARN_ON_ONCE(current->rcu_tramp_nesting);
+}
+
 # define rcu_tasks_classic_qs(t, preempt)				\
 	do {								\
 		if (!(preempt) && READ_ONCE((t)->rcu_tasks_holdout))	\
@@ -192,6 +223,9 @@ void rcu_tasks_torture_stats_print(char *tt, char *tf);
 # define rcu_tasks_classic_qs(t, preempt) do { } while (0)
 # define call_rcu_tasks call_rcu
 # define synchronize_rcu_tasks synchronize_rcu
+static inline void rcu_tasks_trampoline_enter(void) { }
+static inline void rcu_tasks_trampoline_exit(void) { }
+static inline void rcu_tasks_trampoline_assert_none(void) { }
 # endif
 
 #define rcu_tasks_qs(t, preempt) rcu_tasks_classic_qs((t), (preempt))
@@ -208,6 +242,9 @@ void exit_tasks_rcu_finish(void);
 #define rcu_tasks_classic_qs(t, preempt) do { } while (0)
 #define rcu_tasks_qs(t, preempt) do { } while (0)
 #define rcu_note_voluntary_context_switch(t) do { } while (0)
+static inline void rcu_tasks_trampoline_enter(void) { }
+static inline void rcu_tasks_trampoline_exit(void) { }
+static inline void rcu_tasks_trampoline_assert_none(void) { }
 #define call_rcu_tasks call_rcu
 #define synchronize_rcu_tasks synchronize_rcu
 static inline void exit_tasks_rcu_start(void) { }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8b3d47a325cc..d2e7b1b3c9d2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -956,6 +956,7 @@ struct task_struct {
 	unsigned long			rcu_tasks_nvcsw;
 	u8				rcu_tasks_holdout;
 	u8				rcu_tasks_idx;
+	int				rcu_tramp_nesting;
 	int				rcu_tasks_idle_cpu;
 	struct list_head		rcu_tasks_holdout_list;
 	int				rcu_tasks_exit_cpu;
diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index e6ca052b2a85..2da23a52ca4a 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -153,6 +153,17 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 	current->trace_recursion = val;
 	barrier();
 
+	/*
+	 * Callbacks reached from static trampoline text (return_to_handler,
+	 * the rethook and kretprobe trampolines) do not maintain
+	 * current->rcu_tramp_nesting themselves; they rely on this
+	 * preempt_disable() to keep the task from being preempted, and thus
+	 * from reporting a Tasks RCU quiescent state, while an ftrace_ops or
+	 * its data is in use.  If the preempt_disable() is ever removed from
+	 * the recursion protection, this must rcu_tasks_trampoline_enter()
+	 * here and rcu_tasks_trampoline_exit() in trace_clear_recursion()
+	 * instead.  See CONFIG_RCU_TASKS_PREEMPT_QS.
+	 */
 	preempt_disable_notrace();
 
 	return bit;
diff --git a/kernel/fork.c b/kernel/fork.c
index 416758c8a3d4..cfe3a8e53fbd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1869,6 +1869,7 @@ static inline void rcu_copy_process(struct task_struct *p)
 #endif /* #ifdef CONFIG_PREEMPT_RCU */
 #ifdef CONFIG_TASKS_RCU
 	p->rcu_tasks_holdout = false;
+	p->rcu_tramp_nesting = 0;
 	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
 	p->rcu_tasks_idle_cpu = -1;
 	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 627295396cd9..1662ba18bf34 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1113,10 +1113,11 @@ static void check_holdout_task(struct task_struct *t,
 		*firstreport = false;
 	}
 	cpu = task_cpu(t);
-	pr_alert("%p: %c%c nvcsw: %lu/%lu holdout: %d idle_cpu: %d/%d\n",
+	pr_alert("%p: %c%c nvcsw: %lu/%lu holdout: %d tramp_nesting: %d idle_cpu: %d/%d\n",
 		 t, ".I"[is_idle_task(t)],
 		 "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
 		 t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
+		 data_race(t->rcu_tramp_nesting),
 		 data_race(t->rcu_tasks_idle_cpu), cpu);
 	sched_show_task(t);
 }

-- 
2.55.0

