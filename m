Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDFF26F441;
	Tue,  4 Mar 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101057; cv=none; b=VaPdw6hd+VHvn/4drHTAQ8dRmjxRMxib7p3tqZf+bB0cpeC49KaEOTxFJA5EcUXNlH71Ea8DS0b8cvQXvbAsahwNa1eFOi2Dsn37pcTyIXCMM6Rfv7USI5i1sMEYua66KeHSnoDyNmQCWfLH8xn/tmJYXW/OAJCOUoPD0nlAkYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101057; c=relaxed/simple;
	bh=KRdRud0KKKLKl9c4w5fSpaB1vPlZnIT/TE03lwaFsZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gb3749cKdg8W1lvUB6lJ4PqN6u7sVWFv+D0QS8FYZ8p0/wyY1uLn9KmLGeSlwyPq+ylOGgHfDcWHOX9XpcbYmEjQMRkAZUOQm8iPTcD25QTda4N07qNYrEN2HU0s7J01mZmHkdaQYLPxVn/UtZ9WAAwGRUoRAxva+2am9AHpYB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA025C4CEF0;
	Tue,  4 Mar 2025 15:10:55 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:11:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Strforexc yn <strforexc@gmail.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh
 Triplett <josh@joshtriplett.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: KASAN: global-out-of-bounds Read in srcu_gp_start_if_needed
Message-ID: <20250304101150.0eb83618@gandalf.local.home>
In-Reply-To: <20250304035732.GA128190@joelnvbox>
References: <CA+HokZrPb-oHcuZQsc=LZ6_aJfjKy9oMeCBd-tq4b_sX5EG7NQ@mail.gmail.com>
	<20250303114711.12716d05@gandalf.local.home>
	<20250304035732.GA128190@joelnvbox>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 22:57:32 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> > 
> > The lock taken is from the passed in rcu_pending pointer.
> >   
> > > [   92.322655][   T28]  rcu_pending_enqueue+0x686/0xd30
> > > [   92.322676][   T28]  ? __pfx_rcu_pending_enqueue+0x10/0x10
> > > [   92.322693][   T28]  ? trace_lock_release+0x11a/0x180
> > > [   92.322708][   T28]  ? bkey_cached_free+0xa3/0x170
> > > [   92.322725][   T28]  ? lock_release+0x13/0x180
> > > [   92.322744][   T28]  ? bkey_cached_free+0xa3/0x170
> > > [   92.322760][   T28]  bkey_cached_free+0xfd/0x170  
> > 
> > Which has:
> > 
> > static void bkey_cached_free(struct btree_key_cache *bc,
> >                              struct bkey_cached *ck)
> > {
> >         kfree(ck->k);
> >         ck->k           = NULL;
> >         ck->u64s        = 0;
> >                 
> >         six_unlock_write(&ck->c.lock);
> >         six_unlock_intent(&ck->c.lock);
> > 
> >         bool pcpu_readers = ck->c.lock.readers != NULL;
> >         rcu_pending_enqueue(&bc->pending[pcpu_readers], &ck->rcu);
> >         this_cpu_inc(*bc->nr_pending);
> > }
> > 
> > So if that bc->pending[pcpu_readers] gets corrupted in anyway, that could trigger this.  
> 
> True, another thing that could corrupt it is if per-cpu global data section
> section is corrupted, because the crash is happening in this trylock per the
> above stack:
> 
>  srcu_gp_start_if_needed ->
> 	spin_lock_irqsave_sdp_contention(sdp) ->
> 		spin_trylock(sdp->lock)
> 
> 	where sdp is ssp->sda and is allocated from per-cpu storage.
> 
> So corruption of the per-cpu global data section can also trigger this, even
> if the rcu_pending pointer is intact.

If there was corruption of the per-cpu section, you would think it would
have a bigger impact than just this location. As most of the kernel relies
on the per-cpu section.

But it could be corruption of the per-cpu variable that was used. Caused by
the code that uses it.

That code is quite complex, and I usually try to rule out the code that is
used in one location as being the issue before looking at something like
per-cpu or RCU code which is used all over the place, and if that was
buggy, it would likely blow up elsewhere outside of bcachefs.

But who knows, perhaps the bcachefs triggered a corner case?

-- Steve
