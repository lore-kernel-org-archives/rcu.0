Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2941F1908;
	Thu, 30 Jan 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=SdErO2upyPdE8XagxrhF7jr/gCIOiPkUV5d2mhJs0V78Xy+M+Ms5xVF0XxMscXDbV4O+aewfJa5l4hU9MhAvCqQRlkEzGMr51JT8dOzBs+1fRh6xjfuzI9F6CajwyZHEzzdd3CzygduXeCopG1llj/NCQmhfaq4rioIOXBjzssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=LWNIwn/R0OGDFNje6lsbp/s0VzDvYLj8gIfaC1VG4e8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rxr7v+RsyKyrIWnuoQ9zsjcVfxTTQi6CEjlcW1fS7ld67YDh8KPpga8f8eAIfcQb0yFz3ybCNuYTANwRK5LY+CTe7juEMeRbI7GEg2lP/D5Jg7CeolMZU1m41KlsbtJ72lc9HMOK/IxxomudujGPwDWdMK1qE9BxCD3U3v9Whdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqGL6Lwz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqGL6Lwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFADC4CEE3;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263800;
	bh=LWNIwn/R0OGDFNje6lsbp/s0VzDvYLj8gIfaC1VG4e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqGL6LwzERy8ooBzUAM05diqnpA+YMkg/PFQBoi4uxxJQFx+tbiHe6jkObB3GktTs
	 DkPSpYTFkT/u4EQx1zezHpT86s67hDbbrtqTm0/WvKpOsHa9CelNhU52sBzm089gE3
	 EUFiimATUlldXU15eVzJ/noI5B52nYrFgY5G9N52P8ok4RiJYkvi/Qsbs9yhd9X6r6
	 3GHT2VgJASU9E9wWl6GjhlTxMmIKyb8bME+VfkPAxJOnlDi9zXZ46xdakS41dgYzkW
	 W4IcWQ/zgUxv1x5UUipPhsUX28KbxBvlO0ZT9p+3fhI4EL/rpwsLr83jojHrNFYgRR
	 HwZ6gAGIPOqKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 15082CE3992; Thu, 30 Jan 2025 11:03:19 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH rcu v2] 20/20] srcu: Make SRCU-fast also be NMI-safe
Date: Thu, 30 Jan 2025 11:03:17 -0800
Message-Id: <20250130190317.1652481-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
References: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF uses rcu_read_lock_trace() in NMI context, so srcu_read_lock_fast()
must be NMI-safe if it is to have any chance of addressing RCU Tasks
Trace use cases.  This commit therefore causes srcu_read_lock_fast()
and srcu_read_unlock_fast() to use atomic_long_inc() instead of
this_cpu_inc() on architectures that support NMIs but do not have
NMI-safe implementations of this_cpu_inc().  Note that both x86 and
arm64 have NMI-safe implementations of this_cpu_inc(), and thus do not
pay the performance penalty inherent in atomic_inc_long().

It is tempting to use this trick to fold srcu_read_lock_nmisafe()
into srcu_read_lock(), but this would need careful thought, review,
and performance analysis.  Though those smp_mb() calls might well make
performance a non-issue.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index bdc467efce3a..8bed7e6cc4c1 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -231,17 +231,24 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
  * srcu_struct.  Returns a pointer that must be passed to the matching
  * srcu_read_unlock_fast().
  *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
+ * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
+ * critical sections either because they disables interrupts, because they
+ * are a single instruction, or because they are a read-modify-write atomic
+ * operation, depending on the whims of the architecture.
+ *
+ * This means that __srcu_read_lock_fast() is not all that fast
+ * on architectures that support NMIs but do not supply NMI-safe
+ * implementations of this_cpu_inc().
  */
 static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
 {
 	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
-	this_cpu_inc(scp->srcu_locks.counter); /* Y */
+	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
+		this_cpu_inc(scp->srcu_locks.counter); /* Y */
+	else
+		atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  /* Z */
 	barrier(); /* Avoid leaking the critical section. */
 	return scp;
 }
@@ -252,15 +259,22 @@ static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct
  * different CPU than that which was incremented by the corresponding
  * srcu_read_lock_fast(), but it must be within the same task.
  *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
+ * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
+ * critical sections either because they disables interrupts, because they
+ * are a single instruction, or because they are a read-modify-write atomic
+ * operation, depending on the whims of the architecture.
+ *
+ * This means that __srcu_read_unlock_fast() is not all that fast
+ * on architectures that support NMIs but do not supply NMI-safe
+ * implementations of this_cpu_inc().
  */
 static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
 {
 	barrier();  /* Avoid leaking the critical section. */
-	this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
+	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
+		this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
+	else
+		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  /* Z */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
 }
 
-- 
2.40.1

