Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862AE1BF311;
	Thu, 26 Dec 2024 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735255875; cv=none; b=DWoDfOF6uuUHm8BdoAvXEZ5g9JSFQ2qqXOGD5MPQAFCQ44931ZthyROtwa1FgkdN864YHLZAFqO00ueiB+psLt4pqqzXPXmkBfKKrFa7r35TCGfqosVDVSnxHrvNsdXjfOzlrXU0TeG65UiDPQHHh3jeeIBx04ZxM1lM9GLqcrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735255875; c=relaxed/simple;
	bh=Nx04f2UY5wu4GKXvfnaz0KF5DugzuqZshT0buArrIM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aL9iz0JVTHqxIZpudZGe/zesWKMBCZhimIaW4Am5yqFB3dQj7OgzZuz608WF6Kr/e3lfT4UHqGe4Q3PNlxxsYRJEyfzJCoqvOt+a/GN+kS21dXybeO+VG39qNpMWKfJzEUay7WCb1ozcxhMZC7d3pKUfwoZxx8qrlGisZaa2Vg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXLv9WNC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXLv9WNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE3DC4CEDC;
	Thu, 26 Dec 2024 23:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735255874;
	bh=Nx04f2UY5wu4GKXvfnaz0KF5DugzuqZshT0buArrIM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXLv9WNCui9QBLXQ/S9afuLaqGeyX4NEEog6P5si+5fAJMlpCf9QMPUm3u5EfjCnD
	 bN5AxIoICF2zR0tKAPuELSFgkUAa0opxbG2UqtztEV0vU1TlwOteMnmiApdl6SO0EI
	 7tSB+lMs4xeXC1j9cAKBl6VGYTn+x1399/ftGiCF98gq3MMo30xznLxbV4FoznbyPP
	 EwnbCkXbXO9U4WWurLtM1H9QG7yyybfeD4FLhhGA6qBtKq5upwV3ASlHStrDDsY8XR
	 a2PmacdwNSrl19xP+2F5QJadXT97uObU5KuL/98B2CkutasDBa0YuFXwwcR40RUu7y
	 Q1lnAtlK6M7wg==
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
Subject: [PATCH 3/3 v2] Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"
Date: Fri, 27 Dec 2024 00:30:52 +0100
Message-ID: <20241226233052.145450-4-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241226233052.145450-1-frederic@kernel.org>
References: <20241226233052.145450-1-frederic@kernel.org>
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

