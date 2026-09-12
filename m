Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B9C47ACE9
	for <rcu@vger.kernel.org>; Sat, 12 Sep 2026 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789216882; cv=pass; b=LAob7s+/8L01dleW6TsK9h0U72ywrqyVEAo0SzSbze0AdNpaaBO9kBU7A27psyvnxvrByk8mRFQgSREEPYgJr0QztV+gyluH5vrhgd3YXi71iKMuGsGBLJzTPmz0i0QDaa8H9CHv7wrErBiaP8wt/qkDZhEiOBjte8fisPYUbqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789216882; c=relaxed/simple;
	bh=ljQce7QZbvSQsSjeQRo2qnnTep+8IGO0siKl5j67fFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJId1x9aZLEHoKW8qHkO5Ujl48vouT1/4QRcgNdizHUHCmb4jNmug7GLSzQTHW9eJ3OS+DXwf31SJS84OuVjx/r6+a98elaahbSyyF/up/8tJ/MPmxImF/2VStsb/J5O2p3YCzkpiBzu2B5AHpa1mRfeeyLyWHHSEK/YB5Q11tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOoIKsJ+; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOoIKsJ+"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-485850cbac3so899775f8f.3
        for <rcu@vger.kernel.org>; Sat, 12 Sep 2026 05:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789216879; cv=none;
        d=google.com; s=arc-20260327;
        b=X1fbjnkI/VQ8HGZT35fqW8BQ554KbQ8uvSKfzFw6n+EnFfNyrGme4a50BMqB5C7aMe
         jCgqaryaNu6Ce0NuEp5bpvS+kd+De+7Sre8aNcLoZbJtcZiPimvKzCAnUaL9ZTHBSaVO
         lrq+fyg3MArZO8QJn+PqqENNLWfaGSeWB7q+WlX0v4Cg9wbU3rJags5IsOuByo8VX/z1
         oT4P4UP5czv5MqBnTA4KfTIdkTWaLuTulmdNTqfmHNKqa5LYQRpShMjODp5X1l64nmZg
         tHdv9awZOj1vTrJMuXvx6nRNybEkvwKNJBH9POLPuNYTa6/87xHl1mP95yAOq1uEuzeV
         vLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eMkrmsdzvhlrfqjThqc4QsEj+XaqWtVZO9BiCBmcgwc=;
        fh=jeM5wlbnVXSGSAM2mr1kJTaacYC50p1BKNBWBV0AAEM=;
        b=nNmJLha/7aNEfRoLQsJ2/S8VhYfl7Y/D0gLF/738n7UljRC0vBF1/k0LynCSBVx5hL
         uNdiD0VqnPCi8Ysx7oW0ery+8w1efHPsZFgR2Z9d5s9pjjFdGe0Ezv/6L6yoWIMscqZN
         IxmcljRb935ZrtZVltuAciv/DfnoK8qChBjzuHQauh8pgo5tmVNdyIQG+ZO4PBDEFznb
         E8AiTThHVS1gZfnLXRecpEWsA6Q7s2n7/QzUXUFOsBXWhm7XV0NmZG7CA7XiKYTHAXMI
         Vso0X5HMpQsVn5kAT1ybucya8bSueP/TfmQam3cfXZHuU8cTnVG9uoSxhzThioE09BZE
         ZicA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789216879; x=1789821679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eMkrmsdzvhlrfqjThqc4QsEj+XaqWtVZO9BiCBmcgwc=;
        b=IOoIKsJ+x7VaK8tzdnhgtcVouGypOQzV927qTMDECkFvJvgKhRnHz8eAtXOEixHSaz
         eWc1e35nENKnItsuLIMFLlG68FoD94gUMaTKv0RBCTHyyUruawAvaV7rStK0OoMtMaj5
         fDJncKIOVN0HvxFVvHkH6z07i/lGE38hXk0eMoPzew7xkCElVHQkfw7fNJXGpFhV8JFd
         MVPSBAc9nGOgvpP4+Oex+8V9SnQoJe8Jyxq3Hc2T06Se4bFzbXfOXol13SY/aA/MQ2K4
         leTBon8aErsvCOuL+EpuM4bT1zxt9NLGzlj0RTx6rkmJeWLUe7qoPY+i24NlzlNfWhf6
         Xe3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789216879; x=1789821679;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eMkrmsdzvhlrfqjThqc4QsEj+XaqWtVZO9BiCBmcgwc=;
        b=Xr+25pRwY42FfEpMXRD/+ofwDCNKtclbrgnHZXkaX3sRCh7WgYqrcxi5LCqJLx5NoS
         w7JkfYdPn2VlxHb/DSKQfJn4tJqCshd5VZQgWWpyrAyZxuC4iFPujOhMGsU+8a+Z+owT
         vRrD7FPq0xEuelQsTWwThMCf0df9zBlZkYLyXwbAoWOTxP+zLSyRmU4uV336z+vURn+h
         fZndWwmdZNL1kCIqUPqBr6tMP0nc08839ykB3yImvNyEswMN0TQ/MZ5H7UNUUBaw4Cel
         TUfmcx4osDw0nfpZsF6jqWZu3I4XUF5zKpQvu7+13xXZ9UT4qG5BnGCscqUt06RYpvSl
         o2+Q==
