Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C718FDBD
	for <rcu@vger.kernel.org>; Mon, 27 Jan 2025 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738003554; cv=none; b=Dla3Qe6n2WI7wP7jvrEYCBZAmzHTyabd1HLrf9k1SiH0DigbTzMlqg4z/jePVT1QG8BpvieoKI2iZQ75lrwM6/HHI5ntH6y66T5JCN4N9cMr3uK5LeLzVctQQevPAoBFNmH7b91zXmBUUERpsiBY7Bx9RajHbrtSQWePL7GRca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738003554; c=relaxed/simple;
	bh=b1HZcN4tBc20/gZMDiVH0q+E1uh5y+bhg5IP2X8/0ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFAAOkozX5wIpaaz6ejaFDEWrB9lBnMSJgKsPOjBamypNJZ8xNDQN5Fvg1YpEdCXzcbnCd3K9NuCNLfTpNHdisf7kNnp4nf2QMIc+lh3MGO0VMQPMNOAeP+6Hkjyx3yaSjaQcExs94JC3mXk+GOglOt4m3CmSB8FZiMYQQvLt3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=AGmKwhxU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="AGmKwhxU"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so2935826f8f.0
        for <rcu@vger.kernel.org>; Mon, 27 Jan 2025 10:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1738003550; x=1738608350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PwzVk8i9K2zGAyqPPcOMZEsWc1d4G5fLm6dwU600kU=;
        b=AGmKwhxUpqPlkkvH1Eii8xTDHCyFRbMb1Yl2bplBjyjjMdHl4LJyWrWH6/ZQhgRK2g
         g8qwTZawskV3d8yey9lQ5VNMCrOrn1DV9v4lZg3/WP91elGWM47/+TS1IpO9pEcnOapP
         Gu6Lv6TOD9YNwYRt3wfrVlfuvatXyFzJgPweQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738003550; x=1738608350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PwzVk8i9K2zGAyqPPcOMZEsWc1d4G5fLm6dwU600kU=;
        b=nk5/zIh8i6hRkQulknH4v/NabftNplVBtSavojHzxEgz5jLDRlZUx1oN+OEVQKTxJd
         kxjPQRBGKsDA61wEF0D9Zof0FtRYU/sFl6YjG96N+MFscvrmpRbIKPNCQ1INtuujp5+q
         FELIqyc2/LAyijmnoaS0+wiQ2es9A+dVKvfG0TSsrTWiwcJDqIr3hG91aljHC49j3g+J
         HRgm9M1a4bWVjN2v0fY9V8i6mKxwfgJORpO4MX3N/nDPx5seE04hFA4UrTkk74cRfoGP
         EQZ40uwSrfe92FkiiNRlRwjxvfiy7Jt0RbZ6lUEJ7imB+ZjE19CWVutRd7juN6PG3qh7
         y1wg==
X-Forwarded-Encrypted: i=1; AJvYcCWiE+B2tlLi9xynXtMQH2I/4t9jYlnftTPMr1XHr2v+SYl7sZO9o95qszcI2dwcn+uuWwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyszbHJj+5CAZywg9nLQaQZ9QtUupv4zFsZePGZVT032daQe8Dl
	pHC6xa9crDrtVdYS4TfUH7upP/WPppAf3//tu2ERjzwdcbrN4oh9lTZqtmJrop5Y/Usap0VGjll
	QMzP0gjnjpiqSRRY4d9r56PEJlsmpfK8XVvM9+A==
X-Gm-Gg: ASbGncuuEodSeekuOtD/h1ZeTos51vWYeoR3JmmBeP2mXv81B5NRGp5ngtr/FWFtCYe
	PVtHJzqw8RtH2jrjVbG6UOyCFb5xgUCaPOIGyjJV4hjYuZr1AjtZx8V03XlbH2PDv3P2fI6piQw
	==
