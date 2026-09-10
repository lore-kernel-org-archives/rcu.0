Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8925921EB
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066285; cv=none; b=XMLlDB2UPJkk11ZyK029M9LVMy1cd2x50VFWuFirV631tew3ArKWu0bLkrAsxgAhIuK2xMNscdSfBV+IWQPfcVjBx7py6OoWtqUEzWrPsyIkqSL839X0SanVu2puAfsPA2Nm1GmZG3ux+mn7g9hDulZuAid10DtLwlFWbiU1evQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066285; c=relaxed/simple;
	bh=wax+gU4S8O6EbLEMHcnuQdChZkiSg/zKdiccnkmuOZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nwm+EzSgHw0lh46fz/C/vs1kehGCLdOyB7E6sOiXB+dm90y7c2MKR2+qkwxrsGT5JkwUxcjoZiq1Zo4GjZCeVsXYISItHgU8pYdl9oLayvz9AnbSgUX26ws7LYgTsiXygHyGNRG/SWZhoQ0mzPgitkpz/8YQqOq11Iidpfg6AWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ldBeSrvU; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ldBeSrvU"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90e9ad1a373so10592676d6.0
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066265; x=1789671065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+J5TsPokEtcBZgoC4/eVwMDHhzV3+rip9BUfjH6oWiE=;
        b=ldBeSrvUxVNb7Y5K16ZhxBJ9p40Z8BbyByYl4M3OQ2gd1bmrC/tzKfA3AG+8F+Hbuj
         PqBJ+o18lsLKlM5nYx2AzEH2A30UZAcVaq0ncOPL5VQIC6T+f17MByccvbFc+ZaHz4SM
         wN8qKURchxN1JJgJ6RIkMNJmwq8HEVITX9ILf4h4W0y1IXC6ALMFqcLa3utKTWWbBbbK
         q2gCrxY0s9RdEnOCr2fnPmq7uiQ1/bOGayXJ23sEbU8GP0DxHHU/MixPjkJ4OV86l/Va
         lECo5PBObfT6muAsyPnkkbUnz8bg8OGeQe2aCnXerGl1nuPTLQBA6MK0kC4OxcsVvZnO
         A1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066265; x=1789671065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+J5TsPokEtcBZgoC4/eVwMDHhzV3+rip9BUfjH6oWiE=;
        b=WLLIkCkAlspFDk2oJpYzHyA42TdsjKRH24TCjv4zMwEWgDXQhfqEa+GwHsYKKUWlbA
         PDRDGZ73hGOT/yXRhwPa59QRJzLoy+72hpMhnDtiWPA76Rjm/pecDBEIA/pmc/ZVhR9t
         oHCC9kfIwS34cq/vsXfPYPlzRHBfDLbLYvYrh4NxGNqtvZ7ns6Tt23NefA4wQXmkmb23
         nkk//eVtUA0MzuuKLBh34q1O8mb8MTQbdnfppbTnjqInWvCNr1VC7TQCVPfG56Nn3sTQ
         rJZo+fH8FjZTinWEaFYvF2p5lvAvYJ7gtOr9DYTnzUgrIosu8lVwZzXxqips76y4ZnUJ
         RVqQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7Ax+GkYNnNzb7HPslM62vHk3HvI1YTEVwn1CxuGYtFUmJIcmg1c2icN5ASWwbYphfpM0=@vger.kernel.org
X-Gm-Message-State: AFuF++l2Gy8JmbsL51d6H7U52ZvC+LOBZPmnhFWkv1PgGNYiTc4jQq1i
	0C0lqPi6EkHoC/W0XslvEPS+Ne1DYS/XdoK4qgqOPi5D1ms4hU/B5q8uGhAxIHDIRHo=
