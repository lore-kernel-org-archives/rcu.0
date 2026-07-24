Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15622EEE8C
	for <rcu@vger.kernel.org>; Fri, 24 Jul 2026 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904882; cv=pass; b=XQSsL714KjSM+zKjmJBSt8xSI6k7LBs768yAsYKX+3Ik6P7sKkbBiymPXQzQUgUUBxSxwowy4cHfSBBJ5n6bapi+IiKB32LSDvigvCUTm7QlXdpMi1JrygDAHpOdQXIc+1e+1y58fE0bysd1qwJMe7LCuc0W0WWMsA1rh6YYa9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904882; c=relaxed/simple;
	bh=GdBX5HBWHNdELzkCCNAlBoJl+FVAZi4vpTXJd4Yd/XY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHKzDo6yscoabmQa6FZGouAGUAEngHmAd0tgyxflF1Y5WfcC0CJTqpeM65+H0eln12822GFegJSPkodbc73oYGtYr1zh5dAekCz5apF+51V/D4puZ91vRzqvj/l2QlfA8ZP2TpywF7mW9hONPZceYKzg1B0R0/KEV2STVYSqLCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvYChsSL; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvYChsSL"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1c52d920b8so76408166b.2
        for <rcu@vger.kernel.org>; Fri, 24 Jul 2026 07:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784904875; cv=none;
        d=google.com; s=arc-20260327;
        b=qtwkC4G6TmfdYfC7vuaH9yVwQ4L51qzBjZe0vN0iVPkYe0fWlNtVZA9QXnAXl4PDfG
         M2InNpQa9NEOfWQ0QcgPb8WpakjqBpRfzsEfUebAQdlaSFZSPdHb9rxENj+6qbu9BN87
         zcl6fEpKI5jndGX2eJEUe4q1VYeiFOOHSpRXkqT5pTpWZCdTOJLCrtGoEU7pR+c4dm/n
         l/FRHcaCLIfdfQbdxcOWrw7ReiPiMMnf0rKuFCuOd+ehgEuA9CfL/uuJtGJYQFKReAKO
         j4o/50ujNqrAQbztLzAqrUI17OVnftEt2hmGNPtEkL2FGYPiWlOpSjyP2zesej1/LqSS
         4ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qtyT3zOEPZ/csodJ+SE+HkdqXNL9WhosxFizDs5p1Q8=;
        fh=0a32sBVml1HIh/QBMwCUfYAd9Sn2D0eKAeJB6PxXdAA=;
        b=mJ/0/6uxNCcCo7enYp3tMl25u8KsBmDwiMSih1LgUR/YciWQ1LoPeJwS0qNIGvZ3sx
         rhMUU6bv4ceWiUyXqL2dDDTwbNnFKuaMhC1IE22jdiGC2DSTse5BE18E+wb+LzQWsSXF
         cEfTAmx0RJD9SiczasFWYFEy2ulENTcUNXVkBi+uI4oVeXGyQvaJPHmG9NRowxq0PGea
         HsUZRZMxCd5ylL+uu8whhl/Wpp6bcC+22c55+QUk6GSiy0Plh0Fkx2osCcHiAuv3qZSl
         1a5bw1alKcjw0sNS+C6GuffDV1+48Zg81kshyqgOJtynPZyMqxWss12wlSTOjSSkB6Sp
         /ZDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784904875; x=1785509675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qtyT3zOEPZ/csodJ+SE+HkdqXNL9WhosxFizDs5p1Q8=;
        b=hvYChsSLfQhsIG15sY/HeIgkxe+DpUfLxaajV+3RLC8yJuXqhglZkFNSwco4zjaz2/
         kn7sHio4psC6QmwWD+t2xvPfUavqC1LSmVXh4rCnmKi/Qs4PJJ3sucMLmmndqr87C01A
         XM9bM3k/+8Rg+Mdsa+uEdqoP5RNIwnkyonYI/fpiBuaDxf4gcutMiwlHuMi8IWnZ5e6v
         ag1ZZ9WLrIWnJoenfY+DdktEZfPITmr7w4d7KxZzx2zlcvMOysV9RH9XB3TG8UGytQHZ
         ysJ1OfllifXzlyGj2YdiZJdwReMHsmZqAXX8mcGRcJc9mOcFPKrs6AvoXRL3+Jegdjlb
         q0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784904875; x=1785509675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qtyT3zOEPZ/csodJ+SE+HkdqXNL9WhosxFizDs5p1Q8=;
        b=UhFswSQpLMrvScm4r3BWc8smLiGXJzRxfGgae7b8QPGm7AmNecsoDEcHbO/e5c8AHr
         a4GRgOZqV2txwBuv8PLBKn7M7U8crlg2T6AAl+uRFlCv6X153rYu4/h+C5RmR97jj6Ez
         a3J9nwg4N+QfRaVOaYEZA3oQg75Apmi2m2tDFP+2hcTXViFveCm01WHEgZC8UqW/vtah
         9DvKo4aUjCJctNOY5yaRgeAtcru94cgevGtreVsGLKYkbGbuiTDzLraMThRhJJhaoTpA
         dRtahUNc4oYO2YLlOlLCE7/hJnPYfbO2Nds+cSRH7z8bZXkBNpAjo2k97w0SQPV3yy2n
         koeA==
