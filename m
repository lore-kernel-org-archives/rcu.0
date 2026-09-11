Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9A3E867A;
	Fri, 11 Sep 2026 04:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789099671; cv=none; b=TErxnGWC0bFGCFG4Sd2izOmefhQP5X64+nTDbVHCE9+jEcLntsu8iHKegfTkPVAPL+ZK3byUqtOTe7BrPcCICROwx/uo50fdmrUCguASffih0LAHpvYR1zyWVlvU8QpaRX3F4YgRYHDyHDi2Ph4BqT70mVA7nRduG0y1g7djBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789099671; c=relaxed/simple;
	bh=wbgapqDhT4wUXtrMjMWkTOMlTyH3DqQ+/u4ZuXdvKWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRE4w5VlLP7dGY1DNJijcX+omfQVilpYf5PoupGVLZgZ7pI4lWw+iaMWWcOykwe3AvW0CzQfn0429HeENM6uFvT9MQg+7CQLLCRm73CsgarpWxlIbT4/G4MbymlS8NCuFI/sMqF/sXlceGoXQgAvyByRulpIiBbEVjJf0u+XVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlemSkOI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlemSkOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119CB1F000FF;
	Fri, 11 Sep 2026 04:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789099669;
	bh=n/g8ly4OxLyeREiUuSYEh2ixuq6wmXwe5ZXzyZhrmyg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=OlemSkOIqIP8ZwL7dV8e+hxx/mZCUn4P0zds8pnIXTNB8RYOMdtRc9yfZg0Ec5Bh5
	 J0iyJ1hNnZNUbeUqhLxgW5g3e6XDlpA8uW6Zcj1McDpRBrUxoRJvj471pXjkKt/Hlb
	 BZobLL3gvi1mj+P4Xk6g7TjVQJoS7HcndRyr2+G04+lJlF/SjIQtRsRXAXYnYfiGyU
	 Oz6g1Mn6kgKSIhicV1qqm4BevK0Nvc3UaJ2MNmHLIUiRrDZS5mJXH2x0GLeVVNuEfZ
	 252oOmYiVpaHeJ4oacEhoStMtMNXVL1fwc4cyzWllc2trXqfi1qlrvPZaTmveiwAyb
	 82doeal4nfdyQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D8974CE157A; Thu, 10 Sep 2026 21:07:48 -0700 (PDT)
Date: Thu, 10 Sep 2026 21:07:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcutree: Skip torture to-big transition for atomic SRCU
Message-ID: <21442bfe-ec4d-47bb-94e7-73b74aeae81e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260910041427.3579817-1-kunwu.chan@gmail.com>
 <8d55847a-9e4d-4f1e-95bc-4dc77bea73c3@paulmck-laptop>
 <CAN_Opa-jjwUOds2QqCbgozKjzYT=wzQV+k7ak0Wpk3Un78aq3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa-jjwUOds2QqCbgozKjzYT=wzQV+k7ak0Wpk3Un78aq3g@mail.gmail.com>

On Fri, Sep 11, 2026 at 10:12:37AM +0800, KunWu Chan wrote:
> On Fri, Sep 11, 2026 at 12:53 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Sep 10, 2026 at 12:14:27PM +0800, Kunwu Chan wrote:
> > > Atomic SRCU does not use the srcu_node combining tree.  Exclude it
> > > from the SRCU_SIZING_IS_TORTURE() transition in
> > > srcu_torture_stats_print().
> > >
> > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > > ---
> > >  kernel/rcu/srcutree.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index d462102c6bb6..99d11fb4123a 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -2421,7 +2421,7 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
> > >               }
> > >               pr_cont(" T(%ld,%ld)\n", s0, s1);
> > >       }
> > > -     if (SRCU_SIZING_IS_TORTURE())
> > > +     if (SRCU_SIZING_IS_TORTURE() && ssp->srcu_reader_flavor != SRCU_READ_FLAVOR_ATOMIC)
> > >               srcu_transition_to_big(ssp);
> > >  }
> >
> > Much better, thank you!
> >
> > Could you also please add an "else" clause with a WARN_ON_ONCE()
> > for ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC?
> >
> > This is after all a user error where someone said to torture atomic SRCU
> > but also said to transition to big.
> 
> Thanks, Paul.
> Agreed. I'll add the warning in the next version:
> if (SRCU_SIZING_IS_TORTURE()) {
>         if (WARN_ON_ONCE(ssp->srcu_reader_flavor ==
>                          SRCU_READ_FLAVOR_ATOMIC))
>                 return;
>         srcu_transition_to_big(ssp);
> }
> 
> This keeps atomic SRCU out of the to-big transition while exposing
> the invalid torture configuration.

Again, sounds good!

							Thanx, Paul

> Thanks,
> Kunwu
> 
> >
> >                                                         Thanx, Paul
> >
> > >  EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
> > > --
> > > 2.43.0
> > >
