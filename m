Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7712EAB61;
	Thu, 18 Sep 2025 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191394; cv=none; b=t/X5Ee1zCIwYrkd7P42bhLMOexGsjIIvfPgs1RQX93OSeR9ObtZZInd7+oKF2iofqxTtgXLb2ib16P2vljNGElR6bnMK8B0HR8BznLbAYp8DUdAfH+Mw0Ip3R3XdwuLQA4YklzB5bo/enICrHKCyf/Bd1DKXoClIwFoTz6Kmsdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191394; c=relaxed/simple;
	bh=b9sPRChOApZiUr0xwL3sxPCf4tYxxEx0JLu49QV5rt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INs8fNrgvlrxBSunQnq5ZR611WJn8eK8Ttefb7zgAA+n5tviVp5X2VeeieBQOkLmSJHAvQWILqgX0h4ePXGea9cvJ5wPsbwYnhZb3o4Kb1fV6Notie5Mi7pvoN2pBkp+2IZjVhNSNBS5mlUlb0SFCGlFS9dW6RyBU/nzfFJSWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmF9nrC7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmF9nrC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFEBC4CEFA;
	Thu, 18 Sep 2025 10:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191394;
	bh=b9sPRChOApZiUr0xwL3sxPCf4tYxxEx0JLu49QV5rt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmF9nrC7jx76D0QchYlJ7NNph2K4+VOs1dglNydEdlLbNELwQ5QKHVY7/hsOIkAC9
	 bYcudcVB5ftvEoDBNt9Oy6SeLuxim877t7Gqj7bN7lsWG+hpvFIN6YpO/dFmOMoZtj
	 RcFZpdYOa+ZXPDAoD29xJ912gN9HNklneNmfDYH2eX/ywn3BpdUXa5Ib/d1aD4rou8
	 wGniZf60qJ3Av+hmE7L5Kx51LhMpX/Yj1fjqNRZjwWQ59NJkd7/4a8+o90afzsuahG
	 yKwYjDQVLpWNOfqSHhICbfbYIps4EkTSN/GPrjFMWA5iBrV7WgypI09HCASAx0ZRJy
	 H+umF3JNn2B9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D7C99CE10B6; Thu, 18 Sep 2025 03:29:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 05/11] rcutorture: Delay rcutorture readers and writers until boot completes
Date: Thu, 18 Sep 2025 03:29:46 -0700
Message-Id: <20250918102952.2593045-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
References: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcutorture writers and (especially) readers are the biggest CPU
hogs of the bunch, so this commit therefore makes them wait until boot
has completed.

This makes the current setting of the boot_ended local variable dead code,
so while in the area, this commit removes that as well.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 49e048da4f6810..1578d330565752 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1528,7 +1528,7 @@ static void do_rtws_sync(struct torture_random_state *trsp, void (*sync)(void))
 static int
 rcu_torture_writer(void *arg)
 {
-	bool boot_ended;
+	bool booting_still = false;
 	bool can_expedite = !rcu_gp_is_expedited() && !rcu_gp_is_normal();
 	unsigned long cookie;
 	struct rcu_gp_oldstate cookie_full;
@@ -1539,6 +1539,7 @@ rcu_torture_writer(void *arg)
 	struct rcu_gp_oldstate gp_snap1_full;
 	int i;
 	int idx;
+	unsigned long j;
 	int oldnice = task_nice(current);
 	struct rcu_gp_oldstate *rgo = NULL;
 	int rgo_size = 0;
@@ -1581,6 +1582,16 @@ rcu_torture_writer(void *arg)
 			rgo_size = cur_ops->poll_active_full;
 	}
 
+	// If the system is still booting, let it finish.
+	j = jiffies;
+	while (!torture_must_stop() && !rcu_inkernel_boot_has_ended()) {
+		booting_still = true;
+		schedule_timeout_interruptible(HZ);
+	}
+	if (booting_still)
+		pr_alert("%s" TORTURE_FLAG " Waited %lu jiffies for boot to complete.\n",
+			 torture_type, jiffies - j);
+
 	do {
 		rcu_torture_writer_state = RTWS_FIXED_DELAY;
 		torture_hrtimeout_us(500, 1000, &rand);
@@ -1769,13 +1780,11 @@ rcu_torture_writer(void *arg)
 				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
-		boot_ended = rcu_inkernel_boot_has_ended();
 		stutter_waited = stutter_wait("rcu_torture_writer");
 		if (stutter_waited &&
 		    !atomic_read(&rcu_fwd_cb_nodelay) &&
 		    !cur_ops->slow_gps &&
 		    !torture_must_stop() &&
-		    boot_ended &&
 		    time_after(jiffies, stallsdone))
 			for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
 				if (list_empty(&rcu_tortures[i].rtort_free) &&
@@ -2437,7 +2446,8 @@ rcu_torture_reader(void *arg)
 			torture_hrtimeout_us(500, 1000, &rand);
 			lastsleep = jiffies + 10;
 		}
-		while (torture_num_online_cpus() < mynumonline && !torture_must_stop())
+		while (!torture_must_stop() &&
+		       (torture_num_online_cpus() < mynumonline || !rcu_inkernel_boot_has_ended()))
 			schedule_timeout_interruptible(HZ / 5);
 		stutter_wait("rcu_torture_reader");
 	} while (!torture_must_stop());
-- 
2.40.1

