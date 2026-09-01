Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7D392807;
	Tue,  1 Sep 2026 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232219; cv=none; b=H1hrIVJCpqbp68wExnmvI2B7cj887khGa/ZlhRCKtuVYgU5JLPlrKcsJHqD3z2QoYOZahzj/077aDRQfDTQmDu15U96P4CKTfTNqqHzYDEQTZ8511U0mQaetbx69t+u+RbJeEobnXL2W7kbpkpzAlWELjJ1UzoPk6BtgKyASQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232219; c=relaxed/simple;
	bh=Qqr/cqvz7esR3oRutG3uVaAbwv2QbUPLSf3EGeKHWWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaO7/ro4Jx3JVllDBVxMz2Mt+mRmtO+sLFLpIP/vCnyxuV1KlfXHMl3SEfPHMSgQ3kgCZcsxwk26FLRuHA4DZNIeCUOll08tEl09fxetPQchfVmvToIE9t5KA16ZoEzXIYz5LHvsWu2waHbYUhSW7hGxyHVU7SRJntHIpUrcUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imWetiqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imWetiqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052C11F000E9;
	Tue,  1 Sep 2026 03:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788232216;
	bh=YLKBrTqOTNNklJANAjH/POw5+7rG2PRW69UPtKdnoo0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=imWetiqscS/clmFmln41qV1JWXBdbwRWK7uiwP8viDdz6zj53x4uQ13NJDd7OSx70
	 CaJahMoF4soesOxbK9ncoTq6ERAIDsQqVnlJvsMx7UDpgE3v1RkZ3tuWZhmLrsUJuW
	 cqnRzFoU8/Wb52UP1tlCAror6CP/VJ1fY2VHoxRsftKba9+uhTRAUf0WzMzJZdDduA
	 VOxcynz5YrSTsq8w+4/SC8NHXlkWNR0vsHmZNqC6tdEVjlVoIJz4hZLrt6mnFhwavG
	 7VgbRPr0mTtK3VfPqjfmY2eHanB/IV2qo54j1T9hUy+OSReTo2qEVhZMV2kW9u7Udk
	 HC6HSLyG/+97w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 803F2CE0B65; Mon, 31 Aug 2026 20:10:15 -0700 (PDT)
Date: Mon, 31 Aug 2026 20:10:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcutiny: Add atomic SRCU operation checks and state
Message-ID: <ce1789d4-7a78-456c-9e6e-e9af824e5285@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260831074937.2380914-1-kunwu.chan@linux.dev>
 <0eac36c5-acd2-4d8d-a498-f56a57cc3d6a@paulmck-laptop>
 <CAN_Opa_z4e8fLM0=+QV82r4oveKKUWitvNrBnsfJhXd+2-QQLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa_z4e8fLM0=+QV82r4oveKKUWitvNrBnsfJhXd+2-QQLQ@mail.gmail.com>

