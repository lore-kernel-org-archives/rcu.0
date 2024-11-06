Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1FB205E2D;
	Wed,  6 Nov 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908958; cv=none; b=hxX/aS3MOZBzQak6EyA6mD93ywCQNPB96JkH6SetglQ69RpiwM4xu14LgBYeHdtoHVjpz+HZHSdR5bDWwDDtOwjyZ2CMryL2XAG0aVM/jlLNa/c2y9srt46MwpdEfdkugBZFllMBfxfhbvZZ6LiOKwGEWfEIJKrL8rzRwEoOGto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908958; c=relaxed/simple;
	bh=zfmB69Z3xb3CVeThnzwQWB10ZhWTFdBu117CVg5FG/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TC/QF9GPJ18NujXyLGalYEQYSVRhF3yGKebRRXO8MeNlf4pYsNggOjD0Xue4vZ7HaoTZJjYPR8yuWqhNuqlpd7cDbvq/oJvj0EJtzX7/Xw5haI84Ut+ZDjJ1yThdxcI2Os4N9vQVlzkIDuKK9vnLTDJ/6D49X0FOPoUBHsiyQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=US3V2bxN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US3V2bxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6396C4CED6;
	Wed,  6 Nov 2024 16:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908958;
	bh=zfmB69Z3xb3CVeThnzwQWB10ZhWTFdBu117CVg5FG/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=US3V2bxNdIcig1wbdN+HySmruVB8hPDXtM5nntafT1NgPz6BofWBWeDtMh911JaVX
	 pE3xrd/On3iWHRu623V2OMrfoj8D1BvulvJwMRysquB/hsYzqMOFq4m+tDBNXVqDM1
	 hReXw6tPEag6+1UWvoHoBB4DPEatnLtdJGxFz5bd0jNYctf741aJ+glllZBZ90YVMh
	 uMq/VrUUbELRSoxyn5Y5hpXY36EfWjevdpC5cGo+N6IMqerSVUbU3fjHaP7w+fMQon
	 aBMFDTXYZqJYsixOS5ZmFS+d6pgNA2jtuEXX+qZPepSW+LAKpZP929477fdf84wINK
	 +/JHgtEVaUDKw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 3/6] rcuscale: Add guest_os_delay module parameter
Date: Wed,  6 Nov 2024 17:02:20 +0100
Message-ID: <20241106160223.42119-4-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106160223.42119-1-frederic@kernel.org>
References: <20241106160223.42119-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a guest_os_delay module parameter that extends warm-up
and cool-down the specified number of seconds before and after the series
of test runs.  This allows the data-collection intervals from any given
rcuscale guest OSes to line up with active periods in the other rcuscale
guest OSes, and also allows the thermal warm-up period required to obtain
consistent results from one test to the next.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/refscale.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 25910ebe95c0..c8374760e003 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -75,6 +75,9 @@ MODULE_PARM_DESC(scale_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 torture_param(int, verbose_batched, 0, "Batch verbose debugging printk()s");
 
+// Number of seconds to extend warm-up and cool-down for multiple guest OSes
+torture_param(long, guest_os_delay, 0,
+	      "Number of seconds to extend warm-up/cool-down for multiple guest OSes.");
 // Wait until there are multiple CPUs before starting test.
 torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_SCALE_TEST) ? 10 : 0,
 	      "Holdoff time before test start (s)");
@@ -801,6 +804,18 @@ static void rcu_scale_one_reader(void)
 		cur_ops->delaysection(loops, readdelay / 1000, readdelay % 1000);
 }
 
+// Warm up cache, or, if needed run a series of rcu_scale_one_reader()
+// to allow multiple rcuscale guest OSes to collect mutually valid data.
+static void rcu_scale_warm_cool(void)
+{
+	unsigned long jdone = jiffies + (guest_os_delay > 0 ? guest_os_delay * HZ : -1);
+
+	do {
+		rcu_scale_one_reader();
+		cond_resched();
+	} while (time_before(jiffies, jdone));
+}
+
 // Reader kthread.  Repeatedly does empty RCU read-side
 // critical section, minimizing update-side interference.
 static int
@@ -957,6 +972,7 @@ static int main_func(void *arg)
 		schedule_timeout_uninterruptible(1);
 
 	// Start exp readers up per experiment
+	rcu_scale_warm_cool();
 	for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
 		if (torture_must_stop())
 			goto end;
@@ -987,6 +1003,7 @@ static int main_func(void *arg)
 
 		result_avg[exp] = div_u64(1000 * process_durations(nreaders), nreaders * loops);
 	}
+	rcu_scale_warm_cool();
 
 	// Print the average of all experiments
 	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
-- 
2.46.0

