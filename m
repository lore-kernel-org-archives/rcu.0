Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8C33CD1;
	Fri, 30 Aug 2024 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725044487; cv=none; b=KyLfFug/lalo+lcK8K8OBN5Ee7jBxJyAozEKBxLKKli18fjEtDXevlqOzrNzbCNc/gIYmCBZa90debjiI2eBTiFW78WRNmTOLF71rpUJ0dua/349xAI4GOEqulRcQ2zyBa0cWmKANdJI2VETptoh1Oq4lNdGJcIMJsmRexzOzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725044487; c=relaxed/simple;
	bh=KfVE6P8urjsnp6ddpaVy6aYisx5jn6Zrub0+Da8TYP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saUqpitvzVwh3p8r5h8hwh7UZpC8+ir7VUD+472LHMj0P2m5NtJ71KQ1VuOCs7nR2HQYtHZDEySKUTf0zapsGYdcbPW5tOvhUpP7XpmdvPr7fbuQdTUoFXfVxwQPPj7Kyj5cqMw3cXFtKiP/t4kkTRs9T58phBakyhTNrQ1V5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfwyXnnQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfwyXnnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FC4C4CEC2;
	Fri, 30 Aug 2024 19:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725044487;
	bh=KfVE6P8urjsnp6ddpaVy6aYisx5jn6Zrub0+Da8TYP4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NfwyXnnQyzGm1mW0InEIA+pwxUksxisfHTt0nbofNzrUEqn8YbwrPG2szu+mTjtVD
	 JF1rtvmesRjgfMkG33RTfNwVsQwg5zSoxVVrMFHWhrqrClMm5xYgKVCV4YpIcxAk/A
	 K+Rn4ogo2JI7ewD4T8fbQnPRaJhgNEUql9NxsCFZzOBYDI6e4CQgI6q6hyQGxZY8Lo
	 D/TOv3XgkZJgbKsATUGW3ZWa1xDpFao85QHNo/y266hn7kh0uZFCKi6WmrzuKIsVgR
	 VeqWLkMjQCjtPf/p6wYAv2BfiotRPh2szowQOUZxxKYr3bjVVpdoVC63KWkYl9ubhm
	 xXKEgFa4XjH1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CF3C5CE114C; Fri, 30 Aug 2024 12:01:26 -0700 (PDT)
Date: Fri, 30 Aug 2024 12:01:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
	akpm@linux-foundation.org, cl@linux.com, mhocko@kernel.org,
	urezki@gmail.com, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH 6/9] rcu: rcu_pending
Message-ID: <ab35ac12-23ac-40a1-b98b-5b4d91ec44b9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
 <20240819165939.745801-7-kent.overstreet@linux.dev>
 <adc8b09e-5f66-44de-845b-e615069c2e20@paulmck-laptop>
 <yfhctftdn4itupt735u7dnu2zt2aarm3lzvmyf6bs7hkv4radc@ndw4nsinxhqx>
 <f7266ab4-aa29-4cbc-a63e-fa582e266864@paulmck-laptop>
 <4zkfyn2shwot2zxiahn7zt7k2gpnoavyrldzzwo23qqxr6fvfh@xqlz4vehkln5>
 <4e4a5c89-e9ec-421e-8245-f076044866c9@paulmck-laptop>
 <gqgocomsljkn5sw2jvm432peesjuclfjwd2sasec3kg6tofk5t@ry7rkoo2auek>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gqgocomsljkn5sw2jvm432peesjuclfjwd2sasec3kg6tofk5t@ry7rkoo2auek>

On Mon, Aug 26, 2024 at 01:09:15PM -0400, Kent Overstreet wrote:
> On Mon, Aug 26, 2024 at 09:01:54AM GMT, Paul E. McKenney wrote:
> > But get_state_synchronize_srcu() is still a function call.  But the
> > offer of a function that checks multiple grace-period-state cookies in
> > one call still stands.
> 
> It shouldn't be though, it's just reading a sequence number - I'd much
> prefer if it could be at least a static inline.
> 
> Which you won't want to do, because it would mean exposing RCU private
> data structures; hence my approach of exposing an RCU-only api for
> getting a pointer to the sequence number.

True enough.

In addition, I have not yet been able to come up with any safe use of
this sequence number that does not require memory ordering.  And -that-
I most emphatically won't want to export to the caller.

Hence my offer of a function taking multiple grace-period-state cookies
in one go, allowing the memory-ordering overhead to be amortized over
the set of cookies.