X-Google-Smtp-Source: AGHT+IEiYZxWKw1f4jZlkCoTxbq4GRIK7zA831OCCqdR61OlHR13txvYf/Gcc6R/OYOteXkKArSnlxHyOp93E0RzE/0=
X-Received: by 2002:a5d:598e:0:b0:38c:24c6:5bdc with SMTP id
 ffacd0b85a97d-38c49a1cf43mr426563f8f.4.1738003549735; Mon, 27 Jan 2025
 10:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop>
 <Z5QcXoE0lrS6yIBt@pavilion.home> <d7bbe2cd-d889-40e9-8d46-fb8772fed6db@paulmck-laptop>
 <Z5T7kF7LKIuk05FR@pavilion.home> <a18ec931-a7cb-408b-8707-f88068a13ba9@paulmck-laptop>
 <CAEXW_YReLoj+fofM9=fT-G0rz-E0z7vcwg_ANrbfCrPOX99tYA@mail.gmail.com>
 <CAEXW_YQaC+TYnXZca2MBcJQgf2EWD+pBp-Dih+b647RtpJ+LNQ@mail.gmail.com>
 <83f5a3ff-8f89-4994-844f-b7eb9e80b16d@paulmck-laptop> <CAEXW_YTiX2taVbg3keCR4RuxSdfpVA0fVPpCcDWXjF7rH7Kkdw@mail.gmail.com>
 <CAEXW_YTduDBJY2CbkStWc3-4MP06+bJVFmEbgvfayB6BQyyksw@mail.gmail.com> <76ea9e49-c8d9-4ddf-8dd5-65ba4096e242@paulmck-laptop>
