Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002884A99AD
	for <rcu@vger.kernel.org>; Wed,  2 Sep 2026 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365607; cv=pass; b=MzX5PAIhQSRTuaBjzoXRl8udn91UNY95jOLs+0W83kfNmf0mRXQUjWJisgzT6S/citNfQgmCQbkfngJFWK7aGUX40NB4+6M8XJu0C7VR8NtK7YLAAbMNgwDww/UDi6FGYFORnJtaLD1Sh9krwaAYrgzx5ewcjcL7XoD30VOnAas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365607; c=relaxed/simple;
	bh=Xwx+i8ie8iWt9T1gkOr8D3LhF3LdmlPxqV7GjAiFZAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2BZQuF9+YQ/3YjMUhQPeyIKdtXnhA8hq98jbICILiogMTgHEwE4TTUCbObPSS9/Elfu7j0FIOzlhT9yR4mYxNDKqvBC1Yd0ii4UvMB9bzB3g7KsZ6Lpd1xgvT1MdR7OAqWaTN2b6XoVuUG8+K0JwJ9xZ5Vum4r/vTtwc6SWe/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XM2RNVB+; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM2RNVB+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso8838695e9.0
        for <rcu@vger.kernel.org>; Wed, 02 Sep 2026 09:13:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788365602; cv=none;
        d=google.com; s=arc-20260327;
        b=iWywq61hoWioseAD1GlJ0f5/dbjjBHMpXHpenkZJ4yUqIB4lMf1BwcYUH6FD4VDZhj
         EmBj6fXVfuwSivmj+T+i/6A/Fl+2bhXdS12yp+Xkip3WO7jUbtWFDGar2mAuKSaQC55Y
         UuV31ypWrlaHeDNikm2FFpAzjjhpFja4Mr9NeqnWdw006I+FwHLWyOzFu8/IdrAVU381
         K/tX4/9rM2u4kFUap3PxZmb/2/GVglGmuITUa3EZg1wqy47GCPvw7jqL3BxQuQtvTjKk
         C8CdGcQTY6pa6PzjKWy5lIVs1YNEPcrilh8p8A8l41dkGHNKYBZThdYY316CIKB09J9a
         EZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qdS3hS3kVE/eGxKJX6EKacC7t5SUHZQkdHOd2e2KnX0=;
        fh=lOGGdyeT7sDkSKE8pSdcbr26MubtWnogNnrZpZfYIrI=;
        b=BpbccAP47c4ikXqTGxFx80K/6jR4AaXnT9s434CmYg3uJBKxTxMaSYaky5m5bRXnOE
         Rxi9hjbMxiFdNJFAIXAeHnml8gelTPWcuMb9DInY43dXpgmf64VuK5zMQ8GuugbKmN/p
         reOFzjrNlDnOQj+fFjsfZEJtFMlyVhnsyMrcYgxoPNFpm0eGsYMD9radwHjcTgC5+mVK
         lNNXBhkLAJE8o5ijvWo8rDy7WrTIWBNG9rEPQSyWQKkWOZFOZZrrUQB0SRQ04ecK1/sc
         rqDGEHP1wYhP8I8rVpo4x40VI/kdnvAelPao2rv/7tJIMA2PCsr7T09TdaDxkRIerg5K
         uTZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788365602; x=1788970402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qdS3hS3kVE/eGxKJX6EKacC7t5SUHZQkdHOd2e2KnX0=;
        b=XM2RNVB+duezqXN8bttNExi9usm0mzUJXgXovPdymOoPnOs4P+Y+O/vd7Mn2jT9dCB
         kMheAFbBuAiLDurgsqgHKsK2sVv4mJeaqjjDOB9L2YqpV/BhF55kdsExZFbc1StTGCv2
         qJG2t9WERoL1Q82RlFzyeovr4LRhqf04w8UC4RixWSq1QibVxpvCO6fXelCVKwFB9X5V
         hdqmdL1CX1ozyXJRQu4y7/xfPyae8pXGH8K+Ytw5cxzyVBybU0mNvOa3wIH/WKlSH7/E
         Zhw2/gxzouHiNxib4H9j3LoXMX3NwIkLITYflN9Di4vFZ48Y4xPZ3wRprRQXt8IBlFqn
         XhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365602; x=1788970402;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qdS3hS3kVE/eGxKJX6EKacC7t5SUHZQkdHOd2e2KnX0=;
        b=O/eQqpWvTBhEmREOX1ZKjL/jQyYT7ldjyzb1kGm7VVNncFAjZiv9SX3s9P80S/UI/P
         RhJkTmBB/s4MTw8/naB4Lk2GM33MW35oMbd2imwBR6mLnAFlO+Mqj82SmXcxf1Pi9fW7
         vaL5Orh/S1+MkSkUqyrX8Qy+STHfkxa/pUHe0pFEp9AKvWQwpOyJS/cg3xhAoX69672i
         OcNHwdYzNA3zE8my6xgGV9fzxgDCkmx+snun5SFKSwzoGkC9R7Mn6YDUadmjaowkrjA8
         NYw6ckPzbxPEJuPE3aWp68A5HnLw78LYD7sxT6OW2rA8DLNIMdMWjsBFatZ1TMI95rLk
         1DmA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5pRrVnzeJmxexeD/qyBugNpN+zrtn8VaYSnXXjTkbqwA9+10UTzccKAEeMke3xe+/h70=@vger.kernel.org
