Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A0218FDB0;
	Wed,  6 Nov 2024 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907149; cv=none; b=oD4ileObnVpZ27gCFF5ZtGodgk95a/UKroh/HTBrFqmdUH5saW/jEc2EA2anSpUaM1VEFzIcJ1fdil+N861uWEk8ihf4WRON+ER2ChNfMcVY2zRrJqKU+92R3T98T8wS5nQBhGuQmSkAIDkD12xZRRFWOSFCUD8UTg2xHgWPfok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907149; c=relaxed/simple;
	bh=i/urNZasEZGkqJe0WJR/j8fI69WJU8G5mFhs6F2dWfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cj8P9HEZ0fF73MoP4vYCE5PQneszThwLYwpZttgA0sCGpU7k8bB7l3fuYcXrXuHskJFOAW/rPZjRxjuem4DP7e6R2Cl/jojmo6GSezG1CgxDLSY4HZ0BflopWQkzu+XCtHn3WzqUbJLXqJf9Mn8b43cK/hUUZV3b4R8jWrXADt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7F2y3kc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7F2y3kc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03517C4CEC6;
	Wed,  6 Nov 2024 15:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730907146;
	bh=i/urNZasEZGkqJe0WJR/j8fI69WJU8G5mFhs6F2dWfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7F2y3kc3m/u9hVltjxAoVOGYNs366ERYucq97ZsiFc3KWPgH7lDoVDgZmCj4e3dP
	 H4lq9iBS2nnzMutVdWomxjbTwRBE575YEHRo3zraxMsUv4TDxUufd9qbRCHv4cE+is
	 0+Sw34WoLfXOzL3JDHKX0mnrnfFN3WKtx1p/TEe4ER3R7RMU2t7eg/jMJyk1H0wlUu
	 7S3rBo0kqfdMPIr+FD+U9OsOFnEE4p1KORGqSBOW6fCQCPOlU7NYLrge0s06hHuDe7
	 ko5IxXVaNx3F8jYaDE/RG1H3SsONDFun+I8wrPd33xmrKVlq/W4Y9jKOfO4zKPoXuy
	 WOWAylM70Qzbg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zqiang <qiang.zhang1211@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 2/2] rcu/nocb: Fix missed RCU barrier on deoffloading
Date: Wed,  6 Nov 2024 16:32:13 +0100
Message-ID: <20241106153213.38896-3-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106153213.38896-1-frederic@kernel.org>
References: <20241106153213.38896-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang1211@gmail.com>

Currently, running rcutorture test with torture_type=rcu fwd_progress=8
n_barrier_cbs=8 nocbs_nthreads=8 nocbs_toggle=100 onoff_interval=60
test_boost=2, will trigger the following warning:

	WARNING: CPU: 19 PID: 100 at kernel/rcu/tree_nocb.h:1061 rcu_nocb_rdp_deoffload+0x292/0x2a0
	RIP: 0010:rcu_nocb_rdp_deoffload+0x292/0x2a0
	 Call Trace:
	  <TASK>
	  ? __warn+0x7e/0x120
	  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
	  ? report_bug+0x18e/0x1a0
	  ? handle_bug+0x3d/0x70
	  ? exc_invalid_op+0x18/0x70
	  ? asm_exc_invalid_op+0x1a/0x20
	  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
	  rcu_nocb_cpu_deoffload+0x70/0xa0
	  rcu_nocb_toggle+0x136/0x1c0
	  ? __pfx_rcu_nocb_toggle+0x10/0x10
	  kthread+0xd1/0x100
	  ? __pfx_kthread+0x10/0x10
	  ret_from_fork+0x2f/0x50
	  ? __pfx_kthread+0x10/0x10
	  ret_from_fork_asm+0x1a/0x30
	  </TASK>

CPU0                               CPU2                          CPU3
//rcu_nocb_toggle             //nocb_cb_wait                   //rcutorture

// deoffload CPU1             // process CPU1's rdp
rcu_barrier()
    rcu_segcblist_entrain()
        rcu_segcblist_add_len(1);
        // len == 2
        // enqueue barrier
        // callback to CPU1's
        // rdp->cblist
                             rcu_do_batch()
                                 // invoke CPU1's rdp->cblist
                                 // callback
                                 rcu_barrier_callback()
                                                             rcu_barrier()
                                                               mutex_lock(&rcu_state.barrier_mutex);
                                                               // still see len == 2
                                                               // enqueue barrier callback
                                                               // to CPU1's rdp->cblist
                                                               rcu_segcblist_entrain()
                                                                   rcu_segcblist_add_len(1);
                                                                   // len == 3
                                 // decrement len
                                 rcu_segcblist_add_len(-2);
                             kthread_parkme()

// CPU1's rdp->cblist len == 1
// Warn because there is
// still a pending barrier
// trigger warning
WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
cpus_read_unlock();

                                                                // wait CPU1 to comes online and
                                                                // invoke barrier callback on
                                                                // CPU1 rdp's->cblist
                                                                wait_for_completion(&rcu_state.barrier_completion);
// deoffload CPU4
cpus_read_lock()
  rcu_barrier()
    mutex_lock(&rcu_state.barrier_mutex);
    // block on barrier_mutex
    // wait rcu_barrier() on
    // CPU3 to unlock barrier_mutex
    // but CPU3 unlock barrier_mutex
    // need to wait CPU1 comes online
    // when CPU1 going online will block on cpus_write_lock

The above scenario will not only trigger a WARN_ON_ONCE(), but also
trigger a deadlock.

Thanks to nocb locking, a second racing rcu_barrier() on an offline CPU
will either observe the decremented callback counter down to 0 and spare
the callback enqueue, or rcuo will observe the new callback and keep
rdp->nocb_cb_sleep to false.

Therefore check rdp->nocb_cb_sleep before parking to make sure no
further rcu_barrier() is waiting on the rdp.

Fixes: 1fcb932c8b5c ("rcu/nocb: Simplify (de-)offloading state machine")
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 16865475120b..2605dd234a13 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -891,7 +891,18 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
 					    nocb_cb_wait_cond(rdp));
 	if (kthread_should_park()) {
-		kthread_parkme();
+		/*
+		 * kthread_park() must be preceded by an rcu_barrier().
+		 * But yet another rcu_barrier() might have sneaked in between
+		 * the barrier callback execution and the callbacks counter
+		 * decrement.
+		 */
+		if (rdp->nocb_cb_sleep) {
+			rcu_nocb_lock_irqsave(rdp, flags);
+			WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			kthread_parkme();
+		}
 	} else if (READ_ONCE(rdp->nocb_cb_sleep)) {
 		WARN_ON(signal_pending(current));
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
-- 
2.46.0

