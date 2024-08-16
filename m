Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E2413E033;
	Fri, 16 Aug 2024 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791911; cv=none; b=cKkywFFCEwruYeXlC5DXCzJPb62kzqNGEw+02wfAA8TpC7pCx0YwJgcZTzOEWnv+Zpv1k2yndYRpwD9lSHfjzmBrlr9oXqEgU9xMiAnraS8bRi0sLXEYbdcj8maVrJD/s2PuQDvG+uz4tkUpzcIoH6ixPSsiyaYeOLYs7dJPmdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791911; c=relaxed/simple;
	bh=3CHmrIAyszwFM0IWdsUcipqJUlHGF9O40d3/y8Ctn4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OsjlQEChadmWvp6w0af3F395BmHSzI1Ol7sX54ofDqVD8T5KLLjGwOsQ6scjUALdpnYle0JpPA5XdJ8xqB4f1YSrV3b6nk6DbtKu8SGCDafvgJs5ZBrquHX93/gqbmtuJNLxobjII7Mc/LS0Cc/fYkOfxsjRpvQhfuPtaEXJ42Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCcTGXNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCcTGXNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76A0C32782;
	Fri, 16 Aug 2024 07:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791911;
	bh=3CHmrIAyszwFM0IWdsUcipqJUlHGF9O40d3/y8Ctn4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCcTGXNvKuiEBEs4A/3AWTdoPqqkAkGw9bsS1Zy9XUwGjtQqdBgwl02KLA1MBGFad
	 4EvejIRjNVg4QuLuGgtesKHlZNWuEQNNpRK48mM/UqFuWILGzl4x+qmc63qXn2xWM7
	 OcPVP1/5n2dhicaMyG4zYZ88o1n3VNGthLpBaQtl9LT1+Mj0wZ6wdYEiArlXUGol9x
	 sPJyovQN/kM8k4Q2KM6caJrm/NGZhgVDfMsmcKAdJytWurbp8lZeFyHfy+9v1TvUAw
	 EqP5YXoiv6IClhh/jt5C1W03nsa0R3LWRTEOU0pTmUbZVaXkLmTQ3SFPY896KVCBBR
	 cCTLpaTSyUEyA==
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
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH rcu 13/14] rcuscale: Count outstanding callbacks per-task rather than per-CPU
Date: Fri, 16 Aug 2024 12:32:55 +0530
Message-Id: <20240816070256.60993-13-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816070209.GA60666@neeraj.linux>
References: <20240816070209.GA60666@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The current rcu_scale_writer() asynchronous grace-period testing uses a
per-CPU counter to track the number of outstanding callbacks.  This is
subject to CPU-imbalance errors when tasks migrate from one CPU to another
between the time that the counter is incremented and the callback is
queued, and additionally in kernels configured such that callbacks can
be invoked on some CPU other than the one that queued it.

This commit therefore arranges for per-task callback counts, thus avoiding
any issues with migration of either tasks or callbacks.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcuscale.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 61a178914256..6d37596deb1f 100644
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

