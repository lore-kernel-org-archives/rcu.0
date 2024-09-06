Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083F13D613
	for <rcu@vger.kernel.org>; Fri,  6 Sep 2024 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725604336; cv=none; b=bqwBrjIOYUjKRvR9fOph/J/kdLH1eNw7oLnq/UiR6EvwwTAS8Ikgif2ATbaTRehTdqwQL4sL6d+P+cQtWINglHE8M2pnpd3N/ofQNBd9P4d+O0lmk60nnLEgYCEKuYzA/vUM5LVHFTSOO7Jv1FujdnnH8akr7iDlAieTSl0IT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725604336; c=relaxed/simple;
	bh=aW4RP2bFoxHJC0IUW5/QBFj/9WlQmttCm0rLAt8nPXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0h2PMv5M8lJEnL5gzmncQoOSyc8hhUHLPfkTwXDX0btyGs7PFK6nfaKDOA2hVxyKxzx9RsZC5ygu18VVpJPi8nifBdxLzolTr1vkCooEhZVtDpOQ4F767/Ggih/k1SrhJPbbXbMo/Vd+eDh3h19CedPCU6t3O9o+wb+anvAdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVHtT07O; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVHtT07O"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so125404466b.0
        for <rcu@vger.kernel.org>; Thu, 05 Sep 2024 23:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725604333; x=1726209133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syqDlsFG8PrTgP/NuncL1T63KjbfWz8Ixi+unKr9gXg=;
        b=XVHtT07O7r85vlwH1+xP1YvpOFpKnKNVdZMXapW6T1QpCH7rN1vgRh2ZVhXnfjvXZs
         UutOObt8508HvCNP/ADutXVvYuEGpdk+24XTFozVfcrUa1FpKtUMdkb8PqdxbtbiZvLE
         Xi6N/pcFf2EhBfbRdYwNOlqbe7LvTIHOGLJHeHxGgu0AOmXN+9aZnlFA7Sl3dxCVGFdO
         48wCEgCAJu2z8qGFy2shjcHXFUaRFzJd+5DJzseSKPB1bV5da6417oEL+zF1Lxntwzzp
         Y812FLySBWZZCZG8+Eypyj5QglBz2U0IZ0Qx7jmJm0oyFdOrIeNzlrgOV0v/HjetF1S6
         8oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725604333; x=1726209133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syqDlsFG8PrTgP/NuncL1T63KjbfWz8Ixi+unKr9gXg=;
        b=DZK2PG/bUtS93YxLDNJ+Yr5ksLQX1NO6ceHiogs0pqNekYKwH15VZ+FeQJ3jJiMd0c
         2Ac51zowG6R4Q54aq6iOWLjir9GW4SDFNaERPUqwLdRO0sPbEUICMA35XY45PYEZcgn3
         J4XsNwBXiRSMwgO5l1nbaHanIV0gR50AniH+2I+9rRCHAJq/IRbF3ZIQrgVuaJmCCI12
         tstTOxVgSofa2iQbxxftv8f6jgjdoQ+jMWEOTSpEOGS0zg8xCjMKnG0sp64FtPLIwGJX
         4ooyH9UoEqOtwICD+7aS8uI1LrvhA5FPofx4BaEXlRtuV9FIibZNfGHCM1mBZuMfM2/s
         2SGw==
X-Forwarded-Encrypted: i=1; AJvYcCW5gT1psfzrxlTNpvVtvOG8RmlRQyVlQD7n/l4NyCpIbgMorGIhTuyPDekxD7iu9MORZlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEOAYWCus728k9Bg0R05cFENwqG2wfVfZ5AeJMvGc4nzcrOhKJ
	FQUyi7FkKHscDI4VPvmplL95FIv20at9N5af5sEgoDHvStwQkRDXJAsFDPcyiqh1h1RWXeNa1lH
	6Kw7wWh55o/9s07gX8UXT494WfSx5/+u4
