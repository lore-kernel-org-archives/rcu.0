Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D86385521;
	Thu, 10 Sep 2026 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010054; cv=none; b=JF6AE0Qd1hQiIPCc3FU4LJtsTF8otoC1z5O4tJXQUK82E1CznVZQNe4tnQRH/7ny6/2SHkSkkBQO8RAlJMjSHt4LiEdzYhpjAwRcfYXf5zfkW6Xr9HN22d4MNsu6BQVYdKfU7FRXq3VynErFqKfNFUY91xNdZj4t4n+li2FyIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010054; c=relaxed/simple;
	bh=i3qj4N8nsML3gQgXydrJC9MhO54EGjHvIuSzLdVLEgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRr82sQyhNUL8kLxCBiScD2v6SGPVGHGvRfoz1jl/JtT+IxbN4Ta+SO04Ebhn6tyyV3BucAoLHjgMZ5ZCLsW5IFRqiVxn0D7m+wdUZZKr+sylfbPBz2SO7SzV+1cQlXNpqjV1hM3wp22Ww5ibouXr8KTrrTshDC0INi4D2TWw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJBDoptU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJBDoptU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE5D1F000FF;
	Thu, 10 Sep 2026 03:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789010050;
	bh=ypWPk9EZ0+SltrmqSFE9tEBYLz/6aFYaEZi9JGgqGYE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=KJBDoptUU3Nfrdnu6jQv+/c03Kx1WOZ6ZIHZ8bMH7aPQhS68kIdkEuzWEJoaLQQnW
	 v3w+clQOmIxdea3V1rRIX2dmzXbLiFJv34D33IqIQjiH1ecp86A6mws7r9ua1cOlQk
	 atG6HyS9jnGKgN/KQdS94SlzdC00lnB1q/IXXEbofhUFXhtgftNKSo7JrN5BMC1BhE
	 kL6ZyYISYdO1NUv0Ugvp8QSvhuzMRbNDJdQxVzPTOw284n/kwen9yhxLNmbsIsRinl
	 UYMQDqjPk7qJxUTk6lP6kvOnRyt6yeHh0ONf1iPH748jVEBMC9uJwDOMtPUfnLEVLE
	 E1qWmQB92t+Tg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E6087CE086B; Wed,  9 Sep 2026 20:14:09 -0700 (PDT)
Date: Wed, 9 Sep 2026 20:14:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Bradley Morgan <brads@mainlining.org>, linux-kernel@vger.kernel.org,
	kernel test robot <yi1.lai@intel.com>,
	Boqun Feng <boqun@kernel.org>, rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: Re: [PATCH] hazptr: handle NULL address in hazptr_detach
Message-ID: <e8f734b1-9ea2-4c58-9119-778fe5d0d0ac@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260908152228.4154-1-mathieu.desnoyers@efficios.com>
 <E8BCA0DB-FB79-4348-BB0D-229E8B550D91@mainlining.org>
 <7e574430-c77e-4ba9-aab0-cdaed40f788f@efficios.com>
 <da21c929-cd85-4ecb-8976-5948f080b6e7@paulmck-laptop>
 <21b63f08-e79b-4eb9-9922-77a61d5ffa7c@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21b63f08-e79b-4eb9-9922-77a61d5ffa7c@efficios.com>

On Tue, Sep 08, 2026 at 12:53:52PM -0400, Mathieu Desnoyers wrote:
> On 2026-09-08 12:22, Paul E. McKenney wrote:
> > On Tue, Sep 08, 2026 at 11:29:31AM -0400, Mathieu Desnoyers wrote:
> > > On 2026-09-08 11:24, Bradley Morgan wrote:
> > > > On 8 September 2026 16:22:14 BST, Mathieu Desnoyers
> > > > <mathieu.desnoyers@efficios.com> wrote:
> > > > > When hazptr_acquire loads a NULL pointer, it sets:
> > > > > 
> > > > > - slot_item->slot.addr = NULL,
> > > > > - slot_item->ctx.ctx = ctx
> > > > > - ctx->slot = slot
> > > > > 
> > > > > And it returns NULL.
> > > > > 
> > > > > Then hazptr_detach is called on this ctx, it will act on the ctx as if
> > > > > needed to be promoted to backup slot, even though it has a NULL addr.
> > > > > 
> > > > > Looking at what hazptr_note_context_switch() does before promoting
> > > > > to backup slot, it checks for a NULL slot->addr, which is exactly
> > > > > what is missing from hazptr_detach.
> > > > > 
> > > > > With this in place there would be no need to explicitly check the
> > > > > hazptr_acquire() return value before calling hazptr_detach().
> > > > > 
> > > > > hazptr_release() has a early return check for NULL addr as well, so it
> > > > > makes sense that detach does an early return (no-op) similarly.
> > > > > 
> > > > 
> > > > You shall kill me for this!!
> > > > 
> > > > Could you perhaps do a splat in ze commit description pls?
> > > 
> > > The splat is available at the "Closes" URL below. I'm not sure whether
> > > we should duplicate this verbose information ?
> > > 
> > > Paul ?
> > 
> > I am fine either way, as long as the information is reasonably easily
> > accessible.  Which is the case either way.  ;-)
> 
> Then I favor a concise commit message, leaving the splat details to the
> "Closes" link. Feel free to pick up this patch for testing.
> 
> Thank you!

Done, thank you!  With this applied, the CPU-hotplug-related failures
are gone.  Or at least much lower probability.  ;-)

							Thanx, Paul
