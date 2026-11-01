Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793496647;
	b=XkZLtAf1laHfdGGBwQIrDJSfaBrF15uHQTbpGyUCsO1Npd7v1EMD6eYL3LM16pOCNbDW
	 ZYM9G+cH1PISu82O6EyRuc8zewF5iIlGwVbmDBS/i1hjBYOKNs1xy8DpDuIuQJeJfvUsA
	 7uOVRcJ6jTI8ZsGvOBWpqVanmjdGTRk1m8QyaHp7zcKv78JHDd7StFSaFOegTwDh8GyJc
	 GxGkcZiIs4D94DJXGyHoLV56bdyRKSRSxS3s/zph9aDb40XkvZgPvRWQ1ybRmQ+bTEvd5
	 YW7d+YgbNhBZDbLUP1cJFa5KzFOKxTIQ4Djkp+L/rCwLE34vs9RfTz+zjgeuivUgARA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=HKpTgsAdietgImbWPM33Hs3sIvDzrbl29q+l/XmMzoc=;
	b=DCjjEQA9NVp8ydgSa4nWnCSySuvYzGR58GWb0EMvUGfEj4plQyTFva5YlEqDBr8bTeYn
	 xvyicH7gZDrWeEQFnUBYb2+c3EvW4qXhaW/a+nCp9IIBuGRp9oGgFfn+ObFlojKmDRCer
	 sCUGke48jZ6IkpLB+TDP4maS5ZeG77+GgOpsM3IylWqv4NU35PRiOigl/6ivK/a8PtIW0
	 D9aDrLcBxrvQCGhQguWr4jBFxfH0EC5A0rQqui8QcggbqoGB4KSH/OlsKjcBh+kFXgrkp
	 /DISs/1zWAoYa9z1E/nOOr58DG/RgXcJyBxQoiNSIEece62DHH/KE1BGyKgwFo6zh1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BTG+RZM2;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283CE606A31F
	for <rcu@vger.kernel.org>; Sun,  1 Nov 2026 01:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 283CE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BTG+RZM2
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9f6a16aedso11983845ad.2
        for <rcu@vger.kernel.org>; Sat, 31 Oct 2026 18:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793496646; x=1794101446; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HKpTgsAdietgImbWPM33Hs3sIvDzrbl29q+l/XmMzoc=;
        b=BTG+RZM2xdbQ1q707/pPe1Q7+sBufQLL/wOMexWBWzDWtLevA4L8vRmK26LT2AHamY
         cIzAVZTBuqn1rXHupAwaEOnQcbqlerPMsi3EB98YF0YD0+VtCtTyy0VQrcGXpw/fnBik
         eH5yGVldbfawrH6cpOQT194fLr9WVkwg2zhxXkqF159mwVJCt5D+Opp3cg5TBZiQNDBI
         EI5H11dxfspvci5DgyIozxTWsYt0sQwssEzoc2ywqz+7mvR7xCW2cPAft4GJj8Rp4R+U
         Q+gy1AJ3Ro4JqIL7b5VvcwxiJKp8Wy2k/OHib11NqVFkfhUInQ1hL6kWZ0swIH5oCSfA
         E7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793496646; x=1794101446;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HKpTgsAdietgImbWPM33Hs3sIvDzrbl29q+l/XmMzoc=;
        b=FNlIj0Mc1PykSi/aMzhaC5zUkuGnyPwlrTYeyqlNkZunSJvm2DPiFROplr5i4PDQA3
         s1GoOzVJEHaUct61fMMOoFaCqK+9oOsA2F5zMK0FpwPfMfegpOWYss5FkZ3MEenzQfHD
         wIcl4A6c7JLDhFnqIx8lJ3MiwuTGrcqesmEoj//ItjPO1coqVizWvcg4YGxoXTfexWH1
         QAWvoGyw9vgye5kTcxPNs4XBBzda1tO/GNRsi+Wj9mSSkzWDJJgF//or4MJINHkPl5Wa
         /sv3Ril7A9t4+Mfwzc5cv5I21ASltw3hDzgF2PVm4UkRRgi2YnQkffahpMMwbqslXTZ6
         n+BA==
