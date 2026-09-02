Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6733226D4C3
	for <rcu@vger.kernel.org>; Wed,  2 Sep 2026 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342451; cv=pass; b=XNzF6qENgd5Pzh0o3txeHZiZVq5sWaB8SUOVCnoARphaofIPcXvgq7cN9AagEQ82KCwqVcv+Pp3Hido9o9X9lGlKZswWb8UGyH+376hCMIJpSHLiwr41PsipwYVlN6HzR0du8jOkong2euUoLkrPkfrcgne9TW5Jh0x0+gV040k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342451; c=relaxed/simple;
	bh=SLPs4e7GI/dhAzNosrUy6jyT8TI3x/kIMb11ozyFP/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxKLkQOF2jaB7T3pwoAmUmWUsUd2hCrEte0yAGY3pg3slyCAXfusjJv06YLoOF4pEm6L62myLZLQ2oM+b64n/iVsRgKuSPs/xhDhREboK6G9RL7UQPu/JPEjDbV9CMZv9ickKxqaZQhUzFZpkuCGO0StVY7/yZOru5p6V6fL8ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DznuSgJj; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DznuSgJj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso8859475e9.1
        for <rcu@vger.kernel.org>; Wed, 02 Sep 2026 02:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788342447; cv=none;
        d=google.com; s=arc-20260327;
        b=JX2IdVWOaZ/Ipdfl0A7E1KNp1j/XFh3rA+NIlkSYzicOF3oqbShFUzs1fUpE+zOXGe
         bQfKKZiV3VNYdo31RC6VmviGNN1CB0j12t5YDEX3nowLAtB98hjwDX7K/iyUCXHUXO4E
         nirMe2IDpWhOPWYoe6C1r+Lqq1JxSskXBlMzzjDPAfBiEQBpSdFtmYjKthWPSNWRpJcH
         cWddP2MxHLrYPzsNSGKS9dVyvm0D9SWiprP+385BF2zF7P3mZjpJqk/jt/RaDeQOsXWU
         bJ3lC3XOxMrn2r8Qw8ECdR1UcxSEhaI3QupYeQXTf5hfNZdOJLuWc3Fsg/CLSGXlBNd1
         YRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SbxFKEWK4K5uHVRHdbfbBiahcsHx60mb7aYknqB5Omk=;
        fh=gwiwl2zfdBBWpmeTD6OX33n9XSrrFSN59D8Pc3JPwzo=;
        b=fLtKFbf0rEZ/m+zaZGclOOOcJuzhGuhkJBbnR2ClYawrtsvDnOo7rMza84yXQiAQGn
         +jNwcRhHf5op3XrTINnh/s4Jx1l5Lu2C0RkLH5dMVK2OG52JE/fdzRSGsy6itUlqTRvh
         +0ODkSn2YMPaAu68+Dh6YDGUCjpRFYlUPX0PtUljvHvdve0v5t1cQabDMpTsSukRyAVm
         OP/oxnRge35DtwXN8iP7PxY4gL1Jk/KYCc5W3V9rGvo1tMWyhGWd88HZ+hHeZab5ic0p
         U/NE7HJp/5oOlV2t/lt8cUFxoeY42UhFimLvokY3EM+kDHNIvZA9BYh7GK3y6u2mqRLA
         D6/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788342447; x=1788947247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SbxFKEWK4K5uHVRHdbfbBiahcsHx60mb7aYknqB5Omk=;
        b=DznuSgJjEfPqheoBFOIYjwS4ZvUfdCk9nu2swUTEPjxeKcK/zrRqWAo5Euk2MI2OaB
         xGF+LkkI5C4VNs6PDQaTdNwEmfpSOSKgIkcA5/ckBcZMPqslOewIRuOEMyu28c4HIJOG
         Wn3doL8+SXjztckqHwtWEz0+3qdpBSNIxZZ07YHHCqrrjUkZu6F6xw/H8jlppiiuaDDw
         1TX7hgVQ7RTGJH8L2h5nXzM354xhM/exWorqK+c+iD8Dm5gGE2ViNAA8R1KccXpefsPq
         BhxEtSx0nn3uC1fc2DyYlzvPbG1tsI2u/IKY+w7OZzjrNkdCB60j4s0MaHFrZEdutRfU
         02dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788342447; x=1788947247;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SbxFKEWK4K5uHVRHdbfbBiahcsHx60mb7aYknqB5Omk=;
        b=VRFSq6qX+tbJSBwQHsKwNmVfuEinnzQWqHYv8zLcU+2YDXtKQ6U9W0HQZPbMEGgCLS
         4LsUW9PtADyuReKbxtnXJC6JAemoc9Ffl05ZTbwQLfh4cdDfGIMv0jj2LsBemPFs7wWb
         RWnrkIKb869WRl+jI/3bGQVNXkS2B1VXAAkBdswyVN34VpTCn+gGO56/iGYZqS2Ellc8
         dvefzqw23WVj8okZ2FKExf3/qB06Et4F1C4iypvFKHdWPpW4SHIuFAiOtJGQUn7y3bUy
         FEelkYVc3TNYxIHtLERGz1b6g4L/p8ZPlU4fdXmjrLsFpPCAbG2+cVdJIr0iquGTtevj
         VSUg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/OiBrlEW5ntkPAUBxNwM4nezdJWZPAnySS11qmH+5pALImGTTUFJ8xAneA277cC2oAYw=@vger.kernel.org
