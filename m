Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDE312E5B
	for <rcu@vger.kernel.org>; Sat,  7 Sep 2024 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725700666; cv=none; b=bdiCFlLSRq/MFwp4saxlst8ro3sYQR9COYJnm96gg+KakRZm2mA7RNPPD1m/Cr+UAhxVqoh/uuQNfTadNDLAl6NVXEO2wlo0wj+0nGiwXnQ3erGFtHKkNLD+/xbO9pl0NvyhlFsOUMhfMHAGz99Opxf250va2z3LroKL4JDckDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725700666; c=relaxed/simple;
	bh=59Yctn/MFReaK8/fHP0Fspa+rsRjbeHcEA9gL0JFdXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roL7pouXnbmAkyv22HJ68fZ74bBt781C3V4ITJdgUi5ADVGWfjefZ6UjZRdlbsJYf1kqhdyihUWLq+uEZm6ayYwgWctkM6+Et+yDO1dXrADSMUIGGhxKGGvdg/xl3TQEU3GaO1yiK8JkgMFwQUiFJ70eLvvtjmG90nBJ3eeDO1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJdyHI+k; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJdyHI+k"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so5876010a12.1
        for <rcu@vger.kernel.org>; Sat, 07 Sep 2024 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725700663; x=1726305463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM1BAAjfjudViCU39v5dhmfOFVZcciOLXgU3a/ttS8c=;
        b=RJdyHI+klz11GzdXXxBheqyhw2Xy7YobYVV+zbFExFTfp1BevZWoCBq9QcjzFNoURB
         9yYS0ivbMO5cfMTXdMeOFRCWnnpAGdJD3IUHqMIToqfXZvI8Dvvb/st0ZPg6U3rBUddR
         dzkHa3KSGdLTe5A8cKgwiKK8XlRTiIm/jJndvrwOLMJxeiZBitc2hbkLiqs9OnK7d/Dp
         UCkGPRidgKuIJ9rjzW05rLQDx9Dn21KnYrb/RvpRI02KHtX93xcHxWsMznd4DoKfJmNP
         IV0Thpv8ZXwdub5hn7F4JMJLMpVt7LBEUsRkgAZ1+py9OeOPZGkxlekIqeuouVU5tM5r
         ihMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725700663; x=1726305463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM1BAAjfjudViCU39v5dhmfOFVZcciOLXgU3a/ttS8c=;
        b=LujepTksK/fMcEUh1HdZWxYUwZRp3+WU7P4UsdbhpQRvMk2vuQqOGAa7wKP549uTj7
         O4EfC7SGvQYbexd/Cco9MS81UBcuJJrmWDKBmcDWbWgP4a+YIHAShgb13qpSdysi3MqG
         D/lUMASZiC1jvyI6Yp2TJDWXo963xvQ0KADeBbiHriGCaDAw3ftCW+ULsSUQ8FdbmHhu
         Qy6HA9nZfBUXIsNglEM1jFJIFRro1Wl8voyadUbZwtmCgGsJ5vO9BgWED15/XNHcwlNs
         pqZgB/uHL/r17Fu63qV2DJqghUQF+C5SyuJDOURsmkfXF46z4EmHtnQGM0EnPAyO5W+2
         QklQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBGwMoRyusGGip+5TLmDt/sgEMjsrZ8CBXhn0fBKlS9CA5VXIAH1TSAfCIqyBxs2xSrek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx263B/xedwSo0g9pwO1yy9TD1x4Qn6dvV7NNtWsh2oyPpi/ExE
	yAo23XXylAF2d57lbxxpVe4HE0yoaSB5q4TR+AZLLA8MRM4jRbp2Ooszsa4EfMII7VtQauxstcR
	C+lFkTUZCxhecthd1mD/Qns9iR78=
