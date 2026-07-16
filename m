Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460232264B0;
	Thu, 16 Jul 2026 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161097; cv=none; b=vAUWJUXaFTa+2Qec4SnBoGX+BPEChQN+eTjo3ZCvgLwTPMVgqOvxe85/OPUbvlHAJrQxTHeDwbDvagoY8IZIgBMR1Om641L18HmadNgqkStPk3uKkLepcirWZev39crRYIo5q5W+2ksLS2gNAc/izEuMuMoVHLr0XkLyutE5Flo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161097; c=relaxed/simple;
	bh=7Pyke/o79sTDfkUqS45VlLOxDMP8MIL1i7PXIg6sUu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEHYsn/3UpOeZWU2/vCWFN83a/B4t6+ULhRfOBpdxcYlf1G/vlygfX8WUMtIs8Uzw5lStUY3JohfzsGT9Jm82TE4dj1E7FamVuMjI+5a7Yu9A/RsZCwPuGToKjXdAPlJXd+IrSHhJqaqi0u9wR/gSj+UM4qbhrvcnjS9XSVSGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvP8yra/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvP8yra/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D6B1F00A3D;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=AAbLUnNrcnqFC0CF5ESAMKua77koOg9Ol3O6aMT/qRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SvP8yra/uNjYWoI5kgfJAusi/owJ0qAIS//DRKTW2g8y8v8B3wCv/MsRSFJ+cVO6K
	 kbPyB+h8DV2HA1gBLY/lwHo1TSZAyUCCaBPSlWzy16a+60rYDelYzg0wPbgAjEqqja
	 UvsPGW/WaQHUMfWPYcOIkH70FQvOzJ5w8yHYj3ThPTbm3nBs8DeRD9/JgND6hl4iC2
	 lpv07/a8kWb3lEjYSpFei92+uykNKmgx0bYEEoczF2xuQTsIhIIO+zchiaiBB0yMX3
	 pMzU1+QDb71jyBV/kMIi2aT7F8WfkESpWyCAtMbFdICM0gSKw0HV+fJoVR4HdjEFpM
	 2ksItvwfz96Xw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 47D1ECE0F4C; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 15/24] hazptrtorture: Add the ability to disable the writer kthread
Date: Wed, 15 Jul 2026 17:18:00 -0700
Message-Id: <20260716001809.11084-15-paulmck@kernel.org>
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

This commit adds a hazptrtorture.nwriters module parameter that, when set
to zero, disables hazard-pointer update-side activity.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 625ed90912a2c6..0752cedb2f5570 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -36,6 +36,7 @@ torture_param(int, irq_acquire, -1,
 torture_param(int, kthread_do_pending_ms, -1,
 	      "Delay between cleanups for deferred hazard pointers (ms), zero to disable");
 torture_param(int, nreaders, -1, "Number of hazard-pointer reader threads");
+torture_param(int, nwriters, 1, "Number of hazard-pointer writer threads, 0 or 1");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
 torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
@@ -658,14 +659,14 @@ static void
 hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" TORTURE_FLAG
-		 "--- %s: nreaders=%d "
+		 "--- %s: nreaders=%d nwriters=%d "
 		 "defer_modulus=%d irq_acquire=%d kthread_do_pending_ms=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "preempt_duration=%d preempt_interval=%d "
 		 "reader_sleep_us=%d "
 		 "shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d "
 		 "verbose=%d\n",
-		 torture_type, tag, nrealreaders,
+		 torture_type, tag, nrealreaders, nwriters,
 		 defer_modulus, irq_acquire, kthread_do_pending_ms,
 		 onoff_interval, onoff_holdoff,
 		 preempt_duration, preempt_interval,
@@ -825,9 +826,12 @@ static int __init hazptr_torture_init(void)
 			goto unwind;
 	}
 
-	firsterr = torture_create_kthread(hazptr_torture_writer, NULL, writer_task);
-	if (torture_init_error(firsterr))
-		goto unwind;
+	if (nwriters) {
+		WARN_ON(IS_BUILTIN(CONFIG_HAZPTR_TORTURE_TEST) && nwriters != 1);
+		firsterr = torture_create_kthread(hazptr_torture_writer, NULL, writer_task);
+		if (torture_init_error(firsterr))
+			goto unwind;
+	}
 
 	firsterr = torture_onoff_init(onoff_holdoff * HZ, onoff_interval, NULL);
 	if (torture_init_error(firsterr))
-- 
2.40.1

