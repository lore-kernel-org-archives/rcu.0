Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8281AC426;
	Tue, 13 Aug 2024 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589815; cv=none; b=WF5eIkNcv4Pk+7sCTSMr8Yo84PA/cD+892WDHbBvsIROEWw1bCLNpJk1saSo+bTw4nqZAdolYnZv0tGkYIXQco/SoX/YGxUYeqo9XuGBehGQve9VP7BgTri1d6EKz6G90fskMsUN4BrxL/CNMZ1kD4wN2ZsEoROTmiP1pWFg7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589815; c=relaxed/simple;
	bh=8ABdp/mvtv583Z/CXv4BFc9AuImk05ra5ARaYYVqd+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WG6OsqY2PMQ8soJLgWH3vZ2agpH5GH7dqtLBf1GQ40bR/QVzfoNX/cusHvYL8iFCtAtJiMPoc6scj+/XHSma0hOBXWLO+Y1VnrEMJJJEkcjLLKP5/Yc/jbd7KiFfzhYI78GN6f0A2ypKBY+Z6KL2xgZmjLdttPtdb1Hf/UOLoHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVTmzmlO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVTmzmlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3494DC4AF0F;
	Tue, 13 Aug 2024 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723589815;
	bh=8ABdp/mvtv583Z/CXv4BFc9AuImk05ra5ARaYYVqd+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVTmzmlOPamQjn+e0PVo6ruD3c7helHzunXC29QY7DqLRUc4yB3dPPUB689VsIsai
	 jfyWND1WXGomVSttMtZLUgFGfQbVQ2YGLyjGHY9sjMKVnwJ+uM7UmJwYfyPOlRMhne
	 1ESdZz6Ds312XaFcOSzEt143BgzJ77Yb/rPlFzMW2cF4X18fx4P5W5sOwzBzMEXOCo
	 mtnKI1Mj/gjaOo8dtKCSMVi8ob+YxY8FT8IdvrjtFswSCH6c0tIAHZ5iBZu1177aV8
	 baqoCZoC9Z45otO5hysPf3iXE3U3FbtXHi3jN6BF5bAVutmtPqUImBREUfYFH+pHVs
	 wGoldZldJ323g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Cheng-Jui Wang <Cheng-Jui.Wang@mediatek.com>
Subject: [PATCH 2/3] rcu/nocb: Conditionally wake up rcuo if not already waiting on GP
Date: Wed, 14 Aug 2024 00:56:41 +0200
Message-ID: <20240813225642.12604-3-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813225642.12604-1-frederic@kernel.org>
References: <20240813225642.12604-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A callback enqueuer currently wakes up the rcuo kthread if it is adding
the first non-done callback of a CPU, whether the kthread is waiting on
a grace period or not (unless the CPU is offline).

This looks like a desired behaviour because then the rcuo kthread
doesn't wait for the end of the current grace period to handle the
callback. It is accelerated right away and assigned to the next grace
period. The GP kthread is notified about that fact and iterates with
the upcoming GP without sleeping in-between.

However this best-case scenario is contradicted by a few details,
depending on the situation:

1) If the callback is a non-bypass one queued with IRQs enabled, the
   wake up only occurs if no other pending callbacks are on the list.
   Therefore the theoretical "optimization" actually applies on rare
   occasions.

2) If the callback is a non-bypass one queued with IRQs disabled, the
   situation is similar with even more uncertainty due to the deferred
   wake up.

3) If the callback is lazy, a few jiffies don't make any difference.

4) If the callback is bypass, the wake up timer is programmed 2 jiffies
   ahead by rcuo in case the regular pending queue has been handled
   in the meantime. The rare storm of callbacks can otherwise wait for
   the currently elapsing grace period to be flushed and handled.

For all those reasons, the optimization is only theoretical and
occasional. Therefore it is reasonable that callbacks enqueuers only
wake up the rcuo kthread when it is not already waiting on a grace
period to complete.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 08608fe1792c..0c9eca1cc76e 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -216,10 +216,7 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 	if (needwake) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DoWake"));
-		if (cpu_is_offline(raw_smp_processor_id()))
-			swake_up_one_online(&rdp_gp->nocb_gp_wq);
-		else
-			wake_up_process(rdp_gp->nocb_gp_kthread);
+		swake_up_one_online(&rdp_gp->nocb_gp_wq);
 	}
 
 	return needwake;
-- 
2.45.2

