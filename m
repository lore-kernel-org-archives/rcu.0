Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B63C30
	for <rcu@vger.kernel.org>; Mon, 10 Jun 2024 03:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717989888; cv=none; b=E5HOQfFzWdv8O/GQ28UNt6ZlbIQcr+JW6n/RIuATMR48MyZ/uc53Qb/d1F604nUNkucfSUK9lfUDF7kibvXl/YcWKsX0I6vnK9g6LW0feSsk/GIbNGl5TRFalym1N+0Mxlio123u2rMdUepMQNYYhv336Imb+V4w4+xLNlNHfus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717989888; c=relaxed/simple;
	bh=XIzOsvwPeEe7/O23eDwTcDfXVSbNoTbYXoj6XDkRtfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpLRQRUOJymBaSo6TWp66aGFOnCncAMIFCNZ4CnPcINN3TtRn928XbUaPd2t0JVo62nBzrl+KhOp2ap+BWH73KkSlO18z4CIYJveOtiwQWl2ypGr85pJZ5kH0XI8ABZ/RC7i6LgPCmdbl0hydX1HnNeL63rbAh0/OjCNlt4H1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0h1A+jK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0h1A+jK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C343C2BD10;
	Mon, 10 Jun 2024 03:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717989887;
	bh=XIzOsvwPeEe7/O23eDwTcDfXVSbNoTbYXoj6XDkRtfU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Y0h1A+jKe/UVNyOHPwQy1lGHYW1y9PDDhNreNGBiDls7JzLyZBmbUlkO3gY72bWqz
	 RBjv+NeUpUc0v0exp62Tz5jrH4Pwk8LchPhFaVaHaFfOHJxZNookDVs5Mq+UUkY9Fu
	 +Su2cV13dnwH5I9ReE7mBWJh7PjQGzBp+jUS+tIosjqkr5lB2KtOrGHypRiReLntbE
	 QOPciBEWaNpbJiHaFcR5zKiUMqRp3q3ALdBGoETZfu2hOQSAu2q/LL7JVVL+MrQP4p
	 fo46JUkeVMDnIQo2z6+uFo3CY7NThVr97DoOM4wrGF54xZbzE8Cb0nn63zgTuMxyZw
	 styhPBC+Lg+WA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2D7ACCE22D7; Sun,  9 Jun 2024 20:24:47 -0700 (PDT)
Date: Sun, 9 Jun 2024 20:24:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <822411f5-bda9-4882-8dfd-095a2a197082@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <y5hi7x5w3yi4i5sh2b5hgk7xu2mghkthabc7adrqteg3muc5y4@pbnkp7yyxcrp>
 <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
 <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
 <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
 <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
 <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
 <3cegn4of3iw3duydtgkpivuzw6roqqwyppyxhj43qw2oiygenm@wtwldj5hgphd>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cegn4of3iw3duydtgkpivuzw6roqqwyppyxhj43qw2oiygenm@wtwldj5hgphd>

On Sun, Jun 09, 2024 at 10:57:00PM -0400, Kent Overstreet wrote:
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
> 
> That seems to me like it'd be entirely on the calling code for using an
> object it destroyed.

I like the way you think, but the hard cold fact would be that the
segfault would be within a function whose name contained "rcu".  ;-)

But I do need to update that comment.  Would the following have
helped?

> > > Another question for you: is there a limit to the number of pending
> > > sequence numbers from start_poll_synchronize_srcu()? (e.g. 2?)
> > > 
> > > That affects the data structure I use for redoing this "track pending
> > > frees" code.
> > 
> > Yes, there is, and you are right, the number is two.  Would something
> > like the patch shown below help?
> 
> Yeah, that clarifies things - thanks!

Very well, I expect to push that into the upcoming merge window.  Now to
make rcutorture do the right thing with it.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9a8b7ecd2ff45..bc0d28fdc0146 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -668,7 +668,10 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
 			__func__, ssp, rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)),
 			rcu_seq_current(&sup->srcu_gp_seq), sup->srcu_gp_seq_needed);
-		return; /* Caller forgot to stop doing call_srcu()? */
+		return; // Caller forgot to stop doing call_srcu()?
+			// Or caller invoked start_poll_synchronize_srcu()
+			// and then cleanup_srcu_struct() before that grace
+			// period ended?
 	}
 	kfree(sup->node);
 	sup->node = NULL;
