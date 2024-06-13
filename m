Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF18F5B
	for <rcu@vger.kernel.org>; Thu, 13 Jun 2024 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242354; cv=none; b=MyhDst9K94ej4LoWr0J1ElH1hUZBKGPhFsWwoj2H01btx6QcKrP0tmz12FfAw9BhNYZIaCffSPzI9JIi2Z+8W5swY9+5rpw+ADdvl5S+wClEzydPVqaxdddSqb9nwXQL8DGYrYhjpd8mum9FVEzFEK6jEgcakv4NpTsRx1WMvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242354; c=relaxed/simple;
	bh=MgO4Wl5TZ9mHtksqW1OjN76mbosiAj8/HiNPr/TMh9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fdhd6tVLmN95MGXwUHD0bnhbORhaL901eLPN7QROr57IyA63fofL9ZEbYYAJ4/rH9Cmt3Cu7kd8MeX7E2rccBkSJ4SIfGF6cCWBAsrUu2X4c12bc/xnytoPc4oCuojcZTZaRi26weyjcKfGzugSBJw+/EnRuBwlKuQiaxpSWriE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T5ZwZ7jK; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T5ZwZ7jK"
X-Envelope-To: paulmck@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718242349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l1iZKr6FH7V7WyIRP13ydBODtWdTM25qTxvhUcj29F0=;
	b=T5ZwZ7jKwFeKLOJpTLPzl9IlqJMSEFy0GcCVz3EbhMESRQnWGuzmqM5Ev7YLDlXpyEKU8s
	jikIfpSg5b1PukHvG4H77UZK7YKiF5IsNxHVx2mP9ZPt1CuBO/misH4v57+01rbO5zh4mB
	yAGN/ef7BVjReVGFUJOxP6Vs4cXdtR8=
X-Envelope-To: rcu@vger.kernel.org
Date: Wed, 12 Jun 2024 21:32:26 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
References: <y5hi7x5w3yi4i5sh2b5hgk7xu2mghkthabc7adrqteg3muc5y4@pbnkp7yyxcrp>
 <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
 <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
 <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
 <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
 <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 09, 2024 at 07:10:53PM -0700, Paul E. McKenney wrote:
> On Sun, Jun 09, 2024 at 08:52:14PM -0400, Kent Overstreet wrote:
> > On Sun, Jun 09, 2024 at 09:55:30AM -0700, Paul E. McKenney wrote:
> > > On Sun, Jun 09, 2024 at 11:37:45AM -0400, Kent Overstreet wrote:
> > > > On Sat, Jun 08, 2024 at 08:25:53PM -0700, Paul E. McKenney wrote:
> > > > > Could you please try something like this just before the call to
> > > > > cleanup_srcu_struct()?
> > > > > 
> > > > > 	WARN_ON_ONCE(poll_state_synchronize_srcu(&c->btree_trans_barrier, ck->btree_trans_barrier_seq);
> > > > 
> > > > Which seq was this supposed to be? All keys have been freed by this
> > > > point...
> > > 
> > > Or, alternatively, where in the code is this supposed to be?
> > > 
> > > If there is no convenient point in the code to grab the most recent
> > > return value from start_poll_synchronize_srcu(), another thing to do
> > > is to invoke either synchronize_srcu() or synchronize_srcu_expedited()
> > > just before the call to cleanup_srcu_struct().
> > > 
> > > Another approach is to use get_state_synchronize_srcu() instead of
> > > start_poll_synchronize_srcu(), and have a self-reposting SRCU callback
> > > to keep the grace periods going.  Then you would set a flag that
> > > stopped it from self-posting, then do srcu_barrier().  With careful
> > > memory ordering.
> > > 
> > > There are quite a few techniques to shut down the self-reposting SRCU
> > > callback when there is nothing for it to do and to restart it if need be.
> > > 
> > > But just doing a synchronize_srcu() or synchronize_srcu_expedited() is
> > > a lot simpler and probably does the job.
> > 
> > synchronize_srcu_expedited() seems like the simplest solution, yeah.
> > 
> > Thanks, I think I'm starting (hazily) to get an idea of how the RCU code
> > is structured, but I'll have to dig more when I have more time, this is
> > interesting :)
> > 
> > I am wondering why you couldn't just have cleanup_srcu_struct() do the
> > appropriate cleanup (synchronize_srcu_expedited?) in this instance; if
> > the caller is tearing down the srcu struct they don't need srcu
> > synchronization anymore, I would think the only safety issue that would
> > need a warning would be leaked read locks.
> 
> Starting a grace period and then invoking cleanup_srcu_struct() before
> it has had a chance to finish seems worth a warning.  And preferable to
> having something like poll_state_synchronize_rcu() segfault later on,
> for example.
> 
> > Another question for you: is there a limit to the number of pending
> > sequence numbers from start_poll_synchronize_srcu()? (e.g. 2?)
> > 
> > That affects the data structure I use for redoing this "track pending
> > frees" code.
> 
> Yes, there is, and you are right, the number is two.  Would something
> like the patch shown below help?

If I look at the sequence number from start_poll_synchronize_srcu() vs.
the last uncompleted one, I see a difference of 4 (so far?)

I could use a doubly linked list for tracking all uncompleted objects,
but I'm hoping use a darray per sequence number. Is it a max of two
sequence numbers that had objects/callbacks/were requested pulling,
or...?

Also, I'm wondering if this code might be worth turning into something
generic...

What I'm sketching out is:

struct btree_key_cache_freelist {
	spinlock_t		lock;
	bool			rcu_armed;
	unsigned long		seq;
	struct bkey_cached	*free[2]; /* singly linked list for now,
					   * perhaps darray/vector later
					   */
	struct rcu_head		rcu; /* rearming callback to free objects */
};

and these are percpu. Thoughts?