X-Forwarded-Encrypted: i=1; AKwUvBxw1XkKcSLPJJGK6McueGv8uaGrm0IjbwNGdfbtDKHsHVwe8xnMKuk8LKThuvK7XF11QL8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XQLzJmYeBIAY9AjE8u/9O2NgA8tGU0ub+v39A8e+GEhEMT027
	uF5DWKfY3LsCnUrCnCVj1uSM4P1Ug6ZFGPDk/3WM+BGgowgRIsPUlYio
X-Gm-Gg: AYBFou22XTH58DhjwMt8wt+Mfwta4jwDFoKF3kQPpir2HoFjZtGBsiV+c5m2oock+8f
	Vqv3B8ClUClKSBLnV4Nxk4hKKBWMQS5mCj7SSFJc6BoIaLAQL9sLVXH/D+6rKy7CmVSXgbR6AT0
	THKgwv+v7y3guXO0/s6aSkkwrXaCMCmcEekUxllrqG33Rz4nfDmZL2cfaOpbwNzWppZLsWYkQj7
	MH0YibXLTiMP9nSkf4948OiaJHgE8Bm7ZyvJR3hjv3OwnA4b+S6E0g2xYlJG3mghvUO+p3XVROx
	Ure+XPu3Xioj56M8Xu2OUhJZUf403Cm26QvM0UTPZRw++tDPGQ4DtZ8NR+ofXpQZ1ikFrdNsay2
	Q7JlS7Q19G2+HS0CwCldaFQkzlmLSLpVPgJ3uj7V8IPsoB8+GUh/aW7Fi2PDECaMJorTxnwYDgI
	yzsuP3bFLjUqeg6km5OjFSldg81nSYgqhrhk4azGWf4l5nR4DCC2vFfaFGBH+UoBFg2u7svlff+
	NBw6N7jPttd08CscFIIgh/Q1bbvjDClSTLCXlONN9jLVa+lUZmj89kGML6UGhZRE1pRLWgGjkYu
	462Au9sFiPokcz3VpCNSPxepQPhrXW8rotNw/R+7nJ3FNNNSED/VzLgCkbe/ic7Ev/+xOinZ4Xx
	IB408dUDqUzHiulcEBwM7ugXcPNh2CIc8msM=
X-Received: by 2002:a17:90b:5145:b0:3ac:9706:772c with SMTP id 98e67ed59e1d1-3ae8984cefamr5674017a91.60.1793496646286;
        Sat, 31 Oct 2026 18:30:46 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84577911sm8943687a91.7.2026.10.31.18.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 18:30:45 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 01:30:44 +0000
Message-Id: <DMJHI077QR5H.5KF9WFI089UJ@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Josef Bacik" <josef@toxicpanda.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
Cc: "Boqun Feng" <boqun@kernel.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>,
 <rcu@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/14] rcu-tasks: build Tasks RCU on Tasks Trace
 readers in trampolines
In-Reply-To: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
References: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Sep 29, 2026 at 10:07 AM Josef Bacik <josef@toxicpanda.com> wrote:
>                    Graviton4                  Xeon 8375C
>                    base   series   C          base   series   C
>   nothing          87.0    87.8   87.7        70.3    70.5   69.8
>   function tracer 103.7   105.6  105.9        87.2    88.0   88.2
>   kprobe event    215.5   215.6  216.4       119.9   123.2  124.7
>   fentry          101.3   109.7  111.3        77.0    77.9   78.3
>   fexit           118.8   136.2  139.3        78.4    80.7   80.5
>   fentry+fexit    134.1   151.0  154.5        83.2    85.6   85.5

On Graviton4, on top of the bare syscall:

                  today      the series adds
  fentry          14.3 ns     8.4 ns
  fexit           31.8 ns    17.4 ns
  fentry+fexit    47.1 ns    16.9 ns

