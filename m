Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82219374A17
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135830; cv=none; b=oWL61q/+7FLbswLmO97kE0G6TBs4xNL8dGy1RAHY/MJYrK8q7KgeVy3n82VlzEJDV2WhVGj82Af5DPQ3lwxu5R85G27CLT2KQx9RQJEaMGgf/EEiQnMVUi9YadvVXJnOhabwSyLrdjfeBgM1KT2QVnx0lCjp7mJ7F/HQPsXMgfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135830; c=relaxed/simple;
	bh=CHfEJf4XyY3zn8RyomjOM2Uc3mVFT7MUycrwjg2RabY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oztTV8rf/Z8pZUYLmMRHYlxlCwtxNwnpE1LB91Jcf1b3oU7WCgVFRsPb8r6Yon4DfHoDr4v3B7Jw+8AnBC40xwZhP0+0t6BDtKOxBri8JOb6Bs5WsRRdfKYA1+Yz0pZOR7lZPrUPTW4pSFGgMwgcS5yuYP970G7eCK7lCq2g9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=mt4DmxKM; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="mt4DmxKM"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939695b5741so98111585a.1
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135826; x=1789740626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tDcwMwF0CqD/SLUwt7lLP/Zeny+NN6n073A4kvHv5Ng=;
        b=mt4DmxKMFOa54vKaT7P7rC0nknUec5SG40ykFBll3pCY7tJxqt/x+SOCkXo3KNe18M
         yedzxk53shlT7hl4bnCF93vW8Y8pISo2hDuG8GRWZ/63qMENZom+pJ0aLDwuU3F8URLY
         sw2cIbuAA0M8+dqVCdaDdIwG5iib83Y3t4wTDLLWgp+XYVAQr1orQF86xBjSQEUfDkuI
         m1WVGkAxwPOHg/lTHRo1qpU7itzlq3ZKGLp28y4/aiV/Z3+87tG6AJ4lwxpq8U8eYIam
         2Zoa7ytfUf8k+ZLC8eMWbTFPq7Fa+oTvHEHxNMUgVKDtXmGQ6Pl0liwZ2dOx/DYlFOQP
         Q1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135826; x=1789740626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDcwMwF0CqD/SLUwt7lLP/Zeny+NN6n073A4kvHv5Ng=;
        b=NMOXZK68qnKCi6AXcntrLsFQy1uYEbBBxeFPOWSh5hkPGN3rMVZIBxeqw7iYxw9UV3
         B1qO5B7SGtAa16qT8TJzQopq/+RwnO3kdnGIOslbz+Pp41oKeRwz7P8tyuebVSSe5D+I
         /vlnRPlM8Fv/qheDIqkbOTz2t63ny35gv14FH6RNJ6YAb+0UQLHsRsy6YfSf3M2pm+kF
         lg9oozapL+x8FlMCkiUGJjRcb16lG7I5iaYdwlsTcOrGDFz7g53PLN2diMRSH74hSGGy
         uk6Qtc1QfSjwWCPVMRDdM15bGvmhZLxXFw9b4DA/fJHdrRRSaS3nB7ZCUBvzOQcrYr7J
         4CDg==
X-Forwarded-Encrypted: i=1; AKwUvBz23a9kFd94Cl7OaFjicoeHrIk3VP0JV0vqPzEAXfiTva8stVkhCIsYeRO1aRjVh+yzEYg=@vger.kernel.org
X-Gm-Message-State: AFuF++li4e7ittijNT+ZbYLdReHmfUbg+7BpM1UU2nKHaCHNjRa/uuYa
	oKwGeaIhrAAZ9Edfb7UCduacR6G7PObaAXMVDCeCqspME1NY0oHLcLkd0zrggg8yxZA=
X-Gm-Gg: AYBFou2UR034xYO2KLVstInd0SkBzdWs2cHaLHdEmwGpec+bjap/PRTAB3g/NHmNJ3R
	fASP28ltzTcaV3USyw0IJkoUIKV7OWqSRsKeA7wsaLl2oo/VoqVPxZS6QMW2CvObre5G83uMpc2
	MZ4EvoDPEC2sE5OhuR1rHBxr+fqI1NSLb74RzEBHjCVCqrQzE3epwrJasKvoQ0iXpda09X17cK8
	cJDFwE7ycQoqzcn/rmTKtKsyHRUB8glMSbMAPD98/P7Qg/ZDrOZW6S0zBfH0cc+tbLZqr3r8zBb
	WR3T88F3O5xsFWkzlRc3tGVnTswc5VltXtUKUOmqQLI2EzzBlzAiUsvgH14dpaAiimw0dBXizn+
	oMJTQ6OQO4Y3cJ01SunErtgGTDTcNplQSs2ny3XW6vPK47kBUre6ufWwlTDJLyeqPAmOVpmQhAs
	LJOj4ieNHnuUkD75b/3qkQQ6jbMwsBDP1DGgRpqkPoQ0+evroNkyBbo809tuRET0LTLDjbHQ+hG
	h4afwxYGDnJyyHF3kjxFpcryi3HD3EPzql3sp26XfAj+ajkfkPsJPCE
