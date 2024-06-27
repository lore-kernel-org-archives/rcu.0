Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA86EC8E9;
	Thu, 27 Jun 2024 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719456023; cv=none; b=gaD2JsZflb5xLSaFKvUSZH5v62R7v2wHOzmFxtKcc8odvwGqYp5V1GxXOK+7qxjUwqrCRPB+Z2rFn2zlLKFy90oN6hK5SJ1W5cNLidVdtbew2pnRQDUpd2cxH4OcIbPmoc/uvteDBFkSY5MrCGCb0WgVUbF+bwj0o7W84jaz2+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719456023; c=relaxed/simple;
	bh=I3qMPc9qUfiAFg8bs2NXUNGb6Oa005vf5im4UUd0UrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiOs6Tl0uNNw3zIYGVHMEVXeRqvhieCGQo14vkEQVyHQAJ5XP/jKbE7vnaUEvq/9vX8dyoymt0US69C39WRt1L2uj5Vo1D3Gy+ow4CngW9S1lFoPNIfbymcPBlR+yfZOSVDfv9/jiMp0SOdavGTisZsVwoBIllVGMO8kNulN5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai6R5ju0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai6R5ju0"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6fe61793e2so327734666b.0;
        Wed, 26 Jun 2024 19:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719456020; x=1720060820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4Ay7++MkN/pxOO3USj58zzpiS633Yr9vwAppfqnzXo=;
        b=Ai6R5ju0P49rG2oOpnfLSDKTOp3foeUAzVCE1snWFBnC2Gfs/CeP0UUhcDKgD0xqcr
         KYdZ6X94+CVkBswMU7k51ud5HlSq2j6HGeb0otIu9B6uJRzkzOt5WfxQiDGupc0zjn50
         Kw0vs8ad7qhPaDu5krSDt5bwetWSZ4wS8iaTX5uBbdKXrpBhdxS4m3fcvTu3u1w1RU+t
         gFadm4b09rCR0mMLlQ/fX1ddL7fgP+uc1TRYDEsQmlVJXpJ36qBCYAbACIXqC43FGxDc
         7rj2tNuL9tkRx/Q0jH1kOWKRdvY7E7L6p/LSf9gXTbJvQyjdw/WLAwgRgM6VZh27eGVf
         ITGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719456020; x=1720060820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4Ay7++MkN/pxOO3USj58zzpiS633Yr9vwAppfqnzXo=;
        b=dOfh4D7ZMbsd+B52+pVmNB0XgRPAlEhs5sIfc9nN8wnrBzlf8xp/ktJOu542VgvFkT
         mGG/vJwiMSF+7FpYfvN+OxMqFaymYbKnGpQJufvWSa5MT7tJ2AZPxFuodpoqjqXmsH9u
         kgv7trFNFf0YgMse2L3G7N3zH/ERMdd8n5/KoTfRqYWUZZP+rIRxqQQzaoLS+HPSuXFk
         d09V/2wQjQAO10BWmEWniaaGtp7Db6T2ByK/g2isaB7qflpl4WrdS4Pr91kc98CDwIe1
         +iR7wc/pvHP+BJ+EUWEToTfC8ZcuTlCorJa2PNXAbjFCKsYkjwNfkq/umjCAxrasXP83
         BQPg==
X-Forwarded-Encrypted: i=1; AJvYcCW3knW3OdWzmSW1OmoVGKQXkQ3cjSBfj+1y9obIP8yCWFlIJodCXoK+6eQvaJyNLeqRg3UO/UHORw3ojvuB4JwqsxE+0HcvqWU2uHYcHX8bkO6nwNh0QtwmT0ACEbaEhRei
X-Gm-Message-State: AOJu0YwH0MkcMmEyJqT5ywjrxoVvq4YDuNqr1Ha2xhVPA/aAgMWWbvru
	D9zZCcSD1ZGOi87+y0CrqBQWu7ezKwHW/3iigSID7s1ANk+OlfXa5C+WCOubHB2SitBL37ZHD2b
	546K2tDHRu3CszL2DoHDYk2OjFFc=
