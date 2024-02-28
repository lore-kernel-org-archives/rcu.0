Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC915CD67
	for <rcu@vger.kernel.org>; Wed, 28 Feb 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135847; cv=none; b=T4vUf1xi2zTRgr8sEOaU+5YEMnJ3zQSS4X1G0w/WWf3r1EEWMZgzqfuv41hXdvJPKw4UkG1EBxfQRgoC18k3ctf/9LCU/hJ5mgkn3sFkkavd61YBlU9MEj8ma+HU6bXZ2nFO/UNEyAL51x+LYLLQ4BcwBTcA+/pmbGtJ7pAamQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135847; c=relaxed/simple;
	bh=TntFyzEBDmvjeG6lgJOTxzaH04I3ce53rz5JasdYp70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gr5lj1bEFGMbihZpqR0FyOtJAbjeTq+4S93jRbxdWx3MMpg+jQvCza4XFJcCtJ3zgMzDFt1CpUrLYGuN5T6f75dJaOCsXS5uXNLrQmovRhoG5sRZqeATMbqY2zwMKFGYsYmGjTHhnq4OWAycdh39MLK/PXxSfNGgST+k4c6bJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bUuqaAYC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bUuqaAYC"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso7160092a12.2
        for <rcu@vger.kernel.org>; Wed, 28 Feb 2024 07:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709135844; x=1709740644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWTMXfWT3+HIW/VeHNOCaZnDk8xJkuA4vn6TyWTnAFY=;
        b=bUuqaAYCb/0yKZJkefXnqNBOBM4/t4KlwX9depAjKf+mTQEGguayD1CbxeuGG7tiAs
         GI3dGts8ddNwkY2k1zOMTpqrZy2wzs8SgjXF73apVmzTsEh3+HwYvSR/XDlgjfoz8MTa
         Ui6M4P3aSqrdt5TJEUutPk5ZAtgOOFAvLxPJVCf3NaLV42uxv9g7q/FPGeGwJwDTsRkK
         cG5mZs5mkJCf9HT8f7Sm5Q1LYcvfoBiKIJvHiaVRwMhnRxyT/ZSatdW9Ew2+kpOvisbb
         mPLcEASNgoWEniApjgckDAzgxD3seZRp4otEcaGgo/zYeV1Xk32Mw5+ov9V5tgxpDCOj
         wRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709135844; x=1709740644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWTMXfWT3+HIW/VeHNOCaZnDk8xJkuA4vn6TyWTnAFY=;
        b=CJ9lWIXviha/zhrGQ9SkD4o/mo2tmdPSeXyhdflT4fvbBB6zTIzDlJowq+dsR2+TS6
         W16MdTDwuIfgl8IZBIJD+2Kc7z8sBIfN0Ca4gRCKbAVBNJOv1aHqUB9b49NBFUernjI1
         41QeIpGPYEh01qX947bBmZ4RJQf8AKR/EchZJRIHTKVv8k85A9b1mOE5C5d7FdIf2ubU
         SoJIPKDsILsF6u4elL2yll+vl73Y7c64ObxABfNOycrTggHWKO2XhBOJ9p+v2TC4dz0Q
         1yQMtxxeN+exVCW/FZ6Q2Z04HLaaLy1CfYosjKkAymH4ZDuR9Mp02im6+3Tyevmr39BD
         u1uA==
X-Forwarded-Encrypted: i=1; AJvYcCWFghTF1xlWsczP9Kt+hN32S+WDC6Bsw6L0YnM5e6a2X8/p6B+NOHpspfIbOTvQAVpeYvpLaUtaYfvlMQZ1X7SVGt8R
X-Gm-Message-State: AOJu0YxcazMEHtbtutwIxleY4FalIlpfq19AsuJidBRfzkkthUm1W08t
	hYI1cxev4Fo1qSw210wOXmcd4iXfx2WjMWeLxFWn/htcJfw6kzbpXBTmfgeRqp5OTj287lztWiH
	Lruxk/FomxHyHmQJBMzauQ1eW4/MwtWTFkDw98Q==
X-Google-Smtp-Source: AGHT+IHLo6cGjMnZBsFUHICQtxAQoz4FMO0YzyebxfXgxsFVXIWI5YRBRpigVFarMceZT4fNTa7BinDaYjco5LKfF0I=
X-Received: by 2002:a05:6402:3456:b0:565:6bbc:3839 with SMTP id
 l22-20020a056402345600b005656bbc3839mr8344503edc.40.1709135844452; Wed, 28
 Feb 2024 07:57:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zd4DXTyCf17lcTfq@debian.debian> <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop> <20240227191001.0c521b03@kernel.org>
 <66a81295-ab6f-41f4-a3da-8b5003634c6a@paulmck-laptop> <20240228064343.578a5363@kernel.org>
 <9a0052f9-b022-42c9-a5da-1d6ca3b00885@paulmck-laptop> <20240228073544.791ae897@kernel.org>
In-Reply-To: <20240228073544.791ae897@kernel.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 28 Feb 2024 09:57:13 -0600
Message-ID: <CAO3-PbrFSrQZQczp7nEj=HLn4GLL+UY0SUCJentgOAJ480dqRg@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 28 Feb 2024 07:15:42 -0800 Paul E. McKenney wrote:
> > > > Another complication is that although CONFIG_PREEMPT_RT kernels are
> > > > built with CONFIG_PREEMPT_RCU, the reverse is not always the case.
> > > > And if we are not repolling, don't we have a high probability of do=
ing
> > > > a voluntary context when we reach napi_thread_wait() at the beginni=
ng
> > > > of that loop?
> > >
> > > Very much so, which is why adding the cost of rcu_softirq_qs()
> > > for every NAPI run feels like an overkill.
> >
> > Would it be better to do the rcu_softirq_qs() only once every 1000 time=
s
> > or some such?  Or once every HZ jiffies?
> >
> > Or is there a better way?
>
> Right, we can do that. Yan Zhai, have you measured the performance
> impact / time spent in the call?
For the case it hits the problem, the __napi_poll itself is usually
consuming much of the cycles, so I didn't notice any difference in
terms of tput. And it is in fact repolling all the time as the
customer traffic might not implement proper backoff. So using a loop
counter or jiffies  to cap the number of invocations sounds like a
decent improvement.

Let me briefly check the overhead in the normal case, too

Yan
