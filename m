Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684D21766A;
	Wed,  9 Jul 2025 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057805; cv=none; b=A8DCSuvgfmFlcC7p6jaRqfbDDYyoOChUru5o2te1AYgs9p0qDTy3ZBf21e9/QxzKqiZprsSJrRm47OLSkBi0YjaFQ5/RlbhQKdX+9DftGiZmb9XrQMCjjob6wcQ5oQ1Dr7aDxAniT3k9UQO6aZ1vOXNYONACi1tIFJXJsRPqOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057805; c=relaxed/simple;
	bh=w0ultm8tcpppshfn+Iwj+Nx3B7+l8kg1Bdk2vOBcOKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSguC0OKGQ7sn6ctc3dREFQWKT4U+vVZ/JcffYtn60msNoowohTegRsv9ShENYDYPD4+l17Rugd+nhlcxk+oUxfo0N7DW4jFgxuPRAclXDCgufjbNfV6J5aBU/4/QYMokQ7t0TMF8cKQVA157bQNQf5muUlO3U96sPME2t72mGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAvzB56b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAvzB56b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3ACC4CEEF;
	Wed,  9 Jul 2025 10:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057805;
	bh=w0ultm8tcpppshfn+Iwj+Nx3B7+l8kg1Bdk2vOBcOKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cAvzB56ba9+mAjp2vx8tfBU4/7w2/W3pVGv/jVH83Bp3MJLWWueYmAj6ycmxiMjwR
	 UY1Z2gp6qUVNXKumWI5kh4osXnqp5XM42VgGbkM+khl3xVlVc9nPOocScUruh4Qz3z
	 6j2u2BJvJdfw+Uz++2l8VnLG6NX0UGOOjpRg0vndkq8Fc0hBDIs8rdCeH0pDijwd0u
	 TBN82VTQyGPGr15xrzIxFTZNYXbYs8WqcNlIMSpogrXMD0oToMjOw0RwQjjoRPG20Q
	 lrqmWR1sH9FZbex3i9ydeRpKX0juQbRrwvxtDutrCur8t+wMU7JTZQROALOF1jH4yP
	 06gBS6J1XAhtw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 09/15] rcutorture: Print number of RCU up/down readers and migrations
Date: Wed,  9 Jul 2025 16:12:09 +0530
Message-Id: <20250709104215.15562-10-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
References: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit prints the number of RCU up/down readers and the number
of such readers that migrated from one CPU to another, along
with the rest of the periodic rcu_torture_stats_print() output.
These statistics are currently used only by srcu_down_read{,_fast}()
and srcu_up_read(,_fast)().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 10f3cc4861ee..3f644b1f5823 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2450,9 +2450,11 @@ struct rcu_torture_one_read_state_updown {
 	struct hrtimer rtorsu_hrt;
 	bool rtorsu_inuse;
 	ktime_t rtorsu_kt;
+	int rtorsu_cpu;
 	unsigned long rtorsu_j;
 	unsigned long rtorsu_ndowns;
 	unsigned long rtorsu_nups;
+	unsigned long rtorsu_nmigrates;
 	struct torture_random_state rtorsu_trs;
 	struct rcu_torture_one_read_state rtorsu_rtors;
 };
@@ -2463,12 +2465,15 @@ static int rcu_torture_updown(void *arg);
 
 static enum hrtimer_restart rcu_torture_updown_hrt(struct hrtimer *hrtp)
 {
+	int cpu = raw_smp_processor_id();
 	struct rcu_torture_one_read_state_updown *rtorsup;
 
 	rtorsup = container_of(hrtp, struct rcu_torture_one_read_state_updown, rtorsu_hrt);
 	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
 	WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
-	rtorsup->rtorsu_nups++;
+	WRITE_ONCE(rtorsup->rtorsu_nups, rtorsup->rtorsu_nups + 1);
+	WRITE_ONCE(rtorsup->rtorsu_nmigrates,
+		   rtorsup->rtorsu_nmigrates + (cpu != rtorsup->rtorsu_cpu));
 	smp_store_release(&rtorsup->rtorsu_inuse, false);
 	return HRTIMER_NORESTART;
 }
@@ -2516,7 +2521,7 @@ static void rcu_torture_updown_cleanup(void)
 		if (hrtimer_cancel(&rtorsup->rtorsu_hrt) || WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
 			rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
 			WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
-			rtorsup->rtorsu_nups++;
+			WRITE_ONCE(rtorsup->rtorsu_nups, rtorsup->rtorsu_nups + 1);
 			smp_store_release(&rtorsup->rtorsu_inuse, false);
 		}
 
@@ -2534,13 +2539,14 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 
 	init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
 	rawidx = cur_ops->down_read();
-	rtorsup->rtorsu_ndowns++;
+	WRITE_ONCE(rtorsup->rtorsu_ndowns, rtorsup->rtorsu_ndowns + 1);
 	idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
 	rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
 	rtorsup->rtorsu_rtors.rtrsp++;
+	rtorsup->rtorsu_cpu = raw_smp_processor_id();
 	if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1)) {
 		WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
-		rtorsup->rtorsu_nups++;
+		WRITE_ONCE(rtorsup->rtorsu_nups, rtorsup->rtorsu_nups + 1);
 		schedule_timeout_idle(HZ);
 		return;
 	}
@@ -2649,6 +2655,10 @@ rcu_torture_stats_print(void)
 	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
 	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
 	long n_gpwraps = 0;
+	unsigned long ndowns = 0;
+	unsigned long nunexpired = 0;
+	unsigned long nmigrates = 0;
+	unsigned long nups = 0;
 	struct rcu_torture *rtcp;
 	static unsigned long rtcv_snap = ULONG_MAX;
 	static bool splatted;
@@ -2662,10 +2672,18 @@ rcu_torture_stats_print(void)
 		if (cur_ops->get_gpwrap_count)
 			n_gpwraps += cur_ops->get_gpwrap_count(cpu);
 	}
+	if (updownreaders) {
+		for (i = 0; i < n_up_down; i++) {
+			ndowns += READ_ONCE(updownreaders[i].rtorsu_ndowns);
+			nups += READ_ONCE(updownreaders[i].rtorsu_nups);
+			nunexpired += READ_ONCE(updownreaders[i].rtorsu_inuse);
+			nmigrates += READ_ONCE(updownreaders[i].rtorsu_nmigrates);
+		}
+	}
 	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
 		if (pipesummary[i] != 0)
 			break;
-	}
+	} // The value of variable "i" is used later, so don't clobber it!
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	rtcp = rcu_access_pointer(rcu_torture_current);
@@ -2686,6 +2704,8 @@ rcu_torture_stats_print(void)
 		n_rcu_torture_boost_failure,
 		n_rcu_torture_boosts,
 		atomic_long_read(&n_rcu_torture_timers));
+	if (updownreaders)
+		pr_cont("ndowns: %lu nups: %lu nhrt: %lu nmigrates: %lu ", ndowns, nups, nunexpired,  nmigrates);
 	torture_onoff_stats();
 	pr_cont("barrier: %ld/%ld:%ld ",
 		data_race(n_barrier_successes),
-- 
2.40.1

