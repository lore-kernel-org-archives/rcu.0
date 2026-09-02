Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D84137BE
	for <rcu@vger.kernel.org>; Wed,  2 Sep 2026 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340746; cv=pass; b=YyeJB/Xv3aUNSbaPY6zwpiU2mgDEliwIKll7c59/MyyCQt7mhQJnz4RgfHe+fwdddBBAZHb2sjBBki9His/XMMdQsOgQrqv4G4mW/hIGCQEQzPBA4znMF6XujTfkLnmFlStP1xKYaUgM9GwaHEkYwbJkxEiVqQQp1DVv8ZANy+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340746; c=relaxed/simple;
	bh=eDdI7kb9rYHWeWJphr+48URA7otzpjTVs5yq3zmmPlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Op0FrgxH/hpB35mAEf91J9kEQAcCAm9XYfAqhhpqwaSWIfqMagTmNDB1lNIBIZJUYJ7DcRKcLRx7/U3v7i7oSvm3I85jJGDlJztgOtTUYREMROrJCqM/PgBcxMjd9zpkkeBpIgTiAQpWNQT4LgLuQ8XwYhrW4oZgbxZYf8yRBYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti6qrbUo; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti6qrbUo"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso11402285e9.2
        for <rcu@vger.kernel.org>; Wed, 02 Sep 2026 02:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788340743; cv=none;
        d=google.com; s=arc-20260327;
        b=rn5iLjgGAlQnAuqY/g97pw+BlyJFj6MDe2io705+5lEKkC8oIJ6k0OWRujfkEf3lN4
         Ye8a3GHaibsd+2LN5u+gCxN8NZn/htwxVsJBfz5fse6gJ28jJnTZDoUV4/nEBLnGu7q8
         MJKMprJrJ+mKELllWUnLN82KB7Je3XDaYR5UHnLD6S3ZiG/26vDK7VgjnVO5UhC5x4VW
         MwcBhHTAr7bplubpuYYNHrGmilAdhwR5l9vYZcck+haGTQ857o1hRjRlFhu+81PYmINP
         ZzQgKZHy46M/IwAhgzQ7RFmGqLv5QICwpdoDIi3g+D9GkGNok3MIcDdUK4yUipp/YQN0
         K0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hcMVnJ0MPEnl0dw1WvCWplZ0EWqlilumUc/YSuk4s3k=;
        fh=fgC2EbYs75/Rz4B2bdEsFU4OJm59N2JzpMy8XbHL0G0=;
        b=BwAd+qGjIwGXNXZHJ6pWX5oBd9T+DE7VGHxZ1kbH5bChxj3qCm+CrzNuMQUc1b+yvH
         9qr8ko+CgqHqX2X/VtbIVaniKgmHjJwShqTZ1vcgsGdo5nek9GfnOdunDix+bi9LIT6L
         MTKu7XLVb1ib6irihPs4PUq50Mhz4cZfFpt45UK7VQKnOtdyMzckUVQx0+RxFBJWFMr8
         izKYKi7NdkfT3jOd5t5S0r7RAiRWJrD3MN53NPoTNv+AZiPQ//iJOzCdT40oT6ve6LPa
         pFaA6m+Li0qQZtLuZGd+dVNeXAS6kZxquRqF7iweDa7O1nm7fmX3slIycUOmoVF4HMar
         87hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788340743; x=1788945543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hcMVnJ0MPEnl0dw1WvCWplZ0EWqlilumUc/YSuk4s3k=;
        b=Ti6qrbUoOIQhQycrrrf7BXBu8Zkb//ZuG3PyyQomVwOs2tezKEwGAYH2nH8I7efsPg
         u6KfcKn4sRMcz2a9PohgtL5SbAYrPKuzsjJF82wpuf8/Zp/djKgov2xWOuEmaCPjEYrj
         MlzJNJ1YIpVsvqOjytjVjyaX+kTxuIY8ZtEC/rW/eNT/R6Nz/5cC6Xoq5X67O2ED5cC3
         PtxNofN8QmkQsFkRhe85xTX6ro9wrO9Si3ww5CBvWAEYr59+RoJdA58wDcFgRcrTwvVX
         SSL7zeWu95lDmGXnglnL71wso72cGyPhG8DcHZIsTW6664uHgGPGU6huYSjJxeX9hv91
         A/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788340743; x=1788945543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hcMVnJ0MPEnl0dw1WvCWplZ0EWqlilumUc/YSuk4s3k=;
        b=N82izbxRfLj5Q6GVybsNAH+eXCMzkYJth/+rdpJ2wyGbr4Kre5bhnk3QwVz6NXcLuW
         g/hGESnCV/Ft1hnBGnYInMpdudw8emaRkhCcj+hNHK8wC4LcaxkgBmbaxSBQB4Jd0bVp
         5LvKiRsPzuhD2nLslbIiztiY3BZPvT407Hz0Gj7397GTS4EXw1xgnDtPy9lIM7p67gCS
         HuCRGTKuP3DssLU7x7j4piRLhmZG4kMGT4limkNmIW06kHAzjdKy6MNOT6LFD2HWv+p7
         JbpoLGoW2jK1QzvdFFkEYbt25F5jqnh+TuD/BWHCbCKDBEQMnBId3ucTWT+65iNiEboS
         2mvA==
