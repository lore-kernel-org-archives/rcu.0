Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BEF43CEFA;
	Thu, 23 Jul 2026 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801079; cv=none; b=stSLb8/LdO4dP/wioGnHDVCZmBWHyXr5j4s2g1Qi7yceCqqIzwUSaVTatwEFQhLQCKwpzDxHxO5kWBvZRtyQX9q1FHnI1u4aow8KQ6bev0iqP/GYKoo28PytV8jmVelbh0gM0Bm/uNMgLOzOf6kIvctjyl2rvd7/UL60fByWrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801079; c=relaxed/simple;
	bh=KUsAmnJc0CtN+YiA+6zA+pu8KFCFPdDbgMWUNo9k45U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cUn78HvF9VW2GoCeHVIV1kiJuJn1m/CetKJ47SxGw8X1jjNrtREsoiqlKwXeOMtgft3nTBkob9Wk0kSXdD1KOSyGRyqJDqhPPzGubmKfaJIRqWdrouvNox1MDaqi+itNRU03oUDMpTu05gAVI2jYuDgMnHNpAq+6srw9YInJ9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CCVnwem/; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CCVnwem/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784801075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=81PQ46SvAF0W4XJpEJC7aw/3dQzv/s4/HjHw+wE1ZJ0=;
	b=CCVnwem/CZ5zO6LPR8OlkmQHkjRZ8e0QLllN2ZUHntlFBmCDF6/HosTKKeKTl3OlWraj54
	I2K35bI8ZswdCF63taQNTz3rT3MhAcsIEX3A6HfBenZFUwX1xLgl+NospT5jmbmg2UjTA8
	q8oO1Y/kgVvbuOD7jDtOIartmaxPqbA=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	urezki@gmail.com,
	boqun@kernel.org
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Reduce stack usage in show_rcu_gp_kthreads()
Date: Thu, 23 Jul 2026 18:04:30 +0800
Message-Id: <20260723100430.17813-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

When CONFIG_KASAN=y and CONFIG_KASAN_STACK=y builds, the
show_rcu_gp_kthreads() exceeds the 1024-byte frame-size limit:

make kernel/rcu/tree.o KCFLAGS="-fstack-usage"
  DESCEND objtool
  DESCEND bpf/resolve_btfids
  INSTALL libsubcmd_headers
  CC      kernel/rcu/tree.o
In file included from kernel/rcu/tree.c:4998:
kernel/rcu/tree_stall.h: In function 'show_rcu_gp_kthreads':
kernel/rcu/tree_stall.h:994:1: warning: the frame size of 1656 bytes is larger than 1024 bytes [-Wframe-larger-than=]

grep show_rcu kernel/rcu/tree.su
tree_nocb.h:1622:13:show_rcu_nocb_state 896     dynamic,bounded
tree_stall.h:933:6:show_rcu_gp_kthreads 1784    dynamic,bounded
tree_stall.h:1102:13:sysrq_show_rcu     16      static

Wrap the pr_info() into two noinline_for_stack helpers function:
show_rcu_state() print rcu_state status, and show_rcu_node()
print single rcu_node status.

After apply this change:

grep show_rcu kernel/rcu/tree.su
tree_stall.h:955:22:show_rcu_node	696	dynamic,bounded
tree_stall.h:930:22:show_rcu_state	872	dynamic,bounded
tree_nocb.h:1622:13:show_rcu_nocb_state	896	dynamic,bounded
tree_stall.h:972:6:show_rcu_gp_kthreads	544	static
tree_stall.h:1113:13:sysrq_show_rcu	16	static

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tree_stall.h | 47 +++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 45b9856ccd2b..a6dfd036a7e9 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -927,20 +927,13 @@ bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
 }
 EXPORT_SYMBOL_GPL(rcu_check_boost_fail);
 
-/*
- * Show the state of the grace-period kthreads.
- */
-void show_rcu_gp_kthreads(void)
+static noinline_for_stack void show_rcu_state(void)
 {
-	unsigned long cbs = 0;
-	int cpu;
 	unsigned long j;
 	unsigned long ja;
 	unsigned long jr;
 	unsigned long js;
 	unsigned long jw;
-	struct rcu_data *rdp;
-	struct rcu_node *rnp;
 	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
 
 	j = jiffies;
@@ -957,21 +950,39 @@ void show_rcu_gp_kthreads(void)
 		(long)data_race(READ_ONCE(rcu_get_root()->gp_seq_needed)),
 		data_race(READ_ONCE(rcu_state.gp_max)),
 		data_race(READ_ONCE(rcu_state.gp_flags)));
+}
+
+static noinline_for_stack void show_rcu_node(struct rcu_node *rnp)
+{
+	pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
+		rnp->grplo, rnp->grphi,
+		(long)data_race(READ_ONCE(rnp->gp_seq)),
+		(long)data_race(READ_ONCE(rnp->gp_seq_needed)),
+		data_race(READ_ONCE(rnp->qsmask)),
+		".b"[!!data_race(READ_ONCE(rnp->boost_kthread_task))],
+		".B"[!!data_race(READ_ONCE(rnp->boost_tasks))],
+		".E"[!!data_race(READ_ONCE(rnp->exp_tasks))],
+		".G"[!!data_race(READ_ONCE(rnp->gp_tasks))],
+		data_race(READ_ONCE(rnp->n_boosts)));
+}
+
+/*
+ * Show the state of the grace-period kthreads.
+ */
+void show_rcu_gp_kthreads(void)
+{
+	unsigned long cbs = 0;
+	int cpu;
+	struct rcu_data *rdp;
+	struct rcu_node *rnp;
+
+	show_rcu_state();
 	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq), READ_ONCE(rnp->gp_seq_needed)) &&
 		    !data_race(READ_ONCE(rnp->qsmask)) && !data_race(READ_ONCE(rnp->boost_tasks)) &&
 		    !data_race(READ_ONCE(rnp->exp_tasks)) && !data_race(READ_ONCE(rnp->gp_tasks)))
 			continue;
-		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
-			rnp->grplo, rnp->grphi,
-			(long)data_race(READ_ONCE(rnp->gp_seq)),
-			(long)data_race(READ_ONCE(rnp->gp_seq_needed)),
-			data_race(READ_ONCE(rnp->qsmask)),
-			".b"[!!data_race(READ_ONCE(rnp->boost_kthread_task))],
-			".B"[!!data_race(READ_ONCE(rnp->boost_tasks))],
-			".E"[!!data_race(READ_ONCE(rnp->exp_tasks))],
-			".G"[!!data_race(READ_ONCE(rnp->gp_tasks))],
-			data_race(READ_ONCE(rnp->n_boosts)));
+		show_rcu_node(rnp);
 		if (!rcu_is_leaf_node(rnp))
 			continue;
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
-- 
2.17.1

