Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F934A28
	for <rcu@vger.kernel.org>; Mon, 27 Jan 2025 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737940444; cv=none; b=Qbwc0M+EU6WtX06+jXsnc73HSHuFjwmhVNUsuM785OLv50TXpLPeSc3Iz60nhCvP5PlmgmoVHNlyZ2dr5v+BAMbcxOQGKAQtdaRldtpcQwjzdYvSJ9FH5c9bVuw6grjDeShL2XEefdipX50cCDBUrYWtW8df5+SsvssZFNpp04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737940444; c=relaxed/simple;
	bh=zy/IjBozhUcS9iQw4kmOh13QQR3okPoV9fIHfAFK77Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GW02SdabMMBvgcAN5q08YaBQ1G4h6yEGBsPcdc6tAOJ3NiCsqnoWA5qXqLY3R/dK/DLUr00LFEAoIFlCYUH5LfE/x7ygQ6EvCI8TZ0ljK5aX/3NDSoIyplzmw55Xndkm0vycoM3ju5wfgvWySaTSgG2NskEtJelKD3v0a8xap1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=czK4nR/j; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="czK4nR/j"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385de9f789cso3132187f8f.2
        for <rcu@vger.kernel.org>; Sun, 26 Jan 2025 17:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737940441; x=1738545241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwH49lGi6sdBBF4DwAbi8Q3hFJ7Q7ohm/Zt/I/oDUVo=;
        b=czK4nR/jR4tpuHPaswTQLv4Yvkqxw2MyaZg5jvyvzKxvLdEBc07P/KAV0OumgN2rwc
         negXS1jiSEhnR/YhLRM3Unzp/1YQi8XJ1CYCMm4DEOopltkrR9nWz7k5GFIXD9RWS7FG
         0HteOOl2wDzeF4Rw3Dwb+6UwLALJCl41iei0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737940441; x=1738545241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwH49lGi6sdBBF4DwAbi8Q3hFJ7Q7ohm/Zt/I/oDUVo=;
        b=NzLgAlW4DJaofX0KU8KeKHMjsIUehUDYGMsXfcYa1V98VbWsNDAoHpUxH+zo6U4fHW
         03D6Hbo+zahKm4TAnfE2vHhNtx4FpfsIbblnNFKa2oqdiaMEUZpZJiE8oA5fY+N5adl8
         tzHIV08I3Bm4j2WjS1jSHfqe1xyOYWmSIc7jOqs6uflyUAQ5ybSfuKcuTL/qwDYwpg+p
         WZVS+yV7kmRZrXQq338jtb2oNuZlc2C3a+ofNkRZ7LCjcpGFJAP0e82V4pcPDAC1ISi5
         34jWDYXjYpL80GPLU9NWC7wKbzVVL2tHycYwXQPDqLFYJxFYJlTbqz5yuxJjdygmSuFV
         3dMw==
X-Forwarded-Encrypted: i=1; AJvYcCWHMM7kc3pupsjPmJ2afr4tvUtbvXPRXyYYIAQHpO5urEhQQ3nQrCyk/QJ9w6I2tQAnuQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWI1FzgXh+iJj3ufrCfCvhnriCZvZvp6CVsalJfU9+ffcc6ZPg
	EeKCD28iJcG7aaplslUTwWys7Yk36AQ8b9+MhbB33MEded+0YF7uGfJI/gY9ksS+sI5Pv7Iw0lu
	xMkh7s1BMY/YhAtWkxN64FCPPEvkFUkAOPlP/bg==
X-Gm-Gg: ASbGnctYIez/CX8jZPMAkMRcr2H3L+4Eh6pTH7XCoFTejLrSFwycoz1q2HqiEreaQp9
	X/5U43ee92MMh5nnlNt6u8QJj2FX1TR5BaJ5nAq63imH85w7F5yyuhEZiFEEHVrI=
