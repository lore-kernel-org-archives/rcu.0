Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C923B05BC;
	Fri, 11 Sep 2026 04:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789099622; cv=none; b=r0KrIDfMphBlWkWNQM2/uti2G8Ngez+cpMjcAoWq4O+GeqI9ENVfyVF0Kf1rHFe/L3i9tFZGD/yC0X5Ze7mQyOKoroAedzPKaS8ARkKoVpElonGiVqhaHam3cehrXNUQEEzOa5xfTo1vFgGMZoNJCZFidrA8paeJq+5KwNnc9Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789099622; c=relaxed/simple;
	bh=2w+nxZMaymHIbHfOL5y5/ASn0HihPMGfJ9QEL0BeZb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFeiriVUmO0Zq8v8r1hXuf07yGERVQ/DEFhuN0etZ46IxWBKDCWRvv2UKqptTJCwDPRN40C7PJ9QJytKbDFZLi8IYSwT2+uJSjl2PK4odiQLWJGPzgj9z4bHvoWqTnpoiq5IbBIizvoy9uTds47K0BEZzOIjaVvWuthU90sQ8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXc7B4ar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXc7B4ar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E01A1F000FF;
	Fri, 11 Sep 2026 04:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789099620;
	bh=2PcDT+PMPmPDLuTC1DqX4YBtp96s8KgMt+vlAfga/kI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=LXc7B4arMjwlFRxTZ0pxYn8fHXJT3Z3N8wV4ZoORQ4nmhOSj57ywurIhd04mQN0k5
	 JB/A5AkLI77RYvku9gQtjcE82nNSCHwEYRLiygFXbC8X6UyAdyVsg6RrKr1inoF1cS
	 /3Y9LDgA1kvENsshU86UGiWh5+hBzMx97sbx663FV+SpYHf/CJUk9Mv5WDUTK/O/Gq
	 hGu3jf3xwoSxLAJ08Y6QN8eqIjpMyj7Y1EK6C1e0UWmDHFlI1kBT0FyfH4JXBnaLb4
	 Od6XK7RCeRSgEYiF5FoUJ6GfgztqRKR5IMUPS6Fg7/NKYKicQXtobcQ4UDQR1T/qmM
	 Y7X3a6JmnNGnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D694BCE157A; Thu, 10 Sep 2026 21:06:59 -0700 (PDT)
Date: Thu, 10 Sep 2026 21:06:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] srcutree: Add WARN_ON_ONCE() for atomic SRCU in
 srcu_gp_end()
Message-ID: <de04ba08-c7bb-4aa6-bf9d-8df75e400f0c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260910084629.3695383-1-kunwu.chan@gmail.com>
 <d1bf830e-8755-4eef-a8f6-35612640a478@paulmck-laptop>
 <CAN_Opa_X1Gq4DxMhZvM_8XPg96Anw6UWW2EnndtVJ6vPYKE0YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa_X1Gq4DxMhZvM_8XPg96Anw6UWW2EnndtVJ6vPYKE0YQ@mail.gmail.com>

On Fri, Sep 11, 2026 at 09:50:09AM +0800, KunWu Chan wrote:
> On Fri, Sep 11, 2026 at 12:58 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Sep 10, 2026 at 04:46:29PM +0800, Kunwu Chan wrote:
> > > Atomic SRCU remain in the small size state, so add a
> > > WARN_ON_ONCE() before the transition check to catch any future
> > > code path that might violate this invariant.
> > >
> > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > > ---
> > > Changes since v1:
> > > - Drop the !is_atomic guard from v1 and add WARN_ON_ONCE() instead,
> > >   per Paul McKenney's suggestion.
> > > - v1: https://lore.kernel.org/rcu/20260907075829.2073224-8-kunwu.chan@linux.dev/
> > > ---
> > >  kernel/rcu/srcutree.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 84c022ec8e09..68441c32cebf 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1074,6 +1074,8 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
> > >       }
> > >
> > >       /* Transition to big if needed. */
> > > +     WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC &&
> > > +                     ss_state != SRCU_SIZE_SMALL);
> >
> > Also much better, but we also need to avoid doing the transition in this
> > case, because doing that transition breaks atomic SRCU.  On way to make
> > this happen is something like this:
> >
> >         if (ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC && ss_state != SRCU_SIZE_SMALL) {
> >                 WARN_ON_ONCE(1);
> >         } else if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
> >                 if (ss_state == SRCU_SIZE_ALLOC)
> >                         init_srcu_struct_nodes(ssp, GFP_KERNEL);
> >
> 
> Thanks, Paul. Good point. The original !is_atomic guard in v1
> already prevented the transition for atomic SRCU. I was mainly
> thinking of the WARN as a diagnostic, since this state should not
> occur with the current code. I agree that retaining the protection
> against the transition is safer if the invariant is ever violated.
> 
> > Other approaches might take advantage of the fact that WARN_ON_ONCE()
> > returns the value of its argument, allowing WARN_ON_ONCE() to be used
> > as a condition in an "if" statement.
> >
> 
> I prefer the first approach. Using !WARN_ON_ONCE() directly in the
> existing condition would make it rather long and less readable,
> while the explicit if/else keeps the control flow clear.

Very good, looking forward to seeing what you come up with.

							Thanx, Paul

> Thanks,
> Kunwu
> 
> >                                                         Thanx, Paul
> >
> > >       if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
> > >               if (ss_state == SRCU_SIZE_ALLOC)
> > >                       init_srcu_struct_nodes(ssp, GFP_KERNEL);
> > > --
> > > 2.43.0
> > >
