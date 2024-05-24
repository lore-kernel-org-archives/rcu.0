Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050D12BF38;
	Fri, 24 May 2024 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559528; cv=none; b=pgT5aO6K8/7i5DW/5CHibBwj2iiZBNdPog67fGmRtQZQzD948IuTAETb0OkfZjOGC1XjsRwaUzWZ7ImWseUJ2wZsfMmmbAISJUJaKNwljnst8Qt9Qw8Sz5JeplT5wclE9hFcPcGTuqTKV2A9nLOuwwNKSls+gC9wO/+9tGKRoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559528; c=relaxed/simple;
	bh=lEpDUMndEWxswvmAvM++8Gc2QtrqlIBZpwvAiQ7Z65E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m5IBdjOHq2auq0wWCwEsTrHpYb7TGWMZnlUWbZ6EvLRT/S3pYbF3A8nz4XOce4arZLLBoT/PH3ZoNVhHlGSS4pWn/39cILuTYv0APPs1b5YUf1miAw4OUUda//mfFIrYTRVZOuutnDBnLmjgmRX1Kprs1qjD8IDKyFheIolRtXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdW6F8IB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdW6F8IB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CB7C2BBFC;
	Fri, 24 May 2024 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716559527;
	bh=lEpDUMndEWxswvmAvM++8Gc2QtrqlIBZpwvAiQ7Z65E=;
	h=Date:From:To:Cc:Subject:From;
	b=JdW6F8IB+hgDYDynBhunl/81pomaGV4o1g5U1Nyx0UXvTk897yltvSF0JZK+5j9h3
	 GyOE0gTKFJ/YeffUGVHujVSngeoLHAvuDIv7LMiqfnGRliBrv67lIif0Jji45wady0
	 EG5LWbvzYN12+7v/xnI+6OWMQPqe/vOfytq/hnIJLMUkopOpN17X5PhThfn1c3zdx9
	 ke95NeTj2HqrYxYaGCpMykccpcV7j6uss03m5uyHAGMIPsttqemy/GB50nFfh75Rwd
	 3UI7e2bqYB5LiBWW5VN+Ou8AppaoK1Mj3ifhHjFvRtLk+NRSv08glVmH853ReS1C0M
	 jG8n3PEgeMsTg==
Date: Fri, 24 May 2024 16:05:24 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: [PATCH] rcu: Fix rcu_barrier() VS post CPUHP_TEARDOWN_CPU invocation
Message-ID: <ZlCepOslDQz4cOIM@lothringen>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have found a potential race, but I might have missed something on the
way that makes it actually impossible... Please double check.

Thanks.

---
Subject: [PATCH] rcu: Fix rcu_barrier() VS post CPUHP_TEARDOWN_CPU invocation

When rcu_barrier() calls rcu_rdp_cpu_online() and observes a CPU off
rnp->qsmaskinitnext, it means that all accesses from the offline CPU
preceding the CPUHP_TEARDOWN_CPU are visible to RCU barrier, including
callbacks expiration and counter updates.

However interrupts can still fire after stop_machine() re-enables
interrupts and before rcutree_report_cpu_dead(). The related accesses
happening between CPUHP_TEARDOWN_CPU and rnp->qsmaskinitnext clearing
are _NOT_ guaranteed to be seen by rcu_barrier() without proper
ordering, especially when callbacks are invoked there to the end, making
rcutree_migrate_callback() bypass barrier_lock.

The following theoretical race example can make rcu_barrier() hang:

CPU 0                                               CPU 1
-----                                               -----
//cpu_down()
smpboot_park_threads()
//ksoftirqd is parked now
<IRQ>
rcu_sched_clock_irq()
   invoke_rcu_core()
do_softirq()
   rcu_core()
      rcu_do_batch()
         // callback storm
         // rcu_do_batch() returns
         // before completing all
         // of them
   // do_softirq also returns early because of
   // timeout. It defers to ksoftirqd but
   // it's parked
</IRQ>
stop_machine()
   take_cpu_down()
                                                    rcu_barrier()
                                                        spin_lock(barrier_lock)
                                                        // observes rcu_segcblist_n_cbs(&rdp->cblist) != 0
<IRQ>
do_softirq()
   rcu_core()
      rcu_do_batch()
         //completes all pending callbacks
         //smp_mb() implied _after_ callback number dec
</IRQ>

rcutree_report_cpu_dead()
   rnp->qsmaskinitnext &= ~rdp->grpmask;

rcutree_migrate_callback()
   // no callback, early return without locking
   // barrier_lock
                                                        //observes !rcu_rdp_cpu_online(rdp)
                                                        rcu_barrier_entrain()
                                                           rcu_segcblist_entrain()
                                                              // Observe rcu_segcblist_n_cbs(rsclp) == 0
                                                              // because no barrier between reading
                                                              // rnp->qsmaskinitnext and rsclp->len
                                                              rcu_segcblist_add_len()
                                                                 smp_mb__before_atomic()
                                                                 // will now observe the 0 count and empty
                                                                 // list, but too late, we enqueue regardless
                                                                 WRITE_ONCE(rsclp->len, rsclp->len + v);
                                                        // ignored barrier callback
                                                        // rcu barrier stall...

This could be solved with a read memory barrier, enforcing the message
passing between rnp->qsmaskinitnext and rsclp->len, matching the full
memory barrier after rsclp->len addition in rcu_segcblist_add_len()
performed at the end of rcu_do_batch().

However the rcu_barrier() is complicated enough and probably doesn't
need too many more subtleties. CPU down is a slowpath and the
barrier_lock seldom contended. Solve the issue with unconditionally
locking the barrier_lock on rcutree_migrate_callbacks(). This makes sure
that either rcu_barrier() sees the empty queue or its entrained
callback will be migrated.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 944e55085262..925e006b64f9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4736,11 +4736,15 @@ void rcutree_migrate_callbacks(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	bool needwake;
 
-	if (rcu_rdp_is_offloaded(rdp) ||
-	    rcu_segcblist_empty(&rdp->cblist))
-		return;  /* No callbacks to migrate. */
+	if (rcu_rdp_is_offloaded(rdp))
+		return;
 
 	raw_spin_lock_irqsave(&rcu_state.barrier_lock, flags);
+	if (rcu_segcblist_empty(&rdp->cblist)) {
+		raw_spin_unlock_irqrestore(&rcu_state.barrier_lock, flags);
+		return;  /* No callbacks to migrate. */
+	}
+
 	WARN_ON_ONCE(rcu_rdp_cpu_online(rdp));
 	rcu_barrier_entrain(rdp);
 	my_rdp = this_cpu_ptr(&rcu_data);
-- 
2.34.1

