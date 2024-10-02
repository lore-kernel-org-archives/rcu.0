Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4F91D079B;
	Wed,  2 Oct 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881068; cv=none; b=ZpZVFccqSDJ3h5nmo3l/4F0ZFLZ0LAl6MfSYTHYRF+AF5Xau/YASRUDYb7bbZiNUUhKdrRxXZysvvmhq4nmwNIjQFV/zrZ/BhN8miNfb6wJeH3ff+D+t6m4nKS3Qzi7D5kSwWy7ErbQpl0oasJ2ZQHQQEH+I8o4Nj3Qn7mZI+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881068; c=relaxed/simple;
	bh=52YRPDjGp4dDviquEXrrl2kjbqpQryVts8kljcTPeDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzRGxVNPjSSXvmenqZOIBt9vW2WSZ1h0KtxzlBKpNOkXASY53nnFaRP8SrGzvZznA+HcCVJELxKnbUG2spzXmnEvIiQe3c+b7tWqRb1h8XqUr3vyNNRurugvD750sjfu5Z+o2cyg36SpNrYxl7rWPE1GY05zrQrA+wQV1hGta9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F75B7Wsv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F75B7Wsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FB1C4CEC2;
	Wed,  2 Oct 2024 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881067;
	bh=52YRPDjGp4dDviquEXrrl2kjbqpQryVts8kljcTPeDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F75B7WsvBbvuxc7fsu+By/22DRQxkIj+tWtpyw0rstH6Zr3zHNGV9P2WpR1tPS9Pg
	 wX0aTUxv2tqrMA6ODjShbWOCL9IK0IzmlpiBOZpiQrOO1tnQc7e5P4apJk5HaFxhXn
	 TAuv7M37lNIni9xqcaFW5ZZ1YsrygDYRNI69oZe3MyqVp+beYogl0UGsSjfG0PN5pg
	 x+IPQwsW+cqGnQMQvKjX5A+O/xpcdfYDxZBM10K39BqaC4Ia2j1YqRfBsIEKdfagNT
	 7JGDSbaZSIBCX+sGXxS5E3NAf9cbQ2/nl+Pd9cVSRSMofSthj9Ig/9fF7D+NfB5LbL
	 RwRcag8PXKBjQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 1/3] rcu/nocb: Use switch/case on NOCB timer state machine
Date: Wed,  2 Oct 2024 16:57:36 +0200
Message-ID: <20241002145738.38226-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002145738.38226-1-frederic@kernel.org>
References: <20241002145738.38226-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's more convenient to benefit from the fallthrough feature of
switch / case to handle the timer state machine. Also a new state is
about to be added that will take advantage of it.

No intended functional change.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 97b99cd06923..2fb803f863da 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -271,22 +271,35 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 
-	/*
-	 * Bypass wakeup overrides previous deferments. In case of
-	 * callback storms, no need to wake up too early.
-	 */
-	if (waketype == RCU_NOCB_WAKE_LAZY &&
-	    rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
-		mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
-		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
-	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
+	switch (waketype) {
+	case RCU_NOCB_WAKE_BYPASS:
+		/*
+		 * Bypass wakeup overrides previous deferments. In case of
+		 * callback storms, no need to wake up too early.
+		 */
 		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
 		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
-	} else {
+		break;
+	case RCU_NOCB_WAKE_LAZY:
+		if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
+			mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
+			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+		}
+		/*
+		 * If the timer is already armed, a non-lazy enqueue may have happened
+		 * in-between. Don't delay it and fall-through.
+		 */
+		break;
+	case RCU_NOCB_WAKE:
+		fallthrough;
+	case RCU_NOCB_WAKE_FORCE:
 		if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
 			mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
 		if (rdp_gp->nocb_defer_wakeup < waketype)
 			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+		break;
+	default:
+		WARN_ON_ONCE(1);
 	}
 
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
-- 
2.46.0

