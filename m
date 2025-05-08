Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3153722D9FF;
	Thu,  8 May 2025 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747904; cv=none; b=fDumaQAuq6QEBQjdSwqLKncrOSdTmA+vgATA1p4tfLN9hMBgDLNvaikTp3GYZriqS1Y+3y9Z2XOs77rs40eLEdkVJOpB+1GLLlq+5CIgJcMPzJgI2gim3tfU6xuGzF2gqgnGe1RDRHkTX7hoCgmpyuNwFIk3yewtiA/yC3VifYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747904; c=relaxed/simple;
	bh=bvCZgli80KnITWarlCrhmBdHt7QXA9LBPnvN1OFeIHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d7j8Ck+5BfTRfEcW3Sp0oQSm8OtOmUaXCXSgHTjpgTDS/eFCIsgFaOdhe4YW1gpndujycuKk9IOfymvaI0/l8/DMDLoncJoEvZfOROGPhQfeJhYZyUyWI++2KHAtUzvzC9rbyQP6BxkzEzcTkZshYx68mTFVjQ1/az0Mu1bY5xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEFGDNA9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEFGDNA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ABEC4CEED;
	Thu,  8 May 2025 23:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746747904;
	bh=bvCZgli80KnITWarlCrhmBdHt7QXA9LBPnvN1OFeIHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fEFGDNA9IaWTXP3d6e/ocxz+i83PL2a00I+8tmusPGA3h5OCXw3Aa79muJ1MNGMF/
	 Lt/A2H/7SAxr3LthaMSWpfW9eDVPe/DPfvfKUNAK9Tozh/FPWWnA5G2Wf0h6TGu7ce
	 tRcvKHP/IuBR32YINzsi8q6UssmtbspSnm1oQJgC1bMAAB9Uagm6yCp6x4XlpBz3By
	 yHdwVRRtatdMkR8vmArqqsS8mfiqXzlaHtBp5ZiNZFBcpMOY0QxEJE7jasp5Ol32Vh
	 SkVTC15OV+rEnbPeAxRjNYF7sZLnLxo8WT8qtI5JJJIp3YTDIUQIVqTbMeedleoD/0
	 EeM8K3szxx6EQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B242BCE11D3; Thu,  8 May 2025 16:45:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/5] rcutorture: Print number of RCU up/down readers and migrations
Date: Thu,  8 May 2025 16:44:59 -0700
Message-Id: <20250508234502.1996788-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a942066a-85cb-4932-b4de-0ee39287ab7d@paulmck-laptop>
References: <a942066a-85cb-4932-b4de-0ee39287ab7d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit prints the number of RCU up/down readers and the number
of such readers that migrated from one CPU to another, along
with the rest of the periodic rcu_torture_stats_print() output.
These statistics are currently used only by srcu_down_read{,_fast}()
and srcu_up_read(,_fast)().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0e044afa98d32..21ff365fca5d9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2447,9 +2447,11 @@ struct rcu_torture_one_read_state_updown {
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
@@ -2460,12 +2462,15 @@ static int rcu_torture_updown(void *arg);
 
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
@@ -2513,7 +2518,7 @@ static void rcu_torture_updown_cleanup(void)
 		if (hrtimer_cancel(&rtorsup->rtorsu_hrt) || WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
 			rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
 			WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
-			rtorsup->rtorsu_nups++;
+			WRITE_ONCE(rtorsup->rtorsu_nups, rtorsup->rtorsu_nups + 1);
 			smp_store_release(&rtorsup->rtorsu_inuse, false);
 		}
 
@@ -2531,13 +2536,14 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 
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
@@ -2646,6 +2652,10 @@ rcu_torture_stats_print(void)
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
@@ -2659,10 +2669,18 @@ rcu_torture_stats_print(void)
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
@@ -2683,6 +2701,8 @@ rcu_torture_stats_print(void)
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

