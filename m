Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769478;
	b=EweeCuyuGAT8WMChI2Lb1SSqazaiSJLJSGn78eFqCPXiA2fHfZ9JoeCtVFrTAvGDIHki
	 bglalukw5icOaWQT7ieXrbJMYljvNgUtVpxfpMwO1p7jro+Zjaq9ATYoHKYSMuM52O5/D
	 UeNmwlvSsg7OyS/1ZnIvLBbqZu7ra5n22uSQhwYKahIGdtqLMg9bsmDC7dQDDBMb7adn/
	 Q6Q1A5qU0gnvSd72OJYyPk2iLUJHjf5YrBrRJaoXxkJD7FZtRKaa+TwUuqkr4CODfQBRE
	 0ih1nv0jVjf07o6ltL4G3yQDvo9/bXj3vNacn+MBuRbs8NVJyc9hhHKJ6nl8QSBQAnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769478;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=p6KEeyjyNXQU3ayuJEeECWcZazCVcQKxSt/xZY18j9s=;
	b=HsXbP4vLF+Nr7I/AwCFdXaymPCP470qLR1zvdYu08zhEFLTxfNdqzF57QMHv9aW+J6I4
	 Im5i2mDRUQywR2phgzIxKR/QsV1nq3Xeekg5EWpYICC8/iTyAnUXBDFrxqDupAolQgYUS
	 uz7rEtZtKtz1My7oNyDx4opR8mD9kKA1G/d3DSERxR7vAgJUjz7l2Ppf7o3YVgnWn4onw
	 qendPdjr5yySD30/VFPWJIwgDxnNAxVOiLfkCBteDZZT4FFCvx8BCxXiWQz+MiC2U4aYb
	 qshB44fLYIfuZuYiPGhQeJeMvq7poYdvwxzdh41F9El0uTgk+MkegAvEb2ePqvL+FvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ichbTzIF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC2606A31B
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 05:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ichbTzIF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E7E1F0093A
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 05:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793769477;
	bh=p6KEeyjyNXQU3ayuJEeECWcZazCVcQKxSt/xZY18j9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ichbTzIFya4W4WvNFCCv7nTsWENKpsz/V73rkUdV/LAxdcLmHpB33xGEZaX0EJ+C7
	 fUYkpcfQqYF5+wfPoPyIOk8jbvL/1+HaOku9c0ovYoTVebuAFLP5XXggDYzfJcqaUB
	 c0bWcmVTgsq0m6Ecl77tjDe3Ntlx2L9fudNU6uQp8LVF7ZqMTcYx7csZorF1rhWDrw
	 sfpxfT1nsTHEBrAHDGrLHn6oa24jb0/CppzZ7NoE1p2Q6h/BX48sFUAp0dFFZRTIz2
	 mxQf/OZ/tNTlSYu5RDJww+WcxbkSks60rmE89D5WvO2JTr6G7u53SUBebSsSlUnS8o
	 VpayNyFYYtOCg==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c7b00a75fso3740056d6.2
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 21:17:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwRRLbAZ6Pq48R8Uog/a2HdQNovQYhd1Mk82Wprt3ye036VIIdHaknX23Hx1uRTTSpGkow=@vger.kernel.org
X-Gm-Message-State: APuU4Z931sduyXS2Sr5/5g3KshS3unqHuv/sMJ9k63fiUiQmCkznw2wP
	YPDfdCm2/Gsvo8si5s/+On2DHCOwH2oiocrLbkU3jr6me4T7XY8xb2OiIPc2sJyRwBpxY7yA2uA
	ju745+Bv0gg1Rj8qopl+VRZMGkYH/7mQ=
X-Received: by 2002:a05:620a:2986:b0:93f:353c:6bee with SMTP id
 af79cd13be357-9442179bdeemr2649014985a.41.1793769477189; Tue, 03 Nov 2026
 21:17:57 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103113711.1832834-1-max.kellermann@ionos.com> <20261103113711.1832834-5-max.kellermann@ionos.com>
In-Reply-To: <20261103113711.1832834-5-max.kellermann@ionos.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 4 Nov 2026 13:17:46 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wpd-e+xjm5KwihVziAeVnQp3XYG=+-BKmx0SVEhmyqqw@mail.gmail.com>
X-Gm-Features: AclHuK-K3YmNyTgJ3q-8NAOMY6-mXLoQSaTkbTkKltCKCY_JfrfNuVcqZ-jSFOg
Message-ID: <CAGsJ_4wpd-e+xjm5KwihVziAeVnQp3XYG=+-BKmx0SVEhmyqqw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm/mglru: avoid redundant rotations of young memcgs
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 7:37=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> Concurrent reclaimers can request promotion after another reclaimer
> has already moved a memcg into the young generation.  Requeueing it
> into a random bin again adds list mutations without advancing the
> old-generation scan.
>
> Therefore, skip `MEMCG_LRU_YOUNG` when the memcg is already in the
> default segment of the current young generation.
>
> In my micro benchmark, this increases the request rate by 36% and
> reduces the average duration of each write request by 27%.

Could you share your microbenchmark somewhere (or post it here
if it's not too lengthy), perhaps on GitHub, so others can
reproduce it? You could then refer to it in your changelog.

>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  mm/vmscan.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 3075949bf641..899f756bd15b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4620,6 +4620,14 @@ static void lru_gen_rotate_memcg(struct lruvec *lr=
uvec, int op)
>         else
>                 VM_WARN_ON_ONCE(true);
>
> +       if (op =3D=3D MEMCG_LRU_YOUNG && old =3D=3D new && lruvec->lrugen=
.seg =3D=3D seg)
> +               /*
> +                * This memcg is already in the young generation and
> +                * reshuffling it again cannot help the scan of the
> +                * old generation.
> +                */
> +               goto unlock;

I think this is a correct change. I wonder if we can
reproduce the issue even without concurrent reclaimers.
In other words, can a single thread running in a
memory-limited memcg trigger it as well?

One thing I noticed is that you may not need to call
get_random_u32_below(MEMCG_NR_BINS) upfront. Could you
defer generating the random number until you actually need
to rotate the memcg? I wonder if this could further improve
your microbenchmark results.

Anyway, the compiler might be able to defer it for you.
I'm not sure, though. Could you take a look?

> +
>         WRITE_ONCE(lruvec->lrugen.seg, seg);
>         WRITE_ONCE(lruvec->lrugen.gen, new);
>
> @@ -4633,6 +4641,7 @@ static void lru_gen_rotate_memcg(struct lruvec *lru=
vec, int op)
>         if (!pgdat->memcg_lru.nr_memcgs[old] && old =3D=3D get_memcg_gen(=
pgdat->memcg_lru.seq))
>                 WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1=
);
>
> +unlock:
>         spin_unlock_irqrestore(&pgdat->memcg_lru.lock, flags);
>  }

Best,
Barry
