Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F939B481;
	Thu, 10 Sep 2026 03:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011962; cv=none; b=QngRH1/DxVTO/nQBXi/mqVSA7nNhmtRzCiHgjDa7D6bO71hKIv4ZoK88Q15NwypkVEpNekvRQ0dfDdCGZ4m9RxYeJi0lt3qaPB+Nqo9H3fZZaz7FtYIcSqKKp0sGWfjqQKpfjRjPB+7orrMB5yPHqZMVzIibccY5Py0QnuOVP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011962; c=relaxed/simple;
	bh=Ws19YNdv+Yum8ONz6b914ToYU5CeaB8UzRzPqCWkg2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/DxUL2pOX84gDQPuE0n74zqIvO593oy2Ha5hoZWwjO5gi7htsp2vw/hFtI60ygpI3i7ByTlXL6Wzgmy2CQcz3M3AHMO/frYgshyuZbpvOJxQpCE14f3osCxfiaL4l2fGIssLZ1SMf3+s2P5+7L0s5+pNbpxfD/gQr1smx9g9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceiiOv1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceiiOv1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56831F000FF;
	Thu, 10 Sep 2026 03:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011960;
	bh=/nTWGwlX5Jet9YxWrdbQFR2OvKuNWX8Lk//yv5kynT0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ceiiOv1LngiCkoobzQ8boVg29aXIsceJZ/3aGIBbUE+mgQDtJc0QfXh2oS9vaebAh
	 aQvQFqtuNWKYxRfipD/GL2ltbAeVt4N5xoLVJFf4MFMXHru2PV2/Awe/gLVncMZOEH
	 M5rZr3zteqtO6xN0dEUh6y5FU4jNB5oYPQKYVcffhGwrELl7kjWX3xe0hqCWbLPRiY
	 jhatlT8Dlh/WQ/SvOlX6A1CrEKIEIVzow47HqZBZwD8DMYBiad2VUsLZUk9/S3/Y49
	 sZxoYzSUX+fWqxSIEGb10RuSFRiX+zYbjibpgr4nFJMX2dtxL9tFDrAQy0ZUbN8Xmm
	 GrdfchyFSlH4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9BE23CE0869; Wed,  9 Sep 2026 20:46:00 -0700 (PDT)
Date: Wed, 9 Sep 2026 20:46:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] srcutree: Don't transition atomic SRCU to big in
 srcu_gp_end()
Message-ID: <f093346c-4eaa-4faf-9a18-f1ec43247290@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cb71412b-a688-4c70-9365-3f6bd40c9244@paulmck-laptop>
 <20260909024515.2429893-1-kunwu.chan@gmail.com>
 <8d5c8d6f-6788-43bc-b5e3-c8bca8e984be@paulmck-laptop>
 <CAN_Opa-FsrNsQM5WPCGBkQ43ECps36e_KyTzG9niEnm6KpdBEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa-FsrNsQM5WPCGBkQ43ECps36e_KyTzG9niEnm6KpdBEw@mail.gmail.com>

On Thu, Sep 10, 2026 at 11:18:20AM +0800, KunWu Chan wrote:
> On Thu, Sep 10, 2026 at 8:13 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Sep 09, 2026 at 10:45:14AM +0800, Kunwu Chan wrote:
> > > On Tue, 8 Sep 2026 16:38:19 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >
> > > > On Mon, Sep 07, 2026 at 03:58:23PM +0800, Kunwu Chan wrote:
> > > > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > > >
> > > > > The transition-to-big code path in srcu_gp_end() calls
> > > > > init_srcu_struct_nodes() with GFP_KERNEL, which is illegal in the
> > > > > atomic context reachable from synchronize_srcu_atomic().  Atomic SRCU
> > > > > has no use for the srcu_node combining tree: it has neither callbacks
> > > > > nor srcu_barrier() operations, and its grace periods are serialized
> > > > > by ->srcu_atomic_gp_flag instead.
> > > > >
> > > > > Skip this transition entirely for atomic SRCU, which is also defense
> > > > > in depth against any path that might wrongly set ->srcu_size_state for
> > > > > an atomic srcu_struct.
> > > > >
> > > > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > > >
> > > > Again, given that we have this commit, is this patch needed?
> > > >
> > > > 4e01d5320a2f ("srcutree: Suppress to-big transition for atomic SRCU")
> > > >
> > > > And again, if so, please tell me what I am missing.
> > >
> > > Yes, this is a separate transition path. That commit suppresses the
> > > initialization-time transition, while this patch prevents the transition
> > > from srcu_gp_end(), which can otherwise call
> > > init_srcu_struct_nodes(..., GFP_KERNEL) for an atomic SRCU.
> > >
> > > So this is defense in depth for the atomic path.
> >
> > Fair point.  But is there any additional pathway other than the
> > SRCU_SIZING_IS_TORTURE() check at the end of srcu_torture_stats_print()?
> 
> I checked all transition-to-big pathways for atomic SRCU.
> Atomic SRCU can reach srcu_gp_end(), but its srcu_size_state remains
> SRCU_SIZE_SMALL,
> so the transition condition there cannot be satisfied.
> 
> The contention path is also unreachable:
> synchronize_srcu_atomic() calls srcu_gp_start() directly and never
> goes through srcu_gp_start_if_needed().
> The other callers of that path reject atomic SRCU.
> 
> The only remaining explicit transition is SRCU_SIZING_IS_TORTURE() in
> srcu_torture_stats_print(),
> which currently lacks an atomic exclusion. I'll send a follow-up patch
> to add a srcu_reader_flavor check there.

Very good!

> So I agree the srcu_gp_end() patch can be dropped.

It might not hurt to have a WARN_ON_ONCE() there, just in case someone
implements another pathway.

							Thanx, Paul

> Thanks,
> Kunwu
> 
> >
> >                                                         Thanx, Paul
> >
> > > Thanks,
> > > KunWu
> > >
> > > >
> > > >                                                     Thanx, Paul
> > > >
> > > > > ---
> > > > >  kernel/rcu/srcutree.c | 5 +++--
> > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > index 01f224a56b41..74acd5645d4c 100644
> > > > > --- a/kernel/rcu/srcutree.c
> > > > > +++ b/kernel/rcu/srcutree.c
> > > > > @@ -1074,8 +1074,9 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
> > > > >           raw_spin_unlock_irq_rcu_node(sup);
> > > > >   }
> > > > >
> > > > > - /* Transition to big if needed. */
> > > > > - if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
> > > > > + /* Transition to big if needed, but never for atomic SRCU. */
> > > > > + if (!is_atomic && ss_state != SRCU_SIZE_SMALL &&
> > > > > +     ss_state != SRCU_SIZE_BIG) {
> > > > >           if (ss_state == SRCU_SIZE_ALLOC)
> > > > >                   init_srcu_struct_nodes(ssp, GFP_KERNEL);
> > > > >           else
> > > > > --
> > > > > 2.43.0
> > > > >
> > > >
> > >
> > > Sent using hkml (https://github.com/sjp38/hackermail)
