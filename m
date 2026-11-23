Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795399305;
	b=B6Lw+B21ec9S1THsPDxcYaAPxobnAwGGYOLn0RFpE4jLeYZ7oP0rHRScFYe5QH3p/hKJ
	 fv+2pi4+oKsgHEeX8DCCviJAvLGTAu0+Y6KELrTBzJoDtv7vre3aNDDU90rCOqx54qAra
	 DQBqyfU839IsWF8bmJ2nBv06Xf2g1b/kIcRD5YEfqVYFPiI2reX2wk+fVibbZD9f9diMh
	 BjEnmRVwN3e0lcBEp980fKo74uoeGwcHT+2UOI+JKL/NIPtfzxPmat9O9G+lA6jrT91mS
	 qlKpQpwuoJ5DkGWjUlaZBEyAh2uyOeNtc79Ors5OtphrasThBEc+LtMYLN/OPOquLMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795399305;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3XCN8MNx9DQWn83H6jTo1oY8Z1rb7ww+YHjpWxJXSWU=;
	b=BGPbMJtg2kWHPRb3bePIVD/iQinju3ovIeqDHpX2niKKXg2bUJcCRi4/5FGt70QfWfgT
	 f31HhPGuikrCubDLmaBbKeoC6+SzFM2Jz8xiIG7SPyL135kowK2vqnPs0UFqrSOSw2uoq
	 2lcqZ5i+M3LQ29c+seFY1f8K81RFuv8QsGh0klLy4taHgcpoHQh+77d6/yAI1gskqk/S0
	 xDcyNngfJ4KcHN0Hn5SLszmzXATVHM15f8NQ5PyE/VdxHIbfoz39I9JFo/4rwqnmn6CrL
	 UKoJnNL25mLGqiDC0Sv8/66HqVj3rGkUQis6SpGS90ZRJb7niGu4evOdDzi7VheFRiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2VB9rZs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63385606A31E
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2VB9rZs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9F81F000E6
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 02:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795399304;
	bh=3XCN8MNx9DQWn83H6jTo1oY8Z1rb7ww+YHjpWxJXSWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=O2VB9rZsOmJSEq7AbJ3AasTzaOZd/nYi80NZEfGhMqTmKa0Qlqlcm34U24FExyVTv
	 CAYKWOxQIALQ0tKud/jaxRfvdbytji8bzpRqXkkgoM8EWixaJtjIQDyfq0j5n/87na
	 ysFGtO/DQLI6E/NYbrwT1HXg9NsMxEq8gWgsOh4fagsGh66LgeSqfBdXCWkeufzJGR
	 u3U3c9Nyg+Lahr2QzfM316FUeDUsKfZDavAwj4j4SM3XxG8Ys2se/UlhuOnM0c8uzu
	 mPSJiHqsCdurDI2r86lh/fIasi3FRIFkjp/WfEzEDFiKBm9WPD0z00d/JCX40I3nMP
	 AsMEr9J8avz2w==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-949657a20d7so307328185a.1
        for <rcu@vger.kernel.org>; Sun, 22 Nov 2026 18:01:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGbJwz6sCPFjc0JCcKnK0AFKayQv84Vhs+fphfonKeh6qTsZb89d40p/nhPh/0clN/Hobg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vxsGmv4eLztlJ23+YEv0Ww0O6wEUeBSJIZETlzycrdtvyg7uY
	bEAdIc+pum4YSHLqMCEvP9Qqmjk078yKT3vJ9ZcUvoP3B9cN+Xn2luwJoRjkqoOl6YvawI5VMgr
	wgFkOEv5Rw0tzQ4v4ERdLbJbZy0aIAGY=
X-Received: by 2002:a05:620a:8388:b0:93e:e425:229f with SMTP id
 af79cd13be357-949bab2ab74mr1674615185a.77.1795399303983; Sun, 22 Nov 2026
 18:01:43 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116081403.216452-1-max.kellermann@ionos.com> <20261116081403.216452-5-max.kellermann@ionos.com>
In-Reply-To: <20261116081403.216452-5-max.kellermann@ionos.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 23 Nov 2026 10:01:32 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4w3cP+tgCGhTFu5p27Wi-9AFCneQgwLUAUg7X-gvX=e4Q@mail.gmail.com>
X-Gm-Features: Aa3M54p-50BtAbApXAC69mU4ZCzPL9LtAqomEWm18qsEYdXBO_694xtx7kaXITk
Message-ID: <CAGsJ_4w3cP+tgCGhTFu5p27Wi-9AFCneQgwLUAUg7X-gvX=e4Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm/mglru: avoid redundant rotations of young memcgs
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 4:14=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
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
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  mm/vmscan.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7cfaeca9a605..6b7c9f118e18 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4472,7 +4472,6 @@ static void lru_gen_rotate_memcg(struct lruvec *lru=
vec, int op)
>         int seg;
>         int old, new;
>         unsigned long flags;
> -       int bin =3D get_random_u32_below(MEMCG_NR_BINS);
>         struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>
>         spin_lock_irqsave(&pgdat->memcg_lru.lock, flags);
> @@ -4490,11 +4489,19 @@ static void lru_gen_rotate_memcg(struct lruvec *l=
ruvec, int op)
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
> +
>         WRITE_ONCE(lruvec->lrugen.seg, seg);
>         WRITE_ONCE(lruvec->lrugen.gen, new);
>
>         lru_gen_del_memcg(&pgdat->memcg_lru, &lruvec->lrugen, old);
> -       lru_gen_add_memcg(&pgdat->memcg_lru, &lruvec->lrugen, new, bin);
> +       lru_gen_add_memcg(&pgdat->memcg_lru, &lruvec->lrugen, new, get_ra=
ndom_u32_below(MEMCG_NR_BINS));

Hi Max,

I know it was my suggestion to avoid unnecessary calls to
get_random_u32_below() unless we actually need them.

You then pointed out that this would move get_random_u32_below()
inside the spinlock, which I had overlooked. Sorry about that.

Have you tested whether calling get_random_u32_below() under the
spinlock increases lock contention?

>
>         pgdat->memcg_lru.nr_memcgs[old]--;
>         pgdat->memcg_lru.nr_memcgs[new]++;
> @@ -4502,6 +4509,7 @@ static void lru_gen_rotate_memcg(struct lruvec *lru=
vec, int op)
>         if (!pgdat->memcg_lru.nr_memcgs[old] && old =3D=3D get_memcg_gen(=
pgdat->memcg_lru.seq))
>                 WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1=
);
>
> +unlock:
>         spin_unlock_irqrestore(&pgdat->memcg_lru.lock, flags);
>  }


Thanks,
Barry
