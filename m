Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7654344D92
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135801; cv=none; b=ol1bMUS1ex7Jd696pXoeZd7yIbeAokfEQ30L3Qa28PKf313qvino4WZcwao8mcvEv9ty2EICPOI9OxXAQcdJx85h5yszgZsU2P6QDlUlrWkV+hZ6aiLcekrH/TPobu/EQ6RJfcJyiAaJe7yEXDq8ZEgQgdcrvLTQa2HEmp1yVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135801; c=relaxed/simple;
	bh=zaxzL0DRdr6YBFEcTSGtZpzKzuVZf+tDLqNK8lLQ3vQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gmDf7ux5DxFPTsgFfnaKXnNubW20Xb5c2Pl8rj61EhqHQabGAF29VGXcyyeXWpRTAZ+i3dKHdh2olu6BofeVMwkE1nKAH7T/KpB0Ch1jamXbifqgNByBMTTbY6Hk4bJ+2TrEL9Xciys2M4VO73rxRiTA5+j4/VODnKazIgdHYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=FWHTJbU2; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="FWHTJbU2"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-836c8bde2dcso8058317b3.0
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135795; x=1789740595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5run1FbtWhLPrIbIpcsdoDpDcAIfw1LixKxJKXXjMZI=;
        b=FWHTJbU2CaiRLjYPtzSleNd1U6QhPoDbBc7iiYgmy9FHDYMO/G+IuSxfD4+hVy/wQV
         TbPd0UgWLcQvgyUoA0hRWMqE9bIBPQfJqYZwP1fS2c2+wODE1A+OWn+Lw3UAYiiqYCzx
         C483azIk8nfsfrz7WXCcMRZtDUkBpDzTVOgkNegbBjLzMukB0Y3VMxTmIEBHmmOWBIHg
         0rRc0zq9Cqe54uKoha3TephRv0cBW36yEQVdrP4Notogjs9QucRc42LDwbW2+P0odZKo
         EFtMKODdYYc0g/YmH785r1IDTyxgKuMXnlmBt5mmABEVSThuLc8Yh/jqndFiSAW2Jo96
         UCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135795; x=1789740595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5run1FbtWhLPrIbIpcsdoDpDcAIfw1LixKxJKXXjMZI=;
        b=ssH9Jy8EEQV0kkd4vRBKXB8XXhaTgedyek/NOeCfh3f+4HBPN/2o1m83Brww7pYKhm
         i7nPnKoTs/NBl9UMQtutXgw2SWzR0XdWAmCkD1M70T4PvJGanXxMxUG8Rk9hH+WFr35S
         Iv+Mr1ttfOy8MWkLdcdjeDGTo3ppIbXkLUTLiD5fWVrhb4nF1toBe21QzWvxamHV3Qsc
         B/6ejywTMFEkK/Ztysp5/txOYy8JivWWOm9s00G/6dgfhWOY1OPipCYgIsDxK5h/S9TU
         fZ/1soQTcCgfdE/jAa5nxqy8Ykox6d4Pvo8jTESyNG4E1CjMzo4JFq9ijlNye+iZXDCg
         /UIg==
X-Forwarded-Encrypted: i=1; AKwUvBzSTkiqmSqDQFf42XGDHIi/kHtvqiJDKfsiT5hR9zpFLhOoDn6u34x65X/SZw2Bp9YUlbI=@vger.kernel.org
X-Gm-Message-State: AFuF++mNd/oaSFXNE0wmp8mF4dErmiU1lPtpw8TfoXJqGNRFCgjOXB7R
	6m6KYgEgttdK0oApCLidI7HmfcprOAUp64AOh0idoyzDJOTD3s/zNpuntMc7e8qY3IE=
X-Gm-Gg: AYBFou0481hkYzh0jFDmFlx4HfbF0V3vLacWf+U9SDNXNAFJLRhWbuMEi5j2QPeMZDP
	fnZ66Nk+qygbNWGy6Z5U7sDs+qLn7tYQNjl6EpZmxTOulavycDyZZFvVeFXxCoNr4kHdfhqiK1Y
	Cc+ZY6/dnUi5bgC+4dpLrm8dvOf49PNVAhWcW/kEhL9q5Hg7v7QYCe5AsmFoEJpLvs99TpXhqPp
	vfVQvZ/Sl3k1nQktPU1Rsc0dyc9OGzEMFhdt1U7JWy8I1vPmAEhjjpFdNHZSCYJ4zDJT5ugB55g
	rXsx6F29DS8dUyreoRueJFktx8hnKt3jn1sD9CZRAvo/NV1PtZ9oebTQtiXOCWxMxJm3bM2LeNX
	SGvPJ7rJqbBxv30wnkT+TUw3dk+sWqqJOpimXuFODJRlfCyrHvxVrgo9jOj7lytVbFCeEZ/VL8I
	PKCbioYRqZyuE6GSV2tBBO6qSkC7H0ms0Y2oaiZE/bYA+3xmLcYdCzdxdOxfF9nNKuL+MoDWaSY
	8EZpnZ1nNbM418jAsaFd+Mel2K5G1LI0mA+a2l+HoprxlUK+S50GON/
