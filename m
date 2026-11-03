Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738648;
	b=cyRvmoiyHj3cG9nfZblP5/cQkRDo/sIa3yC90XypcrJBeIYlqw2niaXMRkmvC33tqfcG
	 MVfy0+vnU4KxHhKH+hbIbgatCLuLcWPd9LQJ3MxIc/qv0IbFNRkTxtzSmMe8Ng6pMLwjZ
	 LbTSszgyhFTHLvnbLMBuemPtmqpNUpIMDyuBPKQQX4Ul0AIMDRO+tzMqcBLi0EddojUhm
	 YJ+EQUnjy2ubqrTuQ5wsMqIdMxJ3OjeYk04YTRVoZegFGol38H8zc2eJoxZm26cJjZBxl
	 PF6ld3ifMakXwIYEcRtUqL+ZyurVA6kh8mypaco8fDnaWeYFKRmpIdWFh7TN5UMiNoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738648;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=1z1SE8r2zM4cgPSawLT9A4tTj551gDLTUizG53Ns404=;
	b=4bLHFm9fs/EB90Bf5xo5PbkBkLi1kfVhLMP3bgWgeM6kH02iJ3wXB96PyVOyLIQYLPbt
	 J67ULK7HIuZ5VEKWGlo9J3sxwNUSa/rU10x/d5nLRzrI7z8swNGV2k6mKS4NtRmqhJz7H
	 2JcmNnosoNUObsTsMI7D6lTlkRRGUl51r4CruRShzVxi8ZhibJhz6PRJZLASsmc0/mN1U
	 CiNQjsmKgKeAe2KBVWp0r3wHRRlCZ5lJMei3HzDQLZMhsyKsSdmsFIzi7z/B3ByKufUhV
	 vAyt9ypNwzZ9vCpmeo4ntG/Oh95oK6Hclag4A+1poeATEnkEPHFjCc8b+dVOcq1EtJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENDR175+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F43606A31B;
	Tue,  3 Nov 2026 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENDR175+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A781F00919;
	Tue,  3 Nov 2026 20:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793738647;
	bh=1z1SE8r2zM4cgPSawLT9A4tTj551gDLTUizG53Ns404=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ENDR175+IN4KSNwZ/q6G+tBiw8nrmmUwVr2qRKZ3Rt7z8O13bURvxdKJbEPR4fQ1W
	 DAvIHa5afhSJrSTvAqsJPV+8E1+ApDVW8oSkG6C3Kx+4gmbCKd9lfxoy81HYHQ5BAt
	 MIE4UczpSz+mOk7Fzc1PTtlfM6FzCQTINVXesX3GFUoAFPK8epXS8KQ9pG7Luc5a9p
	 N8lcc963fXdXNvy32IKZCGLbTM5PDgWFPNEYp5yDJ2FzfOZt6hM8zYAwFNXwprLQa3
	 o1ptHgi1MXBG1xCb8HVgBo6krnQqINUQbSQhEBGAwQ4+Aq64a3gsleid9iRb7/0hEd
	 jpweyswdI51SQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 909B5CE0C97; Tue,  3 Nov 2026 12:44:07 -0800 (PST)
Date: Tue, 3 Nov 2026 12:44:07 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Gary Guo <gary@garyguo.net>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>, rcu@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu/dev 1/4] hazptrtorture: Release all deferred hazard
 pointers before stopping
Message-ID: <ad753ec5-52ee-4fcf-8275-77095f42e8c9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261027163811.2470569-1-parri.andrea@gmail.com>
 <20261027163811.2470569-2-parri.andrea@gmail.com>
 <eb59edbb-c6e8-49c6-a426-c55cdb792853@paulmck-laptop>
 <9da03ed6-fea2-44df-8aee-f7a61a1d35ce@paulmck-laptop>
 <178eaa0b-e7bd-455e-ac3c-f1115d731a52@paulmck-laptop>
 <20261103190507.1913628-1-parri.andrea@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103190507.1913628-1-parri.andrea@gmail.com>

