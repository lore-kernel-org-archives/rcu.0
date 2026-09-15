Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B25496D56
	for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478281; cv=none; b=ji+JxedqXPGhL0s7gnRaUxUZey81Z755vhuOTljnW1Qv3cJKdnxAeIZVEqkinyJCgPg8jLlH+GiKbb/S4ZeQi84opuHX4597yBcctBv7DhdRTGmBNnXta/zF9NoC/JBV1/1LnGAroNtALd8Frh1cWPPltV5cBGOI8Fdm1DtgkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478281; c=relaxed/simple;
	bh=Fqdt5J86rRS/oaPi1G1Rp34bXnNDaywOKyZCOJUFY5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SDhm5ha2WHwXtKXEkY9LjXrlzf039m/EgFH9ngT06kCxVSDOZEbMMUNgqGwpLl/jmla9OAc/kivcauePPrOJ93jzfYKHbl9bKKITl4Z/6DF67zmiolc6csPlnJ/6GFPeO16IvxdZmJhn6Bnjp8Cmh3LSPhj8WlLJfvnkEcjaqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=CRhRb+l2; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="CRhRb+l2"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6e3so43668386d6.1
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789478277; x=1790083077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2aqKzOffwJC2uJ3O0Ky+yGqpaXXawvJtULMY2mEOoI=;
        b=CRhRb+l23DQePZUfpwq1XxVnI66GKrnWw/Sp+VmaStShbBHtAvSQz0pD00cggntvJB
         mcZtQleGxGo5SQIwuZXUmaM7+7GMRgGeFlgvxvCBL3vzDIkFp+TCJ6gNGSVczMdwFLjR
         fE4ZSPkpyF5mIkODxWjEPvC0M0KBGTdqi6sa93a1rswGCT9KvaIq4n3wyAGKeX9FtwdM
         KBiHjCcruG0s9eWqANmS/e+MhyTp5JbxP+XJQZ2F5Ykt4J1++3gU8eQ/SipGhHXljQdD
         GYe+8n6VluaHH/c2TducimjYxo0VqJChAdUp4+TGxEuVuuBoDSRmUasCpEXm4/Il61Gb
         xbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478277; x=1790083077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2aqKzOffwJC2uJ3O0Ky+yGqpaXXawvJtULMY2mEOoI=;
        b=MUFQOh4UMfR9tcM+AKH2bpoL8co3at5tVyTb6WWrIe/JibNO5QnrNxVsYNd2ClWF91
         B3mdXHAbHsHkieDYDP+40GfpG5mkuLU+cQmXJeIeoBHPjlbdFH4aeaUWY1mNiiqlDog3
         JvyhTMa30JDV5bVV1+FO3aEQICaD8zL+KhQ2mwjOavYJYL/59fINRUAEtbTXSrdX857w
         ZPq25D8saEjqqwhK3M/hCOgAaYKOxzflplGKtI66SFQesRtN3Kfwc3TMhhs7b85Z3gGM
         iKhV+j38T1I9oOk9OPogvBRziCUb7IvK14qe2hVZrrkkE/EmKMw/32LRdpdpjQWbL4P9
         eJFA==
X-Forwarded-Encrypted: i=1; AKwUvBxQFnFGS0++u8MvhKEHIGHqXQINmVRDLFxOmf4a0cM9+lgMoJpdRLd98IvT0+y5hc020vA=@vger.kernel.org
X-Gm-Message-State: AFuF++nC2UPOMBUCpBJBb6+ohTlq4X+cEZPcP/q/YZkZceYntNNqV8Ka
	GzW6WuD7KLNNWqK9qwjoKMqyccpsP1vgU+ropPH03Gp0bOR0O/vk9hJF63zt9GproGE=
X-Gm-Gg: AYBFou0PMA2tjN5HqtPOJzfFnIxyoQLCGFEHlaeEaxT5716LUr5OCqfbuHtYxai6NSc
	L8s8ihA8QaEMkCEy8TA8QY2U+GFCH6dKkgjjCmfXIitKLhyDJqlVuf+ungQtxJknootVZQO1Uwi
	7yxpisqRf7mRkn09+Dmc6Bg1++9+Tv1Er3D0nJ8d+Ks+2GMjtYaaJRPUg+ez6fQ/+jWMblaD/UU
	tM3yJ3R2RSX9R0kRkti7Q/zPHdAKmRpyD9QIB4ayXp1qV2zVm0b/JOkGFLI7PV7YyfczE9wouik
	A/o2BaiiD4FlvLAZnbFFLMHlw6gWCaq2u6gOvNcmC24GzYqW/SJbtzAaIxf3MlobMLSaGMpOUjF
	LyjUZzPYMuadd8WB9HfvBThUHVXB8GbJMa08c0qLsK17BtZJFdKsQl++GhvHcStEcRc/5kH1QPL
	2eFVU61WIVVU6FbNx1KnffIVBLxdfCfb7ggUwQPKmQJJxtDFQ0/9kYSqhKy3uVXoPSmFILTSXPM
	goWZN2NeFivvqBvcVpUTAZBfEhKtp1RMMXmUkLo3HexjDV+wTHyw6hWYCZJw/URnrc=
