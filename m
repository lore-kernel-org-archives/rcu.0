Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2834614C592;
	Tue,  4 Jun 2024 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539837; cv=none; b=SdgBGIM1m0qS8sUTgOVSacE3FB0pBwVLqoORgzrWpIUla1iS/t8tk2Mph+FTFvDcivXE3eQghnvbH0KCiZY8QH3KSn5Q7Wt3u8Set4mjZHl8rbkw/dzO2/MpBTdCPjDlQScEoif0fc96mi+Zc+KmVJsxQwaPnEqkO0KQisxOTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539837; c=relaxed/simple;
	bh=pfQQEuNAMcpIVAntByrnVCNTp3OoaecMef/sKBSFuQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hU33HoIDYoSxDeGBALR4VItDiPLg2iKxtlWbMv+fheKHhhz7GcRJXP5m4wRuLBtX/pkCHoaOht1KLQze0lLDHrxWBKOgSh/pnghrpru1NQhP8m1+F+VCEo1Hbo0TiE44LVmcTw8Y+le62DTLF4SSz5T/7onSWR7MBQa6AUBug0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0LX1Gsk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0LX1Gsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6E6C4AF08;
	Tue,  4 Jun 2024 22:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539836;
	bh=pfQQEuNAMcpIVAntByrnVCNTp3OoaecMef/sKBSFuQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0LX1GskxrP735W7tui7ZPtRZqg8hRjGnLsh3TQxMveQtXzar8nhQ9LN3Gf6D5mAr
	 ppyDH57GjFGHhEjW9RK8pWV7UpC+/RveIlrAqV91QKywsS3wydUX0Q9+0aNnsNAwA4
	 pSUkyvPKRXEQ1W9n/cDGVR46DVmZJ0u/7dzlbNwy7DcN5DCkNm0opWliukzhC/4Hdu
	 NWlCs7BN190+IY2/XbEyrIeFO55ApJHopcLmOV+cPLCE+k5hitWuFHfpjbk/p8XPsX
	 UuKI5uPVH4onkDSVU4XaAXZn8XiCI8/1lxzfWZqbs8S9iZmHe8u9C1c7/ttGSmHjNo
	 Ad/xufTVra4og==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5F39DCE3F26; Tue,  4 Jun 2024 15:23:56 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/9] rcu/tree: Reduce wake up for synchronize_rcu() common case
Date: Tue,  4 Jun 2024 15:23:49 -0700
Message-Id: <20240604222355.2370768-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

In the synchronize_rcu() common case, we will have less than
SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
is pointless just to free the last injected wait head since at that point,
all the users have already been awakened.

Introduce a new counter to track this and prevent the wakeup in the
common case.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 35 ++++++++++++++++++++++++++++++-----
 kernel/rcu/tree.h |  1 +
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6ba36d9c09bde..2fe08e6186b4d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
 	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
 	.srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
 		rcu_sr_normal_gp_cleanup_work),
+	.srs_cleanups_pending = ATOMIC_INIT(0),
 };
 
 /* Dump rcu_node combining tree at boot to verify correct setup. */
@@ -1633,8 +1634,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 	 * the done tail list manipulations are protected here.
 	 */
 	done = smp_load_acquire(&rcu_state.srs_done_tail);
-	if (!done)
+	if (!done) {
+		/* See comments below. */
+		atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
 		return;
+	}
 
 	head = done->next;
 	done->next = NULL;
@@ -1656,6 +1660,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 
 		rcu_sr_put_wait_head(rcu);
 	}
+
+	/* Order list manipulations with atomic access. */
+	atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
 }
 
 /*
@@ -1663,7 +1670,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
  */
 static void rcu_sr_normal_gp_cleanup(void)
 {
-	struct llist_node *wait_tail, *next, *rcu;
+	struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
 	int done = 0;
 
 	wait_tail = rcu_state.srs_wait_tail;
@@ -1697,16 +1704,34 @@ static void rcu_sr_normal_gp_cleanup(void)
 			break;
 	}
 
-	// concurrent sr_normal_gp_cleanup work might observe this update.
-	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+	/*
+	 * Fast path, no more users to process except putting the second last
+	 * wait head if no inflight-workers. If there are in-flight workers,
+	 * they will remove the last wait head.
+	 *
+	 * Note that the ACQUIRE orders atomic access with list manipulation.
+	 */
+	if (wait_tail->next && wait_tail->next->next == NULL &&
+	    rcu_sr_is_wait_head(wait_tail->next) &&
+	    !atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
+		rcu_sr_put_wait_head(wait_tail->next);
+		wait_tail->next = NULL;
+	}
+
+	/* Concurrent sr_normal_gp_cleanup work might observe this update. */
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
+	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
 
 	/*
 	 * We schedule a work in order to perform a final processing
 	 * of outstanding users(if still left) and releasing wait-heads
 	 * added by rcu_sr_normal_gp_init() call.
 	 */
-	queue_work(sync_wq, &rcu_state.srs_cleanup_work);
+	if (wait_tail->next) {
+		atomic_inc(&rcu_state.srs_cleanups_pending);
+		if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work))
+			atomic_dec(&rcu_state.srs_cleanups_pending);
+	}
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index bae7925c497fe..affcb92a358c3 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -420,6 +420,7 @@ struct rcu_state {
 	struct llist_node *srs_done_tail; /* ready for GP users. */
 	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
 	struct work_struct srs_cleanup_work;
+	atomic_t srs_cleanups_pending; /* srs inflight worker cleanups. */
 };
 
 /* Values for rcu_state structure's gp_flags field. */
-- 
2.40.1

