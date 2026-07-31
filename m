Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B22DF6E9;
	Fri, 31 Jul 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459718; cv=none; b=kSxbYsOkrITJED5jMv3nOTveTD8H8+TthsqiFlV2ERN0h97C0IMgq7CjVS/lO+L0QbrVpETGddpsF8gA9gM6Ph9wg4e+9mq6auUe9Y1AjMf8XKz5NZYro6s8480raBARqj90Iv8sqKgpAokTCQgDg4Lz+UkiE5kQgJp4GRszGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459718; c=relaxed/simple;
	bh=dhSjR3vDrtZvSwAI9l7DzmPyRTQldlTikhvP7DqtDvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPI0clbt+5t+5E8Cvhw84nhKLxkaT179Hzx21zsuHgGM99f2nyvrWNcpkNJ6+xVBjI/11l34NOR8FRoc3bFdKQ3ObqWR+Zihmmv0p9W60E3VQeLvACyvpBd6fneJPk/oBhF3GwwjIECS2yhhNURkeNOn5QyBNflICr2/GKZF4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvs/cxd5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvs/cxd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E461F01559;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459715;
	bh=qVUn+HvYcqrUN3yFZCWJp+z6JszIeDOMxvQANkWtJx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cvs/cxd5QgLm3kix3Z9nbFPn49vEfWu6klvQhKYJCWEmQ2C7sZhD9QtFgSNeYK9Mn
	 C9Kd5Hp5KQ7sHA5hpQYna8sX6na10Mnc2iLRlmvfhwsK188uNhF6DMbhkCiKuuVy5S
	 hQwluFjcPsWRiH+uU0dL4x2CdymnwdP4tuQqLpal8zMmYHWekbv8cYl1IP1dt49dJX
	 XhiBD9w70zbMJCR3RFsvP9RCNs3ZIQVcT2VZlLNSXeCb85vG6MCW4i5SI7w19seoKG
	 BC7qHEt5jh15QuryLdoXyrT3s0QBXMu+1MX5vPogSIw55mSDQm9H23LLOPbGJG4gZ/
	 Zjwtx3bNrlSgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B9DF4CE14DB; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 10/16] rcu: Remove unused func parameter from callback-enqueue functions
Date: Thu, 30 Jul 2026 18:01:47 -0700
Message-Id: <20260731010153.3531313-10-paulmck@kernel.org>
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

Ever since the kvfree_rcu() tracing moved out of the callback-enqueue
path, rcutree_enqueue() no longer looks at the callback function
pointer:  By the time it is invoked, __call_rcu_common() has already
stored the function into rhp->func, and the enqueue path only adds
the rcu_head to the segmented callback list and emits tracepoints
that do not take the function pointer.

Nevertheless, the function pointer is still threaded through
call_rcu_core(), call_rcu_nocb(), and rcutree_enqueue(), forcing
each level to carry a dead argument.

Remove the parameter from all three functions, from the no-CBs stub,
and from the corresponding declarations.  Anything needing the
callback function can still get it from rhp->func.

No functional change.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c      | 10 +++++-----
 kernel/rcu/tree.h      |  2 +-
 kernel/rcu/tree_nocb.h |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 91d5b4dd08bf5c..390dad82675db5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3024,7 +3024,7 @@ static int __init rcu_spawn_core_kthreads(void)
 	return 0;
 }
 
-static void rcutree_enqueue(struct rcu_data *rdp, struct rcu_head *head, rcu_callback_t func)
+static void rcutree_enqueue(struct rcu_data *rdp, struct rcu_head *head)
 {
 	rcu_segcblist_enqueue(&rdp->cblist, head);
 	trace_rcu_callback(rcu_state.name, head,
@@ -3036,9 +3036,9 @@ static void rcutree_enqueue(struct rcu_data *rdp, struct rcu_head *head, rcu_cal
  * Handle any core-RCU processing required by a call_rcu() invocation.
  */
 static void call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
-			  rcu_callback_t func, unsigned long flags)
+			  unsigned long flags)
 {
-	rcutree_enqueue(rdp, head, func);
+	rcutree_enqueue(rdp, head);
 	/*
 	 * If called from an extended quiescent state, invoke the RCU
 	 * core in order to force a re-evaluation of RCU's idleness.
@@ -3179,9 +3179,9 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	check_cb_ovld(rdp);
 
 	if (unlikely(rcu_rdp_is_offloaded(rdp)))
-		call_rcu_nocb(rdp, head, func, flags, lazy);
+		call_rcu_nocb(rdp, head, flags, lazy);
 	else
-		call_rcu_core(rdp, head, func, flags);
+		call_rcu_core(rdp, head, flags);
 	local_irq_restore(flags);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 587bd71396eaa3..ca88aaa29d615e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -507,7 +507,7 @@ static bool wake_nocb_gp(struct rcu_data *rdp);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
-			  rcu_callback_t func, unsigned long flags, bool lazy);
+			  unsigned long flags, bool lazy);
 static void __maybe_unused __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
 						unsigned long flags);
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 373b877cf171d3..95dbf33462a2ff 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -603,13 +603,13 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 }
 
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
-			  rcu_callback_t func, unsigned long flags, bool lazy)
+			  unsigned long flags, bool lazy)
 {
 	bool was_alldone;
 
 	if (!rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy)) {
 		/* Not enqueued on bypass but locked, do regular enqueue */
-		rcutree_enqueue(rdp, head, func);
+		rcutree_enqueue(rdp, head);
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
 	}
 }
@@ -1666,7 +1666,7 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 }
 
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
-			  rcu_callback_t func, unsigned long flags, bool lazy)
+			  unsigned long flags, bool lazy)
 {
 	WARN_ON_ONCE(1);  /* Should be dead code! */
 }
-- 
2.40.1