In-Reply-To: <76ea9e49-c8d9-4ddf-8dd5-65ba4096e242@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Mon, 27 Jan 2025 13:45:34 -0500
X-Gm-Features: AWEUYZlg7acBQEhSxUf_ASQiMZ_jsAmHwHh_IhpAlcjR5FqdJd15nPDfUILw4qg
Message-ID: <CAEXW_YSxGb3ph-bBiWsOJS-C2XvW9FUuwtoM1eFVxPomMKUd5A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start detection
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 11:49=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Sun, Jan 26, 2025 at 09:58:11PM -0500, Joel Fernandes wrote:
> > On Sun, Jan 26, 2025 at 9:55=E2=80=AFPM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > >
> > > On Sun, Jan 26, 2025 at 9:03=E2=80=AFPM Paul E. McKenney <paulmck@ker=
nel.org> wrote:
> > > >
> > > > On Sun, Jan 26, 2025 at 08:22:23PM -0500, Joel Fernandes wrote:
> > > > > On Sun, Jan 26, 2025 at 8:13=E2=80=AFPM Joel Fernandes <joel@joel=
fernandes.org> wrote:
> > > > > >
> > > > > > Hi, Paul and Frederic,
> > > > > >
> > > > > > [...]
> > > > > > > > > On Sat, Jan 25, 2025 at 12:03:58AM +0100, Frederic Weisbe=
cker wrote:
> > > > > > > > > > Le Fri, Dec 13, 2024 at 11:49:49AM -0800, Paul E. McKen=
ney a =C3=A9crit :
> > > > > > > > > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > > > > > > > > index 2f9c9272cd486..d2a91f705a4ab 100644
> > > > > > > > > > > --- a/kernel/rcu/rcu.h
> > > > > > > > > > > +++ b/kernel/rcu/rcu.h
> > > > > > > > > > > @@ -162,7 +162,7 @@ static inline bool rcu_seq_done_e=
xact(unsigned long *sp, unsigned long s)
> > > > > > > > > > >  {
> > > > > > > > > > >         unsigned long cur_s =3D READ_ONCE(*sp);
> > > > > > > > > > >
> > > > > > > > > > > -       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT=
(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 1));
> > > > > > > > > > > +       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT=
(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
> > > > > > > > > >
> > > > > > [...]
> > > > > > > > > > The way I understand it is that rcu_state.gp_seq might =
be seen started while
> > > > > > > > > > root_rnp->gp_seq is not. So rcu_seq_snap() on the start=
ed rcu_state.gp_seq
> > > > > > > > > > may return maximum 2 full GPs ahead of root_rnp->gp_seq=
. And therefore it takes below
> > > > > > > > > > 2 GPs to safely deduce we wrapped around.
> > > > > > > > >
> > > > > > > > > Exactly!
> > > > > > > > >
> > > > > > > > > > Should it be ULONG_CMP_LT(cur_s, s - (2 * (RCU_SEQ_STAT=
E_MASK + 1))) ?
> > > > > > > > >
> > > > > > > > > Quite possibly.  I freely admit that I allowed a bit of s=
lop because
> > > > > > > > > time was of the essence (holidays and all that) and also =
it does not
> > > > > > > > > hurt much to lose a couple of counts out of a 2^32 cycle,=
 to say nothing
> > > > > > > > > of the common-case 2^64 cycle.  It would not hurt to be e=
xact, but it
> > > > > > > > > would be necessary to convince ourselves that we were not=
 off by one in
> > > > > > > > > the wrong direction.
> > > > > > > > >
> > > > > > > > > I would be happy to see a patch, as long as it was suffic=
iently
> > > > > > > > > convincing.
> > > > > > > >
> > > > > > > > I'm not so much concerned about being exact but rather abou=
t making
> > > > > > > > sure we still understand what we did within one year. We ca=
n leave one
> > > > > > > > more grace period than what we expect out of paranoia but, =
the most
> > > > > > > > important is that we comment about what we expect and why. =
Let me
> > > > > > > > prepare a patch for that.
> > > > > > >
> > > > > > > Even better!
> > > > > >
> > > > > > Do we really have users who could pass such a huge delta wrappe=
d
> > > > > > around value to poll() i.e > ULONG_MAX/2 ?  For 32-bit, that wo=
uld be
> > > > > > 2 billion count since the get() (500 million GPs on 32-bit?). I=
 am
> > > > > > curious if such a scenario should be a WARN() because also: If =
more
> > > > > > than ULONG_MAX/2 values are possible after get(), then a full o=
r
> > > > > > multiple ULONG_MAX wraparound is also possible. This means then=
 both
> > > > > > rcu_seq_done() and rcu_seq_done_exact() become unreliable anywa=
y for
> > > > > > such stale get() values.
> > > > > >
> > > > > > I do agree with both your points on the side effect of the patc=
h to
> > > > > > rcu_seq_done_exact(), but I am not fully convinced myself about
> > > > > > utility of rcu_seq_done_exact() versus the rcu_seq_done() but I=
 could
> > > > > > be missing something.
> > > > >
> > > > > I want to modify my comment on reliability. rcu_seq_done_exact() =
is
> > > > > certainly more "reliable" than rcu_seq_done() for wraparound delt=
a  >
> > > > > ULONG_MAX/2. Still with such a huge wrap around it is not fail pr=
oof
> > > > > if it lands within the "3 Grace period" window, so if it is not s=
uper
> > > > > reliable and if the user should not rely on it, then I wonder if =
it is
> > > > > better to not do it and instead warn the user they are playing wi=
th
> > > > > fire. But a counter-argument might be, landing within the 3 GP wi=
ndow
> > > > > is quite low probability...
> > > >
> > > > It is also a harmless false negative.  And another poll within a fe=
w
> > > > hundred milliseconds will set things straight.  In contrast, if we
> > > > used rcu_seq_done(), it would be a good long time before we got out=
 of
> > > > false-negative territory.
> > >
> > > True!
> > >
> > > > On a 32-bit system, if there was an expedited grace period every 10
> > > > microseconds (just barely possible on small systems), then a 32-bit
> > > > counter would wrap in about 12 hours.  So there would be a six-hour
> > > > false-negative zone.
> > > >
> > > > So an expedited grace period every 10 microseconds combined with
> > > > a six-hour polling delay is unlikely, but not out of the realm of
> > > > possibility.
> > >
> > > Assuming that every 10 microsecond of the entire 6 hours is used for
> > > an expedited GP, but I agree with your point.
> > >
> > > > Please feel free to nominate a comment.
> > >
> > > Ok thanks, I'll see what Frederic comes up with and can take it from =
there.
> >
> > I forgot to ask is the reason for keeping rcu_seq_done_exact() to have
> > more complexity only when needed, or does it make sense to rename
> > rcu_seq_done_exact() as rcu_seq_done_done() and get rid of the old
> > rcu_seq_done()?
>
> We might well be able to use the rcu_seq_done_exact() algorithm for
> all the uses, but that will require very careful review and testing.
> Please keep in mind that there are quite a few uses, that the benefit
> is small, and I was lazy.  ;-)
>
> The difference with the polling APIs is that a user might well
> legitimately hang onto a cookie for six hours, for example, by having
> used it to tag a data structure in a block cache or similar.

Thanks for clarification. I will work on a patch along these lines and
see if it is worth doing.

 - Joel