X-Gm-Gg: AYBFou0QhT+YZZacjpSpN9r3v+iVQgLSK7nFkIslGpGOrSkGcdfI5P7Ksgq636rxBXz
	MQeyBPrFa8H6AcYCi6ZtTDkuzkxO6wjngfcR+koL4qxz1BBUJxl2nWreZ/qB5ItyG9Z4mo5LL9e
	H4QqrvH7ZtKlBKYtKv09/xtlzf7gep3lHsSZp155w0nt5o/sT6oXP2EIoHfGPqng4qdPrmc9Z2T
	Rrf1Ml1VQYosYzzTDKxZuFN6FSTUhn4tnbfIdg6sR7DJV9J4pG8Miz/lxAX31sKCBPpIvFBp0Z9
	jLgV+orGao5EKY0zoHJBaZs3eINneo1s2sC/qanr1ZeIeuOnIaOgsYvIbJgDpo0WqN9BAngKGlb
	Kr/wjvBhx4SBnEXk2E+PkwY2pDk4BTNQbbz7393zUrlVwleRb1OOFewM3Bk2x4aPeyo+dPPolVB
	+x267geJQjQJP6Yu7OTByQzTM685InIt6U26p8pL2q7iO1kAbhGhQL0zsfFGve805WDldfQTVcz
	cXYqWk95PZvGpJicj+pTyjNmJXKVkPS2rRO10i8h7XuRt5gZSJfqeNW
X-Received: by 2002:ac8:6f19:0:b0:530:4773:113d with SMTP id d75a77b69052e-530b35ec4f6mr85380621cf.27.1789066260401;
        Thu, 10 Sep 2026 11:51:00 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca45bbd7sm230971cf.8.2026.09.10.11.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:50:59 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 10 Sep 2026 18:50:28 +0000
Subject: [PATCH RFC 05/13] ftrace: Mark modules hosting direct-call
 trampolines for Tasks RCU
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-5-d4469f4cc101@toxicpanda.com>
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

An out-of-line direct trampoline registered with register_ftrace_direct()
is kept alive only by Tasks RCU while a task executes it or is preempted
in something it called; ftrace_shutdown()'s synchronize_rcu_tasks() is
what stops rmmod freeing it under such a task.  Once preemption becomes a
Tasks RCU quiescent state, such a trampoline must hold
current->rcu_tramp_nesting across its call-out like the ftrace and BPF
trampolines do, so document that in register_ftrace_direct().

That still leaves the few instructions before the increment and after
the decrement.  For BPF images those are in dynamically allocated text
that rcu_tasks_ip_in_trampoline() already treats as protected, but the
in-tree samples (and any similar user) place their trampolines in module
.text.  Add a sticky module::ftrace_direct_tramp flag, set by every
register/modify path when the direct address is module text, and have
rcu_tasks_ip_in_trampoline() treat a task interrupted anywhere in such a
module as a potential reader.  Other modules' text is unaffected.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/module.h |  7 +++++++
 kernel/rcu/tasks.h     | 23 +++++++++++++++++++++--
 kernel/trace/ftrace.c  | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..ea4727f53fab 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -521,6 +521,13 @@ struct module {
 	unsigned int num_ftrace_callsites;
 	unsigned long *ftrace_callsites;
 #endif
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	/*
+	 * An ftrace direct-call trampoline lives in this module's text; see
+	 * rcu_tasks_ip_in_trampoline().  Sticky once set.
+	 */
+	bool ftrace_direct_tramp;
+#endif
 #ifdef CONFIG_KPROBES
 	void *kprobes_text_start;
 	unsigned int kprobes_text_size;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a55dc2a20fb7..df68a330769a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1117,19 +1117,38 @@ bool __weak arch_rcu_tasks_ip_in_trampoline(unsigned long ip)
  *  - inside the bytes following a registered kprobe that jump optimization
  *    may overwrite, which kprobe_optimizer() protects with
  *    synchronize_rcu_tasks();
- *  - in core text the architecture flags via arch_rcu_tasks_ip_in_trampoline().
+ *  - in core text the architecture flags via arch_rcu_tasks_ip_in_trampoline();
+ *  - in the text of a module that hosts an ftrace direct-call trampoline,
+ *    which covers the instructions before that trampoline's increment and
+ *    after its decrement (see ftrace_direct_mark_module()).
  *
  * A false positive only defers the quiescent state to the task's next
  * context switch.
  */
 bool rcu_tasks_ip_in_trampoline(unsigned long ip)
 {
+	bool ret = true;
+
 	if (kprobe_in_optimized_region(ip))
 		return true;
 
 	if (core_kernel_text(ip))
 		return arch_rcu_tasks_ip_in_trampoline(ip);
-	return !is_module_text_address(ip);
+
+#ifdef CONFIG_MODULES
+	scoped_guard(rcu) {
+		struct module *mod = __module_text_address(ip);
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+		if (mod)
+			ret = READ_ONCE(mod->ftrace_direct_tramp);
+#else
+		if (mod)
+			ret = false;
+#endif
+	}
+#endif
+	return ret;
 }
 NOKPROBE_SYMBOL(rcu_tasks_ip_in_trampoline);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 53d5db60bfa5..14f27b887231 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6076,6 +6076,29 @@ static void reset_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->trampoline = 0;
 }
 
