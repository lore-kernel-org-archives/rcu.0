Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4E81FEFCB;
	Tue, 12 Nov 2024 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422241; cv=none; b=peH8vl2aKaAtwFBTkylgo38hNziJGr3RHER09Wlp1zNmdCd7QeQwLvCJtQQPx0EyTaVuG59DzKrLPwII3TheHAJANXrfLCLerHMUL0Q2lrn4CKl/MNglZ/1QpAe5BeUFVy5H3pVT+6YXIJpRIRCeyqZSWDZLomrgjf20llbP2PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422241; c=relaxed/simple;
	bh=OLM1LmvcGmfjwEoOH9THmUpT4WbBiVuJoTYmOw4ORrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYF93vdw9ZUCcFDMgWpAQ9oB2tZFdQhpANOop2MaJeL2UHXplpeyQnycd4/A0R7sdtlIvHu6iYP3ngf6qMWiqXAtMTI61ulZb8Cn89YNF5FTUfz61fZSwPy90ZhSgyQJpEC2hX8zYyk2NP8mUleTNOSKJ5DPumXPuhr+wqGArFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXKHjTKy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXKHjTKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E4FC4CED5;
	Tue, 12 Nov 2024 14:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422241;
	bh=OLM1LmvcGmfjwEoOH9THmUpT4WbBiVuJoTYmOw4ORrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXKHjTKyUbZPR6iHL4Gv3k6lw7qIdLYGsYEhL/GTflN6Y9HfituAM/nJ71CLJh9Fm
	 X5cSOnT7xgjcgv1J42+WEixgU9pf+nIvtCPOvvujyDvsNgtfzGHPVLze7e+Wk86eyB
	 anNFzRhsAE32QQWGzcQno7Jz5YcT0sNSjw5SmZ0CKNrDlXBrDeUbjRCzgMqsFnJrWD
	 CNErYQWFtapb2VLhGdAeQUMlQwkOgF5K2BQJXWkRUFTkUIF0uLnP/6emcRs2R72EpY
	 hciIRdZDE0XaKKmfRNReRTc5H1LCzlvu4Mg3DtHFvuivRY6xw7iqcHsI1aMl/86YLD
	 LeA8EoqJo7IrQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/3] rcu: Delete unused rcu_gp_might_be_stalled() function
Date: Tue, 12 Nov 2024 15:37:09 +0100
Message-ID: <20241112143711.21239-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112143711.21239-1-frederic@kernel.org>
References: <20241112143711.21239-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_gp_might_be_stalled() function is no longer used, so this commit
removes it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcutiny.h |  1 -
 include/linux/rcutree.h |  1 -
 kernel/rcu/tree_stall.h | 30 ------------------------------
 3 files changed, 32 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 0ee270b3f5ed..fe42315f667f 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -165,7 +165,6 @@ static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_eqs(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
-static inline bool rcu_gp_might_be_stalled(void) { return false; }
 
 /* Avoid RCU read-side critical sections leaking across. */
 static inline void rcu_all_qs(void) { barrier(); }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 90a684f94776..27d86d912781 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -40,7 +40,6 @@ void kvfree_rcu_barrier(void);
 void rcu_barrier(void);
 void rcu_momentary_eqs(void);
 void kfree_rcu_scheduler_running(void);
-bool rcu_gp_might_be_stalled(void);
 
 struct rcu_gp_oldstate {
 	unsigned long rgos_norm;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 4432db6d0b99..d7cdd535e50b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -76,36 +76,6 @@ int rcu_jiffies_till_stall_check(void)
 }
 EXPORT_SYMBOL_GPL(rcu_jiffies_till_stall_check);
 
-/**
- * rcu_gp_might_be_stalled - Is it likely that the grace period is stalled?
- *
- * Returns @true if the current grace period is sufficiently old that
- * it is reasonable to assume that it might be stalled.  This can be
- * useful when deciding whether to allocate memory to enable RCU-mediated
- * freeing on the one hand or just invoking synchronize_rcu() on the other.
- * The latter is preferable when the grace period is stalled.
- *
- * Note that sampling of the .gp_start and .gp_seq fields must be done
- * carefully to avoid false positives at the beginnings and ends of
- * grace periods.
- */
-bool rcu_gp_might_be_stalled(void)
-{
-	unsigned long d = rcu_jiffies_till_stall_check() / RCU_STALL_MIGHT_DIV;
-	unsigned long j = jiffies;
-
-	if (d < RCU_STALL_MIGHT_MIN)
-		d = RCU_STALL_MIGHT_MIN;
-	smp_mb(); // jiffies before .gp_seq to avoid false positives.
-	if (!rcu_gp_in_progress())
-		return false;
-	// Long delays at this point avoids false positive, but a delay
-	// of ULONG_MAX/4 jiffies voids your no-false-positive warranty.
-	smp_mb(); // .gp_seq before second .gp_start
-	// And ditto here.
-	return !time_before(j, READ_ONCE(rcu_state.gp_start) + d);
-}
-
 /* Don't do RCU CPU stall warnings during long sysrq printouts. */
 void rcu_sysrq_start(void)
 {
-- 
2.46.0

