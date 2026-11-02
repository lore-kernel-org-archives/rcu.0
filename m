Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793607991;
	b=Ob02sAfeWmjYTEytGxZBaOYXRsu0YHkT9JjK/NsdoXZjeJlUMb4MlQxRITu4Jy8v7LSG
	 bylPRjKPtle1BJbusIO32p7UTyNtLvIOsdZGjbDKjnA2M2XiHFxBrl6v+y5mgMl4z2cGU
	 grIYM+g9/PCqigePm1/ueSPTot9dkD8e3Gq0M8w4pKafFjv6E2nbD7V3uoMCm1QSaaHWW
	 BfuGtj3pgRzRuWQTV0TaMIMfgKEwBKKZ+tSR/sexhfLQdYfwhotgkAOD4svtzph9nM2+4
	 sfWz7dbRi0bUbWPS0E9RL4/S0w9ql973pgf1giUWUe5KsMNgNik74SAIEM8QlHVtKyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dcE/5rnGxKA55YKLDJm0k2JZRyvDK8vL0G/XzycxiFE=;
	b=e5F7rnNN+BlEJ6xraq2ao8QEdAVLQgzjxVBfM0WqoiaJfH9dFeOytrYy71AWXWvGYnfr
	 oLNvwwEZbiJyQzk95JJKrMhkwuKdTqJMuHbDgeWHDqwGKd856bWBWr8k/ntB57zZzJYkh
	 CYCDFQ2wrsR2kq9qlzQVrvqKh7YQ0aWD4akqKfyabVbdzrGRdUGRNff7BWoZ4Lyygeh8j
	 9NQvO9Lv3G1pEHil2jVl7rU7rJKDe1QT/PGCUCvpzcc3+Vp9XpAwo1Gl156AggDc3Z7sL
	 3c7Rsivo7RxzP5NMW5kKkVBEtZbotPiCBnWvEnaX3/H9SPm7/BlL06eYkY5ekkicZ/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=Ghla3XBe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97149606A329
	for <rcu@vger.kernel.org>; Mon,  2 Nov 2026 08:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97149606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=Ghla3XBe
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4326803b54so132604766b.0
        for <rcu@vger.kernel.org>; Mon, 02 Nov 2026 00:26:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793607989; cv=none;
        d=google.com; s=arc-20260327;
        b=q5PWDoaXdpvtUo+44UDOfq0POXJo+J/zQCOYlMmL7fwRrExiqh/aRQc53z6eaNDI0u
         QNZVanaosYd2mhpwQ09dMPp3mPw9CcuwzAeZaSlYkvGNWdzsyyTrU5TUe5x3PZk/7z2K
         qzA+uF0a/vfi89Bo6H7GzHxb+cEZodjoTH6jVTvGC7cBikAtFhrl9uI8WkEMKaYkjZTW
         22dmc3Cvx6epdvVlK64HQXyu13H7v/EZeHo7FNMKnk3aV99ojajqlPfrKmowzoh5U9mi
         CGlFI/nSFCzK6wsww0Su8bqvCLLgcBLswUURfcbpLxQcwJX2jgepvfQOmjMgKYtlofwl
         c8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dcE/5rnGxKA55YKLDJm0k2JZRyvDK8vL0G/XzycxiFE=;
        fh=w/tCe9iGl8XGCpANl0KHv8/D+ExjRgnX0g6BmUWQjFM=;
        b=hvUTdQSveB9M3QJCG+aXUFwujBvvZkGVkzQSrkrbwybnL1X/wK3yCoQJV5CDyl+IqB
         Yo6K/8Pl6GZ7ibb4S1kCvp8r86ITaJZvrLuhlsPoks0qnqVfWw8cMD/Jayc2F/96JDn7
         7Jq3qgVF2T4UbFVP0dcS+aeWyFgARcG5CzxHNUvqvJsBAceBUoaRomGEvbnvPGt5Z/F5
         2lT9fJ3kA7MNdlTN4SU/Ym4UKQC3TeRg+H64/gb0Pf5HLxind7VSF6nW2cjN1E/Jfmta
         IlKsR3SJ/SVd2fu5RA5Il6wQxpHSqMplisVjLgTclyujf5fYCtFUpW8v5DOB92E6nhKt
         0kdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793607989; x=1794212789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dcE/5rnGxKA55YKLDJm0k2JZRyvDK8vL0G/XzycxiFE=;
        b=Ghla3XBeS3ZICDrDsHjTXEvnEEaidAKWl/h1ntZF2kzJFeB4ZzlWCOPMEmE/cVNY9R
         K6YEJg4LMX5VCL1r98aAqcrZvHPyPUg6ePzuNvBalIR3blx7UM7fdSzAaxBxiodOU81T
         /7mgiqozIqGVoXjbU2aqi698KLTkCnXQVLgJv+ouqP/L4lRbQKoyeMl1WHZ9y65FT5Z+
         wIeg2Ujtz7Ip7hUxjCJql/TVnrLpJZzZi8yOvHuRz88Efp1flvosjSN95LCMQxTFhcPt
         5xCQJGPZYk3ZfV/fwpXn4ziYAhwWTXP0BBQjSOIbuYyugnyZM6QfnDWQNohKxEj6AxZl
         nEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793607989; x=1794212789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcE/5rnGxKA55YKLDJm0k2JZRyvDK8vL0G/XzycxiFE=;
        b=Q3cPQSKP1pEl17KynfrL0CzN99jKUNwArMYUNIk3bk4+8eh0FamOQBQtiS43GohWl9
         O3DBFo5Qln9yz6L3AnGrHqCBtH9Tt9Z3S9UGQeUdTlN1mi51IQw0qmJ+CvYadkKBRuKM
         1qNQHVzg7aXnJwJkvAaVqm0UJC6PlfF6b/uRueuz6U2cwt8VCqo6PJfZi1aNR/XNHaaK
         zHNGGOBehmVCSRfFJ3duFmRuH3E/ZUXAHGE9N+lQoBLpdG+NnDQU9Too97121l5PRxOI
         1wmCwOxabjeKT1kvWokP7ns/mq9FmmL84OW1v9LVdzaf7w9PvQDm5pUhYiVtU/H46nQT
         h1rg==
