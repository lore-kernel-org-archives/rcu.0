Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6858E2CE
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066262; cv=none; b=r4zUkJKndEgpzRHpve9co0Ccj1hNNKSgCHHzkYA74V0sKcak4+qdPyHYRW8u9X+1EtzjqYxkthq/1+4XHQQ4RzoYPeNfBbNtFV0V52BFBIUGoJvoH0pceejeY4GrRKN2oLMO/SP9LYj9R7BlK1K0msCqyK5wa1ZIgEQPIxclHLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066262; c=relaxed/simple;
	bh=JGB9TElpRBgk6QzCzF9poMsfUxxS/A8RtDDCOyt7z54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IfUIaNLjMST9HRFiReWTaFe4sqFy/G6bzeT5UhNOmTyE476bPWJhyVt61I7NRJ7yIulxed4m850nztwzQ7GGgUvt/C+bYmiVMlYAKlVR2bEVf3MzLcY28KodofU68UpK4FJgsrCPechAlXv6n0kThtsMhZCLnVMugRkYVIMMxfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Ka0MeZUG; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Ka0MeZUG"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6eeso492776d6.0
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066252; x=1789671052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AwJvzjOst2er6K+UDT8eDw5lj3PdpLVthroXGjj7dNM=;
        b=Ka0MeZUG+ShhGpead4iP9O+duhA9gbSP9HyHbPYEvdJYzZPxFqV6HleLkID4gZjja7
         Zl2MdzZF0MoCLpPw9k7sAe3QhzzxW/NcH2KllXG8sqCB6rZ1jjnXmk4rfAwXIvObl9wW
         siS2GozR+X77q5xGmvXQULPYYSlvR+639QufTlIdiipbL9CkG/WznfHonhqXBHGJX2Ud
         ihhuRtZ5QatIUumWL+ASG6ntwEb0YBQxDsCmlBekG3lau1TKlCzzrDFjkcGna/cR6MnV
         s0+7hNV1jfD+/Yx5bPkjJHg0iFsCX3v1zKGQF3c3H4PvkxuVs53o3BKtH8IgAd6pPe4N
         QDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066252; x=1789671052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AwJvzjOst2er6K+UDT8eDw5lj3PdpLVthroXGjj7dNM=;
        b=s8vo6TCaeSVnYEjIQGb/NZLHq6Rri8dhWY3a41NCzoOD7X4f4UfbNasQY3UxeEqvHR
         7UbmYUWuzrI2JVulq7ehngrMBX+gDxF8q6lcjhFb1DyeE2fYRLXNVpvATQ558O74veq/
         VoFUI71SnHXKcARVQBZ0m84UGVDcJ6HvJEllTBE7vlkKPO3d0/wISmj2eQt9F/Athzsl
         aCAFJi95gkHXqz391G8KEtrPrf4sErkOUnmBMjuAa2cm82Q3+i/9SV+GjwbIj/8a5akL
         MfkT2XS1qddZPmjCpBCsGo2YIz8w5jVrdC5QhdkvntF5TjDfIOLeGOkJjZL+CFyoaceG
         h6ug==
X-Forwarded-Encrypted: i=1; AKwUvBwf2MxYmsAaMbG82NPPjYoCoOKoa7/ffpGXGKIob9fm8q1V8vUMNGz89E/8MeHCZM5k0pY=@vger.kernel.org
X-Gm-Message-State: AFuF++kihOXtAdWWB0kGQ1pataf6CieJSX/dUEzAibNRJIFV5qi2/DmU
	pUAbtiNDC+zJPV3HmeI1+mrmuQzMwq0nCjgnN+FH5inI+gOV+s6y/64dc0iCFeaBH/k=
X-Gm-Gg: AYBFou1Sazfiqsvjhs1fgZnAntG+Q21d9rWqfDeUtlkwCpDIMBh+l/g4sIuEEzpcOsb
	TEVlfi43in/Bqljc4M9MWXRb5r7SqbcpcyNmXEPqa2O8KRK9ln+tY1L0lGRBofQtOeiLDhYDts5
	IwTP+1HTLbjryzngE3nC0cliuebM+B+iEZrjbD3YU0vnaR3XPk4zqFf0HzsVyE2L4fEOQQuIXJA
	TRcOSY5Svne+aqJk5oUxjYrVVoSelt9JxlqpVeQ7/S7TRmT0E1ACAjjDSy4xUkPr2LOMEixtsH8
	iLiVyjuTPVyG2VcXeEjD45jyL6ItrcW/iIpICddBMhiu3vtbQ76iIFgwgT5r7CCXNrDfnYVOQJR
	dS0RtxjcnlleOcX5Df/ikbVY8Hq1Umn9nWPSPCi7cDyMXM1XJ/CLr9ooOvKJuDB4ZUcd1hAD3hH
	kd4k+eMiaGnbWo18CosU5zlff9SCDR0k0RNWUBTBZzSqQq6f682HpQvc4TkZ9osJy44tvQpEces
	1fzUvOXt3blcwli4FZI6+gcrJZftMSXxKXlBgfygL5KfMZFMSNqJdyHzw==
X-Received: by 2002:a05:622a:1b8b:b0:530:5ed1:561a with SMTP id d75a77b69052e-530c876e50amr12423551cf.43.1789066252311;
        Thu, 10 Sep 2026 11:50:52 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca45b61dsm239421cf.6.2026.09.10.11.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:50:51 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 10 Sep 2026 18:50:24 +0000
Subject: [PATCH RFC 01/13] rcu-tasks: Add per-task trampoline nesting count
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-1-d4469f4cc101@toxicpanda.com>
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

Nothing increments the count and nothing consults it for quiescent-state
decisions yet; both come in later patches.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/irq-entry-common.h |  2 ++
 include/linux/rcupdate.h         | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/sched.h            |  1 +
 kernel/fork.c                    |  1 +
 kernel/rcu/tasks.h               |  3 ++-
 5 files changed, 43 insertions(+), 1 deletion(-)

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

