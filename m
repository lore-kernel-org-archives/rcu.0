Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531036;
	b=EliuSa0etOSHAyUjhzqI9idqM9O3WwwH5nnGcV7cLo58nUz+slhHzBoWregD5R/KiWkK
	 dyDH1G/xeDAmn5K6rr8+WBtwgN8arbCyuayTO7EOrWQU6OdrHw06dJWa6SGTIdyl7Swyu
	 96AeQpwIzyzh1+ZC97/dnA+BtfdEtPKxppsC8xbMaoQWkj01EY/qZVfMXTJ4H5lZWb5pT
	 AC8n5PTdClrZYc2gHpDE/rU0gTlk/k1ecwUqdd9zpgTl+CsMEgKBNzo2WDMCf/ybX4KCv
	 W5HXNmzFNWHN6LjtUkszkmrXxvsv+Rut5axHQYoNHKuv5Yzn7zUGrkhNQq98fLhLSDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531036;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1IRuvUkQTRkQ+ilf6p3cBYjTfeE1ubS23ik55VclfyQ=;
	b=tT8BbP4Njd9R3fwQt3/WS7rKXbZnpNlyi54+gsWS33pVxnMVIH5SKifAhx0AOD/bDsxc
	 uDR5FjqGOnIRPjQ2fcLIlISuh5QGtXxJus5N9AWzs0tZQnEIgFgtgNq8iyhz67f/nDLQ+
	 erNra1lid6lczvvVtNu9dNKdcgHMC2oTWm3XdGnVhkBr5eOWWaNOi0/yplSjz8d0Lv4rp
	 ROWa1CPH21bcyb9NQdnuTBxl1tAlYf3s1CRHo83OZnx5pjHbloOwDvmZ6sq4XW6ejscGu
	 dp32vJqZjLobwmP39FrfOa0HkgtHzIhazrblIp4zD/visspJ7M4jjxliPmdK4q/3lrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQEDJq36;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A0C1E60A5BC9;
	Fri, 13 Nov 2026 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQEDJq36
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 314C01F000C9;
	Fri, 13 Nov 2026 00:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531036;
	bh=1IRuvUkQTRkQ+ilf6p3cBYjTfeE1ubS23ik55VclfyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CQEDJq36P/UajLs/igvB6eB7u6YzP9+Ixhti+TVNdMJO41zgugiJo/9iREQ6wvRiZ
	 zqCwHCwKgP4aOp+ERC1S0nwHl85mpyrY5F5Z7kSZgC+2Q/P70l2PNrf/o9HtXC4ElL
	 h2NvqzwPG9r4L42goQeLfaveOiGnwXF/EivP2wLbQ28Ldos3/5roAANZOFi+q1CGgp
	 03hqyXA+QE1/Ty/GSgdcY2WbKc/0+xXU5t2o8qFSs8WKx8VFlmdFrN5TF+u1ZS+giP
	 9l2T39aHjVzQdxCWjt6Z0hO78E5dbKIUYoMktl51GXL2NBxY4UnGdH1j5Ecaw8hcOU
	 Q3l/TGPji1DFg==
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
	Zqiang <qiang.zhang@linux.dev>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH for-v7.5 09/11] srcutiny: Detect duplicate callback enqueue
Date: Thu, 12 Nov 2026 19:50:11 -0500
Message-ID: <20261113005017.2772440-10-jfern@kernel.org>
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

Detect duplicate callback enqueue attempts at call_srcu()
entry, before the deferred list can be corrupted.  Use
__ratelimit() for the diagnostic output group.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/srcutiny.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 98864977bed2..4c1e8d8595b3 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -12,9 +12,11 @@
 #include <linux/irq_work.h>
 #include <linux/kasan.h>
 #include <linux/llist.h>
+#include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/preempt.h>
 #include <linux/rcupdate_wait.h>
+#include <linux/ratelimit.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/srcu.h>
@@ -178,6 +180,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	while (lh) {
 		rhp = lh;
 		lh = lh->next;
+		debug_rcu_head_unqueue(rhp);
 		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
@@ -235,6 +238,8 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
  * Also called by __srcu_defer_drain() to re-issue a deferred callback, so it
  * must not re-check the deferral condition.
  */
+static void srcu_leak_callback(struct rcu_head *rhp) { }
+
 static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
 			    rcu_callback_t func)
 {
@@ -272,6 +277,8 @@ static void __srcu_defer_drain(struct srcu_struct *ssp)
 	llist_for_each_safe(node, next, llist_del_all(&ssp->defer_cbs)) {
 		struct rcu_head *rhp = (struct rcu_head *)node;
 
+		/* Bounds a node self-linked by a double call_srcu(). */
+		rhp->next = NULL;
 		srcu_do_enqueue(ssp, rhp, rhp->func);
 	}
 	local_irq_restore(flags);
@@ -288,6 +295,10 @@ void srcu_defer_drain(struct irq_work *iw)
 }
 EXPORT_SYMBOL_GPL(srcu_defer_drain);
 
+static DEFINE_RATELIMIT_STATE(rcu_srcutiny_dup_rs,
+			      DEFAULT_RATELIMIT_INTERVAL,
+			      DEFAULT_RATELIMIT_BURST);
+
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	       rcu_callback_t func)
 {
@@ -298,6 +309,17 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	if (WARN_ON_ONCE(!func))
 		return;
 
+	if (debug_rcu_head_queue(rhp)) {
+		if (__ratelimit(&rcu_srcutiny_dup_rs)) {
+			pr_err("%s(): Duplicate call_srcu() CB %p->%pS()\n",
+			       __func__, rhp, rhp->func);
+			mem_dump_obj(rhp);
+			dump_stack();
+		}
+		WRITE_ONCE(rhp->func, srcu_leak_callback);
+		return;
+	}
+
 	/* Record the caller: the irq_work's stack says nothing about it. */
 	kasan_record_aux_stack(rhp);
 
@@ -306,6 +328,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 		if (READ_ONCE(srcu_defer_draining) && !in_nmi()) {
 			WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
 				  "call_srcu() re-entered during callback drain; leaking callback\n");
+			debug_rcu_head_unqueue(rhp);
 			return;
 		}
 		rhp->func = func;
-- 
2.54.0

