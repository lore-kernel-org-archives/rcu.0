Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD8149E0E
	for <rcu@vger.kernel.org>; Sun, 18 Aug 2024 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000503; cv=none; b=kIA3HTSUlJxSoYmWawL+lamyA0PZeFW1gWkjSLmDN70nINofjMUogwYkjCnuYbBmpp3ZnDLpyjUemi1MXnwLmm6P0i6JeY3emZD8MWiO8zolMaE52O1EAFdpOTYeLe6BoH836F0TtnQp3OjktuSffHXFk63YB1eAG/+XCmX+w/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000503; c=relaxed/simple;
	bh=5x2uLXHm/kroUCrwZLUMvB216xWYqX1m9KkTbW6leQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lplzFHlfZYHXE33coYMxXEt9ALvxyJzECfVrpmWs+gZPSv0dHQOfPLCDzNVmQ6JY7+ks6VO8mQhsPwJVamN46379nLZZch17kjb+nGS2/GxtQ7qMSfZ95ir9Ne8EdICQc8+J69tk6JUVqx8LHoO35q/gu+RfwgQ9dAgmrGUBqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPGXrpz2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPGXrpz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F332C4AF0C;
	Sun, 18 Aug 2024 17:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724000503;
	bh=5x2uLXHm/kroUCrwZLUMvB216xWYqX1m9KkTbW6leQA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fPGXrpz2Nm+KyKRQb2rk9Uf4N8nPhBKohNnWTvLn/MNJpeWCV1tq1t9B17Q7ne0MS
	 wd3TZQ1KgkzMVfhYakFq5PSYL5T7I0WFZ2c4cZshADGXlzbsI9qPcYLMMgdEciP7xJ
	 MrbLateBxR1zGjHwXNhMO06XPu29XysfkxY+qZXoNvxjfkHGiFtDt8iUBdp0vvUVXM
	 oX9kACWsYyFSxgpAsYLJ7IvDJbnXvy2mL44eVs29CT5u1wzKmIrTQVzKFIAEhpcfJS
	 tfckYSKAGorqIq5o+/VzZWtygMg4xAGiXHr1k2T0AwTPJpMpcVh1LvDVY+ZCGnbpiq
	 zfbLmcJ9084kg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CFBEFCE0DFD; Sun, 18 Aug 2024 10:01:42 -0700 (PDT)
Date: Sun, 18 Aug 2024 10:01:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <b1ea0a2a-23c1-41db-a446-318e1eb7c429@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cqs6e6daupkzbjphltpbo5ljwut2lteji2ips3rpihlak5yjbp@im5ksmjjsrh6>
 <w52nycocowsq7jiay3ybhpsy4h6bl6t6nqew4wk2dolzvn5mql@rv3nffcb7q7q>
 <7da0d749-e482-402e-9241-6c7d5f29e39a@paulmck-laptop>
 <lqtvpxcnp3mfs5pmaawfvfrcnz2vla7hfedgzec2louaxypjex@o6qzbt7snxoq>
 <617a8c07-4e26-4cf7-a263-552cfa070956@paulmck-laptop>
 <us7xrey4xz6zxou4u64bsebthodqzl33zrdo3pdgmf33q2bgjt@abf6a6c5x7ar>
 <11b7a42a-a11d-4efd-926d-1777f9e210a8@paulmck-laptop>
 <43crql5tqt2d7a65qxtaowpritjvvzoe72spvnb3temas33q5a@6qvk2an743wh>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43crql5tqt2d7a65qxtaowpritjvvzoe72spvnb3temas33q5a@6qvk2an743wh>

On Sun, Aug 18, 2024 at 12:10:26AM -0400, Kent Overstreet wrote:
> On Fri, Aug 16, 2024 at 01:33:30PM GMT, Paul E. McKenney wrote:
> > On Thu, Aug 15, 2024 at 11:20:09AM -0400, Kent Overstreet wrote:
> > > On Thu, Aug 15, 2024 at 08:13:10AM GMT, Paul E. McKenney wrote:
> > > > On Thu, Aug 15, 2024 at 10:58:37AM -0400, Kent Overstreet wrote:
> > > > > start_poll_synchronize_rcu_common() requires that irqs are enabled
> > > > > 
> > > > > that doesn't match call_rcu() requirements, so - can we lift that
> > > > > requirement? I need to be able to make sure the grace period is
> > > > > started...
> > > > 
> > > > I have to awaken the grace-period kthread, and wakeups are no longer
> > > > possible when interrrupts are hard-disabled.
> > > 
> > > Err, what? How do we get anything done when IRQs are hard disabled,
> > > then?
> > 
> > Good point, I was confused.  I will try it and see what happens.
> > Perhaps you have already done so?
> 
> >From a cursory glance at the test dashboard, it looks good :)
> 
> I was hesitant at first because... that's not a normal wakeup, but I
> read through it more and I think it's safe.

