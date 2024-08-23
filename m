Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05CC16B391;
	Fri, 23 Aug 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447717; cv=none; b=IYoriYhOyDNuefrpQ54btTZ+QfrnoFkDjbHtWtFWEG/h+vEDax62jDZD7OCTmxTk6IwUAOKUHVgZ/OoWAbgPst+YpYIqsEPDsL5+Qep4VqUKxIelg8+560qNsDNdxvmQUuMQHPUU04fTBqgXnkK3WiSgL7r2K/HQZS/V6U/KdXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447717; c=relaxed/simple;
	bh=bmBTGW+VcZqWF/8zKVL1ZslDNcVmNY96MKMOPxGZ0M4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TyuGVk7LA6l7LzSpIhGJCrjaJHD+V4PCKxxhj6UjJeh8YahzDhLVD8e2l4JzSQtE2VIOHc9wWVttMg8fB50d15UmLQhqUapTD0XO4dKRyc8t/xtevFIjcwBW2HiofkU7LfbROOYSjcdaqCcwLQxFgFwcMU5HVVwTHtM5kdrqHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW4MYXgG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW4MYXgG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791D5C4AF0C;
	Fri, 23 Aug 2024 21:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724447717;
	bh=bmBTGW+VcZqWF/8zKVL1ZslDNcVmNY96MKMOPxGZ0M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oW4MYXgGBz96OA1xvf5UFLs4XdneGZLSC4kfWvnEoTkJTsEyx6cU2t7SWL62lbb5v
	 qRmAG3qfhYMnSxSYZklN4ULqWOC4rw4SdKMRl+A8fo4zHh9uA0gsTGWEfJCOZNyeeW
	 AbX3EY+LxlLPjmeICYnFuD6Cne4cPsCA6xvyT3SvL1wwBCajQYMQMw5s6nVrvA4hCV
	 5dWklflOBeTZWbdcg/6M23VqY0X3WfAr6xJJhWvcLT/NP8R/yzEq2p/rJfpakn4JF7
	 wm7909Zp11xP7tu6LP88GLl2Bo+jYZPqo31AEIBA6RXt2QHSFkwq+V+QMLlkgBMLup
	 eyuV3JvMU9FfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2A64FCE1078; Fri, 23 Aug 2024 14:15:17 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	riel@surriel.com,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/4] rcu: Delete unused rcu_gp_might_be_stalled() function
Date: Fri, 23 Aug 2024 14:15:13 -0700
Message-Id: <20240823211516.2984627-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <415b108b-1046-4027-aa2a-c829b77f39f6@paulmck-laptop>
References: <415b108b-1046-4027-aa2a-c829b77f39f6@paulmck-laptop>
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
index cf2b5a188f783..ca43525474a9e 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -160,7 +160,6 @@ static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_eqs(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
-static inline bool rcu_gp_might_be_stalled(void) { return false; }
 
 /* Avoid RCU read-side critical sections leaking across. */
 static inline void rcu_all_qs(void) { barrier(); }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 7dbde2b6f714a..da14ad1141263 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -39,7 +39,6 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr);
 void rcu_barrier(void);
 void rcu_momentary_eqs(void);
 void kfree_rcu_scheduler_running(void);
-bool rcu_gp_might_be_stalled(void);
 
 struct rcu_gp_oldstate {
 	unsigned long rgos_norm;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 2fb40ec4b2aea..ed065e3ce5c33 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -75,36 +75,6 @@ int rcu_jiffies_till_stall_check(void)
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