X-Gm-Message-State: AFuF++lYKH4zkwcEbQFEMcv9+q4/etJoY8ZkgJQ8UE2D9hUtiIfTeYpM
	NT5HUMenK3/iDdJrLTxq/z8QJrXrk+yYIzwhY8ajcGMyi74aF/EfmmJuigQQg9Ulc5+eA3rvYBl
	sNhCpm64U036qlVvZn6Ot+45leKWRfG4=
X-Gm-Gg: AR+sD10jAKA13G9AdYJJrSb/K68gCQtEJmD2GNIJzEjK35rwrzp2yHLYfWafStcej3I
	AAhjUX/QAwtTWHHow1vHumRsllsWxP6bCYelrcYjCEr34WH3L2KqGev3J84jsCkzfOwbMJzxVMn
	d4U1tBC14bYlzg8cEz9oNTvqCxxFKYgbe2D7ECwKCjcSFJ0mSCP+U6HY9DDkc/B91yklDhN09ru
	L75/bhc32NBwrPRuPigkcn4KPW+bJ/CorJjfws99Vs7tZWyVOP3fET8IEhDGGbm/wHOqL8NJ3V7
	eLVbHxbZIi5PaO7PA4EPpP5ScGOqIT49GfeS5uaScDpqmwtiWLgb9AwbiUntQDAS+iLybKBnhCL
	gHA==
X-Received: by 2002:a05:600c:4e87:b0:49c:dc14:d681 with SMTP id
 5b1f17b1804b1-49ce580a50cmr82648105e9.3.1788365601129; Wed, 02 Sep 2026
 09:13:21 -0700 (PDT)
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
 <eeba30f0-5a74-42ce-b559-dec079c8b84a@paulmck-laptop> <CAN_Opa_aRqEvnni_3yuAMkugZnY9L7C-_OxQqaYhEp-E9amtzg@mail.gmail.com>
 <ab114f9f-ccb2-4d51-a7e7-f66275d2cd57@paulmck-laptop>