X-Google-Smtp-Source: AGHT+IGgLwNmzCAIyioZqmQCGSa3IBcw+BR7hvVkYijuL3X45Gi9dz9CfgQNqExUOhYLzp7pzURcrWQzBxTdNhjSThM=
X-Received: by 2002:a17:906:d552:b0:a8a:7c4a:d1d4 with SMTP id
 a640c23a62f3a-a8a8890b06bmr99868366b.65.1725604332857; Thu, 05 Sep 2024
 23:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2747e596-5359-4f32-b3e0-0b2368d37017@paulmck-laptop>
 <CALm+0cV0GwT5umPRZrZWg4oqXwdjcWz-NkxkhgxQkv=NypQthA@mail.gmail.com>
 <CAFTL4hzY09QEGE+sTqc02d2LkuH_ObYKiuVTfGnrtwjtYiwt4A@mail.gmail.com>
 <d31bdc50-a61b-446b-926d-b3ddde832a91@paulmck-laptop> <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>
 <ZthlEg2njJwXMk32@localhost.localdomain> <5bb81db1-bf62-4edc-8d71-dfa192dda39f@paulmck-laptop>
 <Ztn5MOwk4nIfTWv-@localhost.localdomain> <Ztn7PpfFiYDRBjWX@localhost.localdomain>
 <3e62cd89-441f-4a9a-aff7-7ca1dda3c34d@paulmck-laptop>
In-Reply-To: <3e62cd89-441f-4a9a-aff7-7ca1dda3c34d@paulmck-laptop>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Fri, 6 Sep 2024 12:02:00 +0530
Message-ID: <CAFwiDX83q+8fHLrOaLtrbE5q1UKB1BFLS+tGKWyzSKLvDKzFmA@mail.gmail.com>
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 11:34=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Sep 05, 2024 at 08:41:02PM +0200, Frederic Weisbecker wrote:
> > Le Thu, Sep 05, 2024 at 08:32:16PM +0200, Frederic Weisbecker a =C3=A9c=
rit :
> > > Le Wed, Sep 04, 2024 at 06:52:36AM -0700, Paul E. McKenney a =C3=A9cr=
it :
> > > > > Yes, I'm preparing an update for the offending patch (which has o=
ne more
> > > > > embarassing issue while I'm going through it again).
> > > >
> > > > Very good, thank you!
> > >
> > > So my proposal for a replacement patch is this (to replace the patch
> > > of the same name in Neeraj tree):
> >
> > FYI, the diffstat against the previous version of the same patch is as =
follows.
> > The rationale being:
> >
> > 1) rdp->nocb_cb_kthread doesn't need to be protected by nocb_gp_kthread=
_mutex
> >
> > 2) Once rcuoc is parked, we really _must_ observe the callback list cou=
nter decremented
> >    after the barrier's completion.
> >
> > 3) This fixes another issue: rcuoc must be parked _before_
> >    rcu_nocb_queue_toggle_rdp() is called, otherwise a nocb locked seque=
nce
> >    within rcuoc would race with rcuog clearing SEGCBLIST_OFFLOADED conc=
urrently,
> >    leaving the nocb locked forever.
>
> Thank you!!!
>
> Just to make sure that I understand, I apply this patch on top of
> Neeraj's current set of branches to get the fix, correct?
>

I have pushed this diff to branch next.06.09.24a of shared-rcu tree
and started testing.
Will squash this diff to the original commit later.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/commit/?h=
=3Dnext.06.09.24a&id=3D0fc7fc28b5afc3037ae4e1464013bc38c4b51c99


- Neeraj

>                                                         Thanx, Paul
>
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 755ada098035..97b99cd06923 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1056,6 +1056,13 @@ static int rcu_nocb_rdp_deoffload(struct rcu_dat=
a *rdp)
> >       /* Flush all callbacks from segcblist and bypass */
> >       rcu_barrier();
> >
> > +     /*
> > +      * Make sure the rcuoc kthread isn't in the middle of a nocb lock=
ed
> > +      * sequence while offloading is deactivated, along with nocb lock=
ing.
> > +      */
> > +     if (rdp->nocb_cb_kthread)
> > +             kthread_park(rdp->nocb_cb_kthread);
> > +
> >       rcu_nocb_lock_irqsave(rdp, flags);
> >       WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> >       WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
> > @@ -1064,13 +1071,11 @@ static int rcu_nocb_rdp_deoffload(struct rcu_da=
ta *rdp)
> >       wake_gp =3D rcu_nocb_queue_toggle_rdp(rdp);
> >
> >       mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
> > +
> >       if (rdp_gp->nocb_gp_kthread) {
> >               if (wake_gp)
> >                       wake_up_process(rdp_gp->nocb_gp_kthread);
> >
> > -             if (rdp->nocb_cb_kthread)
> > -                     kthread_park(rdp->nocb_cb_kthread);
> > -
> >               swait_event_exclusive(rdp->nocb_state_wq,
> >                                     rcu_nocb_rdp_deoffload_wait_cond(rd=
p));
> >       } else {
