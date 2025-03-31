Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2FF21C9E1;
	Mon, 31 Mar 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454996; cv=none; b=WOv50rt25k9KvgGPcHxcE/2Z7wi/vL2uBvVPZIkB2iuvz07//2MCN1662Of2naOpTZJIWG2Vp8q7TfNGvOxPxkbbVCHKXgn6k1tUStBcrhMLwXfcLI7J1dEvPXJ/hm1hiavIP6rIygyYzewTxBd/aqfPTx/DheJy7CvzftFDi0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454996; c=relaxed/simple;
	bh=1zu+tiXtv9EHc5tmGSDi0qMNWo1wCGu6vx+Yk4qI7Lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GXXhbHl+Jrudl+4rxYz3192cSazRRDOCxNKwOgEbGN+TiC8mjv7wsN+WAK/woTNLLZ+O1ALcDpNbyWs9zXULymtt87u6Xq0aH1ISqHKPbJySs0cCLFfU/h0VjECqtluyPxokoFtG9vzHUWRyBYB4Ejeju4AVOQ7WntnoxkTvnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qeb1Pgqt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qeb1Pgqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C831DC4CEF2;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454995;
	bh=1zu+tiXtv9EHc5tmGSDi0qMNWo1wCGu6vx+Yk4qI7Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qeb1PgqtgYDJnKofypo6RoakDGGU01cieJkh2ZB8Oy1EsawhGSb4RtcUAQE3KlF/i
	 azwhWgIaewmGVOJAN3zHeJgpyW/Z90oH1VFbpj13dRmPFexCOO9CFzPX7lM4SmoVz+
	 lbVu+w0fN2IuK/ig9Q3ZDRS3/Hhf9IsVj+bK5B0zzXtBnZE7iU6bKF9tWq3OBu2of/
	 6M4QO0jjJ7aCL57/DjoXvu6AJmTdIFOPeT1ukYICifvoJJGTlF111ORLRBlJwh553Z
	 ty33igFClrr2TLeUzlCCoZQgRnFA5JOPnQiSIDRLtIPNOu0y9/Qb6CSN5/2UXCNbu7
	 z1jq9EYl9eb1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3125ECE11EE; Mon, 31 Mar 2025 14:03:15 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 06/12] rcutorture: Pull rcu_torture_updown() loop body into new function
Date: Mon, 31 Mar 2025 14:03:08 -0700
Message-Id: <20250331210314.590622-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
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
index e7f0521c56d08..7eccc74e60a7f 100644
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

