Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A90F1957F8;
	Wed,  9 Oct 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496847; cv=none; b=ZyK2lj0FA1zjrt7OPM+FPNLCRar6e0yLu/6ST1RBimtHOBsXa3DpXjQpGeBzxIzbtsiLK4CLWJozkADBFttKrD1heWlEcomTPCIAW1YnKvl87YRwr/JmHN50VGygbFNWd+ujl09HhWdkhlguaTy12NaZcidvNYi75Z700aUn+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496847; c=relaxed/simple;
	bh=OySrHGIYGBCnLfy5/68TxcrLmWNaXjEnRyRhtLieCyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FIHotcgipeXAvktiLZrlCv0R3FVzaERoOhAx5j7E72SUdjV/ixr1EeRmQHrQtTAdE8xO/SZVQM9mOIHGoc1aXh6vSqS6inMUDY3DL97NATP3kH9InG9Sj4iZTZF57Zn766iU545/uGyeQf6r6HhB8S73WQdS+qFeGtArrrBWtPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmpiWNxj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmpiWNxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF26C4CED1;
	Wed,  9 Oct 2024 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496846;
	bh=OySrHGIYGBCnLfy5/68TxcrLmWNaXjEnRyRhtLieCyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmpiWNxjj9ykcbMYQabAxAfCZDufS2YtyYEKPaXTrucrMCtyxx2TB5O7ffz0tVj6+
	 ISHEN6H1n+3shbX7hs+jFBv9Xrll3bRmuscBf/lJW9o3wIQ42STuf0ggSA6W/KHE9X
	 TDPf751b9mjY4AGGw9kgF+g+xBx4hUTFHkbOle7gOrRulC0o7ygiqCoyV4a3WMMDS2
	 2tmLBABO8wXW++u/lkPAy+KvG36ileuhJSyflWtRk1dnTWNK4e5OJCgShiEnn0Yd1m
	 UZISqF7jJWIVgsUIFMyyZmqB2UfegHPX9tN4qcvXGVcyhZzVL0IxNS9Vy0BIv5nyew
	 znkaBQ6JQukOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7118FCE0DD1; Wed,  9 Oct 2024 11:00:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH rcu 4/7] rcu: Permit start_poll_synchronize_rcu*() with interrupts disabled
Date: Wed,  9 Oct 2024 11:00:42 -0700
Message-Id: <20241009180045.777721-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
References: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header comment for both start_poll_synchronize_rcu() and
start_poll_synchronize_rcu_full() state that interrupts must be enabled
when calling these two functions, and there is a lockdep assertion in
start_poll_synchronize_rcu_common() enforcing this restriction.  However,
there is no need for this restrictions, as can be seen in call_rcu(),
which does wakeups when interrupts are disabled.

This commit therefore removes the lockdep assertion and the comments.

Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a60616e69b663..3d6507d0b8d33 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4193,7 +4193,6 @@ static void start_poll_synchronize_rcu_common(void)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 
-	lockdep_assert_irqs_enabled();
 	local_irq_save(flags);
 	rdp = this_cpu_ptr(&rcu_data);
 	rnp = rdp->mynode;
@@ -4218,9 +4217,6 @@ static void start_poll_synchronize_rcu_common(void)
  * grace period has elapsed in the meantime.  If the needed grace period
  * is not already slated to start, notifies RCU core of the need for that
  * grace period.
- *
- * Interrupts must be enabled for the case where it is necessary to awaken
- * the grace-period kthread.
  */
 unsigned long start_poll_synchronize_rcu(void)
 {
@@ -4241,9 +4237,6 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
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
2.40.1

