Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601413;
	b=ccmFw5pxJaAP6laKWK3KM1Ew6c0Y1mhGwgplYdqGganW+IMYuvOprktw8nDIu1dY0R/a
	 rGPRNwuk7gWhOy2PuIvE537a6OwuS7ydvhq0AtXky0Omb6mz5HObYUyCmqnZ8Yv48tOB7
	 I3MTvHeKGEPZAAzZUNCgLuTkTwPBPdy8iqx64mllSTrTRUtf/O7k+1qejr+AqAxo0Iynm
	 T5FW/MbTFHFnNzPi9bqrPb7aUJ09859QkDyP9BUL5A90VLdIXJJVrK86olW1mTCiJ4oF/
	 XdB9NGMOP3G1OIGetvGTBPuYrZ7lHpdBk1yyM8mCOYhjTa5raXmt93kp54T3DbfQvew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601413;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=b0Kaswa/lxkfrNm0Z6sl/FGZoMaBiL1u4HmXTr8IWBk=;
	b=miWeCUU5HFcmUfXVBIlu96ynLCBUhFJ8dps1AYxhilpm55Z85fIG+u8RXo9plH/O/Jm/
	 rEUMsP+/Ganv4uk7cNssuVSLJ83Y2KSLyAcf1UGkXAF1Iz0Ab8MsVhU7ky2cMYp0RmiPT
	 QyjtTo7EUBjVkWq7qM2z2SFyTn9zSVcSFs2RqIYMB7LP9lnEhWyoIg5rYlNmJUAFkq6Mb
	 AV9gmLxnp3YoNoSQAey8T7T0r2dVWBcd3apdFRdiToMBS3sobfA5ROa0MfwoRvCFtilMk
	 T6S8kBV9zt83cECeC64ql8dNQ3bCx0DT4Ln0xileFJGAQ7Z3Rx+M8eLTaSXiSn/jAAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P/lELwZM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2E606A324;
	Wed, 21 Oct 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/lELwZM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2611F000C4;
	Wed, 21 Oct 2026 16:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792601412;
	bh=b0Kaswa/lxkfrNm0Z6sl/FGZoMaBiL1u4HmXTr8IWBk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=P/lELwZM6u8bGIq4JSkLCLc8r0WDgljl0UYXerAPsvZmjf6wswLt7miLGJnAI0NXU
	 I/ultCOPihzv6GoFH1DYxIMZQha2+1XNAYlYyYn35L7NengmFtgdcNO884Tr3L7Nqo
	 NHy0Pp7jjScXFpkoR0HT9Wi4Z7KlAu5dOr6DEKmwwu/9Bsxno+Nebf/1pNC+Sd2IGw
	 amX4kK1Vg3TTQyCO1gx8gZOJhud+HOT+rbwCK1ufXmUUs7tgFjpMcLv0bJ6mxFkEGl
	 CJ4B1MKaj7IZhgC/mMTsJZwwHcE48ptLRp3C/CrfEFL/0dRvb55yHthCg5DIfjpLQw
	 9JonNl41W8L2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F3541CE0836; Wed, 21 Oct 2026 09:50:11 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:50:11 -0700
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
Message-ID: <45a6159e-1bcd-45d4-af25-baddf729ac54@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261019162005.12888-1-parri.andrea@gmail.com>
 <3e7abe29-df1f-4cb6-884f-dd0a70c5311f@paulmck-laptop>
 <20261021090652.20333-1-parri.andrea@gmail.com>
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
In-Reply-To: <20261021090652.20333-1-parri.andrea@gmail.com>

On Wed, Oct 21, 2026 at 11:06:51AM +0200, Andrea Parri wrote:
> On Tue, Oct 20, 2026 at 11:49:08AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 19, 2026 at 06:20:03PM +0200, Andrea Parri wrote:
> 
> [...]
> 
> > > -		if (!torture_must_stop())
> > > -			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
> > > +		torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
> >
> > Is the theory here that a kthread_stop() will wake up this sleep anyway?
> > And if so, would that work if the kthread_stop() already happened?
> >
> > (I do recall adding the torture_must_stop() checks due to delays at
> > kthread_stop() time, but perhaps things have changed since then.)
> 
> Yes, that is the theory.  torture_hrtimeout_ns() does
> set_current_state(TASK_IDLE) and then schedule_hrtimeout(), and
> kthread_stop() sets KTHREAD_SHOULD_STOP before wake_up_process(),
> which wakes TASK_IDLE sleepers.  So:
> 
>   - If kthread_stop() comes while do_pending sleeps, or between its
>     set_current_state() and schedule(), the sleep ends right away.
> 
>   - If kthread_stop() has already happened, i.e., it comes between
>     the kthread_should_stop() check and set_current_state(), the
>     wakeup is lost, but KTHREAD_SHOULD_STOP stays set: do_pending
>     sleeps for one full period and the loop then exits.  That is
>     kthread_do_pending_ms plus up to 1ms of fuzz, so 3-4ms by
>     default.

Very good.  Except that if someone sets a very long sleep time, that
could result in excessive delay for kthread exit, right?  Or am I missing
a turn in there somewhere?

> For comparison, without this patch do_pending leaves its loop at
> torture_must_stop() and waits in torture_kthread_stopping(), which
> sleeps in TASK_UNINTERRUPTIBLE for HZ/20 at a time, so it has the
> same lost-wakeup window with a 50ms bound instead.

But that is a fixed wait, without the possibility of a user extending
it, correct?

> The next version says this in the changelog, which in the RFC only
> says "kthread_stop() wakes it".

Adding the details would be good, thank you!

> > >  		// Omit stutter_wait() because this function needs to do cleanup.
> > > -	} while (!torture_must_stop());
> > > +	}
> > > +	/* The readers have stopped, so nothing new can be deferred. */
> > > +	for_each_possible_cpu(cpu)
> > > +		hazptr_torture_do_one_pending(cpu, &rand);
> >
> > Very good!
> >
> > But given these two lines, do we need the changes to the loop?
> 
> I believe so, at least for the loop condition.  The readers are
> stopped after the writer, so during the writer's kthread_stop(), the
> writer can be in ->sync() on a hazard pointer that a still-running
> reader deferred, possibly from the iteration it was in when
> torture_must_stop() became true.  If the loop still ended at
> torture_must_stop(), do_pending would make that final pass right away
> and then wait in torture_kthread_stopping(), so a hazard pointer
> deferred after that pass would leave the writer in ->sync(), as in the
> hang above.
> 
> The other two loop changes follow from that one: the unconditional
> sleep keeps do_pending from spinning while the writer and the readers
> are being stopped, and the all-CPU pass once torture_must_stop() only
> bounds the writer's wait to one period, instead of up to nr_cpu_ids
> periods.  I'm happy to drop the latter if you prefer the simpler loop.

Should we stop the writer before stopping the readers?  Or would that
open up some other issue?

> > > +	/*
> > > +	 * Stop do_pending only after the writer and the readers: the writer
> > > +	 * may be waiting on hazard pointers that readers deferred.
> > > +	 */
> > > +	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
> > > +
> >
> > And this change looks good.
> 
> Thanks.  In the next version, I'll keep the original (longer) comments
> as you suggested in the other subthread, and post this patch in one
> series with two patches that make hazptrtorture catch the slot-owner
> race, as you asked in the slot-owner thread.

The comments sound good, and the single-patch/series decision is yours,
thank you!

							Thanx, Paul