X-Forwarded-Encrypted: i=1; AHgh+Rpgs9Cn2Kk8d6OR/x+BJbTmX5PX3bbKhkoaFUBjn5vSGBFh13rli/n5eWC4WB3xYO1N9ME=@vger.kernel.org
X-Gm-Message-State: AFuF++l7YnveSr5tbOZ33m704tHqeNG8OtXzNKP35U895EvX6OYxMG3A
	BboZXSYTSFhaI/n5a7Jc7Flq+x9TmXtyKvDeQnjZwh6CkrGPG7S/3cMGnsRhpPsEHJnZ3KN3jYV
	ZP++rleRThLMZrUCDCUB6Xi7rcLJDl/8=
X-Gm-Gg: AR+sD108tthZwhzxveQ+0mglvYTy2vulaM6qW1FXOVEyfMTcBha+MNptZdMgzrjPE76
	Zp7KSrcqN9DJyy6AAqkfXl7dsR+j4nbzu+0klFMDKibVWH37YO2O9keBANE809xSk9nKohmw7mO
	JGLKSZnE9Hbz1gikxPqLk17yqePr03Ao9bCJhVvwGgctBz1Tr6mW0QFFVoiQqyMJVq9d6GdvRtW
	QJC4P9bIlpgeY7F3aFd1OnCo5LKIqYHpxUyN2fFAvTKJpCZ8UHNgbIjjLazOaiqCmP+uBhaYEv2
	XEC5nxHgRyGMcMdjK5Gln5faVdVgTAX1wUCVvH76clE2lDVbn+KlqGcubnCvBz5mydTQSa8GyOr
	u7yc=
X-Received: by 2002:a05:600c:6296:b0:499:621a:2ec2 with SMTP id
 5b1f17b1804b1-49ce581635bmr62953555e9.3.1788340742125; Wed, 02 Sep 2026
 02:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901074815.3145037-1-kunwu.chan@linux.dev> <d991297a-9bd4-4da2-89cd-002b6f2a3305@paulmck-laptop>
In-Reply-To: <d991297a-9bd4-4da2-89cd-002b6f2a3305@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 2 Sep 2026 17:18:50 +0800
X-Gm-Features: AcwNN1VWxMi68XrHmbYjnT12bLzvr38iujyJVXNF6dN9XU4E4ljwjU-fKuImwbU
Message-ID: <CAN_Opa81BaWxkdRyoHQBcMLbOt-n7f-4cUmxxstage1MSOu1Hw@mail.gmail.com>
Subject: Re: [PATCH] srcutiny: Enable atomic SRCU flavor tracking
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 1:11=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Tue, Sep 01, 2026 at 03:48:15PM +0800, Kunwu Chan wrote:
> > From: Kunwu Chan <kunwu.chan@gmail.com>
> >
> > Set srcu_reader_flavor to SRCU_READ_FLAVOR_ATOMIC in the Tiny SRCU
> > atomic initialization paths, so that the entry-point checks added by
> > the previous commit can identify atomic SRCU domains.
> >
> > For static initialization, add a flavor parameter to
> > __SRCU_STRUCT_INIT() and pass SRCU_READ_FLAVOR_ATOMIC through
> > DEFINE_SRCU_ATOMIC() and DEFINE_STATIC_SRCU_ATOMIC().
> >
> > For dynamic initialization, initialize srcu_reader_flavor to zero in
> > init_srcu_struct_fields() for the generic initialization path, and
> > set it to SRCU_READ_FLAVOR_ATOMIC in init_srcu_struct_atomic().
> > Handle both CONFIG_DEBUG_LOCK_ALLOC and non-debug initialization paths.
> >
> > Enable srcu_check_read_flavor() for Tiny SRCU, matching the Tree SRCU
> > behavior, so that readers can verify that the requested flavor matches
> > the SRCU domain.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> Much better!  Please see below for additional questions and comments.