X-Gm-Message-State: AFuF++ml2cpN/NYGlqr8yY/N//MoLfXJn7S3JIvosrUvJHdA0nT0KlaW
	mE95EhQ45mf5vKhIKqtGEJhxI9FWAv1n9etm5UYj7/k+e0LW5w4rFnq5RrfPQYk3K1OZgGzJQSf
	64U27wqFZlSSA9nE4fehFlWaBFVaK95w=
X-Gm-Gg: AR+sD12UFhIsSoWwssaQPm0gQDZHXKZizwxUxoEw7aqbbzBc1rP2YD5Stwx7flFd2pB
	HHSEfK76ejtNEEGLKdQ7STDAF1M8+7YdNc8cK5Ul2t7yJz0iAAQ0lPUM7vrES2BJFBFkAV8yBu5
	LYvQmMoIHG3CNffOo4drtGQbT39a93uxYwgdiduV5uuj1VEep7mDeY2QuAwlNEJiUaUN4eJULd6
	jqMkc4kzij6HasyDvxOB5rFFh6lRZZcP1sD0qHeZGHHRVizr8pu1ZVQxpEducnQtE/VtsccH39k
	3kC6i9M/9LcwXHBaeUYpevTHRvgdbE3/k6B1YoobhqlF3+sE5HFh73K+0ABoRZcD1vKCK9P+G9c
	P
X-Received: by 2002:a05:600c:34c2:b0:499:7219:122f with SMTP id
 5b1f17b1804b1-49ce581f2d9mr66403935e9.4.1788342446536; Wed, 02 Sep 2026
 02:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831074937.2380914-1-kunwu.chan@linux.dev>
 <0eac36c5-acd2-4d8d-a498-f56a57cc3d6a@paulmck-laptop> <CAN_Opa_z4e8fLM0=+QV82r4oveKKUWitvNrBnsfJhXd+2-QQLQ@mail.gmail.com>
 <ce1789d4-7a78-456c-9e6e-e9af824e5285@paulmck-laptop> <CAN_Opa_AYw-KSA-u5=fjGLOP9z-Cf1Dk2Fba==MSLAX7TZSYWQ@mail.gmail.com>
 <e521bee4-e8ab-40a2-b22f-325d37fbcd63@paulmck-laptop> <CAN_Opa_7gKNuibT07tM=TcMYoTEzjeBO_=9WCoxVnY=-Jq2hcg@mail.gmail.com>
 <eeba30f0-5a74-42ce-b559-dec079c8b84a@paulmck-laptop>
In-Reply-To: <eeba30f0-5a74-42ce-b559-dec079c8b84a@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 2 Sep 2026 17:47:14 +0800
X-Gm-Features: AcwNN1XI89SvgVNfwxk4vkLvufUvXUYDxK0wtXaBjT9rXa_MOJ7v1vm1neB0X4g
Message-ID: <CAN_Opa_aRqEvnni_3yuAMkugZnY9L7C-_OxQqaYhEp-E9amtzg@mail.gmail.com>
Subject: Re: [PATCH] srcutiny: Add atomic SRCU operation checks and state
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 1:20=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Wed, Sep 02, 2026 at 11:05:22AM +0800, KunWu Chan wrote:
> > On Wed, Sep 2, 2026 at 12:52=E2=80=AFAM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Tue, Sep 01, 2026 at 04:29:05PM +0800, KunWu Chan wrote:
> > > > On Tue, Sep 1, 2026 at 11:10=E2=80=AFAM Paul E. McKenney <paulmck@k=
ernel.org> wrote:
> > > > >
> > > > > On Tue, Sep 01, 2026 at 10:00:24AM +0800, KunWu Chan wrote:
> > > > > > On Tue, Sep 1, 2026 at 9:04=E2=80=AFAM Paul E. McKenney <paulmc=
k@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Aug 31, 2026 at 03:49:37PM +0800, Kunwu Chan wrote:
> > > > > > > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > > > > > >
> > > > > > > > Add atomic SRCU operation checks and the associated state t=
o Tiny
> > > > > > > > SRCU.
> > > > > > > >
> > > > > > > > An atomic SRCU domain does not use the normal SRCU callback=
 and
