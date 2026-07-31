Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695B2D73A6;
	Fri, 31 Jul 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459717; cv=none; b=jj5YSXnSQ9olrnDoax+CaA5GYTOEKcIfmqugrlrro83EBM+AkfKfhNR6ayKP3CeQL/4+9kGvVU0bxgYCa+TfoNB6Cwx91xwwS4uMq/7tiggnqlbiebLEQfyiLAsuGVOgvdyuBnmnGYt9FvmtI6on1opJma15KMk6z/OI7ZTPA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459717; c=relaxed/simple;
	bh=5Fl+jixV+111LdJWKLj28h0xJ4Wa+YXtPbADF+JcAXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NnU22gRyzQTt0axpihrilrRg0lyKuXwBGl+AsajITBeAxqWnsIgnisD4J99bfUC7ZSB2jLEUVskVcOvvtE9iYKMOgbUj6jnuQH0JqHVHOzzW9J5NvU5PvflOVKhhtz3xUJ8FQbkgIXM7h0mkimkp14GfVJEbS0sXkPaKaSUDjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMzIEYfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMzIEYfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAD31F00ADE;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459715;
	bh=cYMHLUJByBXeSM5FJPpp9HkR0BuwBLZFM7nxWlaVTKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bMzIEYfmK/tsTBGqpBrQQjxy1OMwX4LM6ynhv+ZwkALHYtbFfm6ODM3CMtJWHw2JS
	 21ntdPJoFo2J1jhQ1/5l1y43k8/wYlrZ/EbCrZlAFWQ3bR6V02gv0pp+GKudcF/8sS
	 40rvsUUICxNn3+S8BovervNEoXq4SzPm0QiCHUXBN7z5gkx4RyLClx9hin6+/cY3ha
	 zY+ovBd3lJYHMhAp37fbofxRN0CU7teJkhGemwDumJYiN5Sb1h+f/REzte1dPfyMGc
	 1gqDB0EqvH4xx3xCMtMZ0NYoETy3UKriorD40CZCu2ZrMKolWfND4X1gmenBS8qD2n
	 yURM4TjjRTZLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B019CCE1018; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 06/16] rcu: clear defer_qs_pending in deferred-QS bail when nesting > 0
Date: Thu, 30 Jul 2026 18:01:43 -0700
Message-Id: <20260731010153.3531313-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
References: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joel Fernandes <joelagnelf@nvidia.com>

Paul McKenney noted that a softirq (or irq_work) handler arming for a
deferred QS can fire and find rcu_preempt_depth() > 0 -- the task is
still inside its outer reader, so rcu_preempt_need_deferred_qs() bails
without reporting the QS.  At that point the queued mechanism has been
consumed but ->defer_qs_pending stays in DEFER_QS_PENDING.

In the meantime, the only remaining path back to a quiescent state on
this CPU may be a local_irq_disable()/_enable() pair that does not
call preempt_check_resched() (it is just `sti`/`cli`).  patch 6's
unconditional set_need_resched_current() makes need_resched true, but
without an irq_work being raised the next outer rcu_read_unlock_special()
hits the P-gate at the arming code:

    if (rdp->defer_qs_pending != DEFER_QS_PENDING) {
        rdp->defer_qs_pending = DEFER_QS_PENDING;
        irq_work_queue_on(...);                 // <-- skipped
    }

so no irq_work is queued for the hardirq-exit preempt_schedule_irq()
path either.  The deferred QS now waits until the next timer tick (or
similar preempt-safe boundary), needlessly extending expedited grace
period latency.

Clear ->defer_qs_pending in the bail-out path of rcu_preempt_deferred_qs()
when rcu_preempt_depth() > 0.  The recursion guard semantics introduced
by commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ
work").

The clear is also safe against fresh recursion at this exact program
point: rcu_preempt_depth() > 0 guarantees we are still inside an outer
reader, so any inner rcu_read_unlock() from tracing infrastructure
brings nesting back to outer (>0), never to 0.  The slow path of
rcu_read_unlock_special() is structurally unreachable under that
condition, so no recursive raise_softirq_irqoff()/irq_work_queue_on()
can be triggered by the clear. Essentially, the mechanism will work to
prevent the following recursion which Xiongfeng had previously reported:

irq_exit() -> __irq_exit_rcu()
  -> tick_irq_exit() -> tick_nohz_irq_exit() -> tick_nohz_stop_sched_tick()
    -> trace_tick_stop()                    // BPF prog hooked here
      -> rcu_read_unlock_special()
        -> irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu)   // self-IPI re-enters irq_exit

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 8637f405cb472f..9ba136a4233a26 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -614,9 +614,35 @@ static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
+	struct rcu_data *rdp;
 
-	if (!rcu_preempt_need_deferred_qs(t))
+	if (!rcu_preempt_need_deferred_qs(t)) {
+		/*
+		 * If we got here from a softirq/irq_work that fired while
+		 * rcu_preempt_depth() > 0, the deferred-QS mechanism has been
+		 * consumed without doing any work: rcu_preempt_need_deferred_qs()
+		 * just returned false because the task is still in a reader, so
+		 * the actual QS report has to wait for the next
+		 * rcu_read_unlock().
+		 *
+		 * Clear ->defer_qs_pending here so the next outer
+		 * rcu_read_unlock_special() can re-arm a fresh mechanism (in
+		 * particular the irq_work path, which the local_irq_enable()
+		 * recovery boundary cannot itself reschedule from).
+		 *
+		 * Recursion safety: rcu_preempt_depth() > 0 means we are inside
+		 * an outer reader, so any inner rcu_read_unlock() reached via
+		 * tracing (bpf programs attached to trace points) brings
+		 * nesting to outer (> 0), never to 0, so no recursive
+		 * raise_softirq_irqoff()/irq_work_queue_on() can be triggered
+		 * by this clear.
+		 */
+		if (rcu_preempt_depth() > 0) {
+			rdp = this_cpu_ptr(&rcu_data);
+			rcu_defer_qs_clear(rdp);
+		}
 		return;
+	}
 	local_irq_save(flags);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
-- 
2.40.1

