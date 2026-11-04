Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793778945;
	b=N5O1h9OJcXfn7bl8cqyPGsfRIrfiUFvqTxXa4Cc84LgeBMZaTPmtOshOY/3lLyz3VNql
	 iA984uff+7mM0SX7Ja9IhCVcaC8Hm5/RGyKXUVj6CKkvhmAwQIRzXDh8hsp1YXDwzjJQS
	 rlPcNm0xxGavdVM9dggblUMuAxO2VGK/fA1vMpI9Rx6jTht+A/6BzPVObLwj8Y3QtsONF
	 8nOWV0dVOb+DTrJLteh04U2/uf8yw8GlvPRBBfgsixnNwcqosDT8agp95cL6J6GeDxNJw
	 2C6bFGDxMcO3UlGyrBmzrbDkHVxUotxgDfj3WUaed++EtNajxUAjn9pZwXxVA37QD4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=I2RVWsP67jO+YLENwruOvOgNLvlMuyI5Iq8dOZmwn9A=;
	b=QRUqzBweHDJLbbqIpjhJFJWe/ODZ8dTYHwdw8N8ihg1n2xauzHLs4OCmlAyd4TNqXSEu
	 s1oLJNRmFLb04LsO/d9v0rm3wIkChJj9x7WX0wLgSDH6Nl3EHi1Gm5NudlxJOk1HmaFiv
	 5c7hYwWYetUoAg/+C7XmNm2Nzt4RfgQH2t/ICjg75wW+dshE70nZoGUJLkssXTYjQMKw6
	 A0ALwaQZNyZ6gYECb9CiaHhWnFW+7j5JS+VfvR6ZphDwISh+lIt3POx3xU0fLBl7BttQ1
	 p7jIbfYcSWADSjC2Tf7vhd7hVFa3LlHQc/29zBFkrX9a8vgJ/lKWixGblw+SWw2r8Mw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=NKOMzLqu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB4606A31B
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 07:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8BB4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=NKOMzLqu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c46bd7a7345so69535666b.0
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 23:55:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793778943; cv=none;
        d=google.com; s=arc-20260327;
        b=dXaw9/qJPaAjWJUTRIqgy3sWmBq7IQDWHpnIYBfnr1vfqMxIO9/GDsvMh/8yfClR5D
         ncU4XENMfVHjWJysdygTeJdnp8oTY6Lc83xz2JXesuGXp9tXMOvpZ7YwLyItkvDd2dRy
         Td66c45khnPSKcXUGalx8eW/AK9oMTI2dHrHW18UM1TYpx7XBjHvoXbR/GMOyZnUcdRJ
         PZYFNe1A3Z2kvjqHOFB6FeHNgMwHX4VWEFACJLibNQLVsMD50EOE6VodTqiLmOf5YpUX
         9+paKpTgGd0n4j9pTw0L/iAsCVA5/YLIIc3YK3m0O4KY+YzrZHO8YYj9ZPH9gooExpAI
         kp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2RVWsP67jO+YLENwruOvOgNLvlMuyI5Iq8dOZmwn9A=;
        fh=xqhQVhRwj6/Yew3ysiHN7sCA/gyErIHy0B2ekIBr0ZA=;
        b=hNz7UQ6OLSZ+Fx/Nj4Ree9boBFSZZxIWfeJ4v0/YwqUsuvuybR84kortBdlvYnV2aT
         /nCpDrm6VFEkavTYB4vhxx1GN5XNn7E+wrs3SkYR3M8VZF3FQSsWRrEXx3LfVNTq0lVM
         yk8lTrQ4IgxtaSWr2MUvn5wQ82fVS+LCK7TMVXxuPemRKE2sbCwCa+SC/faAFCQOBkCY
         mkGMP6toLtqbaYSxLA4kyAozBrjIcg0xBoMFWacilXn7+0S4QaQu5N1EInIChtoz9E+U
         aqvWJYSHy0Jm1ipoiX26u7ddhU/icNKTqZ184q0GHyp+CgJdNo+1iCTpMimb4yM+Ytm0
         fCcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793778943; x=1794383743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I2RVWsP67jO+YLENwruOvOgNLvlMuyI5Iq8dOZmwn9A=;
        b=NKOMzLque/B3IbjV1F0xMbnbjbWqqn7qybulR3GxXFLjFXT8Y2Tc7fD9nqgT4YqJpd
         ObHw5JByjNple4pqFlJ1DDzScPnIhWw9tDjLkj2aZ5fMNTYSk9jGA0M4zhoufUWiGBny
         KrGByfcsWxbtyeRH4GNDRQDFqfwxfPaskD5Jg80mcv+4yNsC7M2vO4tYnNPqdmH/ZyXq
         w6ig9HrisdS1owywLx7CwLMLAudVThFimnudgZCr54Qh30jR+4h4NPt59UQ+KYbaBUbU
         b1hIdDZrCUvFIXd6824CAjg+8jzHLDgoCheqJZj35aLTGamm9fEsn98PPoPSeeVjae6y
         3FyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793778943; x=1794383743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I2RVWsP67jO+YLENwruOvOgNLvlMuyI5Iq8dOZmwn9A=;
        b=C34Vo0JdY02cS3+ZhEBnlkdX46qDJBE/BqYRUUjDyQdvNaSnmSxKkIA5OlVIULpMZ8
         jdAgdVbQqJJyM9JI3PmC4cAq6dh+043uXmpAJs6oUs1FAs0+sd0cvxNPByS39I4JZtgQ
         fvJmE3e4hkDFseU8L6SClzWXAyEaS3Kb2MatuC1KAenltSOdSag54fhcNd6XwJ4v2dKZ
         FvItTewOyInowzOgvgqcaoIvZonLD1ijQiSccCt9N0wPC+XYedZfViy93K6aB3rIB7AX
         pUYPm+T8FAx33/mKUdX42QjBIAcCyuGWsbDg4DzQbJm/DP0cxLRyW6dEK+4RybIWeBbN
         JRzg==