Every fentry and fexit prog pays that on every call :(
while synchronize_rcu_tasks() is rare.

> mutex, and the hung task detector panicked the machine. The kprobe jump
> optimizer is worse in principle: it does synchronize_rcu_tasks() under
> kprobe_mutex, text_mutex and cpus_read_lock(), so one long-running
> kthread can stall static key updates and CPU hotplug for its whole run.

Not anymore.

  who waits for Tasks RCU     how                      locks in the wait
  kprobe optimizer            call_rcu_tasks()         none
  bpf detach on x86           call_rcu_tasks()         none
  bpf image and prog free     call_rcu_tasks()         none
  ftrace_shutdown() of a      synchronize_rcu_tasks()  ftrace_lock and
  dynamic ftrace_ops                                   what the caller has

The first row is
commit 06e0d3b89da1 ("kprobes: Make optprobe optimizer multi-generational and asynchronous").
The second row is
commit 424f6a361096 ("bpf,x86: Use single ftrace_ops for direct calls").
bpf on arm64 still allocates ftrace_ops per trampoline.
That's the last row.

Another idea...
livepatch had the same problem with PREEMPT_LAZY.
commit 676e8cf70cb0 ("sched,livepatch: Untangle cond_resched() and live-patching")
solved it with a stack walk of prev in __schedule().
can we do the same for a holdout task ?
A preempted task is in a quiescent state when its stack trace is
reliable and has no address in a trampoline.
On x86 ORC unwinds through the interrupt frame.
bpf_has_frame_pointer() makes it reliable through progs and trampolines.

                                   series              stack walk
  cost in a trampoline             0.8 to 17.4 ns      none
  copies of rcu_read_lock_trace()  6                   none
  hook in the irq exit path        yes                 no
  return thunks, __bhi_args        listed by hand      return address is
                                                       on the stack
  register_ftrace_direct() users   must take a reader  as-is
  implementations of Tasks RCU     2                   1
  scan of the task list            only for kprobes    as today

Then no need for patches 2, 3 and 6-13, rcu_tasks_irq_ip,
rcu_tasks_wait_irq_preempted(), etc.

  not in the diff            what it needs
  kprobe jump window         kprobe_in_optimized_region() of patch 4 in
                             rcu_tasks_stack_entry()
  trampolines in modules     the flag of patch 5 in the same place
  fexit on a long function   the task in it stays a holdout, like today
  nohz_full                  resched_cpu() for a running holdout
  rcutorture                 a reader that the walk can see
  arm64                      see below

arm64 is the hard part. arch_stack_walk_reliable() stops at an exception
boundary, because LR can be live there. So a task that an irq preempted
is never clean. A false positive is fine for this check. The walk can
report regs->pc and regs->regs[30] and go on with the frame records.
Mark has to say whether that is enough.

Patch 1 is useful on its own. It removes two smp_mb() from every
sleepable prog. Pls send it separately.

Something like this

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 15fd9ec..83cb440 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -288,6 +288,7 @@ config X86
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	select HAVE_RCU_TASKS_STACK_QS		if UNWINDER_ORC && DYNAMIC_FTRACE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if UNWINDER_ORC || STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 17d6edf..a3a33e9 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -275,6 +275,21 @@ static inline void tramp_free(void *tramp)
 	execmem_free(tramp);
 }

+#ifdef CONFIG_TASKS_RCU_STACK_QS
+extern void ftrace_static_tramp_end(void);
+
+/*
+ * ftrace_caller(), ftrace_regs_caller() and return_to_handler() keep the
+ * address of ftrace_ops, of a direct trampoline or of the caller in a register.
+ * The unwinder does not see it.
+ */
+bool arch_rcu_tasks_trampoline_text(unsigned long addr)
+{
+	return addr >= (unsigned long)ftrace_caller &&
+	       addr < (unsigned long)ftrace_static_tramp_end;
+}
+#endif
+
 /* Defined as markers to the end of the ftrace default trampolines */
 extern void ftrace_regs_caller_end(void);
 extern void ftrace_caller_end(void);
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 62c1c93..c0e8c50 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -403,3 +403,9 @@ SYM_CODE_START(return_to_handler)
 		    X86_FEATURE_CALL_DEPTH
 SYM_CODE_END(return_to_handler)
 #endif
+
+/* See arch_rcu_tasks_trampoline_text() */
+SYM_CODE_START_NOALIGN(ftrace_static_tramp_end)
+	UNWIND_HINT_UNDEFINED
+	ANNOTATE_NOENDBR
+SYM_CODE_END(ftrace_static_tramp_end)
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 44c07a6..2eb88c6 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -180,9 +180,16 @@ static inline void rcu_nocb_flush_deferred_wakeup(void) { }
 #ifdef CONFIG_TASKS_RCU_GENERIC

 # ifdef CONFIG_TASKS_RCU