On Tue, Sep 01, 2026 at 10:00:24AM +0800, KunWu Chan wrote:
> On Tue, Sep 1, 2026 at 9:04 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Aug 31, 2026 at 03:49:37PM +0800, Kunwu Chan wrote:
> > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > >
> > > Add atomic SRCU operation checks and the associated state to Tiny
> > > SRCU.
> > >
> > > An atomic SRCU domain does not use the normal SRCU callback and
> > > grace-period machinery.  In particular, a callback queued with
> > > call_srcu() would never be processed.  Use WARN_ON_ONCE() to reject
> > > call_srcu() and srcu_barrier() on atomic SRCU domains.
> > >
> > > For synchronize_srcu(), redirect atomic SRCU domains to
> > > synchronize_srcu_atomic().
> > >
> > > Add srcu_reader_flavor to the Tiny SRCU state for these checks.
> > > Tiny SRCU does not currently set the flavor for atomic SRCU domains,
> > > but keeping the flavor in the common state allows the operation
> > > checks to enforce the restriction once atomic flavor tracking is
> > > enabled.
> > >
> > > Also initialize srcu_atomic_gp_flag, which was previously left
> > > uninitialized.
> > >
> > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > > ---
> > >  include/linux/srcutiny.h |  1 +
> > >  kernel/rcu/srcutiny.c    | 12 ++++++++++++
> > >  2 files changed, 13 insertions(+)
> > >
> > > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > > index 47a368f945e3..2b293336525a 100644
> > > --- a/include/linux/srcutiny.h
> > > +++ b/include/linux/srcutiny.h
> > > @@ -20,6 +20,7 @@ struct srcu_struct {
> > >       u8 srcu_gp_running;             /* GP workqueue running? */
> > >       u8 srcu_gp_waiting;             /* GP waiting for readers? */
> > >       u8 srcu_atomic_gp_flag;         /* Serialize atomic GP work.*/
> > > +     u8 srcu_reader_flavor;          /* Values: SRCU_READ_FLAVOR_.*  */
> > >       unsigned long srcu_idx;         /* Current reader array element in bit 0x2. */
> > >       unsigned long srcu_idx_max;     /* Furthest future srcu_idx request. */
> > >       struct swait_queue_head srcu_wq;
> > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > > index 26ea4bfbeaf2..22f7716cbb0e 100644
> > > --- a/kernel/rcu/srcutiny.c
> > > +++ b/kernel/rcu/srcutiny.c
> > > @@ -41,6 +41,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
> > >       ssp->srcu_cb_tail = &ssp->srcu_cb_head;
> > >       ssp->srcu_gp_running = false;
> > >       ssp->srcu_gp_waiting = false;
> > > +     ssp->srcu_atomic_gp_flag = 0;
> >
> > Good catch!  I will be folding this into the base commit with attribution
> > on my next rebase:
> >
> > 9a2e9996ccec ("srcutiny: Add an atomic Tiny SRCU")
> >
> > >       ssp->srcu_idx = 0;
> > >       ssp->srcu_idx_max = 0;
> > >       INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
> > > @@ -289,6 +290,9 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain);
> > >  void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> > >              rcu_callback_t func)
> > >  {
> > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
> > > +             return;
> > > +
> > >       if (should_rcu_defer()) {
> > >               /* A re-entrant call_srcu() during the drain would livelock it. */
> > >               if (READ_ONCE(srcu_defer_draining) && !in_nmi()) {
> > > @@ -319,6 +323,11 @@ void synchronize_srcu(struct srcu_struct *ssp)
> > >  {
> > >       struct rcu_synchronize rs;
> > >
> > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC)) {
> > > +             synchronize_srcu_atomic(ssp);
> > > +             return;
> > > +     }
> > > +
> > >       srcu_lock_sync(&ssp->dep_map);
> > >
> > >       RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
> > > @@ -415,6 +424,9 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_atomic);
> > >  /* Register any deferred callbacks, then wait for all in-flight ones. */
> > >  void srcu_barrier(struct srcu_struct *ssp)
> > >  {
> > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
> > > +             return;
> > > +
> > >       __srcu_defer_drain(ssp);
> > >       synchronize_srcu(ssp);
> > >  }
> >
> > The rest is good as far as it goes, but don't we need to set the value
> > of ssp->srcu_reader_flavor somewhere for atomic srcu_struct structures?
> >
> 
> Hi Paul,
> 
> Yes, agreed. I have the flavor tracking changes implemented locally
> and am testing them now.
> I’ll send the updated patch shortly.
> 
> I also have draft patches for the documentation and the fast path, as
> well as rcutorture testing for
> tiny atomic srcu , which I’ll send separately.

Sounds good, and I am looking forward to seeing them.

I will admit that I am curious as to why Tiny Atomic SRCU needs different
rcutorture testing than does Tree Atomic SRCU, but I will ask myself
that question again when I see your patches.  ;-)

							Thanx, Paul
