Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B476D235C1B;
	Mon, 10 Mar 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631892; cv=none; b=X7KV6RHTqXEgePnMnnW0KFAPCXlBWwmSmuKaHDtT4sM10TmFHBN5IK2YUIiXbuh4qw9RtCnNd0X5qamyKNN4MNOD8MDeJeiyYJ3TF6keYLVeLBMC6dOiHH0XzAnn+i7z6pVFKUc1HWjWq/E3qpXusJXF+RgdqXcM29/NBYPv3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631892; c=relaxed/simple;
	bh=49ZKHlT4AKvojbmFQ6+D5rEHUXLvNqqx95V8uLPi97Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SbdxzTctrUp+HjZZMd7UbIsUUvo5lVH+sGOoK/uiC6iW6wbV4T5p+71C34LmKZahKMOQnBIU5BtDYWDQAxXAcduIqijVHJRCBWUgQEULGl7M8ziMzI5JbC6q8Ya3I1phv7INi0+sEG0B9AG+JJcvTU5FaqPEtLLzbDJ7Es4TjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZmXgrdt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZmXgrdt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C74C4CEF4;
	Mon, 10 Mar 2025 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741631892;
	bh=49ZKHlT4AKvojbmFQ6+D5rEHUXLvNqqx95V8uLPi97Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZmXgrdt2IRncH8gy5bmLRP1PCYQsge8OnMpR457h++6qRy7xYC4Xmh2q7oumyOze
	 PhL2B11T54IGa1zfHm2dqg6/8XFjdFTmJJ9yWp1TOWR8LiXPRsQpDW034BPVP0j7GT
	 coKk9otC75zJKWdp9Y0V7tvj8IL9j7KwHgNVZOU48ElHPeOFbd/uBPw6pIGhTV6ZZG
	 T6I2rVWwMk0cGWpKjawpI4i2twDfAPfRhjWSUkVxftmy+KErWdHN+ctksR1vYA7PpL
	 TQI2RKascocarRIV2AIxD7vXqNQ+2QwC6fmgGPF7kAjY3M36uKh3b9gjG5+hSacLRY
	 ZedIMH5VzlsBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9BB38CE1312; Mon, 10 Mar 2025 11:38:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 6/9] rcutorture: Pull rcu_torture_updown() loop body into new function
Date: Mon, 10 Mar 2025 11:38:06 -0700
Message-Id: <20250310183809.3576320-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
References: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is strictly a code-movement commit, pulling that part of
the rcu_torture_updown() function's loop body that processes
one rcu_torture_one_read_state_updown structure into a new
rcu_torture_updown_one() function.  The checks for the end of the
torture test and the current structure being in use remain in the
rcu_torture_updown() function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 46 ++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6afcd33e724ba..6d808c70349c4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2505,6 +2505,30 @@ static void rcu_torture_updown_cleanup(void)
 	updownreaders = NULL;
 }
 
+// Do one reader for rcu_torture_updown().
+static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rtorsup)
+{
+	int idx;
+	int rawidx;
+	ktime_t t;
+
+	init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
+	rawidx = cur_ops->down_read();
+	idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
+	rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
+	rtorsup->rtorsu_rtors.rtrsp++;
+	if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1)) {
+		cur_ops->up_read(rawidx);
+		schedule_timeout_idle(HZ);
+		return;
+	}
+	smp_store_release(&rtorsup->rtorsu_inuse, true);
+	t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
+	if (t < 10 * 1000)
+		t = 200 * 1000 * 1000;
+	hrtimer_start(&rtorsup->rtorsu_hrt, t, HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+}
+
 /*
  * RCU torture up/down reader kthread, starting RCU readers in kthread
  * context and ending them in hrtimer handlers.  Otherwise similar to
@@ -2513,10 +2537,7 @@ static void rcu_torture_updown_cleanup(void)
 static int
 rcu_torture_updown(void *arg)
 {
-	int idx;
-	int rawidx;
 	struct rcu_torture_one_read_state_updown *rtorsup;
-	ktime_t t;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_updown task started");
 	do {
@@ -2525,24 +2546,7 @@ rcu_torture_updown(void *arg)
 				break;
 			if (smp_load_acquire(&rtorsup->rtorsu_inuse))
 				continue;
-			init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors,
-							&rtorsup->rtorsu_trs);
-			rawidx = cur_ops->down_read();
-			idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
-			rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
-			rtorsup->rtorsu_rtors.rtrsp++;
-			if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors,
-							&rtorsup->rtorsu_trs, -1)) {
-				cur_ops->up_read(rawidx);
-				schedule_timeout_idle(HZ);
-				continue;
-			}
-			smp_store_release(&rtorsup->rtorsu_inuse, true);
-			t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
-			if (t < 10 * 1000)
-				t = 200 * 1000 * 1000;
-			hrtimer_start(&rtorsup->rtorsu_hrt, t,
-				      HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+			rcu_torture_updown_one(rtorsup);
 		}
 		torture_hrtimeout_ms(1, 1000, &rcu_torture_updown_rand);
 		stutter_wait("rcu_torture_updown");
-- 
2.40.1