In-Reply-To: <ab114f9f-ccb2-4d51-a7e7-f66275d2cd57@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 3 Sep 2026 00:13:08 +0800
X-Gm-Features: AcwNN1UDipEhtIq8JbPgQQ0cCAU-NWAW9zxEaU3zTtwHovBlImSy3NwElXbihD8
Message-ID: <CAN_Opa8yY072zV=pVnkGPZwY8z9Wg0-vGHUCXM9R6E8mjnhCsQ@mail.gmail.com>
Subject: Re: [PATCH] srcutiny: Add atomic SRCU operation checks and state
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 11:40=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Sep 02, 2026 at 05:47:14PM +0800, KunWu Chan wrote:
> > On Wed, Sep 2, 2026 at 1:20=E2=80=AFPM Paul E. McKenney <paulmck@kernel=
.org> wrote:
> > > On Wed, Sep 02, 2026 at 11:05:22AM +0800, KunWu Chan wrote:
> > > > On Wed, Sep 2, 2026 at 12:52=E2=80=AFAM Paul E. McKenney <paulmck@k=
ernel.org> wrote:
> > > > > On Tue, Sep 01, 2026 at 04:29:05PM +0800, KunWu Chan wrote:
> > > > > > On Tue, Sep 1, 2026 at 11:10=E2=80=AFAM Paul E. McKenney <paulm=
ck@kernel.org> wrote:
> > > > > > > On Tue, Sep 01, 2026 at 10:00:24AM +0800, KunWu Chan wrote:
> > > > > > > > On Tue, Sep 1, 2026 at 9:04=E2=80=AFAM Paul E. McKenney <pa=
ulmck@kernel.org> wrote:
> > > > > > > > > On Mon, Aug 31, 2026 at 03:49:37PM +0800, Kunwu Chan wrot=
e:
> > > > > > > > > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > > > > > > > > Add atomic SRCU operation checks and the associated sta=
te to Tiny
> > > > > > > > > > SRCU.
> > > > > > > > > >
> > > > > > > > > > An atomic SRCU domain does not use the normal SRCU call=
back and
> > > > > > > > > > grace-period machinery.  In particular, a callback queu=
ed with
> > > > > > > > > > call_srcu() would never be processed.  Use WARN_ON_ONCE=
() to reject
> > > > > > > > > > call_srcu() and srcu_barrier() on atomic SRCU domains.
> > > > > > > > > >
> > > > > > > > > > For synchronize_srcu(), redirect atomic SRCU domains to
> > > > > > > > > > synchronize_srcu_atomic().
> > > > > > > > > >
> > > > > > > > > > Add srcu_reader_flavor to the Tiny SRCU state for these=
 checks.
