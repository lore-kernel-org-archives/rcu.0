Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FAF523A
	for <rcu@vger.kernel.org>; Mon, 27 Jan 2025 02:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737946706; cv=none; b=U8GdpdgA8aVVJjjNoIZCqP8NsMlM1RBjwDOadE++SZigcoPAt31gMod3hTzg1d9hcNxKZKuguTp6FAxLusDfAN4u8Jd6I3s1ktWiEoOfeWk+cwoz4WmhWkPvq1+ot7dVJZuGA+QF62Ro+phSGfhuMFb91EzE1p7FAyOUYc12kqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737946706; c=relaxed/simple;
	bh=IyuSSrdsXzkDDyqLzge+kSFMCaZelDhjw+/W64SnJ9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjldHdsZdGZvr0OWSpc7/05toXqH6oRfLZZojg1dnlLyEYGm5zGsRN2tX3kqjRyE4i+40Nze2WA4Sva4Euk4byGpJqXDKIF8IbHe8CzOn9am6EIeTnyIAB9WxXP7NfU1oIuv0NgjhN5zYQseX7x76bxyudFxaKdXSBtm8hlbhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=J3QW3pUF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="J3QW3pUF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4368a293339so45287665e9.3
        for <rcu@vger.kernel.org>; Sun, 26 Jan 2025 18:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737946703; x=1738551503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXdyOGyhSJP9op7kIBajGuI40q17Pk+q/S8KVbpFMXo=;
        b=J3QW3pUFUZw1WJoXsV0oouvmbVwoiuLs+9eAiFMcA1hyyW1cNophDM/3qgZ0AAA2ly
         wynSPJe0lj8LqmfW4A+bNi2MH4dcS4jPGCRi5Cx8O9xaUNuczulvKvLSGCqtd8Pq5SMz
         FwkAGT6yslYxtSoxSlTPIimVwyLNWO0YglrSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737946703; x=1738551503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXdyOGyhSJP9op7kIBajGuI40q17Pk+q/S8KVbpFMXo=;
        b=VpKQrx3RMGALoI4wV+5M98Rkq02n1Q7Sz4qhHsbCzXtk5m74dnWg1LjND4UwQ7ijpu
         OxSIjfDw142MLbTWYXtH/yx1N/SZdKTVHkC6b24XvZZafjFkuMqZs8MYx8J6MhrnMsAQ
         pE3OriXSc6VlLePeDPbgbic1z+oRIcx99fNznfp0lkbvn3ZZXJf+fh+vmnZnNelbWvBm
         uvRVvBL40WtwhIypKl6zEUB2obxxy68wD0agWdAQzzf+pKkGZZ7Rtd0pg8jBhts1uGzJ
         eIUSHNMi/3Yf6AsiRlzFySX7tFf+LRgKLMx7j7817GkowxKgDS0UN/IOGIQA3vAlnetP
         y2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXChVRyInAJRMtDO7grJWbj+aFq3/HqFc5KI0kJn93Zxf8MilvgT5EE0aPEn+rR+xv4xzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRG6B7/HlXqT/BZd73XVnt8xiyRUw8mdD5CktbcILVMbnnyUZ2
	hbA+b4UeWvtKkAMyBlkvD9VVB3grU5JvIgqcS7JXNIbJ96NyhLIkBqjMXJwOWt0XFvLFcEHqHae
	+WjRHrGO46uRnrfCHe0poQkt+7xU2U3m5qXlsAw==
X-Gm-Gg: ASbGncsrb93BQVC6DSEQU4ezOHVgD1794MOyljg5OKQSZij3IuMJIRTnmFongrYEiXk
	WzFidp4Ju2E/HJUo3LIkVwedSNOgO9MvNdg/ABFKxMwVJWk9fCGFypou20jkgxOg=
X-Google-Smtp-Source: AGHT+IFz+NcB7/Jqn8YpTQAGd5L8mDZEmVK/lE9a8KfqVfq4RxPykkKDFtcwVIh4QQEfP42m0AkrVgM96hpVfND+dgY=
X-Received: by 2002:a5d:6d02:0:b0:385:e1a8:e28e with SMTP id
 ffacd0b85a97d-38bf56555a0mr36599174f8f.10.1737946702908; Sun, 26 Jan 2025
 18:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
 <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop> <Z5QcXoE0lrS6yIBt@pavilion.home>
 <d7bbe2cd-d889-40e9-8d46-fb8772fed6db@paulmck-laptop> <Z5T7kF7LKIuk05FR@pavilion.home>
 <a18ec931-a7cb-408b-8707-f88068a13ba9@paulmck-laptop> <CAEXW_YReLoj+fofM9=fT-G0rz-E0z7vcwg_ANrbfCrPOX99tYA@mail.gmail.com>
 <CAEXW_YQaC+TYnXZca2MBcJQgf2EWD+pBp-Dih+b647RtpJ+LNQ@mail.gmail.com>
 <83f5a3ff-8f89-4994-844f-b7eb9e80b16d@paulmck-laptop> <CAEXW_YTiX2taVbg3keCR4RuxSdfpVA0fVPpCcDWXjF7rH7Kkdw@mail.gmail.com>
