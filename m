Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6AE4AA598
	for <rcu@vger.kernel.org>; Wed,  2 Sep 2026 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366605; cv=pass; b=io5zkxBQPMzG3Ul7AcIEdMauJ7DbMcgDqdZ/U81Y7GNXZ2QblqoSR27vB7Y7IY5bAKLZXb+j/fxVV/w2qEZGrLvEP6bB4fQ+d32LnvMVmofeQ0kUMFUmKiTNZZxcawHndC3RVlH+vL36YrBXiAKk8UxtZuuQv1XQJ95pWgdxKwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366605; c=relaxed/simple;
	bh=7rsEEZ3ERvpIWYXqCucWPYukdukzTS9mb89qv9jnrdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDu5Ph2soinWc4HME7hONzCitJhIn/iEc9MitcX9MesOq8y95cW7KrGlPgIxwt9EFhHvHYsr+C5dTBdig4rW7+2+cqM8iCfr0WIq1mgxBCUKb1otG4JYau0Jwzklz2fuqVUOC/p3n0jwKcLEiHLwCIJCQzk4c3Ew8BjPzon8rIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pd8lhp0k; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pd8lhp0k"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b8be0409fso9693995e9.2
        for <rcu@vger.kernel.org>; Wed, 02 Sep 2026 09:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788366601; cv=none;
        d=google.com; s=arc-20260327;
        b=oSXicVZCIECvXtwn2P4ToZoFv5rAcbXwovDERhKW6wL2jkx0ylk/rXF1x7SvxD0KWJ
         18JEjq7S8/ccv9D6FjlQZwvH2nFtmC4al9WBBUrlfjIEtVM1yRYY4MJ9Tz8EcZfPuCst
         WB7CCl3GbuTyHeQo+XhZQiOkVTrPiwrWn80ygboY/dPs0TJCfsAwTrQ1VAr0TQrnnvAl
         3uW1ZmjDM+4sZcjNf/kooHNo+oup9u+JACbLaMUZkPeIXxT++xuUpbua648VY7yhGLpd
         taP7ZQuv8HTqCIELEVPG/oXp8rXviSaDdYqmq0FX6xFc9cflMLJJA0zo+U5Lq6L0DkJg
         syIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DAYPv+x64zvGkdxTQHdsbHb8HeOUzt1Pp1bibLWOPU0=;
        fh=xkMoHHIy8jrevK+3sunIvNyefPmelE3/VteERbDduYQ=;
        b=gpm7te3JvYDxvqneOMLMWZdMpzU4Zaz8cmL1Pk82X8CcwqKZ5uwlAtXytxtQfP+CFX
         XuRJkRlRX8OvdEGF2lfK6cCiOcJvB3ITp8cKKIqjde9NWL5wFDeeHOXv0bx30WqSd/GF
         bu74LkKtvSXhxCv9TG0MCiMY+XfHM2j9sZxrNSyWnk6OFg6dWYk+W+fsIB3yk9zAS8ay
         sMxUC1V68umCvURXtPYrDWkyv/5ymQKu9pPSF1H2BAoYPwp41UXlgbTgM7jQJ5aq1PBc
         05lKUIY0gldXi9ZR6FLCDO2yPxaYaMBLqVaMCha5wUsO+i8rHly3efA4tV270bImO6SA
         vjYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788366601; x=1788971401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DAYPv+x64zvGkdxTQHdsbHb8HeOUzt1Pp1bibLWOPU0=;
        b=pd8lhp0km/kccgImwLOwLjollD1DJ23BmXXiN+mjvnmFx5Lx8kxfrWZtxlp00/afTQ
         2Up4BLG/geByOCK58bBewa0U9tnb+JZSuE1KynywJu7rIT0i64cH3DfPzv5mLGo63Ka7
         xr8SaCLOlRiPKHQYIVr6+Z/tbvB7nLubEyDcRL7tfABX3iyy09fxwMObGNvEy/gePdML
         sWRprIDDl6w3RlE8Da5cDi29MhL6myjrvLD1soIrUYTsl3/heWzWcofF2ew6IVxP5qNz
         btDHhA5fcUnyPcFHUUd3jkNS0Vrd3P3Y7TN7u4H3SrEn3IEcvA94RyV2FjHoQLZVW/ue
         cksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366601; x=1788971401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DAYPv+x64zvGkdxTQHdsbHb8HeOUzt1Pp1bibLWOPU0=;
        b=j6Tdfe5xPjJ+K9/PgsVIwgYXe8aj1ygZCyN0J759poNrMrjqgePj/MCIp5P/ZwuF0T
         Fgy5CtWzaTEV2Dqo2ART6bY9mT1G6uXBM704fpkShJfWuJ2YqVt5zK85sDjtVW5VWaeP
         9FZhBRbeCwFgSRoR8PYT4d6m57aGDCvFD4tm9kbrlAjI0Ns4tR6zA48gPtw2vSAAEa9y
         F6VV5jjmL8cgsf0J3NQVzWxcR8wMZ7eFAg+zQhxS4NwExUqjZSCW+8Z/89XA7sCfzVPC
         FsvVufAL1EnSKqgZxu1uT86t7c5KhpfXuBNkZqRLNVtdEh+/YaPO4iSoSmWNWwuU6rjO
         V8vA==