> > > > > > > > > > Tiny SRCU does not currently set the flavor for atomic =
SRCU domains,
> > > > > > > > > > but keeping the flavor in the common state allows the o=
peration
> > > > > > > > > > checks to enforce the restriction once atomic flavor tr=
acking is
> > > > > > > > > > enabled.
> > > > > > > > > >
> > > > > > > > > > Also initialize srcu_atomic_gp_flag, which was previous=
ly left
> > > > > > > > > > uninitialized.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > >  include/linux/srcutiny.h |  1 +
> > > > > > > > > >  kernel/rcu/srcutiny.c    | 12 ++++++++++++
> > > > > > > > > >  2 files changed, 13 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/include/linux/srcutiny.h b/include/linux/s=
rcutiny.h
> > > > > > > > > > index 47a368f945e3..2b293336525a 100644
> > > > > > > > > > --- a/include/linux/srcutiny.h
> > > > > > > > > > +++ b/include/linux/srcutiny.h
> > > > > > > > > > @@ -20,6 +20,7 @@ struct srcu_struct {
> > > > > > > > > >       u8 srcu_gp_running;             /* GP workqueue r=
unning? */
> > > > > > > > > >       u8 srcu_gp_waiting;             /* GP waiting for=
 readers? */
> > > > > > > > > >       u8 srcu_atomic_gp_flag;         /* Serialize atom=
ic GP work.*/
> > > > > > > > > > +     u8 srcu_reader_flavor;          /* Values: SRCU_R=
EAD_FLAVOR_.*  */
> > > > > > > > > >       unsigned long srcu_idx;         /* Current reader=
 array element in bit 0x2. */
> > > > > > > > > >       unsigned long srcu_idx_max;     /* Furthest futur=
e srcu_idx request. */
> > > > > > > > > >       struct swait_queue_head srcu_wq;
> > > > > > > > > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutin=
y.c
> > > > > > > > > > index 26ea4bfbeaf2..22f7716cbb0e 100644
> > > > > > > > > > --- a/kernel/rcu/srcutiny.c
> > > > > > > > > > +++ b/kernel/rcu/srcutiny.c
> > > > > > > > > > @@ -41,6 +41,7 @@ static int init_srcu_struct_fields(st=
ruct srcu_struct *ssp)
> > > > > > > > > >       ssp->srcu_cb_tail =3D &ssp->srcu_cb_head;
> > > > > > > > > >       ssp->srcu_gp_running =3D false;
> > > > > > > > > >       ssp->srcu_gp_waiting =3D false;
> > > > > > > > > > +     ssp->srcu_atomic_gp_flag =3D 0;
> > > > > > > > >
> > > > > > > > > Good catch!  I will be folding this into the base commit =
with attribution
> > > > > > > > > on my next rebase:
> > > > > > > > >
> > > > > > > > > 9a2e9996ccec ("srcutiny: Add an atomic Tiny SRCU")
> > > > > > > > >
> > > > > > > > > >       ssp->srcu_idx =3D 0;
> > > > > > > > > >       ssp->srcu_idx_max =3D 0;
> > > > > > > > > >       INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
> > > > > > > > > > @@ -289,6 +290,9 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain)=
;
> > > > > > > > > >  void call_srcu(struct srcu_struct *ssp, struct rcu_hea=
d *rhp,
> > > > > > > > > >              rcu_callback_t func)
> > > > > > > > > >  {
> > > > > > > > > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D S=
RCU_READ_FLAVOR_ATOMIC))
> > > > > > > > > > +             return;
> > > > > > > > > > +
> > > > > > > > > >       if (should_rcu_defer()) {
> > > > > > > > > >               /* A re-entrant call_srcu() during the dr=
ain would livelock it. */
> > > > > > > > > >               if (READ_ONCE(srcu_defer_draining) && !in=
_nmi()) {
> > > > > > > > > > @@ -319,6 +323,11 @@ void synchronize_srcu(struct srcu_=
struct *ssp)
> > > > > > > > > >  {
> > > > > > > > > >       struct rcu_synchronize rs;
> > > > > > > > > >
> > > > > > > > > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D S=
RCU_READ_FLAVOR_ATOMIC)) {
> > > > > > > > > > +             synchronize_srcu_atomic(ssp);
> > > > > > > > > > +             return;
> > > > > > > > > > +     }
> > > > > > > > > > +
> > > > > > > > > >       srcu_lock_sync(&ssp->dep_map);
> > > > > > > > > >
> > > > > > > > > >       RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
> > > > > > > > > > @@ -415,6 +424,9 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_=
atomic);
> > > > > > > > > >  /* Register any deferred callbacks, then wait for all =
in-flight ones. */
> > > > > > > > > >  void srcu_barrier(struct srcu_struct *ssp)
> > > > > > > > > >  {
> > > > > > > > > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D S=
RCU_READ_FLAVOR_ATOMIC))
> > > > > > > > > > +             return;
> > > > > > > > > > +
> > > > > > > > > >       __srcu_defer_drain(ssp);
> > > > > > > > > >       synchronize_srcu(ssp);
> > > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > The rest is good as far as it goes, but don't we need to =
set the value
> > > > > > > > > of ssp->srcu_reader_flavor somewhere for atomic srcu_stru=
ct structures?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Hi Paul,
> > > > > > > >
> > > > > > > > Yes, agreed. I have the flavor tracking changes implemented=
 locally
> > > > > > > > and am testing them now.
> > > > > > > > I=E2=80=99ll send the updated patch shortly.
> > > > > > > >
> > > > > > > > I also have draft patches for the documentation and the fas=
t path, as
> > > > > > > > well as rcutorture testing for
> > > > > > > > tiny atomic srcu , which I=E2=80=99ll send separately.
> > > > > > >
> > > > > > > Sounds good, and I am looking forward to seeing them.
> > > > > >
> > > > > > Hi Paul,
> > > > > > I=E2=80=99ve sent the flavor tracking changes as [1].
> > > > > > [1] https://lore.kernel.org/all/20260901074815.3145037-1-kunwu.=
chan@linux.dev/
> > > > > >
> > > > > > >
> > > > > > > I will admit that I am curious as to why Tiny Atomic SRCU nee=
ds different
> > > > > > > rcutorture testing than does Tree Atomic SRCU, but I will ask=
 myself
