Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726902;
	b=dO+2si9fDW5edNOMssQ123Eu4bhKESn208K55EI2zHUIgJIR1cP6ZtxjX0gcK3L7sL3B
	 UAuK7VgwzCePc1oF89Bf9kjyv9d+hWH4UGh97AeAQelQfWGKfLHVVOoYMu10wlzvyfYgL
	 +2J6drCT10+3RGXiuptzOWQi9hTySsZc0QcN6aLYnQJg+3ZxAVvnSXDQ6hmHs5M3rp0lR
	 6tJ90UQX5z5NlNXsY75CP+viT6L6V+eVxTpSO0nPjizrviw3C5dJWRXZrkzIvZ2jKRI+l
	 hYOcJOM7W6T/P4uVTzLem1KddgZdUDu25c4Y+w5XUGwmlXW6aCOo8ryvRBMVg3qMXrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726902;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=AvPtCDS+wgmZZ4Uut5yzp2nAGAYjmT4jNq/nlnchh+c=;
	b=tgMQ4QK5nirkX351M3iap8mSglvvruJXiS8Idp3MBbOOiBQWQIekht9SscY8cOVPSEzE
	 5o9Zo7cwuAU80JB/O4A8LTb0tqwKQqDP2Igc8IfekozQnow71YDhXJD+g+Oj8NuJB0n9z
	 3hFCwReqTzfIaVSKO5whTPi+mnIj97aG2qqIIoc/hObjASgSrh/gGXdn+RdPwfrMpOLxO
	 EZd1eb+PcxsBsFHNVAPFt1Xo6Tzx7BwuOR1EgOb2tS4+IDnNXchJE0z6DoUp3Qtl6nE6T
	 kVzZkqZvb5u4Yt9uQslDysEA6fKMvTn2AORFED6W3TrOG4NT05kbJVh0sO5TjtExPgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5RLl1IO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043AF606A335;
	Tue,  3 Nov 2026 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5RLl1IO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9510D1F00A18;
	Tue,  3 Nov 2026 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793726901;
	bh=AvPtCDS+wgmZZ4Uut5yzp2nAGAYjmT4jNq/nlnchh+c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Q5RLl1IOCeOqF/3QryGc+LTmZ53qvHjrLXbIGCf1IpGaOC/SMbAn0WhUPJ18kK8rY
	 dAB1pa7eXXSANGSD/igvETU18G+E1RRDX2w6xWPyrr8nVeBpDI8BSfelH4vvk1fK4x
	 +WrpTMsqDZt3sHh+pIhdCpzHkvxrN1KZSh6R6/vau3uelWs+bi9veE+MAZITUEO3NR
	 39z5ma2AsQYJbS3ApxraHpkEUacb0Mus5EzlV9RYyxhVX4N7a3hryAfEB7aBJHcjwn
	 gQrKXjhaXITzrhZ0a+dM5V06e3kr/tYVp8C8TpTu6UueGDc5hCZc2crjeIa5mz19UG
	 eX8eWBj/7ecFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 53C8ACE0C97; Tue,  3 Nov 2026 09:28:21 -0800 (PST)
Date: Tue, 3 Nov 2026 09:28:21 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Gary Guo <gary@garyguo.net>,
	Kunwu Chan <kunwu.chan@gmail.com>, rcu@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu/dev 1/4] hazptrtorture: Release all deferred hazard
 pointers before stopping
Message-ID: <50169ee7-032e-4da7-95fc-0594f98ab92f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261027163811.2470569-1-parri.andrea@gmail.com>
 <20261027163811.2470569-2-parri.andrea@gmail.com>
 <eb59edbb-c6e8-49c6-a426-c55cdb792853@paulmck-laptop>
 <9da03ed6-fea2-44df-8aee-f7a61a1d35ce@paulmck-laptop>
 <178eaa0b-e7bd-455e-ac3c-f1115d731a52@paulmck-laptop>
 <359B417A-8412-45E0-A061-C4A11E606F0E@mainlining.org>
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
In-Reply-To: <359B417A-8412-45E0-A061-C4A11E606F0E@mainlining.org>

