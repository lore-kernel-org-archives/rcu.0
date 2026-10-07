Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CA3EC2FF;
	Wed,  7 Oct 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405914; cv=none; b=hdTJ+GGX6IXOFCirNVqR27KeTULgqUzKXMjWHAnHL+ACUIU1KSbR3mCBuA1d2p+o9tK4EU+uC9OyAh24pQlWQrCL1X6h9Tj1AsGuV8svY3OX9V1eLOJO6kud7oZcnoT6Usafxdp4C3orpsyhC7NhAoRZMlpxnWBVGNeu53Tqzxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405914; c=relaxed/simple;
	bh=z/4rr+KDx1LEWNRbAPN0WayNMm7IGVD7gz/AhBku0zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lVTdHI5H8bp47PpCfrd5Vjo6+tPK1XqvCxxC5suWDcg1iC2rrwBI0cAPEM2iYCknHDLBes2mADtSeBOjSSOe9mFgBs4liHzLTeNe3AIy0F65q7qfyF3dYxiIDGioyB7kgB4oOFnzR/lhSBECd+3gGRyCZyZ3rifVWkYqtLbuGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtLRyixv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtLRyixv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961311F00899;
	Wed,  7 Oct 2026 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405913;
	bh=/iNO+8ie2nrE8OqoU3fGnSkJAbqrW9dj3DKud6f8rf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NtLRyixvuXvJTMyPUI7nFHPiDmAOUbzuILc+zvOIHObS7fj/ufAJmfpxIfncX0iOU
	 jIXelyatatj1cMw4BLFJx8kiNqqXdqoQKzxYNIciuN8llc+epyCECwDZ6RcJ2NUTsL
	 U4wgjvMutxNGV765UNG1DmWXZorze7xkcNN1dVM6W1ZQz8X2WRkRjQV+gl/fSUUPSK
	 tKWak8a/88jGJ0vi3YJoEv77StLd2+pNrDOg9errBn9Ir2uuuBfBcy78eiRGBXTsSV
	 z3huXV4BY5jOyF5P4p9JWzJbPKgLpc5WnTWUhKGqSX/jRQl0nlpVv9tdb2f3J9uX86
	 AHQ21rgDNMITQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2C13DCE1DC2; Wed,  7 Oct 2026 13:45:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v2 04/10] rcu: Add running and boosted indications to RCU task stall dump
Date: Wed,  7 Oct 2026 13:45:05 -0700
Message-Id: <20261007204511.1982646-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
References: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
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
[ paulmck: Apply feedback from Arnd Bergmann and kernel test robot. ]

Link: https://lore.kernel.org/all/20260925133922.1356404-1-arnd@kernel.org/
Link: https://lore.kernel.org/all/202609261005.GrnaXBXT-lkp@intel.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Tested-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/tree_plugin.h |  2 --
 kernel/rcu/tree_stall.h  | 24 ++++++++++++++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 743c16247fc05..ae5d21bae7bc0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -11,8 +11,6 @@
  *	   Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
-#include "../locking/rtmutex_common.h"
-
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 {
 	/*
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 93ba31a619b67..803a56af3259f 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -11,6 +11,8 @@
 #include <linux/kvm_para.h>
 #include <linux/rcu_notifier.h>
 #include <linux/smp.h>
+#include <linux/rtmutex.h>
+#include "../locking/rtmutex_common.h"
 
 //////////////////////////////////////////////////////////////////////////////
 //
@@ -305,6 +307,8 @@ struct rcu_stall_chk_rdr {
 	int nesting;
 	union rcu_special rs;
 	bool on_blkd_list;
+	bool rcu_rdr_running;
+	int rcu_rdr_boosted;
 };
 
 /*
@@ -313,6 +317,7 @@ struct rcu_stall_chk_rdr {
  */
 static int check_slow_task(struct task_struct *t, void *arg)
 {
+	struct rcu_node *rnp;
 	struct rcu_stall_chk_rdr *rscrp = arg;
 
 	if (task_curr(t))
@@ -320,6 +325,19 @@ static int check_slow_task(struct task_struct *t, void *arg)
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
 
@@ -357,12 +375,14 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
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

