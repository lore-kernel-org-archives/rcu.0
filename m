Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532DD2442E3;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059076; cv=none; b=AsP7PcvUIwhJA4/dYrbmZLOxxgl3bBZxhgDdgJIMRSVi8ox9Hzd4UUwtSVMM+rPRjzGywoNJLOVoevQcchkxAn4VKNpRdYpFeZuqD7pnaxdDQn8+fNLrnFacdB6CEfr0Ze+YW7hTb2+7WlJLVP9kVffusZhUTa3UOEo9miZuXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059076; c=relaxed/simple;
	bh=CllbxRXuakn5RgpA5sgvez+XvWvb/koD6YasIx7YiYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=biCwwqLV/YauNYKJepmGDkwdF6eRVSfDkVEkrukL8RiEZIv4JqD5pEiBKZGIoLV81kbMPuFnrGUfOqfFd/IF03GY/Jd942iu0u6ovJAcV95Sn7X/ILR0373qWcYg+U+rZJAREIwcVcpxY3Jb1+KVpi7EqzQgh/0WfA4gem1/cW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K50YDFtO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K50YDFtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD57C4CEE5;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737059076;
	bh=CllbxRXuakn5RgpA5sgvez+XvWvb/koD6YasIx7YiYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K50YDFtOGWyFzEAMxOo1OxhtWuR/FnjIELFE0Jj8pWxOyzmQPMttJoM+wSQ1s2pCm
	 L1H5NInuXT9kPqCdN6/knFmHP4Ckdr210BogzUwuYpfYZnwX7ZgDc82oHzMHff0OLZ
	 TeZ4EmPx4UHwdbkGC1STIgEL0Wed9UNhO0DNneviUimyiBO7HrwihfoBLy/wf6ueEL
	 7PMsH+Anvr6E5uOnfB0bCGln3CrtNnFB/4gF1by5TV2LwbKBO7dUqdEVChkrMQQJfA
	 4xX/L6gMXA29Fo56GPfzga1PGdy/nRY+eVuw92vjbAF5JGHL4iGkW+WZy322ZQndr6
	 SpV7G/dbt93VA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A80F7CE37B6; Thu, 16 Jan 2025 12:24:35 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/11] rcutorture: Expand failure/close-call grace-period output
Date: Thu, 16 Jan 2025 12:24:27 -0800
Message-Id: <20250116202434.3783613-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
References: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With only eight bits per grace-period sequence number, wrap can happen
in 64 grace periods.  This commit therefore increases this to sixteen
bits for normal grace-period sequence numbers and the combined short-form
polling sequence numbers, thus deferring wrap for at least 16,384 grace
periods.  Because expedited grace periods go faster, expand these to 24
bits, deferring wrap for at least 4,194,304 expedited grace periods.
These longer wrap times makes it easier to correlate these numbers to
trace-event output.

Note that the low-order two bits are reserved for intra-grace-period
state, hence the above wrap numbers being a factor of four smaller than
you might expect.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h        |  4 ++--
 kernel/rcu/rcutorture.c | 12 ++++++------
 kernel/rcu/tiny.c       |  8 ++++----
 kernel/rcu/tree.c       | 18 +++++++++---------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 7c14eec7c13ae..d2a91f705a4ab 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -590,8 +590,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 #endif
 static inline void rcu_gp_set_torture_wait(int duration) { }
 #endif
-unsigned long rcutorture_gather_gp_seqs(void);
-void rcutorture_format_gp_seqs(unsigned long seqs, char *cp);
+unsigned long long rcutorture_gather_gp_seqs(void);
+void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp);
 
 #ifdef CONFIG_TINY_SRCU
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7af7de1688466..5b0510c79fde7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -273,8 +273,8 @@ struct rt_read_seg {
 	bool rt_preempted;
 	int rt_cpu;
 	int rt_end_cpu;
-	unsigned long rt_gp_seq;
-	unsigned long rt_gp_seq_end;
+	unsigned long long rt_gp_seq;
+	unsigned long long rt_gp_seq_end;
 };
 static int err_segs_recorded;
 static struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
