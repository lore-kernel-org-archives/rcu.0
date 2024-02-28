Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE3A7291B
	for <rcu@vger.kernel.org>; Wed, 28 Feb 2024 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164427; cv=none; b=AgpcQ11GKxE/Vj19ObX98m9K/f/mDtjumssqjpAxL6M03LahCLRI5frkukYwPu8OmWmfKK6yyPrr444MA1iMNKs1Ec4zv1r/jSGsiSaeFanvIjISyIkEB9mDV5wVp/XaQzXYfHi6OSXBpK4/jNsBuQfZMsgCGiSKsjQpo/E8u54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164427; c=relaxed/simple;
	bh=226C5h/Y1VCHHH/6rHYwB8j04u2Bj9Ng00Ye5vrzpe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtjobTTusCylTWEzEvq9uAEspC20J/tCEdlhZ6kPIKadqL/wBSOiQj9X4gmszQvWKmxna+Snc2AHA3WabZp2RNxzgXMRyfW69DtSbMt+VFrU/wA84SbLTC4ACfAzsr70nRY0rPEOO1bOmjF5nQIFTZO9tSNczzJHehEKm+BHlGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=b/WtlF+/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="b/WtlF+/"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso461039a12.2
        for <rcu@vger.kernel.org>; Wed, 28 Feb 2024 15:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709164424; x=1709769224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyTb/9u8Fut3XJA7s5sTKjASpumq9GMF8lzH2f5O968=;
        b=b/WtlF+/cAuvq6M20JXmWz8A2nkQptPjwcnBQLZkV9kPBbnAW24f9bgh5o9TXc7veb
         a3eOi5yMNeZ0hOuCQ3ljUOEqMjHWtp6/ScFlSp1ToC/hhPIiGktWzjz7Pdv3WAnYcinj
         eCck83VpNb35lad8kW5Mqhr9VE5ZFzNOGWHUFbs76XLAQrQEScmGNMXDAz+j8u5YGIHO
         R56D/9Cp+0iznOPm3kXRtfJh9YHYZhdss1n9vCIoVe4M5ivBNkgV0HDZyaRPF1N6UCFS
         E9MKOTH213WGU0/R421/tyAuYheLu49B136cC2wpkd/ARaWY9L02tzb2vCoR9xRlVYaa
         4uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164424; x=1709769224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyTb/9u8Fut3XJA7s5sTKjASpumq9GMF8lzH2f5O968=;
        b=Uo2HaoS4XlBbdwwOfiHZIL3qrT4yICHg+deCVng2qLo7qcvus3TF2dykwlYOZH2Dsn
         3RBDQPqqb6gbBwHlaUsJ1xFY7Qp//j3yxw9+VVZ/7iOGXL4H+QNXAnQxDYcG83OHOgXH
         oncfcxBVc47gj2zKGiGSJ5qojvdfP42IBWWwnXp5odZHWa9aKkhQyECoPlrTpIhfgdih
         eZMqe2FRjjg7zYhBAjR/kzdisPuRhxOE5CQ/P5aY1j0+MytMzjsDIeOLo+dYVB9SrRr1
         /KDZdSdvPwA5uQtYXgHZuP1GG7p1waXsNy/gF9gNM5xiQGVYIe/5n2LBfo3qFTJ9g6WI
         C9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXNgTT3EGUfzLglWatM0KGXn3ARJf0lt9c2VlJtWn4UaaGLihN8FH9LjzIAUj48UyTmdjNTL7FeclvoAopO/mYu6Rl0
X-Gm-Message-State: AOJu0YxyP1HWn4QNcB5+B0GGxKZ7fBndty6w2Y/Rrgku26gYcB4KCoWb
	mUO7kPemo/D/JPvvtP4ADlrjwAZjOFRUPgQihoaznwOY81oAW1Ts4zXvtmaH3jvN9gpE/7y7XcN
	Jkve0mwsrpaz0ApEjii1zR13gYhA2+rztgwpk2A==
X-Google-Smtp-Source: AGHT+IFWoAzwjRhf4ZRQtooisu3O7UmB386nUInSxafRbB0jMnEpyJq60SxptGuNyafKn0Mhr6ixAk9Zq1h7yoTNCaY=
X-Received: by 2002:a05:6402:b57:b0:566:414d:d724 with SMTP id
 bx23-20020a0564020b5700b00566414dd724mr253144edb.35.1709164424445; Wed, 28
 Feb 2024 15:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zd4DXTyCf17lcTfq@debian.debian> <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
In-Reply-To: <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 28 Feb 2024 17:53:33 -0600
Message-ID: <CAO3-Pbq4Fybyhodv5-36U=-rgttkjxFj6cRvAGcapvE8pZyWSQ@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, Feb 27, 2024 at 10:44=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Hmm....
> Why napi_busy_loop() does not have a similar problem ?
>
I just tried and can reproduce similar behavior on sk busy poll.
However, the interesting thing is, this can happen if I set a super
high polling interval but just send rare packets. In my case I had a 5
sec polling interval (unlikely to be realistic in prod but just for
demonstration), then used nc to send a few packets. Here is what
bpftrace react:

Normal:
time sudo bpftrace -e 'kfunc:napi_busy_loop{@=3Dcount();}
interval:s:1{exit();} kfunc:udp_recvmsg {printf("%ld\n",
args->sk->sk_ll_usec);}'
Attaching 3 probes...

@: 0

real    0m1.527s
user    0m0.073s
sys     0m0.128s


Extra wait when polling:
time sudo bpftrace -e 'kfunc:napi_busy_loop{@=3Dcount();}
interval:s:1{exit();} kfunc:udp_recvmsg {printf("%ld\n",
args->sk->sk_ll_usec);}'
Attaching 3 probes...
5000000


@: 16

real    0m11.167s
user    0m0.070s
sys     0m0.120s

So the symptoms are the same, bpftrace cannot exit despite having an
1sec timeout. But the execution pattern for these two are probably
different: NAPI threads would keep polling by itself, whereas sk poll
program might only poll when there is no immediate data. When there
are packets, it switches to process packets instead of polling any
more.


Yan