> > > > > > > that question again when I see your patches.  ;-)
> > > > > >
> > > > > > You=E2=80=99re right that the existing SRCU torture configurati=
on can exercise
> > > > > > the atomic path with rcutorture.reader_flavor=3D0x10. I had pre=
pared
> > > > > > the Tiny atomic torture test as a separate draft, mainly adding=
 local
> > > > > > configurations for convenience while validating the Tiny and Tr=
ee
> > > > > > atomic paths. There is no Tiny-specific torture model here.
> > > > > >
> > > > > > I can adjust the final rcutorture configuration and naming base=
d on your
> > > > > > preference.
> > > > >
> > > > > The best approach is to add a section to this script:
> > > > >
> > > > > tools/testing/selftests/rcutorture/bin/torture.sh
> > > > >
> > > > > This would require adding a command-line parameter such as
> > > > > --do-atomic-srcu and friends.  The effect would be that people li=
ke
> > > > > me would run short tests of atomic SRCU frequently.
> > > >
> > > > Thanks Paul. I=E2=80=99ll add an atomic SRCU option to
> > > > torture.sh so that it can be run as a short, frequent test.
> > >
> > > Very good, looking forward to seeing it!
> > >
> > > > During my atomic SRCU testing, I noticed that kvm-recheck-rcu.sh
> > > > can report =E2=80=9CReader Batch close calls=E2=80=9D even though t=
he kernel reports
> > > > End of test: SUCCESS with no WARNING/BUG. The atomic GP rate is als=
o
> > > > much higher than normal SRCU.
> > > >
> > > > I=E2=80=99m still checking whether this is inherent to atomic SRCU,=
 related to
> > > > my earlier fastpath change, or an interaction with the torture read=
er
> > > > delay. I=E2=80=99ll continue investigating this as part of the test=
ing work.
> > >
> > > The close calls can happen due to memory reordering.  But this is new
> > > code, so please do check them carefully.
> >
> > Thanks, Paul. That gives me a useful reference point.
> >
> > > The high atomic grace-period rate is expected behavior.  On my x86
> > > laptop, I see about 75/second for Tree Atomic SRCU and about 300
> > > for Tiny.  But at your end, how high is high?
> >
> > On my x86 PC, with the earlier fastpath change, I was seeing:
> > Tree Atomic SRCU: about 250=E2=80=93530 GPs/sec
> > Tiny Atomic SRCU: about 290 GPs/sec
> >
> > After reverting the fastpath change, Tree Atomic SRCU dropped to about
> > 129 GPs/sec, while Tiny remained around 291 GPs/sec. So the Tiny result
> > is close to your ~300/sec reference, while the Tree result is somewhat
> > higher than your ~75/sec observation.
> >
> > The close-call behavior also changed with the fastpath. With the fastpa=
th,
> > batch[2] was non-zero (6=E2=80=93334 in my runs). After reverting it, b=
atch[2] was
> > consistently 0. batch[1] can still occur on Tree SRCU, but I have not
> > seen readers spanning 3 or more GPs.
>
> These results suggest that you should very carefully check memory orderin=
g
> in the fastpath code.
>

Thanks, Paul. I appreciate the reminder.
I'll carefully verify the memory-ordering assumptions in the fastpath and
run more torture tests with the relevant configurations/architectures.

> > I'll continue checking the close-call behavior with repeated torture ru=
ns, with
> > particular attention to the memory-ordering aspect you mentioned.
>
> Sounds good, thank you!

Thanks again!
Kunwu

>
>                                                         Thanx, Paul