In-Reply-To: <CAEXW_YTiX2taVbg3keCR4RuxSdfpVA0fVPpCcDWXjF7rH7Kkdw@mail.gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Sun, 26 Jan 2025 21:58:11 -0500
X-Gm-Features: AWEUYZnVxaUcM1mXOQ42398SnN3Yk0ZR3oYW-eqw5CXszeHPkQV0ghvlnS4Z5_o
Message-ID: <CAEXW_YTduDBJY2CbkStWc3-4MP06+bJVFmEbgvfayB6BQyyksw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start detection
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 9:55=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Sun, Jan 26, 2025 at 9:03=E2=80=AFPM Paul E. McKenney <paulmck@kernel.=
org> wrote:
> >
> > On Sun, Jan 26, 2025 at 08:22:23PM -0500, Joel Fernandes wrote:
> > > On Sun, Jan 26, 2025 at 8:13=E2=80=AFPM Joel Fernandes <joel@joelfern=
andes.org> wrote:
> > > >
> > > > Hi, Paul and Frederic,
> > > >
> > > > [...]
> > > > > > > On Sat, Jan 25, 2025 at 12:03:58AM +0100, Frederic Weisbecker=
 wrote:
> > > > > > > > Le Fri, Dec 13, 2024 at 11:49:49AM -0800, Paul E. McKenney =
a =C3=A9crit :
> > > > > > > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > > > > > > index 2f9c9272cd486..d2a91f705a4ab 100644
> > > > > > > > > --- a/kernel/rcu/rcu.h
> > > > > > > > > +++ b/kernel/rcu/rcu.h
> > > > > > > > > @@ -162,7 +162,7 @@ static inline bool rcu_seq_done_exact=
(unsigned long *sp, unsigned long s)
> > > > > > > > >  {
> > > > > > > > >         unsigned long cur_s =3D READ_ONCE(*sp);
> > > > > > > > >
> > > > > > > > > -       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur=
_s, s - (2 * RCU_SEQ_STATE_MASK + 1));
> > > > > > > > > +       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur=
_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
> > > > > > > >
> > > > [...]
> > > > > > > > The way I understand it is that rcu_state.gp_seq might be s=
een started while
> > > > > > > > root_rnp->gp_seq is not. So rcu_seq_snap() on the started r=
cu_state.gp_seq
> > > > > > > > may return maximum 2 full GPs ahead of root_rnp->gp_seq. An=
d therefore it takes below
> > > > > > > > 2 GPs to safely deduce we wrapped around.
> > > > > > >
> > > > > > > Exactly!
> > > > > > >
> > > > > > > > Should it be ULONG_CMP_LT(cur_s, s - (2 * (RCU_SEQ_STATE_MA=
SK + 1))) ?
> > > > > > >
> > > > > > > Quite possibly.  I freely admit that I allowed a bit of slop =
because
> > > > > > > time was of the essence (holidays and all that) and also it d=
oes not
> > > > > > > hurt much to lose a couple of counts out of a 2^32 cycle, to =
say nothing
> > > > > > > of the common-case 2^64 cycle.  It would not hurt to be exact=
, but it
> > > > > > > would be necessary to convince ourselves that we were not off=
 by one in
> > > > > > > the wrong direction.
> > > > > > >
> > > > > > > I would be happy to see a patch, as long as it was sufficient=
ly
> > > > > > > convincing.
> > > > > >
> > > > > > I'm not so much concerned about being exact but rather about ma=
king
> > > > > > sure we still understand what we did within one year. We can le=
ave one
> > > > > > more grace period than what we expect out of paranoia but, the =
most
> > > > > > important is that we comment about what we expect and why. Let =
me
> > > > > > prepare a patch for that.
> > > > >
> > > > > Even better!
> > > >
> > > > Do we really have users who could pass such a huge delta wrapped
> > > > around value to poll() i.e > ULONG_MAX/2 ?  For 32-bit, that would =
be
> > > > 2 billion count since the get() (500 million GPs on 32-bit?). I am
> > > > curious if such a scenario should be a WARN() because also: If more
> > > > than ULONG_MAX/2 values are possible after get(), then a full or
> > > > multiple ULONG_MAX wraparound is also possible. This means then bot=
h
> > > > rcu_seq_done() and rcu_seq_done_exact() become unreliable anyway fo=
r
> > > > such stale get() values.
> > > >
> > > > I do agree with both your points on the side effect of the patch to
> > > > rcu_seq_done_exact(), but I am not fully convinced myself about
> > > > utility of rcu_seq_done_exact() versus the rcu_seq_done() but I cou=
ld
> > > > be missing something.
> > >
> > > I want to modify my comment on reliability. rcu_seq_done_exact() is
> > > certainly more "reliable" than rcu_seq_done() for wraparound delta  >
> > > ULONG_MAX/2. Still with such a huge wrap around it is not fail proof
> > > if it lands within the "3 Grace period" window, so if it is not super
> > > reliable and if the user should not rely on it, then I wonder if it i=
s
> > > better to not do it and instead warn the user they are playing with
> > > fire. But a counter-argument might be, landing within the 3 GP window
> > > is quite low probability...
> >
> > It is also a harmless false negative.  And another poll within a few
> > hundred milliseconds will set things straight.  In contrast, if we
> > used rcu_seq_done(), it would be a good long time before we got out of
> > false-negative territory.
>
> True!
>
> > On a 32-bit system, if there was an expedited grace period every 10
> > microseconds (just barely possible on small systems), then a 32-bit
> > counter would wrap in about 12 hours.  So there would be a six-hour
> > false-negative zone.
> >
> > So an expedited grace period every 10 microseconds combined with
> > a six-hour polling delay is unlikely, but not out of the realm of
> > possibility.
>
> Assuming that every 10 microsecond of the entire 6 hours is used for
> an expedited GP, but I agree with your point.
>
> > Please feel free to nominate a comment.
>
> Ok thanks, I'll see what Frederic comes up with and can take it from ther=
e.
>

I forgot to ask is the reason for keeping rcu_seq_done_exact() to have
more complexity only when needed, or does it make sense to rename
rcu_seq_done_exact() as rcu_seq_done_done() and get rid of the old
rcu_seq_done()?

thanks,

 - Joel
