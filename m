Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C42145355;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161092; cv=none; b=QZX7vXCf1oGmL/5ZnesVRY7tnKxxjpJvijTGnDyDj4YpuZho1Gr3o0ECB32LdmVF9T2t2Zyaah20Gyah6LRikXrLhKkSWqwJMYKSa4xSsZoB16bInm+rBVo5hbeYR8QiByPrZ4lh5UYPUGQ1SQWWeVE2vXz5NCY9JGw+RydHIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161092; c=relaxed/simple;
	bh=//FELBnZMe/1P4IlYUwD9U/a8/x4j15TVXGrWC50gRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NFwOyFQ3aicW4XJtSpcSw9pE/ZIx2P0LGjKu8aUWQXVDysbBwYM87mV2iRL5J/ViXCrc65cvzd2hE5uSvOy2dHK9MCairLDhXh7Y3aE20gIQpCx526n7FaKvQxJJbxeBQsaI3gF4lUcSBLeI39zSHDiY5FmXRi3vEwf65QFa7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUbIUpxQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUbIUpxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F46E1F00ADF;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=D9KA50uigaEU66rKjO2UKiByjh8eGkvgbDo4WqhIl9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jUbIUpxQPM2dGNs6AvsAj/kEIc9rEJ46EmqYMTXm/tdjnGQGaJ+0BGsDyEV0KnvCc
	 WGbTz+CLDECmxC7AuKWk4MEQu3t6GFyRf1uKdor3x/1JkHbFzTMucE0kN2jhJsVoLR
	 x8fWkThVYB0UzFXi49cO49HFB3R2mi1sYr+YXonLlebzeVea5wC6t1g9n3RdrecP99
	 zEkiTok76DFwxxHo7X+yomGjMV0C6vQNORuJPypBmDCKATq7LuCcSiPM9ka06ElDRy
	 4jNugcDu04F6fflMN1/Yph3tPzL6gYS1ZsvUQhTUKFds4iFrnhgZlUuunJrG1aic/V
	 bFFFMsItzbmGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2FD92CE0C57; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 05/24] hazptrtorture: Add microsecond-scale sleep in readers
Date: Wed, 15 Jul 2026 17:17:50 -0700
Message-Id: <20260716001809.11084-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a default-disabled reader_sleep_us module parameter
that causes the hazard-pointer reader to unconditionally sleep for the
specified number of microseconds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 0f25637c82876b..4dd31104779fe8 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -35,6 +35,7 @@ torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
 torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
 torture_param(int, preempt_interval, MSEC_PER_SEC, "Interval between preemptions (ms)");
+torture_param(int, reader_sleep_us, 0, "Reader sleep duration (us)");
 torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
 torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s");
@@ -219,6 +220,8 @@ static void hazptr_read_delay(struct torture_random_state *rrsp)
 		udelay(shortdelay_us);
 	if (!preempt_count() && !(torture_random(rrsp) % (nrealreaders * 500)))
 		torture_preempt_schedule();  /* QS only if preemptible. */
+	if (reader_sleep_us > 0)
+		torture_hrtimeout_us(reader_sleep_us, 0, NULL);
 }
 
 static void hazptr_torture_read_unlock(struct hazptr_ctx *hcp, struct hazptr_torture *htp)
@@ -508,11 +511,13 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
 		 "--- %s: nreaders=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "preempt_duration=%d preempt_interval=%d "
+		 "reader_sleep_us=%d "
 		 "shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d "
 		 "verbose=%d\n",
 		 torture_type, tag, nrealreaders,
 		 onoff_interval, onoff_holdoff,
 		 preempt_duration, preempt_interval,
+		 reader_sleep_us,
 		 shuffle_interval, shutdown_secs, stat_interval, stutter,
 		 verbose);
 }
-- 
2.40.1

