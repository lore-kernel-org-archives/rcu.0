Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F512EE971;
	Wed, 16 Jul 2025 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706464; cv=none; b=JCZt9BNT2i371rYnyW5lzk7kOHJibKY8Aknfua+5DvPHtBXAaA5cWK+c3WcVbSTpTWHelKBtGAiAg48KNI9y54D97RohgPBSPa+Js/0WAx97IRSeBg633k1NFigoOAsV5h89mkUbfnTRjH2CULnEA875IfefDJKcz4nB0+V7KsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706464; c=relaxed/simple;
	bh=yhEmGTEOgL1pzUmcVmfBO55XtP3DhnMdEc4mCnPazzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S55c5w16+jKRu6YygNZYbtA514LPSU85ZrwQeALMx4XSoeyjbSRiC2hAB76g3wWVJCuz1qpxH4Gqdwh7d0jZl8m3ciL828HX8U/HpL1SIR+G21Jw7oAmwY6fxk9V+lZo5FRiX0o5vDJq1IYsimjxnNs1dSe23qVkdVw4YwCCj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrcTWhTD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrcTWhTD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45F7C4CEE7;
	Wed, 16 Jul 2025 22:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752706463;
	bh=yhEmGTEOgL1pzUmcVmfBO55XtP3DhnMdEc4mCnPazzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BrcTWhTDvGaTlEMBI6rPy6IhdK6n1U9huqPXLklrhZM7utiZrcNT0jLQhHU5B0iP9
	 6QuEWp/j/5hqsZ54NVKnFuOgEHBdi8RBxIWLtvwIdTAAKNq2LfurknqhPjlJP1atb3
	 9fHGpTEUT5KeZVs43wqauJfVCM3+0K9dOGmmgBrpyc3Oju9Y+GSB+BPPPCFwM6vany
	 VfyZVnmbGMyioGvNiigZBisFwHd+wifG7MIeIHSubycfX5iEMtUrdfCzLRNZgRuXGB
	 0Uf2WEcOKL4+ZpfJaiuMOnatZEVv8se3wAgBszq9scGSzhEDbRpk32O9VdGD3Pwn4m
	 tQoYPXc49w1VQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7797CCE09C2; Wed, 16 Jul 2025 15:54:23 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RFC 1/4] srcu: Move rcu_is_watching() checks to srcu_read_{,un}lock_fast()
Date: Wed, 16 Jul 2025 15:54:15 -0700
Message-Id: <20250716225418.3014815-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
References: <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_is_watching() warnings are currently in the SRCU-tree
implementations of __srcu_read_lock_fast() and __srcu_read_unlock_fast().
However, this makes it difficult to create _notrace variants of
srcu_read_lock_fast() and srcu_read_unlock_fast().  This commit therefore
moves these checks to srcu_read_lock_fast(), srcu_read_unlock_fast(),
srcu_down_read_fast(), and srcu_up_read_fast().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/srcu.h     | 4 ++++
 include/linux/srcutree.h | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index cf711a0f440b2..9a25a2cb000fe 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -275,6 +275,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
 {
 	struct srcu_ctr __percpu *retval;
 
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
 	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
 	retval = __srcu_read_lock_fast(ssp);
 	rcu_try_lock_acquire(&ssp->dep_map);
@@ -295,6 +296,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
 static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *ssp) __acquires(ssp)
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_down_read_fast().");
 	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
 	return __srcu_read_lock_fast(ssp);
 }
@@ -389,6 +391,7 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	srcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock_fast(ssp, scp);
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
 }
 
 /**
@@ -405,6 +408,7 @@ static inline void srcu_up_read_fast(struct srcu_struct *ssp, struct srcu_ctr __
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	__srcu_read_unlock_fast(ssp, scp);
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_up_read_fast().");
 }
 
 /**
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index bf44d8d1e69ea..043b5a67ef71e 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -244,7 +244,6 @@ static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct
 {
 	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
 	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
 		this_cpu_inc(scp->srcu_locks.counter); /* Y */
 	else
@@ -275,7 +274,6 @@ static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_
 		this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
 	else
 		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  /* Z */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
 }
 
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
-- 
2.40.1