> > > > > > > > grace-period machinery.  In particular, a callback queued w=
ith
> > > > > > > > call_srcu() would never be processed.  Use WARN_ON_ONCE() t=
o reject
> > > > > > > > call_srcu() and srcu_barrier() on atomic SRCU domains.
> > > > > > > >
> > > > > > > > For synchronize_srcu(), redirect atomic SRCU domains to
> > > > > > > > synchronize_srcu_atomic().
> > > > > > > >
> > > > > > > > Add srcu_reader_flavor to the Tiny SRCU state for these che=
cks.
> > > > > > > > Tiny SRCU does not currently set the flavor for atomic SRCU=
 domains,
> > > > > > > > but keeping the flavor in the common state allows the opera=
tion
> > > > > > > > checks to enforce the restriction once atomic flavor tracki=
ng is
> > > > > > > > enabled.
> > > > > > > >
> > > > > > > > Also initialize srcu_atomic_gp_flag, which was previously l=
eft
> > > > > > > > uninitialized.
> > > > > > > >
> > > > > > > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > > > > > > > ---
> > > > > > > >  include/linux/srcutiny.h |  1 +
> > > > > > > >  kernel/rcu/srcutiny.c    | 12 ++++++++++++
> > > > > > > >  2 files changed, 13 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/include/linux/srcutiny.h b/include/linux/srcut=
iny.h
> > > > > > > > index 47a368f945e3..2b293336525a 100644
> > > > > > > > --- a/include/linux/srcutiny.h
> > > > > > > > +++ b/include/linux/srcutiny.h
> > > > > > > > @@ -20,6 +20,7 @@ struct srcu_struct {
> > > > > > > >       u8 srcu_gp_running;             /* GP workqueue runni=
ng? */
> > > > > > > >       u8 srcu_gp_waiting;             /* GP waiting for rea=
ders? */
> > > > > > > >       u8 srcu_atomic_gp_flag;         /* Serialize atomic G=
P work.*/
> > > > > > > > +     u8 srcu_reader_flavor;          /* Values: SRCU_READ_=
FLAVOR_.*  */
> > > > > > > >       unsigned long srcu_idx;         /* Current reader arr=
ay element in bit 0x2. */
> > > > > > > >       unsigned long srcu_idx_max;     /* Furthest future sr=
cu_idx request. */
> > > > > > > >       struct swait_queue_head srcu_wq;
> > > > > > > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > > > > > > > index 26ea4bfbeaf2..22f7716cbb0e 100644
> > > > > > > > --- a/kernel/rcu/srcutiny.c
> > > > > > > > +++ b/kernel/rcu/srcutiny.c
> > > > > > > > @@ -41,6 +41,7 @@ static int init_srcu_struct_fields(struct=
 srcu_struct *ssp)
> > > > > > > >       ssp->srcu_cb_tail =3D &ssp->srcu_cb_head;
> > > > > > > >       ssp->srcu_gp_running =3D false;
> > > > > > > >       ssp->srcu_gp_waiting =3D false;
> > > > > > > > +     ssp->srcu_atomic_gp_flag =3D 0;
> > > > > > >
> > > > > > > Good catch!  I will be folding this into the base commit with=
 attribution
> > > > > > > on my next rebase:
> > > > > > >
> > > > > > > 9a2e9996ccec ("srcutiny: Add an atomic Tiny SRCU")
> > > > > > >
> > > > > > > >       ssp->srcu_idx =3D 0;
> > > > > > > >       ssp->srcu_idx_max =3D 0;
> > > > > > > >       INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
> > > > > > > > @@ -289,6 +290,9 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain);
> > > > > > > >  void call_srcu(struct srcu_struct *ssp, struct rcu_head *r=
hp,
> > > > > > > >              rcu_callback_t func)
> > > > > > > >  {
> > > > > > > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D SRCU_=
READ_FLAVOR_ATOMIC))
> > > > > > > > +             return;
> > > > > > > > +
> > > > > > > >       if (should_rcu_defer()) {
> > > > > > > >               /* A re-entrant call_srcu() during the drain =
would livelock it. */
> > > > > > > >               if (READ_ONCE(srcu_defer_draining) && !in_nmi=
()) {
> > > > > > > > @@ -319,6 +323,11 @@ void synchronize_srcu(struct srcu_stru=
ct *ssp)
> > > > > > > >  {
> > > > > > > >       struct rcu_synchronize rs;
> > > > > > > >
> > > > > > > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D SRCU_=
READ_FLAVOR_ATOMIC)) {
> > > > > > > > +             synchronize_srcu_atomic(ssp);
> > > > > > > > +             return;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > >       srcu_lock_sync(&ssp->dep_map);
> > > > > > > >
> > > > > > > >       RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
> > > > > > > > @@ -415,6 +424,9 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_atom=
ic);
> > > > > > > >  /* Register any deferred callbacks, then wait for all in-f=
light ones. */
> > > > > > > >  void srcu_barrier(struct srcu_struct *ssp)
> > > > > > > >  {
> > > > > > > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D SRCU_=
READ_FLAVOR_ATOMIC))
> > > > > > > > +             return;
> > > > > > > > +
> > > > > > > >       __srcu_defer_drain(ssp);
> > > > > > > >       synchronize_srcu(ssp);
> > > > > > > >  }
> > > > > > >
> > > > > > > The rest is good as far as it goes, but don't we need to set =
the value
> > > > > > > of ssp->srcu_reader_flavor somewhere for atomic srcu_struct s=
tructures?
> > > > > > >
> > > > > >
> > > > > > Hi Paul,
> > > > > >
> > > > > > Yes, agreed. I have the flavor tracking changes implemented loc=
ally
> > > > > > and am testing them now.
> > > > > > I=E2=80=99ll send the updated patch shortly.
> > > > > >
> > > > > > I also have draft patches for the documentation and the fast pa=
th, as
> > > > > > well as rcutorture testing for
> > > > > > tiny atomic srcu , which I=E2=80=99ll send separately.
> > > > >
> > > > > Sounds good, and I am looking forward to seeing them.
> > > >
> > > > Hi Paul,
> > > > I=E2=80=99ve sent the flavor tracking changes as [1].
> > > > [1] https://lore.kernel.org/all/20260901074815.3145037-1-kunwu.chan=
@linux.dev/
> > > >
> > > > >
> > > > > I will admit that I am curious as to why Tiny Atomic SRCU needs d=
ifferent
> > > > > rcutorture testing than does Tree Atomic SRCU, but I will ask mys=
elf
> > > > > that question again when I see your patches.  ;-)
> > > >
> > > > You=E2=80=99re right that the existing SRCU torture configuration c=
an exercise
> > > > the atomic path with rcutorture.reader_flavor=3D0x10. I had prepare=
d
> > > > the Tiny atomic torture test as a separate draft, mainly adding loc=
al
> > > > configurations for convenience while validating the Tiny and Tree
> > > > atomic paths. There is no Tiny-specific torture model here.
> > > >
> > > > I can adjust the final rcutorture configuration and naming based on=
 your
