Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D062288C8
	for <rcu@vger.kernel.org>; Wed,  5 Feb 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742241; cv=none; b=idc/1FUOHFIiyIQH2WfKUZuzSjvM7L2ioVIAmL5qIJjrf4PCe8eTpfvSQUTfe1lAsu9bltcVq/U1b9vqXwI0ZJjWZuq2VsnhOlOGQhE8BmhG40fNUkAiL9Js0px+PvTcS6zduF5hs2/Ycm1XYZTy8l7rHYRGgViVit/s4P003oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742241; c=relaxed/simple;
	bh=uJCJoXaIceeUOx7uPX2U7F+kJtLIbsGT9PC55HpSSoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gS/2CahAVRY6Sj1Fc3Vmpfe5fXdsNG8ZbCjoquUa+6ntqSOU+A3LyBQ+zMBMu/DuBkcaSVkte2PbMc5c5McVzo1pVyoN2CL/5JlU/fO0gjP/RMKCfywYaRstCgA8UaA8Br0+1errvlNQBA2yQTcwHMW3iWrbaC6c7nWG7vSFvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SN4m623h; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SN4m623h"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so11150917a12.0
        for <rcu@vger.kernel.org>; Tue, 04 Feb 2025 23:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738742238; x=1739347038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPQ45o6GxZmuNIcqeDr+LwklxlIy2EcQQETBSNhoeZw=;
        b=SN4m623hoCBDLEJ9loNxqj3z9fN3yiKKP5jm48JFSbdwUasahCW05X+gnaUNiit3uT
         0Vj/ge+V/aUo/BjenHKKlwBfjtgzrvLxEOvRSq6QUuiCgeUw6ZFjm657a4nOZfXNMSgG
         4/H3AQuMjpZy0UDFmIkFJHvyug7M7U441RZwdtmaxPAPQEKIuPRJGx43mpXz1t8qdM8X
         gUV5bEPbQ8Hn+4QebSnSzxltoyOKu9tL2KdGEbCteQ9owdE859iKN07r7h/pt38wtpnQ
         b1QQ140QUOLFQPoFS1R6bPSEiS4M2UoLtvPf41hj4bwBbMFnJJFiUqEhfZDBM6JLwqVS
         LBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738742238; x=1739347038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPQ45o6GxZmuNIcqeDr+LwklxlIy2EcQQETBSNhoeZw=;
        b=AW+f7ut5mM3Rz9GlKqQI1FaySNMcH9OT8iXUhDTb9fjVlATUUJAUDX9uMbjk7l7m0u
         Idx/L/H/3E8c69lYnofNiJrZvL0k/pCYw4JmvAUK4GPJ0crdV4SSOpvLz1EgXZ3bcL+k
         GC8DmmN43Uix7K1aN2IvR8GyNNrnOIIWj5J1/2Fu6eVteX0CBRo4OaIsHf1FDSAQVRHp
         6Bbqvh0pC5JcBsl6iwDMqLOXtjz+BDJ4ufuGrdl5YPjPuD/SeALmq5zMKL/GQ0+vwncm
         dM2JSPG1dxwR9hhb696fRMDDNvCUQlyjHwR6ubhgKSJWGwjkCnU++YnrD3Pp6kfWAVyR
         6ncQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOesADjOW6wUwuniAL4696O84ZjuP8occp3zNcI9f16QVbNig7uE4r/+8vCyUBR+VMA84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDaBRiE/7SBl3dSVA4UZL24046F/yKTpJgUk5S2LwFOhLc9/SE
	edb+TbyqfydBZTpo7mG6worl1seN+yv+KkT+AL6exgCy6kgv1qhJYOlQfUcFH4gYPqfZYCoI4ye
	THzOWiuZZGEDWTTL+ERiWp3dCC70Oa+nE1bts
X-Gm-Gg: ASbGncviMCkwUaL/p32WLtD8FfSd6+5ISNmZS4B+4be0mdse5DpUdHzXz9QlKEPaqdl
	QPjzKptMgbA2Zn0OB+rsV++njAnSZ4O9lAkzh123prdqRa3lKcV7Vm9mTTTnpDC8PEdf3MXk=
