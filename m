Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BCE2A8DD
	for <rcu@vger.kernel.org>; Sun, 27 Apr 2025 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745794413; cv=none; b=Tw97qHSaqaz7FEnWQevl1xJgwhm+DH+zq3sQvPeCvAT9/4zEO0MBAFgPyTiqu4U3BlyIxkUfVG+15PSwx7bjPeZiClqjCSlWVEFGKvG6j7TqOCwO3QXFYi928EmTqBACn2dzomgBgpk9aJZgZyhNRvhDVBDrA5l+lfhgzpeGsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745794413; c=relaxed/simple;
	bh=mvmtJ+aknAbnlsLKu3yeyLXvlCRWJTrdq2fONLMLAZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iLiCm+SpobN1oW7xm0Jzfc5F1OwENzxFGrCcaxHcYY/6Z/O38aK+eAcKF4qq3MTfEHqESCAclzNhPbPBCfOUwU+EDRnE40cfl2YVhNz/inj2PH4bOoytc38F3HV52MIjZ12AvH5QUZ9NEAG9HzFl/q2SwdrSImyqm0k/3smckfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi9aRK1k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi9aRK1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286ECC4CEE3;
	Sun, 27 Apr 2025 22:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745794413;
	bh=mvmtJ+aknAbnlsLKu3yeyLXvlCRWJTrdq2fONLMLAZ4=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=pi9aRK1kB0+1MiTsADlQ6TnMpxq5lJeTWnVAdPBtwVi2qujXybaFU+OgUh7xgvdMv
	 soVg3jvKpFMLui4Hl2AB9aR8QLiTXzYyXVpPiCr/rS3Nb+1vgximxEZKuxRuLLb/ve
	 h0KOQj1jmwwX1FhBP2QdeJtoMwhhTz0gYyDcTWSlRnNXBojjcLFa1US3H1uhTEGKDK
	 dwMF4CJIgQYox8hO9bHu4vj3xwfrGMGVN5RWd3q5NTuTPgjzulEZrw1Sasp/UQyRYJ
	 c5iTO5FnI24BuG2wuJy6aAPrsykv1euOFP9/ejp1zcOcbfsLa8QdFGZvRtEFbWQ/NL
	 IPMtO4oIKxUnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9A98DCE0571; Sun, 27 Apr 2025 15:53:31 -0700 (PDT)
Date: Sun, 27 Apr 2025 15:53:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: kernel test robot <oliver.sang@intel.com>, rcu@vger.kernel.org
Subject: [PATCH squash] rcutorture: Complain if an ->up_read() is delayed
 more than 10 seconds
Message-ID: <a66a1398-4ba7-4147-916b-a8b2302efd62@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This to-be-squashed commit avoids false-positive complaint of excessive
->up_read() delays.  These false positives could arise by task-level
delays in the rcu_torture_updown() and rcu_torture_updown_one() functions,
or due to delays in softirq scheduling of the HRTIMER_MODE_SOFT
rcu_torture_updown_hrt() handler.  Avoid the task-level delays by
sampling the time after queuing the hrtimer on the one hand and by
sampling the time before reading the ->rtorsu_inuse flag on the other.
Avoid the softirq scheduling delays through use of HRTIMER_MODE_HARD.

[ paulmck: Apply kernel test robot feedback. ]

Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bb9a8e7185334..0e044afa98d32 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2446,6 +2446,7 @@ rcu_torture_reader(void *arg)
 struct rcu_torture_one_read_state_updown {
 	struct hrtimer rtorsu_hrt;
 	bool rtorsu_inuse;
+	ktime_t rtorsu_kt;
 	unsigned long rtorsu_j;
 	unsigned long rtorsu_ndowns;
 	unsigned long rtorsu_nups;
@@ -2489,7 +2490,7 @@ static int rcu_torture_updown_init(void)
 	for (i = 0; i < n_up_down; i++) {
 		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
 		hrtimer_setup(&updownreaders[i].rtorsu_hrt, rcu_torture_updown_hrt, CLOCK_MONOTONIC,
-			      HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+			      HRTIMER_MODE_REL | HRTIMER_MODE_HARD);
 		torture_random_init(&updownreaders[i].rtorsu_trs);
 		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors,
 						&updownreaders[i].rtorsu_trs);
@@ -2540,12 +2541,14 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 		schedule_timeout_idle(HZ);
 		return;
 	}
-	rtorsup->rtorsu_j = jiffies;
 	smp_store_release(&rtorsup->rtorsu_inuse, true);
 	t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
 	if (t < 10 * 1000)
 		t = 200 * 1000 * 1000;
-	hrtimer_start(&rtorsup->rtorsu_hrt, t, HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+	hrtimer_start(&rtorsup->rtorsu_hrt, t, HRTIMER_MODE_REL | HRTIMER_MODE_HARD);
+	smp_mb(); // Sample jiffies after posting hrtimer.
+	rtorsup->rtorsu_j = jiffies;  // Not used by hrtimer handler.
+	rtorsup->rtorsu_kt = t;
 }
 
 /*
@@ -2556,6 +2559,7 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 static int
 rcu_torture_updown(void *arg)
 {
+	unsigned long j;
 	struct rcu_torture_one_read_state_updown *rtorsup;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_updown task started");
@@ -2563,8 +2567,10 @@ rcu_torture_updown(void *arg)
 		for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
 			if (torture_must_stop())
 				break;
+			j = smp_load_acquire(&jiffies); // Time before ->rtorsu_inuse.
 			if (smp_load_acquire(&rtorsup->rtorsu_inuse)) {
-				WARN_ON_ONCE(time_after(jiffies, rtorsup->rtorsu_j + 10 * HZ));
+				WARN_ONCE(time_after(j, rtorsup->rtorsu_j + 1 + HZ * 10),
+					  "hrtimer queued at jiffies %lu for %lld ns took %lu jiffies\n", rtorsup->rtorsu_j, rtorsup->rtorsu_kt, j - rtorsup->rtorsu_j);
 				continue;
 			}
 			rcu_torture_updown_one(rtorsup);
