Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B838F954
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044452; cv=none; b=IhU6PCYzEmg28nvuU2hyQFWfCkf66OHqt1QlTrhpIFiRdzfe4UXx80lq0gk7doM5KFr9Ej5iTqFcaB79ND2zHbPR/9oklx2TNSZZR1vxUIktNrBTeAegzEFg45mcXLJeFnfwRNHQo7ojt1QeAXDeEaQAbbxTe6An/id0v7Yx9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044452; c=relaxed/simple;
	bh=EMsOGg9VRxBcocei3P3dGUkU8foVu6cO35v23va9IOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8JwkLEjLIPBWuKUN6gnY8aOChGZuhqy6SBmXO7y0ONqXI6zjc3H4adBrBxcExPYjFMJhn7pVN4tVzzr67zoSyiWld6HAuBUAQF8Z7sUxA7UD2hbcXeGtE3aBDlxgKwRzOd7fobnRUVwrkakmrIc1RSj1sGZ/NLwOB4sZlAifow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=gxu6iCps; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="gxu6iCps"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9104e54b1abso49337416d6.1
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 19:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790044448; x=1790649248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vixDe7y/8fdtCmwAQ+Tlt/gsuGiEiA9j8JVU0h22FWI=;
        b=gxu6iCpsUuLPXgYUiCTsOhdCO0oUcbJMBjMPpP+jv0eOHhhCXhGwUeIs2HbNQ20DHx
         74qKmviwa3RDrCJ7/9SzC3LYu0B9qZiq+5geSmAmd1lXncRixovrhMmqKpR0VohQ1W0Q
         jTaNOe2nZxjJVrveqr8GHCCcHdZWmjGs5eqXGSVA08vZ/Cy4PVwRnkqczI8d4de7SEBh
         PIl1D3KJ8rVTur1Y2QIIEAXJZviOyS0YuCtPLU/DFmzblAiFHYxUvd3ejTUgCcd4nLFr
         qGMy8pp96s6aeeS5/W0b4ATIkBgLliiR2U1+mMJ7ruU1y5jxhOgCgcRf219wL53YetDD
         dafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044448; x=1790649248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vixDe7y/8fdtCmwAQ+Tlt/gsuGiEiA9j8JVU0h22FWI=;
        b=Xo+o4gUPuQIWnfg0h22vi9P6bq1hqq/L4RmO2q4//sOW8VxztulKYEB27SONwPRokB
         S31Sbocbm+WdIwcR8iLOWxbvi7jG5KqZPIiXQzXFsDXk7muoJ/MUmghXq51805p3Xb+b
         Wvhx6dSSfenHeC37G9rgnAXjDEB50oqIFWDM86hfhMGsVFX/jvzKsYXme2xLuj5uUYFP
         GK4zyMCMksGaGJoISP8IIHmeNUalLMiZpUoyXRa+i4GeJT64ZJcGQB6I5gWEexZl3Vfy
         mfX0AmjNR83roTVVbR8aUJKS/P9t8PER6uQVuYrVGxd5FRnYHNo+PAmi2nwKUtA0Dbks
         Pfzw==
X-Forwarded-Encrypted: i=1; AKwUvBxmAzIrUUWDFjKzh+DtejUDtPVZGlz16nUHXpFX42KiK2laE82z40Z+qndDZktcZjbw/us=@vger.kernel.org
X-Gm-Message-State: AFuF++lY1Bwy8Fu8tu9KOc/fUjG9YtOZ8KLMFq1ebfrwYWuJhmXU4Hbg
	I8yz818pBOYjRp3ibczaFWiVEuhyfJEyiLAf/9wwFucxhRvL4WmhFjGeaqOiRfDjr80=
