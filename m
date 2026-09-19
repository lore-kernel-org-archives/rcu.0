Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1042F363F;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777743; cv=none; b=mJY7sGa/aofiXqAQApLNhdAb7q4akFV6ePFRqC0qlNk6SX5tvhVynxR5/An1EyCZkQ0Qnb57S8+Pa244eljiZGS6Ttq9/lmPCUya43xRD2RVXv8P3LsMIjSjNWv5ZI/5/W8qR90J8DMVGkwnkoHyyXNGkLQhge1kPXUY3NCtyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777743; c=relaxed/simple;
	bh=nvQoIx6gQv7E8qFHeuFQhcavJagoOVl+wEtK788m0n4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fiO2fdPzQNwmnKxhPqkjJIvxCqO/i3ryczjdobEf9ftu+Yajn7eKmLuW9Yw70VC9NKzFqLrHDIBTW7fMwTYdjLJiSU5ycoUm8yaJLcjYSkEw6+YF3Duhx0RSoccvGBNC6TNxVmME1uUi+gVlCtB1hLSLH4ULrR21H0ugvBg0KXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6sB1J4b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6sB1J4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C441F0089B;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777741;
	bh=vi8oZSe+Z3oE+eSrcJD3Q70KafHoa5cA6muPToPn83w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L6sB1J4bLtWEk1CrZvQgwgTsL5sJyaJisGISas1lm0FceIIWrTMFwyxcu0UO0PBtU
	 DJHApWG9e894jYf9vvA4DYxiWxNeABnQ0DhYmrp8FGqummXpFe28yb1Qo81gk9eF8r
	 Zv8ZWDQqH70N6zV7q3+TwhSjxVwMfCccw5sH8ZJrIqADovLRgf4K7VLzlZwdmOo8wf
	 gxNpDiNCk9Y+q2wiHwm1jT/GrDdfkYyNIoM3WueMeGa/L0GCWXuzmxlri/Ml4u2E1m
	 dgdcWOGureWkSeYfMyoGUHXBP0fVXRshFbWkGQ6+QPZzAe1bBFP42lu6Fs2Y1JDEft
	 n5fN+d6ZGcwXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4FF6CCE17C1; Fri, 18 Sep 2026 17:29:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 4/9] rcu: Add running and boosted indications to RCU task stall dump
Date: Fri, 18 Sep 2026 17:28:55 -0700
Message-Id: <20260919002900.3134117-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
References: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, rcu_print_task_stall() will dump out the PID, RCU reader
nesting level, the rcu_special structure's flags, and whether or not
that reader is on the ->blkd_tasks list.  When debugging RCU priority
boosting, it is also good to know whether the stalled RCU reader is
currently running and whether it is currently being RCU priority boosted.
This commit therefore adds this information to the output.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 93ba31a619b6..5dded1e89197 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -11,6 +11,7 @@
 #include <linux/kvm_para.h>
 #include <linux/rcu_notifier.h>
 #include <linux/smp.h>
+#include <linux/rtmutex.h>
 
 //////////////////////////////////////////////////////////////////////////////
 //
@@ -305,6 +306,8 @@ struct rcu_stall_chk_rdr {
 	int nesting;
 	union rcu_special rs;
 	bool on_blkd_list;
+	bool rcu_rdr_running;
+	int rcu_rdr_boosted;
 };
 
 /*
@@ -313,6 +316,7 @@ struct rcu_stall_chk_rdr {
  */
 static int check_slow_task(struct task_struct *t, void *arg)
 {
+	struct rcu_node *rnp;
 	struct rcu_stall_chk_rdr *rscrp = arg;
 
 	if (task_curr(t))
@@ -320,6 +324,19 @@ static int check_slow_task(struct task_struct *t, void *arg)
 	rscrp->nesting = t->rcu_read_lock_nesting;
 	rscrp->rs = t->rcu_read_unlock_special;
 	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
+	rscrp->rcu_rdr_running = task_curr(t);
+	rscrp->rcu_rdr_boosted = 0;
+	if (rscrp->on_blkd_list) {
+		rnp = READ_ONCE(t->rcu_blocked_node);
+		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
+		if (rnp == READ_ONCE(t->rcu_blocked_node)) {
+			if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
+				rscrp->rcu_rdr_boosted = 1;
+		} else {
+			rscrp->rcu_rdr_boosted = 2;
+		}
+		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
+	}
 	return 0;
 }
 
@@ -357,12 +374,14 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 		if (task_call_func(t, check_slow_task, &rscr))
 			pr_cont(" P%d", t->pid);
 		else
-			pr_cont(" P%d/%d:%c%c%c%c",
+			pr_cont(" P%d/%d:%c%c%c%c%c%c",
 				t->pid, rscr.nesting,
 				".b"[rscr.rs.b.blocked],
 				".q"[rscr.rs.b.need_qs],
 				".e"[rscr.rs.b.exp_hint],
-				".l"[rscr.on_blkd_list]);
+				".l"[rscr.on_blkd_list],
+				".R"[rscr.rcu_rdr_running],
+				".B?"[rscr.rcu_rdr_boosted]);
 		lockdep_assert_irqs_disabled();
 		put_task_struct(t);
 		ndetected++;
-- 
2.40.1

