Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF15184D
	for <rcu@vger.kernel.org>; Tue,  8 Oct 2024 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728353599; cv=none; b=ABcn2X0uAU50rhM7MU5u9vAahtn3x/mT0Ld0Y24PLwOgeGlZRkouetO6sYudJWtIYyRbPnLPNVXatx9XBnOgMr9H0LL7QmGa8RyiSI8La7u4ky9ROKDeTLXAgICwfrOWmHV3aw0+R+3UmSj8BWDxfCRE/zERlWCVZO14I/DABkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728353599; c=relaxed/simple;
	bh=r9TUdghLDdL7jBfZndhztdR6du/pefzVhcB+4Qbae4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6D9MeFWZ9qnV4jsEJ7OAKjfLsvcTgAUwMPptLPPLc5XSoVUjv6fBjoGiCT22o3h11OtqPVN3LZ22gODQDBKcL1SAF9b20HBRYXMqOKg6nSLSXZ+OKmRotm1vgav9iNjHGNPErNwzTE+vUbEx0i8Y5bB+OLGwGwnQBdkSbcfFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJdqOiLR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJdqOiLR"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e09ff2d890so4292667a91.0
        for <rcu@vger.kernel.org>; Mon, 07 Oct 2024 19:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728353598; x=1728958398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nl8hhB1O4FCDIM4jMb/3yCtUFqDHBBP63qP3aD+bnOg=;
        b=EJdqOiLRUsRJpJL/yO9t3xY46DyM2c04JuOnQd8XqpsJNHEARzLVgkSppoWDV7tROt
         vsMoAbJ4IxVOpqmEUR+Ez8UpbfHDFJKM4vCFhiLaL+Jfo0QXM3Uz3BnxuyKFKSrzu76q
         yAJw0d6IewE7rHyURK5OSbVSkkjuTHmUhFZ+zVLpSRCNLllUma59fNBBxMHx3zQHMV9r
         w3Kdu83xLz2H+o+ewa3pIaz6HFCpWTNygZQ6sF2KQAn6FYfC2xTQgC91Z/8Auxz1cOAX
         18z/9rUqsCaaelQPmWtXZSPreTPTbq4PVpFRAnMPLYrPCCXPFSexrqFeIwORWnlSzm/B
         Zw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728353598; x=1728958398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nl8hhB1O4FCDIM4jMb/3yCtUFqDHBBP63qP3aD+bnOg=;
        b=PzeWP06E2kyIUtdzaqF5+4zChXa6mtaMma4wH2LMboD7Vx5WlIMlVBfxvggmNqkxcR
         Y5iygAcKOOWgjqHuuA6fASFYqkioEk4chCJwogieW8lOjyhAqziDS8is1CP+Hb9+/b0I
         4dSHYcBYSURPpfMAgn8AztueL9ixf9UVuwOI6qLWy9q00O9VNcD9fqoQ+9+O2A6S6xwP
         YXGDsCzvLBQiO+ECA3owdxVOi2u6KTpfLFdVQTA1Thq2w4dckrCSCobuScxRN992vxk3
         y4Z2C8p9bUkK/JmsDhrXx4bmO7JyiHa7mZBDc++OL5fRGartyuiimhlRNqlJ1VdRaxss
         R6JA==
X-Forwarded-Encrypted: i=1; AJvYcCWJmoOWO6G7o/IRwCnaSqquFupC+5B1StWGHdexPBhRiHAgDGCFJHsrc7qhhFVDXD6YdWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCKUGREZ78wkMf4O76kVQ8HenxhNYJeH1bND23kgszRjBCmYAk
	BgAa/6DXqJgaFmgaf9e3l+1zBHD78eBYJ3VZ/frpu70IrJW1z9G5HYospjffY3fLmohIOBtpW4J
	ipyLPbEs6KDI+N2qvOb8+VraD7c0=
X-Google-Smtp-Source: AGHT+IFxmQAdq1Qq7H87kkPjKF/WWqmZ6nli8lO64qs6cDEORok2ijIx4FGHHPT3/YmO7/UiU0hK1DwCDP5WzTX77Nc=
X-Received: by 2002:a17:90a:2ecc:b0:2cf:fe5d:ea12 with SMTP id
 98e67ed59e1d1-2e1e626c037mr17126667a91.24.1728353597737; Mon, 07 Oct 2024
 19:13:17 -0700 (PDT)
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
 <CALm+0cXA8LJM7RWO5uqowkN3-gZYidPuyXZoHOJi10cJja1qPQ@mail.gmail.com> <Zv8tsbnYDgFNfSPq@pavilion.home>
In-Reply-To: <Zv8tsbnYDgFNfSPq@pavilion.home>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Tue, 8 Oct 2024 10:13:03 +0800
Message-ID: <CALm+0cU92CYKfzqhT9DakxEZ6kyMjjzDR8YQGKvtTgp57vMLew@mail.gmail.com>
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Le Thu, Oct 03, 2024 at 10:01:57PM +0800, Z qiang a =C3=A9crit :
> > When the rcuoc kthreads process rcu callback, before invoke
> > rcu_segcblist_add_len(&rdp->cblist, -count),
> > the rcu_barrier() can insert rcu_barrier_callback() func to offline
> > cpu rdp's->list.
>
> Excellent analysis! Indeed we can have:
>
> CPU 0                         CPU 1                          CPU 2
> -----                         -----                          -------
>
> // deoffload                  // nocb_cb_wait                // rcutortur=
e
> rcu_barrier()
>     rcu_segcblist_entrain()
>         rcu_segcblist_add_len(1);
>                              rcu_do_batch()
>                                  rcu_barrier_callback()
>                                                              rcu_barrier(=
)
>                                                                  // still=
 see len =3D=3D 1
>                                                                  rcu_segc=
blist_entrain()
>                                                                       rcu=
_segcblist_add_len(1);
>                                  // decrement len
>                                  rcu_segcblist_add_len(-1);
>                              kthread_parkme()
> // Warn because there is
> // still a pending barrier
> WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
>
>
> And the worst is that the second rcu_barrier() is ignored.
>
> >
> > 6,5408,150692937,-,caller=3DT453;rcu: rcu_callback func: rcu_barrier_ca=
llback
> >
> > Maybe we can wait until rcu_segcblist_n_cbs(&rdp->cblist) return zero
> > and then invoke kthread_parkme() in rcuoc kthreads.
>
> > Any thoughts ?
>
> Sounds good, or simply make sure that rdp->nocb_cb_sleep =3D=3D false bef=
ore
> parking? Since kthread_park() should only be called after rcu_barrier() a=
nd
> then rdp->nocb_cb_sleep shouldn't be set to true as long as there is a pe=
nding
> one? Well we can also add a WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist=
))
> before calling kthread_park().
>
> Would you like to send the fix?

I will update and send the fix :) .

Thanks
Zqiang

>
> Thanks.