It is the same wakeup used by call_rcu(), so if it is safe there, it
should be safe here.  ;-)

> > Hey, you are the one who sent me a private query while I am on vacation!
> > Kidding aside, CCing rcu@vger.kernel.org gives others in a variety
> > of timezones a chance to help out.
> > 
> > > > Another approach is to replace that start_poll_synchronize_rcu() or
> > > > start_poll_synchronize_rcu_full() with a get_state_synchronize_rcu()
> > > > followed by a "throw-away" call_rcu(), that is, one whose callback
> > > > function does nothing.  Would that work for you?
> > > 
> > > Maybe? If call_rcu() then skips adding the entry to the list of pending
> > > callbacks (which it would have to, we're not going to get the
> > > notification when the rcu_head is completed) so that we can reuse it
> > > right away for the next gp, then that should work...
> > 
> > OK, OK, "does almost nothing".  ;-)
> > 
> > Yes, you would need a small state machine to rearm if there was a
> > subsequent start-poll call and so on.
> > 
> > But does your (almost) unconditionally rearming callback have some
> > purpose other than to work around start_poll_synchronize_rcu_common()
> > currently giving lockdep splats when invoked with irqs disabled?
> 
> Yes, processing pending items - so it would be ideal to get a callback
> for every grace period we have items for, though not strictly necessary
> for a v1.
> 
> But as mentioned previously, the issue is that since RCU callbacks may
> be punted to a kthread (correct?) - we'd need memory for an unbounded
> number of pending callbacks, which doesn't work here; we don't have a
> way of handling that allocation failure.

But you only need one callback per live outstanding "cookie" returned
from get_state_synchronize_rcu*() or start_poll_synchronize_rcu().
Or am I missing something here?

If so, create a structure that as an rcu_head structure and a
cookies.  Create an array of this structure (possibly on a per-CPU,
per-shard, or whatever basis), sized by NUM_ACTIVE_RCU_POLL_OLDSTATE or
NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE, depending on which set of APIs you
are using.  Have a lock that guards the full array.

You also need some sort of structure tracking whatever data elements
for which the grace periods are intended, but I will not speculate
on what that might be.

Then when you have a data element that needs to wait for a grace period:

1.	Get a cookie from get_state_synchronize_rcu() or similar.

2.	Acquire the lock.

3.	If this cookie is already in the array, release the lock and
	you are done.  (Give or take associating the cookie with the
	data element, however you choose to do this.)

4.	If this cookie has already expired (it can happen!), set the new
	data element up to be processed (or maybe process it immediately,
	as the case may be).  Proceed to the next step only for unexpired
	new cookies, otherwise, release the lock.

5.	Otherwise, at least one of the array elements must have an expired
	cookie.  Find the first such array element, perhaps already having
	done so when looking for the cookie.

6.	If needed, do whatever is necessary to mark the data elements
	that are associated with that expired cookie.  (Their grace
	period has expired, so maybe they just get processed immediately.)

7.	Store the new cookie into the array element.

8.	Invoke call_rcu() on the rcu_head in the current array element.

9.	Release the lock.

When a given callback is invoked:

1.	Acquire the lock.

2.	Find the array element given the rcu_head pointer passed in to
	the callback function.

3.	If the cookie has expired, set the corresponding data elements
	up to be processed (or, again, maybe process them immediately).
	Set the cookie to get_completed_synchronize_rcu() or similar
	to make sure that the array element's cookie stays expired.
	(32-bit systems and all that...)

4.	Otherwise, the cookie has not already expired, indicating that
	steps 5-9 above already did this callback's work for it and gave
	it some more work to do.  Therefore, requeue the callback.

5.	Release the lock.

Or am I missing something that needs to be done here?

> Long term, I think it would be a worthy goal if this code could be used
> for tracking RCU callbacks, so as to eliminate the linked lists overhead
> in processing them. 

The data elements are presumably already in some other structure?

> For that to happen, we'd need a different way of getting notified when
> grace periods elapse, so maybe we could kill two birds with one stone on
> that one.

I believe that the setup that I described above would suffice, but it
is quite possible that I am missing a subtlety in there somewhere.

Thoughts?

							Thanx, Paul
