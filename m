Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258502586EA;
	Wed,  9 Jul 2025 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057787; cv=none; b=NrixcBeTK4jfrOAKFXkteBPmohXrJ2avgzNVwl6DqOEVXtkWWcZ7NgNlbRoghja4dl3lBZlUL1koX3o7kaDE3Dm0JsqawKB6gQGGPCSP/gQ/YANxehgHODC20Qb26pyNwSkHQfjNqyu0YXXG4+ztEMtJ7Xp39T47NZDKRH4RKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057787; c=relaxed/simple;
	bh=kP4pd/r/UqjMWTtaJcvV3OjNwAqsSwjeQjQVlhXCs9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N962Q5ZEzIKe5aEuyuIi0SWD4NiSEIqC4+fjJHcI4WBvP3ex4U4BPp02Am6sC1Xf5Im9j5kBKThjsPT78VhfCrXuZbSAyb/iaryzNuyM4/Lmhdh8nrvjNKWHwlScsWU6oXII2sbMgfG0G8ofs6Dy0tPrqnUU4EJs6mxIgBwWKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVxVSnV0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVxVSnV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED735C4CEEF;
	Wed,  9 Jul 2025 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057787;
	bh=kP4pd/r/UqjMWTtaJcvV3OjNwAqsSwjeQjQVlhXCs9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UVxVSnV0B75pwGodw2uClJeCiG01uRNUYinHJw/ZtMUoncbc4P+W86mCyQU2+C6y7
	 Y4SwVdfqLIVWV+vctexTxXZAczn43QNjzkGPj/2cNsMuZH4kVhq2VkWEhJ6Ys2jntD
	 c/cBm5al02FDNZ6JmeTh/2DJmlhKDpPqQ/thWtKWk1ps6iCkJfNQLBBZijH9mZEugW
	 2YyAPSsLcWRlK2WZQIcbXyYa69uI8i17pTkhfyVQk5OPajUY2Ex7QYk5avh06Af42g
	 2kelwv6u19Epk5kC+6KXC19Ggx1aLMQCbQA8rn7h+DPoeQbs4Qt6d0U694jCExGlbU
	 n6ewJPUMdUIBA==
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
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 06/15] rcutorture: Complain if an ->up_read() is delayed more than 10 seconds
Date: Wed,  9 Jul 2025 16:12:06 +0530
Message-Id: <20250709104215.15562-7-neeraj.upadhyay@kernel.org>
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

The down/up SRCU reader testing uses an hrtimer handler to exit the SRCU
read-side critical section.  This might be delayed, and if delayed for
too long, it can prevent the rcutorture run from completing.  This commit
therefore complains if the hrtimer handler is delayed for more than
ten seconds.

[ paulmck, joel: Apply kernel test robot feedback to avoid
false-positive complaint of excessive ->up_read() delays by using
HRTIMER_MODE_HARD ]

Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 13cf0e472868..22288efc8c67 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2447,6 +2447,8 @@ rcu_torture_reader(void *arg)
 struct rcu_torture_one_read_state_updown {
 	struct hrtimer rtorsu_hrt;
 	bool rtorsu_inuse;
+	ktime_t rtorsu_kt;
+	unsigned long rtorsu_j;
 	struct torture_random_state rtorsu_trs;
 	struct rcu_torture_one_read_state rtorsu_rtors;
 };
@@ -2485,7 +2487,7 @@ static int rcu_torture_updown_init(void)
 	for (i = 0; i < n_up_down; i++) {
 		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
 		hrtimer_setup(&updownreaders[i].rtorsu_hrt, rcu_torture_updown_hrt, CLOCK_MONOTONIC,
-			      HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+			      HRTIMER_MODE_REL | HRTIMER_MODE_HARD);
 		torture_random_init(&updownreaders[i].rtorsu_trs);
 		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors,
 						&updownreaders[i].rtorsu_trs);
@@ -2533,7 +2535,10 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
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
@@ -2544,6 +2549,7 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 static int
 rcu_torture_updown(void *arg)
 {
+	unsigned long j;
 	struct rcu_torture_one_read_state_updown *rtorsup;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_updown task started");
@@ -2551,8 +2557,12 @@ rcu_torture_updown(void *arg)
 		for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
 			if (torture_must_stop())
 				break;
-			if (smp_load_acquire(&rtorsup->rtorsu_inuse))
+			j = smp_load_acquire(&jiffies); // Time before ->rtorsu_inuse.
+			if (smp_load_acquire(&rtorsup->rtorsu_inuse)) {
+				WARN_ONCE(time_after(j, rtorsup->rtorsu_j + 1 + HZ * 10),
+					  "hrtimer queued at jiffies %lu for %lld ns took %lu jiffies\n", rtorsup->rtorsu_j, rtorsup->rtorsu_kt, j - rtorsup->rtorsu_j);
 				continue;
+			}
 			rcu_torture_updown_one(rtorsup);
 		}
 		torture_hrtimeout_ms(1, 1000, &rcu_torture_updown_rand);
-- 
2.40.1

