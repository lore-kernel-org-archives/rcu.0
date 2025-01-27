Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9601FC3
	for <rcu@vger.kernel.org>; Mon, 27 Jan 2025 02:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737946559; cv=none; b=Dbd+x9Fcpz/xifjfGF3ov3gp6Q6EdS55ZFMx58yKirAhzKpjVI0mWo+rBbcL/gk6+g0BmFKFlbqWdHt54hOs2pf1vJMDaKTLBk4u/S6mcTQSK+Vbr3ZRX1MyQgEY1UI3nv73ofJWK2nmYVvLby+4LaQ/GJ4MzMJt8wrAUasgdVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737946559; c=relaxed/simple;
	bh=AJ9VQ239zPrKZYg+MJJ6ro4VFlf4p7LCzHfEhFQ2HH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBsaencLrpPBTlGKyl2hwkZY6i3EgDeSfaMw90GD1+NUbri43gEifyuJrFBxNxgazQ8L0cHSaOL/Mu8j5+3wTlD2IcS8zxei78hlX8nEW2LMqJLxZLunzQmt5BGiAIbIilZd7uyFI1LNSC3iqgcGvGf5RRFiJfqsdi3gcEFUXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=p47JUu/d; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="p47JUu/d"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4368a293339so45275515e9.3
        for <rcu@vger.kernel.org>; Sun, 26 Jan 2025 18:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737946555; x=1738551355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK1mXBPeeuOjLiE1pt79BIcLz1c5fKInaximZ9M/9e4=;
        b=p47JUu/dHRbqcyWBnW5mMbU8YnLmk/yfzwFxK5Lj4PO0y1+17q/1ZtUjny8BE6am/8
         Ykl5QAWLgr8cxYge3nagf9hET5FllJcbzQX/AgIPqYwFegSiizJSoFz5+YgN84cfm6Vd
         SajoZJCE7wGtU04VgKNgiuh3Rdhxzv/iAu7pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737946555; x=1738551355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK1mXBPeeuOjLiE1pt79BIcLz1c5fKInaximZ9M/9e4=;
        b=k+INSS2rSp+LWwGQwgpHJODrB0Mg/VR4vQwMsz1hb31stZYdUUSA1UMKLpqRMiQSAu
         4x5k9QkG87by7Buob7YWEjyLG5yWaOZjG2AifYvvL5eVVQ6I9fbk9whlotK+/UJqtc3p
         nHiU89Z+Wcjp2OmEvXob2iJXnqWiCZuO6W9uTOX9AED7KmWNfsPQtUugg3aOijH5L/YG
         v31kxAM5DskIDBgCgZOHGu0QlKkAswMx2fZKu2SjwIGKwsWVQPLCRVcR4AaKl1KZlh82
         s96SrqK/ld682IvByd7TZ/2bZ9Xo5R4QSvo295F72QrVZQxIKP+B/tzpFXbGw6++w8DX
         3Gpg==
X-Forwarded-Encrypted: i=1; AJvYcCWl7W0JUFryhEeACIbAxElo6OzDGcX2wha5v7TBUNjI3s7clvVS2kZ50Wi/pZizIAfz61s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOggAKA31XVJGLLKpzkSr3xba6XIOhE6zK+xY6gYN20Iu8Mlvg
	OinpsemHvQ7AEDw6Vls9N9rz3YTIsPmVpSBrCgQQdjFmJevJAoSGgcDKHrH0aykVoiErbAdUsgv
	++QvY5aL2PJRC1wNYE+Ooc4oLsnnKKFwJLL9GKQ==
X-Gm-Gg: ASbGnct7Ijv5qUlMKMDFlrOKkClsEu1pM3AKWW6V4ubYLa2UizbDpWk4z2VdzaUjxy+
	EYxYUQXE0sLIzUYqo0ACW2Z7C1nxElnZ6OodWZXll2oO5u1HZT+cReQWZieTozf4=
X-Google-Smtp-Source: AGHT+IGQDKD7f+H9wzA/XyuLo+4SVoi+9cyb7L1mHxZ78+y+h0aRHFEFy8rB4PRI6o37YWf/QWyabh40s0R6MRZtPZk=
X-Received: by 2002:a05:6000:1acd:b0:38a:88be:bcb5 with SMTP id
 ffacd0b85a97d-38bf56555f4mr32487251f8f.5.1737946554992; Sun, 26 Jan 2025
 18:55:54 -0800 (PST)
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
 <CAEXW_YQaC+TYnXZca2MBcJQgf2EWD+pBp-Dih+b647RtpJ+LNQ@mail.gmail.com> <83f5a3ff-8f89-4994-844f-b7eb9e80b16d@paulmck-laptop>
