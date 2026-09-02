Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83A54A483C;
	Wed,  2 Sep 2026 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363607; cv=none; b=VaaHN31ZOxRUTsg3ClxC5/CoCq48Y2NxIqvOY24W6n78wiJur+f8CwAyD4TO+K/u5WrdbtpXbF9J4VUDf7byKxL0VPfZllBax6LPdpwwe1gbrBx8XxNj+hxnX8p+/ZxdrFxZtvoNhIpIKBfpHCG2oc3q2MG+tlQHbu5g+ekfs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363607; c=relaxed/simple;
	bh=13sGoM+qIAb6LgiEcr8iFQz4zvxP0RaRk7Cs/DmlrY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtzdbw8OPI0GRkS20cxIymZIUMk3yweR1Gr+zchxleCloPZlj37ovuWk0vw05zjrv/UXDCDDG6H000vOT4DUJcHIQE2FDpmRDZdC+fJoPLly45n9049ajmdZkaHZMVVI7yliOsjUwFpkhK3Rs6UzUn4U47M8RfFH4h/ythLf3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7WSoEJu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7WSoEJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF9E1F000E9;
	Wed,  2 Sep 2026 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788363603;
	bh=KyRYWAWNk+yyXs0ab9bSByIW1kmtJLiVt8nrs6dL6rQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=c7WSoEJutH19mCrBFUf+WP54pO1w+WD0+higMiZV/Gszdjqkfw6caWpaTHFDzlswA
	 Z7UaQLNvv9NrpvVZx4BhgWn1mCo9gySzz1FrOQIbvQiff+mgoQ3RPazCCmriawNjZo
	 T4ZUv2xyeYZLxb8gWsE5vJjIB7c1Pa5EKRTnPSZFQzo9MsQreIlH4XpOKGYJlstDVn
	 V7guXfsypt/6AGzuDX4GFUToHNdq+GTCCSR+iDhHCKDFUbsAOJ0hDDt4Ml0I/J1BIe
	 Zm9FIa+VJHEsLaP/qD/Lq+JAv33vGjK7qJfARjopkZi8X1C7b9oCn227mgooEqT1Qo
	 ytLpbm81T3V4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 61785CE0503; Wed,  2 Sep 2026 08:40:03 -0700 (PDT)
Date: Wed, 2 Sep 2026 08:40:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcutiny: Add atomic SRCU operation checks and state
Message-ID: <ab114f9f-ccb2-4d51-a7e7-f66275d2cd57@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260831074937.2380914-1-kunwu.chan@linux.dev>
 <0eac36c5-acd2-4d8d-a498-f56a57cc3d6a@paulmck-laptop>
 <CAN_Opa_z4e8fLM0=+QV82r4oveKKUWitvNrBnsfJhXd+2-QQLQ@mail.gmail.com>
 <ce1789d4-7a78-456c-9e6e-e9af824e5285@paulmck-laptop>
 <CAN_Opa_AYw-KSA-u5=fjGLOP9z-Cf1Dk2Fba==MSLAX7TZSYWQ@mail.gmail.com>
 <e521bee4-e8ab-40a2-b22f-325d37fbcd63@paulmck-laptop>
 <CAN_Opa_7gKNuibT07tM=TcMYoTEzjeBO_=9WCoxVnY=-Jq2hcg@mail.gmail.com>
 <eeba30f0-5a74-42ce-b559-dec079c8b84a@paulmck-laptop>
 <CAN_Opa_aRqEvnni_3yuAMkugZnY9L7C-_OxQqaYhEp-E9amtzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa_aRqEvnni_3yuAMkugZnY9L7C-_OxQqaYhEp-E9amtzg@mail.gmail.com>

