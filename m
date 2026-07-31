Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD44222565;
	Fri, 31 Jul 2026 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460042; cv=none; b=Myxm0F1JRFW+8pZ735UrQ6AmllFSJMM2xYDIPhJvGfNMNdPsVAveEuUEeirX0AuH43mg/QtKP/5ZDw1lHgtRALw5JXMUVp/ibs1O8rRwpEVJOkHf3MgGMdKAmcFQHmjp1uMhs5B/cjx5TkVtUPZSH/6Q5kHQlk8blJLUvfD0JOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460042; c=relaxed/simple;
	bh=6Xs3jwDoSFtHtLmZe767+cTvDIZN3KlwcFjw/arZtkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=txYj1q9XOR1gljJiIXqX0G1j7t7Z4FBEIGMqtphcrR9E4iFE0+BQvUJNJWP09EVdGX+JxlpmNQPB1OYVNXNaqvHmKR8SqixWJR1DSWfVlTfVDxcGCRQN8HRPxqn1yy9JGV1g424vF6eORcllFkRu2y4zHCW3WVqwh25bPDqAh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFA2zt62; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFA2zt62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A768A1F000E9;
	Fri, 31 Jul 2026 01:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460040;
	bh=n+oAf3hk5jmN4VFVeAO70gcuYbRCnvfHxBQClN5hEMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BFA2zt62a/2T/Trp6k7K6o9c6Jisx8LarFalujjoG1Tb6E0CXF3dzgjPbBubYWiMX
	 JAzKDq8PlqK3ZZCTak4XYLSWb5YRW8gi/0yO0Ii/Mxts95A4FyyFSUlZ1j8JwShZ1b
	 NFXK/O5YLT5xiMFu6fUz7RNNwmChHN4xzT8avQhEcfvKxs0cPpVUpI9xwmJnIHaT23
	 S7MlqfwqveLyn2ZcKd71+3ISFcmNd26BwTkpmGd0I/NsYzQPsnPbHgKwN+iWf7ljY+
	 +9ZYT7gcz5vXdUaqOcAb2+jgffwxjT9qFbWe+w7spBtqJxAwwsl/15IvjVHbyVEkTX
	 sEHKk3kiCX34Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8021ECE0F69; Thu, 30 Jul 2026 18:07:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 01/13] rcutorture: Abstract reader-segment dump into rcu_torture_dump_read_segs()
Date: Thu, 30 Jul 2026 18:07:07 -0700
Message-Id: <20260731010719.3531912-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
References: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit abstracts the open-coded dumping of reader segments in the
rcu_torture_cleanup() function into a new rcu_torture_dump_read_segs()
function.  This abstraction will allow reader segments to be dumped for
other purposes.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 148 +++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 72 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 882a158ada7bbd..ffeca1b7e17016 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2401,6 +2401,80 @@ struct rcu_torture_one_read_state {
 	unsigned long long ts;
 };
 