X-Forwarded-Encrypted: i=1; AKwUvByGVLj0G9sWvWL0nhbgLsVBxNIxHl85YxYvNRqw1aS1hSnxUZnYTv2xxwIlByxP00NXxTg=@vger.kernel.org
X-Gm-Message-State: AFuF++mQXdsU8qGRt4d/DqXLF3UXzE8Hf8a9d0Q54lnaWeElBmUCJraH
	a0vFj/0dGOfFPRCDV1eEjk2B1xambr1TK8rasWnqZfcmcEXIDUz/4/ijR+WRPmylnZ400HxEJsO
	biDfUD+mRla7PdlodynGAigk2rFz4I1w=
X-Gm-Gg: AYBFou2WTRyByiaKcP5x3Iu0da798s0l58m3o5qMsON/JAu3YO38Bc4KJStfStV8cIF
	E+ETx1tGOBPnroks7yTPyaHVyJcL7c0brglxQXZ4BgHnCsQomCpBdOna8/kEaZGZrtO3UwbWAwi
	+d/9vFdciREhGJMVVK0ziIh6By6gK90RrrhfXm373Rti7dRWl4GfCa6z/NkhqxEG/dD+jcw6PP4
	0i5Kjvfh0UNXhf8qfaf9AD3IYW4Utddge74rB6cEHDzTBYU5CA56/oBh0TsP0tQiyiLLQ4CgSX4
	0u6p2Hauafy3r67KCNaSo/ZoOqLuGralCun8iSjcTryh1X8DcliUy9iYbEq+d/ayphh+TODKKsx
	yc5WG4TyWhbfMYg==
X-Received: by 2002:a05:600c:4455:b0:49d:174e:2a1e with SMTP id
 5b1f17b1804b1-49e619c00a8mr98934575e9.19.1789216878599; Sat, 12 Sep 2026
 05:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911072125.2268530-1-kunwu.chan@gmail.com> <71507136-1439-4ee0-b176-e45ed3f60429@paulmck-laptop>
In-Reply-To: <71507136-1439-4ee0-b176-e45ed3f60429@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Sat, 12 Sep 2026 20:41:07 +0800
X-Gm-Features: AcwNN1V7di3Qqso44IU6NZjZqKJSd5euIhD-AGL6x4f6Gkeg8fSwXoYBrEqOkMA
Message-ID: <CAN_Opa9H_XoQUgS5wX=5RUhavt4Ueqkw-4UFwt8-qjALPwAwfw@mail.gmail.com>
Subject: Re: [PATCH v3] srcutree: Don't transition atomic SRCU to big in srcu_gp_end()
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 12:37=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Fri, Sep 11, 2026 at 03:21:25PM +0800, Kunwu Chan wrote:
> > Atomic SRCU must remain in the small size state. Warn if this
> > invariant is violated and avoid transitioning to big in that case.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> Very good, queued for further testing and review, thank you!
>
> I folded the new "if" statement onto one line because some years back the
> Linux kernel liberated itself from the 80-column constraint imposed by IB=
M
> back in 1928.  We can now have up to 100 characters in a line of code.  ;=
-)

Thanks, Paul. And thanks for sharing that interesting bit of kernel
history! I didn't know about the IBM 80-column constraint from 1928.
I had assumed that 80 columns was still the current convention, so
it's good to know we can use up to 100 now. ;-)

Thanks,
Kunwu

>
>                                                         Thanx, Paul
>
> > ---
> > Changes since v2:
> > - Also prevent the transition when the atomic SRCU size-state
> >   invariant is violated, per Paul McKenney's suggestion.
> > -v2: https://lore.kernel.org/rcu/20260910084629.3695383-1-kunwu.chan@gm=
ail.com/
> >
> > Changes since v1:
> > - Drop the !is_atomic guard from v1 and add WARN_ON_ONCE() instead,
> >   per Paul McKenney's suggestion.
> > - v1: https://lore.kernel.org/rcu/20260907075829.2073224-8-kunwu.chan@l=
inux.dev/
> > ---
> >  kernel/rcu/srcutree.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 84c022ec8e09..07db4e459b30 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1073,8 +1073,11 @@ static void srcu_gp_end(struct srcu_struct *ssp,=
 bool is_atomic)
> >               raw_spin_unlock_irq_rcu_node(sup);
> >       }
> >
> > -     /* Transition to big if needed. */
> > -     if (ss_state !=3D SRCU_SIZE_SMALL && ss_state !=3D SRCU_SIZE_BIG)=
 {
> > +     /* Transition to big if needed, but never for atomic SRCU. */
> > +     if (ssp->srcu_reader_flavor =3D=3D SRCU_READ_FLAVOR_ATOMIC &&
> > +         ss_state !=3D SRCU_SIZE_SMALL) {
> > +             WARN_ON_ONCE(1);
> > +     } else if (ss_state !=3D SRCU_SIZE_SMALL && ss_state !=3D SRCU_SI=
ZE_BIG) {
> >               if (ss_state =3D=3D SRCU_SIZE_ALLOC)
> >                       init_srcu_struct_nodes(ssp, GFP_KERNEL);
> >               else
> > --
> > 2.43.0
> >
> >
