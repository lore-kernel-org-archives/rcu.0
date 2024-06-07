Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754864C76;
	Fri,  7 Jun 2024 01:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725132; cv=none; b=owgFUFV5Lvo5litYoxhaibJ1FWxt2BNiScBW8xuDhWtuKOo/mYqiXt8B3bJle8okBWHaXlj076pypPfkFJQG7cHUr97epL7K+AgOGgLzVunDQLw0EMqahAQzEPGvhlPovYxqnMWos8eBD4Xzl9gcz/05djgl5a5FWvF8qOn8nAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725132; c=relaxed/simple;
	bh=Ft9K5tqBcGHPfK6ue+b6pgSwXcSkS7vdLQtR+6Ntohs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZMFIAVVxgKNmM3lnvcKAisVGot0Izdu/YNZfbzuexRSVX+68zu+t2Asay03pdfqffcksQwbKT6B3rZz4GU1uJQhAX03sGER2A3/l2d5l2+Pnq6eAU2GqdNsr+CBN+aZ4EJGGyllsKG57wwSif1yXBQD9vLmvjfxal3O9FF+XSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuuQ7iwo; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuuQ7iwo"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b962c4bb6so2291845e87.3;
        Thu, 06 Jun 2024 18:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717725128; x=1718329928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feKQLMNR2OCkrvMLmagnriZF6/TtRYUMMPipPVIqagk=;
        b=TuuQ7iwoKs8fSj8EWyKJjvo2Vyq2L7DQejYwXan4A3sKRkD0+stHxCAJkNo7fRwTNC
         gCHwEMrLoXw6ah3hTJTH5aBIqm5QArtkDsSRVRwLyLGghjllLdM1NiJIR25A+Bu40iZ4
         7yJGDWjZF1Ae1Vlg4DXHKoGEq47/4GXnfCEUHENtygA7PUA94noSxcDxVUHlpG/Q82tJ
         cANqzfYmWwiSCxRgiYzWFeIc9LnPESLRdWIyaUfPkUxFd/2gqTECn1asoxKx0KAGEh3B
         ahUhRRLFCGvGkOEoaL6JptkDrE0bEPLuQttCR+oe3jngYoguBaP17RQG5TCm4eY+nEc6
         0Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717725128; x=1718329928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feKQLMNR2OCkrvMLmagnriZF6/TtRYUMMPipPVIqagk=;
        b=nTMrr2mK5o0Q2I6JbVJSQC3NOv3AqTbt/8UWh/LzjgDRDl5/fymiqRSmoEwCK9Oan6
         TCLTkbZNoiVwDhf4BKHVkPp7ZRUQQPu2ygQKj/pVtXaIsn+eX+tdwheX/RwfluTXR7zW
         zZeVyrFSAbBh5Y91HugLgTOmzfIamEIM3Q2BOTHpuDz1xEFWn3P0bUyqheCt1WO2mhct
         WbZ83P+0sHuNgTEDKBPBokcbxbjcNU92tQv+y/lWOquQhsdaW04eae7rPRlrR/aK4UPR
         v4zHrZ75O9scFNSd3gcpBNrZJxa3r4XYvxRNivoaIgwaSBtu7lxANg7Y64ka4xKDY+/J
         ZuQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/uKl9HZ3B7qsJOUyiPsNwGAXmE2vDIWptiQUTC51/yJspjRdVhBUQ6UGY67rWAMKh07vU9HwKZMevzUrYcs6zaJB4ZrbCB4q1YuKIRJFo5Svuj3Nx34gc2vf3wXW7XzMh
X-Gm-Message-State: AOJu0Yw4JdVvBapra4lOOrMEUoJ0g40GF5RngYcQCnULmMZmEQOInrff
	C4QrW0bOZ+s3MdLtZRVFcJO5Rcg3IApw53r1w9xHr6IjMj0ooc0IPI+khywprt2DIWmNcaNjJQu
	Z6kXMkR+pQBbuTfFGpwK61UlHTIs=
X-Google-Smtp-Source: AGHT+IE70XrJkjRuPIhSRl0W6yWUryDU1Bd4WSoWyxJjq2t0jbQIcSTuI5G78mq3z9NseE8K6bZD1urRowmDxy21wPs=
X-Received: by 2002:ac2:4c25:0:b0:52b:940d:b3d with SMTP id
 2adb3069b0e04-52bb9fc62f4mr869612e87.50.1717725128163; Thu, 06 Jun 2024
 18:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-3-paulmck@kernel.org> <ZmCTvMVlOMFv0-zd@localhost.localdomain>
 <CAFwiDX8yGCEiZE-VC0i=VoGByQArQkwG7beVvQO5wRGsK8rdPQ@mail.gmail.com> <beb31a51-253e-4bc4-a73c-456f2bf2fd06@paulmck-laptop>
