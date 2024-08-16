Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE17DA7C;
	Fri, 16 Aug 2024 06:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789565; cv=none; b=Cx/V7KRdsxr4k6Zw/mzwnSlD9WgWsO5gYQFAjUlaDn4EsaWI6KXC1BtQtEvRSnJztOeTaNCkvbA9BhT49RZw1m5r1mz69fBN8ksKLAzb5snUthNSApneNKNmVPTUtAU3Yrpp9Rbcw3DlSLiyQcehdBnI/r7sU8aLOcN1etBH1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789565; c=relaxed/simple;
	bh=/ouYOuZVN62/GbxNdOnzqwKp1r/zXa/CHPqoWQ2Ijo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DkZ7U6oWcvbq+izYjU/BnGz/qPTVOvqITtbltPkiE9RTYe7sZ/zA0cMS1lUrxhc2JKyYU8N6oVh09B9znMtlC9k6S+3fm78p0zkTVUyTrerBzBr16LA/1f/Q+unM5zSL1p/RKIZa+Jb2JX7rZMPauWKQHRH1jomtbOe6zY5X9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYBLnIjh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYBLnIjh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DF1C32782;
	Fri, 16 Aug 2024 06:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723789564;
	bh=/ouYOuZVN62/GbxNdOnzqwKp1r/zXa/CHPqoWQ2Ijo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYBLnIjhRoYqwf29721h+46Ge3GQfara0lMugYU3R0klbV9M1536QMgyKQdtP7B/5
	 1XfAh+uvcaJSlh8aO9onjpvS7/F3K+9wceqSVlh3nP84TvKy7klTkwxyLWZVRkRgfV
	 tHV+d5gowIZMrnySyGw5zWMKiD5OKC+8nQBVFHbt8unGXBV2D8ha2QByQG5mpU5XL+
	 dmWhRADx3rzWhxisR1aTEnYKq45aE2RH1TmPWZ+eaqtZHuCoNjj1bzIzgjOMy9xWiL
	 7I3SmUQ6v+CNXIYlKVedi1Vls9VQCjmOKINGZ6i3fx0SN5/ycOMPMPDFObqwMvKwEx
	 fMR4JJd7kW1QQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	JP Kobryn <inwardvessel@gmail.com>
Subject: [PATCH rcu 1/3] srcu: faster gp seq wrap-around
Date: Fri, 16 Aug 2024 11:55:30 +0530
Message-Id: <20240816062532.51893-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816062445.GA51253@neeraj.linux>
References: <20240816062445.GA51253@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JP Kobryn <inwardvessel@gmail.com>

Using a higher value for the initial gp sequence counters allows for
wrapping to occur faster. It can help with surfacing any issues that may
be happening as a result of the wrap around.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/rcupdate.h |  3 +++
 include/linux/srcutree.h | 15 ++++++++++++++-
 kernel/rcu/rcu.h         |  3 ---
 kernel/rcu/srcutree.c    |  7 ++++---
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 13f6f00aecf9..8d56db70d417 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -34,6 +34,9 @@
 #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
 #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
 
+#define RCU_SEQ_CTR_SHIFT    2
+#define RCU_SEQ_STATE_MASK   ((1 << RCU_SEQ_CTR_SHIFT) - 1)
+
 /* Exported common interfaces */
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
 void rcu_barrier_tasks(void);
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 8f3f72480e78..ed57598394de 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -129,10 +129,23 @@ struct srcu_struct {
 #define SRCU_STATE_SCAN1	1
 #define SRCU_STATE_SCAN2	2
 
+/*
+ * Values for initializing gp sequence fields. Higher values allow wrap arounds to
+ * occur earlier.
+ * The second value with state is useful in the case of static initialization of
+ * srcu_usage where srcu_gp_seq_needed is expected to have some state value in its
+ * lower bits (or else it will appear to be already initialized within
+ * the call check_init_srcu_struct()).
+ */
+#define SRCU_GP_SEQ_INITIAL_VAL ((0UL - 100UL) << RCU_SEQ_CTR_SHIFT)
+#define SRCU_GP_SEQ_INITIAL_VAL_WITH_STATE (SRCU_GP_SEQ_INITIAL_VAL - 1)
+
 #define __SRCU_USAGE_INIT(name)									\
 {												\
 	.lock = __SPIN_LOCK_UNLOCKED(name.lock),						\
-	.srcu_gp_seq_needed = -1UL,								\
+	.srcu_gp_seq = SRCU_GP_SEQ_INITIAL_VAL,							\
+	.srcu_gp_seq_needed = SRCU_GP_SEQ_INITIAL_VAL_WITH_STATE,				\
+	.srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL,					\
 	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
 }
 
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 38238e595a61..2bfed9855d67 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -54,9 +54,6 @@
  *					grace-period sequence number.
  */
 
-#define RCU_SEQ_CTR_SHIFT	2
-#define RCU_SEQ_STATE_MASK	((1 << RCU_SEQ_CTR_SHIFT) - 1)
-
 /* Low-order bit definition for polled grace-period APIs. */
 #define RCU_GET_STATE_COMPLETED	0x1
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b24db425f16d..6fd9c914ce64 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -247,7 +247,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
 	mutex_init(&ssp->srcu_sup->srcu_gp_mutex);
 	ssp->srcu_idx = 0;
-	ssp->srcu_sup->srcu_gp_seq = 0;
+	ssp->srcu_sup->srcu_gp_seq = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_barrier_seq = 0;
 	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
@@ -258,7 +258,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	if (!ssp->sda)
 		goto err_free_sup;
 	init_srcu_struct_data(ssp);
-	ssp->srcu_sup->srcu_gp_seq_needed_exp = 0;
+	ssp->srcu_sup->srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
 		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
@@ -266,7 +266,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
 	}
 	ssp->srcu_sup->srcu_ssp = ssp;
-	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
+	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed,
+			SRCU_GP_SEQ_INITIAL_VAL); /* Init done. */
 	return 0;
 
 err_free_sda:
-- 
2.40.1

