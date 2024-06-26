Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B917FAAE;
	Wed, 26 Jun 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422431; cv=none; b=o9cgYJHUibu+unMDHcxS2jrF0m04GkbgdIU31PcF+knMn6wS+tPPFE7mnVOXqQEKPwELkDqngq+7O/QFBEkqASPH4pCOdH9ITMlYsnmxAIr6HOL2stqU0hzkAML7QzxiETCeXsbVHtXQCMvwq3aAafNXcHKKbJodt2f7QjEg6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422431; c=relaxed/simple;
	bh=FpmfseKvsNrIyy6B2hAFiPzR46XhnvKTaVIYDG7zZdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USplVvAZn1CQrKyNQH/HGvWttxuXUGpVnPOVZZd6xkQdujElsbwFwqCSMK1hKAdK5ByZh/h73BgoJDfpJxUuL3TDWfIvselYqNtXYnE6BT4YDpen89Grfg2QsJz9ZN61DckyfxeGIU2Oahyd7jg5jJoNxNo0u6oTW9fKMrz+BFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxBZgqyD; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxBZgqyD"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f3c5af0a04so102403639f.0;
        Wed, 26 Jun 2024 10:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719422429; x=1720027229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIGwS8SF4bCfxZNVEqDa8yq7jny8yEUT/eble4D1TDs=;
        b=OxBZgqyDinFl3FVWneYN5matErtTtngidtsq4qAwwKaGxlDdeazaquXKG2OPL5v49e
         h4735AuXmQwzsa6tUcchxU2vRJo+hO5MHAnZQRLA06mHGBrqjxLuSKk6cKxX0oLEJAmb
         sLfxzmi0LQ1YLQ3lt+Is8SGMLZk6ycCFA9jH4Lfx/vvGCZHTfL+z/9eSHgHmxMNQp8jU
         cJZR28e+nSEUwTm1k2dTGcvjwhfibkuroLlH9ePS9vcT67t1Vr813mOkVm2l/GcFB95j
         0XjB66oBDSC6NiVOyqeyK8NdKKoNMHYFDLqBEAK5U309qdpjNUX4ThMbj680yveB+zdr
         +Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719422429; x=1720027229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIGwS8SF4bCfxZNVEqDa8yq7jny8yEUT/eble4D1TDs=;
        b=eitMy5BJZfr/6/kYVYF3r1xQzKQGmU5e/2ve1jqlEZ54SAcZ7Th/cbg3TfvgkDZla2
         RsCNs6he6Tue3IZfIENrhkYDR0G4qhNvI+YLA3I8D7SMQSniSUurLOqO6PA1dkq8bl2B
         DZslyu/Y/LPAKtzQJmNGYzoRF9vLpT3+6OWQXEm6lALKoncEe+26bhZcTRaJIic1dSDD
         Nu1HmSzNaEOi2Y3Tht10RIH3CMjAQh4M6G3Hnt3cCm4dV9kjMd4T0///AElQgvqnq55v
         R5zwFlIuOj8cr/iV8KemSByW9KazZ4GEF17xpi0t07y0FVBovtsr8IkOTfdyLGCORVyO
         sPmA==
X-Forwarded-Encrypted: i=1; AJvYcCWRx4SvSJ7nhf7PkPZa1cam/QGtmIQeuQ4iW4jP6Ndcwi7MzRjU6S+p9VPY/ZMZyybqyz6BiYke3C0O5+6XucwQAi9mfo91aaekEqKEb4/ugdKWxUGXejSBRNM5wJAX9JiA
X-Gm-Message-State: AOJu0YxDvUXVZb9QoCU3Yz3ZbunYmmTMFD7Kv9swhTdDkTa1s6Ak0zLj
	GbwhuMK7c2cPCqa3Vq/pGxvsVbOYvze2R/RAlQVrJFgCCo7JSCdmwaXAcvkEQGfwM5u5jFjEgAd
	CROC2LC+iX6lmXBRt3ocHbumYYHY=
X-Google-Smtp-Source: AGHT+IHnOfn2sbxPWjAazylFRWlND8nm1YEP9y+YSWcboQP72tyGVXpbgT+rdy9CjIyrRVN9t2Pwyn/lu9svJTAXh+Q=
X-Received: by 2002:a05:6602:14ce:b0:7eb:7bc9:7fc3 with SMTP id
 ca18e2360f4ac-7f3a74b20dfmr1388847039f.3.1719422429115; Wed, 26 Jun 2024
 10:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-3-paulmck@kernel.org> <CAFwiDX_5BZ9e0odyJKTPJJ9BDkHJ6fcEzSwgs9rnjhuRk4qhhw@mail.gmail.com>
 <ZnwloG9xOrOHru4B@localhost.localdomain>
In-Reply-To: <ZnwloG9xOrOHru4B@localhost.localdomain>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Wed, 26 Jun 2024 22:49:58 +0530
Message-ID: <CAFwiDX8OE74e4ZVsy3wJbX5F4Huv0NR1w2EqM4xfeoa03JjCpg@mail.gmail.com>
Subject: Re: [PATCH rcu 3/6] rcu/exp: Remove superfluous full memory barrier
 upon first EQS snapshot
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 7:58=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Wed, Jun 12, 2024 at 02:14:14PM +0530, Neeraj upadhyay a =C3=A9crit :
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
> > >  kernel/rcu/tree_exp.h | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > index 8a1d9c8bd9f74..bec24ea6777e8 100644
> > > --- a/kernel/rcu/tree_exp.h
> > > +++ b/kernel/rcu/tree_exp.h
> > > @@ -357,7 +357,13 @@ static void __sync_rcu_exp_select_node_cpus(stru=
ct rcu_exp_work *rewp)
> > >                     !(rnp->qsmaskinitnext & mask)) {
> > >                         mask_ofl_test |=3D mask;
> > >                 } else {
> > > -                       snap =3D rcu_dynticks_snap(cpu);
> > > +                       /*
> > > +                        * Full ordering against accesses prior curre=
nt GP and
> > > +                        * also against current GP sequence number is=
 enforced
> > > +                        * by current rnp locking with chained
> > > +                        * smp_mb__after_unlock_lock().
> >
> > Again, worth mentioning the chaining sites sync_exp_reset_tree() and
> > this function?
>
> How about this?
>

Looks good to me, thanks!


- Neeraj

>     /*
>      * Full ordering against accesses prior current GP and also against
>      * current GP sequence number is enforced by rcu_seq_start() implicit
>      * barrier, relayed by kworkers locking and even further by
>      * smp_mb__after_unlock_lock() barriers chained all the way throughou=
t
>      * the rnp locking tree since sync_exp_reset_tree() and up to the cur=
rent
>      * leaf rnp locking.
>      */
>
> Thanks.
>
> >
> >
> > Thanks
> > Neeraj
> >
> > > +                        */
> > > +                       snap =3D ct_dynticks_cpu_acquire(cpu);
> > >                         if (rcu_dynticks_in_eqs(snap))
> > >                                 mask_ofl_test |=3D mask;
> > >                         else
> > > --
> > > 2.40.1
> > >
> > >
