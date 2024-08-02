Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81DA18E06;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559391; cv=none; b=aeh3zrVxtt5TFgXjqSERqV/Cni6TMdX5qjz++eyvERNUL/WBjiPH/pPXFQ+bMNoYfpcxQtg+SjaLcTAawBA47HckDAD2ysnYGP7JBHtGfFjOy9mhkl82pOzxVV+tyEbsK+6goPZmJENuxV5SVxzVNYHKl0EkWjMW9er73ge8TNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559391; c=relaxed/simple;
	bh=0uXJ7XpqMMOTU5D9L7DX8BbJ/THNXMlQczyB3O6xc1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6MpY4pBnTk04hdDNcrjUKySPIrMw8NM2TtGL19DMZ0UX0PzY498jQlcnUi7AoTeFsUaOZ5dpWao4B6RGNWD3NCVlO6ki+3D+3nPY67SD0Gk2o7j96PkGWUjUqO5MuZXvy8pj+BPcg3Wz7qKy+w9U9TV1U/AlyOxLYp6AfkWC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIqaK0Xk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIqaK0Xk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8251FC4AF17;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559391;
	bh=0uXJ7XpqMMOTU5D9L7DX8BbJ/THNXMlQczyB3O6xc1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIqaK0XkfevEFyIoWZ+h2IqA31zqlYISem5Wb/IElhq3wvGBRVM0hFZDUNkb6UKjC
	 c5ckoYj31+3opPDh5z9cGrQaGmgPetTc6TuyVC7W/Zxux6hRNTPENrPnukR7l+gtrD
	 8iw9Lc2kDbbotzikFwHm51fFi4EGFmUGKrIUACQeVcIDU9waFpviRWQDzOst+A9kYP
	 g2jCzi1rFQW0KNniIT+i8iHyxDm+2Rc/wpX+dNkzvTkMLzVHGvLtMpZNnyda6YaUR+
	 j5WmyzvrG2pI478uSPMln9zNfkecs/pzwzo9roGRl7gZQsTKlruMo7OTGsbFNW4S0k
	 6GKRYfsQZhD5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D8C1BCE11CD; Thu,  1 Aug 2024 17:43:10 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH rcu 11/11] rcuscale: Count outstanding callbacks per-task rather than per-CPU
Date: Thu,  1 Aug 2024 17:43:08 -0700
Message-Id: <20240802004308.4134731-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
References: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current rcu_scale_writer() asynchronous grace-period testing uses a
per-CPU counter to track the number of outstanding callbacks.  This is
subject to CPU-imbalance errors when tasks migrate from one CPU to another
between the time that the counter is incremented and the callback is
queued, and additionally in kernels configured such that callbacks can
be invoked on some CPU other than the one that queued it.

This commit therefore arranges for per-task callback counts, thus avoiding
any issues with migration of either tasks or callbacks.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 13d379c179248..b1c50df142eba 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -114,6 +114,7 @@ struct writer_mblock {
 
 struct writer_freelist {
 	struct llist_head ws_lhg;
+	atomic_t ws_inflight;
 	struct llist_head ____cacheline_internodealigned_in_smp ws_lhp;
 	struct writer_mblock *ws_mblocks;
 };
@@ -136,7 +137,6 @@ static u64 t_rcu_scale_writer_started;
 static u64 t_rcu_scale_writer_finished;
 static unsigned long b_rcu_gp_test_started;
 static unsigned long b_rcu_gp_test_finished;
-static DEFINE_PER_CPU(atomic_t, n_async_inflight);
 
 #define MAX_MEAS 10000
 #define MIN_MEAS 100
@@ -520,8 +520,9 @@ static void rcu_scale_free(struct writer_mblock *wmbp)
 static void rcu_scale_async_cb(struct rcu_head *rhp)
 {
 	struct writer_mblock *wmbp = container_of(rhp, struct writer_mblock, wmb_rh);
+	struct writer_freelist *wflp = wmbp->wmb_wfl;
 
-	atomic_dec(this_cpu_ptr(&n_async_inflight));
+	atomic_dec(&wflp->ws_inflight);
 	rcu_scale_free(wmbp);
 }
 
@@ -541,6 +542,7 @@ rcu_scale_writer(void *arg)
 	DEFINE_TORTURE_RANDOM(tr);
 	u64 *wdp;
 	u64 *wdpp = writer_durations[me];
+	struct writer_freelist *wflp = &writer_freelists[me];
 	struct writer_mblock *wmbp = NULL;
 
 	VERBOSE_SCALEOUT_STRING("rcu_scale_writer task started");
@@ -584,8 +586,8 @@ rcu_scale_writer(void *arg)
 		if (gp_async && !WARN_ON_ONCE(!cur_ops->async)) {
 			if (!wmbp)
 				wmbp = rcu_scale_alloc(me);
-			if (wmbp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
-				atomic_inc(this_cpu_ptr(&n_async_inflight));
+			if (wmbp && atomic_read(&wflp->ws_inflight) < gp_async_max) {
+				atomic_inc(&wflp->ws_inflight);
 				cur_ops->async(&wmbp->wmb_rh, rcu_scale_async_cb);
 				wmbp = NULL;
 				gp_succeeded = true;
-- 
2.40.1