X-Forwarded-Encrypted: i=1; AKwUvBymxwmoGMPdVtMv+TqdzHz/1N+3yX+1btHCzytgByq1AZ6pW7ZJlh1bHWgXLKwjpm+BCnE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Bj1d3t8j5/Xoj+aIIHUXIJP+t0/369Ql1c6Nskxz4ysjva/gn
	Rr35u6gBeSIJOao/NyjS2ZeP/dMRiD0VlfdqYYXX6yaHhxCCi6QQrqXRnkOddKDEVbc/zZJTqpT
	Nk41scHgaZmNVxH2nSmW2Qp/QCinrZaj4jAK+guQSlA==
X-Gm-Gg: AYBFou0bNIEOgoDFySk3q3tBpC34cL3xi2QdqU0Kr4fZyBvvcclKcMk8dLcjpclh1N4
	ijr1XEt/SLo75O31Bccw81ePUozVRQ90CBFp3vfeTVr69myFMSvn1Zil+zZ2z5duETjtEDS/nyp
	GjDuKkYwQU1AISmvsbhYQY5tw0M7f1/zOhYy29kyjhawst+fby9lDjqAC0Af996s2Lvzb/fFuZM
	21t2Qe6B+oy4tjFqZ5JEebfOK6wK6z3xr9gHGIRteTpgF7Pahv4kSDW/lXV1AhtJs1zkX+qakjy
	mqLascYOevXEzwgzlcfdhJZVXDNZ/TT/yhwaG4G4Uph7zaL0WKtfwfFjOozcgLUBaRKPJOz1uFY
	6GsQfUvgJkdhzqVIrngUFWq6gEjH/qMqkCRB4afqfFouUu1qN+Tx4VcnlCsfLwDoIDg==
X-Received: by 2002:a17:906:9946:b0:c4d:939:526b with SMTP id
 a640c23a62f3a-c4d0939530bmr123502666b.0.1793778943224; Tue, 03 Nov 2026
 23:55:43 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103113711.1832834-1-max.kellermann@ionos.com>
 <20261103113711.1832834-4-max.kellermann@ionos.com> <CAGsJ_4y+LX-CSnDJ59VT2nc-i=rB=4iMuBQYawMCktk-_SPykg@mail.gmail.com>
In-Reply-To: <CAGsJ_4y+LX-CSnDJ59VT2nc-i=rB=4iMuBQYawMCktk-_SPykg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 4 Nov 2026 08:55:31 +0100
X-Gm-Features: AclHuK9db34czdLJDGuWdv4eeJ4Wz3rR25lYZqq6bke9pbWo9X2wFnS-q5qCw2o
Message-ID: <CAKPOu+9XP8CP-EiLqd_Q-F6EWUQPgi4Ysz7wu8LZijR+j0_uyQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm/mglru: cache the last memcg node, make tail
 insertion constant time
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 4:40=E2=80=AFAM Barry Song <baohua@kernel.org> wrote=
:
>
> On Tue, Nov 3, 2026 at 7:37=E2=80=AFPM Max Kellermann <max.kellermann@ion=
os.com> wrote:
> >
> > Rotating or onlining a memcg currently uses hlist_nulls_add_tail_rcu()
> > which walks the destination bin to find its tail while holding
> > `memcg_lru.lock` with interrupts disabled.  With thousands of cgroups,
> > this takes a long time and causes severe lock contention.
>
> This is the main cause of the soft lockups and RCU stalls,
> right? If so, we may want to add a Fixes tag.

Yes. I added (for v3): Fixes: e4dde56cd208 ("mm: multi-gen LRU:
per-node lru_gen_folio lists")

This commit added lru_gen_rotate_memcg() which calls
hlist_nulls_add_tail_rcu() (full linked list walk under spinlock).

> The fix itself may not be directly applicable to stable
> kernels, but based on the logic of this patch, we should
> be able to work out a backport, right?

The primary copy of these patches lives in our kernel branch that is
based on 6.18 LTS.  So I already have a set of patches that can be
backported more easily.  Do you want me to submit these versions, too
- and if yes, how?

For me, it is not entirely clear if a stable backport is really
necessary (thus I did not Cc stable).  It's not a bug; just awful
performance when you have thousands of memcgs, but few people have
that.  But that's up for you to decide.

> Another option is to leave the cleanups in patches 1 and 2
> out for now, and make patch 3 self-contained as the first
> patch in your series, if that makes backporting easier.

I don't think that makes backporting any easier - they are not really
cleanups, but refactoring to make [3/5] as simple&small as possible.
I wouldn't squash them; it improves nothing but makes review harder.

> I'd appreciate it if you could also mention Ridong's earlier
> work in the changelog:
>
> https://lore.kernel.org/all/20251119083722.1365680-1-chenridong@huaweiclo=
ud.com/

Aye.

> > +       if (at_head || !last)
> >                 hlist_nulls_add_head_rcu(&lrugen->list, head);
>
> Do we still need at_head now that MEMCG_LRU_OLD has been removed?

Yes, for the "!last" case.  This is, unfortunately, a special case.
If you prefer, we could move this special-casing to the hlist_nulls
API so callers need not be aware of it.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