In-Reply-To: <83f5a3ff-8f89-4994-844f-b7eb9e80b16d@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Sun, 26 Jan 2025 21:55:43 -0500
X-Gm-Features: AWEUYZlaXi140bROI_sG8fmZXZmBneS5W5qLn5y4SdjC6ZNbWBHBzq7HV0gAsrc
Message-ID: <CAEXW_YTiX2taVbg3keCR4RuxSdfpVA0fVPpCcDWXjF7rH7Kkdw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start detection
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 9:03=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Sun, Jan 26, 2025 at 08:22:23PM -0500, Joel Fernandes wrote:
> > On Sun, Jan 26, 2025 at 8:13=E2=80=AFPM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > >
> > > Hi, Paul and Frederic,
> > >
> > > [...]
> > > > > > On Sat, Jan 25, 2025 at 12:03:58AM +0100, Frederic Weisbecker w=
rote:
> > > > > > > Le Fri, Dec 13, 2024 at 11:49:49AM -0800, Paul E. McKenney a =
=C3=A9crit :
> > > > > > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > > > > > index 2f9c9272cd486..d2a91f705a4ab 100644
> > > > > > > > --- a/kernel/rcu/rcu.h
> > > > > > > > +++ b/kernel/rcu/rcu.h
> > > > > > > > @@ -162,7 +162,7 @@ static inline bool rcu_seq_done_exact(u=
nsigned long *sp, unsigned long s)
> > > > > > > >  {
> > > > > > > >         unsigned long cur_s =3D READ_ONCE(*sp);
> > > > > > > >
> > > > > > > > -       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s=
, s - (2 * RCU_SEQ_STATE_MASK + 1));
> > > > > > > > +       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s=
, s - (3 * RCU_SEQ_STATE_MASK + 1));
> > > > > > >
> > > [...]
> > > > > > > The way I understand it is that rcu_state.gp_seq might be see=
n started while
> > > > > > > root_rnp->gp_seq is not. So rcu_seq_snap() on the started rcu=
_state.gp_seq
> > > > > > > may return maximum 2 full GPs ahead of root_rnp->gp_seq. And =
therefore it takes below
> > > > > > > 2 GPs to safely deduce we wrapped around.
> > > > > >
> > > > > > Exactly!
> > > > > >
> > > > > > > Should it be ULONG_CMP_LT(cur_s, s - (2 * (RCU_SEQ_STATE_MASK=
 + 1))) ?
> > > > > >
> > > > > > Quite possibly.  I freely admit that I allowed a bit of slop be=
cause
> > > > > > time was of the essence (holidays and all that) and also it doe=
s not
> > > > > > hurt much to lose a couple of counts out of a 2^32 cycle, to sa=
y nothing
> > > > > > of the common-case 2^64 cycle.  It would not hurt to be exact, =
but it
> > > > > > would be necessary to convince ourselves that we were not off b=
y one in
> > > > > > the wrong direction.
> > > > > >
> > > > > > I would be happy to see a patch, as long as it was sufficiently
> > > > > > convincing.
> > > > >
> > > > > I'm not so much concerned about being exact but rather about maki=
ng
> > > > > sure we still understand what we did within one year. We can leav=
e one
> > > > > more grace period than what we expect out of paranoia but, the mo=
st
> > > > > important is that we comment about what we expect and why. Let me
> > > > > prepare a patch for that.
> > > >
> > > > Even better!
> > >
> > > Do we really have users who could pass such a huge delta wrapped
> > > around value to poll() i.e > ULONG_MAX/2 ?  For 32-bit, that would be
> > > 2 billion count since the get() (500 million GPs on 32-bit?). I am
> > > curious if such a scenario should be a WARN() because also: If more
> > > than ULONG_MAX/2 values are possible after get(), then a full or
> > > multiple ULONG_MAX wraparound is also possible. This means then both
> > > rcu_seq_done() and rcu_seq_done_exact() become unreliable anyway for
> > > such stale get() values.
> > >
> > > I do agree with both your points on the side effect of the patch to
> > > rcu_seq_done_exact(), but I am not fully convinced myself about
> > > utility of rcu_seq_done_exact() versus the rcu_seq_done() but I could
> > > be missing something.
> >
> > I want to modify my comment on reliability. rcu_seq_done_exact() is
> > certainly more "reliable" than rcu_seq_done() for wraparound delta  >
> > ULONG_MAX/2. Still with such a huge wrap around it is not fail proof
> > if it lands within the "3 Grace period" window, so if it is not super
> > reliable and if the user should not rely on it, then I wonder if it is
> > better to not do it and instead warn the user they are playing with
> > fire. But a counter-argument might be, landing within the 3 GP window
> > is quite low probability...
>
> It is also a harmless false negative.  And another poll within a few
> hundred milliseconds will set things straight.  In contrast, if we
> used rcu_seq_done(), it would be a good long time before we got out of
> false-negative territory.

True!

> On a 32-bit system, if there was an expedited grace period every 10
> microseconds (just barely possible on small systems), then a 32-bit
> counter would wrap in about 12 hours.  So there would be a six-hour
> false-negative zone.
>
> So an expedited grace period every 10 microseconds combined with
> a six-hour polling delay is unlikely, but not out of the realm of
> possibility.

Assuming that every 10 microsecond of the entire 6 hours is used for
an expedited GP, but I agree with your point.

> Please feel free to nominate a comment.

Ok thanks, I'll see what Frederic comes up with and can take it from there.

Thanks!

- Joel
