Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E917CA1F;
	Tue, 11 Jun 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113614; cv=none; b=iZxspcjC69TbrGi2sTCpy6i6+s7cQknGydvdu/G82+L9bY478XsagfZ+7HnFTdKWvWouR2rv1yGoiTEbCZ6/XaZhVLvb1ZhILF6D7uq4Mm4hQK7p2LwQxQMeTHEGLOTxt/GpjGCCjbBfzeB6hcJEoVg7MgCj5lX11JMnF/2c9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113614; c=relaxed/simple;
	bh=cNanDInxZk7FiGVbiLa/XAwCsdIBmKmI7LvvmzDUm30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqVxZHilsMV3/JC+wNpePZtFS5hkeGUxEhQ1ZnuA7CAf2atTSLEU5TKFqsi4WDUhJ5xx32bWeVqnV/1Tvvh81vEF+woKAfJa8fQQxgSPTKPnf+zj3dhi+BJWj2cjO9fQuZw9ANgoy2Em5Mhg9m3bSqU4kZCVixLZnMcNjAE7aiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+iSwK5C; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+iSwK5C"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so7446789a12.0;
        Tue, 11 Jun 2024 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718113611; x=1718718411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuBdErgY6EqIvR6Zc36TKGGAfL2xSbBTx8rRNPmSZ6U=;
        b=H+iSwK5Cy8K3Jkf86bTsfBYDr9Thxy4GCQycPT8etsIoCkLQiLXfAgGhfRMkOjYWsc
         39JyP48UtvBrg7fWk2B2Te1/iiR2jobyG6U83wWa+igZot3pvywb/NzfVrIdGVyjfoFP
         2sDtAEV5pfI2vYcilnHnkQx/823bQ53BGm8M7cc/az7USVwWYsl0tYM5u9w/+KCOE1an
         m36N9iEWNaBCi5D2TsVqVB5oiqD5vNaiM+x7/AxXbPwFB8LBMhEEnax3E0Ux2B7Jw5E+
         3T8N4/JgmGWyS3XpMRZso3PRdVyKp2NTYyRzASxWmYDgmIuIAC2q1dUJK2BsDwKOBzvj
         IJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718113611; x=1718718411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuBdErgY6EqIvR6Zc36TKGGAfL2xSbBTx8rRNPmSZ6U=;
        b=iydXJaxWs3mfaeWZhMFkYLOJpDbNhmlb28BdPT+zq7IraacWDGHp1VM/mNag2MrvpQ
         cEihZF5b3Wp4ecTIqhXVIqJFgu12gpGmZ7r+E7kDGRgX13a/4IjX0XIcomOoc5vqofWK
         l5li2QQYjAkZgr4SUrfCP3xmMzGJzZkXAmXwxO5drntUT10WCLJ76dLgBUdeOgppnGwY
         nmV3ikGZaVpFnei4zKqIcfFwaoc78iw/ZkmmGW4aockSozgfStjuyPxSmiBcUnTW6Rgi
         XPqEutjOo7s+YeHJHi8J3txIyg7SVQuA5P8bYs90TIFW51oZ+gaUKndpaj57AoN2q+6x
         UfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKWdeAEosrvQ8x5Ve7XkoIsJCTJdhYzDF2JMxYqPGy2XPHDgwSOZIf0XwiFsK3l9wSwl4lcckUk3g8bBwgekws5R1hP1gUIhoWfqJgZLSJmr/cTSPndWyrj3Ou7atPjMOA
X-Gm-Message-State: AOJu0YyFvKjcZJvncXuqJawvhQf/YtllpVHB/3nnqf1eTXv8GWao+6W1
	juRkqkSohXWQclw8FUZtnDa4tDBtBMvjhQKvyBw1F9ABRc4aqq+vTFhlQ5hMIhQ64UjCRptx5dq
	8o3U2CI9rODhUkWrGkoYOd3rJ+gg=
X-Google-Smtp-Source: AGHT+IGAxBa2wTardWl9h4IiZld+tk8tyQWlqZdB61S6QFxjZs3bxuN7Igl2VafPjmgiMBoLXE1uc6We5UcRn6XkBdY=
X-Received: by 2002:a50:8e17:0:b0:57c:6955:41ea with SMTP id
 4fb4d7f45d1cf-57c6955422cmr5411049a12.38.1718113611021; Tue, 11 Jun 2024
 06:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-3-paulmck@kernel.org> <ZmCTvMVlOMFv0-zd@localhost.localdomain>
 <CAFwiDX8yGCEiZE-VC0i=VoGByQArQkwG7beVvQO5wRGsK8rdPQ@mail.gmail.com>
 <beb31a51-253e-4bc4-a73c-456f2bf2fd06@paulmck-laptop> <CAFwiDX-x4=_N2szD2QZhAEkU+kx_eTscz2bcyHqikHq7m=rkpQ@mail.gmail.com>
 <3900dfd9-f2e7-4206-930b-2247186a37db@paulmck-laptop>
