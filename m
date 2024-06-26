Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47D217FAAE;
	Wed, 26 Jun 2024 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422378; cv=none; b=Jm0UF2BmKCDrkKWDPA32YECxTVSrokWpYS8fOeQVH9rW1HxU0MJsVPQvLMWYtWtD8sFeClemsETzlON0FTo5pkF0Rtdy51nrtIlH+9OYKJY9HecghDrt8a0mDIMPwBTydRdbq6jj2BNmDpLxleOyoXmz27bm6zo4Tm1UfaGMKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422378; c=relaxed/simple;
	bh=0LduNK3bPYZgs4UFQPZqlImNVDjc+X38oRo/pc0lg9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLk0pAwMJzBkaU83P4baIV0BxCJsyLuO5/PMgON0EcqwDpfleIvxOXgwmFUp3yYTtLmKWK/PSVIL+oe9gpGQpt/8/AwFFLRjPH0Hoxsdnv+ZesD7NopgLghnBgFxl4t9znpySZpBeqLv62x6INL0TCqY0lVi9rbfgIlkKu+5t2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmBUO/rY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmBUO/rY"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d0699fd02so319551a12.0;
        Wed, 26 Jun 2024 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719422375; x=1720027175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mr3ZLeyAGT3Xql2UKCTpUh/n7IJBDk+dbP0/G/zbYIQ=;
        b=OmBUO/rYSHkIA7qB5Nk8jK/jvvUTsNbb7/1NUD49L9MOg+mGeL9aR/reGYeF5tVjYX
         9bK8NJ+FiuwyruVe8GqrbtFoV7djozYlPctNwHLLjmYKczG2eGTuGwgaEsKpU3zKwZHP
         1VewSZHY9+Ts38bxChKzFQhw83LqcNW7G9qG7m2AxlAYps0EaqEcwoWSPxeNx5daQn3o
         8bk1tsB6qgqiBIZMMoN9ldQiFJcTbJRCRJlsHeh/PHp+B8kU1wKKVE3KVpDMaLeHlN75
         ZqLlJXTYI59KimlMjHogktziLkMLGd2WSDVm8uhc4eZSW7cIcyHvH4Zpq5U5VtlRJcHu
         sLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719422375; x=1720027175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mr3ZLeyAGT3Xql2UKCTpUh/n7IJBDk+dbP0/G/zbYIQ=;
        b=xMwTsjhN7nwgT/dFW3RDCJf3Zu8y5W/KHU3OyDSIPa2AeoGEmB2mJ6C3f0wco9d692
         s+KogANEi1XyWt6pPC8xGWDd1eO1L+9vITw3Zp4cODp7xlDdpaoBQkWPboNvIwlXHR7I
         rVXnLgLe6YdDS1rcI9JFwhSZSBTBTxCljOyRfY6Sju90Mj3s/P0sGCVPvU37nMT00jF1
         dT/Ry8dFZhwQkc3NXE8dgK8ia87BMAIif6vsCxbWPlv+zEQ9R2alie6POyy7g8B45GDG
         STxevKf8pdLuE+/hSXS3oZVpEMmzrVe3PasPs+kITwBAdFTPaXi2VdB3vbqsRu0T8a4+
         UMZA==
X-Forwarded-Encrypted: i=1; AJvYcCXmpsCawQ9D4ZxW5gTHa6USGzdvkb1q3B5vo4i/1QEKpyt3IJrbaiH/XLbj+I3Bub1uchpMoOb/YGt9h6r/sHAO1FY4Y2UtAQA1xQNUBmRPOcxopNyNlxlFvxKPBzjPm2hl
X-Gm-Message-State: AOJu0YxGrVqHHlJLhGXlGbjjyfBKbXkYd/JW5eQk6LD2+023xDfuRoHS
	MkHTGwO3cYt8fIjpxNg+nj3917KHQ+0U5zzzOvHwhDgHVNuvf9VE/vgGDjHHmVmAKkNtHP2WaCZ
	216G6/LBNMDVFjvFhchgDPW0OS4kCuw==
X-Google-Smtp-Source: AGHT+IEPeBEalTFV3G3Im6AbBHPZP8Gz54aT+NVdMCYtpGdvw29y1CwVU+Mpb4XiYk/hOVyDgS4ordFaxy7FKJre1oE=
X-Received: by 2002:a50:999d:0:b0:582:8746:6534 with SMTP id
 4fb4d7f45d1cf-582874667afmr3829609a12.28.1719422374689; Wed, 26 Jun 2024
 10:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-2-paulmck@kernel.org> <CAFwiDX9ynNpmU_Au=J7geJYjE8NLLM-p2x8QDyjmZ1qNBkLXZQ@mail.gmail.com>
 <ZnwiCsor-cku3ETF@localhost.localdomain>