X-Google-Smtp-Source: AGHT+IEJouV3yO79uvOq+WHeyeeL3yua5eJT44dVXpuQg7A6EM7CMvhAfwdC3dN8U/0O4ep1azPKT1h4hLWpttQKREk=
X-Received: by 2002:a17:907:7247:b0:a8d:2bc7:6331 with SMTP id
 a640c23a62f3a-a8d2bc7668amr90579866b.27.1725700662420; Sat, 07 Sep 2024
 02:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALm+0cV0GwT5umPRZrZWg4oqXwdjcWz-NkxkhgxQkv=NypQthA@mail.gmail.com>
 <CAFTL4hzY09QEGE+sTqc02d2LkuH_ObYKiuVTfGnrtwjtYiwt4A@mail.gmail.com>
 <d31bdc50-a61b-446b-926d-b3ddde832a91@paulmck-laptop> <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>
 <ZthlEg2njJwXMk32@localhost.localdomain> <5bb81db1-bf62-4edc-8d71-dfa192dda39f@paulmck-laptop>
 <Ztn5MOwk4nIfTWv-@localhost.localdomain> <Ztn7PpfFiYDRBjWX@localhost.localdomain>
 <3e62cd89-441f-4a9a-aff7-7ca1dda3c34d@paulmck-laptop> <Ztr_q9dJIYdmc3q_@pavilion.home>
 <c6c9b808-aaaf-412f-8e2e-f509a8c4e266@paulmck-laptop>
In-Reply-To: <c6c9b808-aaaf-412f-8e2e-f509a8c4e266@paulmck-laptop>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Sat, 7 Sep 2024 14:47:30 +0530
Message-ID: <CAFwiDX-G6CzV3gRnfzynrHje_BXWwTmifEABZ3JV42ZV4NQjMQ@mail.gmail.com>
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 9:58=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Fri, Sep 06, 2024 at 03:12:11PM +0200, Frederic Weisbecker wrote:
> > Le Thu, Sep 05, 2024 at 11:04:22PM -0700, Paul E. McKenney a =C3=A9crit=
 :
> > > On Thu, Sep 05, 2024 at 08:41:02PM +0200, Frederic Weisbecker wrote:
> > > > Le Thu, Sep 05, 2024 at 08:32:16PM +0200, Frederic Weisbecker a =C3=
=A9crit :
> > > > > Le Wed, Sep 04, 2024 at 06:52:36AM -0700, Paul E. McKenney a =C3=
=A9crit :
> > > > > > > Yes, I'm preparing an update for the offending patch (which h=
as one more
> > > > > > > embarassing issue while I'm going through it again).
> > > > > >
> > > > > > Very good, thank you!
> > > > >
> > > > > So my proposal for a replacement patch is this (to replace the pa=
tch
> > > > > of the same name in Neeraj tree):
> > > >
> > > > FYI, the diffstat against the previous version of the same patch is=
 as follows.
> > > > The rationale being:
> > > >
> > > > 1) rdp->nocb_cb_kthread doesn't need to be protected by nocb_gp_kth=
read_mutex
> > > >
> > > > 2) Once rcuoc is parked, we really _must_ observe the callback list=
 counter decremented
> > > >    after the barrier's completion.
> > > >
> > > > 3) This fixes another issue: rcuoc must be parked _before_
> > > >    rcu_nocb_queue_toggle_rdp() is called, otherwise a nocb locked s=
equence
> > > >    within rcuoc would race with rcuog clearing SEGCBLIST_OFFLOADED =
concurrently,
> > > >    leaving the nocb locked forever.
> > >
> > > Thank you!!!
> > >
> > > Just to make sure that I understand, I apply this patch on top of
> > > Neeraj's current set of branches to get the fix, correct?
> >
> > Exactly!
>
> It passes the initial tests, an hour of 200*TREE01 and a 10-minute
> torture.sh (which Neeraj likely already ran a longer version of).  I fire=
d

200-minute torture.sh completed successfully at my end.

- Neeraj

> off a 12-hour 200*TREE01 run and a 60-minute torture.sh for overnight.
>
> Here is hoping!  ;-)
>
>                                                         Thanx, Paul
