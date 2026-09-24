Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BEA29993F
	for <rcu@vger.kernel.org>; Thu, 24 Sep 2026 01:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790211862; cv=pass; b=k5owPrrljoXklWJ8WzCIKbNaW7TxbFX7jGVBLtikKnRSqNpOFyFK9s9WuoilfxxhVfyVmy/4MQg8iB5ZSsjKeXdMCz4bsqADT2EeZ61gbDdeBOt3/ROP1OAHkfCjzLqXYGfho1Av2tj7pCXfZVuHBHEBaoIKMpxp38C+Oxs/a4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790211862; c=relaxed/simple;
	bh=e7NYzYowAH42T4CIyLla37LCOTvpZlsNv4w1YShEB0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3y/ktLVrc/w9n0jKxI+LpCTSU3PFgl01wBfZixodaJ+e91GhlRsOeUTNvTy2y/2ADSxXXvPSUdbvp7JWOwHZbOt+hSGddwk5R87nKM6WwIozVXWip1zkQ4O8Lt2lnrBA1Va+eB1AMJeFXmBdzYZm+zB6jFxSP7N8pVKtN0l9c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajy0EMXt; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajy0EMXt"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f88so1049182f8f.2
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 18:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790211859; cv=none;
        d=google.com; s=arc-20260327;
        b=cXEUijawnGFGdOXrrklg2W6ptC4vbcMG6YJcE/g2QI95409IbzEi7b2Hh1/fw6J5hg
         99qFn8OFfwSZCfw23CN6wVM88vtgSf0WILghefxjQa1wz8+Xc+K5j1XML1wN3SqvP2o0
         Zvg4I6AEC6Sl9w4A8FyV1HYEISR9OTGKm0PkpIvMocxXv2vCaAWtXVd8tCsKJTa6S9xQ
         n4uyebCEog3r2ymEHF6Qda5SpRG6COOyCRkQDxdp/uYpQU7f4/Upi2V5uk0NzQKkGi9Q
         b0qJns0CfTr9LPD7Rp1ZT3M8HFVyqI0xPYh/KRREzExlVYsLlmg/FZ6COnWvj6nsEq3A
         ar7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e7NYzYowAH42T4CIyLla37LCOTvpZlsNv4w1YShEB0s=;
        fh=iGvPZAw1sg06tp7FVstXM0vijW+2lbzQrvkyepBWUTE=;
        b=j79HNbHEcDEIXDO5cw0lIhUM0YZ4K5PjdABw7kD6vCUWA2JX3azehPT/l0hNu4305k
         WBUDku3jkzIts3ebRf6aw1rqTLuXIxbqXcaloM1RZIXG1xgmCXFuWoUXwi0NpxWX0L65
         5NbDPPAhvT/yptyX2REfPt5rp050coqsMHRWY9omfU4yGOi8/p7IzwzVejv/VrF7+7Fk
         SjbPTwVczWckkqJLHd9irugOX73A8z/cf8tAWgi+yX7rAsHePVK1Ly/xG6YaWAD+Fi7m
         I5Qm4UBzOvXdSL5Vvy+HZgpVWmM4hk+f+FSHuPl/DF/2001pdCcaYFnIVCbgBRaHY/1c
         oI8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790211859; x=1790816659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e7NYzYowAH42T4CIyLla37LCOTvpZlsNv4w1YShEB0s=;
        b=ajy0EMXtWXEEtuEzs0fhJaHHzTOIefavKgLWDDqenNKEF592vNluon8kjHRz53ZWeg
         T+cSyPPQoj5F8jyZFK1Ee7puNyQLV+PVASSq8d7XDnmrf1yfL8JrU4R8j8DGw1DAnpD8
         neChnzF5hLluCtW6ZInxgguX6oVyKkIXtpQ2t2oOXcFNPMbWaSRkL6tTOSjmuZlHN5M0
         +2d6ZhV6JieiXYs9qK04hilhRB0dG8DzkLQFuS02GKwvKicGf1TUpgAqS+HabX41kjzo
         alx5DyBXS0hF9OC2ysqJ5aZlqNUHL4M+wS4BnFrUPVek3ojlVc66fdKIlZyKmSlYwftG
         JOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790211859; x=1790816659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7NYzYowAH42T4CIyLla37LCOTvpZlsNv4w1YShEB0s=;
        b=GYOr2pYu7ZySJ8b+pASXAYa+DuqBUlPeC6M+WJaes4N+A/MFMNtcS+YnMiTPPjzxPD
         kco7c5rSC2gSijFHk/dWn3RaRo+nJWOVIWXiUJRIQpVWjIPhqVxDKOmesV4lh0jmRtE9
         W6WxsOul9ai+q3ydp5DE96TqD23veqa2F/rpuF6+gZozeJF95ern3lFsAc7YnwK48tZf
         v5aA4O7CUpJwrBS5bsEx/luNRkpiRnkWluVrS6wxvndYJP1ZOXYWVgh/rv+f7S7wYtux
         yPZWbhPPgVkFVjb8BqXKXp9rg+skyHcFMNAZwsTVZ08LxLWHOm9DOeAIBu1SDQpyMgDa
         nx9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwV5B/N7epMNPYLJWUSMEoYRo/G11WgTk9a5Tq0xmNvAjqSD5rLJ+K8CiLL6BcBnQZUXg8=@vger.kernel.org