X-Google-Smtp-Source: AGHT+IG1lY98mbgHIfxulrCqW75x67WBWZl4edIbVhiG+f7NWfYRsJW7OWWgL06It5sLaxE75txVfNRoRGC6xPp8lTY=
X-Received: by 2002:a50:99dd:0:b0:57c:5874:4f5c with SMTP id
 4fb4d7f45d1cf-57d4bdcad82mr10679798a12.32.1719456019734; Wed, 26 Jun 2024
 19:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-2-paulmck@kernel.org> <CAFwiDX9ynNpmU_Au=J7geJYjE8NLLM-p2x8QDyjmZ1qNBkLXZQ@mail.gmail.com>
 <ZnwiCsor-cku3ETF@localhost.localdomain> <CAFwiDX8EL8q-ihiXR8GSu5AxmRGs8w4z682nWMMMqDe2phLjuQ@mail.gmail.com>
 <ZnyQJGJGeAbTSEhv@pavilion.home> <CAFwiDX8TP4EzsnFCfrj-2iKVdXGqsM5_eLexp=qpqnd7qEE-bw@mail.gmail.com>
In-Reply-To: <CAFwiDX8TP4EzsnFCfrj-2iKVdXGqsM5_eLexp=qpqnd7qEE-bw@mail.gmail.com>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Thu, 27 Jun 2024 08:10:07 +0530
Message-ID: <CAFwiDX9U1ABD4Nvvimnx6FFECrgqJ0_F1WAEChQUchQZT0a-0g@mail.gmail.com>
Subject: Re: [PATCH rcu 2/6] rcu: Remove superfluous full memory barrier upon
 first EQS snapshot
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 7:46=E2=80=AFAM Neeraj upadhyay <neeraj.iitr10@gmai=
l.com> wrote:
>
> On Thu, Jun 27, 2024 at 3:33=E2=80=AFAM Frederic Weisbecker <frederic@ker=
nel.org> wrote:
> >
> > Le Wed, Jun 26, 2024 at 10:49:05PM +0530, Neeraj upadhyay a =C3=A9crit =
:
> > > On Wed, Jun 26, 2024 at 7:43=E2=80=AFPM Frederic Weisbecker <frederic=
@kernel.org> wrote:
> > > >
> > > > Le Wed, Jun 12, 2024 at 01:57:20PM +0530, Neeraj upadhyay a =C3=A9c=
rit :
> > > > > On Wed, Jun 5, 2024 at 3:58=E2=80=AFAM Paul E. McKenney <paulmck@=
kernel.org> wrote:
> > > > > >
> > > > > > From: Frederic Weisbecker <frederic@kernel.org>
> > > > > >
> > > > > > When the grace period kthread checks the extended quiescent sta=
te
> > > > > > counter of a CPU, full ordering is necessary to ensure that eit=
her:
> > > > > >
> > > > > > * If the GP kthread observes the remote target in an extended q=
uiescent
> > > > > >   state, then that target must observe all accesses prior to th=
e current
> > > > > >   grace period, including the current grace period sequence num=
ber, once
> > > > > >   it exits that extended quiescent state.
> > > > > >
> > > > > > or:
> > > > > >
> > > > > > * If the GP kthread observes the remote target NOT in an extend=
ed
> > > > > >   quiescent state, then the target further entering in an exten=
ded
> > > > > >   quiescent state must observe all accesses prior to the curren=
t
> > > > > >   grace period, including the current grace period sequence num=
ber, once
> > > > > >   it enters that extended quiescent state.
> > > > > >
> > > > > > This ordering is enforced through a full memory barrier placed =
right
> > > > > > before taking the first EQS snapshot. However this is superfluo=
us
> > > > > > because the snapshot is taken while holding the target's rnp lo=
ck which
> > > > > > provides the necessary ordering through its chain of
> > > > > > smp_mb__after_unlock_lock().
> > > > > >
> > > > > > Remove the needless explicit barrier before the snapshot and pu=
t a
> > > > > > comment about the implicit barrier newly relied upon here.
> > > > > >
> > > > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > ---
> > > > > >  .../Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst    | 6=
 +++---
