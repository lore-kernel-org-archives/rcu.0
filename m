Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C11F1909;
	Thu, 30 Jan 2025 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263886; cv=none; b=L3p1VvSrbPA6nvj77f2yUu6z31ogKkJ1uoZu0kij0wDSII495ONq+JzuWWbyJreJFNeqxFAzR/WMUgxxwszCzCqBUTDjYKA4X9zbeEZmq440dftO8SHQmgVZjbOh+xWmQslCd/iemKY0fEvgWAoj+stAJ71jU4bcvJAzFbqBsG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263886; c=relaxed/simple;
	bh=gFnmkAYqjurcLuodZiG/vOrkertezCGXKFhOcFWMl6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BUXJAxLwfP64xggctfpi29pq67shePc7yAMxeAbNEWedBPh19WY197IjSj6FJ0T4otHpA9HfrizHa7eT2qOAJao11InWg/sOxg2ARaIa5DdddkpKGBAuDJ6VPYEXg1kX5pd6I22rlJeOSWAQi18VfW/7h9xmRgGMsWeDkgzh8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4a/HAJ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4a/HAJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64CAC4AF0C;
	Thu, 30 Jan 2025 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263885;
	bh=gFnmkAYqjurcLuodZiG/vOrkertezCGXKFhOcFWMl6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4a/HAJ/k/fGiKK8GxFKppH8KKTY3a1bcFPLqHg9UvY6BhZGjxuBlKHJTjcNMHMBr
	 ChDCwrYaYuFGLp+GIwFWrOPnHfSgND4NymdEnB+0mJ3asjjUh2ZICqNhhpj/jfFhVi
	 erUgx0bl58EzhKLzMcv5Ko0WaW7070KJ3b7gnwD3ai6/kkf3++pVmlVPCEeXNNF2sR
	 iXia1B5pTrbU2cFiOfG9/fjFT9usjSpj9ny+ZDRxDC44EcsvSHns94/He61qPDT1H2
	 iZ1NA35kWjOcHyMMmz+CExzc/M8cYZRsulDwEvDP/MQma9K/su2Ak6zQc8WjA3p1V7
	 3egd1M02vzcsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7C332CE37DC; Thu, 30 Jan 2025 11:04:45 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu v2] 03/11] rcutorture: Include grace-period sequence numbers in failure/close-call
Date: Thu, 30 Jan 2025 11:04:36 -0800
Message-Id: <20250130190444.1652700-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
References: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit includes the grace-period sequence numbers at the beginning
and end of each segment in the "Failure/close-call rcutorture reader
segments" list.  These are in hexadecimal, and only the bottom byte.
Currently, only RCU is supported, with its three sequence numbers (normal,
expedited, and polled).

Note that if all the grace-period sequence numbers remain the same across
a given reader segment, only one copy of the number will be printed.
Of course, if there is a change, both sets of values will be printed.

Because the overhead of collecting this information can suppress
heisenbugs, this information is collected and printed only in kernels
built with CONFIG_RCU_TORTURE_TEST_LOG_GP=y.

