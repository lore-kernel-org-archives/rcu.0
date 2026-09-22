Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50E38DC6C
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044009; cv=none; b=JL0FRJy1LbPLgkyRAJR9//gkXzDXaDRn7AECE7K3KW//8S+v9B5Cm/Efw8nUDfjqBliL2krsFpInCoTTX4D2jBAO+jcdLy2APDe5kBd9X9Kmsl5VmkXFWoNixkjlWYjLOxDlOeK1t/sYRBC+o4Q6gl9J1Owd5WinPUc769SCWCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044009; c=relaxed/simple;
	bh=97rXNEsO0S02JFiFJq38moNkWCht7E9TlyxYtLTVeYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RZPovecKHd7Vu8j3WjP6xqHsRmxo9suxwaRMQDvxnajt2yXLNAC0VJoSEVS8OHd6PsfgUhftNmshPe5sYRsA42D69e4hEKoyKTghCzY6Z2MMxAubnHbU1Cq2OIC8H8Pt84TOpgABDO8jnABV6qEb/Y2eam/o4QPgPZ6mjf4Mgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=XSRleOQg; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="XSRleOQg"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfa7b2093so203676885a.1
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 19:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790044006; x=1790648806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n57jpnbqR3xEpFvVL4pj+x/9TynCnpwMD9+qM+zc540=;
        b=XSRleOQgjUQzCCbGEqntpF1vr5U/KVWqAt+XGZTZyL7fS/CGUQWvFYjOql/DtI5/ub
         Nmg95FYAnqGSAU1R/dqqGGRjGJMTw12mQNR+E++vzI+/sbf8ai7wIXNQ+Lm0KJNIjGFj
         H9bd+G2Bltwo/mRIntAlADHD8ps41xJql+bya1+EyOFPjE6skdbc/Chdbp0DUN3rgl2l
         d+Zkv5KxY27DLAV4SoE8EhalcodDzL+OsYpn+N8YNQobrt7sFVqNBQPn/l4IKKv0P43O
         5O1XnoEd8Potdb0IatO8OmwzK0n4U13eXoXdtpodtRQUJcaoWuiKyygELPsQcC/1d06D
         jgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044006; x=1790648806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n57jpnbqR3xEpFvVL4pj+x/9TynCnpwMD9+qM+zc540=;
        b=qkgrRSq62La0b7L87O++aKqoGtoXWBbFz6ag95efic99PILvHM/ATHSD3Wr6OHI9oY
         jJOcvU1dUkRcqp8SNH70K/gy06SkpME+iGCRIycvHjGLVSVDzsXJjn+WHJY+ggCXyBel
         DBVH7N+D+OfB6kObUG10DorzH50T5j+Kg2Fw/VGonsLnwcehA+DSKR+co4gzU96cx5sj
         b8foBJyh33mNIrtWRiFaCJs+hyaVBG6He5ENL/3oYgCog4wdOMKAgozx3rLW60nLkypU
         MSXWG7DTa8P9chuHrnemFXbAkhTfkHePSotUD7CXX0H2lxo+2tgpsNW95ViVeP/CMf0O
         cvNA==
X-Forwarded-Encrypted: i=1; AKwUvBygxqtWB6asN0ojBWlQDT090ShrgRUq3tSuyazpEqdA6BrywEQvPwHYY2vyd3BvTdC3iac=@vger.kernel.org
X-Gm-Message-State: AFuF++kM/J7KKgUZ/5Wedrcv7MP4HANAvDi7I4gkGl3WKZ4yhoRHNclz
	YQ2z7Vaf3MMfpNsscgSSDg98/WO6YZXr2hqsfi3xOk1cu0eHi2l7zyXN7NAlWzPVolU=
X-Gm-Gg: AYBFou1trg/WQPSasm7nSDkqpZKGKM7wmh9QQBo4YiMcttnukTbN0IWXm2FjCjS7rSW
	qX1qpDbfmRfRZWR5NmKLr3UXnSOIYoJ+9TEwaoSaojoABGg9a1qEqy229c/FHXtuIi9LlDUT1+j
	hr/Ut0Jjdpy2qcRUqQlxP7fGDfJaba1gFp3jCzSYkxSG6pmgRR6KyUDXlpU/aRd1hvCVLv5Iwrf
	2cFXQ5tWwzdvCIr8qHYRUG+3bDwqqq9D6dvhcZbplrG7d0+lJt4cWGwQ1sDzZdGU+RGiAyHE8Do
	pfcX+lnNedoX/H9V2pUmrNau6DOW7U3tLihTLjyJ9FVLDIkhGuL1IaMnEKFimeUvpxqPhQxm807
	1o8H6Em9b63t0irChbygc6R7ugIZt8D24Scy02QZBQyrCuF7B1A4EtF8gYzyv6CgfudaU4qaobb
	T/MfAiV22i1Zud/QiRzOtPA+xBBg3RwGohqIGqL7zF0tD28xPZHnlvs8CWxgrbZBvGdcuBTcGdE
	mtUAJms9ELJITo=
X-Received: by 2002:a05:620a:458f:b0:939:bc7c:15c8 with SMTP id af79cd13be357-93c15e783eamr375359285a.45.1790044005713;
        Mon, 21 Sep 2026 19:26:45 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d131c4dsm21683685a.15.2026.09.21.19.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:26:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 22 Sep 2026 02:23:22 +0000