@@ -409,8 +409,8 @@ struct rcu_torture_ops {
 	void (*gp_slow_register)(atomic_t *rgssp);
 	void (*gp_slow_unregister)(atomic_t *rgssp);
 	bool (*reader_blocked)(void);
-	unsigned long (*gather_gp_seqs)(void);
-	void (*format_gp_seqs)(unsigned long seqs, char *cp);
+	unsigned long long (*gather_gp_seqs)(void);
+	void (*format_gp_seqs)(unsigned long long seqs, char *cp);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -3689,8 +3689,8 @@ rcu_torture_cleanup(void)
 			}
 			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP) &&
 			    cur_ops->gather_gp_seqs && cur_ops->format_gp_seqs) {
-				char buf1[16+1];
-				char buf2[16+1];
+				char buf1[20+1];
+				char buf2[20+1];
 				char sepchar = '-';
 
 				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq, buf1);
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 773944257e796..b97c64e99a905 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -258,15 +258,15 @@ EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 #endif
 
 #if IS_ENABLED(CONFIG_RCU_TORTURE_TEST)
-unsigned long rcutorture_gather_gp_seqs(void)
+unsigned long long rcutorture_gather_gp_seqs(void)
 {
-	return READ_ONCE(rcu_ctrlblk.gp_seq) & 0xff;
+	return READ_ONCE(rcu_ctrlblk.gp_seq) & 0xffffULL;
 }
 EXPORT_SYMBOL_GPL(rcutorture_gather_gp_seqs);
 
-void rcutorture_format_gp_seqs(unsigned long seqs, char *cp)
+void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp)
 {
-	snprintf(cp, 8, "g%02lx", seqs & 0xff);
+	snprintf(cp, 8, "g%04llx", seqs & 0xffffULL);
 }
 EXPORT_SYMBOL_GPL(rcutorture_format_gp_seqs);
 #endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 574a280660624..ac596596e7717 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -560,22 +560,22 @@ void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
 /* Gather grace-period sequence numbers for rcutorture diagnostics. */
-unsigned long rcutorture_gather_gp_seqs(void)
+unsigned long long rcutorture_gather_gp_seqs(void)
 {
-	return ((READ_ONCE(rcu_state.gp_seq) & 0xff) << 16) |
-	       ((READ_ONCE(rcu_state.expedited_sequence) & 0xff) << 8) |
-	       (READ_ONCE(rcu_state.gp_seq_polled) & 0xff);
+	return ((READ_ONCE(rcu_state.gp_seq) & 0xffffULL) << 40) |
+	       ((READ_ONCE(rcu_state.expedited_sequence) & 0xffffffULL) << 16) |
+	       (READ_ONCE(rcu_state.gp_seq_polled) & 0xffffULL);
 }
 EXPORT_SYMBOL_GPL(rcutorture_gather_gp_seqs);
 
 /* Format grace-period sequence numbers for rcutorture diagnostics. */
-void rcutorture_format_gp_seqs(unsigned long seqs, char *cp)
+void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp)
 {
-	unsigned int egp = (seqs >> 8) & 0xff;
-	unsigned int ggp = (seqs >> 16) & 0xff;
-	unsigned int pgp = seqs & 0xff;
+	unsigned int egp = (seqs >> 16) & 0xffffffULL;
+	unsigned int ggp = (seqs >> 40) & 0xffffULL;
+	unsigned int pgp = seqs & 0xffffULL;
 
-	snprintf(cp, 16, "g%02x:e%02x:p%02x", ggp, egp, pgp);
+	snprintf(cp, 20, "g%04x:e%06x:p%04x", ggp, egp, pgp);
 }
 EXPORT_SYMBOL_GPL(rcutorture_format_gp_seqs);
 
-- 
2.40.1