On Wed, Sep 02, 2026 at 05:47:14PM +0800, KunWu Chan wrote:
> On Wed, Sep 2, 2026 at 1:20 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Wed, Sep 02, 2026 at 11:05:22AM +0800, KunWu Chan wrote:
> > > On Wed, Sep 2, 2026 at 12:52 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > On Tue, Sep 01, 2026 at 04:29:05PM +0800, KunWu Chan wrote:
> > > > > On Tue, Sep 1, 2026 at 11:10 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > On Tue, Sep 01, 2026 at 10:00:24AM +0800, KunWu Chan wrote:
> > > > > > > On Tue, Sep 1, 2026 at 9:04 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > > On Mon, Aug 31, 2026 at 03:49:37PM +0800, Kunwu Chan wrote:
> > > > > > > > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > > > > > > > Add atomic SRCU operation checks and the associated state to Tiny
> > > > > > > > > SRCU.
> > > > > > > > >
> > > > > > > > > An atomic SRCU domain does not use the normal SRCU callback and
> > > > > > > > > grace-period machinery.  In particular, a callback queued with
> > > > > > > > > call_srcu() would never be processed.  Use WARN_ON_ONCE() to reject
> > > > > > > > > call_srcu() and srcu_barrier() on atomic SRCU domains.
> > > > > > > > >
> > > > > > > > > For synchronize_srcu(), redirect atomic SRCU domains to
> > > > > > > > > synchronize_srcu_atomic().
> > > > > > > > >
> > > > > > > > > Add srcu_reader_flavor to the Tiny SRCU state for these checks.
> > > > > > > > > Tiny SRCU does not currently set the flavor for atomic SRCU domains,
> > > > > > > > > but keeping the flavor in the common state allows the operation
> > > > > > > > > checks to enforce the restriction once atomic flavor tracking is
> > > > > > > > > enabled.
> > > > > > > > >
> > > > > > > > > Also initialize srcu_atomic_gp_flag, which was previously left
> > > > > > > > > uninitialized.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > > > > > > > > ---
> > > > > > > > >  include/linux/srcutiny.h |  1 +
> > > > > > > > >  kernel/rcu/srcutiny.c    | 12 ++++++++++++
> > > > > > > > >  2 files changed, 13 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > > > > > > > > index 47a368f945e3..2b293336525a 100644
> > > > > > > > > --- a/include/linux/srcutiny.h
> > > > > > > > > +++ b/include/linux/srcutiny.h
> > > > > > > > > @@ -20,6 +20,7 @@ struct srcu_struct {
> > > > > > > > >       u8 srcu_gp_running;             /* GP workqueue running? */
> > > > > > > > >       u8 srcu_gp_waiting;             /* GP waiting for readers? */
> > > > > > > > >       u8 srcu_atomic_gp_flag;         /* Serialize atomic GP work.*/
> > > > > > > > > +     u8 srcu_reader_flavor;          /* Values: SRCU_READ_FLAVOR_.*  */
> > > > > > > > >       unsigned long srcu_idx;         /* Current reader array element in bit 0x2. */
> > > > > > > > >       unsigned long srcu_idx_max;     /* Furthest future srcu_idx request. */
> > > > > > > > >       struct swait_queue_head srcu_wq;
> > > > > > > > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > > > > > > > > index 26ea4bfbeaf2..22f7716cbb0e 100644
> > > > > > > > > --- a/kernel/rcu/srcutiny.c
> > > > > > > > > +++ b/kernel/rcu/srcutiny.c
> > > > > > > > > @@ -41,6 +41,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
> > > > > > > > >       ssp->srcu_cb_tail = &ssp->srcu_cb_head;
> > > > > > > > >       ssp->srcu_gp_running = false;
> > > > > > > > >       ssp->srcu_gp_waiting = false;
> > > > > > > > > +     ssp->srcu_atomic_gp_flag = 0;
> > > > > > > >
> > > > > > > > Good catch!  I will be folding this into the base commit with attribution
> > > > > > > > on my next rebase:
> > > > > > > >
> > > > > > > > 9a2e9996ccec ("srcutiny: Add an atomic Tiny SRCU")
> > > > > > > >
> > > > > > > > >       ssp->srcu_idx = 0;
> > > > > > > > >       ssp->srcu_idx_max = 0;
> > > > > > > > >       INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
> > > > > > > > > @@ -289,6 +290,9 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain);
> > > > > > > > >  void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> > > > > > > > >              rcu_callback_t func)
> > > > > > > > >  {
> > > > > > > > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
> > > > > > > > > +             return;
> > > > > > > > > +
> > > > > > > > >       if (should_rcu_defer()) {
> > > > > > > > >               /* A re-entrant call_srcu() during the drain would livelock it. */
> > > > > > > > >               if (READ_ONCE(srcu_defer_draining) && !in_nmi()) {
> > > > > > > > > @@ -319,6 +323,11 @@ void synchronize_srcu(struct srcu_struct *ssp)
> > > > > > > > >  {
> > > > > > > > >       struct rcu_synchronize rs;
> > > > > > > > >
> > > > > > > > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC)) {
> > > > > > > > > +             synchronize_srcu_atomic(ssp);
> > > > > > > > > +             return;
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > >       srcu_lock_sync(&ssp->dep_map);
> > > > > > > > >
> > > > > > > > >       RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
> > > > > > > > > @@ -415,6 +424,9 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_atomic);
> > > > > > > > >  /* Register any deferred callbacks, then wait for all in-flight ones. */
> > > > > > > > >  void srcu_barrier(struct srcu_struct *ssp)
> > > > > > > > >  {
> > > > > > > > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
> > > > > > > > > +             return;
> > > > > > > > > +
> > > > > > > > >       __srcu_defer_drain(ssp);
> > > > > > > > >       synchronize_srcu(ssp);
> > > > > > > > >  }
> > > > > > > >
> > > > > > > > The rest is good as far as it goes, but don't we need to set the value
> > > > > > > > of ssp->srcu_reader_flavor somewhere for atomic srcu_struct structures?
> > > > > > > >
> > > > > > >
> > > > > > > Hi Paul,
> > > > > > >
> > > > > > > Yes, agreed. I have the flavor tracking changes implemented locally
> > > > > > > and am testing them now.
> > > > > > > I’ll send the updated patch shortly.
> > > > > > >
> > > > > > > I also have draft patches for the documentation and the fast path, as
> > > > > > > well as rcutorture testing for
> > > > > > > tiny atomic srcu , which I’ll send separately.
> > > > > >
> > > > > > Sounds good, and I am looking forward to seeing them.
> > > > >
> > > > > Hi Paul,
> > > > > I’ve sent the flavor tracking changes as [1].
> > > > > [1] https://lore.kernel.org/all/20260901074815.3145037-1-kunwu.chan@linux.dev/
> > > > >
> > > > > >
> > > > > > I will admit that I am curious as to why Tiny Atomic SRCU needs different
> > > > > > rcutorture testing than does Tree Atomic SRCU, but I will ask myself
> > > > > > that question again when I see your patches.  ;-)
> > > > >
> > > > > You’re right that the existing SRCU torture configuration can exercise
> > > > > the atomic path with rcutorture.reader_flavor=0x10. I had prepared
> > > > > the Tiny atomic torture test as a separate draft, mainly adding local
> > > > > configurations for convenience while validating the Tiny and Tree
> > > > > atomic paths. There is no Tiny-specific torture model here.
> > > > >
> > > > > I can adjust the final rcutorture configuration and naming based on your
> > > > > preference.
> > > >
> > > > The best approach is to add a section to this script:
> > > >
> > > > tools/testing/selftests/rcutorture/bin/torture.sh
> > > >
> > > > This would require adding a command-line parameter such as
> > > > --do-atomic-srcu and friends.  The effect would be that people like
> > > > me would run short tests of atomic SRCU frequently.
> > >
> > > Thanks Paul. I’ll add an atomic SRCU option to
> > > torture.sh so that it can be run as a short, frequent test.
> >
> > Very good, looking forward to seeing it!
> >
> > > During my atomic SRCU testing, I noticed that kvm-recheck-rcu.sh
> > > can report “Reader Batch close calls” even though the kernel reports
> > > End of test: SUCCESS with no WARNING/BUG. The atomic GP rate is also
> > > much higher than normal SRCU.
> > >
> > > I’m still checking whether this is inherent to atomic SRCU, related to
> > > my earlier fastpath change, or an interaction with the torture reader
> > > delay. I’ll continue investigating this as part of the testing work.
> >
> > The close calls can happen due to memory reordering.  But this is new
> > code, so please do check them carefully.
> 
> Thanks, Paul. That gives me a useful reference point.
> 
> > The high atomic grace-period rate is expected behavior.  On my x86
> > laptop, I see about 75/second for Tree Atomic SRCU and about 300
> > for Tiny.  But at your end, how high is high?
> 
> On my x86 PC, with the earlier fastpath change, I was seeing:
> Tree Atomic SRCU: about 250–530 GPs/sec
> Tiny Atomic SRCU: about 290 GPs/sec
> 
> After reverting the fastpath change, Tree Atomic SRCU dropped to about
> 129 GPs/sec, while Tiny remained around 291 GPs/sec. So the Tiny result
> is close to your ~300/sec reference, while the Tree result is somewhat
> higher than your ~75/sec observation.
> 
> The close-call behavior also changed with the fastpath. With the fastpath,
> batch[2] was non-zero (6–334 in my runs). After reverting it, batch[2] was
> consistently 0. batch[1] can still occur on Tree SRCU, but I have not
> seen readers spanning 3 or more GPs.

These results suggest that you should very carefully check memory ordering
in the fastpath code.

> I'll continue checking the close-call behavior with repeated torture runs, with
> particular attention to the memory-ordering aspect you mentioned.

Sounds good, thank you!

							Thanx, Paul