X-Gm-Message-State: AOJu0Yy8I5XhvYYoAiImxIBhaXGzDyUg+i0BAtE+dGYDyN6sYKX+C6bm
	aw3qF/dB4/98sHjqgafbGCpcnsA5/u34sLi0z8XcXqQlSUXU8VqyzLNkvP29UZqjwTHx/8AN9P8
	7/61KGQyXQyLKQWM+72LVjvoQ5C4X8EdwCQrqFAg=
X-Gm-Gg: AR+sD102JrkCWrXD83wo8g3kipqtX06rR52o/6nDxiz+fnjyJzTLAn/YKFojP5BKaZY
	Og/DmOH/TbDw/SaRZwiXaOPzwIYwmVHU3yz+3s5EBb08KzvGJmmY5n4llbMbK9ziW0SPPt5XOgV
	8uqm6h/dfv5BmbKtgI3eBy3aoB9MP5gKTkeblIVmz5KJvOnLH+rk5EWUH9YeyvdHS4/Iwf9XhqL
	YZcQq3J4+HZNroEpqCrLw1ne/E5IL5r9ATmtWIyPrlgIPARL27ZwfrCaIIEk0i5hVTIfy8f8OhT
	BilxVnpWR8PU
X-Received: by 2002:a17:907:a682:b0:c16:5dbd:820c with SMTP id
 a640c23a62f3a-c1c508f5f39mr321380666b.33.1784904874785; Fri, 24 Jul 2026
 07:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624132356.516959-1-puranjay@kernel.org> <20260624132356.516959-11-puranjay@kernel.org>
 <al-DopVEIe2FvLnv@localhost.localdomain> <CANk7y0hado1yb9Gaeg0FVX45E96E3U_8d6gJTF0=s-pjwcQEpQ@mail.gmail.com>
 <amE7NrJRm0YDYroX@pavilion.home>
In-Reply-To: <amE7NrJRm0YDYroX@pavilion.home>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 24 Jul 2026 15:54:20 +0100
X-Gm-Features: AUfX_mzr_adsLjWyFMlsS6xiXyVAsee9rcQh-ohbnzJZHXe86Q3JwIlhIl98FE4
Message-ID: <CANk7y0g24_wj+PUKSRdkrCqY2P1tQ=5JxbWYZbWsbTLhR0M9Lw@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] rcu: Advance callbacks for expedited GP
 completion in rcu_core()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:50=E2=80=AFPM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> Le Tue, Jul 21, 2026 at 04:06:24PM +0100, Puranjay Mohan a =C3=A9crit :
> > On Tue, Jul 21, 2026 at 3:35=E2=80=AFPM Frederic Weisbecker <frederic@k=
ernel.org> wrote:
> > >
> > > Le Wed, Jun 24, 2026 at 06:23:52AM -0700, Puranjay Mohan a =C3=A9crit=
 :
