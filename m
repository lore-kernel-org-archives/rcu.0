Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D01804E
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039580; cv=none; b=fhw5MIZV3PVB9wCJPsEc1VebrxwhKL7YCWohQoxAjX0JD7vkCa7MM6keu/oxDKAlzXKRGqju1h2929MnKPZKH6T5ePGreLLHs78EXodUMnJqXy2L/ay2sUnkC6orzAWwsEdprP9CoR+TGU/VF05AlZx6Wn+VNVjvgXbs9aDjsfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039580; c=relaxed/simple;
	bh=bmRoyZZr4q924iDoEgmbd+xaz/zhk5Lw+GRSOHwrqLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EL2+3TQdffjvgyJ8qni8x0+UItCBxuKSBymmf2RxXjpoPuvvbPEdOTy4Zc2wu91IDOGG2PYkpiO/XVTQaqCymk74OUR8+z/AYMiGgkRwOV605IiP5/6V9/kSvLD9/D6wBKT20PLnudaasoeWyPCvEcq3GVfp0mfwIcVhFtIW52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpZMU530; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpZMU530"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08436C32782;
	Mon, 19 Aug 2024 03:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724039580;
	bh=bmRoyZZr4q924iDoEgmbd+xaz/zhk5Lw+GRSOHwrqLs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GpZMU530+qdZMqJAovXIGvwZOuUUKHY7iJ/m9lQlCNcfUbd4S7FZr9dXPqz5X5Dsq
	 W4fgEMFoWtTe+1LYbScfyZb3YCV8VoMn2j6wObs+BM1u1hH4Rvl6byr2aOXodBa4NP
	 Siw721RC8cxVAtycpU4HOp0m/od7VCimXqqaD5lUac+us65i1jkvBTkzcftouybPMd
	 TR2dMSsveDOiz/UY4imHPynjp/RVcSojkBfANv5YERiqZavbfqLsDiUkpQ2OBMlJvG
	 Rw+8nWLekIX8MHeNxYm5F7ApDL2eWIj9r+NVCJmOpKZBIoRCtGt8be4Iejgbo5zHOk
	 ddo7U5arQkRDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9BFC1CE0B09; Sun, 18 Aug 2024 20:52:59 -0700 (PDT)
Date: Sun, 18 Aug 2024 20:52:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <abc36602-20bb-4a52-b5f5-01c044700c50@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cqs6e6daupkzbjphltpbo5ljwut2lteji2ips3rpihlak5yjbp@im5ksmjjsrh6>
 <w52nycocowsq7jiay3ybhpsy4h6bl6t6nqew4wk2dolzvn5mql@rv3nffcb7q7q>
 <7da0d749-e482-402e-9241-6c7d5f29e39a@paulmck-laptop>
 <lqtvpxcnp3mfs5pmaawfvfrcnz2vla7hfedgzec2louaxypjex@o6qzbt7snxoq>
 <617a8c07-4e26-4cf7-a263-552cfa070956@paulmck-laptop>
 <us7xrey4xz6zxou4u64bsebthodqzl33zrdo3pdgmf33q2bgjt@abf6a6c5x7ar>
 <11b7a42a-a11d-4efd-926d-1777f9e210a8@paulmck-laptop>
 <43crql5tqt2d7a65qxtaowpritjvvzoe72spvnb3temas33q5a@6qvk2an743wh>
 <b1ea0a2a-23c1-41db-a446-318e1eb7c429@paulmck-laptop>
 <6loibv4dmpwxbgavh3p2h2edf4hdyglmakxt6pvzoajdwnyypp@b4jrv7vyi3bl>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6loibv4dmpwxbgavh3p2h2edf4hdyglmakxt6pvzoajdwnyypp@b4jrv7vyi3bl>

On Sun, Aug 18, 2024 at 09:19:16PM -0400, Kent Overstreet wrote:
> On Sun, Aug 18, 2024 at 10:01:42AM GMT, Paul E. McKenney wrote:
> > But you only need one callback per live outstanding "cookie" returned
> > from get_state_synchronize_rcu*() or start_poll_synchronize_rcu().
> > Or am I missing something here?
> 
> Maybe I am?
> 
> I've been assuming that if rcu callbacks are getting punted off to a
> kthread that we can't rely on them being completed in any particular
> timeframe - i.e. the number of grace periods with outstanding callbacks
> would be unbounded.

Exactly, and that is why there is a check for expired cookies during the
addition of a new data element that needs to wait for a grace period.
The only purpose of that call_rcu() callback is to act as a fallback in
case there is a long period of time with no newly arriving data elements
that need to wait for a grace period.

> You're saying that NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE _does_ include
> grace periods with outstanding callbacks? Just want to be clear on that.

No, it does not, but given the algorithm outlined in my previous
email, it doesn't need to.  The point of the callbacks is *not* to
unconditionally drive things forward, but instead to provide a fallback
to do the necessary processing in the case nothing new arrives for an
extended period of time.

> > If so, create a structure that as an rcu_head structure and a
> > cookies.  Create an array of this structure (possibly on a per-CPU,
> > per-shard, or whatever basis), sized by NUM_ACTIVE_RCU_POLL_OLDSTATE or
> > NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE, depending on which set of APIs you
> > are using.  Have a lock that guards the full array.
> > 
> > You also need some sort of structure tracking whatever data elements
> > for which the grace periods are intended, but I will not speculate
> > on what that might be.
> > 
> > Then when you have a data element that needs to wait for a grace period:
> > 
> > 1.	Get a cookie from get_state_synchronize_rcu() or similar.
> > 
> > 2.	Acquire the lock.
> > 
> > 3.	If this cookie is already in the array, release the lock and
> > 	you are done.  (Give or take associating the cookie with the
> > 	data element, however you choose to do this.)
> > 
> > 4.	If this cookie has already expired (it can happen!), set the new
> > 	data element up to be processed (or maybe process it immediately,
> > 	as the case may be).  Proceed to the next step only for unexpired
> > 	new cookies, otherwise, release the lock.
> 
> There's another race, though - we're associating sequence numbers from
> get_state_synchrize_rcu() with call_rcu() callbacks, and that's racy -
> they can end up with different grace periods...

Indeed they can end up with different grace periods, and that is just
fine.  Remember, the call_rcu() callbacks are a fallback mechanism in case
of a cessation of new data elements arriving in need of grace periods.
If there is a constant stream of such data elements, the call_rcu()
callback will (almost) always find that its array element has not yet
expired (because some intervening data element overwrote the expired
cookie with a new unexpired cookie), and will thus simply invoke
call_rcu() on itself.

> I think solving that would require a call_rcu_for_gp() API that takes
> the sequence number we previously got from get_state_synchronize_rcu().

You don't need this because this race is harmless.

> I think we can avoid your race in #4 entirely by simply waiting until we
> have irqs disabled to call get_state_synchronize_rcu() (at least for the
> normal RCU variant, the SRCU variant will naturally need a
> srcu_read_lock() if we want to handle it that way).
> 
> That might be beneficial because then call_rcu_for_gp() can never race
> with the grace period expiring.

Except that we don't need to avoid that race.

Or am I missing something subtle here?

							Thanx, Paul