> > > > > >  kernel/rcu/tree.c                                          | 7=
 ++++++-
> > > > > >  2 files changed, 9 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-=
Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Mem=
ory-Ordering.rst
> > > > > > index 5750f125361b0..728b1e690c646 100644
> > > > > > --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-=
Ordering.rst
> > > > > > +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-=
Ordering.rst
> > > > > > @@ -149,9 +149,9 @@ This case is handled by calls to the strong=
ly ordered
> > > > > >  ``atomic_add_return()`` read-modify-write atomic operation tha=
t
> > > > > >  is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
> > > > > >  time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
> > > > > > -The grace-period kthread invokes ``rcu_dynticks_snap()`` and
> > > > > > -``rcu_dynticks_in_eqs_since()`` (both of which invoke
> > > > > > -an ``atomic_add_return()`` of zero) to detect idle CPUs.
> > > > > > +The grace-period kthread invokes first ``ct_dynticks_cpu_acqui=
re()``
> > > > > > +(preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_=
since()``
> > > > > > +(both of which rely on acquire semantics) to detect idle CPUs.
> > > > > >
> > > > > >  +-------------------------------------------------------------=
----------+
> > > > > >  | **Quick Quiz**:                                             =
          |
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index f07b8bff4621b..1a6ef9c5c949e 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -769,7 +769,12 @@ static void rcu_gpnum_ovf(struct rcu_node =
*rnp, struct rcu_data *rdp)
> > > > > >   */
> > > > > >  static int dyntick_save_progress_counter(struct rcu_data *rdp)
> > > > > >  {
> > > > > > -       rdp->dynticks_snap =3D rcu_dynticks_snap(rdp->cpu);
> > > > > > +       /*
> > > > > > +        * Full ordering against accesses prior current GP and =
also against
> > > > > > +        * current GP sequence number is enforced by current rn=
p locking
> > > > > > +        * with chained smp_mb__after_unlock_lock().
> > > > > > +        */
> > > > >
> > > > > It might be worth mentioning that this chained smp_mb__after_unlo=
ck_lock()
> > > > > is provided by rnp leaf node locking in rcu_gp_init() and rcu_gp_=
fqs_loop() ?
> > > >
> > > > Right!
> > > >
> > > > How about this?
> > > >
> > >
> > > Looks good to me, thanks! Minor comment (ditto for the other patch) b=
elow
> > >
> > >
> > > >     /*
> > > >      * Full ordering against accesses prior current GP and also aga=
inst
> > >
> > > Nit: "prior to current GP" ?
> >
> > Thanks. On a second thought and just to make sure we don't forget why w=
e did
> > what we did after a few years, I expanded some more, still ok with the =
following?
> >
>
> Yes, looks good!
>

So, I rechecked this after reviewing the other one. One comment below:

>
> Thanks
> Neeraj
>
> >         /*
> >          * Full ordering between remote CPU's post idle accesses and up=
dater's
> >          * accesses prior to current GP (and also the started GP sequen=
ce number)
> >          * is enforced by rcu_seq_start() implicit barrier and even fur=
ther by
> >          * smp_mb__after_unlock_lock() barriers chained all the way thr=
oughout the
> >          * rnp locking tree since rcu_gp_init() and up to the current l=
eaf rnp
> >          * locking.
> >          *
> >          * Ordering between remote CPU's pre idle accesses and post gra=
ce period's
> >          * accesses is enforced by the below acquire semantic.

Maybe say "post grace period updater's accesses" as in the other change?

(I had to refer to your sequence flow in PATCH 1/6, between GP kthread
and remote CPU
to visualize this :) )


Thanks
Neeraj

> >          */
> >
> > Thanks.
