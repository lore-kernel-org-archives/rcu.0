Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3171E1F8AE5;
	Wed, 19 Feb 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980507; cv=none; b=RXEAxRZVWdAa9gkg93QJkGsLnxiSgOCayDPG9JahDzs/xAMOV578HwhZt7LrM3w1Z7UgTID48INVvq42gnjZC6d0k/sDniRnFuc+TiK3RdcTZQHlr1lGC8YNaJeb3sCpOAKDvdkpXXrAabBv/xz8skIFTyWA6vV0qZD+vd5q8ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980507; c=relaxed/simple;
	bh=7q/Od81HOGTmVblpP6svDOzuqkZWjDxFL25IFDT+QuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tmzw67TotfUgJFMn56pdBMraBIxUzIZwd/9uhUUgNKur9e2NDJ/idn/llPjG8uqYzsvRpSpXc7+HFSeRRM+PFatViL6W3e0QMB/6DifOXC1NKDoPg3rrX06DGeVRGT3cCe/Al1B3oMnCGRnL/tDDVCH9+9kdh7SyT+7XkEGY6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X804gVej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X804gVej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D79FC4CED1;
	Wed, 19 Feb 2025 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739980505;
	bh=7q/Od81HOGTmVblpP6svDOzuqkZWjDxFL25IFDT+QuA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=X804gVejbT4L+d1fY5FnTcRYOCWDsGHZUWbATkKy34efzsryLRlFJqSapZlOvDqY2
	 5G9Ld2cb2/cThPmrxtscO+I3y5A7Zfif73c5KgR8qa6ViJWR7oBiil1hBzjIkVjpTB
	 2XDYOOI0QOakPJystV9WW1ygDFImxRPkHaWD3/l8ZP1OzXp/OYNRm8Naa2lKEwFlEi
	 AXdSwA/+vcaxspb6eKQwN2NUrR6gyr3VUOcVO+qxb9Sk5124jvH4kHhReMtuhwJyNn
	 8oFsWdsxM3Xl++YRgX7MTTKvmdGpqGd9qdUgb9re0A7fUPrpMaMElgVfRtyJqdCc2Q
	 LShuyE2tzJ5GA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4DD82CE0885; Wed, 19 Feb 2025 07:55:05 -0800 (PST)
Date: Wed, 19 Feb 2025 07:55:05 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 3/3] rcu/exp: Remove needless CPU up quiescent state
 report
Message-ID: <966fe653-7dbf-40b6-8b6e-c9bcf7b34335@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-4-frederic@kernel.org>
 <fe931d3a-bf97-4be5-8420-f1fcb55e6a46@paulmck-laptop>
 <Z68yzBURiIr_7Lmy@pavilion.home>
 <610596cf-9836-473f-bcdc-15c69b7e0cd4@paulmck-laptop>
 <Z7ET8S4HKqSPubQY@pavilion.home>
 <c5ea9684-291f-4952-b834-ed8e39cfdf8f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5ea9684-291f-4952-b834-ed8e39cfdf8f@paulmck-laptop>

