Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60E12E737D;
	Fri, 31 Jul 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459718; cv=none; b=FIPED87VCkEENMTvyU/D0Fp4f2SB6xYiaqwjR0rC6IF1na10C2pMGZ8nsTFh610OhZm21bChzl3MUrxkwyF9IuouAWJ7IhQ5qIDNqe9eWACdZE9COac+OF4mOHyzaYJH9XuWUn/KShAr0xq6CxNZNH/Ct0AaSP38tGzPSnkPaX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459718; c=relaxed/simple;
	bh=DD9x53YWgK/M5p4JEQQBQJE41f0Bxkxoh/tgT/hXIcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tTELrgvFIT5HJ0rcjp1gMbxPk9yT0H774TYUwfwlPoHobmB/c2LYIwxYjyI6ggtbmudZBs7ddYweh/EbQ5qU64V1CYkFx7AaO8tXIJ7Yl0haHL+i0jr4caWm3/a0OVOEoOD1XiDIqhJhUpbBUCJwz5IIZtmFGKWk7naPcsc6mHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIb6rwkn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIb6rwkn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2221F0155D;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459715;
	bh=8wTMVIMquaIq9IDftApy8iAaPEckI9PdhSiLZ7SuAtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cIb6rwkncRo9+6VFJLx94DpBEq4U0NfLYlKsoFuLjrdmEY7KDnqJdeKmpCisdrufm
	 H4r+vD+bD2zSSBgThK30CSxN6uiAkDDZLZhZNcr8/sDFQ8Pr3shYkqG9Mbrm/NEAmJ
	 p0aAigeISkjf1JLXAOrjYGN4GBXNhM/ygbU6b19p8npW8gRZjqe03YFzXZCCc9TPYu
	 nT6R3MUpJEYxaP2R01eGoIXM0O+vdqzewI3EWB9Ks4iUZL+XcyXCHCa6ZF/eH8TbVG
	 xBTFGMZKzt7BI3ioniyM3ES0s/KRidAZTBHvRv/KCrjC8rhRqQl4V1l7XAMpVtiq84
	 0HORl0YHwfeZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C1607CE19A4; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 13/16] rcu: Remove unused rdp parameter from rcu_check_gp_start_stall()
Date: Thu, 30 Jul 2026 18:01:50 -0700
Message-Id: <20260731010153.3531313-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
References: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

The rcu_check_gp_start_stall() works entirely on rnp parameter,
and never uses it's rdp parameter. this commit therefore drop it,
updating both callers and the declaration.

No functional change.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c       | 2 +-
 kernel/rcu/tree.h       | 3 +--
 kernel/rcu/tree_stall.h | 5 ++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 377153e0d93440..5dbc7506c0c0c0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2890,7 +2890,7 @@ static __latent_entropy void rcu_core(void)
 			rcu_accelerate_cbs_unlocked(rnp, rdp);
 	}
 
-	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
+	rcu_check_gp_start_stall(rnp, rcu_jiffies_till_stall_check());
 
 	/* If there are callbacks ready, invoke them. */
 	if (!rcu_rdp_is_offloaded(rdp) && rcu_segcblist_ready_cbs(&rdp->cblist) &&
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index ca88aaa29d615e..c3662c6ba39549 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -544,8 +544,7 @@ static bool rcu_nohz_full_cpu(void);
 static void record_gp_stall_check_time(void);
 static void rcu_iw_handler(struct irq_work *iwp);
 static void check_cpu_stall(struct rcu_data *rdp);
-static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
-				     const unsigned long gpssdelay);
+static void rcu_check_gp_start_stall(struct rcu_node *rnp, const unsigned long gpssdelay);
 
 /* Forward declarations for tree_exp.h. */
 static void sync_rcu_do_polled_gp(struct work_struct *wp);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 45b9856ccd2b23..02684dadb4ee08 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -998,8 +998,7 @@ EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
  * This function checks for grace-period requests that fail to motivate
  * RCU to come out of its idle mode.
  */
-static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
-				     const unsigned long gpssdelay)
+static void rcu_check_gp_start_stall(struct rcu_node *rnp, const unsigned long gpssdelay)
 {
 	unsigned long flags;
 	unsigned long j;
@@ -1074,7 +1073,7 @@ void rcu_fwd_progress_check(unsigned long j)
 			__func__, jiffies - data_race(READ_ONCE(rcu_state.gp_end)));
 		preempt_disable();
 		rdp = this_cpu_ptr(&rcu_data);
-		rcu_check_gp_start_stall(rdp->mynode, rdp, j);
+		rcu_check_gp_start_stall(rdp->mynode, j);
 		preempt_enable();
 	}
 	for_each_possible_cpu(cpu) {
-- 
2.40.1

