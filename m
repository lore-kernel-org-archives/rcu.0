Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014973A1B5;
	Thu,  6 Jun 2024 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717653503; cv=none; b=L3kaZCZsgMKl+HONjmLmfnZN07cagXdFNScyIHqHyGRnNfvUj2arADJBMFbgZd7sja1+npT9ff19SNk5u0zM3l0XjdLYwegel2rkb390OlcYgKVlfZj5pfRg4DkLE1ZoFGMVVW8cygsAO1luoqsf8F3//C2ixWRUuaWr0ibAG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717653503; c=relaxed/simple;
	bh=6NWcvCXPzOmQL03xuUwIf0ZfJFfV4TLSn/3ewibXaUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRgLEmyd7kpHRfEcE3f7b/8o6tUfryOowfviSXyZne6XPHG7ZcfgGRisICvPRihryZw2Ix8dBbJD9H5LA7uyVLN2NL40fVv4vBm+rkQdv1o4LtUJBXbJD+jpApQgCxKRyfY/OvsX5+Ba1w2JU3IBXkodTEIIbH83VuGtK3M7/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrLx96W3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrLx96W3"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a2f27090aso2852647a12.0;
        Wed, 05 Jun 2024 22:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717653500; x=1718258300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1mYtjBByOprl6ZmfuL/H30Cog14YD+HEdn6u5NccMA=;
        b=QrLx96W37KP9KQSWLUOaCeKEM901nqpyBeGTtb+lzcXrpRh8U++sHmreUxtDCBqIKl
         yV6plTz8K4rXiMCCr7sAECJLj3WEL4/2HExoZHm9c2xIQFC6pfco5UOvgk80k4Ky3qk8
         XNmzbv2mWFuUgcXKx1ECoh5HFp5ujztYRUsqRcO1eNBI7wgH1SsjaWZ7CYDMk92VyLFx
         t+MjkC2AyU9zGaqmZ3ffW5P/N4jXI1AmsPZlhx/FdF9+Umo7BhizFrgfnu1kPjE5bwz/
         5RDlRBqyXgMgyvG1f/WWvDwZt4ViVSdYS/xYK0TLsB+xLRhzme7WJuPd2R0/7bRzvhMx
         rkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717653500; x=1718258300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1mYtjBByOprl6ZmfuL/H30Cog14YD+HEdn6u5NccMA=;
        b=EQxUSNo/reTZFK7uDn4V2amYKdH4/dcmOK2pjdiyuk37UIr2noouWRxYxiMLkzT8SD
         lI4Rih8PX+xkwnjzkjgw40ZHaTdjwwcpeBeUgxhHpsHrngNhXPV4lbygYnV2fs9xLaWF
         l91ogcQryI7HjDDV02hV0NOVtKdQTIjCbG1Ca2dMdBW3BnL0xEikNzmFbMeANaguQE6S
         Ex91DOj0reTJb8II9T1knoanptSqZUx6svyG5bAQ0fjO+Xo1dAEuJLVFP5KLpZwS/Ijf
         Fya4zoywQ/L1ZyoWj7hjj2pQgn5aObaAgWR2JxLGf35hsTwJ4jHHFA9zctIJkDPqDHpB
         VAZA==
X-Forwarded-Encrypted: i=1; AJvYcCVUbr/xA8KVkk7pfYVAmBmR7/I1DE4G8Vdyn//+T4VEhbq7xgUnVzRCZ9pII2/FdTOnbGTzDAOyrAc+LvQbCudJHwJU1bjNBMDAiaPC+bF9QyaMkL3iu5sOOG6Zv0HkslHa
X-Gm-Message-State: AOJu0Yz2qiY54cwMmODo4qmLMEc7flurxEmxTdh3HBssSIIBsp4bKpVf
	15T6S4Lcnw1PTZfdi9XcSit/ncbae9ACq77S4UW8umx9TCapgDqI4tPqcDGVvUkRsfCKjghAwyO
	5cy24XZnDI2wee36+FUCeboQ0ofJ2/f9kd8s=
X-Google-Smtp-Source: AGHT+IEys7geThk0pva0KeRlzuve++l6LF43LlkA5b2bW48UwAZZ4TpcxWzTiCpa5GRUMks/MiKkC5EhfnEfGLW1VOg=
X-Received: by 2002:a50:9f2c:0:b0:578:63ec:3e90 with SMTP id
 4fb4d7f45d1cf-57aa55ae1dbmr1347672a12.14.1717653499952; Wed, 05 Jun 2024
 22:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-3-paulmck@kernel.org> <ZmCTvMVlOMFv0-zd@localhost.localdomain>
In-Reply-To: <ZmCTvMVlOMFv0-zd@localhost.localdomain>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Thu, 6 Jun 2024 11:28:07 +0530
Message-ID: <CAFwiDX8yGCEiZE-VC0i=VoGByQArQkwG7beVvQO5wRGsK8rdPQ@mail.gmail.com>
Subject: Re: [PATCH rcu 3/9] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>, Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 10:05=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Tue, Jun 04, 2024 at 03:23:49PM -0700, Paul E. McKenney a =C3=A9crit :
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> >
> > In the synchronize_rcu() common case, we will have less than
> > SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> > is pointless just to free the last injected wait head since at that poi=
nt,
> > all the users have already been awakened.
> >
> > Introduce a new counter to track this and prevent the wakeup in the
> > common case.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree.c | 35 ++++++++++++++++++++++++++++++-----
> >  kernel/rcu/tree.h |  1 +
> >  2 files changed, 31 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 6ba36d9c09bde..2fe08e6186b4d 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -96,6 +96,7 @@ static struct rcu_state rcu_state =3D {
> >       .ofl_lock =3D __ARCH_SPIN_LOCK_UNLOCKED,
> >       .srs_cleanup_work =3D __WORK_INITIALIZER(rcu_state.srs_cleanup_wo=
rk,
> >               rcu_sr_normal_gp_cleanup_work),
> > +     .srs_cleanups_pending =3D ATOMIC_INIT(0),
> >  };
> >
> >  /* Dump rcu_node combining tree at boot to verify correct setup. */
> > @@ -1633,8 +1634,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct=
 work_struct *work)
> >        * the done tail list manipulations are protected here.
> >        */
> >       done =3D smp_load_acquire(&rcu_state.srs_done_tail);
> > -     if (!done)
> > +     if (!done) {
> > +             /* See comments below. */
> > +             atomic_dec_return_release(&rcu_state.srs_cleanups_pending=
);
>
> This condition is not supposed to happen. If the work is scheduled,
> there has to be a wait_queue in rcu_state.srs_done_tail. And decrementing
> may make things worse.
>

I also don't see a scenario where this can happen. However, if we are
returning from here, given that for every queued work we do an
increment of rcu_state.srs_cleanups_pending, I think it's safer to
decrement in this
case, as that counter tracks only the work queuing and execution counts.

    atomic_inc(&rcu_state.srs_cleanups_pending);
    if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work))
        atomic_dec(&rcu_state.srs_cleanups_pending);




Thanks
Neeraj

> So this should be:
>
> if (WARN_ON_ONCE(!done))
>    return;
>
> Thanks.
>