X-Forwarded-Encrypted: i=1; AHgh+Rpo2V8x5icjjjCwsAU2hNgKGrw6IsWHyTThtvF0r2zW/C2SI/cpAPOKFGLGJ6BIrU75ycM=@vger.kernel.org
X-Gm-Message-State: AFuF++l8BB77LtMmtYOKltm693r/7i05eyUYtMKSJMh5rA8tEKbbOlNm
	wmXMDM2IyMa3NJTPNdU8Vw3ibrokSaXQ8d2hhLaPyVldfTzkwg2TdtpgZYLhUS7a8LI63xbWSeN
	n7bM4kH7K+peVThWyGv7GZ3MCHzyLH8xmleDGhoA=
X-Gm-Gg: AR+sD12RRTKaYjE3VycQv8aEAS2taSpJMHtezsVF7TmOCfqRdyk9lzjb6vuY9+gPkef
	Zb+bN/C8Ahgt+kit9mE1fjBJmNw41KPgGb+LI30IHpPszF30ESQQMIDulrJyO/Cb/MLbLLufmVM
	owTkHuMlYSOetC23DJjvmtNraU238qTPcPa+o51QKdx9C7bNxS3rPUCd1dGmxWbPK4RYAt+2jGP
	PRGtSiI32So393UDxqk7mvdkQq+e3QQbv66ZMu1zZucU942+4yTSTHuKqMz1VhET8IjHn9ySVcY
	HO+6xrSzIg2X9MSiMaaoYOsPAhUSlFf6As1cX64JHyI2bAPxgHDiOFKN1h3096tME5qa1qxkBG0
	zPSE=
X-Received: by 2002:a05:600c:1914:b0:49c:d294:41e5 with SMTP id
 5b1f17b1804b1-49ce581acaamr95538775e9.8.1788366599990; Wed, 02 Sep 2026
 09:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901074815.3145037-1-kunwu.chan@linux.dev>
 <d991297a-9bd4-4da2-89cd-002b6f2a3305@paulmck-laptop> <CAN_Opa81BaWxkdRyoHQBcMLbOt-n7f-4cUmxxstage1MSOu1Hw@mail.gmail.com>
 <b099065c-5808-4eb6-9dba-fcba9a2ef9ea@paulmck-laptop>
