Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB852288EB
	for <rcu@vger.kernel.org>; Wed,  5 Feb 2025 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742730; cv=none; b=lZrKw8jEGPMFdMKQRfbd2N+WPDmhxBNBuDCfkOREOc3qlPtCG1WEPFmGm/dNFvHQ3yO0OojEUBWQtfYEcNHkQ+Yerj3gicdNu7aNx2jI0G/rQ80kXLred/1+0zrnlIEU778p7INui7YceSh56pANxJEUgXGFaBwA4rWcWapuN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742730; c=relaxed/simple;
	bh=8zo9UiMtaw4DKOqW5Dg6bGLEtAHpv/+avVSiD07aQjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpyqvZn3e1ULdSQv9BV8ZchYnGTYGU0gYVxndKPOxqgMgwmMF5TvYmKRvq3noJc051AtIxBc9YbNc3IqMzGfDv/SSs05JfU1zEkFMyu7PqfEc4qaHyFZZfnbeggklmKCpn+CrfRSPhA39n5y+gVcxxEI9gIRWd5jzSbJ6rkJVRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+QQcrPt; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+QQcrPt"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab737e5674bso460236066b.1
        for <rcu@vger.kernel.org>; Wed, 05 Feb 2025 00:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738742727; x=1739347527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zo9UiMtaw4DKOqW5Dg6bGLEtAHpv/+avVSiD07aQjw=;
        b=3+QQcrPt66sIHWnT1CXj4NDEI0D4E2x1tXinpi0tn3RezigHMbnW5qZaeRnHCRiz2k
         w+fdGs9xMfgbR7Gox2B+K4ok2SKjnoJ1gh5fh/zCb97TfnbWCsZK/wnPVlEO1KWh6Wjf
         Ss4JtzqR2D1ma+/NM+F2Tru8vhyw29jKXkbAzNsx5tdm14p+ttYyuxfw4Yb9z96Xp7Qd
         xxbn7qCry1RYpvNrXe0gAw6Rkg4xC5PX1v8fgbHUhhTmwFpsgU/gMR1yUMNhEXuiSwjt
         8eawd3B5QP6qWT8rN5G37WJNLRVyyVS2C+pOhrR31Pzsvq0r+JHbDYiD236C80ZbxVtJ
         Cueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738742727; x=1739347527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zo9UiMtaw4DKOqW5Dg6bGLEtAHpv/+avVSiD07aQjw=;
        b=tVW2gkgUtXxb1WSs67o+nnC0PM8iCzRumZkoJCUAerEgFrCu16aZochhvFzz9zxOoI
         Oy8MzrBcF7XGoV/rfT81TDaaqkom0kk6xd9/e+O7uIiuFlGGLGJfot90jwpXvOIrhD03
         l7vNmSX6VmNTD8ZR5E144BQQ1cJhi2W5WzaDsO6JHpzWWj+f/SiPY8fWasqmmX1UgnI1
         gquIhfr3ndvM1QmQQ5YbJ2g6JBF/UVXN50L7lNXOUou/PHJjZVu799ANhQfFzQkGAIXC
         cpJDfhvbpfB3IYvbzoWrqw5laRK9+FHQzBhP2lXQ3KzrWo2jCVYDmYfDfkod2oHdFSyY
         X9eg==
X-Forwarded-Encrypted: i=1; AJvYcCXhhBpNJ5zMa0d9JoILqKSPjXkNG/26UtcS32MO49yl9rhhmIxCyXkaFPx8AHw6+4Gzfqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwknfQhgFY903J3aERJgVEhKL80U07W+QHi4DtCRemdOrsociNW
	TbR3R4ETCJD7zjdy7j+0lI5A3N0+APu2Xi6ntEN6yTRG1Z+gkFsQEMYeTnhCu6p+RbbH2sCIfMh
	s70R43E+ayjd7Fzhc7GMwn6J0g+N97ZAsrOI+
X-Gm-Gg: ASbGncsR415waDfuGswz63h+hFgjuQbQEGFcFRtTT6ekqL/g5vAFdDyD93eQSzb1us9
	hfpAgAa6dMr2N53A0oj8T4ARvxL7/UfRuW637tRzsReRAF77SK/3Qtl6AkaK5Xr13N8LBCRI=
X-Google-Smtp-Source: AGHT+IF/tPS7g8m5Lh0zFFpr42ZF/S4x6y7PIzl/K9hhNU1ZEDrtn3AORwaNSpJDgTzJEEaedLRVmDbrij+UTFPyEqU=
X-Received: by 2002:a17:907:9414:b0:ab2:c0b9:68d with SMTP id
 a640c23a62f3a-ab75e2141f5mr166034666b.1.1738742726840; Wed, 05 Feb 2025
 00:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com> <20250204132357.102354-12-edumazet@google.com>
 <20250204120903.6c616fc8@kernel.org> <CANn89i+2TrrYYXr7RFX2ZwtYfUwWQS6Qg9GNL6FGt8cdWR1dhQ@mail.gmail.com>
 <20250204130025.33682a8d@kernel.org> <CANn89iJf0K39xMpzmdWd4r_u+3xFA3B6Ep3raTBms6Z8S76Zyg@mail.gmail.com>
 <39a1fde2-63f7-4092-870f-ae20156fbb9e@paulmck-laptop> <20250204133025.78c466ec@kernel.org>
 <CANn89i+AozhFhZNK0Y4e_EqXV1=yKjGuvf43Wa6JJKWMOixWQQ@mail.gmail.com>
In-Reply-To: <CANn89i+AozhFhZNK0Y4e_EqXV1=yKjGuvf43Wa6JJKWMOixWQQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Feb 2025 09:05:15 +0100
X-Gm-Features: AWEUYZn2wyo84Ggd9HyZWG5UC81qSqlrX9lj52VMiPkHivRXYrW2OJfDm4-DPgc
Message-ID: <CANn89iKN_HRA5kO_hGghpL8Ly2qFTwjaDz1AQDZkmus28uoadw@mail.gmail.com>
Subject: Re: [PATCH v3 net 11/16] ipv6: input: convert to dev_net_rcu()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:57=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>

>
> I will squash this diff to the following iteration, and keep rcu_derefere=
nce()
>
>

I will shrink the series in V4 to only include known bug fixes, to
lower the risk of having 10 more iterations.
