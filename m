Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1CC3FFD
	for <rcu@vger.kernel.org>; Mon, 27 Jan 2025 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737940958; cv=none; b=GXK4PebGg1f4Nl8LObaftDgcpxX/A4xQGQqgzooQ1FJ+46D/RFN0+kaCvNwYPbYG3sGViZXlsGcLNzAizEMdKQCVT9jIdmLmFvgMRUDF8AE6DhV8KwSPXZS/0hpmQqehXs1VlISJhhihmGkVB7IAVdKl2t0XMBGwJdw2qHS1YBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737940958; c=relaxed/simple;
	bh=l9x9ywmqE/4RUldAoF9QnY5OUNsWcOvweQXZlkiRcN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tl7IJfx1SDqg3EWFIIv44p2Hme90Q+Wiv6rJdOqsio16DNTX758pAoP1aNmP6/4r45+jDGDrsIc1ffU3teCSCWoq3ZbptQr/3/0iax/uU6ksMAih6z63poE00Ezh+d5cOAAOYyTLvxEFIJHK+fl//TeVnPDgLLldLaM/WzQU7HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=OwEg/6Nw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OwEg/6Nw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361f796586so42082545e9.3
        for <rcu@vger.kernel.org>; Sun, 26 Jan 2025 17:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737940954; x=1738545754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OL/tfQ68r+bTmzvnwrB9fBO4KS9HjhmhhKSnRrpZ/RQ=;
        b=OwEg/6NwkTd+LY5ciyYgT7ViAVbvFU6766CDH2u96BixDNBK6z9WL6U5Vt8xYlkH/b
         umAekmBMkZd6p/exVxrivzmxbhIsScsBTzjqLMjxECA1sFGYYY9Oo9z6hGfMr8ZKLtIm
         Y14+sVDFehs1D/r8fbOeSXD0lo3xW8pzu8WvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737940954; x=1738545754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OL/tfQ68r+bTmzvnwrB9fBO4KS9HjhmhhKSnRrpZ/RQ=;
        b=ROqtNyZKdVqa8untaRMrOegY6Fr8YuTCZpGxNnXdveaVbI8OTNnmEnza94yB2z+uuy
         D+E8GvwTb+34Tkd2morr7EsDmN2X5t2Vat3srKXD6qbg7TX2Wt9Bcq8i8Ln/S8+wV77g
         CP4QgipxPJVMf8rNMb1hbgHvAaOnnRlHiz4E0WCaSjH++BJMmvYKb6hx3RN6og2i1ePw
         7Ydk/CYFA915deudXML1kfIILlN1jQZXqzQVVeU6fUHLoiDXyXJYLvXoDtf9Uqa+tC0/
         pg4N7kdcnHT7C6VPVZ3Kn4c/MLWDO5D7R2c4k5BgCKmhQJY/A3L5n+UBZrNzMTpBZxJl
         U3qw==
X-Forwarded-Encrypted: i=1; AJvYcCX8NTh289TmFdVIYXtNTgzonbOdHXVX/LfEBL0b/7HWuvfbha/R7uLUnTeUctDpdH7LhGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/Gdqs+xHrfYwNUVBsX0FwX3poDbS9egNoptbGLNIFQGW/ihT
	Q9gDltvFygnff4zASQ+6SBTtLj/5gYgPzAuUDi8rvdKr/aQPFpypjkeMDmFY+9sCcKOiIj9rRd3
	LpEkZXmZMhZGhipCvueaFjPxU6HrKnnI7o6kqnA==
X-Gm-Gg: ASbGnctqZzngv4zSy9QhuFHkz8oR4wP/h+/tOoCnC1H6/nGJvmwmoXQD98n7CY+BS9P
	zJA9y5YjoJHCaqayrMqznQA4tpdlHKXZAeIpkP4JitOX7DwPSC2iOpgswXEr4vqE=