[ paulmck: Apply Nathan Chancellor feedback for IS_ENABLED(). ]
[ paulmck: Apply feedback from kernel test robot. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
---
 kernel/rcu/Kconfig.debug | 14 ++++++++++++++
 kernel/rcu/rcu.h         |  2 ++
 kernel/rcu/rcutorture.c  | 34 ++++++++++++++++++++++++++++++++++
 kernel/rcu/tiny.c        | 14 ++++++++++++++
 kernel/rcu/tree.c        | 20 ++++++++++++++++++++
 5 files changed, 84 insertions(+)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 6af90510a1ca..25a9dc2be0dc 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -84,6 +84,20 @@ config RCU_TORTURE_TEST_LOG_CPU
 	  Say Y here if you want CPU IDs logged.
 	  Say N if you are unsure.
 
+config RCU_TORTURE_TEST_LOG_GP
+	bool "Log grace-period numbers for rcutorture failures"
+	depends on RCU_TORTURE_TEST
+	default n
+	help
+	  This option causes rcutorture to decorate each entry of its
+	  log of failure/close-call rcutorture reader segments with the
+	  corresponding grace-period sequence numbers.	This information
+	  can be useful, but it does incur additional overhead, overhead
+	  that can make both failures and close calls less probable.
+
+	  Say Y here if you want grace-period sequence numbers logged.
+	  Say N if you are unsure.
+
 config RCU_REF_SCALE_TEST
 	tristate "Scalability tests for read-side synchronization (RCU and others)"
 	depends on DEBUG_KERNEL
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index f6fcf87d9139..7c14eec7c13a 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -590,6 +590,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 #endif
 static inline void rcu_gp_set_torture_wait(int duration) { }
 #endif
+unsigned long rcutorture_gather_gp_seqs(void);
+void rcutorture_format_gp_seqs(unsigned long seqs, char *cp);
 
 #ifdef CONFIG_TINY_SRCU
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 978893398465..7af7de168846 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -273,6 +273,8 @@ struct rt_read_seg {
 	bool rt_preempted;
 	int rt_cpu;
 	int rt_end_cpu;
+	unsigned long rt_gp_seq;
+	unsigned long rt_gp_seq_end;
 };
 static int err_segs_recorded;
 static struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
@@ -407,6 +409,8 @@ struct rcu_torture_ops {
 	void (*gp_slow_register)(atomic_t *rgssp);
 	void (*gp_slow_unregister)(atomic_t *rgssp);
 	bool (*reader_blocked)(void);
+	unsigned long (*gather_gp_seqs)(void);
+	void (*format_gp_seqs)(unsigned long seqs, char *cp);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -611,6 +615,8 @@ static struct rcu_torture_ops rcu_ops = {
 	.reader_blocked		= IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU)
 				  ? has_rcu_reader_blocked
 				  : NULL,
+	.gather_gp_seqs		= rcutorture_gather_gp_seqs,
+	.format_gp_seqs		= rcutorture_format_gp_seqs,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -656,6 +662,8 @@ static struct rcu_torture_ops rcu_busted_ops = {
 	.sync		= synchronize_rcu_busted,
 	.exp_sync	= synchronize_rcu_busted,
 	.call		= call_rcu_busted,
+	.gather_gp_seqs	= rcutorture_gather_gp_seqs,
+	.format_gp_seqs	= rcutorture_format_gp_seqs,
 	.irq_capable	= 1,
 	.extendables	= RCUTORTURE_MAX_EXTEND,
 	.name		= "busted"
@@ -1989,6 +1997,12 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 				rtrsp[-1].rt_preempted = cur_ops->reader_blocked();
 		}
 	}
+	// Sample grace-period sequence number, as good a place as any.
+	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP) && cur_ops->gather_gp_seqs) {
+		rtrsp->rt_gp_seq = cur_ops->gather_gp_seqs();
+		if (!first)
+			rtrsp[-1].rt_gp_seq_end = rtrsp->rt_gp_seq;
+	}
 
 	/*
 	 * Next, remove old protection, in decreasing order of strength
@@ -3577,6 +3591,7 @@ rcu_torture_cleanup(void)
 	int flags = 0;
 	unsigned long gp_seq = 0;
 	int i;
+	int j;
 
 	if (torture_cleanup_begin()) {
 		if (cur_ops->cb_barrier != NULL) {
@@ -3672,6 +3687,25 @@ rcu_torture_cleanup(void)
 				else
 					pr_cont(" ...");
 			}
+			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP) &&
+			    cur_ops->gather_gp_seqs && cur_ops->format_gp_seqs) {
+				char buf1[16+1];
+				char buf2[16+1];
+				char sepchar = '-';
+
+				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq, buf1);
+				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq_end, buf2);
+				if (err_segs[i].rt_gp_seq == err_segs[i].rt_gp_seq_end) {
+					if (buf2[0]) {
+						for (j = 0; buf2[j]; j++)
+							buf2[j] = '.';
+						if (j)
+							buf2[j - 1] = ' ';
+					}
+					sepchar = ' ';
+				}
+				pr_cont(" %s%c%s", buf1, sepchar, buf2);
+			}
 			if (err_segs[i].rt_delay_ms != 0) {
 				pr_cont(" %s%ldms", firsttime ? "" : "+",
 					err_segs[i].rt_delay_ms);
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index b3b3ce34df63..773944257e79 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -257,6 +257,20 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 #endif
 
+#if IS_ENABLED(CONFIG_RCU_TORTURE_TEST)
+unsigned long rcutorture_gather_gp_seqs(void)
+{
+	return READ_ONCE(rcu_ctrlblk.gp_seq) & 0xff;
+}
+EXPORT_SYMBOL_GPL(rcutorture_gather_gp_seqs);
+
+void rcutorture_format_gp_seqs(unsigned long seqs, char *cp)
+{
+	snprintf(cp, 8, "g%02lx", seqs & 0xff);
+}
+EXPORT_SYMBOL_GPL(rcutorture_format_gp_seqs);
+#endif
+
 void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9ba34206e20d..574a28066062 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -559,6 +559,26 @@ void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 }
 EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
+/* Gather grace-period sequence numbers for rcutorture diagnostics. */
+unsigned long rcutorture_gather_gp_seqs(void)
+{
+	return ((READ_ONCE(rcu_state.gp_seq) & 0xff) << 16) |
+	       ((READ_ONCE(rcu_state.expedited_sequence) & 0xff) << 8) |
+	       (READ_ONCE(rcu_state.gp_seq_polled) & 0xff);
+}
+EXPORT_SYMBOL_GPL(rcutorture_gather_gp_seqs);
+
+/* Format grace-period sequence numbers for rcutorture diagnostics. */
+void rcutorture_format_gp_seqs(unsigned long seqs, char *cp)
+{
+	unsigned int egp = (seqs >> 8) & 0xff;
+	unsigned int ggp = (seqs >> 16) & 0xff;
+	unsigned int pgp = seqs & 0xff;
+
+	snprintf(cp, 16, "g%02x:e%02x:p%02x", ggp, egp, pgp);
+}
+EXPORT_SYMBOL_GPL(rcutorture_format_gp_seqs);
+
 #if defined(CONFIG_NO_HZ_FULL) && (!defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK))
 /*
  * An empty function that will trigger a reschedule on
-- 
2.40.1

