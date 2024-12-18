Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBDC1FAC3D;
	Wed, 18 Dec 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734540629; cv=none; b=bkP6OeWcWw2ifF6lGUqHFLR9/2MabqMVbtL71C9V/dlvbAlNcbWrGaUUX9+Sizspas0EWOS0wvrNwVx8o6TgJE5JJ78Szy3598a2jfkG0K59Fq535pXXHHh/a9tGbLpLjp2o8hJyFLokERNd/UIPABjxNe4nx/TKFUCJ7X+F8qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734540629; c=relaxed/simple;
	bh=Nx04f2UY5wu4GKXvfnaz0KF5DugzuqZshT0buArrIM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRnXn5frrG43JCbR/wgMivUBvtuBjtjAHA62d0dvUeK4HyydPSHpMRosgNjRhDBOsJejoRnApqcBZXJn2zHaQiXx5h1dtT5JiqugYhsBD/bQfwxck6l+UEEujavLBhdCrbRsfqgt5fXnZRwe7NHNEaaM/9up/R0X9Z26dBN6nms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSlzLPR2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSlzLPR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FC5C4CECD;
	Wed, 18 Dec 2024 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734540627;
	bh=Nx04f2UY5wu4GKXvfnaz0KF5DugzuqZshT0buArrIM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSlzLPR2hZ4zEPirL+mOaWKCmCCFkqOHqi6MV2IAX9L3ibW+pCxWGTj61Ui2LoGTF
	 7OO3DHlzVbO233Pf7xVoZjCyKdQru/qgccqq2fodTV94QHdK2/BVwXBA7mHkj8k0WB
	 H+sqSLxU/fe791TOpy297Q/Rdqe2zWpkAAiYvv+Yp+h5yWYl8Vyl39zJMWZCfwTRKR
	 hZqfoAGFipFITwQl8exfYHBTqWFDib5hAUj2zWP2Mmodacv/gx9AyS162Mi8rR/v4R
	 xwBeCBso/AEAopMc8ui5qgMIvHrRGOokRh3Oh08eu7eRnmBHvUpS4ureZEHdqH1nLO
	 D3G5JhP+CN+xQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	vlad.wing@gmail.com,
	rcu@vger.kernel.org,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	neeraj.upadhyay@amd.com,
	urezki@gmail.com,
	qiang.zhang1211@gmail.com,
	Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	paulmck@kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 3/3] Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"
Date: Wed, 18 Dec 2024 17:50:08 +0100
Message-ID: <20241218165008.37820-4-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241218165008.37820-1-frederic@kernel.org>
References: <20241218165008.37820-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f7345ccc62a4b880cf76458db5f320725f28e400.

swake_up_one_online() has been removed because hrtimers can now assign
a proper online target to hrtimers queued from offline CPUs. Therefore
remove the related hackery.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index a43141a1b3a5..a03fc19abde7 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -554,19 +554,13 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
-		} else if (!irqs_disabled_flags(flags) && cpu_online(rdp->cpu)) {
+		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp(rdp, false);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
-			/*
-			 * Don't do the wake-up upfront on fragile paths.
-			 * Also offline CPUs can't call swake_up_one_online() from
-			 * (soft-)IRQs. Rely on the final deferred wake-up from
-			 * rcutree_report_cpu_dead()
-			 */
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
-- 
2.46.0

