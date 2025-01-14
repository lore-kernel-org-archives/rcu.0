Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE302040AF;
	Tue, 14 Jan 2025 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851944; cv=none; b=rzi267n6Cy2xJIh2SFwYT51A6oLCoiS7oI0gMQ9ijfKOxj5O9FDi7+kfLBS3iAnkgLT0lySPszn/nB3HfnLjWQS1WBZtAcPfXADFANUH7sebvl5ZD/Xr/r6BBz4Km6z3txH+9R0zpWYtUEMNjIQ0NGQn/diWFxwgLOfJ54YcUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851944; c=relaxed/simple;
	bh=XHDHqBhBTNEsxRmKfNgl9Kie38h1OqgmpR+eE3CSssk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFZDEL16+kuOqHsxd3CaGAZYc42NoE8kfa3SUpbqD/y01g0AqfXkmIHPpXwqgf2S3WnOvDgtDulRRAKfmTS0CeljuiPBMFcZ4q+vaEB7OFNb5CzkesxXkAu7gjX9QX0l5ZJtun9PuOKtT+IjcxqdvJA1qeIeM8e+hZfRO1R03oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMWpRZVj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMWpRZVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD09EC4CEDD;
	Tue, 14 Jan 2025 10:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736851944;
	bh=XHDHqBhBTNEsxRmKfNgl9Kie38h1OqgmpR+eE3CSssk=;
	h=From:To:Cc:Subject:Date:From;
	b=HMWpRZVjIPrzOVarIR/4Mo11rPo3QiotE6VbRD7zfuBLffs2uSof1jWUZsDDPl9FD
	 EQ69EKSagL5eK7tiPIbYdUDh0Br2EdE+3w6U69cPBi8+CbmsIqw2GdV3HW7ffNAIRX
	 DOq1hbQSQj1k1lCmiI1FEmIPPOlsjm5WKKDWj04IwaumU08mLmoQrSz9BA6HjR7IS9
	 QEemz0NVaR21lZ0GMrt9i4yINgi6vMJ4edPNz5yv8hLzvqOfe60ORUhqCoVVhLS/De
	 NLKuO/ssanHR6QAJl1d4OMEuuFNUt90NqBifCp3wIfudUoF9wBoMINdnos+YBg1Fc1
	 8e+KPTZO6DiBA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] srcu: refactor __srcu_read_(un)lock_lite() declarations
Date: Tue, 14 Jan 2025 19:52:13 +0900
Message-ID: <20250114105215.4007622-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For CONFIG_TREE_SRCU, __srcu_read_(un)lock_lite() are defined as static
inline functions in <linux/srcutree.h>. The later function declarations
are redundant.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/srcu.h     | 9 ++-------
 include/linux/srcutree.h | 4 ++--
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 08339eb8a01c..314f0bca6eb7 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -45,6 +45,8 @@ int init_srcu_struct(struct srcu_struct *ssp);
 
 #ifdef CONFIG_TINY_SRCU
 #include <linux/srcutiny.h>
+#define __srcu_read_lock_lite __srcu_read_lock
+#define __srcu_read_unlock_lite __srcu_read_unlock
 #elif defined(CONFIG_TREE_SRCU)
 #include <linux/srcutree.h>
 #else
@@ -56,13 +58,6 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
 void cleanup_srcu_struct(struct srcu_struct *ssp);
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
-#ifdef CONFIG_TINY_SRCU
-#define __srcu_read_lock_lite __srcu_read_lock
-#define __srcu_read_unlock_lite __srcu_read_unlock
-#else // #ifdef CONFIG_TINY_SRCU
-int __srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp);
-void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx) __releases(ssp);
-#endif // #else // #ifdef CONFIG_TINY_SRCU
 void synchronize_srcu(struct srcu_struct *ssp);
 
 #define SRCU_GET_STATE_COMPLETED 0x1
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 490aeecc6bb4..16a7d631c185 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -219,7 +219,7 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
  * or because it is a read-modify-write atomic operation, depending on
  * the whims of the architecture.
  */
-static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
+static inline int __srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int idx;
 
@@ -241,7 +241,7 @@ static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
  * or because it is a read-modify-write atomic operation, depending on
  * the whims of the architecture.
  */
-static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
+static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx) __releases(ssp)
 {
 	barrier();  /* Avoid leaking the critical section. */
 	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);  /* Z */
-- 
2.43.0