+static void rcu_torture_dump_read_segs(struct rt_read_seg *rrsp, int nsegs)
+{
+	bool firsttime;
+	int i;
+	int j;
+
+	firsttime = 1;
+	for (i = 0; i < nsegs; i++) {
+		if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP))
+			pr_alert("\t%lluus ", div64_u64(rrsp[i].rt_ts, 1000ULL));
+		else
+			pr_alert("\t");
+		pr_cont("%d: %#4x", i, rrsp[i].rt_readstate);
+		if (rrsp[i].rt_delay_jiffies != 0) {
+			pr_cont("%s%ldjiffies", firsttime ? "" : "+",
+				rrsp[i].rt_delay_jiffies);
+			firsttime = 0;
+		}
+		if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU)) {
+			pr_cont(" CPU %2d", rrsp[i].rt_cpu);
+			if (rrsp[i].rt_cpu != rrsp[i].rt_end_cpu)
+				pr_cont("->%-2d", rrsp[i].rt_end_cpu);
+			else
+				pr_cont(" ...");
+		}
+		if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP) &&
+		    cur_ops->gather_gp_seqs && cur_ops->format_gp_seqs) {
+			char buf1[20+1];
+			char buf2[20+1];
+			char sepchar = '-';
+
+			cur_ops->format_gp_seqs(rrsp[i].rt_gp_seq, buf1, ARRAY_SIZE(buf1));
+			cur_ops->format_gp_seqs(rrsp[i].rt_gp_seq_end, buf2, ARRAY_SIZE(buf2));
+			if (rrsp[i].rt_gp_seq == rrsp[i].rt_gp_seq_end) {
+				if (buf2[0]) {
+					for (j = 0; buf2[j]; j++)
+						buf2[j] = '.';
+					if (j)
+						buf2[j - 1] = ' ';
+				}
+				sepchar = ' ';
+			}
+			pr_cont(" %s%c%s", buf1, sepchar, buf2);
+		}
+		if (rrsp[i].rt_delay_ms != 0) {
+			pr_cont(" %s%ldms", firsttime ? "" : "+", rrsp[i].rt_delay_ms);
+			firsttime = 0;
+		}
+		if (rrsp[i].rt_delay_us != 0) {
+			pr_cont(" %s%ldus", firsttime ? "" : "+", rrsp[i].rt_delay_us);
+			firsttime = 0;
+		}
+		pr_cont("%s", rrsp[i].rt_preempted ? " preempted" : "");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_BH)
+			pr_cont(" BH");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_IRQ)
+			pr_cont(" IRQ");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_PREEMPT)
+			pr_cont(" PREEMPT");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_RBH)
+			pr_cont(" RBH");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_SCHED)
+			pr_cont(" SCHED");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_RCU_1)
+			pr_cont(" RCU_1");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_RCU_2)
+			pr_cont(" RCU_2");
+		pr_cont("\n");
+
+	}
+	if (rt_read_preempted)
+		pr_alert("\tReader was preempted.\n");
+}
+
 static void init_rcu_torture_one_read_state(struct rcu_torture_one_read_state *rtorsp,
 					    struct torture_random_state *trsp)
 {
@@ -4094,11 +4168,9 @@ static void rcu_gpwrap_lag_cleanup(void)
 static void
 rcu_torture_cleanup(void)
 {
-	int firsttime;
 	int flags = 0;
 	unsigned long gp_seq = 0;
 	int i;
-	int j;
 
 	if (torture_cleanup_begin()) {
 		if (cur_ops->cb_barrier != NULL) {
@@ -4183,76 +4255,8 @@ rcu_torture_cleanup(void)
 		pr_alert("Failure/close-call rcutorture reader segments:\n");
 		if (rt_read_nsegs == 0)
 			pr_alert("\t: No segments recorded!!!\n");
-		firsttime = 1;
-		for (i = 0; i < rt_read_nsegs; i++) {
-			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP))
-				pr_alert("\t%lluus ", div64_u64(err_segs[i].rt_ts, 1000ULL));
-			else
-				pr_alert("\t");
-			pr_cont("%d: %#4x", i, err_segs[i].rt_readstate);
-			if (err_segs[i].rt_delay_jiffies != 0) {
-				pr_cont("%s%ldjiffies", firsttime ? "" : "+",
-					err_segs[i].rt_delay_jiffies);
-				firsttime = 0;
-			}
-			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU)) {
-				pr_cont(" CPU %2d", err_segs[i].rt_cpu);
-				if (err_segs[i].rt_cpu != err_segs[i].rt_end_cpu)
-					pr_cont("->%-2d", err_segs[i].rt_end_cpu);
-				else
-					pr_cont(" ...");
-			}
-			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP) &&
-			    cur_ops->gather_gp_seqs && cur_ops->format_gp_seqs) {
-				char buf1[20+1];
-				char buf2[20+1];
-				char sepchar = '-';
-
-				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq,
-							buf1, ARRAY_SIZE(buf1));
-				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq_end,
-							buf2, ARRAY_SIZE(buf2));
-				if (err_segs[i].rt_gp_seq == err_segs[i].rt_gp_seq_end) {
-					if (buf2[0]) {
-						for (j = 0; buf2[j]; j++)
-							buf2[j] = '.';
-						if (j)
-							buf2[j - 1] = ' ';
-					}
-					sepchar = ' ';
-				}
-				pr_cont(" %s%c%s", buf1, sepchar, buf2);
-			}
-			if (err_segs[i].rt_delay_ms != 0) {
-				pr_cont(" %s%ldms", firsttime ? "" : "+",
-					err_segs[i].rt_delay_ms);
-				firsttime = 0;
-			}
-			if (err_segs[i].rt_delay_us != 0) {
-				pr_cont(" %s%ldus", firsttime ? "" : "+",
-					err_segs[i].rt_delay_us);
-				firsttime = 0;
-			}
-			pr_cont("%s", err_segs[i].rt_preempted ? " preempted" : "");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_BH)
-				pr_cont(" BH");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_IRQ)
-				pr_cont(" IRQ");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_PREEMPT)
-				pr_cont(" PREEMPT");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_RBH)
-				pr_cont(" RBH");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_SCHED)
-				pr_cont(" SCHED");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_RCU_1)
-				pr_cont(" RCU_1");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_RCU_2)
-				pr_cont(" RCU_2");
-			pr_cont("\n");
-
-		}
-		if (rt_read_preempted)
-			pr_alert("\tReader was preempted.\n");
+		else
+			rcu_torture_dump_read_segs(err_segs, rt_read_nsegs);
 	}
 	if (atomic_read(&n_rcu_torture_error) || n_rcu_torture_barrier_error)
 		rcu_torture_print_module_parms(cur_ops, "End of test: FAILURE");
-- 
2.40.1