X-Received: by 2002:a05:690c:10c:b0:873:5c0f:27f with SMTP id 00721157ae682-884b183fa8fmr15728927b3.41.1789135795285;
        Fri, 11 Sep 2026 07:09:55 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d0700sm22061896d6.38.2026.09.11.07.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:09:53 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:42 +0000
Subject: [PATCH RFC v2 04/15] kprobes: Let Tasks RCU recognise tasks
 preempted in an optprobe jump window
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-4-eaaa61ed2da4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135736; l=12385;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=zaxzL0DRdr6YBFEcTSGtZpzKzuVZf+tDLqNK8lLQ3vQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDkHo+7Zxxr001o9pThi3R9UNNh0hJGGQszxQdwGKWyIfzZokuP81SU5bPZjsOb84RB2Rvd/rcr
 ztRWEWANpTgE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

kprobe_optimizer() is the one synchronize_rcu_tasks() user that is not
about trampoline text: it waits for tasks that were preempted on an
instruction boundary inside the bytes it is about to overwrite with the
optimized jump, so that none of them resumes into the middle of the new
instruction.  Such a task sits in ordinary kernel or module text with
rcu_tramp_nesting == 0, and can only have got there via an irq-exit
preemption.

Add kprobe_in_optimized_region(), a lockless and conservative form of
get_optimized_kprobe() that reports whether any registered kprobe lies
within MAX_OPTIMIZED_LENGTH before the given address regardless of its
optimization state.  The hash walk is only done while kprobe_optimizer()
is actually inside its synchronize_rcu_tasks(), tracked by a flag it sets
around the call; otherwise the check is a single load.  The kprobe hash
is RCU-protected and every free path waits for a grace period after
unhashing, so the lockless walk is safe from any context with preemption
disabled.

Unlike trampoline text, which a task can only be interrupted in while
the trampoline exists, these bytes are ordinary text a task may have
been parked in since before the kprobe was registered, and the optimizer
may start waiting while that task is already switched out.  So the check
cannot be made once at preemption time the way the trampoline cases are:
have irqentry_preempt() record the interrupted IP in
current->rcu_tasks_irq_ip for the duration of the preemption, and add
rcu_tasks_irq_ip_holds() to test it, to be evaluated at every
quiescent-state decision once preemption becomes a quiescent state --
each pass through __schedule() in preempt_schedule_irq()'s loop as well
as any remote check.  A task switched out synchronously cannot have a
resume point inside such a window (a call there returns beyond it), so
only the irq-exit IP needs checking, and preempt_schedule_irq() cannot
nest, so one slot per task suffices.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/kprobes.h  |  8 +++++++-
 include/linux/rcupdate.h | 17 +++++++++++++++++
 include/linux/sched.h    |  1 +
 kernel/entry/common.c    | 13 +++++++++++--
 kernel/fork.c            |  1 +
 kernel/kprobes.c         | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tasks.h       | 23 +++++++++++++++++++++++
 7 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e6de7ae55bda..74cc48c04417 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -530,11 +530,17 @@ static inline bool is_kprobe_insn_slot(unsigned long addr)
 }
 #endif /* !CONFIG_KPROBES */
 
-#ifndef CONFIG_OPTPROBES
+#ifdef CONFIG_OPTPROBES
+bool kprobe_in_optimized_region(unsigned long addr);
+#else /* !CONFIG_OPTPROBES */
 static inline bool is_kprobe_optinsn_slot(unsigned long addr)
 {
 	return false;
 }
+static inline bool kprobe_in_optimized_region(unsigned long addr)
+{
+	return false;
+}
 #endif /* !CONFIG_OPTPROBES */
 
 #ifdef CONFIG_KRETPROBES
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 0a408e36ea15..4cfe096d624f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -202,6 +202,14 @@ bool arch_rcu_tasks_ip_in_trampoline(unsigned long ip);
  * rcu_tasks_ip_in_trampoline() and holding the count elevated across
  * preempt_schedule_irq() when it matches.
  *
