Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804E223302;
	Thu, 12 Dec 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028778; cv=none; b=RbCGvrL8pjiBvmXcp12EtfK4PvKL4pZ3jErN9GgFGvL3obaFozIPP4H1sMmxpgillBJGxfQOTg5xWvubbjULz3vC7kljo/9Gp2P3ezsDs1NZoGwY1TFxVwHkUBd9X8wbiV5mD0vzI8YALLJF1gYPI3xDTkiWZRdpAhBdGFgzj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028778; c=relaxed/simple;
	bh=M+u1mLkgwoFCzd2B/v6VzYBFEaWMnA5b0i8RiGmlU84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WENq+Q4XvAre+EI3SaXsV2+IR5RwbgTJoPWArMltpCfy1zBZOjnKfJ6Q5aHwhQRmx5L5di5nSqm+xrzGj832M+1U/mVoA5aW2vR5oWtvaj+aVyfGl/AG0i/dYt2Jlob/p21jOgXw24Hq29gTp5JYy2ql876X4uAqzYvpwKxjddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIbZceyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIbZceyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFC6C4AF0B;
	Thu, 12 Dec 2024 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028777;
	bh=M+u1mLkgwoFCzd2B/v6VzYBFEaWMnA5b0i8RiGmlU84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIbZceyJEbyeztq/36ocDD4mtOfkbvV2lUh6dodhGg1UJHlSoAJKXUShsaWqHizK0
	 61br0cYhr8u1bb1hvYYC7quIPijMGuAvZbjHrUJsq14qZYHPxT2bio7K2ftPmsTTsx
	 wD2wZRc9IdwFCdLanP5hmRnw1v2WpvXmZ5bYD0jAr1PwmYkexnngBySTAeHSWnnTdu
	 PyRIuQFRyQka79ggg6S4InzSi7CERRVQGSrZjwlO6KybH96EmfJzPgL/x7d5OiVMEz
	 z+kTxxo/gXVmfRQ2Pdon5MbQ4KAbciSTVl65cAEkD24kJvlsRu/3KVE4sN6pLpAZ3Q
	 owtXGT9OhLvZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3EEEECE0F78; Thu, 12 Dec 2024 10:39:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 2/8] rcu: Make rcu_report_exp_cpu_mult() caller acquire lock
Date: Thu, 12 Dec 2024 10:39:30 -0800
Message-Id: <20241212183936.1936196-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
References: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a hard-to-trigger bug in the expedited grace-period computation
whose fix requires that the __sync_rcu_exp_select_node_cpus() function
to check that the grace-period sequence number has not changed before
invoking rcu_report_exp_cpu_mult().  However, this check must be done
while holding the leaf rcu_node structure's ->lock.

This commit therefore prepares for that fix by moving this lock's
acquisition from rcu_report_exp_cpu_mult() to its callers (all two
of them).

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index fb664d3a01c95..581e88d39542d 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -227,16 +227,16 @@ static void __maybe_unused rcu_report_exp_rnp(struct rcu_node *rnp, bool wake)
 
 /*
  * Report expedited quiescent state for multiple CPUs, all covered by the
- * specified leaf rcu_node structure.
+ * specified leaf rcu_node structure, which is acquired by the caller.
  */
-static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
+static void rcu_report_exp_cpu_mult(struct rcu_node *rnp, unsigned long flags,
 				    unsigned long mask, bool wake)
+				    __releases(rnp->lock)
 {
 	int cpu;
-	unsigned long flags;
 	struct rcu_data *rdp;
 
-	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	raw_lockdep_assert_held_rcu_node(rnp);
 	if (!(rnp->expmask & mask)) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
@@ -257,8 +257,12 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
  */
 static void rcu_report_exp_rdp(struct rcu_data *rdp)
 {
+	unsigned long flags;
+	struct rcu_node *rnp = rdp->mynode;
+
 	WRITE_ONCE(rdp->cpu_no_qs.b.exp, false);
-	rcu_report_exp_cpu_mult(rdp->mynode, rdp->grpmask, true);
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	rcu_report_exp_cpu_mult(rnp, flags, rdp->grpmask, true);
 }
 
 /* Common code for work-done checking. */
@@ -432,8 +436,10 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 	/* Report quiescent states for those that went offline. */
-	if (mask_ofl_test)
-		rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
+	if (mask_ofl_test) {
+		raw_spin_lock_irqsave_rcu_node(rnp, flags);
+		rcu_report_exp_cpu_mult(rnp, flags, mask_ofl_test, false);
+	}
 }
 
 static void rcu_exp_sel_wait_wake(unsigned long s);
-- 
2.40.1