> > > > Even when rcu_pending() triggers rcu_core(), the normal callback
> > > > advancement path through note_gp_changes() -> __note_gp_changes() b=
ails
> > > > out when rdp->gp_seq =3D=3D rnp->gp_seq (no normal GP change). Sinc=
e
> > > > expedited GPs do not update rnp->gp_seq, rcu_advance_cbs() is never
> > > > called and callbacks remain stuck in RCU_WAIT_TAIL.
> > > >
> > > > Add a direct callback advancement block in rcu_core() that checks f=
or GP
> > > > completion via rcu_segcblist_nextgp() combined with
> > > > poll_state_synchronize_rcu_full(). When detected, trylock rnp and c=
all
> > > > rcu_advance_cbs() to move completed callbacks to RCU_DONE_TAIL. Wak=
e the
> > > > GP kthread if rcu_advance_cbs() requests a new grace period.
> > > >
> > > > Uses trylock to avoid adding contention on rnp->lock. If the lock i=
s
> > > > contended, callbacks will be advanced on the next tick.
> > > >
> > > > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 17 +++++++++++++++++
> > > >  1 file changed, 17 insertions(+)
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index b01d7bf6b57b1..f42e01ef479c4 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2891,6 +2891,23 @@ static __latent_entropy void rcu_core(void)
> > > >       /* Update RCU state based on any recent quiescent states. */
> > > >       rcu_check_quiescent_state(rdp);
> > > >
> > > > +     /* Advance callbacks if an expedited GP has completed. */
> > > > +     if (!rcu_rdp_is_offloaded(rdp) && rcu_segcblist_is_enabled(&r=
dp->cblist)) {
> > > > +             struct rcu_gp_seq gp_state;
> > > > +
> > > > +             if (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
> > > > +                 poll_state_synchronize_rcu_full(&gp_state)) {
> > > > +                     guard(irqsave)();
> > > > +                     if (raw_spin_trylock_rcu_node(rnp)) {
> > > > +                             bool needwake =3D rcu_advance_cbs(rnp=
, rdp);
> > > > +
> > > > +                             raw_spin_unlock_rcu_node(rnp);
> > > > +                             if (needwake)
> > > > +                                     rcu_gp_kthread_wake();
> > > > +                     }
> > > > +             }
> > > > +     }
> > >
> > > Should that go as an improvement to note_gp_changes() instead?
> >
> > note_gp_changes() only reconciles rdp->gp_seq against rnp->gp_seq, and
> > the expedited path never advances rnp->gp_seq. So the gap this closes
> > is exactly rdp->gp_seq =3D=3D rnp->gp_seq, where note_gp_changes() and
> > __note_gp_changes() both short-circuit, the expedited completion isn't
> > visible there at all. It's detected from the cblist's stored gp_seq
> > (rcu_segcblist_nextgp()) confirmed with
> > poll_state_synchronize_rcu_full(), so hosting it in note_gp_changes()
> > would mean running that in the lockless preamble for every caller,
> > including the off-tick call_rcu_core() path. In rcu_core() it's
> > already gated by rcu_pending(), which does the barrier-free detection.
>
> Let's take a step back. note_gp_changes() is for the CPU to ackowledge
> a grace period change, either start or completion, and react upon with:
>
> _ Making the callback progress through the state machine if a grace perio=
d
>   has changed.
>
> _ Starting to chase quiescent states.
>
> And now callback advancing/acceleration don't even refer anymore to the
> leaf node state but to the global one. So why not proceed with that
> logic?
>
> Also other callers of note_gp_changes() may want to benefit from expedite=
d
> grace periods as well.
>
> Would the following (untested) work?
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ff6601411a89..96bf7fe03be8 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1271,27 +1271,29 @@ static bool __note_gp_changes(struct rcu_node *rn=
p, struct rcu_data *rdp)
>  {
>         bool ret =3D false;
>         bool need_qs;
> +       struct rcu_gp_seq gp_state;
>         const bool offloaded =3D rcu_rdp_is_offloaded(rdp);
>
>         raw_lockdep_assert_held_rcu_node(rnp);
>
> -       if (rdp->gp_seq =3D=3D rnp->gp_seq)
> -               return false; /* Nothing to do. */
> -
>         /* Handle the ends of any preceding grace periods first. */
> -       if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
> +       if ((rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
> +           poll_state_synchronize_rcu_full_unordered(&gp_state)) ||
>             unlikely(rdp->gpwrap)) {
>                 if (!offloaded)
>                         ret =3D rcu_advance_cbs(rnp, rdp); /* Advance CBs=
. */
>                 rdp->core_needs_qs =3D false;
>                 trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("=
cpuend"));
> -       } else {
> +       } else if (rdp->gp_seq !=3D rnp->gp_seq) {
>                 if (!offloaded)
>                         ret =3D rcu_accelerate_cbs(rnp, rdp); /* Recent C=
Bs. */
>                 if (rdp->core_needs_qs)
>                         rdp->core_needs_qs =3D !!(rnp->qsmask & rdp->grpm=
ask);
>         }
>
> +       if (rdp->gp_seq =3D=3D rnp->gp_seq)
> +               return ret; /* Nothing else to do. */
> +
>         /* Now handle the beginnings of any new-to-this-CPU grace periods=
. */
>         if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
>             unlikely(rdp->gpwrap)) {
> @@ -1316,6 +1318,27 @@ static bool __note_gp_changes(struct rcu_node *rnp=
, struct rcu_data *rdp)
>         return ret;
>  }
>
> +static bool need_note_gp_changes(struct rcu_data *rdp)
> +{
> +       struct rcu_gp_seq gp_state;
> +       struct rcu_node *rnp =3D rdp->mynode;
> +
> +       /* Need to chase QS or accelerate? */
> +       if (rdp->gp_seq !=3D rcu_seq_current(&rnp->gp_seq))
> +               return true;
> +
> +       /* Waited upon GP has ended, need to advance CBs ? */
> +       if (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
> +           poll_state_synchronize_rcu_full_unordered(&gp_state))
> +               return true;
> +
> +       /* Wrapped? */
> +       if (unlikely(READ_ONCE(rdp->gpwrap)))
> +               return true;
> +
> +       return false;
> +}
> +
>  static void note_gp_changes(struct rcu_data *rdp)
>  {
>         unsigned long flags;
> @@ -1324,8 +1347,7 @@ static void note_gp_changes(struct rcu_data *rdp)
>
>         local_irq_save(flags);
>         rnp =3D rdp->mynode;
> -       if ((rdp->gp_seq =3D=3D rcu_seq_current(&rnp->gp_seq) &&
> -            !unlikely(READ_ONCE(rdp->gpwrap))) || /* w/out lock. */
> +       if (!need_note_gp_changes(rdp) || /* w/out lock. */
>             !raw_spin_trylock_rcu_node(rnp)) { /* irqs already off, so la=
ter. */
>                 local_irq_restore(flags);
>                 return;
> @@ -2888,23 +2910,6 @@ static __latent_entropy void rcu_core(void)
>         /* Update RCU state based on any recent quiescent states. */
>         rcu_check_quiescent_state(rdp);
>
> -       /* Advance callbacks if an expedited GP has completed. */
> -       if (!rcu_rdp_is_offloaded(rdp) && rcu_segcblist_is_enabled(&rdp->=
cblist)) {
> -               struct rcu_gp_seq gp_state;
> -
> -               if (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
> -                   poll_state_synchronize_rcu_full(&gp_state)) {
> -                       guard(irqsave)();
> -                       if (raw_spin_trylock_rcu_node(rnp)) {
> -                               bool needwake =3D rcu_advance_cbs(rnp, rd=
p);
> -
> -                               raw_spin_unlock_rcu_node(rnp);
> -                               if (needwake)
> -                                       rcu_gp_kthread_wake();
> -                       }
> -               }
> -       }
> -
>         /* No grace period and unregistered callbacks? */
>         if (!rcu_gp_in_progress() &&
>             rcu_segcblist_is_enabled(&rdp->cblist) && !rcu_rdp_is_offload=
ed(rdp)) {
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 01a1b2985abd..6b9b058d138e 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -517,6 +517,7 @@ static void rcu_nocb_unlock(struct rcu_data *rdp);
>  static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
>                                        unsigned long flags);
>  static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
> +static bool poll_state_synchronize_rcu_full_unordered(struct rcu_gp_seq =
*gsp);
>  #ifdef CONFIG_RCU_NOCB_CPU
>  static void __init rcu_organize_nocb_kthreads(void);
>
>


Hi Frederic.

I took your approach and created this commit with minor changes to your dif=
f:

A few points I'd like a second opinion on. I kept the unordered
poll_state_synchronize_rcu_full_unordered() for the advance check (the
old rcu_core() block used the ordered variant): this looks safe
because rcu_segcblist_advance() re-checks each segment with the
ordered poll_state_synchronize_rcu_full() before moving callbacks to
RCU_DONE_TAIL, so the check here is only a gate and the barriers still
apply where callbacks are actually advanced, please confirm that
reasoning. need_note_gp_changes() runs the callback-list poll on the
lockless preamble for both callers, including offloaded rdps where
__note_gp_changes() won't advance anything; I left it ungated since it
only leads to a trylock, but it could take a
!rcu_rdp_is_offloaded(rdp) guard. I also dropped the
rcu_segcblist_is_enabled() guard the rcu_core() block had, relying on
__note_gp_changes() already operating on the cblist unconditionally
for non-offloaded rdps.

-- >8 --

From c38c5f599d699e2c40d3459fdf3ef383a99c0097 Mon Sep 17 00:00:00 2001
From: Puranjay Mohan <puranjay@kernel.org>
Date: Fri, 24 Jul 2026 07:26:25 -0700
Subject: [PATCH] rcu: Advance callbacks for expedited GP completion in
 note_gp_changes()

When rcu_pending() triggers rcu_core(), the callback advancement path
through note_gp_changes() -> __note_gp_changes() bails out when
rdp->gp_seq =3D=3D rnp->gp_seq (no normal GP change). Since expedited GPs d=
o
not update rnp->gp_seq, rcu_advance_cbs() is never reached from there and
callbacks satisfied by an expedited GP would otherwise remain stuck in
RCU_WAIT_TAIL until the next normal GP.

This is currently handled by a dedicated advancement block in rcu_core()
that polls the callback list and advances under a trylock. But callback
advancement no longer depends on the leaf-node grace-period delta; it is
driven by the grace-period state stored in the callback list, which
tracks both normal and expedited GPs. __note_gp_changes() is the natural
home for it, and hosting it there lets every note_gp_changes() caller
benefit from expedited completions rather than just rcu_core().

Move the advancement into __note_gp_changes(): trigger rcu_advance_cbs()
whenever rcu_segcblist_nextgp() confirmed with
poll_state_synchronize_rcu_full_unordered() reports a completed grace
period, and add need_note_gp_changes() so the lockless preamble takes the
lock for an expedited-only completion instead of short-circuiting on
rdp->gp_seq =3D=3D rnp->gp_seq. Remove the now-redundant rcu_core() block.

The quiescent-state bookkeeping stays keyed to an actual rnp->gp_seq
change, so an expedited completion never clears a still-pending
core_needs_qs and stalls the normal grace period.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/tree.c | 56 ++++++++++++++++++++++++-----------------------
 kernel/rcu/tree.h |  1 +
 2 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 21b6ce1dffb63..0e700d0ecf27e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1270,27 +1270,33 @@ static bool __note_gp_changes(struct rcu_node
*rnp, struct rcu_data *rdp)
 {
        bool ret =3D false;
        bool need_qs;
+       struct rcu_gp_seq gp_state;
        const bool offloaded =3D rcu_rdp_is_offloaded(rdp);
+       bool completed =3D rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) |=
|
+                        unlikely(rdp->gpwrap);

        raw_lockdep_assert_held_rcu_node(rnp);

-       if (rdp->gp_seq =3D=3D rnp->gp_seq)
-               return false; /* Nothing to do. */
-
        /* Handle the ends of any preceding grace periods first. */
-       if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
-           unlikely(rdp->gpwrap)) {
+       if (completed ||
+           (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
+            poll_state_synchronize_rcu_full_unordered(&gp_state))) {
                if (!offloaded)
                        ret =3D rcu_advance_cbs(rnp, rdp); /* Advance CBs. =
*/
-               rdp->core_needs_qs =3D false;
-               trace_rcu_grace_period(rcu_state.name, rdp->gp_seq,
TPS("cpuend"));
-       } else {
+               if (completed) {
+                       rdp->core_needs_qs =3D false;
+                       trace_rcu_grace_period(rcu_state.name,
rdp->gp_seq, TPS("cpuend"));
+               }
+       } else if (rdp->gp_seq !=3D rnp->gp_seq) {
                if (!offloaded)
                        ret =3D rcu_accelerate_cbs(rnp, rdp); /* Recent CBs=
. */
                if (rdp->core_needs_qs)
                        rdp->core_needs_qs =3D !!(rnp->qsmask & rdp->grpmas=
k);
        }

+       if (rdp->gp_seq =3D=3D rnp->gp_seq)
+               return ret; /* Nothing else to do. */
+
        /* Now handle the beginnings of any new-to-this-CPU grace periods. =
*/
        if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
            unlikely(rdp->gpwrap)) {
@@ -1315,6 +1321,20 @@ static bool __note_gp_changes(struct rcu_node
*rnp, struct rcu_data *rdp)
        return ret;
 }

+static bool need_note_gp_changes(struct rcu_data *rdp)
+{
+       struct rcu_gp_seq gp_state;
+       struct rcu_node *rnp =3D rdp->mynode;
+
+       if (rdp->gp_seq !=3D rcu_seq_current(&rnp->gp_seq) ||
+           unlikely(READ_ONCE(rdp->gpwrap)))
+               return true;
+
+       /* Has a grace period a callback is waiting on completed? */
+       return rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
+              poll_state_synchronize_rcu_full_unordered(&gp_state);
+}
+
 static void note_gp_changes(struct rcu_data *rdp)
 {
        unsigned long flags;
@@ -1323,8 +1343,7 @@ static void note_gp_changes(struct rcu_data *rdp)

        local_irq_save(flags);
        rnp =3D rdp->mynode;
-       if ((rdp->gp_seq =3D=3D rcu_seq_current(&rnp->gp_seq) &&
-            !unlikely(READ_ONCE(rdp->gpwrap))) || /* w/out lock. */
+       if (!need_note_gp_changes(rdp) || /* w/out lock. */
            !raw_spin_trylock_rcu_node(rnp)) { /* irqs already off, so late=
r. */
                local_irq_restore(flags);
                return;
@@ -2886,23 +2905,6 @@ static __latent_entropy void rcu_core(void)
        /* Update RCU state based on any recent quiescent states. */
        rcu_check_quiescent_state(rdp);

-       /* Advance callbacks if an expedited GP has completed. */
-       if (!rcu_rdp_is_offloaded(rdp) &&
rcu_segcblist_is_enabled(&rdp->cblist)) {
-               struct rcu_gp_seq gp_state;
-
-               if (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
-                   poll_state_synchronize_rcu_full(&gp_state)) {
-                       guard(irqsave)();
-                       if (raw_spin_trylock_rcu_node(rnp)) {
-                               bool needwake =3D rcu_advance_cbs(rnp, rdp)=
;
-
-                               raw_spin_unlock_rcu_node(rnp);
-                               if (needwake)
-                                       rcu_gp_kthread_wake();
-                       }
-               }
-       }
-
        /* No grace period and unregistered callbacks? */
        if (!rcu_gp_in_progress() &&
            rcu_segcblist_is_enabled(&rdp->cblist) &&
!rcu_rdp_is_offloaded(rdp)) {
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index eedfa43059e80..962f86afc3c9a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -521,6 +521,7 @@ static void rcu_nocb_unlock(struct rcu_data *rdp);
 static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
                                       unsigned long flags);
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
+static bool poll_state_synchronize_rcu_full_unordered(struct rcu_gp_seq *g=
sp);
 #ifdef CONFIG_RCU_NOCB_CPU
 static void __init rcu_organize_nocb_kthreads(void);


base-commit: dc597bcabf31a58f8c1aca01677a6af0b3307398
--
2.53.0-Meta

-- 8< --

Thanks,
Puranjay
