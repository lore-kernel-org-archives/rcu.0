Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB401824A6
	for <rcu@vger.kernel.org>; Thu, 13 Jun 2024 03:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718250521; cv=none; b=rUgXnn3JZjVwuYqiCn5id7m9/9s/Rn0FjhjAOxJxN4pYFCyQhaF7Djr3r9Rb+ZG65bhMkry+qA053agjVxnzCPLcaiGSEOWtr9LhQ8LWxhRf/Yhs3eozYDCxdeUrJCropOTz5UuEyxBD30cNzsVV2KAOnqmF/LAU1/srlztVXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718250521; c=relaxed/simple;
	bh=UatiIni9GA0Wv7hUFG4BNbtpwD1pJNginzPo6nGt8gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T52wFANuH+pCpEAXUqNbGxVUaQnSEj+sdl2BhMChr5n+V4UYfJjfLUzDZQTTaHh0UfsK8YzUJ4FAMdiSzt0uSMYek2NGTblc8eO/z1cdWoXvQkx/tSqWEytzWzVMVSNgQt+IsWr18yheTlK34hcd+UuwmweiCA1TKxeZx0hhAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKYPZTqz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKYPZTqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E5FC2BBFC;
	Thu, 13 Jun 2024 03:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718250521;
	bh=UatiIni9GA0Wv7hUFG4BNbtpwD1pJNginzPo6nGt8gQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LKYPZTqzAnIbUXC8SrRuacq423oSf/5G2uXyYB6gFbNiOLFAFvUCcPBlto5nKj0bI
	 JkYgkva7i8dshpI5AGHDaJAALif9vTFu2AUkKBKcYoLO+uoLTW81uyUdTWu7pj/Isu
	 U7hgn2fG8M/t8IGQpHv1rU2XFVtXCyGODKB8Lf1g9wVygYd3q2GN10e0iW7f0Y9nhb
	 WW2mj5dnGSq2ufIOFvXC6FCikN/4Aj1S8VBUSe8+G8dfD9WqUnY2eosrproLgTHVTq
	 izTFPmwvsHHNJQigLESO7aChvD/nGxnGL+ou0oI9g5GEzITCEVLPcsjKJEfM1rZoi7
	 hJy2jGpk3HrAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DD824CE0DEA; Wed, 12 Jun 2024 20:48:40 -0700 (PDT)
Date: Wed, 12 Jun 2024 20:48:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <y5hi7x5w3yi4i5sh2b5hgk7xu2mghkthabc7adrqteg3muc5y4@pbnkp7yyxcrp>
 <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
 <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
 <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
 <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
 <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
 <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>

On Wed, Jun 12, 2024 at 09:32:26PM -0400, Kent Overstreet wrote:
> On Sun, Jun 09, 2024 at 07:10:53PM -0700, Paul E. McKenney wrote:
> > On Sun, Jun 09, 2024 at 08:52:14PM -0400, Kent Overstreet wrote:
> > > On Sun, Jun 09, 2024 at 09:55:30AM -0700, Paul E. McKenney wrote:
> > > > On Sun, Jun 09, 2024 at 11:37:45AM -0400, Kent Overstreet wrote:
> > > > > On Sat, Jun 08, 2024 at 08:25:53PM -0700, Paul E. McKenney wrote:
> > > > > > Could you please try something like this just before the call to
> > > > > > cleanup_srcu_struct()?
> > > > > > 
> > > > > > 	WARN_ON_ONCE(poll_state_synchronize_srcu(&c->btree_trans_barrier, ck->btree_trans_barrier_seq);
> > > > > 
> > > > > Which seq was this supposed to be? All keys have been freed by this
> > > > > point...
> > > > 
> > > > Or, alternatively, where in the code is this supposed to be?
> > > > 
> > > > If there is no convenient point in the code to grab the most recent
> > > > return value from start_poll_synchronize_srcu(), another thing to do
> > > > is to invoke either synchronize_srcu() or synchronize_srcu_expedited()
> > > > just before the call to cleanup_srcu_struct().
> > > > 
> > > > Another approach is to use get_state_synchronize_srcu() instead of
> > > > start_poll_synchronize_srcu(), and have a self-reposting SRCU callback
> > > > to keep the grace periods going.  Then you would set a flag that
> > > > stopped it from self-posting, then do srcu_barrier().  With careful
> > > > memory ordering.
> > > > 
> > > > There are quite a few techniques to shut down the self-reposting SRCU
> > > > callback when there is nothing for it to do and to restart it if need be.
> > > > 
> > > > But just doing a synchronize_srcu() or synchronize_srcu_expedited() is
> > > > a lot simpler and probably does the job.
> > > 
> > > synchronize_srcu_expedited() seems like the simplest solution, yeah.
> > > 
> > > Thanks, I think I'm starting (hazily) to get an idea of how the RCU code
> > > is structured, but I'll have to dig more when I have more time, this is
> > > interesting :)
> > > 
> > > I am wondering why you couldn't just have cleanup_srcu_struct() do the
> > > appropriate cleanup (synchronize_srcu_expedited?) in this instance; if
> > > the caller is tearing down the srcu struct they don't need srcu
> > > synchronization anymore, I would think the only safety issue that would
> > > need a warning would be leaked read locks.
> > 
> > Starting a grace period and then invoking cleanup_srcu_struct() before
> > it has had a chance to finish seems worth a warning.  And preferable to
> > having something like poll_state_synchronize_rcu() segfault later on,
> > for example.
> > 
> > > Another question for you: is there a limit to the number of pending
> > > sequence numbers from start_poll_synchronize_srcu()? (e.g. 2?)
> > > 
> > > That affects the data structure I use for redoing this "track pending
> > > frees" code.
> > 
> > Yes, there is, and you are right, the number is two.  Would something
> > like the patch shown below help?
> 
> If I look at the sequence number from start_poll_synchronize_srcu() vs.
> the last uncompleted one, I see a difference of 4 (so far?)

The number two is the number of distinct values, which will not be
consecutive numbers.  As you noticed, they currently are always multiples
of four, but that is an accident of implementation that is subject to
change.

> I could use a doubly linked list for tracking all uncompleted objects,
> but I'm hoping use a darray per sequence number. Is it a max of two
> sequence numbers that had objects/callbacks/were requested pulling,
> or...?

Agreed, an array should work.  Each array element would need a field
recording its cookie.  Right, so you likely need a few more simple
functions:

	same_state_synchronize_srcu(): Equality comparison of the
		pair of cookies passed in.
	get_completed_synchronize_srcu(): Return a special cookie
		that, when passed to poll_state_synchronize_srcu(),
		always results in a @true return value.

Or maybe not, you tell me.

> Also, I'm wondering if this code might be worth turning into something
> generic...
> 
> What I'm sketching out is:
> 
> struct btree_key_cache_freelist {
> 	spinlock_t		lock;
> 	bool			rcu_armed;

This says whether or not the callback corresponding to ->rcu is in
flight?

> 	unsigned long		seq;

You store the get_state_synchronize_srcu() return value in ->seq?

> 	struct bkey_cached	*free[2]; /* singly linked list for now,
> 					   * perhaps darray/vector later
> 					   */

If ->free[] is the array, then you also need an array to hold the cookies.
Unless you are placing them in the objects themselves, which would
also work.

By "darray" you mean distributed array?

> 	struct rcu_head		rcu; /* rearming callback to free objects */
> };
> 
> and these are percpu. Thoughts?

This definitely looks to be moving in a good direction, give or take
the accuracy of my guesses above.

							Thanx, Paul
