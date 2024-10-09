Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DC51A76D5;
	Wed,  9 Oct 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497111; cv=none; b=eFzrkOpCmKrlNbkqVYhWNbMtWfausUd/zzT8RO6O7teV7EkeW/YiyHG31ott0+ppOZCFsKRYkllIXU1nCbgTYge0dp0ryn9KMzKjSfFf+szoTT0Qa97gN/qR5TlqGn/sCl2ELCZgSebayogvPQ3tLnMcVSTuGrLelSVaSrv/VmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497111; c=relaxed/simple;
	bh=7pa17iJCiaC6VrtPo21ztViCSaaHz8p6/8C7mQB27KI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ayd8s5HvmFCpThNWpSC58HY9ibTvuJdA6/GlkFY6dfsquUjH+xxDJHG0sI6hhqw9VxKVPy9QovG0VPA5YSJdmNIZHzWaiIRGRr40IAwU2NwmGmTGGD0xsUHdVsqJPCJhhEd37EnglHzb2kOYmqGkyZgwvsQOEU0F2/cpdbL4/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhO9iWqK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhO9iWqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B71BC4CEC3;
	Wed,  9 Oct 2024 18:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497111;
	bh=7pa17iJCiaC6VrtPo21ztViCSaaHz8p6/8C7mQB27KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhO9iWqKYnQMV7d6GZR+LRUgHvwv/OQKi/SavZMii/Q7HjXAfkQSvk4xt/9wx6e6w
	 u5DZrJOHUB8gS7cNIQM9r9Jr4A5NnZ6IHQ7Ab3oGS+g2V/Ij+0cUfCFELngn1oWrMv
	 S9bnk+Dd1to7BfD7qCSD9+lNNYKykh5F42VJHJlBNRPyrtws7qiFnLuIr0Qnr3+YHt
	 QKzmKlWIvGEzS9tpt580Iv/CQ6Ka0r1O+C0sN5GolQxeAhijpvFAOxF2OPsQumP1dZ
	 91zIiHej22Vvz7w5q68BsJDOTQr0KqzNNC/ROl6P91ad1Ezbs5Dm07CnHqWpv43SuA
	 o5S99WKK2PXLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EC9D3CE08E5; Wed,  9 Oct 2024 11:05:10 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/3] rcu: Delete unused rcu_gp_might_be_stalled() function
Date: Wed,  9 Oct 2024 11:05:07 -0700
Message-Id: <20241009180509.778133-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>
References: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_gp_might_be_stalled() function is no longer used, so this commit
removes it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |  1 -
 include/linux/rcutree.h |  1 -
 kernel/rcu/tree_stall.h | 30 ------------------------------
 3 files changed, 32 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 0ee270b3f5ed2..fe42315f667fc 100644
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
index 90a684f94776e..27d86d9127817 100644
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
index 4432db6d0b99b..d7cdd535e50b1 100644
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
2.40.1

