Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8B205AC2;
	Tue, 12 Nov 2024 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375105; cv=none; b=qYr/TZ+6fq4MHcYXq4dbIslhOAYxkGo3l1YBIy2bUhgKLd/pCnEgN8xVhadXVuWk0BekAJXjA0+s8DKxhDerlnxKQTYhFN3vOYoOM9vJxPAQBm2qb3PfG56W2iyKTK+H/XlfLFfoGM1S0qA1YykCBv2EUw9cVcxTGh48GQzoGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375105; c=relaxed/simple;
	bh=+MUnT2ixsByPRqgZLMCXaVOCAlMUjkJamTfkr8KcD0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tNakR7+NjHmUSjnOvNXQWFQiBWVBQqq59aQRZQrhkhRrXzHbnqr45c8YakUJk+gIelVguR8aHnHtqogNYLflRlJXd7tHf7ZPtZ+YDRs5MDp2gFuJRjI+ty88ewr3Osi3o86TlV1C0G4JY61mOPg6PbJD+j6nU4Rvvg5IOzMS+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzzpMlWt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzzpMlWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C17C4CED5;
	Tue, 12 Nov 2024 01:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731375105;
	bh=+MUnT2ixsByPRqgZLMCXaVOCAlMUjkJamTfkr8KcD0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fzzpMlWthttpkPhQSgqy31GAfo9FZJfvIkMZDyIvoaoa4UAz2QOkzznOZRWCxFd36
	 LZ4ruAnbM+cYFQDTpemIyv0elL7o09TEwyO1+e+kYNJlRWrl9qOrX/ltjw9p3faxEx
	 idX1BJQi1Dkf5CjwlVlIFGxrOTbjDu6zEIfMcIOfs5vqDa8jO+tuY/A+gbusHJsAi2
	 L8eYUEJMvL6KlYNG2Qr+aBK5i1ZEIMHM2cBuMMC80aoVptkbJ5uEfkYPgoDwR0RB03
	 3UqVS7wY8MPIx0XxMTLBkgF0vobQAFC4jvsiH37YEEFHfkOTzANmCq+q4V5c5jE2Sk
	 vmrMpKeET3Vgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C052FCE0D89; Mon, 11 Nov 2024 17:31:44 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	frederic@kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH rcu 3/3] srcu: Unconditionally record srcu_read_lock_lite() in ->srcu_reader_flavor
Date: Mon, 11 Nov 2024 17:31:43 -0800
Message-Id: <20241112013143.1926484-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb96e032-4f7d-41bf-a675-81350dca8d0a@paulmck-laptop>
References: <bb96e032-4f7d-41bf-a675-81350dca8d0a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, srcu_read_lock_lite() uses the SRCU_READ_FLAVOR_LITE bit in
->srcu_reader_flavor to communicate to the grace-period processing in
srcu_readers_active_idx_check() that the smp_mb() must be replaced by a
synchronize_rcu().  Unfortunately, ->srcu_reader_flavor is not updated
unless the kernel is built with CONFIG_PROVE_RCU=y.  Therefore in all
kernels built with CONFIG_PROVE_RCU=n, srcu_readers_active_idx_check()
incorrectly uses smp_mb() instead of synchronize_rcu() for srcu_struct
structures whose readers use srcu_read_lock_lite().

This commit therefore causes Tree SRCU srcu_read_lock_lite()
to unconditionally update ->srcu_reader_flavor so that
srcu_readers_active_idx_check() can make the correct choice.

Reported-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Closes: https://lore.kernel.org/all/d07e8f4a-d5ff-4c8e-8e61-50db285c57e9@amd.com/
Fixes: c0f08d6b5a61 ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()"
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/srcu.h     |  8 +-------
 include/linux/srcutiny.h |  3 +++
 include/linux/srcutree.h | 21 +++++++++++++++++++++
 kernel/rcu/srcutree.c    |  6 ++----
 4 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index fff6265818d4f..abaddd7e6ddf7 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -183,12 +183,6 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
 
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
-#if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TREE_SRCU)
-void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
-#else
-#define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
-#endif
-
 
 /**
  * srcu_dereference_check - fetch SRCU-protected pointer for later dereferencing
@@ -278,7 +272,7 @@ static inline int srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
-	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
+	srcu_check_read_flavor_lite(ssp);
 	retval = __srcu_read_lock_lite(ssp);
 	rcu_try_lock_acquire(&ssp->dep_map);
 	return retval;
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 4d96bbdb45f08..1321da803274d 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -81,6 +81,9 @@ static inline void srcu_barrier(struct srcu_struct *ssp)
 	synchronize_srcu(ssp);
 }
 
+#define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
+#define srcu_check_read_flavor_lite(ssp) do { } while (0)
+
 /* Defined here to avoid size increase for non-torture kernels. */
 static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
 					    char *tt, char *tf)
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 778eb61542e18..490aeecc6bb47 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -248,4 +248,25 @@ static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
 }
 
+void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
+
+// Record _lite() usage even for CONFIG_PROVE_RCU=n kernels.
+static inline void srcu_check_read_flavor_lite(struct srcu_struct *ssp)
+{
+	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
+
+	if (likely(READ_ONCE(sdp->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE))
+		return;
+
+	// Note that the cmpxchg() in srcu_check_read_flavor() is fully ordered.
+	__srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
+}
+
+// Record non-_lite() usage only for CONFIG_PROVE_RCU=y kernels.
+static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
+{
+	if (IS_ENABLED(CONFIG_PROVE_RCU))
+		__srcu_check_read_flavor(ssp, read_flavor);
+}
+
 #endif
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 5991381b44383..ee3cbb8308664 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -711,11 +711,10 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
 
-#ifdef CONFIG_PROVE_RCU
 /*
  * Check for consistent reader flavor.
  */
-void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
+void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 {
 	int old_read_flavor;
 	struct srcu_data *sdp;
@@ -733,8 +732,7 @@ void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 	}
 	WARN_ONCE(old_read_flavor != read_flavor, "CPU %d old state %d new state %d\n", sdp->cpu, old_read_flavor, read_flavor);
 }
-EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
-#endif /* CONFIG_PROVE_RCU */
+EXPORT_SYMBOL_GPL(__srcu_check_read_flavor);
 
 /*
  * Counts the new reader in the appropriate per-CPU element of the
-- 
2.40.1

