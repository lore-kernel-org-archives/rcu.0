Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D999919306C
	for <rcu@vger.kernel.org>; Mon, 26 Aug 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692175; cv=none; b=P7gIWtXNq9JY8WTjvd9tlS/2rSjLNyTu/QBfXd++CMrCbqptGQXkDtyhe7pCRORSyxE18TeGm8ag0lWHZ0zPrEEAk4lOwd01zzLc8X4YRHEFcIvljAt1ou6tdhO9HmTolukDIIY0QJrP0zrQEUbgo6odDhjJEhcNch1Pz64Sn4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692175; c=relaxed/simple;
	bh=UkMKhXbxUysCKnginI4+ViBJH9lR3aoTZZDC0L1LmJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkHWvaffmt/m29OMGuclekP33PnZ6/B4K9vGNwhsLcUJP0OljRMa6VimIDy+hA5FiRyAotfWG+y/ZWyw8CH13A7OWCVNVSEnXjbXuEaQPZbysDqIZoA4Fym+li/aZU5U787tqkK654RN6QRLR9QTUTbJC3ugzIAOe5lLRKc3gPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p8d/OM50; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p8d/OM50"
Date: Mon, 26 Aug 2024 13:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724692170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U2AMIywTyKt2xwzTJWAd9krzomxqoEAnx2EiULkeoSA=;
	b=p8d/OM50msHKVzPngdMQXX0eCpLZKmh4oIrsEBNxBngJ54eLjKpoxnPc0CG1nZrIQSUzHM
	4dvUdiM/Mr5ylqaIljmWmNqlmY5DAkizfkqUBeWpkYIDJg5bU82lGZj+jFQ4i4qtoYdPXO
	j0MkUSuBt59dpfEhNlfPIQuYHDxVp80=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com, 
	mhocko@kernel.org, urezki@gmail.com, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH 6/9] rcu: rcu_pending
Message-ID: <gqgocomsljkn5sw2jvm432peesjuclfjwd2sasec3kg6tofk5t@ry7rkoo2auek>
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
 <20240819165939.745801-7-kent.overstreet@linux.dev>
 <adc8b09e-5f66-44de-845b-e615069c2e20@paulmck-laptop>
 <yfhctftdn4itupt735u7dnu2zt2aarm3lzvmyf6bs7hkv4radc@ndw4nsinxhqx>
 <f7266ab4-aa29-4cbc-a63e-fa582e266864@paulmck-laptop>
 <4zkfyn2shwot2zxiahn7zt7k2gpnoavyrldzzwo23qqxr6fvfh@xqlz4vehkln5>
 <4e4a5c89-e9ec-421e-8245-f076044866c9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e4a5c89-e9ec-421e-8245-f076044866c9@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 09:01:54AM GMT, Paul E. McKenney wrote:
> But get_state_synchronize_srcu() is still a function call.  But the
> offer of a function that checks multiple grace-period-state cookies in
> one call still stands.

It shouldn't be though, it's just reading a sequence number - I'd much
prefer if it could be at least a static inline.

Which you won't want to do, because it would mean exposing RCU private
data structures; hence my approach of exposing an RCU-only api for
getting a pointer to the sequence number.

> 
> > In my current version of the code, we call __get_state_synchronize_rcu()
> > after we've disabled interrupts; we know the rcu gp seq isn't going to
> > tick while we're in the critical path. But this doesn't apply if it's
> > for SRCU, and I don't want to add if (src) srcu_read_lock() branches to
> > it.
> 
> Actually, disabling interrupts does *not* prevent RCU's grace-period 
> sequence number from changing.  For example, the following really can
> happen:
> 
> o	RCU notices that the current grace period can end.
> 
> o	A CPU disables interrupts here.
> 
> o	A call to get_state_synchronize_rcu() returns a cookie
> 	corresponding to the end of the grace period following the
> 	current one.
> 
> o	RCU ends the current grace period, therefore updating the
> 	grace-period sequence number.
> 
> o	RCU starts a new grace period, therefore updating the
> 	grace-period sequence number once again.
> 
> o	RCU cannot complete this new grace period until that CPU
> 	re-enables interrupts, but it has already updated its grace-period
> 	sequence number not once, but twice.
> 
> So if your code knows that RCU's grace-period sequence number cannot
> change while a given CPU has interrupts disabled, that code has a bug.
> A low-probability bug, perhaps, but if your code is running on enough
> systems, it will make its presence known.

Ok, good to know

> 
> > Not at all essential, the races that result from this are harmless, but
> > if we e.g. decide it's worthwhile to only kick off a gp if it hasn't
> > ticked (i.e. only kick rcu if we're still on seq of the object being
> > enqueued) it'd be nice.
> 
> Why not call get_state_synchronize_rcu(), and ask for a new grace period
> if the value returned is different than that from the previous call?

We don't want to falsely think the object expires later than it actually
does, and have more accumulated work than we need to.

> > Funny, I had the same thoughts trying to read your code... :)
> 
> Amazing how much easier it is to generate new code than to understand
> existing code, isn't it?  ;-)

I would have much preferred if your existing code worked with SRCU. You
think I'm doing this for fun?

> > > Plus, unlike kfree_rcu() post-grace-period handling, call_rcu() callback
> > > functions usually access the memory block passed to them, which means
> > > that they are incurring that per-element cache miss in any case.
> > 
> > True. But this would allow us to prefetch those objects (several
> > iterations in advance).
> 
> I need to see a CPU on which this actually make a significant difference
> before adding this sort of complexity.

We would of course want benchmarks to show that this was worthwhile
before switching call_rcu(), since absent a performance improvement we'd
want to stick with the approach that doesn't allocate memory.

> > Just processing a few items? hmm, would we want to though, when
> > otherwise we'd be calling kfree_bulk()? I think icache locality means
> > we'd generally prefer not to.
> 
> You might not want to yet, but you eventually would want this.

Because?
