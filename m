Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F58380FD1;
	Fri, 24 Jul 2026 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902005; cv=none; b=qKIFs8DiLKDoiR0UgMOJGtFoQgpJ83Xx3PvNhrOoX+2El4CtJaHL91LdCCp9xBIqVqS2QjEv7241/sQnOccd4lLrhkR1tX/ku3ILm3/KveiNOCgd7cpyS+oltwywlZhszHxU8gySfG6MT6tsf+ayTEtE3976JV8KaoY+s8Be5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902005; c=relaxed/simple;
	bh=NfIi70k8Nmz57C6mcDFEQDtlRP7cawus6Q13j07KKS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVJJU4vNPikcOcTnAqfCuvTWH1zkAhYZwGn1ecJ0g85SUspR2bTOK13QTXes2IiAh7R7Y/uoWDTJecgxMa764fhu4GIoeunb+TFp+lxpXaxnHngkTTcKdrdpasieojzSE+OlwqeWQL/5F8J08Jd1XfV2f2gD9Mtje+DQm3axdiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPrGT33d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPrGT33d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A081F000E9;
	Fri, 24 Jul 2026 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784902002;
	bh=4Wq+CIgiO6/RNmUJ2Ls/3PcV+zADtxIH+URIcPHTVy8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=TPrGT33dZzTcR7Lc59Utyg1nVH8xo4EDWHjM9/Id1Q3haFRac8SEtb81JlGR7+0jF
	 amDCMICj/tmnRLawVuu3v4CpZXbVZulCVVNkZqg4CR3CxTihbwerZfofX1/QyAVbzx
	 gSUwgCngzlVzoVk4qGEl9olNug8n8XV0sqQfEYgSQIXrU+YZTy3WU7uN9xJorndBRc
	 LrcZ5f7RXEK4NSO5ALKnVrDlRltozlHYWlhgs2QNIIDjOkPp4KMnJvNvdegmF5YZ9n
	 Y//cf5HPiRwHoQvb/y3xP8JcJ/fIQF6F4/aa8WICggHnnJH7KUD1+qBeq08YAk/eT5
	 w2w1GsfTJjajg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7DE76CE08DF; Fri, 24 Jul 2026 07:06:42 -0700 (PDT)
Date: Fri, 24 Jul 2026 07:06:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 00/11] RCU: Enable callbacks to benefit from expedited
 grace periods
Message-ID: <88e5e2e4-8043-4d23-a362-cd864f9d4145@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260624132356.516959-1-puranjay@kernel.org>
 <062ddbcd-dac1-4ee1-9d3f-ef115a667d6a@paulmck-laptop>
 <amNeS_ahHPLqXIGT@localhost.localdomain>
 <CANk7y0hQQ3oDKt+_8oh4t=8NfMRSa80a9jGr+DG+zbrcuUskTA@mail.gmail.com>
 <CANk7y0isSWC0mARzqhn_4OWb+oHkrAt9k_83j_V3eDzKGbsxjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0isSWC0mARzqhn_4OWb+oHkrAt9k_83j_V3eDzKGbsxjA@mail.gmail.com>

