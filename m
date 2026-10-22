Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709745;
	b=r+Yv0K4fi2ClujaggKjbqPEp49OLZiZuax4N0OSUzyTJJlPOKxnvTne8rYrzRGPVOwpa
	 I4iITNp7woH7a5US68UBzBLL02ZU40JrYdA4RfWlOFMJF9JLA7GrOQgeiPJq5mdbzxI/0
	 IV4K60nqYPWRMeqg0fb7/rtVetOzaKxheSgvjZD2JS9pB5k5WiX5HCkMfg58jh/KJCAi5
	 bkNSYf1Mu12kZAAfjg7rQVQqXNAMTG9+8UGpV3Wbr7wcYAjSMOHxqYC0ASWv4pB1yLoy/
	 YfxBUd8vhjl12+uUqumQ69YkvvI10ZhqYOmy+ZyCyG8UsNJOKMPKgOq8veqEoRPR1rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709745;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=7FUVVXhItu/QW94FR4cnzHPqgu3y5aD4CdMVsL3eGWU=;
	b=Zs/hnqmRKFIMTMogwYdK7CqEXqLVedHrWXeL/THExWGd/hZcAMMUiGMffMbAP6EorCtq
	 qBL2iQBJNRRkCWTWg62h71Kl+x3uFjdHCv7XndM/6DgDDCnNuh+P0Vg2DuXSNsAnOo4RJ
	 1gUkbc/tH/DZ++x9do+CIU0QWw4ux5TQ9bBVPWYnh44XiaptukY75vQTvPRUq2jV1uxUj
	 vnrzhNRhLUlA2auZcEOafWk4epI5tBdUaWM1EZTmriDx4pO6Tl7LTbYB2plGdIPSfEVbq
	 HwWvVgRzLAGdB8AMC/xQPfoI/eLEw1g3xewo/gjEyOohm4WbnY7nXinhOFFNyuwB/Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X/Y1+neF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33537606A319;
	Thu, 22 Oct 2026 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X/Y1+neF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C85C1F01825;
	Thu, 22 Oct 2026 22:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792709745;
	bh=7FUVVXhItu/QW94FR4cnzHPqgu3y5aD4CdMVsL3eGWU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=X/Y1+neFVM+Dp3tJVNYGZKfARRzJR+SUavtjtZT3Q+pN5eJYcW+42UVnGNpXNTCDU
	 KUcv42dzJmAKvG59jPHDn3IhTpY6HNjLzJ7ekVFZgLcgkCdD6Cv8UlBoTBeAbsmqeD
	 knBkr1Ul1a4fdU8IcEbvyTvH5O3Wm2to+rzUo4djhAjPQgP54i0ir2I9xy+/Y95DNh
	 JvrhN+74yUzTLViHpchCLszqZ/edszeOgb2nIuW/uHdLOa4QAZJL0OvGVZYIx1WTog
	 dyi6uR4pfJKW8oIGvzJ7addTC0QOqEpRAmogffQ5Wm4NA11sjmToYCT6OG+NZH21PB
	 YPxmWMtv+Z6zQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BB524CE0A7E; Thu, 22 Oct 2026 15:55:44 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:55:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC -rcu/dev] hazptrtorture: Release all deferred hazard
 pointers before stopping
Message-ID: <579683e2-ee2a-46e8-8bf3-f7ecc5547581@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261019162005.12888-1-parri.andrea@gmail.com>
 <3e7abe29-df1f-4cb6-884f-dd0a70c5311f@paulmck-laptop>
 <20261021090652.20333-1-parri.andrea@gmail.com>
 <45a6159e-1bcd-45d4-af25-baddf729ac54@paulmck-laptop>
 <20261022125556.3559773-1-parri.andrea@gmail.com>
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
In-Reply-To: <20261022125556.3559773-1-parri.andrea@gmail.com>

