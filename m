Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2EC54EED2;
	Tue,  8 Sep 2026 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904465; cv=none; b=U/hDQieDT9wf0OybLVudeJI3afHOWvytI28sIC+C+/7VqFSTHkxbY01bUgsOHtdlo7a1nUYk2/noGWYzDJpvykQMZHOqTM7nBKl6BK9iD5Y+8lxWVC5xVXIc6pmKgioS3HxZN1r9LG6lsK4aJ2lRJmrbaREbmNjbBX6zcNEOxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904465; c=relaxed/simple;
	bh=NcixbZGuHxKwdzVBCxD5UuChQngLxuHo6IpUSKRH1hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLYZwgn7+iH+aUeVn2gIyQtBE1EqX2XSrIxyGN0YJhulkJmdX5o8AazSmSDTb+pWaRnbNenMwB3GRCsRhPuyQPhIaXhb8LyqSrD7WkkUuJtbuikpaDVXAHaLkqZAOdVhNiWrsDMfgIxI1pZaE6jD4VNtsQS4xZOR4G3tq+Gn5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeDX39+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeDX39+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3A01F00A3A;
	Tue,  8 Sep 2026 21:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788904464;
	bh=YilMaq7/1E55l68gqwQcvtSaacgRxXGp8MELTiTKfDI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=NeDX39+AwAx9UaYoj7ryM6SzPwBph6zY8osRfkxBaRnJtS1NMBl/odR2gnko2dQ7c
	 yHmrhBAx4YJA/+rolOzGnpMFgXOkUjiGFxaWwEUKB8p/vCNjzlgsCxJgcl/SNml7HZ
	 G7NaFiXJTEtjGKlFczYg1K//irrjpYTXMby5JlqOaUA78zsE0IRAEUIWXKc448aaOe
	 97ESSA5rZB+nm7sq2XsiCJvejLr2lSubqJtN3HyIn8YqyJ4U5atNmTqiZCDAHJgQeG
	 A+OYrEDt3r4fAr6hmIPFL9vKMfTTmdPPN98iOMJjY/+VwgKmV+1pZf7wCEOiXMVIU4
	 dH4jcgFvlrVKg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E936DCE1902; Tue,  8 Sep 2026 14:54:23 -0700 (PDT)
Date: Tue, 8 Sep 2026 14:54:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>, jiangshanlai@gmail.com,
	josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] srcutree: Add reader-free fastpath to
 synchronize_srcu_atomic()
Message-ID: <40a4a925-d984-4f0b-b594-2d0a5ca7bde0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-4-kunwu.chan@linux.dev>
 <b7bc58aa-4b8a-4eaa-a7e8-8d338f34d14a@paulmck-laptop>
 <d622a6ed07845e5b7c5ab87446ff8b622b4b80eb.camel@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d622a6ed07845e5b7c5ab87446ff8b622b4b80eb.camel@infradead.org>

On Tue, Sep 08, 2026 at 10:13:39PM +0100, David Woodhouse wrote:
> On Tue, 2026-09-08 at 13:29 -0700, Paul E. McKenney wrote:
> > On Mon, Sep 07, 2026 at 03:58:19PM +0800, Kunwu Chan wrote:
> > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > 
> > > synchronize_srcu_atomic() is restricted to srcu_read_lock_atomic() and
> > > srcu_read_unlock_atomic(), whose read-side critical sections disable
> > > preemption.  In the common case where there are no readers at all, the
> > > grace period therefore need not do the index flip.  Add a fastpath
> > > that sums both ranks of the per-CPU ->srcu_ctrs[] counters and, if the
> > > lock counts match the unlock counts on both ranks, ends the grace
> > > period immediately, skipping the srcu_advance_state() scans, mirroring
> > > the similar Tiny SRCU fastpath.
> > > 
> > > Correctness requires the counter-sum proof to follow the grace-period
> > > anchor written by srcu_gp_start(); placing it before the anchor could
> > > let this grace period miss a pre-existing reader and return without
> > > waiting for it.  The smp_mb() between the unlock and lock sums pairs
> > > with the smp_mb() in __srcu_read_lock().  The grace period is ended
> > > manually under ->lock and ->srcu_atomic_gp_flag.
> > >
> > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > 
> > Adding David Woodhouse on CC.
> > 
> > David, does this provide appropriate performance in your use case?
> 
> Looks like it should; I've thrown it into the test. Thanks.
> 
> My version¹ didn't drive the GP at all, and just took the fast path if
> there were no readers. And because it didn't drive the GP, I *think*
> the "Correctness requires…" part of the commit message cited above
> didn't apply?

And another option is to pull the fastpath up earlier, before
checking and/or acquiring ->srcu_atomic_gp_flag.  But this is a
bit more complicated from a concurrency viewpoint, at least if
we are to interact normally with get_state_synchronize_srcu() and
poll_state_synchronize_srcu().  For example:

	srcu_state = get_state_synchronize_srcu(ssp);
	synchronize_srcu_atomic(ssp);
	WARN_ON_ONCE(!poll_state_synchronize_srcu(ssp, srcu_state));

Without at least some mucking with the grace-period mechanism, that
WARN_ON_ONCE() could trigger, which just might not be universally
considered to be a friendly act.  ;-)

So it would be very good to keep the fastpath where Kunwu put it, if
that works reasonably.

> Driving the GP does mean a certain amount of serialization that my
> earlier bailout didn't incur, but I think that's probably only going to
> show up on a microbenchmark. Let's see.

Here is hoping!

> I *do* want the fast path used from synchronize_srcu_expedited()
> though, if possible. That's what solves Sean's *other* problem. Can we
> have that?

I believe so, but let's get this put to bed first.  Please note
that synchronize_srcu_expedited() has the same relationship with
get_state_synchronize_srcu() and poll_state_synchronize_srcu(), so there
will be some trickiness there as well.

							Thanx, Paul

> ¹ https://git.infradead.org/?p=users/dwmw2/linux.git;a=commitdiff;h=0f1456f508
>   https://git.infradead.org/?p=users/dwmw2/linux.git;a=commitdiff;h=62ff5ac4ca


