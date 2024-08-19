Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB4159565
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724111060; cv=none; b=aWnv0tGNVnRSf40qSpQ9UicD1WPzjf19oQZHMyzWyE+4tWkjS2xMgO2EeLkmhJVoRj0I64GyDq8p1NmtXCahAAOZpedyK5fof5MpNvNjtAUkVh43PqVniJwz+lUiMuNA4HrzxC46ljhdNGF3ZDV2l49H/WYbzsceVYU16LCYajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724111060; c=relaxed/simple;
	bh=PuI6qKNaMb7WQtYAkDEmZY31vXm5v/bTHgDEEkwILzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2ATiDnxlM3qpXbBdzn61/GqDfw2tBl8EYOeqetr2aS80bNEvxuBwUnKkXxTkg65XFFDrFU9kKG4VOjIbL9x0ZX6aVSL0nXUflnpmFf35bncLDdZ4gZ7DKEcr0y3yGSAj6M2FCUt1OTHZMYZObr8LnTspIzFrPRUXRLG8Z1mMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvwohzDJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvwohzDJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCB0C32782;
	Mon, 19 Aug 2024 23:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724111060;
	bh=PuI6qKNaMb7WQtYAkDEmZY31vXm5v/bTHgDEEkwILzo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PvwohzDJ1SZ2CIFS0PVMVXmr4aTyZ65oVWUsM+JaTN0zNky74ZsO7o0r8ohufGVva
	 Md1I4PxKTNdZ6wmp/3fMoKp7+jW6RJBDM7h4x2LIPWxK0ZKTWQaT3MtGYKLkCQ9YDF
	 YE33RZgJ11xOQTQjfdG++hGiQwFoDWpbFno/LAJf5UifPgUB4BUoIC20SrNau5mua0
	 jvGiC3jYm9ADha+kCNTZjiMyH8HjhNFcbvBqGCcS9zj6Oz3Pyt4s+ASJIc2viArfTv
	 /uav1/bWDvVmjZeo/Nyrq0u5PvPD/4JsMeKllAKFd2elYFw4eiYGzE2RDP19KO91A5
	 MSAIuNIxUW/Cw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2F199CE0A01; Mon, 19 Aug 2024 16:44:19 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:44:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <b85e0bc1-80a9-49f0-8c4f-f2a521c9fe29@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <abc36602-20bb-4a52-b5f5-01c044700c50@paulmck-laptop>
 <a7zb6g6dgmm5hhkhw22u7lhbsgel2w3ntcaggoqoeblethx53l@uxef6ex25xwy>
 <f4c5bf95-da88-4633-ac9f-a626fdc332e4@paulmck-laptop>
 <wp42udo3pdqzjqlddtg7pca3uowil2pjaznx4liiqycpjlwis3@5kxso5kutoe3>
 <24c6696e-5669-421e-8288-5b220a6a1e40@paulmck-laptop>
 <6pqbszwxjby3cu7yfep23zrnfff4f5cnh5f7npxlpim7jhiuq7@4keumf66hfot>
 <e86fc94e-0151-40ec-ae6c-dd5991756905@paulmck-laptop>
 <bkqpx3rbhbz2jw52ugubyjyr4eyn2pkkpzsiczz5emtokviie7@hh5yrqjysacw>
 <6c35998c-a35d-451b-b698-f1613bd8a2a2@paulmck-laptop>
 <uy4ovnf7rkrhpqoj3zo3ky34qv462ttltvyp37ncxxfhz3awkq@cp7rcg4v6qzd>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uy4ovnf7rkrhpqoj3zo3ky34qv462ttltvyp37ncxxfhz3awkq@cp7rcg4v6qzd>

On Mon, Aug 19, 2024 at 07:37:55PM -0400, Kent Overstreet wrote:
> On Mon, Aug 19, 2024 at 04:10:23PM GMT, Paul E. McKenney wrote:
> > On Mon, Aug 19, 2024 at 01:09:09PM -0400, Kent Overstreet wrote:
> > > On Mon, Aug 19, 2024 at 08:49:26AM GMT, Paul E. McKenney wrote:
> > > > On Mon, Aug 19, 2024 at 11:14:02AM -0400, Kent Overstreet wrote:
> > > > By "number of outstanding grace period sequence numbers" you mean
> > > > the number of outstanding grace period sequence numbers that have
> > > > memory blocks that have not yet been processed?  If so, how could that
> > > > possibly matter more than the total number of memory blocks that have
> > > > not been processed, regardless of which grace-period number they are
> > > > associated with?  Why would a huge number of memory blocks fail to
> > > > cause an OOM simply because they happen to be associated with a single
> > > > grace-period number?  Or, to put it another way, suppose that same number
> > > > of memory blocks were distributed over a large number of grace-period
> > > > sequence numbers?  How could this possibly cause an OOM to be more likely
> > > > than if the same nubmer of memory blocks were associated with a single
> > > > grace-period number?
> > > 
> > > We just want a callback every time one of those grace periods expire, so
> > > the pending objects can be freed as soon as they're ready.
> > > 
> > > This isn't _fatal_ for the kvfree_rcu() backend, since we have memory
> > > reclaim to fall back on, but it would still definitely be preferable for
> > > rcu_pending to be getting the notification from core RCU and avoid the
> > > more expensive memory reclaim path.
> > > 
> > > It is more critical if we want to use this for a faster call_rcu()
> > > backend.
> > 
> > I am still missing why the call to process_finished_items() from
> > __rcu_pending_enqueue() cannot cover this.  Given the way that RCU works,
> > that has the potential to notify you *before* RCU's grace-period kthread
> > would get around to doing so.
> 
> Not with any kind of bounds, since there's no predicting if that
> enqueue() call will happen, and not all potential users can process
> pending objects in enqueue().

And if that enqueue() never does happen, then the RCU callback is
there for you.  But in that case, the flood of callbacks must have
stopped.

> Like I said, this isn't the most critical issue, I'm mainly thinking
> about if we want to use this to get rid of linked list overhead for
> call_rcu() processing itself.

In the common case for kfree_rcu(), the linked-list overhead is already
gone due to the pages of pointers.  You get up to 500+ pointers nicely
adjacent in one page, so that the linked-list overhead going from one
page to the next is way down in the noise.

							Thanx, Paul