In-Reply-To: <b099065c-5808-4eb6-9dba-fcba9a2ef9ea@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 3 Sep 2026 00:29:46 +0800
X-Gm-Features: AcwNN1WiUBPC7FZ1JHGisuLmXXH-1S-vs_fN7c7jt04V-RYxaDJVWuclKsYQIUY
Message-ID: <CAN_Opa_igCj1T+LJ+r8GjR4ky1SPK+HVTV_xn5Vpe3fycrLOoQ@mail.gmail.com>
Subject: Re: [PATCH] srcutiny: Enable atomic SRCU flavor tracking
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 11:43=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Sep 02, 2026 at 05:18:50PM +0800, KunWu Chan wrote:
> > On Wed, Sep 2, 2026 at 1:11=E2=80=AFAM Paul E. McKenney <paulmck@kernel=
.org> wrote:
> > >
> > > On Tue, Sep 01, 2026 at 03:48:15PM +0800, Kunwu Chan wrote:
> > > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > >
> > > > Set srcu_reader_flavor to SRCU_READ_FLAVOR_ATOMIC in the Tiny SRCU
> > > > atomic initialization paths, so that the entry-point checks added b=
y
> > > > the previous commit can identify atomic SRCU domains.
> > > >
> > > > For static initialization, add a flavor parameter to
> > > > __SRCU_STRUCT_INIT() and pass SRCU_READ_FLAVOR_ATOMIC through
> > > > DEFINE_SRCU_ATOMIC() and DEFINE_STATIC_SRCU_ATOMIC().
> > > >
> > > > For dynamic initialization, initialize srcu_reader_flavor to zero i=
n
> > > > init_srcu_struct_fields() for the generic initialization path, and
> > > > set it to SRCU_READ_FLAVOR_ATOMIC in init_srcu_struct_atomic().
> > > > Handle both CONFIG_DEBUG_LOCK_ALLOC and non-debug initialization pa=
ths.
> > > >
> > > > Enable srcu_check_read_flavor() for Tiny SRCU, matching the Tree SR=
CU
> > > > behavior, so that readers can verify that the requested flavor matc=
hes
> > > > the SRCU domain.
> > > >
> > > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > >
> > > Much better!  Please see below for additional questions and comments.
> >
> > Thanks Paul for the detailed reply.
> >
> > >
> > > > ---
> > > >  include/linux/srcutiny.h | 39 +++++++++++++++++++++++++++++-------=
---
> > > >  kernel/rcu/srcutiny.c    |  1 +
> > > >  2 files changed, 30 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > > > index 2b293336525a..9dce4b5aa084 100644
> > > > --- a/include/linux/srcutiny.h
> > > > +++ b/include/linux/srcutiny.h
> > > > @@ -40,7 +40,7 @@ void srcu_drive_gp(struct work_struct *wp);
> > > >  void srcu_tiny_irq_work(struct irq_work *irq_work);
> > > >  void srcu_defer_drain(struct irq_work *irq_work);
> > > >
> > > > -#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, ____ignore=
d) \
> > > > +#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, flavor)   =
           \
> > > >  {                                                                 =
   \
> > > >       .srcu_wq =3D __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),   =
     \
> > > >       .srcu_cb_tail =3D &name.srcu_cb_head,                        =
     \
> > > > @@ -49,6 +49,7 @@ void srcu_defer_drain(struct irq_work *irq_work);
> > > >       .defer_cbs =3D LLIST_HEAD_INIT(name.defer_cbs),              =
     \
> > > >       .defer_iw =3D { .node =3D { .u_flags =3D IRQ_WORK_HARD_IRQ },=
         \
> > > >                     .func =3D srcu_defer_drain },                  =
     \
> > > > +     .srcu_reader_flavor =3D flavor,                              =
     \
> > >
> > > Don't we also need to define srcu_reader_flavor?  Or is this patch
> > > supposed to be applied on top of your previous one?
> >
> > Yes, this is intended to be applied on top of the previous one [1].
> > [1] https://lore.kernel.org/rcu/20260831074937.2380914-1-kunwu.chan@lin=
ux.dev/
> >
> > > >       __SRCU_DEP_MAP_INIT(name)                                    =
   \