On Tue, Nov 03, 2026 at 08:05:06PM +0100, Andrea Parri wrote:
> On Mon, Nov 02, 2026 at 08:50:51PM -0800, Paul E. McKenney wrote:
> 
> [...]
> 
> > How about like this?
> 
> Works for me, thanks!  With it and patches 2-4 on top, two 3-minute
> PREEMPT runs with kthread_do_pending_ms=10000, which hung without a fix,
> and a 30-minute PREEMPT run end with "End of test: SUCCESS" and with as
> many hazard pointers released as were deferred.  In one of the
> kthread_do_pending_ms=10000 runs, the writer also stays in ->sync() long
> enough for a writer-stall report 31 seconds after boot, and moves on by
> 46 seconds.
> 
> The variant from my previous reply, with the pass right after the
> reader's loop, passed the same tests, but there is no need for it with
> this version, so I will not send a v2.

Very good, thank you!

> A few small things below.
> 
> [...]
> 
> >     hazptr_torture_cleanup() stops the kthreads in random order, which
> 
> The order is fixed: do_pending, preempt, the writer, then the readers.

That was my first thought, but then I remembered that torture_init_begin()
sets fullstop to FULLSTOP_DONTSTOP, which causes torture_must_stop()
to return true, thus stopping all the hazptrtorture kthread at about
the same time in some random order.

By the time hazptr_torture_cleanup() gets around to invoking
torture_stop_kthread() for the various kthreads, the game is up.

> >     Therefore, make each reader clean up all deferred hazard pointers,
> >     which means that after the last reader finishes, there can no
> >     longer be any deferred hazard pointers, which means that the
> >     writer can terminate promptly.
> 
> With the pass after torture_kthread_stopping(), a reader cleans up only
> once hazptr_torture_cleanup() stops it, so this also relies on stopping
> the readers before the writer.  Maybe worth a sentence here?

Again, the readers are stopped at torture_cleanup_begin() time.
Along with all the other kthreads.

> >     hazard poiners.
> 
> s/poiners/pointers/

Good eyes!  I will fix this on my next rebase.

> >     from the pending lists as were deferred (reldefer: 983727 relundefer
> >     983727).
> 
> These numbers come from v1's patch; with this version, the 30-minute
> PREEMPT run gives reldefer: 657653 relundefer 657653.

Will fix this as well on my next rebase, and again, thank you.

> [...]
> 
> > +	/*
> > +	 * Stop the writer only after do_pending, and do_pending only after
> > +	 * the readers: the writer may be waiting on hazard pointers that
> > +	 * readers deferred, which do_pending releases once they stopped.
> > +	 */
> 
> do_pending no longer releases them; the readers do.  Perhaps:
> 
> 	/*
> 	 * Stop the writer only after the readers: the writer may be
> 	 * waiting on hazard pointers that readers deferred, which each
> 	 * reader releases once it is stopped.
> 	 */

I instead dropped the torture_stop_kthread() reordering from the most
recent version of this patch shown below.  (Which still contains the
above typos, but could you please check it otherwise?)

> Also, "hazptrtorture: Nest a second hazard pointer in readers" conflicts
> with moving hazptr_torture_do_one_pending() up, as both add a function
> after hazptr_torture_defer(); keeping both resolves it.

I believe that I have resolved that correctly, but could you please
check v7.4-rc1..d0a4ec9443ee in my -rcu tree?

							Thanx, Paul

------------------------------------------------------------------------