On Wed, Feb 19, 2025 at 06:58:36AM -0800, Paul E. McKenney wrote:
> On Sat, Feb 15, 2025 at 11:23:45PM +0100, Frederic Weisbecker wrote:
> > Le Sat, Feb 15, 2025 at 02:38:04AM -0800, Paul E. McKenney a écrit :
> > > On Fri, Feb 14, 2025 at 01:10:52PM +0100, Frederic Weisbecker wrote:
> > > > Le Fri, Feb 14, 2025 at 01:01:56AM -0800, Paul E. McKenney a écrit :
> > > > > On Fri, Feb 14, 2025 at 12:25:59AM +0100, Frederic Weisbecker wrote:
> > > > > > A CPU coming online checks for an ongoing grace period and reports
> > > > > > a quiescent state accordingly if needed. This special treatment that
> > > > > > shortcuts the expedited IPI finds its origin as an optimization purpose
> > > > > > on the following commit:
> > > > > > 
> > > > > > 	338b0f760e84 (rcu: Better hotplug handling for synchronize_sched_expedited()
> > > > > > 
> > > > > > The point is to avoid an IPI while waiting for a CPU to become online
> > > > > > or failing to become offline.
> > > > > > 
> > > > > > However this is pointless and even error prone for several reasons:
> > > > > > 
> > > > > > * If the CPU has been seen offline in the first round scanning offline
> > > > > >   and idle CPUs, no IPI is even tried and the quiescent state is
> > > > > >   reported on behalf of the CPU.
> > > > > > 
> > > > > > * This means that if the IPI fails, the CPU just became offline. So
> > > > > >   it's unlikely to become online right away, unless the cpu hotplug
> > > > > >   operation failed and rolled back, which is a rare event that can
> > > > > >   wait a jiffy for a new IPI to be issued.
> > > 
> > > But the expedited grace period might be preempted for an arbitrarily
> > > long period, especially if a hypervisor is in play.  And we do drop
> > > that lock midway through...
> > 
> > Well, then that delays the expedited grace period as a whole anyway...
> 
> Fair enough.  Part of this is the paranoia that has served me so well.
> But which can also cause the occasional problem.  On the other hand,
> we really do occasionally lose things during CPU hotplug operations...
> 
> > > > > > For all those reasons, remove this optimization that doesn't look worthy
> > > > > > to keep around.
> > > > > 
> > > > > Thank you for digging into this!
> > > > > 
> > > > > When I ran tests that removed the call to sync_sched_exp_online_cleanup()
> > > > > a few months ago, I got grace-period hangs [1].  Has something changed
> > > > > to make this safe?
> > > > 
> > > > Hmm, but was it before or after "rcu: Fix get_state_synchronize_rcu_full()
> > > > GP-start detection" ?
> > > 
> > > Before.  There was also some buggy debug code in play.  Also, to get the
> > > failure, it was necessary to make TREE03 disable preemption, as stock
> > > TREE03 has an empty sync_sched_exp_online_cleanup() function.
> > > 
> > > I am rerunning the test with a WARN_ON_ONCE() after the early exit from
> > > the sync_sched_exp_online_cleanup().  Of course, lack of a failure does
> > > not necessairly indicate
> > 
> > Cool, thanks!
> 
> No failures.  But might it be wise to put this WARN_ON_ONCE() in,
> let things go for a year or two, and complete the removal if it never
> triggers?  Or is the lack of forward progress warning enough?
> 
> > > > And if after do we know why?
> > > 
> > > Here are some (possibly bogus) possibilities that came to mind:
> > > 
> > > 1.	There is some coming-online race that deprives the incoming
> > > 	CPU of an IPI, but nevertheless marks that CPU as blocking the
> > > 	current grace period.
> > 
> > Arguably there is a tiny window between rcutree_report_cpu_starting()
> > and set_cpu_online() that could make ->qsmaskinitnext visible before
> > cpu_online() and therefore delay the IPI a bit. But I don't expect
> > more than a jiffy to fill up the gap. And if that's relevant, note that
> > only !PREEMPT_RCU is then "fixed" by sync_sched_exp_online_cleanup() here.
> 
> Agreed.  And I vaguely recall that there was some difference due to
> preemptible RCU's ability to clean up at the next rcu_read_unlock(),
> though more recently, possibly deferred.
> 
> > > 2.	Some strange scenario involves the CPU going offline for just a
> > > 	little bit, so that the IPI gets wasted on the outgoing due to
> > > 	neither of the "if" conditions in rcu_exp_handler() being true.
> > > 	The outgoing CPU just says "I need a QS", then leaves and
> > > 	comes back.  (The expedited grace period doesn't retry because
> > > 	it believes that it already sent that IPI.)
> > 
> > I don't think this is possible. Once the CPU enters CPUHP_TEARDOWN_CPU with
> > stop_machine, no more IPIs can be issued. The remaining ones are executed
> > at CPUHP_AP_SMPCFD_DYING, still in stop_machine. So this is the last call
> > for rcu_exp_handler() execution. And this last call has to be followed
> > by rcu_note_context_switch() between stop_machine and the final schedule to
> > idle. And that rcu_note_context_switch() must report the rdp exp context
> > switch.
> 
> Makes sense to me.
> 
> > One easy way to assert that is:
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 86935fe00397..40d6090a33f5 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -4347,6 +4347,12 @@ void rcutree_report_cpu_dead(void)
> >  	 * may introduce a new READ-side while it is actually off the QS masks.
> >  	 */
> >  	lockdep_assert_irqs_disabled();
> > +	/*
> > +	 * CPUHP_AP_SMPCFD_DYING was the last call for rcu_exp_handler() execution.
> > +	 * The requested QS must have been reported on the last context switch
> > +	 * from stop machine to idle.
> > +	 */
> > +	WARN_ON_ONCE(rdp->cpu_no_qs.b.exp);
> >  	// Do any dangling deferred wakeups.
> >  	do_nocb_deferred_wakeup(rdp);
> 
> I fired off a 30-minute run of 100*TREE03 with this change also.

And no failures!

							Thanx, Paul

> > > 3.	Your ideas here!  ;-)
> > 
> > :-)
> 
> 							Thanx, Paul