On Thu, Oct 22, 2026 at 02:55:55PM +0200, Andrea Parri wrote:
> On Wed, Oct 21, 2026 at 09:50:11AM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 21, 2026 at 11:06:51AM +0200, Andrea Parri wrote:
> 
> [...]
> 
> > >   - If kthread_stop() has already happened, i.e., it comes between
> > >     the kthread_should_stop() check and set_current_state(), the
> > >     wakeup is lost, but KTHREAD_SHOULD_STOP stays set: do_pending
> > >     sleeps for one full period and the loop then exits.  That is
> > >     kthread_do_pending_ms plus up to 1ms of fuzz, so 3-4ms by
> > >     default.
> >
> > Very good.  Except that if someone sets a very long sleep time, that
> > could result in excessive delay for kthread exit, right?  Or am I missing
> > a turn in there somewhere?
> 
> You are not missing anything: in that case, do_pending sleeps for one
> full kthread_do_pending_ms period, however long it is.

Then let's please keep the torture_must_stop() check.  Yes, there is
still a window between the return from torture_must_stop() and the
call to torture_hrtimeout_ms(), but maybe that is something to take
care of later on.

> > > For comparison, without this patch do_pending leaves its loop at
> > > torture_must_stop() and waits in torture_kthread_stopping(), which
> > > sleeps in TASK_UNINTERRUPTIBLE for HZ/20 at a time, so it has the
> > > same lost-wakeup window with a 50ms bound instead.
> >
> > But that is a fixed wait, without the possibility of a user extending
> > it, correct?
> 
> Correct, torture_kthread_stopping() always sleeps for HZ/20 at a time.
> 
> [...]
> 
> > Should we stop the writer before stopping the readers?  Or would that
> > open up some other issue?
> 
> hazptr_torture_cleanup() already stops the writer before the readers,
> and that order is what lets the writer wait on hazard pointers that
> readers defer while it is being stopped.

OK, that is the other issue that would be opened up.  ;-)

>                                           If you mean the other way
> around, stopping the readers first, I believe that works:
> 
>   - Stop the readers, then do_pending, then the writer.
> 
>   - Keep the do_pending loop as it is in -rcu/dev, including the
>     torture_must_stop() check before the sleep, and move this patch's
>     final all-CPU pass after torture_kthread_stopping(), so that it
>     runs once the readers have stopped.
> 
> The writer can then still wait in ->sync() on a deferred hazard
> pointer, but only until that final pass, and nothing waits on the
> writer.  The readers do not need the writer to stop: they leave their
> loop at torture_must_stop(), after at most one stutter_wait().
> 
> With that order, the long sleep above can still happen, but only if
> do_pending passed its torture_must_stop() check before the test began
> stopping, and had not yet gone to sleep when kthread_stop() came,
> after all the readers had stopped.
> 
> Would you prefer that?  If so, I will rework this patch along those
> lines for v1, and rerun the tests.

Taking a more careful look, and thank you for bearing with me...

Yes, agreed, almost:

o	Keep the hazptr_torture_do_pending() do-while loop as it
	is, but add the for_each_possible_cpu() after loop exit.

o	Stop the readers first, stop hazptr_torture_do_pending()
	to flush out anything left from the readers, then stop
	the writer.

However, for the "almost", note that the "while (!torture_must_stop())"
needs to become "while (!kthread_should_stop())".  If this change is
not made, then hazptr_torture_do_pending() will exit its do-while loop
as soon as hazptr_torture_cleanup() calls torture_cleanup_begin().
This will of course defeat the reordering.

Does that work, or am I still missing something?

Alternatively, you could keep the current do-while condition and place
a loop around your post-do-while code like this:

	while (!kthread_should_stop())
		for_each_possible_cpu(cpu)
			hazptr_torture_do_one_pending(cpu, &rand);

But changing the do-while condition looks cleaner to me.

This code will also need adjustment when something like a call_hazptr()
is added, presumably along with a hazptr_barrier(), but we can worry
about that when it happens.

							Thanx, Paul
