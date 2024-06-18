Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B172139DD
	for <rcu@vger.kernel.org>; Tue, 18 Jun 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728267; cv=none; b=cW/DHbq0+MnAO9MRQ9YNNE4dn4ailC6I/hzL3dDt6/GymAzr4iMEMnO4UIluXKp9dbIgsfzVrGF8iPzE6wuJiPgaLjm0lAB/tOi9vnwB5JWtFHp8Vd+Sng3YcGJyYDBZXjJyE0abNuxGhqNrxGREp850HgL5aNUgWtQR9NkmcY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728267; c=relaxed/simple;
	bh=4rvmgLYeX8gXuwtzVuNKhL3/SJkyLuC1nc0UIDCKADc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/G41ZZAXhbeLLPK8a4an+UgIlNeftQqVfj7BPCTLvqeqxNmLxDknI5EWm2MGkYlz3ksk0UNXSShSzLqE3GsdLN5aVD2xPxFQKFsDVttNGdJI8KlP/wfomKdLbUK8ZZv4opHlWfrPPhj9KbtLwOMMHZexLlDxw3Cf8RRnpZthxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNYPrzik; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNYPrzik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718728264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yITZopaqvY4b2PM0tZ+Jx61aUZdLZrWT0NRtkoj2PNQ=;
	b=WNYPrzik426+O5E70GIkfruhmEbAUXeLy1EXD6mB8SSKwgYvnPpleA3LwRHbRjHewE/YCn
	dZ/RkTH0MTETKXWuYb8uc0Nugv2Z5CZ3kIaRAWU1A+Yp/6uzrI7yTtr7fImV1EMqlmNfKj
	E3r+r8uHykuoGweONgHL17p5jV78oI8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-EmYDfAtAOOiR1TNibxY2Kg-1; Tue, 18 Jun 2024 12:31:03 -0400
X-MC-Unique: EmYDfAtAOOiR1TNibxY2Kg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-362bcb0e0a0so13336f8f.3
        for <rcu@vger.kernel.org>; Tue, 18 Jun 2024 09:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718728261; x=1719333061;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yITZopaqvY4b2PM0tZ+Jx61aUZdLZrWT0NRtkoj2PNQ=;
        b=Tn6ipkKcf32k8EXnJ8ZCWNOtsdBNwRq6K1Y9oDZoVBE0smyXQrBTME07YEXGo5N6+L
         laImbGP4B4zPy1rhqrvdax5+16Me+Ukvigl6cvcJQeA6cI8rKQETUjpjBH1i9V/sJ6lH
         7I/0eN30zFlj2BewxvgGZdn+ZlwWkMHmnd2WYgZH6KORrmQxIZhDjVdvXt+O5f7zlspp
         r4eGjQpZPVeLasdyu6VhTp0M8F85fTrZKHlm6GkaS94NCG20NvNFWPRH7sbMb7Efbzeo
         8TDAA8Q6idVY96EzGIsrLs9JC5yKtEK61/ut8w4Dqc+B9gr9SY8wlJxDA7BwtBIGPIWb
         iCZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUws+4yVmsfXmndRGL7wdaOkxkJIW3g3MwwU5hfazOccLrSsaSUBvjl1SEA4FYiC3fIJ5vTM/xjaNXUOgizLbg+lo2q
X-Gm-Message-State: AOJu0YwvNcHl5GT3A1JPqDU0gIFI0NSkO9w67PGe1Kc+0bIiB/M6Er0S
	AIS848GJYXqAEMCJ6gLAVXwLf97EV9gUQknpKoPqrZZxBkzt9iLQ4D4k+u5/QIPOjo3iGRKyBNS
	C6nco+9XjBuO1AH3SN2CDiz5nrXU/8wQEfHnHBhaC73jOaGEHVpfjllHfmQ==
X-Received: by 2002:a05:600c:511d:b0:423:445:4aad with SMTP id 5b1f17b1804b1-42475016e88mr356555e9.0.1718728261666;
        Tue, 18 Jun 2024 09:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoNP4oW7iadbuaQlNHOm7JTR1V2QeWtsXVbR+oIiPPlvBNjt08enX7zyTCMhpuA2yq7qLgww==
