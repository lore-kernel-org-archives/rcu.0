Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05795202625;
	Wed,  6 Nov 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905168; cv=none; b=QVktJGZZ4X9aNgXoCOCZuc5o7HsR1bvb/RWQgBEezd7N1TMncIRMzRkJEw4OEpkObz74HHnz54bTwD5gB1enD5CkzMlJOnV9hlX2b9w5sJSnfEGnWoFnqm822Q5gjCkUHVymHV56Ib4T7Mjv9+TKZa+hM1TC+KELJt50Vwof8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905168; c=relaxed/simple;
	bh=qA/c0N3rIn1d+527roOwF7bl5h7TXeVRuH3DxgNRebw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pf2sAHjoCUhREIK2chhTSiRqY6TcscfdTLw9vLhpW9JjvbsXteXLGUSqknPHUXQIffRh7JhMvwYxgySUY4Cyor/IeRYO57kOLWj8wGlYh4d/g2F7sxmO18woeI6g/EfbLV6wV6rU887WaVvDXu0OOGfvHqFTvF24YXUDryjbx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiq8Et49; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiq8Et49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C369C4CEC6;
	Wed,  6 Nov 2024 14:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730905166;
	bh=qA/c0N3rIn1d+527roOwF7bl5h7TXeVRuH3DxgNRebw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kiq8Et49D6w50kLceRxq1pVCsNKk+lrWWZpW+ScNk4nVPEwlWESeMhuHe4c5dLEK4
	 RvXRaXOTbrPgOgN/lCXkF3kiPmjbWrOy6lv5BJeiMs+unBf6Z4ybnmPvFHa1NLrJ4B
	 TQ/MN6SksZjvxa1f9jQhXGCtqBMmbhfllIROHvvrmGqWRuJiuDaPzFrqPhY6aKPT8+
	 WKJzYDngpAxPXmc3txEbpQIltaooKSIYjhpy+1wFH5Nk0WBXdJQd7XcJ6Fg7XBZ8dP
	 G9MvZjix/EGr4vhrU4p/2Gr2LgECwlfN5+VDyacYmpa9FTkgXpijBoMz72z+tuT/uz
	 WVhiUsVB6q86g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 3/8] rcu: Permit start_poll_synchronize_rcu*() with interrupts disabled
Date: Wed,  6 Nov 2024 15:59:06 +0100
Message-ID: <20241106145911.35503-4-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106145911.35503-1-frederic@kernel.org>
References: <20241106145911.35503-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The header comment for both start_poll_synchronize_rcu() and
start_poll_synchronize_rcu_full() state that interrupts must be enabled
when calling these two functions, and there is a lockdep assertion in
start_poll_synchronize_rcu_common() enforcing this restriction.  However,
there is no need for this restrictions, as can be seen in call_rcu(),
which does wakeups when interrupts are disabled.

This commit therefore removes the lockdep assertion and the comments.

Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 38b121a77366..13829cf38f52 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4194,7 +4194,6 @@ static void start_poll_synchronize_rcu_common(void)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 
-	lockdep_assert_irqs_enabled();
 	local_irq_save(flags);
 	rdp = this_cpu_ptr(&rcu_data);
 	rnp = rdp->mynode;
@@ -4219,9 +4218,6 @@ static void start_poll_synchronize_rcu_common(void)
  * grace period has elapsed in the meantime.  If the needed grace period
  * is not already slated to start, notifies RCU core of the need for that
  * grace period.
- *
- * Interrupts must be enabled for the case where it is necessary to awaken
- * the grace-period kthread.
  */
 unsigned long start_poll_synchronize_rcu(void)
 {
@@ -4242,9 +4238,6 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
  * grace period (whether normal or expedited) has elapsed in the meantime.
  * If the needed grace period is not already slated to start, notifies
  * RCU core of the need for that grace period.
- *
- * Interrupts must be enabled for the case where it is necessary to awaken
- * the grace-period kthread.
  */
 void start_poll_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 {
-- 
2.46.0