X-Received: by 2002:a05:620a:2a01:b0:92e:6c15:24cd with SMTP id af79cd13be357-939ea096ac1mr525489385a.15.1789135826040;
        Fri, 11 Sep 2026 07:10:26 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939f19f94a1sm128350685a.42.2026.09.11.07.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:10:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:52 +0000
Subject: [PATCH RFC v2 14/15] rcu-tasks: Retire switched-out tasks with no
 trampoline nesting at scan time
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-14-eaaa61ed2da4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135737; l=3915;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=CHfEJf4XyY3zn8RyomjOM2Uc3mVFT7MUycrwjg2RabY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCsPahyd7Oix02uJZsqv3hNKRWBYJbR9ZWsmEzIdYJha+M3Xp7J5xDeZFd/3etSxBmrSG0gewnR
 pnh9QNzgnXwY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The previous patch lets a task report its own quiescent state when it is
preempted with rcu_tramp_nesting == 0, but a task that was preempted
before the grace period started and simply has not run since is still
listed as a holdout until it next passes through __schedule().  As Paul
pointed out, the grace-period kthread can settle that case itself.

For a task that is switched out, task_call_func() pins it and
!task_curr() tells us it left the CPU through __schedule(), whose
locking orders its last rcu_tramp_nesting and rcu_tasks_irq_ip updates
before ours; a task preempted from irq exit inside trampoline text has
the count held non-zero across the switch by irqentry_preempt().  So a
pinned, not-running task with a zero count is neither in nor called
from a trampoline, and with rcu_tasks_irq_ip_holds() also clear (the
kprobe jump window, which can open after the task was switched out) it
is quiescent now, whether or not it ever runs again.  Check that in
rcu_tasks_pertask() so such tasks never become holdouts, and in
check_holdout_task() so they are retired on the next scan.

This is the only remote reader of the count, and it only reads it for a
pinned, switched-out task, so the trampoline-side increment and
decrement stay plain on every preemption model, PREEMPT_RT included.

Only under CONFIG_RCU_TASKS_PREEMPT_QS; other architectures are
unchanged.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/rcu/tasks.h | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bab08a666dc0..ba432bd922e2 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1014,10 +1014,39 @@ static bool rcu_tasks_is_holdout(struct task_struct *t)
 	return true;
 }
 
+#ifdef CONFIG_RCU_TASKS_PREEMPT_QS
+/* task_call_func() callback: is @t switched out with no trampoline in play? */
+static int rcu_tasks_switched_out_clean(struct task_struct *t, void *arg)
+{
+	/*
+	 * With @t pinned, !task_curr() means it last left the CPU through
+	 * __schedule(), so its rcu_tramp_nesting and rcu_tasks_irq_ip are
+	 * stable and ordered before the rq lock we hold.  A task preempted
+	 * from irq exit inside trampoline text has the count held non-zero
+	 * across the switch by irqentry_preempt(), so zero here means neither
+	 * in nor called from a trampoline; rcu_tasks_irq_ip_holds() covers the
+	 * one case that can become true after the task was switched out (a
+	 * kprobe jump-optimization window).  Both clear: already quiescent,
+	 * whether or not it ever runs again.
+	 */
+	return !task_curr(t) && !READ_ONCE(t->rcu_tramp_nesting) &&
+	       !rcu_tasks_irq_ip_holds(t);
+}
+
+/* Is @t, right now, switched out somewhere that is a quiescent state? */
+static bool rcu_tasks_preempted_qs(struct task_struct *t)
+{
+	return task_call_func(t, rcu_tasks_switched_out_clean, NULL);
+}
+#else
+static bool rcu_tasks_preempted_qs(struct task_struct *t) { return false; }
+#endif
+
 /* Per-task initial processing. */
 static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 {
-	if (t != current && rcu_tasks_is_holdout(t)) {
+	if (t != current && rcu_tasks_is_holdout(t) &&
+	    !rcu_tasks_preempted_qs(t)) {
 		get_task_struct(t);
 		t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
 		WRITE_ONCE(t->rcu_tasks_holdout, true);
@@ -1181,6 +1210,7 @@ static void check_holdout_task(struct task_struct *t,
 	if (!READ_ONCE(t->rcu_tasks_holdout) ||
 	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
 	    !rcu_tasks_is_holdout(t) ||
+	    rcu_tasks_preempted_qs(t) ||
 	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
 	     !is_idle_task(t) && READ_ONCE(t->rcu_tasks_idle_cpu) >= 0)) {
 		WRITE_ONCE(t->rcu_tasks_holdout, false);

-- 
2.55.0