X-Received: by 2002:a05:600c:511d:b0:423:445:4aad with SMTP id 5b1f17b1804b1-42475016e88mr356365e9.0.1718728261269;
        Tue, 18 Jun 2024 09:31:01 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0b4:c10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42471e65fb7sm13730925e9.1.2024.06.18.09.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:31:00 -0700 (PDT)
Message-ID: <fae8f7191d50797a435936d41f08df9c83a9d092.camel@redhat.com>
Subject: Re: [TEST] TCP MD5 vs kmemleak
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, rcu@vger.kernel.org
Date: Tue, 18 Jun 2024 18:30:59 +0200
In-Reply-To: <20240618074037.66789717@kernel.org>
References: <20240617072451.1403e1d2@kernel.org>
	 <CAJwJo6ZjhLLSiBUntdGT8a6-d5pjdXyVv9AAQ3Yx1W01Nq=dwg@mail.gmail.com>
	 <20240618074037.66789717@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 07:40 -0700, Jakub Kicinski wrote:
> On Tue, 18 Jun 2024 04:24:08 +0100 Dmitry Safonov wrote:
> > Hi Jakub,
> >=20
> > thanks for pinging,
> >=20
> > On Mon, 17 Jun 2024 at 15:24, Jakub Kicinski <kuba@kernel.org> wrote:
> > >=20
> > > Hi Dmitry!
> > >=20
> > > We added kmemleak checks to the selftest runners, TCP AO/MD5 tests se=
em
> > > to trip it:
> > >=20
> > > https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/643761/4-un=
signed-md5-ipv6/stdout
> > >=20
> > > Could you take a look? kmemleak is not infallible, it could be a fals=
e
> > > positive. =20
> >=20
> > Sure, that seems somewhat interesting, albeit at this moment not from
> > the TCP side :D
> >=20
> > There is some pre-history to the related issue here:
> > https://lore.kernel.org/lkml/0000000000004d83170605e16003@google.com/
> >=20
> > Which I was quite sure being addressed with what now is
> > https://git.kernel.org/linus/5f98fd034ca6
> >=20
> > But now that I look at that commit, I see that kvfree_call_rcu() is
> > defined to __kvfree_call_rcu() under CONFIG_KASAN_GENERIC=3Dn. And I
> > don't see the same kmemleak_ignore() on that path.
> >=20
> > To double-check, you don't have kasan enabled on netdev runners, right?
>=20
> We do:
>=20
> CONFIG_KASAN=3Dy
> CONFIG_KASAN_GENERIC=3Dy
>=20
> here's the full config:
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/645202/config
>=20
> > And then straight away to another thought: the leak-report that you
> > get currently is ao_info, which should not happen if kfree_rcu() is
> > properly fixed.
> > But I'd expect kmemleak to be unhappy with ao keys freeing as well:
> > they are currently released with call_rcu(&key->rcu,
> > tcp_ao_key_free_rcu), which doesn't have a hint for kmemleak, too.
> >=20
> > I'm going to take a look at it this week. Just to let you know, I'm
> > also looking at fixing those somewhat rare flakes on tcp-ao counters
> > checks (but that may be net-next material together with tracepoint
> > selftests).
>=20
> Let me add rcu@ to CC, perhaps folks there can guide us on known false
> positives with KASAN + kmemleak?

FTR, with mptcp self-tests we hit a few kmemleak false positive on RCU
freed pointers, that where addressed by to this patch:

commit 5f98fd034ca6fd1ab8c91a3488968a0e9caaabf6
Author: Catalin Marinas <catalin.marinas@arm.com>
Date:   Sat Sep 30 17:46:56 2023 +0000

    rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects

I'm wondering if this is hitting something similar? Possibly due to
lazy RCU callbacks invoked after MSECS_MIN_AGE???

Cheers,

Paolo