On Fri, Jul 24, 2026 at 02:47:22PM +0100, Puranjay Mohan wrote:
> On Fri, Jul 24, 2026 at 1:52 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
> >
> > On Fri, Jul 24, 2026 at 1:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > >
> > > Le Thu, Jul 23, 2026 at 05:31:17PM -0700, Paul E. McKenney a écrit :
> > > > On Wed, Jun 24, 2026 at 06:23:42AM -0700, Puranjay Mohan wrote:
> > > > > This series lets call_rcu() callbacks be reclaimed as soon as either a
> > > > > normal or an expedited grace period that covers them has elapsed, rather
> > > > > than always waiting for a normal grace period.
> > > > >
> > > > > Motivation
> > > > > ==========
> > > > > Today there is an asymmetry: synchronize_rcu_expedited() callers get fast
> > > > > reclaim, but call_rcu() callers never benefit from those same expedited
> > > > > grace periods, even though an expedited GP proves exactly the same thing
> > > > > as a normal one -- all pre-existing readers are done.  When expedited GPs
> > > > > are running on the system (driven by other subsystems), call_rcu()
> > > > > callbacks that could already be freed instead sit in RCU_WAIT_TAIL until
> > > > > the next normal GP.  This series treats a grace period as a grace period
> > > > > regardless of how it was driven, so memory is reclaimed sooner.
> > > > >
> > > > > Design
> > > > > ======
> > > > > Callback segments now record both the normal and expedited grace-period
> > > > > sequence in struct rcu_gp_seq, and rcu_segcblist_advance() releases a
> > > > > segment as soon as poll_state_synchronize_rcu_full() reports that either
> > > > > has completed.  Three notification paths are taught about expedited
> > > > > completion so the advance actually happens: the NOCB rcuog kthreads,
> > > > > the rcu_pending() tick gate, and rcu_core().
> > > > >
> > > > > Changelog:
> > > > > RFC: https://lore.kernel.org/all/20260417231203.785172-1-puranjay@kernel.org/
> > > > > Changes in v1:
> > > > >  - New prep patch 1 renames struct rcu_gp_oldstate to struct rcu_gp_seq
> > > > >    and its fields rgos_norm/rgos_exp to norm/exp tree-wide (Frederic).
> > > > >  - The rcu_segcblist segment field stays named gp_seq; only its type
> > > > >    changes (Frederic).
> > > > >  - Patch 8 (NOCB wake) is reworked.  v1 woke the wrong waitqueue
> > > > >    (rdp_gp->nocb_gp_wq via wake_nocb_gp() rather than the leaf
> > > > >    rnp->nocb_gp_wq[] that an rcuog kthread waiting for a GP sleeps on),
> > > > >    and the wait condition only checked the normal ->gp_seq.  The rcuog
> > > > >    grace-period wait now tracks a struct rcu_gp_seq and is released via
> > > > >    poll_state_synchronize_rcu_full(); rcu_exp_wait_wake() wakes the leaf
> > > > >    node through the new rcu_nocb_exp_cleanup() (Frederic).
> > > > >  - rcu_pending() uses a new memory-ordering-free
> > > > >    poll_state_synchronize_rcu_full_unordered() to avoid memory barriers
> > > > >    on every tick, leaving the ordering duty to rcu_core() (Frederic).
> > > > >
> > > > > Still open: Frederic asked whether the first smp_mb() in
> > > > > poll_state_synchronize_rcu_full() is needed on the callback-advance path
> > > > > (patch 6).  That path still uses the fully ordered helper; only
> > > > > rcu_pending() was switched to the unordered variant.  Happy to revisit.
> > > > >
> > > > > Puranjay Mohan (11):
> > > > >   rcu: Rename struct rcu_gp_oldstate to rcu_gp_seq
> > > > >   rcu/segcblist: Add SRCU and Tasks RCU wrapper functions
> > > > >   rcu/segcblist: Factor out rcu_segcblist_advance_compact() helper
> > > > >   rcu/segcblist: Track segment grace periods with struct rcu_gp_seq
> > > > >   rcu: Add RCU_GET_STATE_NOT_TRACKED for subsystems without expedited
> > > > >     GPs
> > > > >   rcu: Enable RCU callbacks to benefit from expedited grace periods
> > > > >   rcu: Update comments for gp_seq and expedited GP tracking
> > > > >   rcu: Wake NOCB rcuog kthreads on expedited grace period completion
> > > > >   rcu: Detect expedited grace period completion in rcu_pending()
> > > > >   rcu: Advance callbacks for expedited GP completion in rcu_core()
> > > > >   rcuscale: Add concurrent expedited GP threads for callback scaling
> > > > >     tests
> > > >
> > > > I do see the occasional failure when running TREE01, as in a failure or
> > > > four every couple hundred hours of testing.  This is the only rcutorture
> > > > scenario that exercises callback (de)offloading, which might (or might
> > > > not) be a clue.
> > > >
> > > > The console log of a failing run is attached, or you can find it here:
> > > >
> > > > https://drive.google.com/file/d/1EH2P4SDy2a-SJndkN3GbCTGAXxI2xevm/view?usp=sharing
> > > >
> > > > This is a "??? Writer stall state" failure, where rcutorture never learns
> > > > of grace-period completion.  Possibly because no grace period completed.
> > > > But there are no RCU CPU stall warnings.  In addition, these two lines
> > > >
> > > > [  631.032657] ??? Writer stall state RTWS_EXP_SYNC(4) g152813 f0x0 ->state D cpu 1
> > > > . . .
> > > > [ 3610.863114] ??? Writer stall state RTWS_EXP_SYNC(4) g736160 f0x0 ->state D cpu 1
> > > >
> > > > show that the grace-period sequence number advanced from 152813 to
> > > > 736160 in about 50 minutes.  So grace periods really are completing,
> > > > lots of them.
> > > >
> > > > This rcutorture scenario has rcu_nocbs CPUs, and CPU 5 is in trouble:
> > > >
> > > > [  631.066109] rcu:    CB 5^4->4 KblSW F21044 L21044 C116 .W120(148380/168068).N295B101 q516 S CPU 16
> > > > . . .
> > > > [ 3610.869914] rcu:    CB 5^4->4 KblSW F3000848 L3000848 C116 .W120(148380/168068).N295B101 q516 S CPU 16
> > > >
> > > > There are 120 callbacks on the WAIT segment, which are waiting on
> > > > grace-period sequence number 148380, which was long gone even back at
> > > > 631.032657 seconds in (g152813).  There are 295 more callbacks in the NEXT
> > > > segment, which long ago should have been assigned a grace period and moved
> > > > into the currently empty NEXT_READY segment (which is the "." right before
> > > > the "N295").  There are yet another 101 callbacks on the bypass list.
> > > >
> > > > This suggests that the rcuog kthread isn't being awakened when it
> > > > should be.  And that something is failing to advance callbacks out of
> > > > NEXT in a timely fashion.
> > > >
> > > > Thoughts?
> > >
> > > If a grace period has elapsed while in the middle of nocb_gp_wait(),
> > > after the call to rcu_advance_cbs() and before the following polling which
> > > determines if we a grace period must be waited upon, then the kthread
> > > will wait for new callbacks only (and will ignore waiting callbacks that
> > > can now be advanced).
> > >
> > > Does the following help?
> > >
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > index 6da1b8f52476..96d76eb6259d 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -792,22 +792,12 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
> > >                                                            RCU_NEXT_READY_TAIL);
> > >                         raw_spin_unlock_rcu_node(rnp); /* irqs disabled. */
> > >                 }
> > > -               // Need to wait on some grace period?
> > > +
> > >                 WARN_ON_ONCE(wasempty &&
> > >                              !rcu_segcblist_restempty(&rdp->cblist,
> > >                                                       RCU_NEXT_READY_TAIL));
> > > -               /*
> > > -                * Only request a GP wait if the next pending callback's
> > > -                * GP has not already completed (normal or expedited).
> > > -                * If poll_state_synchronize_rcu_full() says it completed,
> > > -                * then rcu_advance_cbs() above already moved those
> > > -                * callbacks to RCU_DONE_TAIL, so there is no GP to wait
> > > -                * for.  Any remaining callbacks got new (future) GP
> > > -                * numbers from rcu_accelerate_cbs() inside
> > > -                * rcu_advance_cbs() and will be handled on the next pass.
> > > -                */
> > > -               if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> > > -                   !poll_state_synchronize_rcu_full(&cur_gp_seq)) {
> > > +               // Need to wait on some grace period?
> > > +               if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
> > >                         /*
> > >                          * Track the earliest pending normal and expedited GP
> > >                          * across the group so the wait below can be released by
> >
> >
> > This looks correct to me, this optimization with
> > !poll_state_synchronize_rcu_full(&cur_gp_seq) opened up this race as
> > you correctly explained.
> 
> My local reproducer says that the problem is gone, but let's see what
> Paul's 100s of hours of testing says.

I will fire it up, and thank you both!!!

And if it passes the 100s of hours (about 600), it will get 1000s of
hours over the weekend.  ;-)

							Thanx, Paul
