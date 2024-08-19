Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E552F2B
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724042428; cv=none; b=RMgCIiAYVB5hzj8AIvebmzxl86XaoEhLZVl9KzhMnNUEELYLB/WBAywimEc9aHB5AEWMyAD1y2u1pfl6ZcxBU4fjw2rBv5h50kXt4nhIpzsYiqsAB1A76+yBDCteRny0Cl/35JWF+7ssydZjsiroeAN6RYLo4TlGQt6UFBwwisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724042428; c=relaxed/simple;
	bh=+f2jFH5PoSUBb5KC3QNR9r/KY2Q4r8ifztt/CGu/EtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+rdpUSYqi88NFq2EjBYLF5YEvCcWVjLr3eE8U90L32BeqhdB1eP71/Pi/RnIWoqXK9ZrCOScZUcjgTh4SvtpgWa2kpWGlYGbcglzFRjD6vrXAPut/12PxRcUkIJ6DSGhQsIS6Uj96Ws6y1Qa5ygcPP+B2WiZwIN9ymPk+G+vYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt45jIeV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt45jIeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5082DC32782;
	Mon, 19 Aug 2024 04:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724042428;
	bh=+f2jFH5PoSUBb5KC3QNR9r/KY2Q4r8ifztt/CGu/EtU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mt45jIeVIGbd8ndkDwgm/g/8MSF/THJFdq09KZudWHj1Lw7XZFBlE7kr5C1OW35dx
	 CvWuMAzupPY/XPRwr4Dx0GHWxyKyAV8ZTuDDM3L9B1HIJkFwrf+gFntFrPAhFBGE32
	 w06Ianm0SshhWpOJfVdKDTKtXZt51Zr+OpPB8mwXMjx47BsUlHYAEUsITbM1pON2g5
	 U0F8yN2P8h02EWR8+33glAuYRlXG4QBxgv+iX23KjIANnPWlqz0lnehXrOpjocLL7/
	 2YodRoe6r9OnaJrr0gseLsVYQfqLhMJ7Mf6f/h6iLda/yqWgFNYyrTRDiHIPyZp41n
	 jc7f7hzY38edw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E46E3CE0B09; Sun, 18 Aug 2024 21:40:27 -0700 (PDT)
Date: Sun, 18 Aug 2024 21:40:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <f4c5bf95-da88-4633-ac9f-a626fdc332e4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7da0d749-e482-402e-9241-6c7d5f29e39a@paulmck-laptop>
 <lqtvpxcnp3mfs5pmaawfvfrcnz2vla7hfedgzec2louaxypjex@o6qzbt7snxoq>
 <617a8c07-4e26-4cf7-a263-552cfa070956@paulmck-laptop>
 <us7xrey4xz6zxou4u64bsebthodqzl33zrdo3pdgmf33q2bgjt@abf6a6c5x7ar>
 <11b7a42a-a11d-4efd-926d-1777f9e210a8@paulmck-laptop>
 <43crql5tqt2d7a65qxtaowpritjvvzoe72spvnb3temas33q5a@6qvk2an743wh>
 <b1ea0a2a-23c1-41db-a446-318e1eb7c429@paulmck-laptop>
 <6loibv4dmpwxbgavh3p2h2edf4hdyglmakxt6pvzoajdwnyypp@b4jrv7vyi3bl>
 <abc36602-20bb-4a52-b5f5-01c044700c50@paulmck-laptop>
 <a7zb6g6dgmm5hhkhw22u7lhbsgel2w3ntcaggoqoeblethx53l@uxef6ex25xwy>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7zb6g6dgmm5hhkhw22u7lhbsgel2w3ntcaggoqoeblethx53l@uxef6ex25xwy>

On Mon, Aug 19, 2024 at 12:16:42AM -0400, Kent Overstreet wrote:
> On Sun, Aug 18, 2024 at 08:52:59PM GMT, Paul E. McKenney wrote:
> > On Sun, Aug 18, 2024 at 09:19:16PM -0400, Kent Overstreet wrote:
> > > On Sun, Aug 18, 2024 at 10:01:42AM GMT, Paul E. McKenney wrote:
> > > > But you only need one callback per live outstanding "cookie" returned
> > > > from get_state_synchronize_rcu*() or start_poll_synchronize_rcu().
> > > > Or am I missing something here?
> > > 
> > > Maybe I am?
> > > 
> > > I've been assuming that if rcu callbacks are getting punted off to a
> > > kthread that we can't rely on them being completed in any particular
> > > timeframe - i.e. the number of grace periods with outstanding callbacks
> > > would be unbounded.
> > 
> > Exactly, and that is why there is a check for expired cookies during the
> > addition of a new data element that needs to wait for a grace period.
> > The only purpose of that call_rcu() callback is to act as a fallback in
> > case there is a long period of time with no newly arriving data elements
> > that need to wait for a grace period.
> > 
> > > You're saying that NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE _does_ include
> > > grace periods with outstanding callbacks? Just want to be clear on that.
> > 
> > No, it does not, but given the algorithm outlined in my previous
> > email, it doesn't need to.  The point of the callbacks is *not* to
> > unconditionally drive things forward, but instead to provide a fallback
> > to do the necessary processing in the case nothing new arrives for an
> > extended period of time.
> 
> You can't use a fixed number of callback heads if there's going to be an
> unbounded number of callback heads outstanding.

The number of rcu_head structures is your choice, based on your choice
of data structure.  You can for example link together data elements that
have the same value of get_state_synchronize_rcu() cookie, and use a
single rcu_head structure for that group.  You could then do whatever
you want for the linking.

But even if you do choose to have a large number of rcu_head structures,
perhaps one per data element, there is no law saying that each and every
one of them needs to be passed to call_rcu().  For example, kfree_rcu()
requires an rcu_head structure in the objects passed to it, but in the
common (non-OOM) case, those structures go unused in favor of pages
of pointers.

So what were you really trying to get across to me here?

							Thanx, Paul
