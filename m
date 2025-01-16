Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA32442D9;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059076; cv=none; b=o5PiU/GqFjZwk8SkcJRYL9fYB79J4ZR4HSMeaRYV9xM+a6vVV9YGoHe1rXJX9Ef8Bkw9KvIzkBmwhxiBiowDQ/b4czlFvDYkq6zr34+mfHZjAbpwXjTYmZ5DoGbC27vDWNqoNEQkiDsPFwazm3DkcMWiNYoN5PZMZdz2s7okSnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059076; c=relaxed/simple;
	bh=pzDQ9rnnwo68H+iTYTDw1mS+6LjzLcLHRtTMGGlwxsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CLannAwmRgsWe7pl63CTTg92+kfY6esLlAbz0hmmL6S3Cra4W3WM0ezs5Fj9sYjtOIzwB2E8nOjDPDWWPvToTr/RZ6lPOHJH6nPHAk80TTLY6tWzx3KFVwXwnv9k+AJ6r+xPXfDOq2SahJMB9z5eQ4f0UihqtI8swqjq1r2wwLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxY0RE9k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxY0RE9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB95C4CEED;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737059076;
	bh=pzDQ9rnnwo68H+iTYTDw1mS+6LjzLcLHRtTMGGlwxsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxY0RE9kr6yF/P2noBfoJanOIRbMh3fHkp1DFrqHoBmrKFHkqLvt98ISZ8qjHcyZx
	 0N5ApZKntmrQUQnJ3TyLMtENsVcx/2Bxpdnsg/pKS5vcUgRh8GwkIUqQ/daVjuip3U
	 Nqzm2QuYZLxL4ugySzTgN04XAOL7st1Wo7ynOgBJ5qKXA+M2wIHFiJHB31lCNcs6NJ
	 wPy0Wp5bbIB2nR9gh56WO5ozSl91L4ofsIEdw3DUcKTyRT3+zk49n7ZlvplPbgjsB0
	 ZTJvQpuxR76gI87B6zjZ9kycN1OP2l5yxIemXR3eFEAylHpKEJouxdaAo7YDMSjnUC
	 d2H71tO1dkI9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AEA28CE37D2; Thu, 16 Jan 2025 12:24:35 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/11] rcutorture: Make cur_ops->format_gp_seqs take buffer length
Date: Thu, 16 Jan 2025 12:24:30 -0800
Message-Id: <20250116202434.3783613-7-paulmck@kernel.org>
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

The Tree and Tiny implementations of rcutorture_format_gp_seqs() use
hard-coded constants for the length of the buffer that they format into.
This is of course an accident waiting to happen, so this commit therefore
makes them take a length argument.  The rcutorture calling code uses
ARRAY_SIZE() to safely compute this new argument.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h        | 2 +-
 kernel/rcu/rcutorture.c | 8 +++++---
 kernel/rcu/tiny.c       | 4 ++--
 kernel/rcu/tree.c       | 4 ++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index d2a91f705a4ab..eed2951a4962d 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -591,7 +591,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 static inline void rcu_gp_set_torture_wait(int duration) { }
 #endif
 unsigned long long rcutorture_gather_gp_seqs(void);
-void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp);
+void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len);
 
 #ifdef CONFIG_TINY_SRCU
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0f5a945427190..2e6e8664e4038 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -411,7 +411,7 @@ struct rcu_torture_ops {
 	void (*gp_slow_unregister)(atomic_t *rgssp);
 	bool (*reader_blocked)(void);
 	unsigned long long (*gather_gp_seqs)(void);
-	void (*format_gp_seqs)(unsigned long long seqs, char *cp);
+	void (*format_gp_seqs)(unsigned long long seqs, char *cp, size_t len);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -3699,8 +3699,10 @@ rcu_torture_cleanup(void)
 				char buf2[20+1];
 				char sepchar = '-';
 
-				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq, buf1);
-				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq_end, buf2);
+				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq,
+							buf1, ARRAY_SIZE(buf1));
+				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq_end,
+							buf2, ARRAY_SIZE(buf2));
 				if (err_segs[i].rt_gp_seq == err_segs[i].rt_gp_seq_end) {
 					if (buf2[0]) {
 						for (j = 0; buf2[j]; j++)
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index b97c64e99a905..6380fbd27557a 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -264,9 +264,9 @@ unsigned long long rcutorture_gather_gp_seqs(void)
 }
 EXPORT_SYMBOL_GPL(rcutorture_gather_gp_seqs);
 
-void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp)
+void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len)
 {
-	snprintf(cp, 8, "g%04llx", seqs & 0xffffULL);
+	snprintf(cp, len, "g%04llx", seqs & 0xffffULL);
 }
 EXPORT_SYMBOL_GPL(rcutorture_format_gp_seqs);
 #endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ac596596e7717..1d201455aa7c3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -569,13 +569,13 @@ unsigned long long rcutorture_gather_gp_seqs(void)
 EXPORT_SYMBOL_GPL(rcutorture_gather_gp_seqs);
 
 /* Format grace-period sequence numbers for rcutorture diagnostics. */
-void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp)
+void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len)
 {
 	unsigned int egp = (seqs >> 16) & 0xffffffULL;
 	unsigned int ggp = (seqs >> 40) & 0xffffULL;
 	unsigned int pgp = seqs & 0xffffULL;
 
-	snprintf(cp, 20, "g%04x:e%06x:p%04x", ggp, egp, pgp);
+	snprintf(cp, len, "g%04x:e%06x:p%04x", ggp, egp, pgp);
 }
 EXPORT_SYMBOL_GPL(rcutorture_format_gp_seqs);
 
-- 
2.40.1