X-Google-Smtp-Source: AGHT+IF42kGdt3W89ZlIif5gI9zTVay8hB8q4hXlUr7ZH/inOaMzt+i5WRt04SxMmmK4e4sdUzF5crttdHY+pNqtxAg=
X-Received: by 2002:a05:6402:4308:b0:5dc:7425:ea9b with SMTP id
 4fb4d7f45d1cf-5dcdb76453fmr1840955a12.25.1738742237482; Tue, 04 Feb 2025
 23:57:17 -0800 (PST)
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
In-Reply-To: <20250204133025.78c466ec@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Feb 2025 08:57:06 +0100
X-Gm-Features: AWEUYZmf-hkK5S-4cTzXYSKvaPn4vDvYROBq0moc-474cU0yHwAgjs53TxCGO80
Message-ID: <CANn89i+AozhFhZNK0Y4e_EqXV1=yKjGuvf43Wa6JJKWMOixWQQ@mail.gmail.com>
Subject: Re: [PATCH v3 net 11/16] ipv6: input: convert to dev_net_rcu()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 10:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 4 Feb 2025 13:17:08 -0800 Paul E. McKenney wrote:
> > > > TBH I'm slightly confused by this, and the previous warnings.
> > > >
> > > > The previous one was from a timer callback.
> > > >
> > > > This one is with BH disabled.
> > > >
> > > > I thought BH implies RCU protection. We certainly depend on that
> > > > in NAPI for XDP. And threaded NAPI does the exact same thing as
> > > > xfrm_trans_reinject(), a bare local_bh_disable().
> > > >
> > > > RCU folks, did something change or is just holes in my brain again?
> > >
> > > Nope, BH does not imply rcu_read_lock()
> >
> > You are both right?  ;-)
> >
> > The synchronize_rcu() function will wait for all types of RCU readers,
> > including BH-disabled regions of code.  However, lockdep can distinguis=
h
> > between the various sorts of readers.  So for example
> >
> >       lockdep_assert_in_rcu_read_lock_bh();
> >
> > will complain unless you did rcu_read_lock_bh(), even if you did someth=
ing
> > like disable_bh().  If you don't want to distinguish and are happy with
> > any type of RCU reader, you can use
> >
> >       lockdep_assert_in_rcu_reader();
> >
> > I have been expecting that CONFIG_PREEMPT_RT=3Dy kernels will break thi=
s
> > any day now, but so far so good.  ;-)
>
> Thanks Paul! So IIUC in this case we could:
>
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 0f5eb9db0c62..58ec1eb9ae6a 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -401,7 +401,7 @@ static inline struct net *read_pnet(const possible_ne=
t_t *pnet)
>  static inline struct net *read_pnet_rcu(possible_net_t *pnet)
>  {
>  #ifdef CONFIG_NET_NS
> -       return rcu_dereference(pnet->net);
> +       return rcu_dereference_check(pnet->net, rcu_read_lock_bh_held());
>  #else
>         return &init_net;
>  #endif
>
> Sorry for the sideline, Eric, up to you how to proceed..

I will squash this diff to the following iteration, and keep rcu_dereferenc=
e()

Note that nf_hook() also grabs rcu_read_lock().

diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 4030527ebe098e86764f37c9068d2f2f9af2d183..ee5a69fdc67a30e55c5a073455e=
1d7299f168f34
100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -477,9 +477,7 @@ void ip6_protocol_deliver_rcu(struct net *net,
struct sk_buff *skb, int nexthdr,
 static int ip6_input_finish(struct net *net, struct sock *sk, struct
sk_buff *skb)
 {
        skb_clear_delivery_time(skb);
-       rcu_read_lock();
        ip6_protocol_deliver_rcu(net, skb, 0, false);
-       rcu_read_unlock();

        return 0;
 }
@@ -487,9 +485,14 @@ static int ip6_input_finish(struct net *net,
struct sock *sk, struct sk_buff *sk

 int ip6_input(struct sk_buff *skb)
 {
-       return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
-                      dev_net_rcu(skb->dev), NULL, skb, skb->dev, NULL,
-                      ip6_input_finish);
+       int res;
+
+       rcu_read_lock();
+       res =3D NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
+                     dev_net_rcu(skb->dev), NULL, skb, skb->dev, NULL,
+                     ip6_input_finish);
+       rcu_read_unlock();
+       return res;
 }
 EXPORT_SYMBOL_GPL(ip6_input);
