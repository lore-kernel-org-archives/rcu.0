Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6A613D;
	Thu, 27 Jun 2024 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719455605; cv=none; b=TvlHwfLjpZpDfUEMWRhXOVZAEpR5rMEqx+gZbGK7mdQcYWRpqwhEvBEDClE1taaNt8+pTFCqWEZtb3wJsYr5r2E22ATppI82NCDmYHHtPUs1VcruJMcdcr9ESFv6RMM6W+BA/YzMAWWpdWO4cCjIS/MzXnmtOVhbr6wwr2SaNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719455605; c=relaxed/simple;
	bh=YeCcrWvUVpBGZAr8vagzzWBnGFNRsYGBmdFQ0k5zMbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFnWIEmov+g5AfEcQEnK/jfnKk7scLFsR7L71VSlo9N7/NE1WjoJgg4VKBGI5Bj0Jg0/wb3SMBbwvSKJ5G0YAP21aPLdn4KeQuX13mMNDE9OnYvgAtxajKAGZQ2KXK92QK8nr/KAhVR5V1CBf9NnyS+/3L+HHbLqnFXYiYdC2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W36Mhh5S; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W36Mhh5S"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a725282b926so565593866b.0;
        Wed, 26 Jun 2024 19:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719455602; x=1720060402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfUeOZXa8kVGItHFCqRxPPX38JF28USU4ic88WwmCwM=;
        b=W36Mhh5Smjpb4AInoHQvokJaANHv48C14+SidNFB+b5tR0Oxx0sFSD8ubzKezZZ5FE
         wvztktwFZhnzl1UJXZKwqa0wchDH3w7WOcbFZLyOWTAwWsJhBpSCqwpXRFHd6AMkXfIx
         OufCj2kO4Pesb36fpNYr2wo/dLXV4YhE/a+DF+m5EXmu5FCz/NZ6P6n5tcSbCnr6R2om
         BPUiOIjHc3L/kNf4kIfa8LbxNRPTiRntwHduyhNOYfmVfeLY1VSXLjJTfTf8Ox2QM1xB
         xRFpZwngJp/VaRpXjvi8Ro7ZdMSkxRRNNIbpt1T4O7jv+h8tB8i8VD2BB5/L1QCTkkK5
         9ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719455602; x=1720060402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfUeOZXa8kVGItHFCqRxPPX38JF28USU4ic88WwmCwM=;
        b=oJtPr8izooa7433Cx/j775k6ME/yq+3RXvdrMwS3+IX/yNIqrS3KKpEoF/ltC43u+5
         KEL1bx4Ta3SO9wCq82WlanHkPN62vt5VwgmE3ndUVxtpPNWXJhOJIUt00cNmHAJ90vzX
         2u5O9mX2Prb+zG9/LwEQFGlDXyM/XjU0/ORkc0nfGfUwpvHDpBHn/0nOmLPqId637pU8
         dw+CQgtYKSfcii3AXKJ5B9E6PdHcKtWWf1BlKjttkiGh985cVoWHhcbOptPSByNUBbfB
         RcSWy7m+wd4l5JM/E8nHun1+Upr245j2K8JgZuz0z4u8Xs9z1NgMxdHHkHj0biGQvIep
         lBvA==
X-Forwarded-Encrypted: i=1; AJvYcCWMtvFM7oMUAPQmFG9P21wojZ2a+ymwhPeEeRMb1Qcvn4h51gGKZsrYvGCwC9JzAjqD9602v5pjBeU/fdPML8QeOn3YGDuJAhsJ30nz+/4685UoR5QjdyQL5/zlDVmGZgbV
X-Gm-Message-State: AOJu0Yzg8UYLLowoAwKPEaRq4nV8zza/RGIdP+qDFH3CHCAJ5/83BquA
	9zyndF1dwVizH9PhOwLGFiThmcO32B05fzOWgcKr35bNvajnySXdynMkyllVwQF7xQ9dPOiq6v5
	YIZlkl+DD4waEIMFiP3aFJB7jOshJ/g==
X-Google-Smtp-Source: AGHT+IH5Z4vo4q9/46RJ47NMRNs/BAPEOE8aIeZk/kcYVMZF/Xpjmu3iV2rvqGLeXTCs5obuqx5Nj1KlYzWtCqhnqiM=
X-Received: by 2002:a17:906:bf42:b0:a72:7a43:5c90 with SMTP id
 a640c23a62f3a-a727f8d6c1bmr374373866b.66.1719455602292; Wed, 26 Jun 2024
 19:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-3-paulmck@kernel.org> <CAFwiDX_5BZ9e0odyJKTPJJ9BDkHJ6fcEzSwgs9rnjhuRk4qhhw@mail.gmail.com>
 <ZnwloG9xOrOHru4B@localhost.localdomain> <CAFwiDX8OE74e4ZVsy3wJbX5F4Huv0NR1w2EqM4xfeoa03JjCpg@mail.gmail.com>
 <ZnySYEWMJpcfkmOr@pavilion.home>