commit ba9a3e4d3b237a7e2f844bd9595a97876f36a427
Author: Andrea Parri <parri.andrea@gmail.com>
Date:   Tue Oct 27 17:38:03 2026 +0100

    hazptrtorture: Release all deferred hazard pointers before stopping
    
    hazptrtorture can hang at shutdown when deferral is enabled, as in the
    PREEMPT scenario: the writer stays in ->sync() and kthread_stop() on it
    never returns, until kvm.sh kills QEMU:
    
        [ 1800.899278] hazptr-torture: Stopping hazptr_torture_do_pending task
        [ 1800.899447] hazptr-torture: Stopping hazptr_torture_writer task
        [ 1812.713870] hazptr-torture: rtc: 00000000225df70a ver: 12436 HTWS_SYNC tfle: 0 rta: 12437 rtaf: 0 rtf: 12427 onoff: 48783/48783:48786/48786 3,254:3,280 611671:731494 (HZ=1000) acq: 5720353149 rel: 5720210186 acqirq: 571927 relirq: 714778 reldefer: 714139 relundefer 714114
        [ 1812.713971] hazptr-torture: hazptr_torture_stats is stopping
    
        Summary: Potential hang (QEMU killed)
        !!! PID 1393523 hung at 1980 vs. 1800 seconds
    
    hazptr_torture_cleanup() stops the kthreads in random order, which
    means that there could be a reader thread still running after
    the do_pending kthread does its last cleanup pass.  If the writer
    is still running at that point, any remaining deferred hazard
    pointers will never be cleaned up and the writer can wait forever
    if it is unlucky enough to be waiting on one of the deferred
    hazard poiners.
    
    Therefore, make each reader clean up all deferred hazard pointers,
    which means that after the last reader finishes, there can no
    longer be any deferred hazard pointers, which means that the
    writer can terminate promptly.
    
    With this change, a 30-minute PREEMPT run on x86_64 with 8 CPUs ends
    with "End of test: SUCCESS" and with as many hazard pointers released
    from the pending lists as were deferred (reldefer: 983727 relundefer
    983727).
    
    The hang was found with the help of an LLM.
    
    [ paulmck: Make readers release deferred hazard pointers. ]
    
    Fixes: f23d7b47ced9 ("hazptrtorture: Add kthread to release deferred hazard pointers")
    Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 7c8b5899fb011..23c2bf229014d 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -449,6 +449,28 @@ static void hazptr_torture_defer(struct hazptr_pending *hppp, struct torture_ran
 	atomic_long_inc(per_cpu_ptr(&hazptr_torture_releases_defer, raw_smp_processor_id()));
 }
 
+/*
+ * Release the specified CPU's set of deferred/pending hazard pointers.
+ */
+static void hazptr_torture_do_one_pending(int cpu, struct torture_random_state *trsp)
+{
+	struct hazptr_pending *hppp;
+	struct hazptr_pending *hppp1;
+	struct llist_head *llhp;
+	struct llist_node *llnp;
+
+	llhp = per_cpu_ptr(&hazptr_pending, cpu);
+	llnp = llist_del_all(llhp);
+	if (!llnp)
+		return;
+	llist_for_each_entry_safe(hppp, hppp1, llnp, hpp_node) {
+		hazptr_torture_reader_tail(hppp, trsp);
+		atomic_long_inc(per_cpu_ptr(&hazptr_torture_releases_undefer,
+					    raw_smp_processor_id()));
+		kfree(hppp);
+	}
+}
+
 /*
  * Hazard-pointer torture reader kthread.  Repeatedly dereferences
  * hazptr_torture_current, incrementing the corresponding element of the
@@ -513,31 +535,13 @@ static int hazptr_torture_reader(void *arg)
 		stutter_wait("hazptr_torture_reader");
 	} while (!torture_must_stop());
 	torture_kthread_stopping("hazptr_torture_reader");
+	// Each reader clears all CPUs, so nothing is left after all
+	// readers exit their for_each_possible_cpu() loops.
+	for_each_possible_cpu(cpu)
+		hazptr_torture_do_one_pending(cpu, &rand);
 	return 0;
 }
 
-/*
- * Release the specified CPU's set of deferred/pending hazard pointers.
- */
-static void hazptr_torture_do_one_pending(int cpu, struct torture_random_state *trsp)
-{
-	struct hazptr_pending *hppp;
-	struct hazptr_pending *hppp1;
-	struct llist_head *llhp;
-	struct llist_node *llnp;
-
-	llhp = per_cpu_ptr(&hazptr_pending, cpu);
-	llnp = llist_del_all(llhp);
-	if (!llnp)
-		return;
-	llist_for_each_entry_safe(hppp, hppp1, llnp, hpp_node) {
-		hazptr_torture_reader_tail(hppp, trsp);
-		atomic_long_inc(per_cpu_ptr(&hazptr_torture_releases_undefer,
-					    raw_smp_processor_id()));
-		kfree(hppp);
-	}
-}
-
 /*
  * Hazard-pointer release of deferred/pending hazard pointers.
  */
@@ -560,6 +564,7 @@ static int hazptr_torture_do_pending(void *arg)
 		// Omit stutter_wait() because this function needs to do cleanup.
 	} while (!torture_must_stop());
 	torture_kthread_stopping("hazptr_torture_do_pending");
+	// Readers clean up after themselves before exit.
 	return 0;
 }
 