In-Reply-To: <3900dfd9-f2e7-4206-930b-2247186a37db@paulmck-laptop>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Tue, 11 Jun 2024 19:16:37 +0530
Message-ID: <CAFwiDX_O3pi-MHimTciPc2Q4SkdDeuvRZdHd6AB5ooMHzio5hQ@mail.gmail.com>
Subject: Re: [PATCH rcu 3/9] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>, Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 8:42=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Jun 07, 2024 at 07:21:55AM +0530, Neeraj upadhyay wrote:
> > On Thu, Jun 6, 2024 at 11:42=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Thu, Jun 06, 2024 at 11:28:07AM +0530, Neeraj upadhyay wrote:
> > > > On Wed, Jun 5, 2024 at 10:05=E2=80=AFPM Frederic Weisbecker <freder=
ic@kernel.org> wrote:
> > > > >
> > > > > Le Tue, Jun 04, 2024 at 03:23:49PM -0700, Paul E. McKenney a =C3=
=A9crit :
> > > > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > > >
> > > > > > In the synchronize_rcu() common case, we will have less than
> > > > > > SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the=
 kworker
> > > > > > is pointless just to free the last injected wait head since at =
that point,
> > > > > > all the users have already been awakened.
> > > > > >
> > > > > > Introduce a new counter to track this and prevent the wakeup in=
 the
> > > > > > common case.
> > > > > >
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > ---
> > > > > >  kernel/rcu/tree.c | 35 ++++++++++++++++++++++++++++++-----
> > > > > >  kernel/rcu/tree.h |  1 +
> > > > > >  2 files changed, 31 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index 6ba36d9c09bde..2fe08e6186b4d 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -96,6 +96,7 @@ static struct rcu_state rcu_state =3D {
> > > > > >       .ofl_lock =3D __ARCH_SPIN_LOCK_UNLOCKED,
> > > > > >       .srs_cleanup_work =3D __WORK_INITIALIZER(rcu_state.srs_cl=
eanup_work,
> > > > > >               rcu_sr_normal_gp_cleanup_work),
> > > > > > +     .srs_cleanups_pending =3D ATOMIC_INIT(0),
> > > > > >  };
> > > > > >
> > > > > >  /* Dump rcu_node combining tree at boot to verify correct setu=
p. */
> > > > > > @@ -1633,8 +1634,11 @@ static void rcu_sr_normal_gp_cleanup_wor=
k(struct work_struct *work)
> > > > > >        * the done tail list manipulations are protected here.
> > > > > >        */
> > > > > >       done =3D smp_load_acquire(&rcu_state.srs_done_tail);
> > > > > > -     if (!done)
> > > > > > +     if (!done) {
> > > > > > +             /* See comments below. */
> > > > > > +             atomic_dec_return_release(&rcu_state.srs_cleanups=
_pending);
> > > > >
> > > > > This condition is not supposed to happen. If the work is schedule=
d,
> > > > > there has to be a wait_queue in rcu_state.srs_done_tail. And decr=
ementing
> > > > > may make things worse.
> > > > >
> > > >
> > > > I also don't see a scenario where this can happen. However, if we a=
re
> > > > returning from here, given that for every queued work we do an
> > > > increment of rcu_state.srs_cleanups_pending, I think it's safer to
> > > > decrement in this
> > > > case, as that counter tracks only the work queuing and execution co=
unts.
> > > >
> > > >     atomic_inc(&rcu_state.srs_cleanups_pending);
> > > >     if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work))
> > > >         atomic_dec(&rcu_state.srs_cleanups_pending);
> > >
> > > Linus Torvald's general rule is that if you cannot imagine how a bug
> > > can happen, don't attempt to clean up after it.  His rationale (which
> > > is *almost* always a good one) is that not knowing how the bug happen=
s
> > > means that attempts to clean up will usually just make matters worse.
> > > And all too often, the clean-up code makes debugging more difficult.
> > >
> >
> > Ok. Thanks for sharing this info!
> >
> > > One example exception to this rule is when debug-objects detects a
> > > duplicate call_rcu().  In that case, we ignore that second call_rcu()=
.
> > > But the reason is that experience has shown that the usual cause real=
ly
> > > is someone doing a duplicate call_rcu(), and also that ignoring the
> > > second call_rcu() makes debugging easier.
> > >
> > > So what is it that Frederic and I are missing here?
> >
> > Maybe nothing. As kworker context does not modify srs_done_tail and
> > invalid values
> > of srs_done_tail  can only be caused by the GP kthread manipulations
> > of  srs_done_tail , my thought here was, we can keep the pending
> > rcu_sr_normal_gp_cleanup_work count consistent with the number of
> > queue_work() and kworker executions, even when we see unexpected
> > srs_done_tail values like these. However, as you described the general =
rule
> > is to not attempt any clean up for such scenarios.
>
> So "if (WARN_ON_ONCE(!done) return;"?
>

Looks good, nit: one more closing parenthesis "if (WARN_ON_ONCE(!done)) ret=
urn;"

> Or is there a better way?
>

I think, above check suffices .


Thanks
Neeraj

>                                                         Thanx, Paul
