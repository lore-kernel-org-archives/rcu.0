Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763630;
	b=zd3KVapIz1apD9UqH/liKqk9fiOzEFrnlm1FpXZwUy1Di4MKPqrRjV0JIBiyMqDE+vRs
	 5yIzMH0VDCutiM5lG0jSNw4CNUKeDR7gkB4pMwzADFwsdShtfdMc7nAuP6PRmAqKcZpJY
	 u8SkJDUwa7YTaQeI2cAw4yKpPPp5RQKVPEd3CV7TshEMvkCCan9e6iiiQ8HdiU6NHb8pe
	 w9A1Ckgc1qKt3CunMnF/gBBX8/tTv74+ViaPh+hERi7b6LHpG7/13QWpLiXUB9E3Cm9Qd
	 2Q9ZeZoLlLAJuFIusZ36REYJVPI3c3GgD/QXPhGqR4Ut/AIf2vsY56J/SSzzl2ctjPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763630;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+tZw0K5+jfSV2aRm7WOFqugUNHNTb6GHxCzlpfjuQew=;
	b=IwfPVJDHfHYtz85DRmM7rp0/JouHrsTRiSS59S9/7W1lqKlXq/V6HB4EcI1HcwNGYdkt
	 tXjjmr0ruFzHuh7SIXWAdJ+jeksPZ9aoFnuc5MXQSPd6d8ueK6C8Gkaj7bzXnL3EEGmvg
	 Bu5uPDcbzpA9HI8opR1+EOglh9OWua6KG/Ud2uROMzyY0wXHLO8XefKCVyFJHP8nfMN+k
	 Of4cUqQouR8NMLNH7DMnFYbjsdkP4/8hYsnq0UVBpIi8qL2yGLUeE68Qj74JmDXuRqVro
	 lSvO8q9qbpKvK/LSRBr3SLca+dWEcIFeg1sm3zsiMqsZPaBTAIbmrseRWqgtgMeUjRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MogoHxc1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFBC606A31B
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MogoHxc1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591101F00A02
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 03:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793763630;
	bh=+tZw0K5+jfSV2aRm7WOFqugUNHNTb6GHxCzlpfjuQew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MogoHxc1lDU2P1JZYWhARSR1ywNNKCZ8EfaS02CKoiTvz5PrWZR2PF50pgo5KbwYr
	 4DB+o0PIXodT0XRysk7/W/FJ3GssiEo3GZe/I8DRjr5VScVGmrzSYpXy8wb3EZAQRn
	 N9yFj/iSV7VxQu8MJctXaBVZLxgx3IDugiJDaiDqBGYTHmatKwSKUdZxPPde6mlugc
	 5lkROUH1J+Dg/qvVOJRx3E5QjYc5tYut+NwMQvAuR0nOAnB5/8lPtBKHQR5G28Cs75
	 A+bAtJCW7H/5vy0OicCC+tBWWZYzBvNK0tLnn0XSqgIqRHFfx7drVEGhKsKVgF7Ml/
	 Np3l598dUmasw==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c11468b5fso3263146d6.0
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 19:40:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBz/qzgpaCwBem9VUmb640Eimw+b0Ef+bmmhk4IWoRkFWEOpIiFncUq16zVuOM4PQP+wtYs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jGmwYybUxW2Z+AlCJ6EXgqG0136WS71aNjvIhEI1icvad3hYO
	+awSvx1cTqY4EeHWOtGdVQ7HFDi7zmjm+M4rwaeC8lJu+Ae5Hu8NI1OCeTsAnPlsmCZzYmVzNjF
	ZTXMoFVZoRpeZpy0Is7zVWxng41GkUqc=
X-Received: by 2002:a05:620a:1a07:b0:93e:c12c:9dd3 with SMTP id
 af79cd13be357-94421796eafmr2530707085a.83.1793763629745; Tue, 03 Nov 2026
 19:40:29 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103113711.1832834-1-max.kellermann@ionos.com> <20261103113711.1832834-4-max.kellermann@ionos.com>
In-Reply-To: <20261103113711.1832834-4-max.kellermann@ionos.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 4 Nov 2026 11:40:16 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y+LX-CSnDJ59VT2nc-i=rB=4iMuBQYawMCktk-_SPykg@mail.gmail.com>
X-Gm-Features: AclHuK_7q4sg1JpsDk1OEkyOWm8WF60WPZ6zY6tzDeYRFIK1cRTEyQLp5iaugqM
Message-ID: <CAGsJ_4y+LX-CSnDJ59VT2nc-i=rB=4iMuBQYawMCktk-_SPykg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm/mglru: cache the last memcg node, make tail
 insertion constant time
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
> Rotating or onlining a memcg currently uses hlist_nulls_add_tail_rcu()
> which walks the destination bin to find its tail while holding
> `memcg_lru.lock` with interrupts disabled.  With thousands of cgroups,
> this takes a long time and causes severe lock contention.

This is the main cause of the soft lockups and RCU stalls,
right? If so, we may want to add a Fixes tag.

The fix itself may not be directly applicable to stable
kernels, but based on the logic of this patch, we should
be able to work out a backport, right?

Another option is to leave the cleanups in patches 1 and 2
out for now, and make patch 3 self-contained as the first
patch in your series, if that makes backporting easier.

You can then move the cleanups from patches 1 and 2 to
follow the new patch 1.

>
> Cache a pointer to each bin's last node, making tail insertion O(1).
> This requires remembering the bin number (but the new struct field
> occupies a hole, so it does not grow).
>
> In a micro benchmark that creates 1500 cgroups and repeatedly writes
> `1024M swappiness=3D0` to `memory.reclaim` in 8 threads, the request
> rate increases by a factor of 9.5 and the average duration of each
> write request is reduced by 89%.
>
> All writes return EAGAIN in both runs; the benchmark measures the cost
> of reclaim attempts that cannot meet their requested target, not
> reclaimed throughput.

I'd appreciate it if you could also mention Ridong's earlier
work in the changelog:

https://lore.kernel.org/all/20251119083722.1365680-1-chenridong@huaweicloud=
.com/

>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
[...]
> @@ -4561,21 +4561,37 @@ static void lru_gen_add_memcg(struct lru_gen_memc=
g *memcg_lru,
>                               int gen, int bin, bool at_head)
>  {
>         struct hlist_nulls_head *head =3D &memcg_lru->fifo[gen][bin];
> +       struct hlist_nulls_node *last =3D memcg_lru->tail[gen][bin];
>
>         lockdep_assert_held(&memcg_lru->lock);
>
> -       if (at_head)
> +       lrugen->bin =3D bin;
> +
> +       if (at_head || !last)
>                 hlist_nulls_add_head_rcu(&lrugen->list, head);

Do we still need at_head now that MEMCG_LRU_OLD has been removed?

>         else
> -               hlist_nulls_add_tail_rcu(&lrugen->list, head);
> +               hlist_nulls_add_behind_rcu(&lrugen->list, last);
> +
> +       if (!at_head || !last)
> +               memcg_lru->tail[gen][bin] =3D &lrugen->list;
>  }

Best,
Barry
