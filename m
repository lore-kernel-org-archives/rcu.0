Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D5EC5
	for <rcu@vger.kernel.org>; Tue, 11 Feb 2025 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739236962; cv=none; b=bqzpxlLcvO0q6SGs2qDkirUfxpAkH5pMuvDqopVqlSYCC+CKUCBnaNvbu4UxAqtk06E1KjqAPlPS+PPrPu5dwzHfuN6y2S+oOx0yJFmgSBvdcLwD/bWEfLWnCHwW2gmLxHMyskCFS9k00PKtNoOucqjYqS4tntMR84mTw2O0oKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739236962; c=relaxed/simple;
	bh=au2bZF1OScEOBCrd96oyl08zbp5M8PPPqxgLxhe6iUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpst6e3HtqNsUD2hz/Io/Er/Hc8k4bD3Pbm22eU5bPIkaQutpjQxws3yCRNhOas2ots08QHEGfPsossw5f7vR1mXrxNwJGVpSIjQ/ZNTMmAXJpJDvzO+kWQ9x/3PEuhez4eo5qb8Q1ZWRrGpajbc18vAHS71egkazB/EMiPfIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=CujmAHYm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CujmAHYm"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dd93a4e8eso1765879f8f.1
        for <rcu@vger.kernel.org>; Mon, 10 Feb 2025 17:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1739236959; x=1739841759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5O9w8IVWMgyEk5cTPeIOHrXp4ugRcHBOEquvRu1qGg=;
        b=CujmAHYmI6EQv1eve/9pbBP7nRIRrmXYMEOmnA/oPD/BonyxKvIgNbOXZ3nWREc1Op
         cJy5Ex/sUJLVXBhe7lwarrFxb24jMWcnjha8vy8kXuAeCujxpscNcHneJGmIcvRvbgNa
         pzZPFcjkjNPT1dT+8tuieKGviNzmI3qwOLX8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739236959; x=1739841759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5O9w8IVWMgyEk5cTPeIOHrXp4ugRcHBOEquvRu1qGg=;
        b=HOVm1Qja899hwHFxaz8RXIOTPjTKzf5rt3kv6veVs87LVE+EOsA9Gsp/yIZl+IPGBV
         kAy18CRvB229Oo+DDxcBggr59fxYqpu//wm9J0F8myPrCdjf2hzujJA5cB3DCtXj/F35
         P+NyS0Szi7s8jPrsoU915oE1f8mtnzkf2KjOWM/LeQs6EQOgvs8h0ppN35QfG/Z3h5rY
         jUw7SNzTMOF3jcfpRLoMCxlQCOLlVALYcV67aPl29XrJ5dh1SEFGn8wzRQKWar46GFY+
         98oWfDXvpNkdXlat/MX+77LQp81Awh2FhmVWxwE/XnpF+29n/oRGX/YHyDBw3Ep0iBuV
         bs4w==
X-Forwarded-Encrypted: i=1; AJvYcCXFA9amOJrKQx1WDXIeClwmEOO6hDxbXkG8e3uSSYj7pm3Y9M+oTrNpVIhrYz51PMrytic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6NspxDwAFOijJ+7eoWZqIWoz4Bipcjm8rXSkYB8gOGBrsLLhx
	mLbMYAhZcSBZSX54HEze55ZupgEj+8XLTP5dg9//kbuCKuTXFeGlDnpGX6TJ8Z/dVii9T/DO7vf
	L0EdUFUawUB9ekUmOleZi8zUYQEMMRyYZuvpmXg==
X-Gm-Gg: ASbGncvF/DIqvNuFF8IfcLYCFr7QPJO8bQ8xzBRTpNKEVbyQmrkAYjYw91YBUiQ7CpT
	mTibgywxRVI7Wap9cYn6dD9lT+e46GH3ohDuBuFlXXaY0OSFwUR45/fiC40A07dgJtEFP000=
X-Google-Smtp-Source: AGHT+IHD2PT8XCo0GkqtLL234jnFRgvVYtSjpUavpk/HEf4nJYRV+x9KHQphKZdo5G/F365nQzREBAo8giI6q0eAlLk=
X-Received: by 2002:a5d:6d87:0:b0:38d:d93b:5899 with SMTP id
 ffacd0b85a97d-38dd93b5a82mr6772289f8f.21.1739236958958; Mon, 10 Feb 2025
 17:22:38 -0800 (PST)
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
 <CAEXW_YTduDBJY2CbkStWc3-4MP06+bJVFmEbgvfayB6BQyyksw@mail.gmail.com>
 <76ea9e49-c8d9-4ddf-8dd5-65ba4096e242@paulmck-laptop> <CAEXW_YSxGb3ph-bBiWsOJS-C2XvW9FUuwtoM1eFVxPomMKUd5A@mail.gmail.com>
 <CAEXW_YS4wD1WJm3fGukyf_rUTZoe9Rmbs2rphLntmo2NbYG--A@mail.gmail.com>
