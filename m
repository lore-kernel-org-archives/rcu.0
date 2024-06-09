Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD01C687
	for <rcu@vger.kernel.org>; Sun,  9 Jun 2024 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717911571; cv=none; b=IDnuOnmZoaY7yNbEjFafa5u7HHFduDD5aeKtFDT8liJLsDOzVozK4OaXGtU/H5bS0DdggtN3MWnCP5cmMxt2zkNad3yOmIKoiLeSDpQlRXGXOPeeRmoesZnFOk0n7ZjEKmiDg+FNVoz/oDQMLFj10nUJYSJ86BtyauVHITWJx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717911571; c=relaxed/simple;
	bh=gTTKO1oV5AS2l3jmMsnRummFRbDoJk9WM4cvNZ7xFjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3shvCmbxkfA9H4E33KXAnEZwdkPJdt+MSDctSzOEnaE1/3paEipp8REjyt6OzgYdEc3qdQN7V4i4usJzVH2zyZ4DahTOfgpNSf0uJ107qym2nT+le9R6rb97xaHz81UHbLHvEtlw74GHGqI9bSmdE4L7G10RBHIw19/DmhN5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D4UM2Phh; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D4UM2Phh"
X-Envelope-To: paulmck@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717911566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p50KJcEeBrvnV+MpFHsh1RLRGCCZJaTnU22WK5y3/Pk=;
	b=D4UM2PhhWuw1ROkVRmtV5U7VZZxYx9H8p4rl/7NeiaJoQf3SVQNqTFnGejv0Y8FDPmdhUe
	dZn7e95XPBg8++cEiqFziIdorggBPt2y1dzhXSMo+W+6poYpNr8yHFvgrqUKl69ZN8CkjE
	XYmUlg639wsKoUz93POEQZor3USXgk8=
X-Envelope-To: rcu@vger.kernel.org
Date: Sun, 9 Jun 2024 01:39:21 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <d2tnj35dkrwe7stc7f7pn7sk3pcz6hfiw7ztm6u4turwkpvema@25yp6csvezpt>
References: <y5hi7x5w3yi4i5sh2b5hgk7xu2mghkthabc7adrqteg3muc5y4@pbnkp7yyxcrp>
 <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Sat, Jun 08, 2024 at 08:25:53PM -0700, Paul E. McKenney wrote:
> There is a grace period in progress ("read state: 1") and that grace
> period is the last one that has been requested ("gp state: 573/576").
> 
> Had there been callbacks pending, there would have been a warning from
> "if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))", so srcu_barrier()
> having no effect is expected behavior.  Which also suggests that the
> unfinished grace period was started by start_poll_synchronize_srcu().

I'm surprised that srcu_barrier() has no effect; I would have exppected
the underlying machinery to be the same for explicit callbacks/barriers
as well as polling, so I think I'm missing something.

So I think there's something I'm missing; it sounds like something's not
getting kicked, and if you say srcu_barrier() is expected to have no
effect than that seems to imply there's something else I should be
calling?

> Could you please try something like this just before the call to
> cleanup_srcu_struct()?
> 
> 	WARN_ON_ONCE(poll_state_synchronize_srcu(&c->btree_trans_barrier, ck->btree_trans_barrier_seq);

Added, I'll check the results in the morning but they'll be here:
https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-testing

> 
> If there is some chance that start_poll_synchronize_srcu() was never
> ever invoked, this check will of course need some additional help.

start_poll_synchronize_srcu() is the only thing that version of my code
uses.

> I am curious about your use of ULONG_CMP_GE() on return values from
> different calls to start_poll_synchronize_srcu(), but that is not urgent.

The freelists are intended to in the order in which they can be
reclaimed - is that not actually a sequence number?

I'm actually in the process of redoing (and simplifying) that code.
Basically, the code is supposed to be tracking objects pending freeing
in exactly the same manner as which RCU tracks pending callbacks -
except that by doing it ourself we can allocate from those pending lists
and not be hosed if reclaim is delayed because of an srcu lock held too
long.

As an aside - I've been considering ripping that out and just freeing
objects via call_srcu(), it would definitely simplify things, but some
workloads cycle through a _lot_ of these objects and memory reclaim
stalling is a real concern. And after I redo it, it should be if
anything slightly more efficient than freeing objects via call_srcu()
like normal (elimination of indirect function calls), so perhaps a
technique we'll want to keep in mind.
