Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A741B1514;
	Thu, 20 Jun 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899904; cv=none; b=t4gPFNxBXsML8ZwYJ2yDl/scmwCLGm2r4/kU36kDxgmiERTX3ItDpaimxgVJKjbbZN+0lOwksB5MUd39PLf54Sghu29yVJz49MdMdb5etNnC5G9MbP9i76uv98/H53pCBc+Jbh+BFnxkDasXzgIMiuyyKiiqyQ0m/EkrdkADxgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899904; c=relaxed/simple;
	bh=moqkrVqx95CFhHpEKKGXhdPr5fPQ9IbFq3m1fia5tT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCq880x7/fpH3NaVzdDgQqtTLubt73f8Um60tdqVTpX6zt2vF/BW2gyhJE1Ly5OnQ3nCgPuD9gfyKcl33N2XlwFxpWgWrkbnOewpfZvzDv5gBvQWsGWTst8PdANXHZ3JqdVbaBmu5LAZy8ILYX+qZt3/j2ZoPNTyorLsmttB1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVwCxk7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVwCxk7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72BBC4AF0A;
	Thu, 20 Jun 2024 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718899903;
	bh=moqkrVqx95CFhHpEKKGXhdPr5fPQ9IbFq3m1fia5tT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVwCxk7mflF3ByQBM3cGd6r6Lu94QLOknEe7PvZUcLYt/uiaYTUVGaBrYhS5FiwX7
	 kfxUJf0r2xhcRrcncw9rKnIFWR5uJYwGU75mAfaNh03kwBUohSctZqml6YJ2IJVamJ
	 8iS+ifUihbHnTvvpuDxtuOnTgSMnu7I1HQXHLIMp+k0an2KolZDorsHzU6dlX+KsqS
	 M0OJEohb1TewF4FNja9lXSQzxhXycxtESiGBAqSF+VRCB55gDBaYDQ12WUClGPr1Vt
	 ERCF0ISiIJGjFfxtIBYXSczhNjQ657rscHBlwAjCoXXdx5zMAuC6IdV9KFc8nUhkqp
	 w5nHDytpDwrTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 540D9CE0D11; Thu, 20 Jun 2024 09:11:43 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH rcu 3/3] srcu: Fill out polled grace-period APIs
Date: Thu, 20 Jun 2024 09:11:42 -0700
Message-Id: <20240620161142.2057652-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8ec14282-a768-49eb-b870-c2ee51e91f8b@paulmck-laptop>
References: <8ec14282-a768-49eb-b870-c2ee51e91f8b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the get_completed_synchronize_srcu() and the
same_state_synchronize_srcu() functions.  The first returns a cookie
that is always interpreted as corresponding to an expired grace period.
The second does an equality comparison of a pair of cookies.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/srcu.h  | 31 +++++++++++++++++++++++++++++++
 kernel/rcu/srcutiny.c |  3 ++-
 kernel/rcu/srcutree.c |  3 ++-
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index f664cba7a80c2..6f6cb5fc12424 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -57,6 +57,20 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
 void synchronize_srcu(struct srcu_struct *ssp);
+
+#define SRCU_GET_STATE_COMPLETED 0x1
+
+/**
+ * get_completed_synchronize_srcu - Return a pre-completed polled state cookie
+ *
+ * Returns a value that poll_state_synchronize_srcu() will always treat
+ * as a cookie whose grace period has already completed.
+ */
+static inline unsigned long get_completed_synchronize_srcu(void)
+{
+	return SRCU_GET_STATE_COMPLETED;
+}
+
 unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
@@ -65,6 +79,23 @@ bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
 // not-yet-completed SRCU grace periods.
 #define NUM_ACTIVE_SRCU_POLL_OLDSTATE 2
 
+/**
+ * same_state_synchronize_srcu - Are two old-state values identical?
+ * @oldstate1: First old-state value.
+ * @oldstate2: Second old-state value.
+ *
+ * The two old-state values must have been obtained from either
+ * get_state_synchronize_srcu(), start_poll_synchronize_srcu(), or
+ * get_completed_synchronize_srcu().  Returns @true if the two values are
+ * identical and @false otherwise.  This allows structures whose lifetimes
+ * are tracked by old-state values to push these values to a list header,
+ * allowing those structures to be slightly smaller.
+ */
+static inline bool same_state_synchronize_srcu(unsigned long oldstate1, unsigned long oldstate2)
+{
+	return oldstate1 == oldstate2;
+}
+
 #ifdef CONFIG_NEED_SRCU_NMI_SAFE
 int __srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp);
 void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx) __releases(ssp);
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 5afd5cf494dba..549c03336ee97 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -277,7 +277,8 @@ bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
 	unsigned long cur_s = READ_ONCE(ssp->srcu_idx);
 
 	barrier();
-	return ULONG_CMP_GE(cur_s, cookie) || ULONG_CMP_LT(cur_s, cookie - 3);
+	return cookie == SRCU_GET_STATE_COMPLETED ||
+	       ULONG_CMP_GE(cur_s, cookie) || ULONG_CMP_LT(cur_s, cookie - 3);
 }
 EXPORT_SYMBOL_GPL(poll_state_synchronize_srcu);
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 15dc22a8ff5ab..d6a4047719cb0 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1543,7 +1543,8 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
  */
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
 {
-	if (!rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, cookie))
+	if (cookie != SRCU_GET_STATE_COMPLETED &&
+	    !rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, cookie))
 		return false;
 	// Ensure that the end of the SRCU grace period happens before
 	// any subsequent code that the caller might execute.
-- 
2.40.1