In-Reply-To: <ZnwiCsor-cku3ETF@localhost.localdomain>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Wed, 26 Jun 2024 22:49:05 +0530
Message-ID: <CAFwiDX8EL8q-ihiXR8GSu5AxmRGs8w4z682nWMMMqDe2phLjuQ@mail.gmail.com>
Subject: Re: [PATCH rcu 2/6] rcu: Remove superfluous full memory barrier upon
 first EQS snapshot
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 7:43=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Wed, Jun 12, 2024 at 01:57:20PM +0530, Neeraj upadhyay a =C3=A9crit :
> > On Wed, Jun 5, 2024 at 3:58=E2=80=AFAM Paul E. McKenney <paulmck@kernel=
.org> wrote:
> > >
> > > From: Frederic Weisbecker <frederic@kernel.org>
> > >
> > > When the grace period kthread checks the extended quiescent state
> > > counter of a CPU, full ordering is necessary to ensure that either:
> > >
> > > * If the GP kthread observes the remote target in an extended quiesce=
nt
> > >   state, then that target must observe all accesses prior to the curr=
ent
> > >   grace period, including the current grace period sequence number, o=
nce
> > >   it exits that extended quiescent state.
> > >
> > > or:
> > >
> > > * If the GP kthread observes the remote target NOT in an extended
> > >   quiescent state, then the target further entering in an extended
> > >   quiescent state must observe all accesses prior to the current
> > >   grace period, including the current grace period sequence number, o=
nce
> > >   it enters that extended quiescent state.
> > >
> > > This ordering is enforced through a full memory barrier placed right
> > > before taking the first EQS snapshot. However this is superfluous
> > > because the snapshot is taken while holding the target's rnp lock whi=
ch
> > > provides the necessary ordering through its chain of
> > > smp_mb__after_unlock_lock().
> > >
> > > Remove the needless explicit barrier before the snapshot and put a
> > > comment about the implicit barrier newly relied upon here.
> > >
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  .../Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst    | 6 +++--=
-
> > >  kernel/rcu/tree.c                                          | 7 +++++=
+-
> > >  2 files changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory=
-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Or=
dering.rst
> > > index 5750f125361b0..728b1e690c646 100644
> > > --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Orderi=
ng.rst
> > > +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Orderi=
ng.rst
> > > @@ -149,9 +149,9 @@ This case is handled by calls to the strongly ord=
ered
> > >  ``atomic_add_return()`` read-modify-write atomic operation that
> > >  is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
> > >  time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
> > > -The grace-period kthread invokes ``rcu_dynticks_snap()`` and
> > > -``rcu_dynticks_in_eqs_since()`` (both of which invoke
> > > -an ``atomic_add_return()`` of zero) to detect idle CPUs.
> > > +The grace-period kthread invokes first ``ct_dynticks_cpu_acquire()``
> > > +(preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_since(=
)``
> > > +(both of which rely on acquire semantics) to detect idle CPUs.
> > >
> > >  +-------------------------------------------------------------------=
----+
> > >  | **Quick Quiz**:                                                   =
    |
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index f07b8bff4621b..1a6ef9c5c949e 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -769,7 +769,12 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, =
struct rcu_data *rdp)
> > >   */
> > >  static int dyntick_save_progress_counter(struct rcu_data *rdp)
> > >  {
> > > -       rdp->dynticks_snap =3D rcu_dynticks_snap(rdp->cpu);
> > > +       /*
> > > +        * Full ordering against accesses prior current GP and also a=
gainst
> > > +        * current GP sequence number is enforced by current rnp lock=
ing
> > > +        * with chained smp_mb__after_unlock_lock().
> > > +        */
> >
> > It might be worth mentioning that this chained smp_mb__after_unlock_loc=
k()
> > is provided by rnp leaf node locking in rcu_gp_init() and rcu_gp_fqs_lo=
op() ?
>
> Right!
>
> How about this?
>

Looks good to me, thanks! Minor comment (ditto for the other patch) below


>     /*
>      * Full ordering against accesses prior current GP and also against

Nit: "prior to current GP" ?


Thanks
Neeraj

>      * current GP sequence number is enforced by rcu_seq_start() implicit
>      * barrier and even further by smp_mb__after_unlock_lock() barriers
>      * chained all the way throughout the rnp locking tree since rcu_gp_i=
nit()
>      * and up to the current leaf rnp locking.
>      */
>
> Thanks.
