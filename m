Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493DC19D075;
	Wed,  9 Oct 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478313; cv=none; b=mkMDNztwM/kJMw74fbwbVHg3Nb3GEij55Bqyr8T/K5Cml1N+u8Cl23hf2Zaa0UKDsXBrJn3n1bghQu0hk5m4GO1LE8OULQb52fOQAg36TYEIrx4YkCkqaGOPKSPU62fXrnb5wrH1R2R79M+w3qfxtN/HkE2ZF4x8p+la3r2Ehlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478313; c=relaxed/simple;
	bh=8qSnsgM8LhMwsfqVBK36j4HZgFG548kSvr6lIkRispo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pmgnEksddVpX49mh4cKBH5bVnv9yguKcjgHLvaD6mYfMe1n0kxS/KpQbjUScxGQNP+aH2pT56tSF14evKB+XXc+KTyZGckBdywwrPGcdKzRm6d+nIvBTF83mFBctXdcvJ8T9Vj/FrtNL+C55xgVRjM3/Gin9yBtxRI5P4IkYkEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEEd2bL6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEEd2bL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8227CC4CEC5;
	Wed,  9 Oct 2024 12:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478312;
	bh=8qSnsgM8LhMwsfqVBK36j4HZgFG548kSvr6lIkRispo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OEEd2bL6J6Yh6YBsyCq5m+LGHBJwL1tXjnrk7zssZzMyP59806bkeUfg2fH6FJ1nd
	 aONa9hiDlTdYipD61Gc3YoEou7VDEd9L5b8nD9R8eUi0BkcnTDjBDcX5x8e3oRK5uw
	 MEye2dbo1oq3MWZlGUpE5NJwCeTMghGq2+D7R0R+UozOEXr6PXCi7hnLlEDlIhryBC
	 99SafEdlZpV1azA9O9dOZxGImxH5GSf5IN7mdGf6sR9mgmhRaNJxWR4ZoWA8nDEo4J
	 rO1xSxAOIkzDS66GODK3oVyP+EWfM55tjYmlubGKLoZ+r0oK+JvpB9TZFuFXog26lU
	 /uObIQnhEidIg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joel@joelfernandes.org,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	peterz@infradead.org,
	neeraj.upadhyay@amd.com,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH v2 02/10] rcu: Make some rcu_watching_* functions global
Date: Wed,  9 Oct 2024 18:21:19 +0530
Message-Id: <20241009125127.18902-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
References: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

rcu_watching_snap_in_eqs() and rcu_watching_snap_stopped_since()
will be used in subsequent commits by RCU-tasks to check rcu_watching
state of idle tasks. So, make these functions global.

Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcu.h  | 4 ++++
 kernel/rcu/tree.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index feb3ac1dc5d5..5fec1b52039c 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -609,6 +609,8 @@ void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 
 #ifdef CONFIG_TINY_RCU
 static inline bool rcu_watching_zero_in_eqs(int cpu, int *vp) { return false; }
+static inline bool rcu_watching_snap_in_eqs(int snap) { return false; }
+static inline bool rcu_watching_snap_stopped_since(int cpu, int snap) { return false; }
 static inline unsigned long rcu_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
 static inline unsigned long
@@ -622,6 +624,8 @@ static inline void rcu_gp_slow_register(atomic_t *rgssp) { }
 static inline void rcu_gp_slow_unregister(atomic_t *rgssp) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_watching_zero_in_eqs(int cpu, int *vp);
+bool rcu_watching_snap_in_eqs(int snap);
+bool rcu_watching_snap_stopped_since(int cpu, int snap);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ea17dd2d0344..5ecbf85f157d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -303,7 +303,7 @@ static void rcu_watching_online(void)
  * Return true if the snapshot returned from ct_rcu_watching()
  * indicates that RCU is in an extended quiescent state.
  */
-static bool rcu_watching_snap_in_eqs(int snap)
+bool rcu_watching_snap_in_eqs(int snap)
 {
 	return !(snap & CT_RCU_WATCHING);
 }
@@ -321,7 +321,7 @@ static bool rcu_watching_snap_in_eqs(int snap)
  *
  * This is meant to be used in a loop waiting for a CPU to go through an EQS.
  */
-static bool rcu_watching_snap_stopped_since(int cpu, int snap)
+bool rcu_watching_snap_stopped_since(int cpu, int snap)
 {
 	/*
 	 * The first failing snapshot is already ordered against the accesses
-- 
2.40.1