> > > >  }
> > > >
> > > > @@ -57,29 +58,43 @@ void srcu_defer_drain(struct irq_work *irq_work=
);
> > > >   * Tree SRCU, which needs some per-CPU data.
> > > >   */
> > > >  #define DEFINE_SRCU(name) \
> > > > -     struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name, na=
me, name)
> > > > +     struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name, na=
me, 0)
> > > >  #define DEFINE_STATIC_SRCU(name) \
> > > > -     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, n=
ame, name, name)
> > > > +     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, n=
ame, name, 0)
> > > >  #define DEFINE_SRCU_FAST(name) DEFINE_SRCU(name)
> > > >  #define DEFINE_STATIC_SRCU_FAST(name) \
> > > > -     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, n=
ame, name, name)
> > > > +     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, n=
ame, name, 0)
> > > >  #define DEFINE_SRCU_FAST_UPDOWN(name) DEFINE_SRCU(name)
> > > >  #define DEFINE_STATIC_SRCU_FAST_UPDOWN(name) \
> > > > -     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, n=
ame, name, name)
> > > > -#define DEFINE_SRCU_ATOMIC(name) DEFINE_SRCU(name)
> > > > +     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, n=
ame, name, 0)
> > > > +#define DEFINE_SRCU_ATOMIC(name) \
> > > > +     struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name, na=
me, SRCU_READ_FLAVOR_ATOMIC)
> > > >  #define DEFINE_STATIC_SRCU_ATOMIC(name) \
> > > > -     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, n=
ame, name, name)
> > > > +     static struct srcu_struct name =3D \
> > > > +             __SRCU_STRUCT_INIT(name, name, name, SRCU_READ_FLAVOR=
_ATOMIC)
> > > >
> > > >  // Dummy structure for srcu_notifier_head.
> > > >  struct srcu_usage { };
> > > >  #define __SRCU_USAGE_INIT(name) { }
> > > >  #define __init_srcu_struct_fast __init_srcu_struct
> > > >  #define __init_srcu_struct_fast_updown __init_srcu_struct
> > > > -#define __init_srcu_struct_atomic __init_srcu_struct
> > > > +#define __init_srcu_struct_atomic(ssp, name, key) \
> > > > +({ \
> > > > +     int __ret =3D __init_srcu_struct(ssp, name, key); \
> > > > +     if (!__ret) \
> > > > +             (ssp)->srcu_reader_flavor =3D SRCU_READ_FLAVOR_ATOMIC=
; \
> > > > +     __ret; \
> > > > +})
> > > >  #ifndef CONFIG_DEBUG_LOCK_ALLOC
> > > >  #define init_srcu_struct_fast init_srcu_struct
> > > >  #define init_srcu_struct_fast_updown init_srcu_struct
> > > > -#define init_srcu_struct_atomic init_srcu_struct
> > > > +#define init_srcu_struct_atomic(ssp)                              =
   \