> > > In my current version of the code, we call __get_state_synchronize_rcu()
> > > after we've disabled interrupts; we know the rcu gp seq isn't going to
> > > tick while we're in the critical path. But this doesn't apply if it's
> > > for SRCU, and I don't want to add if (src) srcu_read_lock() branches to
> > > it.
> > 
> > Actually, disabling interrupts does *not* prevent RCU's grace-period 
> > sequence number from changing.  For example, the following really can
> > happen:
> > 
> > o	RCU notices that the current grace period can end.
> > 
> > o	A CPU disables interrupts here.
> > 
> > o	A call to get_state_synchronize_rcu() returns a cookie
> > 	corresponding to the end of the grace period following the
> > 	current one.
> > 
> > o	RCU ends the current grace period, therefore updating the
> > 	grace-period sequence number.
> > 
> > o	RCU starts a new grace period, therefore updating the
> > 	grace-period sequence number once again.
> > 
> > o	RCU cannot complete this new grace period until that CPU
> > 	re-enables interrupts, but it has already updated its grace-period
> > 	sequence number not once, but twice.
> > 
> > So if your code knows that RCU's grace-period sequence number cannot
> > change while a given CPU has interrupts disabled, that code has a bug.
> > A low-probability bug, perhaps, but if your code is running on enough
> > systems, it will make its presence known.
> 
> Ok, good to know
> 
> > > Not at all essential, the races that result from this are harmless, but
> > > if we e.g. decide it's worthwhile to only kick off a gp if it hasn't
> > > ticked (i.e. only kick rcu if we're still on seq of the object being
> > > enqueued) it'd be nice.
> > 
> > Why not call get_state_synchronize_rcu(), and ask for a new grace period
> > if the value returned is different than that from the previous call?
> 
> We don't want to falsely think the object expires later than it actually
> does, and have more accumulated work than we need to.

Yes, that can happen, but grace periods are long and that race window
will normally be very short.  It will not matter in actual practice.

> > > Funny, I had the same thoughts trying to read your code... :)
> > 
> > Amazing how much easier it is to generate new code than to understand
> > existing code, isn't it?  ;-)
> 
> I would have much preferred if your existing code worked with SRCU. You
> think I'm doing this for fun?

To be fair, the "for fun" reason seemed to me to be one of the more
positive explanations for your providing an unsolicited rip-and-replace
patch for kfree_rcu() without prior consultation. ;-)

But, to your point, why haven't we already implemented kfree_srcu()?

Because in v6.10, there are six use cases for it, and they appear to have
infrequent updates.  Thus, kfree_srcu() is not yet not worth its weight.

> > > > Plus, unlike kfree_rcu() post-grace-period handling, call_rcu() callback
> > > > functions usually access the memory block passed to them, which means
> > > > that they are incurring that per-element cache miss in any case.
> > > 
> > > True. But this would allow us to prefetch those objects (several
> > > iterations in advance).
> > 
> > I need to see a CPU on which this actually make a significant difference
> > before adding this sort of complexity.
> 
> We would of course want benchmarks to show that this was worthwhile
> before switching call_rcu(), since absent a performance improvement we'd
> want to stick with the approach that doesn't allocate memory.

Agreed.

Furthermore, any approach that does allocate memory needs a non-allocating
fallback.  Out-of-memory deadlocks are not fun.

> > > Just processing a few items? hmm, would we want to though, when
> > > otherwise we'd be calling kfree_bulk()? I think icache locality means
> > > we'd generally prefer not to.
> > 
> > You might not want to yet, but you eventually would want this.
> 
> Because?

TL;DR:  Lessons learned from bitter experience.

For more detail, please read on.

Because certain inconvenient laws of physics (and I am looking at *you*,
finite speed of light and atomic nature of matter!) mean that global
agreement across a computer system is expensive.  This is especially
a problem if synchronous global agreement is required, which is one
reason why reader-writer locking is so slow, one way or another.
(You can either make readers slow or you can make updaters *really* slow.)

RCU does not completely avoid the cost of global agreement.  After all,
at the end of a grace period, there must be global agreement that all
pre-existing readers have completed.  But the computation of that global
agreement can be (and is) spread over time.  This spreading has two
good effects: First, it permits CPUs and tasks to use lighter-weight
operations for high-frequency operations such as rcu_read_lock(), and
second, the grace-period requests that arrived during one grace-period
computation can all be satisfied by the next grace-period computation,
in turn permitting the overhead of that next computation to be amortized
over all those requests.  Which is one reason why grace periods are not
unconditionally expedited.

But it is all high-amortization fun and games only until there is risk
of exhausting memory.  At that point, RCU takes steps to expedite
the current grace period, albeit in a light-weight fashion compared
to synchronize_rcu_expedited().  It has proven unwise to wait for mm
to complain to RCU (for example, via a shrinker), so RCU does this
lightweight expediting using heuristics based on the number and rate of
callbacks on each CPU.  And yes, RCU also uses shrinkers, just not as
the first line of defense.

So why don't we have such heuristics in SRCU?

Because SRCU has not yet been subjected to workloads that flood SRCU with
callbacks, so it has not yet proven necessary.  Obviously, should SRCU
start getting flooded, SRCU will start taking whatever forms of evasive
action are indicated by the situation at hand, quite likely including
expediting the current SRCU grace period.

Until that time, we keep it simple.  Or simpler, anyway.

							Thanx, Paul