On Tue, Nov 03, 2026 at 11:36:42AM +0000, Bradley Morgan wrote:
> On 3 November 2026 04:50:51 GMT, "Paul E. McKenney" <paulmck@kernel.org>
> wrote:
> >On Wed, Oct 28, 2026 at 04:51:12PM -0700, Paul E. McKenney wrote:
> >> On Wed, Oct 28, 2026 at 10:26:18AM -0700, Paul E. McKenney wrote:
> >> > On Tue, Oct 27, 2026 at 05:38:03PM +0100, Andrea Parri wrote:
> >> > > hazptrtorture can hang at shutdown when deferral is enabled, as in
> >the
> >> > > PREEMPT scenario: the writer stays in ->sync() and kthread_stop() on
> >it
> >> > > never returns, until kvm.sh kills QEMU:
> >> > > 
> >> > >     [ 1800.899278] hazptr-torture: Stopping
> >hazptr_torture_do_pending task
> >> > >     [ 1800.899447] hazptr-torture: Stopping hazptr_torture_writer
> >task
> >> > >     [ 1812.713870] hazptr-torture: rtc: 00000000225df70a ver: 12436
> >HTWS_SYNC tfle: 0 rta: 12437 rtaf: 0 rtf: 12427 onoff:
> >48783/48783:48786/48786 3,254:3,280 611671:731494 (HZ=1000) acq:
> >5720353149 rel: 5720210186 acqirq: 571927 relirq: 714778 reldefer: 714139
> >relundefer 714114
> >> > >     [ 1812.713971] hazptr-torture: hazptr_torture_stats is stopping
> >> > > 
> >> > >     Summary: Potential hang (QEMU killed)
> >> > >     !!! PID 1393523 hung at 1980 vs. 1800 seconds
> >> > > 
> >> > > hazptr_torture_cleanup() stops the do_pending kthread first, then
> >the
> >> > > writer, then the readers.  Once torture_must_stop(), do_pending
> >makes
> >> > > one last pass and leaves its loop, but unless stutter_will_wait(),
> >that
> >> > > pass releases the deferred hazard pointers of a single CPU.
> >> > > 
> >> > > Readers can also still defer after that pass, from the iteration
> >they
> >> > > are in when torture_must_stop() becomes true.  Readers that have
> >left
> >> > > their loop hold no hazard pointer, so the writer waits on one of the
> >25
> >> > > deferred hazard pointers above (reldefer - relundefer) that nothing
> >> > > releases.
> >> > > 
> >> > > Stop the readers before do_pending, and do_pending before the
> >writer.
> >> > > do_pending still leaves its loop at torture_must_stop(), and now
> >> > > releases the deferred hazard pointers of all CPUs once
> >> > > torture_kthread_stopping() returns, that is, once
> >> > > hazptr_torture_cleanup() stops it, after the readers.  The writer
> >can
> >> > > still wait in ->sync(), but only until then.
> >> > > 
> >> > > This should be safe because readers defer only from their own loop,
> >> > > which they have left once torture_stop_kthread() returns for them,
> >and
> >> > > the hazptr_torture_acquire() IPI runs synchronously within that
> >loop.
> >> > > The readers do not need the writer to stop: they leave their loop at
> >> > > torture_must_stop(), after at most one stutter_wait().
> >> > > 
> >> > > do_pending keeps the torture_must_stop() check before its sleep.  A
> >> > > kthread_stop() that comes after that check and before the sleep
> >starts
> >> > > still delays do_pending's exit by a full kthread_do_pending_ms
> >sleep,
> >> > > however long that is.  With the readers stopped first, this happens
> >> > > only if do_pending passed the check before the test began stopping
> >and
> >> > > had not yet gone to sleep when kthread_stop() came, after all the
> >> > > readers had stopped.
> >> > > 
> >> > > With this change, a 30-minute PREEMPT run on x86_64 with 8 CPUs ends
> >> > > with "End of test: SUCCESS" and with as many hazard pointers
> >released
> >> > > from the pending lists as were deferred (reldefer: 983727 relundefer
> >> > > 983727).
> >> > > 
> >> > > The hang was found with the help of an LLM.
> >> > > 
> >> > > Fixes: f23d7b47ced9 ("hazptrtorture: Add kthread to release deferred
> >hazard pointers")
> >> > > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> >> > 
> >> > Again, thank you!
> >> > 
> >> > Please see the question below.
> >> > 
> >> > 							Thanx, Paul
> >> > 
> >> > > ---
> >> > >  kernel/rcu/hazptrtorture.c | 13 +++++++++++--
> >> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> >> > > 
> >> > > diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
> >> > > index 7c8b5899fb011..c46083a8af093 100644
> >> > > --- a/kernel/rcu/hazptrtorture.c
> >> > > +++ b/kernel/rcu/hazptrtorture.c
> >> > > @@ -560,6 +560,9 @@ static int hazptr_torture_do_pending(void *arg)
> >> > >  		// Omit stutter_wait() because this function needs to do cleanup.
> >> > >  	} while (!torture_must_stop());
> >> > 
> >> > The torture_must_stop() function expands to this condition:
> >> > 
> >> > 	torture_must_stop_irq() || kthread_should_stop()
> >> > 
> >> > The torture_must_stop_irq() function expands to this condition:
> >> > 
> >> > 	READ_ONCE(fullstop) != FULLSTOP_DONTSTOP
> >> > 
> >> > And the fullstop variable is set to FULLSTOP_RMMOD by
> >> > torture_cleanup_begin() (unless it has already been set to
> >> > FULLSTOP_SHUTDOWN).
> >> > 
> >> > And torture_cleanup_begin() is invoked by hazptr_torture_cleanup()
> >> > right at the beginning, before reaching any of the calls to
> >> > torture_stop_kthread().
> >> > 
> >> > So doesn't the above torture_must_stop() instead need to be
> >> > kthread_should_stop()?
> >> > 
> >> > As it is, hazptr_torture_do_pending() will still stop before the
> >> > hazptr_torture_reader() instances do, correct?
> >> > 
> >> > Or am I missing something subtle here?
> >> 
> >> Well, one thing that I am missing is that changing from
> >> torture_must_stop() to kthread_should_stop() might cause trouble
> >> if rcutorture execution is terminated by system shutdown.
> >> 
> >> So my next suggestion is that this be added just after
> >> hazptr_torture_reader() exits its do-while loop:
> >> 
> >> 	for_each_possible_cpu(cpu)
> >> 		hazptr_torture_do_one_pending(cpu, &rand);
> >> 
> >> Thoughts?
> >
> >How about like this?
> >
> >						Thanx, Paul
> >
> >------------------------------------------------------------------------
> >
> >commit 863f3c68c5dce601456368a9152de0239421cef9
> >Author: Andrea Parri <parri.andrea@gmail.com>
> >Date:   Tue Oct 27 17:38:03 2026 +0100
> >
> >    hazptrtorture: Release all deferred hazard pointers before stopping
> >    
> >    hazptrtorture can hang at shutdown when deferral is enabled, as in the
> >    PREEMPT scenario: the writer stays in ->sync() and kthread_stop() on it
> >    never returns, until kvm.sh kills QEMU:
> >    
> >        [ 1800.899278] hazptr-torture: Stopping hazptr_torture_do_pending task
> >        [ 1800.899447] hazptr-torture: Stopping hazptr_torture_writer task
> >        [ 1812.713870] hazptr-torture: rtc: 00000000225df70a ver: 12436 HTWS_SYNC tfle: 0 rta: 12437 rtaf: 0 rtf: 12427 onoff: 48783/48783:48786/48786 3,254:3,280 611671:731494 (HZ=1000) acq: 5720353149 rel: 5720210186 acqirq: 571927 relirq: 714778 reldefer: 714139 relundefer 714114
> >        [ 1812.713971] hazptr-torture: hazptr_torture_stats is stopping
> >    
> >        Summary: Potential hang (QEMU killed)
> >        !!! PID 1393523 hung at 1980 vs. 1800 seconds
> >    
> >    hazptr_torture_cleanup() stops the kthreads in random order, which
> >    means that there could be a reader thread still running after
> >    the do_pending kthread does its last cleanup pass.  If the writer
> >    is still running at that point, any remaining deferred hazard
> >    pointers will never be cleaned up and the writer can wait forever
> >    if it is unlucky enough to be waiting on one of the deferred
> >    hazard poiners.
> >    
> >    Therefore, make each reader clean up all deferred hazard pointers,
> >    which means that after the last reader finishes, there can no
> >    longer be any deferred hazard pointers, which means that the
> >    writer can terminate promptly.
> >    
> >    With this change, a 30-minute PREEMPT run on x86_64 with 8 CPUs ends
> >    with "End of test: SUCCESS" and with as many hazard pointers released
> >    from the pending lists as were deferred (reldefer: 983727 relundefer
> >    983727).
> >    
> >    The hang was found with the help of an LLM.
> >    
> >    [ paulmck: Make readers release deferred hazard pointers. ]
> >    
> >    Fixes: f23d7b47ced9 ("hazptrtorture: Add kthread to release deferred hazard pointers")
> >    Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> >    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> >diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
> >index 7c8b5899fb011..3059ccb01979d 100644
> >--- a/kernel/rcu/hazptrtorture.c
> >+++ b/kernel/rcu/hazptrtorture.c
> >@@ -449,6 +449,28 @@ static void hazptr_torture_defer(struct hazptr_pending *hppp, struct torture_ran
> > 	atomic_long_inc(per_cpu_ptr(&hazptr_torture_releases_defer, raw_smp_processor_id()));
> > }
> > 
> >+/*
> >+ * Release the specified CPU's set of deferred/pending hazard pointers.
> >+ */
> >+static void hazptr_torture_do_one_pending(int cpu, struct torture_random_state *trsp)
> >+{
> >+	struct hazptr_pending *hppp;
> >+	struct hazptr_pending *hppp1;
> >+	struct llist_head *llhp;
> >+	struct llist_node *llnp;
> >+
> >+	llhp = per_cpu_ptr(&hazptr_pending, cpu);
> >+	llnp = llist_del_all(llhp);
> >+	if (!llnp)
> >+		return;
> >+	llist_for_each_entry_safe(hppp, hppp1, llnp, hpp_node) {
> >+		hazptr_torture_reader_tail(hppp, trsp);
> >+		atomic_long_inc(per_cpu_ptr(&hazptr_torture_releases_undefer,
> >+					    raw_smp_processor_id()));
> >+		kfree(hppp);
> >+	}
> >+}
> >+
> > /*
> >  * Hazard-pointer torture reader kthread.  Repeatedly dereferences
> >  * hazptr_torture_current, incrementing the corresponding element of the
> >@@ -513,31 +535,13 @@ static int hazptr_torture_reader(void *arg)
> > 		stutter_wait("hazptr_torture_reader");
> > 	} while (!torture_must_stop());
> > 	torture_kthread_stopping("hazptr_torture_reader");
> >+	// Each reader clears all CPUs, so nothing is left after all
> >+	// readers exit their for_each_possible_cpu() loops.
> >+	for_each_possible_cpu(cpu)
> >+		hazptr_torture_do_one_pending(cpu, &rand);
> > 	return 0;
> > }
> > 
> >-/*
> >- * Release the specified CPU's set of deferred/pending hazard pointers.
> >- */
> >-static void hazptr_torture_do_one_pending(int cpu, struct torture_random_state *trsp)
> >-{
> >-	struct hazptr_pending *hppp;
> >-	struct hazptr_pending *hppp1;
> >-	struct llist_head *llhp;
> >-	struct llist_node *llnp;
> >-
> >-	llhp = per_cpu_ptr(&hazptr_pending, cpu);
> >-	llnp = llist_del_all(llhp);
> >-	if (!llnp)
> >-		return;
> >-	llist_for_each_entry_safe(hppp, hppp1, llnp, hpp_node) {
> >-		hazptr_torture_reader_tail(hppp, trsp);
> >-		atomic_long_inc(per_cpu_ptr(&hazptr_torture_releases_undefer,
> >-					    raw_smp_processor_id()));
> >-		kfree(hppp);
> >-	}
> >-}
> >-
> > /*
> >  * Hazard-pointer release of deferred/pending hazard pointers.
> >  */
> >@@ -560,6 +564,7 @@ static int hazptr_torture_do_pending(void *arg)
> > 		// Omit stutter_wait() because this function needs to do cleanup.
> > 	} while (!torture_must_stop());
> > 	torture_kthread_stopping("hazptr_torture_do_pending");
> >+	// Readers clean up after themselves before exit.
> > 	return 0;
> > }
> > 
> >@@ -773,9 +778,7 @@ hazptr_torture_cleanup(void)
> > 		return;
> > 	}
> > 
> >-	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
> > 	torture_stop_kthread(hazptr_torture_preempt, preempt_task);
> >-	torture_stop_kthread(hazptr_torture_writer, writer_task);
> > 
> > 	if (reader_tasks) {
> > 		for (i = 0; i < nrealreaders; i++)
> >@@ -785,6 +788,14 @@ hazptr_torture_cleanup(void)
> > 		reader_tasks = NULL;
> > 	}
> > 
> >+	/*
> >+	 * Stop the writer only after do_pending, and do_pending only after
> >+	 * the readers: the writer may be waiting on hazard pointers that
> >+	 * readers deferred, which do_pending releases once they stopped.
> >+	 */
> >+	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
> >+	torture_stop_kthread(hazptr_torture_writer, writer_task);
> >+
> > 	torture_stop_kthread(hazptr_torture_stats, stats_task);
> > 
> > 	/* Do torture-type-specific cleanup operations.  */
> 
> 
> This looks okay to me.

Glad you like it, but I do need to remove the extraneous changes.

Something for later today.  ;-)

							Thanx, Paul