X-Gm-Message-State: AFuF++kp0QtO0/XIObfQ9eB9JY/A994SVhSpLYrdTHyAsqSrnSjqgM4j
	0Y92RZ30ZQsWr3fGcxzmYoeSbAu0r9uK8PkZG9YM1+sRRJm7xFd9Bsw4pWultHR0uHBQW39/nCy
	zztB4uKV+0YUIus87X95B6mZqJx5A/Wk=
X-Gm-Gg: AYBFou2e2HsDCyAlL4yYHja7Zt0GIYrEhr9KCj7ywbGQOL19vuSo08O88miYN8bDeJ2
	cRCVmN+tAuBNJBMWdFZnzwT7ZMhfHsYTR36k3DN3L79/ynAcx62FZgCIcz/HlCa2qt1QSVseYpw
	9nY2b2NZzhzdgOlV1Zi600jbhcNlaxmanTG6B5Qzt4DBqdugL8oOk3J0naScbvWe8kAWmMBfP2c
	juvU2kOuSEoe2oRmr7n6Ln17ZrRUkHAQ1oPg4Fkk6OllSS3VntFWFOEMQivvvVwyAhuO0ZNSLk7
	4iW/YAIUaud3naJyQz+R6XSnJUs/N78sc0KzNwvwtpHSVUw6bGzCWopqYudcKfe1JreGsWZF4Lm
	3iNQHcDKK4DDd
X-Received: by 2002:a05:600c:1c0d:b0:49f:ce73:7ac with SMTP id
 5b1f17b1804b1-49fe67106d6mr15096175e9.35.1790211858543; Wed, 23 Sep 2026
 18:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923095435.591542-1-kunwu.chan@gmail.com> <7efbc8e2ecbf397fc8e44327d13e9a7021b97212.camel@infradead.org>
 <CAN_Opa-tDcZOEk=Mt5MAqUTkg2as5G79uBkxkUaJif8b5QpXYQ@mail.gmail.com>
 <1cb9c1d40f246ddbe24c9fb930d6dce16aaa25a1.camel@infradead.org>
 <CAN_Opa-xVAzFAJVU3rwCsiBzVpQYqUYWzgpBBP7EaX3K+ASk1g@mail.gmail.com> <19595BD7-98B3-46F0-8B47-DAFF304C5A7A@infradead.org>
In-Reply-To: <19595BD7-98B3-46F0-8B47-DAFF304C5A7A@infradead.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 24 Sep 2026 09:04:07 +0800
X-Gm-Features: AclHuK9lgR6kmKYPwa1ltvDPz79B4tIYoVe6PMK2Mrf54spd1LXi9d__ShA6Me4
Message-ID: <CAN_Opa9r1ZbZjLQ_jHSaFQ=8Q-QPrDNxqOrN=feCNz=3N3kNGw@mail.gmail.com>
Subject: Re: [PATCH 00/17] KVM: Use atomic SRCU for gfn-to-pfn cache,
 reinstate guest mode for x86 nesting
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, paul@xen.org, paulmck@kernel.org, 
	kunwu.chan@linux.dev, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:46=E2=80=AFAM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> On 23 September 2026 18:26:32 CEST, KunWu Chan <kunwu.chan@gmail.com> wro=
te:
> >On Thu, Sep 24, 2026 at 12:07=E2=80=AFAM David Woodhouse <dwmw2@infradea=
d.org> wrote:
> >>
> >> On Wed, 2026-09-23 at 23:58 +0800, KunWu Chan wrote:
> >> >
> >> > You mentioned that the SRCU read side scales a lot better and avoids
> >> > cacheline bouncing. If you happen to have any existing measurements =
of
> >> > the reader side, such as throughput or reader-side latency, I would =
be
> >> > very interested in seeing them. That would be useful for understandi=
ng
> >> > the reader-side benefit you mentioned.
> >> >
> >> > Of course, no need to rerun anything just for this. I was mainly
> >> > wondering whether you already had such data from the existing testin=
g.
> >>
> >> Most of the KVM gfn-to-pfn-cache usage is per-vCPU so doesn't get much
> >> parallelism. The main case is interrupt delivery to Xen guests' event
> >> channels, and I did some benchmarking of parallel interrupt delivery.
> >> I'll see if I still have those results, or tell my friend to go and
> >> repeat some meaningful tests.
> >
> >Thanks David, that would be very helpful.
> >
> >The parallel interrupt delivery case sounds particularly interesting.
> >Please don't go to any trouble if the old results are not available.
> >I really appreciate you checking, and I also appreciate your friend's
> >help with the measurements.
>
> It's no trouble; my friend is remarkably compliant once I've held its met=
hodology to account and probed at its conclusions.
>

Haha, fair enough. Thanks again to both of you for indulging me. :-)