> > > > +     ({                                                           =
   \
> > > > +             int __ret =3D init_srcu_struct(ssp);                 =
     \
> > > > +             if (!__ret)                                          =
   \
> > > > +                     (ssp)->srcu_reader_flavor =3D SRCU_READ_FLAVO=
R_ATOMIC;\
> > > > +             __ret;                                               =
   \
> > > > +     })
> > > >  #endif // #ifndef CONFIG_DEBUG_LOCK_ALLOC
> > > >
> > > >  void synchronize_srcu(struct srcu_struct *ssp);
> > > > @@ -148,7 +163,11 @@ static inline void synchronize_srcu_expedited(=
struct srcu_struct *ssp)
> > > >  void srcu_barrier(struct srcu_struct *ssp);
> > > >
> > > >  static inline void srcu_expedite_current(struct srcu_struct *ssp) =
{ }
> > > > -#define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
> > > > +#define srcu_check_read_flavor(ssp, read_flavor) \
> > > > +     ({ \
> > > > +             u8 __f =3D (ssp)->srcu_reader_flavor; \
> > > > +             WARN_ON_ONCE(__f && !(__f & (read_flavor))); \
> > > > +     })
> > >
> > > Why not make this a static inline function, along with
> > > __init_srcu_struct_atomic() and init_srcu_struct_atomic() above?
> > > That should simplify the code.
> >
> > Thanks. I=E2=80=99ll rework the initialization helpers as static inline
> > functions as suggested.
> >
> > > >  /* Defined here to avoid size increase for non-torture kernels. */
> > > >  static inline void srcu_torture_stats_print(struct srcu_struct *ss=
p,
> > > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > > > index 22f7716cbb0e..873b30ccf563 100644
> > > > --- a/kernel/rcu/srcutiny.c
> > > > +++ b/kernel/rcu/srcutiny.c
> > > > @@ -42,6 +42,7 @@ static int init_srcu_struct_fields(struct srcu_st=
ruct *ssp)
> > > >       ssp->srcu_gp_running =3D false;
> > > >       ssp->srcu_gp_waiting =3D false;
> > > >       ssp->srcu_atomic_gp_flag =3D 0;
> > > > +     ssp->srcu_reader_flavor =3D 0;
> > > >       ssp->srcu_idx =3D 0;
> > > >       ssp->srcu_idx_max =3D 0;
> > > >       INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
> > > > --
> > > > 2.43.0
> > >
> > > One of the purposes of Tiny SRCU is to be tiny, and one could argue
> > > that Tiny SRCU already has too much diagnostic code.  Should we inclu=
de
> > > these patches at all?  If we should, shouldn't they be under somethin=
g
> > > like CONFIG_PROVE_RCU?  Should some of the existing Tiny SRCU debuggi=
ng
> > > code also be under something like CONFIG_PROVE_RCU?
> > >
> > > Thoughts?
> >
> > I agree that Tiny SRCU should keep its core as small as possible, so I =
think
> > it is worth reconsidering how much diagnostic machinery we want to add =
here.
> >
> > For srcu_reader_flavor, I did have some hesitation when adding it.
> > Tiny SRCU did not previously have the concept of a reader flavor; I
> > mainly added it
> > to distinguish Tiny Atomic SRCU, following the approach used by Tree
> > SRCU. If we still
> > need state for this purpose, perhaps a one-bit flag would be sufficient=
.
> >
> > One question is whether the flavor checking really needs to be part of
> > srcutiny.c.
> > I think there are two somewhat different cases:
> > 1: checking for invalid API usage, where the purpose is to detect or
> > stop misuse;
> > 2: defensive handling of an invalid call, where we redirect to a safe
> > implementation,
> >     like in synchronize_srcu.
> >
> > The first case seems more like diagnostic functionality and could
> > potentially be handled
> > in the common SRCU API layer under CONFIG_PROVE_RCU. The second case af=
fects
> > runtime behavior and should remain independent of CONFIG_PROVE_RCU.
> >
> > This makes me wonder whether the common flavor validation could live in=
 srcu.h,
> > as part of the common SRCU interface, rather than adding more checking
> > logic to srcutiny.c.
> > That could centralize the validation and keep the Tiny SRCU
> > implementation easier to follow,
> > although it would add another wrapper layer, such as a macro or static =
inline.
>
> Another approach is to let the checking in Tree SRCU cover this.
> That way, the only misuses of the atomic SRCU API that are missed are
> those that appear only in CONFIG_SMP=3Dn code.  And right now, there isn'=
t
> any such uses.  There might be in the future, but perhaps this is quite
> unlikely.

Thanks Paul. That makes sense to me.

If Tree SRCU already catches the relevant flavor misuse for CONFIG_SMP=3Dy,
and there are currently no such uses that are specific to CONFIG_SMP=3Dn, t=
hen
I agree that adding flavor tracking/checking to Tiny SRCU just for that
coverage would not be worthwhile. :)

I originally added the Tiny SRCU flavor tracking mainly for defensive handl=
ing
and to keep the behavior consistent with Tree SRCU. But given the Tiny SRCU
size goal, I agree that this additional diagnostic coverage is not worth
the extra complexity. :-)

I'll drop the Tiny SRCU flavor-tracking part.

Thanks,
KunWu

>
>                                                         Thanx, Paul