In-Reply-To: <beb31a51-253e-4bc4-a73c-456f2bf2fd06@paulmck-laptop>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Fri, 7 Jun 2024 07:21:55 +0530
Message-ID: <CAFwiDX-x4=_N2szD2QZhAEkU+kx_eTscz2bcyHqikHq7m=rkpQ@mail.gmail.com>
Subject: Re: [PATCH rcu 3/9] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>, Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 11:42=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Jun 06, 2024 at 11:28:07AM +0530, Neeraj upadhyay wrote:
> > On Wed, Jun 5, 2024 at 10:05=E2=80=AFPM Frederic Weisbecker <frederic@k=
ernel.org> wrote:
> > >
> > > Le Tue, Jun 04, 2024 at 03:23:49PM -0700, Paul E. McKenney a =C3=A9cr=
it :
> > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > >
> > > > In the synchronize_rcu() common case, we will have less than
> > > > SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kwo=
rker
> > > > is pointless just to free the last injected wait head since at that=
 point,
> > > > all the users have already been awakened.
> > > >
> > > > Introduce a new counter to track this and prevent the wakeup in the
> > > > common case.
> > > >
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 35 ++++++++++++++++++++++++++++++-----
> > > >  kernel/rcu/tree.h |  1 +
> > > >  2 files changed, 31 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 6ba36d9c09bde..2fe08e6186b4d 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -96,6 +96,7 @@ static struct rcu_state rcu_state =3D {
> > > >       .ofl_lock =3D __ARCH_SPIN_LOCK_UNLOCKED,
> > > >       .srs_cleanup_work =3D __WORK_INITIALIZER(rcu_state.srs_cleanu=
p_work,
> > > >               rcu_sr_normal_gp_cleanup_work),
> > > > +     .srs_cleanups_pending =3D ATOMIC_INIT(0),
> > > >  };
> > > >
> > > >  /* Dump rcu_node combining tree at boot to verify correct setup. *=
/
> > > > @@ -1633,8 +1634,11 @@ static void rcu_sr_normal_gp_cleanup_work(st=
ruct work_struct *work)
> > > >        * the done tail list manipulations are protected here.
> > > >        */
> > > >       done =3D smp_load_acquire(&rcu_state.srs_done_tail);
> > > > -     if (!done)
> > > > +     if (!done) {
> > > > +             /* See comments below. */
> > > > +             atomic_dec_return_release(&rcu_state.srs_cleanups_pen=
ding);
> > >
> > > This condition is not supposed to happen. If the work is scheduled,
> > > there has to be a wait_queue in rcu_state.srs_done_tail. And decremen=
ting
> > > may make things worse.
> > >
> >
> > I also don't see a scenario where this can happen. However, if we are
> > returning from here, given that for every queued work we do an
> > increment of rcu_state.srs_cleanups_pending, I think it's safer to
> > decrement in this
> > case, as that counter tracks only the work queuing and execution counts=
.
> >
> >     atomic_inc(&rcu_state.srs_cleanups_pending);
> >     if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work))
> >         atomic_dec(&rcu_state.srs_cleanups_pending);
>
> Linus Torvald's general rule is that if you cannot imagine how a bug
> can happen, don't attempt to clean up after it.  His rationale (which
> is *almost* always a good one) is that not knowing how the bug happens
> means that attempts to clean up will usually just make matters worse.
> And all too often, the clean-up code makes debugging more difficult.
>

Ok. Thanks for sharing this info!

> One example exception to this rule is when debug-objects detects a
> duplicate call_rcu().  In that case, we ignore that second call_rcu().
> But the reason is that experience has shown that the usual cause really
> is someone doing a duplicate call_rcu(), and also that ignoring the
> second call_rcu() makes debugging easier.
>
> So what is it that Frederic and I are missing here?
>

Maybe nothing. As kworker context does not modify srs_done_tail and
invalid values
of srs_done_tail  can only be caused by the GP kthread manipulations
of  srs_done_tail , my thought here was, we can keep the pending
rcu_sr_normal_gp_cleanup_work count consistent with the number of
queue_work() and kworker executions, even when we see unexpected
srs_done_tail values like these. However, as you described the general rule
is to not attempt any clean up for such scenarios.

Thanks
Neeraj



>                                                         Thanx, Paul
>
> > Thanks
> > Neeraj
> >
> > > So this should be:
> > >
> > > if (WARN_ON_ONCE(!done))
> > >    return;
> > >
> > > Thanks.
> > >
> >