Thanks Paul for the detailed reply.

>
> > ---
> >  include/linux/srcutiny.h | 39 +++++++++++++++++++++++++++++----------
> >  kernel/rcu/srcutiny.c    |  1 +
> >  2 files changed, 30 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > index 2b293336525a..9dce4b5aa084 100644
> > --- a/include/linux/srcutiny.h
> > +++ b/include/linux/srcutiny.h
> > @@ -40,7 +40,7 @@ void srcu_drive_gp(struct work_struct *wp);
> >  void srcu_tiny_irq_work(struct irq_work *irq_work);
> >  void srcu_defer_drain(struct irq_work *irq_work);
> >
> > -#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, ____ignored) \
> > +#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, flavor)       =
       \
> >  {                                                                    \
> >       .srcu_wq =3D __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),       =
 \
> >       .srcu_cb_tail =3D &name.srcu_cb_head,                            =
 \
> > @@ -49,6 +49,7 @@ void srcu_defer_drain(struct irq_work *irq_work);
> >       .defer_cbs =3D LLIST_HEAD_INIT(name.defer_cbs),                  =
 \
> >       .defer_iw =3D { .node =3D { .u_flags =3D IRQ_WORK_HARD_IRQ },    =
     \
> >                     .func =3D srcu_defer_drain },                      =
 \
> > +     .srcu_reader_flavor =3D flavor,                                  =
 \
>
> Don't we also need to define srcu_reader_flavor?  Or is this patch
> supposed to be applied on top of your previous one?

Yes, this is intended to be applied on top of the previous one [1].
[1] https://lore.kernel.org/rcu/20260831074937.2380914-1-kunwu.chan@linux.d=
ev/

>
> >       __SRCU_DEP_MAP_INIT(name)                                       \
> >  }
> >
> > @@ -57,29 +58,43 @@ void srcu_defer_drain(struct irq_work *irq_work);
> >   * Tree SRCU, which needs some per-CPU data.
> >   */
> >  #define DEFINE_SRCU(name) \
> > -     struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name, name, =
name)
> > +     struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name, name, =
0)
> >  #define DEFINE_STATIC_SRCU(name) \
> > -     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name,=
 name, name)
> > +     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name,=
 name, 0)
> >  #define DEFINE_SRCU_FAST(name) DEFINE_SRCU(name)
> >  #define DEFINE_STATIC_SRCU_FAST(name) \
> > -     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name,=
 name, name)
> > +     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name,=
 name, 0)
> >  #define DEFINE_SRCU_FAST_UPDOWN(name) DEFINE_SRCU(name)
> >  #define DEFINE_STATIC_SRCU_FAST_UPDOWN(name) \
> > -     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name,=
 name, name)
> > -#define DEFINE_SRCU_ATOMIC(name) DEFINE_SRCU(name)
> > +     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name,=
 name, 0)
> > +#define DEFINE_SRCU_ATOMIC(name) \
> > +     struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name, name, =
SRCU_READ_FLAVOR_ATOMIC)
> >  #define DEFINE_STATIC_SRCU_ATOMIC(name) \
> > -     static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name,=
 name, name)