+#  ifdef CONFIG_TASKS_RCU_STACK_QS
+bool rcu_tasks_preempted_qs(struct task_struct *t);
+bool arch_rcu_tasks_trampoline_text(unsigned long addr);
+#  else
+static inline bool rcu_tasks_preempted_qs(struct task_struct *t) { return false; }
+#  endif
 # define rcu_tasks_classic_qs(t, preempt)				\
 	do {								\
-		if (!(preempt) && READ_ONCE((t)->rcu_tasks_holdout))	\
+		if (READ_ONCE((t)->rcu_tasks_holdout) &&		\
+		    (!(preempt) || rcu_tasks_preempted_qs(t)))		\
 			WRITE_ONCE((t)->rcu_tasks_holdout, false);	\
 	} while (0)
 void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 332df7a..93a6a83 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -107,6 +107,20 @@ config TASKS_RCU
 	default NEED_TASKS_RCU && PREEMPTION
 	select IRQ_WORK

+config HAVE_RCU_TASKS_STACK_QS
+	bool
+	help
+	  Select this if arch_stack_walk_reliable() can walk the stack of
+	  a task that was preempted by an interrupt, and if
+	  arch_rcu_tasks_trampoline_text() reports the kernel text that
+	  keeps the address of a trampoline or of ftrace_ops in a register.
+
+config TASKS_RCU_STACK_QS
+	def_bool TASKS_RCU && HAVE_RCU_TASKS_STACK_QS && HAVE_RELIABLE_STACKTRACE
+	help
+	  A preempted task is in a Tasks RCU quiescent state when its stack
+	  has no address in a trampoline.
+
 config FORCE_TASKS_RUDE_RCU
 	bool "Force selection of Tasks Rude RCU"
 	depends on RCU_EXPERT
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6272953..69f7aef 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1089,6 +1089,44 @@ static void rcu_tasks_postscan(struct list_head *hop)
 		timer_delete_sync(&tasks_rcu_exit_stall_timer);
 }

+#ifdef CONFIG_TASKS_RCU_STACK_QS
+/*
+ * Tasks RCU protects the text outside of the kernel and of the modules
+ * (ftrace and bpf trampolines, optprobe slots) and what the arch adds.
+ */
+static bool rcu_tasks_stack_entry(void *cookie, unsigned long addr)
+{
+	if (core_kernel_text(addr))
+		return !arch_rcu_tasks_trampoline_text(addr);
+	return is_module_text_address(addr);
+}
+
+static int rcu_tasks_stack_is_clean(struct task_struct *t, void *arg)
+{
+	if (t != current && task_curr(t))
+		return 0;
+	return !arch_stack_walk_reliable(rcu_tasks_stack_entry, NULL, t);
+}
+
+/*
+ * A preempted task is in a quiescent state when its stack trace is reliable
+ * and has no address in the protected text.  __schedule() asks for current.
+ * The grace-period kthread asks for a task that waits on a runqueue.
+ */
+bool rcu_tasks_preempted_qs(struct task_struct *t)
+{
+	bool ret;
+
+	if (t == current)
+		return rcu_tasks_stack_is_clean(t, NULL);
+	if (!try_get_task_stack(t))
+		return false;
+	ret = task_call_func(t, rcu_tasks_stack_is_clean, NULL);
+	put_task_stack(t);
+	return ret;
+}
+#endif
+
 /* See if tasks are still holding out, complain if so. */
 static void check_holdout_task(struct task_struct *t,
 			       bool needreport, bool *firstreport)
@@ -1098,6 +1136,7 @@ static void check_holdout_task(struct task_struct *t,
 	if (!READ_ONCE(t->rcu_tasks_holdout) ||
 	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
 	    !rcu_tasks_is_holdout(t) ||
+	    rcu_tasks_preempted_qs(t) ||
 	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
 	     !is_idle_task(t) && READ_ONCE(t->rcu_tasks_idle_cpu) >= 0)) {
 		WRITE_ONCE(t->rcu_tasks_holdout, false);
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index b62735a..a21b76f 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -25,6 +25,8 @@
 #include <linux/interrupt.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
+#include <linux/stacktrace.h>
 #include <linux/torture.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>

pw-bot: cr
