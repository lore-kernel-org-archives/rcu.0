Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A273A223C40;
	Thu, 12 Dec 2024 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028936; cv=none; b=XoripqKk9oy21f1lRmdGT7Sr5SYDUZvK9vzuGfNVlftm2IitfVU/wj9y6iiladDK2iNlB8/lGW4ZApoWEKlqMYoLcIYJNdYFtEBhg6EyJQ4LSSgXo8E98g11hYVppCtg2Qb2tFUw0yeLyYbSTs32L3VcInnuNm784qByVa3uzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028936; c=relaxed/simple;
	bh=uu3fvbyDisEB5DAy3KLp/ZLuYwUsfAY7GhAaSJ6sfRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X0/ubVhTRf26aT1LDSwOCs/jRMJHxhp1rzhjkHas3MjwB80gyKCyvaz435iay8mHFz7c3aV/RLV5X03NXkk7whCXmgbbKsrwJfvRgik13yZBLwwUEKoyCkk8+jjvdLNrzKUQh/3Q6es+PxNfUXW7/w7b9GN2Llcg01CuLeO3Ivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiGw3jWk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiGw3jWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AF9C4CED0;
	Thu, 12 Dec 2024 18:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028936;
	bh=uu3fvbyDisEB5DAy3KLp/ZLuYwUsfAY7GhAaSJ6sfRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HiGw3jWko8LMxeYVm1lblhLf7HFpdS4AP5ql5PQtJaEBnzwj0lV6DOxCk522+FViN
	 wO3uDYJfJOWoxfOwnpeKFw8UkF7X34MIZPrPJ25ydXfl8qM0QbK1svS0n1QSri/Qou
	 DAKmWcUjlSNWWCcT2uGBbOjhpZvQWRLBssuCLqb7urmnPYYCDFZvKQR0p7TXPruKbn
	 /nt50NRjVTcway0aQDuyxs9Sgmr4GNZVZOa/m+Q3hdedD/CrfriQ1bq8DpwdQcXmRm
	 PyJxwms3i+COuskj1q0pR4HnuakhronwjA24MEA909BP6WSO2azMTTMAlv7GNK1Icv
	 umj2/SGCzh8SQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BFB07CE0EE3; Thu, 12 Dec 2024 10:42:15 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/2] rcu/nocb: Use switch/case on NOCB timer state machine
Date: Thu, 12 Dec 2024 10:42:13 -0800
Message-Id: <20241212184214.2018411-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c0daba35-f647-40cd-b556-3a04e03da93c@paulmck-laptop>
References: <c0daba35-f647-40cd-b556-3a04e03da93c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

It's more convenient to benefit from the fallthrough feature of
switch / case to handle the timer state machine. Also a new state is
about to be added that will take advantage of it.

No intended functional change.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 2605dd234a13c..0923d60c5a338 100644
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
2.40.1

