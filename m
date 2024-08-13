Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA21AB53F;
	Tue, 13 Aug 2024 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589813; cv=none; b=UqUAH0Z4ugsN/ihtagUIKRsyTvlfcwyv1TAF8FZ53Uce3ajwB5+qkJnklzxSI9Mc2H46xrv5TMdfOM4e+ljouF+MQ8TaI9q+jV9u6JhbQh9BXx4G+WE0LjBwfqR+WEX0/XB//qmQLsXmmMrodIjISdbjEZsntMeaO/dJCXcNeoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589813; c=relaxed/simple;
	bh=//d0b/5lpY1r0BFbIu3UeB0f6ghuzBF9x7spSDqN2Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dACImnW3EgXb2ruqvgV6gd6FgDfSgSdd2l8YE/yWrC+pgjRVbkH/KiqZjyXcM4Rab9PY5wJRBkzjqXZg+JxMe/vve445h/vcdvAmVxhTMdkV4y3Mwe1FgjQycC4HVwTZdskJTLEQy7z9IWT8VEF7B7emut0jL2KOFll3lH3gBb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t38riVsV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t38riVsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E22C4AF0C;
	Tue, 13 Aug 2024 22:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723589812;
	bh=//d0b/5lpY1r0BFbIu3UeB0f6ghuzBF9x7spSDqN2Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t38riVsVoQ8on9Lq4p6oNRQaebHhd09yeD0TiWuI/SbodviCFmjB3im3K8JE+2a8A
	 ktD+VJ5MvoZoRIqphDrjyCVb9jl8PojO+2XREVXAhg/36bq9VexDpiGel6GpNpRK3Q
	 BNgJfF63qTcAr4i5xhr5ZusW6N9qDR/e3VIb8xbbKkRBOCARZDHSY71GJwOhS36rNE
	 9f/uUnHaGza0j2/tugMCLxd+0A9vINRCwwwSqwZrw9J061N0+Iou0ocICUXrMbaYgJ
	 TDJvbmeMHw1RH/dkO8Ef/Y3943jpduKwjjVpo4DqeLb7T5L/MHWAQ6sn8fB1cv7MHq
	 yoCjTLPduVNeA==
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
Subject: [PATCH 1/3] rcu/nocb: Fix RT throttling hrtimer armed from offline CPU
Date: Wed, 14 Aug 2024 00:56:40 +0200
Message-ID: <20240813225642.12604-2-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813225642.12604-1-frederic@kernel.org>
References: <20240813225642.12604-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After a CPU is marked offline and until it reaches its final trip to
idle, rcuo has several opportunities to be woken up, either because
a callback has been queued in the meantime or because
rcutree_report_cpu_dead() has issued the final deferred NOCB wake up.

If RCU-boosting is enabled, RCU kthreads are set to SCHED_FIFO policy.
And if RT-bandwidth is enabled, the related hrtimer might be armed.
However this then happens after hrtimers have been migrated at the
CPUHP_AP_HRTIMERS_DYING stage, which is broken as reported by the
following warning:

 Call trace:
  enqueue_hrtimer+0x7c/0xf8
  hrtimer_start_range_ns+0x2b8/0x300
  enqueue_task_rt+0x298/0x3f0
  enqueue_task+0x94/0x188
  ttwu_do_activate+0xb4/0x27c
  try_to_wake_up+0x2d8/0x79c
  wake_up_process+0x18/0x28
  __wake_nocb_gp+0x80/0x1a0
  do_nocb_deferred_wakeup_common+0x3c/0xcc
  rcu_report_dead+0x68/0x1ac
  cpuhp_report_idle_dead+0x48/0x9c
  do_idle+0x288/0x294
  cpu_startup_entry+0x34/0x3c
  secondary_start_kernel+0x138/0x158

Fix this with waking up rcuo using an IPI if necessary. Since the
existing API to deal with this situation only handles swait queue, rcuo
is only woken up from offline CPUs if it's not already waiting on a
grace period. In the worst case some callbacks will just wait for a
grace period to complete before being assigned to a subsequent one.

Reported-by: Cheng-Jui Wang (王正睿) <Cheng-Jui.Wang@mediatek.com>
Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 1e92164116ef..08608fe1792c 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -216,7 +216,10 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 	if (needwake) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DoWake"));
-		wake_up_process(rdp_gp->nocb_gp_kthread);
+		if (cpu_is_offline(raw_smp_processor_id()))
+			swake_up_one_online(&rdp_gp->nocb_gp_wq);
+		else
+			wake_up_process(rdp_gp->nocb_gp_kthread);
 	}
 
 	return needwake;
-- 
2.45.2

