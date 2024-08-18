Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4238B
	for <rcu@vger.kernel.org>; Sun, 18 Aug 2024 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723954236; cv=none; b=mZLyHgqbXelnpoBku2dkA7t3yMPfda6R+cfzCewJpLLtPPJhZr2hjY4ArHfr5CufWSSsqx3BMIv2oARnRexyCPO+r3tSgkfB/51zIaYodovoqnP2qFQRIVeSgbjX0U2Vu6JBudc+FPAmUESkiNSIs4ad1Y+KujGboWRK3F3oTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723954236; c=relaxed/simple;
	bh=vpWQgvYFxZDkRPRMjr2okkFKUq5xM93gxejKMHwcgMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3UK0EUMWb3UEmW2qOZ86kWcPbfp668gXeoQs1pZPXMZjUiZtre1aLDsu2opRCN/OUAp4AxJmHB2luQvwUM7wCoHduaCYYcjBSoJoTY/n4UhGGqXcZmjIo/kveUNncuHJSH8HIzytPL+RjRpSLhrrkcYJEk/fAleFBt09CXy99I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jGJT7/lg; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jGJT7/lg"
Date: Sun, 18 Aug 2024 00:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723954230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dbx854yXjp8C9pSACJH4a4I+uokUQyEElmgEBzGTYfM=;
	b=jGJT7/lgAhx+CrIi4rWMQasf3Nh89U4KbwhU3nGvCFsUJK7HDhkLelWtFs4jO0x3iHvID1
	3Em5b6R6/dDkAh3lEeSkZN1GGc6D3qgIvWWZpMtWJ2u8E7q6aobvKTD2s077u89cTgHoHM
	2iHheoKFDsrDpHlTQd3YAeK0E+JUeY4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <43crql5tqt2d7a65qxtaowpritjvvzoe72spvnb3temas33q5a@6qvk2an743wh>
References: <cqs6e6daupkzbjphltpbo5ljwut2lteji2ips3rpihlak5yjbp@im5ksmjjsrh6>
 <w52nycocowsq7jiay3ybhpsy4h6bl6t6nqew4wk2dolzvn5mql@rv3nffcb7q7q>
 <7da0d749-e482-402e-9241-6c7d5f29e39a@paulmck-laptop>
 <lqtvpxcnp3mfs5pmaawfvfrcnz2vla7hfedgzec2louaxypjex@o6qzbt7snxoq>
 <617a8c07-4e26-4cf7-a263-552cfa070956@paulmck-laptop>
 <us7xrey4xz6zxou4u64bsebthodqzl33zrdo3pdgmf33q2bgjt@abf6a6c5x7ar>
 <11b7a42a-a11d-4efd-926d-1777f9e210a8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b7a42a-a11d-4efd-926d-1777f9e210a8@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 16, 2024 at 01:33:30PM GMT, Paul E. McKenney wrote:
> On Thu, Aug 15, 2024 at 11:20:09AM -0400, Kent Overstreet wrote:
> > On Thu, Aug 15, 2024 at 08:13:10AM GMT, Paul E. McKenney wrote:
> > > On Thu, Aug 15, 2024 at 10:58:37AM -0400, Kent Overstreet wrote:
> > > > start_poll_synchronize_rcu_common() requires that irqs are enabled
> > > > 
> > > > that doesn't match call_rcu() requirements, so - can we lift that
> > > > requirement? I need to be able to make sure the grace period is
> > > > started...
> > > 
> > > I have to awaken the grace-period kthread, and wakeups are no longer
> > > possible when interrrupts are hard-disabled.
> > 
> > Err, what? How do we get anything done when IRQs are hard disabled,
> > then?
> 
> Good point, I was confused.  I will try it and see what happens.
> Perhaps you have already done so?

From a cursory glance at the test dashboard, it looks good :)

I was hesitant at first because... that's not a normal wakeup, but I
read through it more and I think it's safe.

> Hey, you are the one who sent me a private query while I am on vacation!
> Kidding aside, CCing rcu@vger.kernel.org gives others in a variety
> of timezones a chance to help out.
> 
> > > Another approach is to replace that start_poll_synchronize_rcu() or
> > > start_poll_synchronize_rcu_full() with a get_state_synchronize_rcu()
> > > followed by a "throw-away" call_rcu(), that is, one whose callback
> > > function does nothing.  Would that work for you?
> > 
> > Maybe? If call_rcu() then skips adding the entry to the list of pending
> > callbacks (which it would have to, we're not going to get the
> > notification when the rcu_head is completed) so that we can reuse it
> > right away for the next gp, then that should work...
> 
> OK, OK, "does almost nothing".  ;-)
> 
> Yes, you would need a small state machine to rearm if there was a
> subsequent start-poll call and so on.
> 
> But does your (almost) unconditionally rearming callback have some
> purpose other than to work around start_poll_synchronize_rcu_common()
> currently giving lockdep splats when invoked with irqs disabled?

Yes, processing pending items - so it would be ideal to get a callback
for every grace period we have items for, though not strictly necessary
for a v1.

But as mentioned previously, the issue is that since RCU callbacks may
be punted to a kthread (correct?) - we'd need memory for an unbounded
number of pending callbacks, which doesn't work here; we don't have a
way of handling that allocation failure.

Long term, I think it would be a worthy goal if this code could be used
for tracking RCU callbacks, so as to eliminate the linked lists overhead
in processing them. 

For that to happen, we'd need a different way of getting notified when
grace periods elapse, so maybe we could kill two birds with one stone on
that one.