X-Gm-Gg: AYBFou3Kikv16H321n9kZeIWdGe0Z9Yv9I3OYpoF1B/f3HUqsWOZIHyfKWLw7YCV07G
	SiyRoLKVG+Qr8rhj0HXQQ4p4ARvVCbgoKweDpO55tmLn9RK2ADcP42nspxJYQa/a3zDceyTcupr
	pO4a5o41uE7B0OtiMb9Aphl4ASBrbAng3WwbjMKKSmzquB9NJqGS1UER//Z/0ggZ0aAbMHJ7JDq
	2exzLbXKMcqvzSm1PZjh6YsDa2prt6mjeJBQhBPUEwq26wUbY7T6H9rWo7r3yHXB4ZMCwQcsCwi
	B8Ps9oLfR/JhCetHpKc4Jii32bTuvMZS5HG+SFyc1oV/nqOd2E0/XN9xg/wLUxjJfyXsddYcvey
	voYaXHL2DfH6FRJhd+02wOk+HAzZ2wmjhCvF/OUPehqyUYBZ26Z5z/EiGcx7U0JrzJuIPrZxCwO
	vEpwQ6H35UH8TBzdmLkX6TdNvoQwdly+soByi3fzgVxntQGgaIw7MnjJJqWy4UoSkzkuGw2IiQy
	JZaER6PSO89Zd4=
X-Received: by 2002:a05:6214:1304:b0:90e:9875:b48c with SMTP id 6a1803df08f44-913fc8b1f2dmr34711036d6.12.1790044448184;
        Mon, 21 Sep 2026 19:34:08 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140250b82asm4582396d6.39.2026.09.21.19.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:34:07 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 22 Sep 2026 02:23:31 +0000
Subject: [PATCH v5 12/13] rcu-tasks-trace: Assert no reader is held on
 return to userspace
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b4-rcu-tasks-preempt-qs-v5-12-410f57770bad@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790043820; l=2581;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=EMsOGg9VRxBcocei3P3dGUkU8foVu6cO35v23va9IOs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLzeLb/2gtbRDPx3ssZtnGVRsANVTMmhDuPYTamLR1rD3jjMOpYIakVJmblm2P6SqGgYyithDIa
 ERiWg9/irxQs=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With trampolines now taking rcu_read_lock_trace() open-coded from
assembly and JIT-emitted code, an unbalanced reader would silently
turn every later Tasks Trace grace period on that task into a stall.
No task can legitimately reach userspace with current->trc_reader_nesting
non-zero, so under CONFIG_PROVE_RCU check it in the generic entry
code's return-to-user validation, next to the existing kmap and lockdep
assertions.  Compiles away otherwise.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/irq-entry-common.h | 2 ++
 include/linux/rcupdate_trace.h   | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index e19b41ee6b18..d42568a488a7 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -5,6 +5,7 @@
 #include <linux/context_tracking.h>
 #include <linux/hrtimer_rearm.h>
 #include <linux/kmsan.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/rseq_entry.h>
 #include <linux/static_call_types.h>
 #include <linux/syscalls.h>
@@ -214,6 +215,7 @@ static __always_inline void __exit_to_user_mode_validate(void)
 {
 	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
+	rcu_tasks_trace_assert_idle();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 }
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index dcdb11643496..9eb7f92c710b 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -217,6 +217,12 @@ unsigned long rcu_tasks_trace_batches_completed(void);
 // Placeholders to enable stepwise transition.
 void __init rcu_tasks_trace_suppress_unused(void);
 
+/* A task must never reach userspace inside an rcu_read_lock_trace() reader. */
+static inline void rcu_tasks_trace_assert_idle(void)
+{
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(current->trc_reader_nesting));
+}
+
 #else
 static inline unsigned long rcu_tasks_trace_batches_completed(void) { return 0; }
 /*
@@ -226,6 +232,7 @@ static inline unsigned long rcu_tasks_trace_batches_completed(void) { return 0;
 static inline void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func) { BUG(); }
 static inline void rcu_read_lock_trace(void) { BUG(); }
 static inline void rcu_read_unlock_trace(void) { BUG(); }
+static inline void rcu_tasks_trace_assert_idle(void) { }
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
 DEFINE_LOCK_GUARD_0(rcu_tasks_trace,

-- 
2.55.0

