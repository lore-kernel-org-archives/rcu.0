Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019281AD7;
	Tue, 22 Oct 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605772; cv=none; b=ekAD9a51UVJGJYBRBkwYHUaOCR5MAkh/v4UBWZMO1i0mvwxta5HJVuF/JjW16+ESubRaB/PALzRjjtLhZS7asS/UZs05aM9gQLhV7FfZtZYMNiDSlSdOYxQ84f5qhE3IQoocZ/FSeAowlCpHH3ZXezVdf+qiP/0WaGY6Ibc5Pyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605772; c=relaxed/simple;
	bh=EjeSgyKTr/lV46QdZQZAGPinH4ooRRKs33jscuCD8/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idO1lfchkakx6rhSWZ/KMkiSc+GJBHzcuivYgF/kH7U3d1MPEZJeT/H4XVnqPAlVXjaM8a4lnOqDf4YU5d+XdAiJ360asgdteipR8T2Y77+LfLBppQISA8psdc1zeSgVuZH9pFgebTZxZufZ1tmpgPky+cN9TnFVEQcIVjnD9SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtTDOS6E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtTDOS6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38775C4CEC3;
	Tue, 22 Oct 2024 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729605771;
	bh=EjeSgyKTr/lV46QdZQZAGPinH4ooRRKs33jscuCD8/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtTDOS6EbY/1gLUY4DJPaL0Sbt2ZCc5xvv07+OcQNKFeIwHQ/MX9vWILjPrRueAjj
	 uRj+i6FdlN3C7Lk0o/8Now6nehNXvRJubNkJPq3x7BVcKz7GtG0FbsOM9PyZ7zukKm
	 85DrmzXzrHx9Qi+WeGbQt0hvLKdYAOfyDm5MWva2YVWLGNVf5wAhzAf1e+3b32CapU
	 t5xkgaFmaZQy3kGd8P1ugQmy4s7VqeKkfXCcOcKlux/1qPZMyAeAUavW48aMVqTFHY
	 5KpLzHOiDYTY/nkr0mGPSO/cy0xTeysfZEDggNZsPJW7vv5zi8BrEJpIEfxoTi0mn+
	 r1Fw+ZxlMA1sw==
Date: Tue, 22 Oct 2024 16:02:48 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu/nocb: Fix the WARN_ON_ONCE() in
 rcu_nocb_rdp_deoffload()
Message-ID: <ZxewiAfsMmufpwbV@localhost.localdomain>
References: <20241022034117.2294-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022034117.2294-1-qiang.zhang1211@gmail.com>

Le Tue, Oct 22, 2024 at 11:41:17AM +0800, Zqiang a écrit :
> Currently, running rcutorture test with torture_type=rcu fwd_progress=8
> n_barrier_cbs=8 nocbs_nthreads=8 nocbs_toggle=100 onoff_interval=60
> test_boost=2, will trigger the following warning:
> 
> WARNING: CPU: 19 PID: 100 at kernel/rcu/tree_nocb.h:1061 rcu_nocb_rdp_deoffload+0x292/0x2a0
> RIP: 0010:rcu_nocb_rdp_deoffload+0x292/0x2a0
> [18839.537322] Call Trace:
> [18839.538006]  <TASK>
> [18839.538596]  ? __warn+0x7e/0x120
> [18839.539491]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
> [18839.540757]  ? report_bug+0x18e/0x1a0
> [18839.541805]  ? handle_bug+0x3d/0x70
> [18839.542837]  ? exc_invalid_op+0x18/0x70
> [18839.543959]  ? asm_exc_invalid_op+0x1a/0x20
> [18839.545165]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
> [18839.546547]  rcu_nocb_cpu_deoffload+0x70/0xa0
> [18839.547814]  rcu_nocb_toggle+0x136/0x1c0
> [18839.548960]  ? __pfx_rcu_nocb_toggle+0x10/0x10
> [18839.550073]  kthread+0xd1/0x100
> [18839.550958]  ? __pfx_kthread+0x10/0x10
> [18839.552008]  ret_from_fork+0x2f/0x50
> [18839.553002]  ? __pfx_kthread+0x10/0x10
> [18839.553968]  ret_from_fork_asm+0x1a/0x30
> [18839.555038]  </TASK>
> 
> CPU0                               CPU2                          CPU3
> //rcu_nocb_toggle             //nocb_cb_wait                   //rcutorture
> 
> // deoffload CPU1             // process CPU1's rdp
> rcu_barrier()
>     rcu_segcblist_entrain()
>         rcu_segcblist_add_len(1);
>         // len == 2
>         // enqueue barrier
>         // callback to CPU1's
>         // rdp->cblist
>                              rcu_do_batch()
>                                  // invoke CPU1's rdp->cblist
>                                  // callback
>                                  rcu_barrier_callback()
>                                                              rcu_barrier()
>                                                                mutex_lock(&rcu_state.barrier_mutex);
>                                                                // still see len == 2
>                                                                // enqueue barrier callback
>                                                                // to CPU1's rdp->cblist
>                                                                rcu_segcblist_entrain()
>                                                                    rcu_segcblist_add_len(1);
>                                                                    // len == 3
>                                  // decrement len
>                                  rcu_segcblist_add_len(-2);
>                              kthread_parkme()
> 
> // CPU1's rdp->cblist len == 1
> // Warn because there is
> // still a pending barrier
> // trigger warning
> WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
> cpus_read_unlock();
> 
>                                                                 // wait CPU1 comes online
>                                                                 // invoke barrier callback on
>                                                                 // CPU1 rdp's->cblist
>                                                                 wait_for_completion(&rcu_state.barrier_completion);
> // deoffload CPU4
> cpus_read_lock()
>   rcu_barrier()
>     mutex_lock(&rcu_state.barrier_mutex);
>     // block on barrier_mutex
>     // wait rcu_barrier() on
>     // CPU3 to unlock barrier_mutex
>     // but CPU3 unlock barrier_mutex
>     // need to wait CPU1 comes online
>     // when CPU1 going online will block on cpus_write_lock
> 
> The above scenario will not only trigger WARN_ON_ONCE(), but also
> trigger deadlock, this commit therefore check rdp->nocb_cb_sleep
> flags before invoke kthread_parkme(), and the kthread_parkme() is
> not invoke until there are no pending callbacks and set 
> rdp->nocb_cb_sleep is true.
> 
> Fixes: 1fcb932c8b5c ("rcu/nocb: Simplify (de-)offloading state machine")
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Applied with the below wordsmithing, thanks a lot!

---
From: Zqiang <qiang.zhang1211@gmail.com>
Date: Tue, 22 Oct 2024 11:41:17 +0800
Subject: [PATCH] rcu/nocb: Fix missed RCU barrier on deoffloading

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