+/*
+ * A direct trampoline may live in module text rather than in dynamically
+ * allocated text that rcu_tasks_ip_in_trampoline() recognises on its own (see
+ * samples/ftrace/ftrace-direct*.c).  The trampoline itself must hold
+ * current->rcu_tramp_nesting across its call-out (see register_ftrace_direct());
+ * marking the owning module here covers the instructions before that increment
+ * and after the decrement, where a task interrupted in the module's text must
+ * not be treated as Tasks-RCU quiescent, so that ftrace_shutdown()'s
+ * synchronize_rcu_tasks() still keeps the module text from being freed under
+ * it.
+ */
+static void ftrace_direct_mark_module(unsigned long addr)
+{
+#ifdef CONFIG_MODULES
+	struct module *mod;
+
+	guard(rcu)();
+	mod = __module_text_address(addr);
+	if (mod)
+		WRITE_ONCE(mod->ftrace_direct_tramp, true);
+#endif
+}
+
 /**
  * register_ftrace_direct - Call a custom trampoline directly
  * for multiple functions registered in @ops
@@ -6090,6 +6113,17 @@ static void reset_direct(struct ftrace_ops *ops, unsigned long addr)
  * and save the parameters of the function being traced, and restore them
  * (or inject new ones if needed), before returning.
  *
+ * Nothing but Tasks RCU keeps the trampoline at @addr alive while a task is
+ * executing it or is preempted in something it called.  On architectures that
+ * select ARCH_HAS_RCU_TASKS_PREEMPT_QS a preemption is a Tasks RCU quiescent
+ * state unless current->rcu_tramp_nesting is non-zero, so the trampoline must
+ * increment it before calling out and decrement it before returning, as the
+ * ftrace and BPF trampolines do (see rcu_tasks_trampoline_enter() and
+ * samples/ftrace/ftrace-direct.h).  The few instructions before the increment
+ * and after the decrement are covered by the irq-exit IP check: automatically
+ * for trampolines outside kernel and module text (e.g. BPF images), and via
+ * ftrace_direct_mark_module() for trampolines in module text.
+ *
  * Returns:
  *  0 on success
  *  -EINVAL  - The @ops object was already registered with this call or
@@ -6169,6 +6203,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->flags |= MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
 	ops->direct_call = addr;
+	ftrace_direct_mark_module(addr);
 
 	err = register_ftrace_function_nolock(ops);
 	if (err)
@@ -6237,6 +6272,8 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	lockdep_assert_held_once(&direct_mutex);
 
+	ftrace_direct_mark_module(addr);
+
 	/* Enable the tmp_ops to have the same functions as the direct ops */
 	ftrace_ops_init(&tmp_ops);
 	tmp_ops.func_hash = ops->func_hash;
@@ -6419,6 +6456,7 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
 			if (__ftrace_lookup_ip(direct_functions, entry->ip))
 				goto out_unlock;
+			ftrace_direct_mark_module(entry->direct);
 		}
 	}
 
@@ -6702,6 +6740,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 			tmp = __ftrace_lookup_ip(direct_hash, entry->ip);
 			if (!tmp)
 				continue;
+			ftrace_direct_mark_module(entry->direct);
 			tmp->direct = entry->direct;
 		}
 	}

-- 
2.55.0

