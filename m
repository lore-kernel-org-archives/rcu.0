Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552ED28DB63;
	Wed,  9 Jul 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057708; cv=none; b=VbDLkPBoFIJlB80mwK1dzXZdctTBv0F4TCb5+2cmcdnn8tdluDhswFgan7WWF4w5/kcxyAPzvJ9Xypn2//wce5Be4N2JjcRpblRXV4+m8n2FeEOyiTwD6O1Pz8rGoHFAnaMzAnsD8r6Z5GaWN3nazmh3PkkR2XzAVDQFBZyF/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057708; c=relaxed/simple;
	bh=M8ZjJ30VmwOexsmfFOpejwe1qhUqE7IeUo2Kq/99r1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+B4uXP11nyH8Tox5CHzShf2uWBwy5oq6U9KbN/tCqTrkUsJuCtbCkIXsmkOAphbBkY+HDgFNUScDvOO63jlEpTkwtGHu9PJXlhkP3iXgch1ctvqgnaFiJcWRfcGNjw3Buly3upDMqWB1xpmVnzpiJxk9OL0pPAZe+NbdvB4kPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkB7/kas; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkB7/kas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEFDC4CEEF;
	Wed,  9 Jul 2025 10:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057707;
	bh=M8ZjJ30VmwOexsmfFOpejwe1qhUqE7IeUo2Kq/99r1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PkB7/kasasKhTB/oXK19iJExNC4RuTeV6UDF5Tne9TWO8EYbXimp70tKs4ZXpqcTB
	 R9Wl9k8CjYRlY/Wbmwzc74e0dSA8V0yHXRn4MS/ZFs/clxBkQoOuLX9OFZPUkOXEkh
	 I4xjacRrVYzqbqcARgtpCT96cExVjk6di1WueP/7kBONyPuvDLNG/B1ZRnosnDVkz8
	 hFqCUCuAW7GgbvsCD4M5qmEbZprdArU+CXAhnMS4o28jDEXN6kKVAt/v7wN9EB9rGy
	 qrjjTNSUSvW3aFWXgecqTl5HAxWZOEXovc+gXLEcpwxRjIv0mSkuh99eg/jkj8jqtu
	 DuVitPe53ISmg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 2/5] rcu: Protect ->defer_qs_iw_pending from data race
Date: Wed,  9 Jul 2025 16:11:15 +0530
Message-Id: <20250709104118.15532-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
References: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

On kernels built with CONFIG_IRQ_WORK=y, when rcu_read_unlock() is
invoked within an interrupts-disabled region of code [1], it will invoke
rcu_read_unlock_special(), which uses an irq-work handler to force the
system to notice when the RCU read-side critical section actually ends.
That end won't happen until interrupts are enabled at the soonest.

In some kernels, such as those booted with rcutree.use_softirq=y, the
irq-work handler is used unconditionally.

The per-CPU rcu_data structure's ->defer_qs_iw_pending field is
updated by the irq-work handler and is both read and updated by
rcu_read_unlock_special().  This resulted in the following KCSAN splat:

------------------------------------------------------------------------

BUG: KCSAN: data-race in rcu_preempt_deferred_qs_handler / rcu_read_unlock_special

read to 0xffff96b95f42d8d8 of 1 bytes by task 90 on cpu 8:
 rcu_read_unlock_special+0x175/0x260
 __rcu_read_unlock+0x92/0xa0
 rt_spin_unlock+0x9b/0xc0
 __local_bh_enable+0x10d/0x170
 __local_bh_enable_ip+0xfb/0x150
 rcu_do_batch+0x595/0xc40
 rcu_cpu_kthread+0x4e9/0x830
 smpboot_thread_fn+0x24d/0x3b0
 kthread+0x3bd/0x410
 ret_from_fork+0x35/0x40
 ret_from_fork_asm+0x1a/0x30

write to 0xffff96b95f42d8d8 of 1 bytes by task 88 on cpu 8:
 rcu_preempt_deferred_qs_handler+0x1e/0x30
 irq_work_single+0xaf/0x160
 run_irq_workd+0x91/0xc0
 smpboot_thread_fn+0x24d/0x3b0
 kthread+0x3bd/0x410
 ret_from_fork+0x35/0x40
 ret_from_fork_asm+0x1a/0x30

no locks held by irq_work/8/88.
irq event stamp: 200272
hardirqs last  enabled at (200272): [<ffffffffb0f56121>] finish_task_switch+0x131/0x320
hardirqs last disabled at (200271): [<ffffffffb25c7859>] __schedule+0x129/0xd70
softirqs last  enabled at (0): [<ffffffffb0ee093f>] copy_process+0x4df/0x1cc0
softirqs last disabled at (0): [<0000000000000000>] 0x0

------------------------------------------------------------------------

The problem is that irq-work handlers run with interrupts enabled, which
means that rcu_preempt_deferred_qs_handler() could be interrupted,
and that interrupt handler might contain an RCU read-side critical
section, which might invoke rcu_read_unlock_special().  In the strict
KCSAN mode of operation used by RCU, this constitutes a data race on
the ->defer_qs_iw_pending field.

This commit therefore disables interrupts across the portion of the
rcu_preempt_deferred_qs_handler() that updates the ->defer_qs_iw_pending
field.  This suffices because this handler is not a fast path.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree_plugin.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0b0f56f6abc8..a91b2322a0cd 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -624,10 +624,13 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
  */
 static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 {
+	unsigned long flags;
 	struct rcu_data *rdp;
 
 	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
+	local_irq_save(flags);
 	rdp->defer_qs_iw_pending = false;
+	local_irq_restore(flags);
 }
 
 /*
-- 
2.40.1

