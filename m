Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793567023;
	b=DyncJ+U4GdQsPKSvicij3r3aNfAA1fi4fnxq0X06SczYQCziEz8R58aRfAVfpcnSzHUx
	 8iPX1tI+J65Mr3+WSSeYPJ1W3N+G/S4MWj37qvtrFG9GOBKMiJ3NM73xTzE9w1B6OTgql
	 U6T0Sq+0jrdXh3XLLFJJgq2A+KaejPUM4konkVPsCAlO46nMLqLHbAZhmo+vt5GzQcv3e
	 x86UIkp3wkEeabwdBWMnHGrYmAIRmhUZ47UJ/KgR7LJzPvD/gVAyEE5WBf+gqffJpWV5N
	 3t/wihqK0E0eo00IE1lZIRjGcERjurA2Slbi1NTEApTobkQKnV2K6+1G9fawKB1iEXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793567023;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=L1KaEDjFsWvGvMrTGkRaCJc21/TfVIdv9OIWGbl/AE8=;
	b=ING4Wzvzfb/IaecUxcIv8zsiIvSPnmNmFwkzJCZI5sp65YShxX+3ZP0Fa6zKgksVE+C/
	 QLyYqJ/2uVd7X0kOkIjHj24b8RlRtxkbpA1oX1v0WaqcC04uppOB+EkCWOStU2hJHLRmz
	 10HIEfXXFVLhEo9JGwzYt4xF647dObp+Fwz7J7JvzrgeRqIcgYK8cq6KvJqu0BJi1kSot
	 ZQyVqFEed7upEzqi845svEmT+S/bK+bEJFnyOeml/QkuESiFMeGNS3BfXXr3wQhkF1ZCE
	 9yk+2m5JHGPRJKy6s894/Jzj36jSW7d0O733r3n+CDFasYMRsFv9DJ7mfiI1xrjGCuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvwTgqIY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E479606A324
	for <rcu@vger.kernel.org>; Sun,  1 Nov 2026 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvwTgqIY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6AB1F00919
	for <rcu@vger.kernel.org>; Sun,  1 Nov 2026 21:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793567022;
	bh=L1KaEDjFsWvGvMrTGkRaCJc21/TfVIdv9OIWGbl/AE8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gvwTgqIYDW+tJS7jRZZJWwI4QJsl7v5vBak1kRtEShonyvInS54zHny1lMpSit+Mj
	 p6kBhVrhBTX0K7zn8aH51Os/5aF8JUjREEGPExzSIMamDOlzUESChvzcN6AWg215AS
	 rZ9bP7cukma9Tl4S6vIIiTBt9npzW9HT4FwuABVtNIPBfPd8c7IoZy11wzs5+43Qqf
	 q/F/Y7MOHH7tQB/aT+mT4U/OVQROvONBb+4ZITL4N07WUyJAQmHgD/UwxXEpzCHVBT
	 CNZyT6bF9E8U2pYGPUvmvFj1PvXH64kMbxlvbtLF9XmHGwDGa0XNbIPoRd2Sk/zG1w
	 wbchhqOSafBTg==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91986c5cb75so25839546d6.0
        for <rcu@vger.kernel.org>; Sun, 01 Nov 2026 13:03:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwPu2FixDSR9110t7YffB+xMMXqbB9DAOabneSvlHKjWSIFSIjNVnJD5OkaDCgDIKt9Fto=@vger.kernel.org
X-Gm-Message-State: AFq9FYLum0QpG7GyH48+Kwt/cMdGZ75eOidXk8yQ1h83iWVzYVhc9T1Y
	pbjpJe7sXWhVkanuG95UaxMlCe4Fqc35M7w1XUxhuEraOeUrRUOLVgS0YVhnT0TerJWryJc2Xdd
	CqCMomETXQH9ibMfUY0EUesiZPWryCP0=
X-Received: by 2002:a05:620a:2806:b0:93f:5892:e5fd with SMTP id
 af79cd13be357-94421585e50mr1455648685a.1.1793567021240; Sun, 01 Nov 2026
 13:03:41 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012205447.2717801-1-max.kellermann@ionos.com> <20261012205447.2717801-3-max.kellermann@ionos.com>
In-Reply-To: <20261012205447.2717801-3-max.kellermann@ionos.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 2 Nov 2026 05:03:30 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zQh9HrvgaqD32_A=bSdqmPqP4oV_SxMXMEDBrHe4jjhg@mail.gmail.com>
X-Gm-Features: AclHuK8OqXgKSVdL2WuIVJgz5P-HEa2lSTPqglBGQNxXGO5x-V4zhAlTU4Zabl8
Message-ID: <CAGsJ_4zQh9HrvgaqD32_A=bSdqmPqP4oV_SxMXMEDBrHe4jjhg@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/vmscan: move code to lru_gen_{add,del}_memcg()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:55=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> Preparation for the following patch that adds tail caching.
>
> For simplicity, hlist_nulls_del_init_rcu() is now always used, which
> is also valid during rotation, because the entry is immediately
> reinserted under `memcg_lru.lock`.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  mm/vmscan.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)

[...]
> +       lru_gen_del_memcg(&pgdat->memcg_lru, &lruvec->lrugen, old);
> +       lru_gen_add_memcg(&pgdat->memcg_lru, &lruvec->lrugen, new, bin,
> +                         op =3D=3D MEMCG_LRU_HEAD || op =3D=3D MEMCG_LRU=
_OLD);

T.J. series[1] removed MEMCG_LRU_OLD, i guess you will need some rebase.

[1] https://lore.kernel.org/linux-mm/20261028010611.3929937-1-tjmercier@goo=
gle.com/

Best,
Barry