> > +     static struct srcu_struct name =3D \
> > +             __SRCU_STRUCT_INIT(name, name, name, SRCU_READ_FLAVOR_ATO=
MIC)
> >
> >  // Dummy structure for srcu_notifier_head.
> >  struct srcu_usage { };
> >  #define __SRCU_USAGE_INIT(name) { }
> >  #define __init_srcu_struct_fast __init_srcu_struct
> >  #define __init_srcu_struct_fast_updown __init_srcu_struct
> > -#define __init_srcu_struct_atomic __init_srcu_struct
> > +#define __init_srcu_struct_atomic(ssp, name, key) \
> > +({ \
> > +     int __ret =3D __init_srcu_struct(ssp, name, key); \
> > +     if (!__ret) \
> > +             (ssp)->srcu_reader_flavor =3D SRCU_READ_FLAVOR_ATOMIC; \
> > +     __ret; \
> > +})
> >  #ifndef CONFIG_DEBUG_LOCK_ALLOC
> >  #define init_srcu_struct_fast init_srcu_struct
> >  #define init_srcu_struct_fast_updown init_srcu_struct
> > -#define init_srcu_struct_atomic init_srcu_struct
> > +#define init_srcu_struct_atomic(ssp)                                 \
> > +     ({                                                              \
> > +             int __ret =3D init_srcu_struct(ssp);                     =
 \
> > +             if (!__ret)                                             \
> > +                     (ssp)->srcu_reader_flavor =3D SRCU_READ_FLAVOR_AT=
OMIC;\
> > +             __ret;                                                  \
> > +     })
> >  #endif // #ifndef CONFIG_DEBUG_LOCK_ALLOC
> >
> >  void synchronize_srcu(struct srcu_struct *ssp);
> > @@ -148,7 +163,11 @@ static inline void synchronize_srcu_expedited(stru=
ct srcu_struct *ssp)
> >  void srcu_barrier(struct srcu_struct *ssp);
> >
> >  static inline void srcu_expedite_current(struct srcu_struct *ssp) { }
> > -#define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
> > +#define srcu_check_read_flavor(ssp, read_flavor) \
> > +     ({ \
> > +             u8 __f =3D (ssp)->srcu_reader_flavor; \
> > +             WARN_ON_ONCE(__f && !(__f & (read_flavor))); \
> > +     })
>
> Why not make this a static inline function, along with
> __init_srcu_struct_atomic() and init_srcu_struct_atomic() above?
> That should simplify the code.

Thanks. I=E2=80=99ll rework the initialization helpers as static inline
functions as suggested.

>
> >  /* Defined here to avoid size increase for non-torture kernels. */
> >  static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
> > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > index 22f7716cbb0e..873b30ccf563 100644
> > --- a/kernel/rcu/srcutiny.c
> > +++ b/kernel/rcu/srcutiny.c
> > @@ -42,6 +42,7 @@ static int init_srcu_struct_fields(struct srcu_struct=
 *ssp)
> >       ssp->srcu_gp_running =3D false;
> >       ssp->srcu_gp_waiting =3D false;
> >       ssp->srcu_atomic_gp_flag =3D 0;
> > +     ssp->srcu_reader_flavor =3D 0;
> >       ssp->srcu_idx =3D 0;
> >       ssp->srcu_idx_max =3D 0;
> >       INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
> > --
> > 2.43.0
>
> One of the purposes of Tiny SRCU is to be tiny, and one could argue
> that Tiny SRCU already has too much diagnostic code.  Should we include
> these patches at all?  If we should, shouldn't they be under something
> like CONFIG_PROVE_RCU?  Should some of the existing Tiny SRCU debugging
> code also be under something like CONFIG_PROVE_RCU?
>
> Thoughts?

I agree that Tiny SRCU should keep its core as small as possible, so I thin=
k
it is worth reconsidering how much diagnostic machinery we want to add here=
.

For srcu_reader_flavor, I did have some hesitation when adding it.
Tiny SRCU did not previously have the concept of a reader flavor; I
mainly added it
to distinguish Tiny Atomic SRCU, following the approach used by Tree
SRCU. If we still
need state for this purpose, perhaps a one-bit flag would be sufficient.

One question is whether the flavor checking really needs to be part of
srcutiny.c.
I think there are two somewhat different cases:
1: checking for invalid API usage, where the purpose is to detect or
stop misuse;
2: defensive handling of an invalid call, where we redirect to a safe
implementation,
    like in synchronize_srcu.

The first case seems more like diagnostic functionality and could
potentially be handled
in the common SRCU API layer under CONFIG_PROVE_RCU. The second case affect=
s
runtime behavior and should remain independent of CONFIG_PROVE_RCU.

This makes me wonder whether the common flavor validation could live in src=
u.h,
as part of the common SRCU interface, rather than adding more checking
logic to srcutiny.c.
That could centralize the validation and keep the Tiny SRCU
implementation easier to follow,
although it would add another wrapper layer, such as a macro or static inli=
ne.

Thanks,
Kunwu

>
>                                                         Thanx, Paul