X-Forwarded-Encrypted: i=1; AKwUvBwOH2RK0VNMQ78IVvCr1n41JCdclzLeyN/kTBBvRUfwP9WED/uFU/bpT8UZ3O8L+pcuyGs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hBop5Y0D40mbrhsbY5Ut8kaSxplkHPvAREfns88T+dr3olqA9
	GJ85COTKgxyIavfDSZUiFqnn95lTjy7V73wo2HE2ADkgpEozyA4GVQFWEEWv71k1EWd3F6MpCgM
	gXmqVect/tDD0nRyLfZOjoGu7/zBVOR/BDoaYOM/nSw==
X-Gm-Gg: AYBFou0FHWT7WPeZqi/vJKecCbq0VMsJ78D6lUM68Wv0xeGZc9ElxMwzDC2ioYkY0sL
	kF+xQgHN7fTxkzWgRbCK48mfXY57DIBmoRblAaAkcuXdXgBDt15gJJGgtvf/ThXVI/Shqp/1xYs
	TzrkHWY/8faYffrV8EGO8dWdm4SeoOLk7MTRGBxLpReSpl/LE/DYpY76UEsVHDi5omkPUD91rAp
	WTDmfEgb1qS+IJjbPAhwrUH4Zup5WNv74XdYNOi+aUHlXtpfg8VzDMiGw9eUeLB20bmMocvnp0v
	f6sXsaQWt38q0Onn1YdyNBk3o6FBQAMCcBqvuLC+u87OwspMbmv23VSBKTUGbX/Iflcuno8/Fkx
	gN76Mxf8dHo1o+ajqxKGFES1bJXIpoYqLVOyrSIITLL+2t1EUOpV9PLLnGw+MQMStWkWNaj4XHe
	dR7ZCm7WUSduAU
X-Received: by 2002:a17:906:ef0b:b0:c33:923b:ad66 with SMTP id
 a640c23a62f3a-c4ca7acfb4cmr790165266b.43.1793607988903; Mon, 02 Nov 2026
 00:26:28 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012205447.2717801-1-max.kellermann@ionos.com>
 <20261012205447.2717801-4-max.kellermann@ionos.com> <a64f6a98-de70-4004-aac0-312cb05aaf92@linux.dev>
 <CAKPOu+83bH2CRtiAio+1VTTQrYFF9th5XfG5wL45ujEavPS3Dg@mail.gmail.com> <20261101135047.61fc3f209b3235ed6fc96183@linux-foundation.org>
In-Reply-To: <20261101135047.61fc3f209b3235ed6fc96183@linux-foundation.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 2 Nov 2026 09:26:17 +0100
X-Gm-Features: AclHuK--3PTuMj8RZeBQA28BApSOQ09xugBp4TxqQtGO5WmzRMN0zBosAEwqtzc
Message-ID: <CAKPOu+-e4uPhjSj2KxWojDKJ6GsK51HrWMOwN9-SAnqi2gMW_Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm/mglru: cache the last memcg node, make tail
 insertion constant time
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ridong Chen <ridong.chen@linux.dev>, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev, 
	baolin.wang@linux.alibaba.com, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 10:50=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> So.  Can someone please propose a nice simple quick-fix which we can
> backport into the -stable stream while we work on the larger
> rearchitecting projects?
>
> I think that might be Max's [5/5]?  Max, do you know whether that patch
> alone will fix up 6.18.x, or do we also need to addressed that lengthy
> spinlocked tail insertion?
>
> If you think [5/5] is sufficient for -stable then please propose that as
> a standalone cc:stable thing then we can look at the broader changes on
> top.

Depends on your definition of "sufficient". I guess [5/5] will make
the symptom go away (the stalls), which is a good thing, but I see
this as a minor incremental improvement that doesn't solve any real
problem.

The real problem is the degenerate performance due to a silly linked
list insertion algorithm (traversing the whole list each time). So
with just [5/5], you'd still have hanging processes and abysmal
performance, no progress anywhere, but nothing would be logged. On the
positive side, not stalling RCU would at least not pull the rest of
the kernel down with it...

I repeated my benchmark, this time with Linux 6.18.60 and an isolated
run with just [5/5]:

                       No patches    Only 5/5    All patches
  Requests/s                 5.28        3.20          50.91
  Mean latency (ms)          1494        2463            154
  Max latency (ms)           3932       10467           1685
  CPU time/request (ms)      1494        2452            153

Patch [5/5] does not improve the underlying performance problem,
there's even a regression in this run which might be noise.
(My micro-benchmark does not reproduce RCU stalls and thus does not
prove the RCU stalls are gone.)

If you believe [5/5] should alone should be a stable bugfix, I'll
resubmit it to stable@.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
