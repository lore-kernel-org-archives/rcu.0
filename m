Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B4DDBD
	for <rcu@vger.kernel.org>; Sun,  9 Jun 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717951564; cv=none; b=uaoNv19SKmW9CBoRgej3aqcsIR5QZP83CuYqBGLq5zk1Vg5Gkg9BoQs9S4bjnTycrAQAYh5pOBVZ9JGrSU8LuIbnQs753jC4joTI9aLOGuNJyjyTu3hm+HZwWxe8mfiPZxLT9AnP3UHK2eR0k8FmZATQgcaDEiXLtzb699miDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717951564; c=relaxed/simple;
	bh=/zU9R8uvStIdM+Dl1B7rA4p52E8Mgzrl03ujVrWp7Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB6P4//to+bT4us16GzEr2lXvykMz/gqi4lVNaxEvJCZe7r9l96AMvHMC24Ki718xObBCsKDRDA+kDRCGaIpy4LFakhz/9Gnapt5R8rvhi8Jdlzk3PsBTRrI6WieYN6nUAkZEkKsVk5aGKsU6CMIcAQBo4cFutlnZVreADkZHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh7AKjNZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh7AKjNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DD9C2BD10;
	Sun,  9 Jun 2024 16:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717951563;
	bh=/zU9R8uvStIdM+Dl1B7rA4p52E8Mgzrl03ujVrWp7Lw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Uh7AKjNZxZyFdKcVSD1SuBCudAMwEjVK3Zf9nApQLJmAsKh1swiZZk+Mg9pdzsjYv
	 4C1CV0+MdCIHjKBIekGtfhqlp1yqw6TBKOTRfsVjygdxNDdi6H5KlIzbNLcwj5WZor
	 nykaEwoPRgh0CrwHEbVrqOAM6Oj5pEb9mfe0p8nZh5shcFqVw36nNF8nMvT9gUnRIl
	 A+ue54VQrkCASjJDiT93iU4NpVpYOOJDWLkD5J/qRVqGXSeiyhpLMflbrXuil7/kuw
	 xWavMBbLu8CJLfgcWXXb/F9Ez/GlGXZncfdNtl8Hv1S11Aryvc3kLr1NmiPkYL8Lwp
	 73JzRSja/iRaw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 657E7CE22D7; Sun,  9 Jun 2024 09:46:03 -0700 (PDT)
Date: Sun, 9 Jun 2024 09:46:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <1416745c-05a6-42c4-bdb5-48f6fef42988@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <y5hi7x5w3yi4i5sh2b5hgk7xu2mghkthabc7adrqteg3muc5y4@pbnkp7yyxcrp>
 <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
 <d2tnj35dkrwe7stc7f7pn7sk3pcz6hfiw7ztm6u4turwkpvema@25yp6csvezpt>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2tnj35dkrwe7stc7f7pn7sk3pcz6hfiw7ztm6u4turwkpvema@25yp6csvezpt>

On Sun, Jun 09, 2024 at 01:39:21AM -0400, Kent Overstreet wrote:
> On Sat, Jun 08, 2024 at 08:25:53PM -0700, Paul E. McKenney wrote:
> > There is a grace period in progress ("read state: 1") and that grace
> > period is the last one that has been requested ("gp state: 573/576").
> > 
> > Had there been callbacks pending, there would have been a warning from
> > "if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))", so srcu_barrier()
> > having no effect is expected behavior.  Which also suggests that the
> > unfinished grace period was started by start_poll_synchronize_srcu().
> 
> I'm surprised that srcu_barrier() has no effect; I would have exppected
> the underlying machinery to be the same for explicit callbacks/barriers
> as well as polling, so I think I'm missing something.
> 
> So I think there's something I'm missing;

The trick is that srcu_barrier() waits only for callbacks that were
previously queued using call_srcu().  If there are no callbacks, then
srcu_barrier() is within its rights to return immediately.

>                                           it sounds like something's not
> getting kicked, and if you say srcu_barrier() is expected to have no
> effect than that seems to imply there's something else I should be
> calling?

There is, but a question first.  What looks to have happened here is
that an object was associated with an SRCU grace period with a call
to start_poll_synchronize_srcu().  But before that grace period ended,
everything is being torn down.

Now, I can imagine cases in which this is OK, for example, if everything
that could possibly be an SRCU reader has been stopped.  Perhaps that
stopping was concurrent with the start_poll_synchronize_srcu() call.

If this is the situation here, you can something like this at some
convenient point in your teardown process:

	if (!poll_state_synchronize_srcu(&c->btree_trans_barrier, ck->btree_trans_barrier_seq))
		synchronize_srcu(&c->btree_trans_barrier);

Or synchronize_srcu_expedited(), if you wish.

If you track the furthest-ahead start_poll_synchronize_srcu() return
value, you could replace the "ck->btree_trans_barrier_seq" with that
furthest-ahead value.  But a failing poll_state_synchronize_srcu() is
fairly lightweight, so just invoking the above "if" statement for each
element being cleaned up should be OK.  (Famous last words...)

> > Could you please try something like this just before the call to
> > cleanup_srcu_struct()?
> > 
> > 	WARN_ON_ONCE(poll_state_synchronize_srcu(&c->btree_trans_barrier, ck->btree_trans_barrier_seq);
> 
> Added, I'll check the results in the morning but they'll be here:
> https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-testing

Thank you!

> > If there is some chance that start_poll_synchronize_srcu() was never
> > ever invoked, this check will of course need some additional help.
> 
> start_poll_synchronize_srcu() is the only thing that version of my code
> uses.

OK, then if it was never invoked, there would be no objects, and thus
no problem, correct?

> > I am curious about your use of ULONG_CMP_GE() on return values from
> > different calls to start_poll_synchronize_srcu(), but that is not urgent.
> 
> The freelists are intended to in the order in which they can be
> reclaimed - is that not actually a sequence number?

Yes, but it would be good to be able to see where people are relying
on that.  For example, the _full() polled grace-period cookies are only
partially ordered.  The optimization that resulted in this partial
ordering might never need to be applied to SRCU, but if it ever is,
it would be good to be able to find the required changes easily.

> I'm actually in the process of redoing (and simplifying) that code.
> Basically, the code is supposed to be tracking objects pending freeing
> in exactly the same manner as which RCU tracks pending callbacks -
> except that by doing it ourself we can allocate from those pending lists
> and not be hosed if reclaim is delayed because of an srcu lock held too
> long.

That does sound like a very good optimization!  It of course means
that a reader might see a given object being freed and reallocated as
a different object of this same type, similar to the situation with
SLAB_TYPESAFE_BY_RCU.

Another technique is to have multiple srcu_struct structures, so that
a given too-long reader affects only some of the objects.  A couple
of downsides: (1) You have some way to shard the objects and (2) it
increases the per-object overhead of the grace-period computations.

> As an aside - I've been considering ripping that out and just freeing
> objects via call_srcu(), it would definitely simplify things, but some
> workloads cycle through a _lot_ of these objects and memory reclaim
> stalling is a real concern. And after I redo it, it should be if
> anything slightly more efficient than freeing objects via call_srcu()
> like normal (elimination of indirect function calls), so perhaps a
> technique we'll want to keep in mind.

Agreed, elimination of indirect function calls is one of the potential
benefits of polled grace periods.

In theory, you could also reduce cache-miss overhead by moving away from
a linked list, but my guess is that the fact that the code accesses
each object anyway prevents current CPUs from benefiting from this
added complexity.

							Thanx, Paul
