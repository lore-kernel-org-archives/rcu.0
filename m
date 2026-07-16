Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD991DD877;
	Thu, 16 Jul 2026 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161094; cv=none; b=QZui2QIGFMkyzeeZYO7npkbLHMg2HIoD8qTIadcucI5FGOQUVYpLaOHXW28Asr7wwRh1ffBJAzkkzu2psR9ugenHblj5S3HMf850uVJMCY9/ZCqrvxXKDAqeUrtF1vPWC0HiclE/By2c7fVtSDUuXP0fMVwI17nkFxN5zOZdQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161094; c=relaxed/simple;
	bh=ZYDLakhWjRDXD/lE4lRucRuog7QGo2bBbwJt2eMu1wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYqSGlVnCI7w2d3xLQPISW8W15uz07QvioI/Mxq3vcTB0CTswmY4LQe2KWD0WQ0+AfSGeb12FMn4mT5T1ouMiHrM16xMyTyrtiQTagARPAx4NCEwUxPRlUx3/Yv4NaoHa6BtzmFrXhY0nR22K2zjQQxyaJY51ehszIdxsM0lx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzVfq33t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzVfq33t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926FB1F01558;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=Zg19oyFNV4LWAa8FUqpybXusDjwvYpSzum/Y8JLe4ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SzVfq33tzTcQf5SoZ1uGpGcfr5rCqbrMGAFlR2RCXGNUiiCg1el4oOyjTUw0vEe0I
	 RxhEU0dDPNTeQbY33BHpINkD8/RtJ19LPeOhMT10PVBLdHUvw/Xc+88PxPARRmaQAk
	 JC1AAEv4KtNuOSnHbbZkWG5yJygqsOaAUbJn9w94caqDHMXMfJv/kx3yldp4mSdCQN
	 Fks/FPjNF+pNJPpQ8Ku0s9ESuCQDsP4wjgrfaCj18Mk5f4uTIVzV5DIL0bceiHJpjd
	 QFJYNxgHavQgq1w+BYmXS6vzuPrY3SBhGzOhqkYECkG7dyVUROAm8OZtVd3zcaIsTX
	 tMr9esSXl29bg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 39748CE0E5D; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 09/24] hazptrtorture: Split hazptr_torture_reader_tail() from hazptr_torture_reader()
Date: Wed, 15 Jul 2026 17:17:54 -0700
Message-Id: <20260716001809.11084-9-paulmck@kernel.org>
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

This commit splits a new hazptr_torture_reader_tail() function out
of hazptr_torture_reader().  This will allow hazptr_torture_reader()
to pass hazard pointers off to other tasks and to various types of
handlers, and those hazard pointers can in turn be passed to this new
hazptr_torture_reader_tail() function to complete processing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c | 42 +++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index adaf250ecfd585..3d559cfb85816d 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -351,6 +351,31 @@ hazptr_torture_writer(void *arg)
 	return 0;
 }
 
+/*
+ * Do the delay, the accounting, and the release.  This in intended to
+ * be invoked from hazptr_torture_reader, but also for hazard pointers
+ * sent off to interrupt handlers and the like.
+ */
+static void hazptr_torture_reader_tail(struct hazptr_ctx *hcp, struct hazptr_torture *htp,
+				       struct torture_random_state *trsp)
+{
+	int pipe_count;
+
+	cur_ops->read_delay(trsp);
+	preempt_disable();
+	pipe_count = READ_ONCE(htp->htort_pipe_count);
+	if (pipe_count > HAZPTR_TORTURE_PIPE_LEN) {
+		// Should not happen in a correct hazptr implementation,
+		// happens quite often for TBD torture_type=busted.
+		pipe_count = HAZPTR_TORTURE_PIPE_LEN;
+	}
+	if (pipe_count > 1)
+		rcu_ftrace_dump(DUMP_ALL);
+	__this_cpu_inc(hazptr_torture_count[pipe_count]);
+	preempt_enable();
+	cur_ops->readunlock(hcp, htp);
+}
+
 /*
  * Hazard-pointer torture reader kthread.  Repeatedly dereferences
  * hazptr_torture_current, incrementing the corresponding element of the
@@ -365,7 +390,6 @@ static int hazptr_torture_reader(void *arg)
 	unsigned long lastsleep = jiffies;
 	long myid = (long)arg;
 	int mynumonline = myid % nr_cpu_ids;
-	int pipe_count;
 	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("hazptr_torture_reader task started");
@@ -373,6 +397,8 @@ static int hazptr_torture_reader(void *arg)
 	do {
 		htp = cur_ops->readlock(&hcp);
 		if (!htp) {
+			// Still starting up or allocation failure,
+			// so get out of the way.
 			schedule_timeout_interruptible(HZ / 10);
 			continue;
 		}
@@ -380,19 +406,7 @@ static int hazptr_torture_reader(void *arg)
 			torture_hrtimeout_us(500, 1000, &rand);
 			lastsleep = jiffies + 10;
 		}
-		cur_ops->read_delay(&rand);
-		preempt_disable();
-		pipe_count = READ_ONCE(htp->htort_pipe_count);
-		if (pipe_count > HAZPTR_TORTURE_PIPE_LEN) {
-			// Should not happen in a correct RCU implementation,
-			// happens quite often for torture_type=busted.
-			pipe_count = HAZPTR_TORTURE_PIPE_LEN;
-		}
-		if (pipe_count > 1)
-			rcu_ftrace_dump(DUMP_ALL);
-		__this_cpu_inc(hazptr_torture_count[pipe_count]);
-		preempt_enable();
-		cur_ops->readunlock(hcp, htp);
+		hazptr_torture_reader_tail(hcp, htp, &rand);
 		while (!torture_must_stop() &&
 		       (torture_num_online_cpus() < mynumonline || !rcu_inkernel_boot_has_ended()))
 			schedule_timeout_interruptible(HZ / 5);
-- 
2.40.1