In-Reply-To: <CAEXW_YS4wD1WJm3fGukyf_rUTZoe9Rmbs2rphLntmo2NbYG--A@mail.gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Mon, 10 Feb 2025 20:22:24 -0500
X-Gm-Features: AWEUYZlx2_pYxx6W_bl_bT4AWvFxpugMRxKXzQv9V9TuyOoKYfdE39PNfr6ypcA
Message-ID: <CAEXW_YQkpiQeGat1WhUgMgd3qDWSTBnD6ivc-vdhUHK-6yaUAQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start detection
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 7:28=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Mon, Jan 27, 2025 at 1:45=E2=80=AFPM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> >
> > On Mon, Jan 27, 2025 at 11:49=E2=80=AFAM Paul E. McKenney <paulmck@kern=
el.org> wrote:
> > >
> > > On Sun, Jan 26, 2025 at 09:58:11PM -0500, Joel Fernandes wrote:
> > > > On Sun, Jan 26, 2025 at 9:55=E2=80=AFPM Joel Fernandes <joel@joelfe=
rnandes.org> wrote:
> > > > >
> > > > > On Sun, Jan 26, 2025 at 9:03=E2=80=AFPM Paul E. McKenney <paulmck=
@kernel.org> wrote:
> > > > > >
> > > > > > On Sun, Jan 26, 2025 at 08:22:23PM -0500, Joel Fernandes wrote:
> > > > > > > On Sun, Jan 26, 2025 at 8:13=E2=80=AFPM Joel Fernandes <joel@=
joelfernandes.org> wrote:
> > > > > > > >
> > > > > > > > Hi, Paul and Frederic,
> > > > > > > >
> > > > > > > > [...]
> > > > > > > > > > > On Sat, Jan 25, 2025 at 12:03:58AM +0100, Frederic We=
isbecker wrote:
> > > > > > > > > > > > Le Fri, Dec 13, 2024 at 11:49:49AM -0800, Paul E. M=
cKenney a =C3=A9crit :
> > > > > > > > > > > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > > > > > > > > > > index 2f9c9272cd486..d2a91f705a4ab 100644
> > > > > > > > > > > > > --- a/kernel/rcu/rcu.h
> > > > > > > > > > > > > +++ b/kernel/rcu/rcu.h
> > > > > > > > > > > > > @@ -162,7 +162,7 @@ static inline bool rcu_seq_do=
ne_exact(unsigned long *sp, unsigned long s)
> > > > > > > > > > > > >  {
> > > > > > > > > > > > >         unsigned long cur_s =3D READ_ONCE(*sp);
> > > > > > > > > > > > >
> > > > > > > > > > > > > -       return ULONG_CMP_GE(cur_s, s) || ULONG_CM=
P_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 1));
> > > > > > > > > > > > > +       return ULONG_CMP_GE(cur_s, s) || ULONG_CM=
P_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
> > > > > > > > > > > >
> > > > > > > > [...]
> > > > > > > > > > > > The way I understand it is that rcu_state.gp_seq mi=
ght be seen started while
> > > > > > > > > > > > root_rnp->gp_seq is not. So rcu_seq_snap() on the s=
tarted rcu_state.gp_seq
> > > > > > > > > > > > may return maximum 2 full GPs ahead of root_rnp->gp=
_seq. And therefore it takes below
> > > > > > > > > > > > 2 GPs to safely deduce we wrapped around.
> > > > > > > > > > >
> > > > > > > > > > > Exactly!
> > > > > > > > > > >
> > > > > > > > > > > > Should it be ULONG_CMP_LT(cur_s, s - (2 * (RCU_SEQ_=
STATE_MASK + 1))) ?
> > > > > > > > > > >
> > > > > > > > > > > Quite possibly.  I freely admit that I allowed a bit =
of slop because
> > > > > > > > > > > time was of the essence (holidays and all that) and a=
lso it does not
> > > > > > > > > > > hurt much to lose a couple of counts out of a 2^32 cy=
cle, to say nothing
> > > > > > > > > > > of the common-case 2^64 cycle.  It would not hurt to =
be exact, but it
> > > > > > > > > > > would be necessary to convince ourselves that we were=
 not off by one in
> > > > > > > > > > > the wrong direction.
> > > > > > > > > > >
> > > > > > > > > > > I would be happy to see a patch, as long as it was su=
fficiently
> > > > > > > > > > > convincing.
> > > > > > > > > >
> > > > > > > > > > I'm not so much concerned about being exact but rather =
about making
> > > > > > > > > > sure we still understand what we did within one year. W=
e can leave one
> > > > > > > > > > more grace period than what we expect out of paranoia b=
ut, the most
> > > > > > > > > > important is that we comment about what we expect and w=
hy. Let me
> > > > > > > > > > prepare a patch for that.
> > > > > > > > >
> > > > > > > > > Even better!
> > > > > > > >
> > > > > > > > Do we really have users who could pass such a huge delta wr=
apped
> > > > > > > > around value to poll() i.e > ULONG_MAX/2 ?  For 32-bit, tha=
t would be
> > > > > > > > 2 billion count since the get() (500 million GPs on 32-bit?=
). I am
> > > > > > > > curious if such a scenario should be a WARN() because also:=
 If more