Subject: [PATCH v5 03/13] kprobes: Expose the optprobe jump window to Tasks
 RCU
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b4-rcu-tasks-preempt-qs-v5-3-410f57770bad@toxicpanda.com>
References: <20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com>
In-Reply-To: <20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790043820; l=7473;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=97rXNEsO0S02JFiFJq38moNkWCht7E9TlyxYtLTVeYI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDgns7oV6kZusWmA4JvFz3vXN+lrAHSlz7TH5kJB91LDL9uOpEUIYQaSIenbGihoBc2IuMs6vNX
 0WqfawsK3hAU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

kprobe_optimizer() is the one synchronize_rcu_tasks() user that is not
about trampoline text: it waits for tasks that were interrupted on an
instruction boundary inside the bytes it is about to overwrite with the
optimized jump, so that none of them resumes into the middle of the new
instruction.  Those bytes are ordinary kernel or module text with no
Tasks Trace reader around them, so on CONFIG_TASKS_RCU_TRAMPOLINE_READERS
kernels the irq-exit quiescent-state check has to be told about them.

Add kprobe_in_optimized_region(), a lockless and conservative form of
get_optimized_kprobe() that reports whether any registered kprobe lies
within MAX_OPTIMIZED_LENGTH before the given address regardless of its
optimization state, and have rcu_tasks_trampoline_text() consult it for
core and module text so that a task interrupted there becomes a holdout
rather than a quiescent event. The hash walk only runs while
kprobe_optimizer() is actually inside its synchronize_rcu_tasks(),
tracked by a flag it sets around the call; otherwise the check is a
single load. That check cannot see a task that was already preempted in
the region before the flag went up (possibly before the kprobe even
existed), and the new grace period does not otherwise wait for a
preempted task to run again, so before synchronize_rcu_tasks() the
optimizer calls rcu_tasks_wait_irq_preempted() to wait until no parked
task's recorded irq-exit preemption IP is inside such a region; its
leading synchronize_rcu() also publishes the flag to every (interrupts-
disabled) check in flight. The kprobe hash is RCU-protected and every
free path waits for a grace period after unhashing, so the lockless walk
from the irq-exit path is safe.

On other configurations the flag is set and cleared but nothing reads
it and rcu_tasks_wait_irq_preempted() is a stub; the classic
implementation already waits for such tasks.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/kprobes.h |  8 +++++++-
 kernel/kprobes.c        | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tasks.h      | 11 ++++++++---
 3 files changed, 65 insertions(+), 4 deletions(-)

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
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6337da5cab9e..e460fba83e4a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -511,6 +511,48 @@ static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
 	return NULL;
 }
 
+/*
+ * True while kprobe_optimizer() is waiting for its Tasks RCU grace period.
+ * Only in that window can an interruption inside an optprobe's jump region
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
+ * were interrupted on an instruction boundary inside the region about to be
+ * overwritten by the optimized jump.  Where Tasks RCU is built on
+ * reader-marked trampolines that region has no reader, so the irq-exit
+ * quiescent-state check asks this instead (see rcu_tasks_trampoline_text()).
+ * This is the lockless, conservative form of get_optimized_kprobe(): it does
+ * not care whether the kprobe found is, or ever will be, optimized.  May be
+ * called from any context with preemption disabled; the kprobe hash is
+ * RCU-protected and every free path waits for a grace period after unhashing.
+ *
+ * The hash walk only runs while the optimizer is actually waiting.  A task
+ * that was preempted in such a region before the flag went up is invisible
+ * to that check, so the optimizer first waits those out by their recorded
+ * preemption IP (rcu_tasks_wait_irq_preempted(), whose leading
+ * synchronize_rcu() also publishes the flag to every check in flight).
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
@@ -644,8 +686,16 @@ static void kprobe_optimizer(void)
 		 * to 2nd-Nth byte of jump instruction. This wait is for avoiding it.
 		 * Note that on non-preemptive kernel, this is transparently converted
 		 * to synchronoze_sched() to wait for all interrupts to have completed.
+		 * kprobe_optimizer_waiting lets a reader-marked-trampoline Tasks RCU
+		 * recognise tasks interrupted in such a region while we wait, and
+		 * rcu_tasks_wait_irq_preempted() (a no-op elsewhere) first waits
+		 * out any that were preempted there before we said so; see
+		 * kprobe_in_optimized_region().
 		 */
+		WRITE_ONCE(kprobe_optimizer_waiting, true);
+		rcu_tasks_wait_irq_preempted(kprobe_in_optimized_region);
 		synchronize_rcu_tasks();
+		WRITE_ONCE(kprobe_optimizer_waiting, false);
 
 		/* Step 3: Optimize kprobes after quiesence period */
 		do_optimize_kprobes();
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f03be742be48..eb1388dd8a61 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1005,7 +1005,9 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
  *    trampolines, kprobe slots and other dynamically allocated text; this
  *    deliberately does not ask is_ftrace_trampoline() and friends, since
  *    text being torn down may already be unregistered there);
- *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text().
+ *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text();
+ *  - the bytes after a kprobe that a pending jump optimization is about to
+ *    overwrite, the one synchronize_rcu_tasks() user with no trampoline.
  *
  * A false positive only makes the task a holdout until its next quiescent
  * event.  Called with interrupts disabled from the irq-exit path.
@@ -1013,8 +1015,11 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
 bool rcu_tasks_trampoline_text(unsigned long ip)
 {
 	if (core_kernel_text(ip))
-		return arch_rcu_tasks_trampoline_text(ip);
-	return !is_module_text_address(ip);
+		return arch_rcu_tasks_trampoline_text(ip) ||
+		       kprobe_in_optimized_region(ip);
+	if (is_module_text_address(ip))
+		return kprobe_in_optimized_region(ip);
+	return true;
 }
 NOKPROBE_SYMBOL(rcu_tasks_trampoline_text);
 

-- 
2.55.0