X-Received: by 2002:a05:6214:4285:b0:90e:873f:112b with SMTP id 6a1803df08f44-9122e51912amr113387396d6.16.1789478276555;
        Tue, 15 Sep 2026 06:17:56 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45a780sm120563676d6.10.2026.09.15.06.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:17:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 15 Sep 2026 13:17:32 +0000
Subject: [PATCH RFC v3 05/13] ftrace: Mark modules hosting direct-call
 trampolines for Tasks RCU
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-rcu-tasks-preempt-qs-v3-5-0ad30c4c5ee7@toxicpanda.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789478262; l=7194;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Fqdt5J86rRS/oaPi1G1Rp34bXnNDaywOKyZCOJUFY5s=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFK/UccVcmZvo9+nJV8bUtDnpQLusVqacik5jCxxwwehteVs8AbBeSvZttSzdRt3+dA+Fv7F8p7
 qiOCn2ZKvEwc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

An out-of-line direct trampoline registered with register_ftrace_direct()
is kept alive only by Tasks RCU while a task executes it or is preempted
in something it called; ftrace_shutdown()'s synchronize_rcu_tasks() is
what stops rmmod freeing it under such a task.  Where Tasks RCU is built
on reader-marked trampolines, such a trampoline must be a Tasks Trace
reader across its call-out like the ftrace and BPF trampolines are, so
document that in register_ftrace_direct().

That still leaves the few instructions before the reader is entered and
after it is left.  For BPF images those are in dynamically allocated
text that rcu_tasks_trampoline_text() already treats as unmarked
trampoline text, but the in-tree samples (and any similar user) place
their trampolines in module .text.  Add a sticky
module::ftrace_direct_tramp flag, set by every register/modify path when
the direct address is module text, and have rcu_tasks_trampoline_text()
treat a task interrupted anywhere in such a module as a potential
holdout.  Other modules' text is unaffected.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/module.h |  7 +++++++
 kernel/rcu/tasks.h     | 21 ++++++++++++++++++---
 kernel/trace/ftrace.c  | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..28488687cb01 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -521,6 +521,13 @@ struct module {
 	unsigned int num_ftrace_callsites;
 	unsigned long *ftrace_callsites;
 #endif
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	/*
+	 * An ftrace direct-call trampoline lives in this module's text; see
+	 * rcu_tasks_trampoline_text().  Sticky once set.
+	 */
+	bool ftrace_direct_tramp;
+#endif
 #ifdef CONFIG_KPROBES
 	void *kprobes_text_start;
 	unsigned int kprobes_text_size;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 866768462850..ec54a27e47fa 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1007,6 +1007,8 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
  *  - the .text..rcu_tramp section, C glue called directly from such
  *    trampolines before it has entered the reader;
  *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text();
+ *  - the text of a module that hosts an out-of-line ftrace direct-call
+ *    trampoline (see ftrace_direct_mark_module());
  *  - the bytes after a kprobe that a pending jump optimization is about to
  *    overwrite, the one synchronize_rcu_tasks() user with no trampoline.
  *
@@ -1015,6 +1017,8 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
  */
 bool rcu_tasks_trampoline_text(unsigned long ip)
 {
+	bool ret = true;
+
 	if (core_kernel_text(ip)) {
 		if (ip >= (unsigned long)__rcu_tramp_text_start &&
 		    ip <  (unsigned long)__rcu_tramp_text_end)
@@ -1022,9 +1026,20 @@ bool rcu_tasks_trampoline_text(unsigned long ip)
 		return arch_rcu_tasks_trampoline_text(ip) ||
 		       kprobe_in_optimized_region(ip);
 	}
-	if (is_module_text_address(ip))
-		return kprobe_in_optimized_region(ip);
-	return true;
+
+#ifdef CONFIG_MODULES
+	scoped_guard(rcu) {
+		struct module *mod = __module_text_address(ip);
+
+		if (mod) {
+			ret = kprobe_in_optimized_region(ip);
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+			ret = ret || READ_ONCE(mod->ftrace_direct_tramp);
+#endif
+		}
+	}
+#endif
+	return ret;
 }
 NOKPROBE_SYMBOL(rcu_tasks_trampoline_text);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 53d5db60bfa5..efc4a518658a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6076,6 +6076,29 @@ static void reset_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->trampoline = 0;
 }
 
+/*
+ * A direct trampoline may live in module text rather than in dynamically
+ * allocated text that rcu_tasks_trampoline_text() recognises on its own (see
+ * samples/ftrace/ftrace-direct*.c).  The trampoline itself must be a Tasks
+ * Trace reader across its call-out (see register_ftrace_direct()); marking the
+ * owning module here covers the instructions before it enters that reader and
+ * after it leaves it, where a task interrupted in the module's text must not be
+ * counted as Tasks-RCU quiescent, so that ftrace_shutdown()'s
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
+ * select HAVE_RCU_TRAMPOLINE_READERS, Tasks RCU only waits for such a task if
+ * it is a Tasks Trace RCU reader, so the trampoline must enter one
+ * (rcu_read_lock_trace() or its assembly equivalent, see
+ * samples/ftrace/ftrace-direct.h) before calling out and leave it before
+ * returning, as the ftrace and BPF trampolines do.  The few instructions
+ * before and after are covered by the irq-exit check: automatically for
+ * trampolines outside kernel and module text (e.g. BPF images), and via
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

