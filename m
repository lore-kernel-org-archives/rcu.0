Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7A6BFD4;
	Fri, 13 Sep 2024 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263746; cv=none; b=kZ0zFhZshgg87dGtVSg9RkJ+srVOGa0fta//6uwzAboIChv1z09mOa/zVStcJsIq2ad2yCcah820WuaZ/oJd0A5yycaDx8gkOvapBXHcVoS4IiGGuvVRWHveaeWHD8PDqAhTiX4dQP6D+LfYHykP1+ijfvFMsUzq7E8Z14SL2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263746; c=relaxed/simple;
	bh=8ABdp/mvtv583Z/CXv4BFc9AuImk05ra5ARaYYVqd+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5ITh6wDaV0y2hngRxFFtDGrIJIVCmRGip5oD+Lt3MrgT+MobrtNoYZ+lb8cQXYGkaST4Y3taPePk69uWwjIgQd8wgZ27jPGmmHnJfEN64C8ROU/OECcFLVbcJ4KfYUm8C+DitMI0JuxsM01dM1ZK6LDfvGWw6rN4atCe1oOGxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQNxOZth; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQNxOZth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1115AC4CEC0;
	Fri, 13 Sep 2024 21:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726263744;
	bh=8ABdp/mvtv583Z/CXv4BFc9AuImk05ra5ARaYYVqd+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQNxOZth1QE2HpMgR2WG0aU1j0YstxIY48N6MQX4zthG6BQ+u0AZqnxq1cU7Fx3QI
	 ABPD0l9GUmDLbb5FuB90ZnI2len47zo0GWmo8tJwNuXHymA8xqeb038a2AlhtFGkps
	 rnmd3XyJtU/ige1Q0HI+akYaEx9O4AjZPwRh3sSkPwWmIs+EVctSVN010aHIefDSeP
	 qmvJ0zlZmPkm/+XhvROc5EaadgTtUa34CryIexjy9GuJciO6FxbSYRnQF0xsbYrjnU
	 Q6G1C9JG+y1HVHrcft1uH7FTAXTyxnZj0aN27uE7vdWW2Mnw0oSTjbOk5zi8Hmhsfa
	 tiRXQx5WG9OwA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Cheng-Jui Wang <Cheng-Jui.Wang@mediatek.com>
Subject: [PATCH 2/3] rcu/nocb: Conditionally wake up rcuo if not already waiting on GP
Date: Fri, 13 Sep 2024 23:42:04 +0200
Message-ID: <20240913214205.12359-3-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913214205.12359-1-frederic@kernel.org>
References: <20240913214205.12359-1-frederic@kernel.org>
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