> > > > preference.
> > >
> > > The best approach is to add a section to this script:
> > >
> > > tools/testing/selftests/rcutorture/bin/torture.sh
> > >
> > > This would require adding a command-line parameter such as
> > > --do-atomic-srcu and friends.  The effect would be that people like
> > > me would run short tests of atomic SRCU frequently.
> >
> > Thanks Paul. I=E2=80=99ll add an atomic SRCU option to
> > torture.sh so that it can be run as a short, frequent test.
>
> Very good, looking forward to seeing it!
>
> > During my atomic SRCU testing, I noticed that kvm-recheck-rcu.sh
> > can report =E2=80=9CReader Batch close calls=E2=80=9D even though the k=
ernel reports
> > End of test: SUCCESS with no WARNING/BUG. The atomic GP rate is also
> > much higher than normal SRCU.
> >
> > I=E2=80=99m still checking whether this is inherent to atomic SRCU, rel=
ated to
> > my earlier fastpath change, or an interaction with the torture reader
> > delay. I=E2=80=99ll continue investigating this as part of the testing =
work.
>
> The close calls can happen due to memory reordering.  But this is new
> code, so please do check them carefully.
>

Thanks, Paul. That gives me a useful reference point.

> The high atomic grace-period rate is expected behavior.  On my x86
> laptop, I see about 75/second for Tree Atomic SRCU and about 300
> for Tiny.  But at your end, how high is high?

On my x86 PC, with the earlier fastpath change, I was seeing:
Tree Atomic SRCU: about 250=E2=80=93530 GPs/sec
Tiny Atomic SRCU: about 290 GPs/sec

After reverting the fastpath change, Tree Atomic SRCU dropped to about
129 GPs/sec, while Tiny remained around 291 GPs/sec. So the Tiny result
is close to your ~300/sec reference, while the Tree result is somewhat
higher than your ~75/sec observation.

The close-call behavior also changed with the fastpath. With the fastpath,
batch[2] was non-zero (6=E2=80=93334 in my runs). After reverting it, batch=
[2] was
consistently 0. batch[1] can still occur on Tree SRCU, but I have not
seen readers spanning 3 or more GPs.

I'll continue checking the close-call behavior with repeated torture runs, =
with
particular attention to the memory-ordering aspect you mentioned.

Thanks,
Kunwu

>
>                                                 Thanx, Paul