+ * The one non-trampoline user, kprobe jump optimization, waits for tasks
+ * preempted inside ordinary instruction bytes it is about to overwrite.  A
+ * task can be parked there from before the kprobe even existed, so that
+ * cannot be decided once at preemption time: irqentry_preempt() records the
+ * interrupted IP in current->rcu_tasks_irq_ip for the duration of the
+ * preemption and rcu_tasks_irq_ip_holds() checks it at every quiescent-state
+ * decision, locally and from the grace-period kthread.
+ *
  * Only current writes the count and only current (or an interrupt on the same
  * CPU) reads it, so plain accesses suffice.
  */
@@ -225,6 +233,13 @@ static __always_inline void rcu_tasks_trampoline_assert_none(void)
 }
 
 bool rcu_tasks_ip_in_trampoline(unsigned long ip);
+bool rcu_tasks_irq_ip_holds(struct task_struct *t);
+
+/* Record where current is being irq-preempted; 0 once it has resumed. */
+static __always_inline void rcu_tasks_note_irq_ip(unsigned long ip)
+{
+	WRITE_ONCE(current->rcu_tasks_irq_ip, ip);
+}
 
 # define rcu_tasks_classic_qs(t, preempt)				\
 	do {								\
@@ -242,6 +257,7 @@ static inline void rcu_tasks_trampoline_enter(void) { }
 static inline void rcu_tasks_trampoline_exit(void) { }
 static inline void rcu_tasks_trampoline_assert_none(void) { }
 static inline bool rcu_tasks_ip_in_trampoline(unsigned long ip) { return false; }
+static inline void rcu_tasks_note_irq_ip(unsigned long ip) { }
 # endif
 
 #define rcu_tasks_qs(t, preempt) rcu_tasks_classic_qs((t), (preempt))
@@ -262,6 +278,7 @@ static inline void rcu_tasks_trampoline_enter(void) { }
 static inline void rcu_tasks_trampoline_exit(void) { }
 static inline void rcu_tasks_trampoline_assert_none(void) { }
 static inline bool rcu_tasks_ip_in_trampoline(unsigned long ip) { return false; }
+static inline void rcu_tasks_note_irq_ip(unsigned long ip) { }
 #define call_rcu_tasks call_rcu
 #define synchronize_rcu_tasks synchronize_rcu
 static inline void exit_tasks_rcu_start(void) { }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2e7b1b3c9d2..7f0bdc81fba3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -957,6 +957,7 @@ struct task_struct {
 	u8				rcu_tasks_holdout;
 	u8				rcu_tasks_idx;
 	int				rcu_tramp_nesting;
+	unsigned long			rcu_tasks_irq_ip;
 	int				rcu_tasks_idle_cpu;
 	struct list_head		rcu_tasks_holdout_list;
 	int				rcu_tasks_exit_cpu;
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index cd3feaca6420..b372f2670d4f 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -141,16 +141,25 @@ static inline bool arch_irqentry_exit_need_resched(void) { return true; }
  * across the context switch so that it is not mistaken for a Tasks RCU
  * quiescent state.  This closes the few-instruction windows at trampoline
  * entry/exit where the trampoline's own increment has not yet run or its
- * decrement already has.
+ * decrement already has.  The interrupted IP is also recorded for the
+ * duration, for conditions that must be re-evaluated at each quiescent-state
+ * decision rather than once here (see rcu_tasks_irq_ip_holds()); nested
+ * irq-exit preemption cannot happen inside preempt_schedule_irq(), so one
+ * slot per task is enough.
  */
 static void irqentry_preempt(struct pt_regs *regs)
 {
+	unsigned long ip = instruction_pointer(regs);
 	bool in_tramp = IS_ENABLED(CONFIG_RCU_TASKS_PREEMPT_QS) &&
-			rcu_tasks_ip_in_trampoline(instruction_pointer(regs));
+			rcu_tasks_ip_in_trampoline(ip);
 
 	if (in_tramp)
 		rcu_tasks_trampoline_enter();
+	if (IS_ENABLED(CONFIG_RCU_TASKS_PREEMPT_QS))
+		rcu_tasks_note_irq_ip(ip);
 	preempt_schedule_irq();
+	if (IS_ENABLED(CONFIG_RCU_TASKS_PREEMPT_QS))
+		rcu_tasks_note_irq_ip(0);
 	if (in_tramp)
 		rcu_tasks_trampoline_exit();
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index cfe3a8e53fbd..1277603bc472 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1870,6 +1870,7 @@ static inline void rcu_copy_process(struct task_struct *p)
 #ifdef CONFIG_TASKS_RCU
 	p->rcu_tasks_holdout = false;
 	p->rcu_tramp_nesting = 0;
+	p->rcu_tasks_irq_ip = 0;
 	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
 	p->rcu_tasks_idle_cpu = -1;
 	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6337da5cab9e..cf2ea278fdf5 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -511,6 +511,48 @@ static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
 	return NULL;
 }
 
+/*
+ * True while kprobe_optimizer() is waiting for its Tasks RCU grace period.
+ * Only in that window can a preemption inside an optprobe's jump region
+ * matter to it, so kprobe_in_optimized_region() does no work otherwise.
+ */
+static bool kprobe_optimizer_waiting;
+
+/**
+ * kprobe_in_optimized_region - Could @addr be inside bytes a jump-optimized
+ *	kprobe replaces?
+ * @addr: kernel text address, typically an interrupted instruction pointer
+ *
+ * kprobe_optimizer() relies on synchronize_rcu_tasks() to wait for tasks that
+ * were preempted on an instruction boundary inside the region about to be
+ * overwritten by the optimized jump; such a task must not report a Tasks RCU
+ * quiescent state when it is preempted (see rcu_tasks_ip_in_trampoline()).
+ * This is the lockless, conservative form of get_optimized_kprobe(): it does
+ * not care whether the kprobe found is, or ever will be, optimized.  May be
+ * called from any context with preemption disabled; the kprobe hash is
+ * RCU-protected and every free path waits for a grace period after unhashing.
+ *
+ * The hash walk only runs while the optimizer is actually waiting.  A
+ * preemption that does not observe kprobe_optimizer_waiting predates the
+ * grace period (its leading synchronize_rcu() publishes the store to every
+ * interrupts-disabled reader before any task is sampled as a holdout); such a
+ * task is then an ordinary preempted holdout, and the jump is not written
+ * until it has run again and left the region.
+ */
+bool kprobe_in_optimized_region(unsigned long addr)
+{
+	int i;
+
+	if (!READ_ONCE(kprobe_optimizer_waiting))
+		return false;
+
+	for (i = 1; i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
+		if (get_kprobe((kprobe_opcode_t *)addr - i))
+			return true;
+	return false;
+}
+NOKPROBE_SYMBOL(kprobe_in_optimized_region);
+
 /* Optimization staging list, protected by 'kprobe_mutex' */
 static LIST_HEAD(optimizing_list);
 static LIST_HEAD(unoptimizing_list);
@@ -644,8 +686,12 @@ static void kprobe_optimizer(void)
 		 * to 2nd-Nth byte of jump instruction. This wait is for avoiding it.
 		 * Note that on non-preemptive kernel, this is transparently converted
 		 * to synchronoze_sched() to wait for all interrupts to have completed.
+		 * kprobe_optimizer_waiting lets Tasks RCU recognise tasks preempted
+		 * in such a region while we wait, see kprobe_in_optimized_region().
 		 */
+		WRITE_ONCE(kprobe_optimizer_waiting, true);
 		synchronize_rcu_tasks();
+		WRITE_ONCE(kprobe_optimizer_waiting, false);
 
 		/* Step 3: Optimize kprobes after quiesence period */
 		do_optimize_kprobes();
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a801ec4a951b..0e46d8fe4d8e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1127,6 +1127,29 @@ bool rcu_tasks_ip_in_trampoline(unsigned long ip)
 }
 NOKPROBE_SYMBOL(rcu_tasks_ip_in_trampoline);
 
+/**
+ * rcu_tasks_irq_ip_holds - Is @t irq-preempted somewhere that must hold off Tasks RCU?
+ * @t: a task inside preempt_schedule_irq() (t->rcu_tasks_irq_ip != 0), or not
+ *
+ * Unlike trampoline text, which a task can only be interrupted in while the
+ * trampoline exists, the bytes kprobe_optimizer() is about to overwrite with a
+ * jump are ordinary text a task may have been parked in since before the
+ * kprobe was registered, and the optimizer may start waiting while the task is
+ * already switched out.  So this is evaluated against the IP recorded by
+ * irqentry_preempt() at every quiescent-state decision -- each pass through
+ * __schedule() in preempt_schedule_irq()'s loop, and the grace-period
+ * kthread's scans -- rather than once at preemption time.  A task switched out
+ * synchronously cannot have a resume point inside such a window (a call there
+ * returns beyond it), so only the irq-exit IP needs checking.
+ */
+bool rcu_tasks_irq_ip_holds(struct task_struct *t)
+{
+	unsigned long ip = READ_ONCE(t->rcu_tasks_irq_ip);
+
+	return ip && kprobe_in_optimized_region(ip);
+}
+NOKPROBE_SYMBOL(rcu_tasks_irq_ip_holds);
+
 /* See if tasks are still holding out, complain if so. */
 static void check_holdout_task(struct task_struct *t,
 			       bool needreport, bool *firstreport)

-- 
2.55.0

