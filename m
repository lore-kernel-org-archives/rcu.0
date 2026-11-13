Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531038;
	b=iET0DyJDBEbJmr1DpZ3eVqEJdxvEThVggwpHEB5lbiLjnrnQ8O8saXf5dfcudv/a+l9R
	 9K1/yD8E0qj2WY9/BaU9EYqArTN/qfPwjIHTMNkEEykG0+As6BXOyOdWnciJEgnobPrY2
	 PBVq6QM7fOLICRNnAFXLDFkv/0VISjmT5UnibrA6KNc/kKCx1qQk457f1WkQpW9SOrums
	 iCAa7QSqvIQmD6cmWTiSpGANe29N112jncUZAiG65kRZcz/nlyRurRas/9TV/l23J1sBC
	 BIQQXW7A4t5zHMVTqRm860KtRsW8dEXv6fK5Xdd4gZc+hI16wlJ4zC26EXtrH01fU6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531038;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sNDtcBRE683DcJbnhsJYyrj+yRqwTXKSncfs5WnNGwM=;
	b=r7r1s0xhZpjZs2SlzeDBLXq2QqiLK2KuE3Jb5YSvhLv82Taxrwe3yLpU1/8gihKqlxzQ
	 hiRkR6/pn7mOfsqYCx0W3oKIhBn/cZevZNbN6FgijOFU4+TK3t85EarbYBchh7KQHC7vo
	 /I9vrCjq9Ki6s/MRDA29SOhcWS6TW4gGNvahYJpiGgWeFC90i0kfxQ3372Igwi+iEielb
	 XB/ByG5duKFnozs1aOdyA6kvgBGqgZMiJzinyZ1m758Pz8Qhyc3PUPcT9pcrSUk3d6pRr
	 oWW44ORubipfi85KR96UBa0IU+56n9s//nwa8wNZnfRlKeXXlDYCjXYhU8XyLnlPtjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+3cZ3AP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BE49560A5BE1;
	Fri, 13 Nov 2026 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+3cZ3AP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0FECE1F000C4;
	Fri, 13 Nov 2026 00:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531038;
	bh=sNDtcBRE683DcJbnhsJYyrj+yRqwTXKSncfs5WnNGwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a+3cZ3APsxaHiFX5spVk6IKLbkxSZyyJpNiTRAE39n//R7vAyhE2QXN9b9EcCMPoy
	 NuEKkdSAqh05NA+8IeJch6qF1IupfHoSH8VTpX93y9pyJbY7fpuJlN4biQrQ5qXjEl
	 R0119mPR5SoC78dZf8ZeDqtaGVJ/9baHtiLBryR4Q+Vy20i2Zho5QX8fzaIW/h2ffz
	 lTB2pR/sC7yXaM9b+zSPUERPOV5TqOoWEwtDcxrrXmQwcXBv60k0abw8bbqaCrs12v
	 CSfDep+uTH6NSFWoa/bghrWLXHjMLmohGrGAUngyAY1PaRi+nSbt15MfJfUTJWe0BJ
	 5MOWf1KedozMg==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH for-v7.5 10/11] rcu-tasks: Detect duplicate callback enqueue
Date: Thu, 12 Nov 2026 19:50:12 -0500
Message-ID: <20261113005017.2772440-11-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005017.2772440-1-jfern@kernel.org>
References: <20261113005017.2772440-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Detect duplicate callback enqueue attempts in the generic
RCU Tasks callback registration path.  Use __ratelimit()
for the diagnostic output group.

[ joel: Activate each rcu_barrier_tasks_generic() barrier head in
debugobjects before entrainment, and undo that activation when nothing
is entrained, so that barrier callbacks no longer trigger active_state
and deactivate warnings for untracked objects. ]

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/tasks.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a1883cf5b5d1..c1e456e08e66 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -6,6 +6,8 @@
  */
 
 #ifdef CONFIG_TASKS_RCU_GENERIC
+#include <linux/mm.h>
+#include <linux/ratelimit.h>
 #include "rcu_segcblist.h"
 
 ////////////////////////////////////////////////////////////////////////
@@ -337,6 +339,12 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 }
 
 // Enqueue a callback for the specified flavor of Tasks RCU.
+static void rcu_tasks_leak_callback(struct rcu_head *rhp) { }
+
+static DEFINE_RATELIMIT_STATE(rcu_tasks_dup_rs,
+			      DEFAULT_RATELIMIT_INTERVAL,
+			      DEFAULT_RATELIMIT_BURST);
+
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
 {
@@ -356,6 +364,17 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	if (WARN_ON_ONCE(!func))
 		return;
 
+	if (debug_rcu_head_queue(rhp)) {
+		if (__ratelimit(&rcu_tasks_dup_rs)) {
+			pr_err("%s(): Duplicate CB for %s, %p->%pS()\n",
+			       __func__, rtp->name, rhp, rhp->func);
+			mem_dump_obj(rhp);
+			dump_stack();
+		}
+		WRITE_ONCE(rhp->func, rcu_tasks_leak_callback);
+		return;
+	}
+
 	rhp->next = NULL;
 	rhp->func = func;
 	local_irq_save(flags);
@@ -448,9 +467,12 @@ static void __maybe_unused rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
 			break;
 		rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 		rtpcp->barrier_q_head.func = rcu_barrier_tasks_generic_cb;
+		debug_rcu_head_queue(&rtpcp->barrier_q_head);
 		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 		if (rcu_segcblist_entrain(&rtpcp->cblist, &rtpcp->barrier_q_head))
 			atomic_inc(&rtp->barrier_q_count);
+		else
+			debug_rcu_head_unqueue(&rtpcp->barrier_q_head);
 		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	}
 	if (atomic_sub_and_test(2, &rtp->barrier_q_count))
@@ -579,6 +601,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	len = rcl.len;
 	for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
+		debug_rcu_head_unqueue(rhp);
 		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
-- 
2.54.0