X-Google-Smtp-Source: AGHT+IG4PerU75MXTMQzfCfDi2+xpR7wYy5GniqzTtK+pzvxYDv5CEf3tkq92lYtnB6+ZUSSUkliGsw5m/+MR2jkfdw=
X-Received: by 2002:a5d:6d0c:0:b0:385:dffb:4d56 with SMTP id
 ffacd0b85a97d-38bf57d3004mr31895103f8f.53.1737940440861; Sun, 26 Jan 2025
 17:14:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
 <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop> <Z5QcXoE0lrS6yIBt@pavilion.home>
 <d7bbe2cd-d889-40e9-8d46-fb8772fed6db@paulmck-laptop> <Z5T7kF7LKIuk05FR@pavilion.home>
 <a18ec931-a7cb-408b-8707-f88068a13ba9@paulmck-laptop>
In-Reply-To: <a18ec931-a7cb-408b-8707-f88068a13ba9@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Sun, 26 Jan 2025 20:13:47 -0500
X-Gm-Features: AWEUYZkl6zP1RdoMJ8hIPwIoLJb4luohapv_yTjTSp0XVEb8euz1uPp8xhkna-w
Message-ID: <CAEXW_YReLoj+fofM9=fT-G0rz-E0z7vcwg_ANrbfCrPOX99tYA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start detection
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Paul and Frederic,

[...]
> > > On Sat, Jan 25, 2025 at 12:03:58AM +0100, Frederic Weisbecker wrote:
> > > > Le Fri, Dec 13, 2024 at 11:49:49AM -0800, Paul E. McKenney a =C3=A9=
crit :
> > > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > > index 2f9c9272cd486..d2a91f705a4ab 100644
> > > > > --- a/kernel/rcu/rcu.h
> > > > > +++ b/kernel/rcu/rcu.h
> > > > > @@ -162,7 +162,7 @@ static inline bool rcu_seq_done_exact(unsigne=
d long *sp, unsigned long s)
> > > > >  {
> > > > >         unsigned long cur_s =3D READ_ONCE(*sp);
> > > > >
> > > > > -       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - =
(2 * RCU_SEQ_STATE_MASK + 1));
> > > > > +       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - =
(3 * RCU_SEQ_STATE_MASK + 1));
> > > >
[...]
> > > > The way I understand it is that rcu_state.gp_seq might be seen star=
ted while
> > > > root_rnp->gp_seq is not. So rcu_seq_snap() on the started rcu_state=
.gp_seq
> > > > may return maximum 2 full GPs ahead of root_rnp->gp_seq. And theref=
ore it takes below
> > > > 2 GPs to safely deduce we wrapped around.
> > >
> > > Exactly!
> > >
> > > > Should it be ULONG_CMP_LT(cur_s, s - (2 * (RCU_SEQ_STATE_MASK + 1))=
) ?
> > >
> > > Quite possibly.  I freely admit that I allowed a bit of slop because
> > > time was of the essence (holidays and all that) and also it does not
> > > hurt much to lose a couple of counts out of a 2^32 cycle, to say noth=
ing
> > > of the common-case 2^64 cycle.  It would not hurt to be exact, but it
> > > would be necessary to convince ourselves that we were not off by one =
in
> > > the wrong direction.
> > >
> > > I would be happy to see a patch, as long as it was sufficiently
> > > convincing.
> >
> > I'm not so much concerned about being exact but rather about making
> > sure we still understand what we did within one year. We can leave one
> > more grace period than what we expect out of paranoia but, the most
> > important is that we comment about what we expect and why. Let me
> > prepare a patch for that.
>
> Even better!

Do we really have users who could pass such a huge delta wrapped
around value to poll() i.e > ULONG_MAX/2 ?  For 32-bit, that would be
2 billion count since the get() (500 million GPs on 32-bit?). I am
curious if such a scenario should be a WARN() because also: If more
than ULONG_MAX/2 values are possible after get(), then a full or
multiple ULONG_MAX wraparound is also possible. This means then both
rcu_seq_done() and rcu_seq_done_exact() become unreliable anyway for
such stale get() values.

I do agree with both your points on the side effect of the patch to
rcu_seq_done_exact(), but I am not fully convinced myself about
utility of rcu_seq_done_exact() versus the rcu_seq_done() but I could
be missing something.

Otherwise I analyzed the patch and it makes sense to me:

Reviewed-by:Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
