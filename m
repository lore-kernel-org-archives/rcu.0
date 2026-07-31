Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488E2E736D;
	Fri, 31 Jul 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459718; cv=none; b=mm44IUM1/k0Z7AL1C47vSZav49aEjdF+9nIxCs4EzNL/IzcEjarxWitnrwH+hgFgQ+z7HvdWRUoEoAWJv0OP/lOiGHj1nyD87PiroR9BLqiUAfdSKdOOFyUL5mJQ8fFBnoQwKOaKkygKl+xbyLXuUNxxNumWyAHURc88PSSXmCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459718; c=relaxed/simple;
	bh=s2CwlRfCct6t9x6RRZxvV5lxYUPkezJqvXdfzesKwUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c18i8djOBdEWltoQ8LX7q49gyrvO0sot3K4zlz9k2WKv8XF083R41CEQfjOq0NR3/iXz8N+U1T+PhLAiulVOhjwIyzSPiPEFqpXcGyJGAPQ92As509ar55sJp9SfzE/v5ieXNuMUbOOqIduA+Lk+lSGBSKIr4Xqr15PPnw7RGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEGavETn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEGavETn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F5D1F0155E;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459715;
	bh=zBVVmWWxAq5z4UE2XkEILIkHspGzzHIP0ODNGBb69JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NEGavETnIVm/WYh0U0luJGngciBxGPMS+Ox72Y6nlcAMv8q9IwZB0+quRPFEF2126
	 eDWSsc3BInHGhx7QEzrUZtqwGngsrCYPPBHxz5aKO4VtJNHzY6GXBnBrJMslJKRlN9
	 9yASlEpng6cUoil9nH18uNa4GIUGeeC3uVLpLuestyGQEpSDj2JU9LOXa4cYdQeVTj
	 RBJ0ACjOPdQaewah6t9oWaxKn+4VoR9W5OOT25zYBeHyA8yKuCv4CF5hJwiF5jVqRt
	 QOW8agG9xYLbvfvvf8tkvZk2Lc9Ahjv9qSjdpNHlyQXpOqZsjBXb8WgNAVM3iAhyg/
	 5dd4//mB+x0dw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C6866CE1A3C; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 15/16] rcu: Reduce stack usage in show_rcu_gp_kthreads()
Date: Thu, 30 Jul 2026 18:01:52 -0700
Message-Id: <20260731010153.3531313-15-paulmck@kernel.org>
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

From: Zqiang <qiang.zhang@linux.dev>

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 47 +++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 02684dadb4ee08..20634edfb44d8a 100644
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
2.40.1

