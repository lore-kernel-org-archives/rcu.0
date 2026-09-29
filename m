Received: from mail-qk2-f26.google.com (mail-qk2-f26.google.com [74.125.230.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285D33AEF3F
	for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701904; cv=none; b=pOs0AiiHlpbZZvxMZRBpaAFJFDXHLc7mN80Z9rifw2c+8AesUqK8IE7i7BW09hs31JiCjG2bHX8zPSMzpPmA5OVxvTTXDwsQKzXYILk7ZOlG6kcVtlv5WPTF5yj7XMAeZtHUpq3lE4S3v8K1QA0ICsS51gggAhXFOpFxkbQV9+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701904; c=relaxed/simple;
	bh=4m3DMCCQmxfOOA6Fvpy5MI/pSHBQI92PlwZVm0x7Dhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dMMpOMtgBPWK6lQ1z+6W00vfror+eDJPlt8A7ZO8t1zNxy8/HXQhBvbk4ZxUJKRBj2RwKZ02Cs0JXdZryByfUNhlxrPsvXzHcvueTGcKp/+J1iO/9g8h/4bcl/FHCdyaB5ztWU38oikPoNppP5swVk3x0ps+A13smt9aBywioOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=FboG0nXN; arc=none smtp.client-ip=74.125.230.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="FboG0nXN"
Received: by mail-qk2-f26.google.com with SMTP id af79cd13be357-93a0299c787so270719685a.1
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790701902; x=1791306702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWhOl0BO9x9ME0YpBU8lqtkNCs3GopTTt9A3OXiCl+k=;
        b=FboG0nXNu0xjDZY4iU2Hw3Xpw+174ArzPflK4cn8XNl+uSrhl8ll6NnAZ+V2RrjIbV
         utZeADFC8ccI7oIthxAXZO3uOrpnzhXITGMsCS1QfYTZK5vDXl/u5tTQN4Jxq6rFEJ//
         k4JqReMy58bXKqQ15PaV4CUcDmiObBfGFJxvNut0gj8fVxwrmdb3F7IO8y7tlITpcjZY
         RjXBsfHy3kHPLlV6SVkAuEzEn8YbKrlX104xXY7m1reFnFdoqPkPw7d9f8SuVhZDd+Z+
         4zO+9uasVVMlKQWrG5EscLZHLvV3CwzF/GKJNVDgYPC22y/mT87eW4aPbRxV7xYHOIO6
         JTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790701902; x=1791306702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWhOl0BO9x9ME0YpBU8lqtkNCs3GopTTt9A3OXiCl+k=;
        b=1M0fJ4Rl24OEgcAHj3qEMVoFUl55rr5yuFObffIyMmx6GIvB3BXtfcIdydfKrt9BsW
         sfyMgTXBvvuWMVn69wFvkr/3+Rqjf8EFsX20mCkKRZJEZVw7LrfBjwCaie55TtJseUwG
         tB+mf0qx2BZpZpddixU8P4ET9EbRkzhmgk+tgc20f2eIECCOGr4kZiWYTot3775OQkhj
         b2kYiz0Ac7AFZi1kZA73AgaBGGd6vaVqcKWgkhxnEnI1pyD9NyV0qNaPpEH/1XbyaVC0
         l0XjpnGtSS4XIi0fI2R9iSciKS0l9g8PXZT6wKRclQf3y+qLQ4sBa2dTsT41+6RH1kjp
         UJRw==
X-Forwarded-Encrypted: i=1; AKwUvBz6MYC/mRu7jmGJHDFoQT/W4XeF89OeHIKevkMS6Sseryi6NwFgRqNZeTpChY4K9LabT0g=@vger.kernel.org
X-Gm-Message-State: AFuF++kalrf/5f51+CKT+bglR4cqDKQu3us5alBgRyFe8p3OXRyPdrJZ
	oClc1JRaas+btdIxi7rBDsz8TnXyCDO0f6HOnDb9MIlToFFIhJMEQtXJdZ+84dOJ0f4=
X-Gm-Gg: AYBFou1qnep92yz7oQ6i5v3I8qrPjuAajVKhmSGZG6Djo7qm/Y9UuGc+dwhnFZZVZDx
	0mLtfShm69eaGO/P+RTd4+l1/K0lOyJvj46nfbcQv1rl+eOfBTvlV/Q0iX+d4jIC2mmPHuXza+p
	GjEIC+/GxtpRtn8KoMZ6UCJ5mTlh+qNgzbvVP35RYvPjmNw/S7QGG6VZ7AcoMK92yRE70Jqv0yx
	mTrTDEKdM3IRQjrmzkm33LNXQ4384vb2m5nm8PQZPEzOob4OVbsfoEVCkmKSv4tdd1fNL+Rtg2S
	oO9YwsejP3+xKumz0AVIxDvV0nB8w3+6IXgdnutA0FILVDfmz+9vago4PwKQxoNiJkgVPp/uxWl
	roIxFRc8+1HH+Lt4irEc32Qlv5j1C7hNGoe6uV/396nvrILb9qpY/PG2vA0gBrQ/2OSqnKWDVpL
	1iiF2m0vNDKfjG0tLxBDoH/ZvnU85iXOi4pR2cQiXgZAGBqkiUX7Q7ibZcRQHN7O8IRhTMxyX+M
	Z22zfysCSeOsKs=
X-Received: by 2002:a05:620a:808c:b0:939:6dea:4f1a with SMTP id af79cd13be357-93c9fa9f5dcmr32032585a.48.1790701901901;
        Tue, 29 Sep 2026 10:11:41 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f4bfdd4sm16724185a.23.2026.09.29.10.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:11:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Sep 2026 17:07:22 +0000
Subject: [PATCH v6 05/14] ftrace: Mark modules hosting direct-call
 trampolines for Tasks RCU
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rcu-tasks-preempt-qs-v6-5-c111ee02caca@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790701681; l=7063;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=4m3DMCCQmxfOOA6Fvpy5MI/pSHBQI92PlwZVm0x7Dhg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMMoMYZRQwW06l0AxuXntx6A/gYFpIu/nn0GASboMvYOYbCakPG+Ly6xLjVXIW3ZujZlLuhAq2K
 Nwq7u1wj4GQw=
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
module::ftrace_direct_tramp flag (under CONFIG_TASKS_RCU_TRAMPOLINE_READERS,
its only consumer), set by every register/modify path when the direct
address is module text, and have rcu_tasks_trampoline_text() treat a task
interrupted anywhere in such a module as a potential holdout.  Other
modules' text is unaffected.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/module.h |  7 +++++++
 kernel/rcu/tasks.h     | 18 +++++++++++++++---
 kernel/trace/ftrace.c  | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..82ca4f774725 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -521,6 +521,13 @@ struct module {
 	unsigned int num_ftrace_callsites;
 	unsigned long *ftrace_callsites;
 #endif
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
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
index 3f127e47ffc2..d3bd06ad362b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -997,6 +997,8 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
  *    deliberately does not ask is_ftrace_trampoline() and friends, since
  *    text being torn down may already be unregistered there);
  *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text();
+ *  - the text of a module that hosts an out-of-line ftrace direct-call
+ *    trampoline (see ftrace_direct_mark_module());
  *  - the bytes after a kprobe that a pending jump optimization is about to
  *    overwrite, the one synchronize_rcu_tasks() user with no trampoline.
  *
@@ -1005,12 +1007,22 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
  */
 bool rcu_tasks_trampoline_text(unsigned long ip)
 {
+	bool ret = true;
+
 	if (core_kernel_text(ip))
 		return arch_rcu_tasks_trampoline_text(ip) ||
 		       kprobe_in_optimized_region(ip);
-	if (is_module_text_address(ip))
-		return kprobe_in_optimized_region(ip);
-	return true;
+
+#ifdef CONFIG_MODULES
+	scoped_guard(rcu) {
+		struct module *mod = __module_text_address(ip);
+
+		if (mod)
+			ret = READ_ONCE(mod->ftrace_direct_tramp) ||
+			      kprobe_in_optimized_region(ip);
+	}
+#endif
+	return ret;
 }
 NOKPROBE_SYMBOL(rcu_tasks_trampoline_text);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 53d5db60bfa5..f69f71591358 100644
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
+#if defined(CONFIG_MODULES) && defined(CONFIG_TASKS_RCU_TRAMPOLINE_READERS)
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
+ * (rcu_read_lock_trace() or an assembly equivalent) before calling out and
+ * leave it before returning, just as that option requires of the in-kernel
+ * ftrace and BPF trampolines.  The few instructions before and after are
+ * covered by the irq-exit check: automatically for trampolines outside kernel
+ * and module text (e.g. BPF images), and via ftrace_direct_mark_module() for
+ * trampolines in module text.
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