X-Google-Smtp-Source: AGHT+IE8Gn7ZPrDOnRUbx9mt7Tu4Auvsg/exFQvZngzJnKYEAiiz+LQavW9grQAHjJuHhOL/10kPbkWzMM82f9t3L+U=
X-Received: by 2002:a5d:6d86:0:b0:385:fc00:f5e1 with SMTP id
 ffacd0b85a97d-38bf5649261mr35544331f8f.9.1737940954044; Sun, 26 Jan 2025
 17:22:34 -0800 (PST)
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
In-Reply-To: <CAEXW_YReLoj+fofM9=fT-G0rz-E0z7vcwg_ANrbfCrPOX99tYA@mail.gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Sun, 26 Jan 2025 20:22:23 -0500
X-Gm-Features: AWEUYZkcR8ngadOsHeH3KU8NmrIpBx6F7IdJF6CIvG7pspzw_iNKxLwmOJoWyPM
Message-ID: <CAEXW_YQaC+TYnXZca2MBcJQgf2EWD+pBp-Dih+b647RtpJ+LNQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start detection
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 8:13=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Hi, Paul and Frederic,
>
> [...]
> > > > On Sat, Jan 25, 2025 at 12:03:58AM +0100, Frederic Weisbecker wrote=
:
> > > > > Le Fri, Dec 13, 2024 at 11:49:49AM -0800, Paul E. McKenney a =C3=
=A9crit :
> > > > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > > > index 2f9c9272cd486..d2a91f705a4ab 100644
> > > > > > --- a/kernel/rcu/rcu.h
> > > > > > +++ b/kernel/rcu/rcu.h
> > > > > > @@ -162,7 +162,7 @@ static inline bool rcu_seq_done_exact(unsig=
ned long *sp, unsigned long s)
> > > > > >  {
> > > > > >         unsigned long cur_s =3D READ_ONCE(*sp);
> > > > > >
> > > > > > -       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s =
- (2 * RCU_SEQ_STATE_MASK + 1));
> > > > > > +       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s =
- (3 * RCU_SEQ_STATE_MASK + 1));
> > > > >
> [...]
> > > > > The way I understand it is that rcu_state.gp_seq might be seen st=
arted while
> > > > > root_rnp->gp_seq is not. So rcu_seq_snap() on the started rcu_sta=
te.gp_seq
> > > > > may return maximum 2 full GPs ahead of root_rnp->gp_seq. And ther=
efore it takes below
> > > > > 2 GPs to safely deduce we wrapped around.
> > > >
> > > > Exactly!
> > > >
> > > > > Should it be ULONG_CMP_LT(cur_s, s - (2 * (RCU_SEQ_STATE_MASK + 1=
))) ?
> > > >
> > > > Quite possibly.  I freely admit that I allowed a bit of slop becaus=
e
> > > > time was of the essence (holidays and all that) and also it does no=
t
> > > > hurt much to lose a couple of counts out of a 2^32 cycle, to say no=
thing
> > > > of the common-case 2^64 cycle.  It would not hurt to be exact, but =
it
> > > > would be necessary to convince ourselves that we were not off by on=
e in
> > > > the wrong direction.
> > > >
> > > > I would be happy to see a patch, as long as it was sufficiently
> > > > convincing.
> > >
> > > I'm not so much concerned about being exact but rather about making
> > > sure we still understand what we did within one year. We can leave on=
e
> > > more grace period than what we expect out of paranoia but, the most
> > > important is that we comment about what we expect and why. Let me
> > > prepare a patch for that.
> >
> > Even better!
>
> Do we really have users who could pass such a huge delta wrapped
> around value to poll() i.e > ULONG_MAX/2 ?  For 32-bit, that would be
> 2 billion count since the get() (500 million GPs on 32-bit?). I am
> curious if such a scenario should be a WARN() because also: If more
> than ULONG_MAX/2 values are possible after get(), then a full or
> multiple ULONG_MAX wraparound is also possible. This means then both
> rcu_seq_done() and rcu_seq_done_exact() become unreliable anyway for
> such stale get() values.
>
> I do agree with both your points on the side effect of the patch to
> rcu_seq_done_exact(), but I am not fully convinced myself about
> utility of rcu_seq_done_exact() versus the rcu_seq_done() but I could
> be missing something.

I want to modify my comment on reliability. rcu_seq_done_exact() is
certainly more "reliable" than rcu_seq_done() for wraparound delta  >
ULONG_MAX/2. Still with such a huge wrap around it is not fail proof
if it lands within the "3 Grace period" window, so if it is not super
reliable and if the user should not rely on it, then I wonder if it is
better to not do it and instead warn the user they are playing with
fire. But a counter-argument might be, landing within the 3 GP window
is quite low probability...

thanks,

 - Joel



>
> Otherwise I analyzed the patch and it makes sense to me:
>
> Reviewed-by:Joel Fernandes (Google) <joel@joelfernandes.org>
>
> thanks,
>
>  - Joel