> > > > > > > > than ULONG_MAX/2 values are possible after get(), then a fu=
ll or
> > > > > > > > multiple ULONG_MAX wraparound is also possible. This means =
then both
> > > > > > > > rcu_seq_done() and rcu_seq_done_exact() become unreliable a=
nyway for
> > > > > > > > such stale get() values.
> > > > > > > >
> > > > > > > > I do agree with both your points on the side effect of the =
patch to
> > > > > > > > rcu_seq_done_exact(), but I am not fully convinced myself a=
bout
> > > > > > > > utility of rcu_seq_done_exact() versus the rcu_seq_done() b=
ut I could
> > > > > > > > be missing something.
> > > > > > >
> > > > > > > I want to modify my comment on reliability. rcu_seq_done_exac=
t() is
> > > > > > > certainly more "reliable" than rcu_seq_done() for wraparound =
delta  >
> > > > > > > ULONG_MAX/2. Still with such a huge wrap around it is not fai=
l proof
> > > > > > > if it lands within the "3 Grace period" window, so if it is n=
ot super
> > > > > > > reliable and if the user should not rely on it, then I wonder=
 if it is
> > > > > > > better to not do it and instead warn the user they are playin=
g with
> > > > > > > fire. But a counter-argument might be, landing within the 3 G=
P window
> > > > > > > is quite low probability...
> > > > > >
> > > > > > It is also a harmless false negative.  And another poll within =
a few
> > > > > > hundred milliseconds will set things straight.  In contrast, if=
 we
> > > > > > used rcu_seq_done(), it would be a good long time before we got=
 out of
> > > > > > false-negative territory.
> > > > >
> > > > > True!
> > > > >
> > > > > > On a 32-bit system, if there was an expedited grace period ever=
y 10
> > > > > > microseconds (just barely possible on small systems), then a 32=
-bit
> > > > > > counter would wrap in about 12 hours.  So there would be a six-=
hour
> > > > > > false-negative zone.
> > > > > >
> > > > > > So an expedited grace period every 10 microseconds combined wit=
h
> > > > > > a six-hour polling delay is unlikely, but not out of the realm =
of
> > > > > > possibility.
> > > > >
> > > > > Assuming that every 10 microsecond of the entire 6 hours is used =
for
> > > > > an expedited GP, but I agree with your point.
> > > > >
> > > > > > Please feel free to nominate a comment.
> > > > >
> > > > > Ok thanks, I'll see what Frederic comes up with and can take it f=
rom there.
> > > >
> > > > I forgot to ask is the reason for keeping rcu_seq_done_exact() to h=
ave
> > > > more complexity only when needed, or does it make sense to rename
> > > > rcu_seq_done_exact() as rcu_seq_done_done() and get rid of the old
> > > > rcu_seq_done()?
> > >
> > > We might well be able to use the rcu_seq_done_exact() algorithm for
> > > all the uses, but that will require very careful review and testing.
> > > Please keep in mind that there are quite a few uses, that the benefit
> > > is small, and I was lazy.  ;-)
> > >
> > > The difference with the polling APIs is that a user might well
> > > legitimately hang onto a cookie for six hours, for example, by having
> > > used it to tag a data structure in a block cache or similar.
> >
> > Thanks for clarification. I will work on a patch along these lines and
> > see if it is worth doing.
>
> Here I think there is a real issue:
>
> poll_state_synchronize_srcu() uses rcu_seq_done()
>
>     if (cookie !=3D SRCU_GET_STATE_COMPLETED &&
>         !rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, cookie))
>         return false;
>
> where as poll_state_synchronize_rcu() uses rcu_seq_done_exact()
>
> bool poll_state_synchronize_rcu(unsigned long oldstate)
> {
>     if (oldstate =3D=3D RCU_GET_STATE_COMPLETED ||
>         rcu_seq_done_exact(&rcu_state.gp_seq_polled, oldstate)) {
>
> I believe rcu_seq_done_exact() makes more sense for polling API, as
> there is a higher chance that there is a significant delay between the
> get_state..() and poll_state..() calls.
>
> I think I am pretty convinced now looking at all the call sites that
> rcu_seq_done_exact() should be used everywhere. I am vetting more
> callsites, but that's what I'm leaning towards. I think
> rcu_seq_done_exact() makes the code more robust to false-negatives
> (duration during which a false-negative is in effect)...
>

I was wondering if this can go wonky a little bit (not bug, just
optimization issue):

__note_gp_changes() sees rdp->gpwrap is set.

rnp->gp_seq had overflown and so now < rdp->gp_seq when the
rcu_advance_cbs() is called.

rcu_advance_cbs() uses the rnp->gp_seq to do the advancing.

All the CBs that could be advanced don't move because their gp_seq is
> rnp->gp_seq due to the overflow.

It is probably a slight delay in CB execution and not that big a deal.
I am not saying this is an issue but something I observed when reading
code.

I also got to go audit rcu_seq_completed_gp() to see the implications
of the ULONG_CMP_LT in it...

 - Joel