In-Reply-To: <ZnySYEWMJpcfkmOr@pavilion.home>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Thu, 27 Jun 2024 08:03:10 +0530
Message-ID: <CAFwiDX8A-s1y8ijjtQDNrd1S3kwg+pBzsdO8_J=Dka58n0ZQcg@mail.gmail.com>
Subject: Re: [PATCH rcu 3/6] rcu/exp: Remove superfluous full memory barrier
 upon first EQS snapshot
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 3:42=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Wed, Jun 26, 2024 at 10:49:58PM +0530, Neeraj upadhyay a =C3=A9crit :
> > On Wed, Jun 26, 2024 at 7:58=E2=80=AFPM Frederic Weisbecker <frederic@k=
ernel.org> wrote:
> > >
> > > Le Wed, Jun 12, 2024 at 02:14:14PM +0530, Neeraj upadhyay a =C3=A9cri=
t :
> > > > On Wed, Jun 5, 2024 at 3:58=E2=80=AFAM Paul E. McKenney <paulmck@ke=
rnel.org> wrote:
> > > > >
> > > > > From: Frederic Weisbecker <frederic@kernel.org>
> > > > >
> > > > > When the grace period kthread checks the extended quiescent state
> > > > > counter of a CPU, full ordering is necessary to ensure that eithe=
r:
> > > > >
> > > > > * If the GP kthread observes the remote target in an extended qui=
escent
> > > > >   state, then that target must observe all accesses prior to the =
current
> > > > >   grace period, including the current grace period sequence numbe=
r, once
> > > > >   it exits that extended quiescent state.
> > > > >
> > > > > or:
> > > > >
> > > > > * If the GP kthread observes the remote target NOT in an extended
> > > > >   quiescent state, then the target further entering in an extende=
d
> > > > >   quiescent state must observe all accesses prior to the current
> > > > >   grace period, including the current grace period sequence numbe=
r, once
> > > > >   it enters that extended quiescent state.
> > > > >
> > > > > This ordering is enforced through a full memory barrier placed ri=
ght
> > > > > before taking the first EQS snapshot. However this is superfluous
> > > > > because the snapshot is taken while holding the target's rnp lock=
 which
> > > > > provides the necessary ordering through its chain of
> > > > > smp_mb__after_unlock_lock().
> > > > >
> > > > > Remove the needless explicit barrier before the snapshot and put =
a
> > > > > comment about the implicit barrier newly relied upon here.
> > > > >
> > > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > ---
> > > > >  kernel/rcu/tree_exp.h | 8 +++++++-
> > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > > index 8a1d9c8bd9f74..bec24ea6777e8 100644
> > > > > --- a/kernel/rcu/tree_exp.h
> > > > > +++ b/kernel/rcu/tree_exp.h
> > > > > @@ -357,7 +357,13 @@ static void __sync_rcu_exp_select_node_cpus(=
struct rcu_exp_work *rewp)
> > > > >                     !(rnp->qsmaskinitnext & mask)) {
> > > > >                         mask_ofl_test |=3D mask;
> > > > >                 } else {
> > > > > -                       snap =3D rcu_dynticks_snap(cpu);
> > > > > +                       /*
> > > > > +                        * Full ordering against accesses prior c=
urrent GP and
> > > > > +                        * also against current GP sequence numbe=
r is enforced
> > > > > +                        * by current rnp locking with chained
> > > > > +                        * smp_mb__after_unlock_lock().
> > > >
> > > > Again, worth mentioning the chaining sites sync_exp_reset_tree() an=
d
> > > > this function?
> > >
> > > How about this?
> > >
> >
> > Looks good to me, thanks!
>
> And similar to the previous one, a last minute edition:
>
>                         /*
>                          * Full ordering between remote CPU's post idle a=
ccesses
>                          * and updater's accesses prior to current GP (an=
d also
>                          * the started GP sequence number) is enforced by
>                          * rcu_seq_start() implicit barrier, relayed by k=
workers
>                          * locking and even further by smp_mb__after_unlo=
ck_lock()
>                          * barriers chained all the way throughout the rn=
p locking
>                          * tree since sync_exp_reset_tree() and up to the=
 current
>                          * leaf rnp locking.
>                          *
>                          * Ordering between remote CPU's pre idle accesse=
s and
>                          * post grace period updater's accesses is enforc=
ed by the
>                          * below acquire semantic.
>                          */
>
> Still ok?
>

Yes, looks good, thanks.


Thanks
Neeraj

> Thanks.
