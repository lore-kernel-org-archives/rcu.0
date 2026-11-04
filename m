Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793762551;
	b=q+nvjjnlqpBgGleF+B94JBM3BZdds1TvGy19sZvOWYtInj1P+jPF2x1t/+FT2C1rjN6+
	 EJHO4GJPRV/s89DS/kzebksPrun82myYbDjxhtVgAoKu+LXHu5771msaI4qm7hdONQ0o9
	 wvzr0bZpBTajqvqSVsihfmEJABmJGfL9WaUBoFIBpa4pmBwHSnkRcyJQYKzXGdIKwLjIB
	 3QjAYBfxY8kiuVSBKDlv8dH/XJRm/wdjbLNU1Ov+S3K9020TsJf1cbLQecklUYaqyT3jW
	 1f2ZO6Zg4cwnYXUKEUpumk280pSGdIIwC0MJTWe0ur5GCe2A1FDQHEgbNE3E8IFGI/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762551;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qWCFdcjUisnGbX9eq6UHrpBovt78PAdZKtud0fjPZzU=;
	b=plr4xjAHMt1i3lYv6DF9Tj6Frwq54A8cR24p0zURI8xqCl/GBa8+XbnYPeMAyACTPhua
	 FngX8OOiN4mrcte78hQgpWIx4y1AyUEkwvYnkhnVrGq1O9qc5jQQ6GYHFpiAuP4Yd8ezV
	 2dh7kNbmPE2zEc/IIhD3eHSIF0XR5xZP71kej2flV9KrpCGorSAUtx37Myw65NjuTuA52
	 XizjWA5NnAwXdlg1i3IIrfmlwx9Pth8NjzpHD/FlEyswgm7b1UR0qWbrQLHaZ/MbciMDD
	 nLXwbYoaWg/A745x+ZlFLM4PZmJpaVSHv6NOZY6SBHZlUjhqlpY3lStVTzI/31cho0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaAyXkKQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E8B606A31B
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaAyXkKQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9826D1F00919
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 03:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793762550;
	bh=qWCFdcjUisnGbX9eq6UHrpBovt78PAdZKtud0fjPZzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OaAyXkKQDVaRqOtox0bAyPP7k4UrH5HsY8Ra0sVkUlpLe1/FsofiFRKQVo3PfP6iu
	 uH8O+RlK/jDvUm1z3UespIMOj/0uC1AipSpHOg0x3QxJZriOfJQDIqJ1aP1Md1MxUu
	 nUADCDXu1wqdRh8noXbrTNk9ocHQs/u4Fa7wcbC/UoqrTBmxBUI4MdNf0yTNsUUzkH
	 Vyqu53OAuR1oVoHYkdE/YyTTNuHsELEAE/vu+Fc0dVvu4QCRIKsBdwAH9wdknibOvq
	 8i8KUGsZwMTP7WM7m4m4mZWMbVPYrGsQf1+rKUU363gJucg6haAJ9UlaqyagneLu/n
	 WqP9r1+9aheaQ==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f1e5d7450so29537985a.2
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 19:22:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwx4Hd3WQzv48C9Us/Yj3YWlXqyjk6pXntxymgnHXO+7q4GUzQVQ3yxK8ArG3xdKTIQMBA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TEq5bZVRZPfadmbaMtHrXNlBux2WOVuxLS5LDMbO+yL9R7Gda
	pEvGbFLiSd92xdKyi5ivN6Z2LxmVGbYDndRaUBYJ526hazA9ouYYUkyrSyOCDT5ulxpDl/z33YW
	GJboanXXJyTn4GWmniFfRSz4VasDIBNI=
X-Received: by 2002:a05:620a:6495:b0:93f:571b:c733 with SMTP id
 af79cd13be357-944216f2a98mr2641078985a.13.1793762550012; Tue, 03 Nov 2026
 19:22:30 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103113711.1832834-1-max.kellermann@ionos.com> <20261103113711.1832834-3-max.kellermann@ionos.com>
In-Reply-To: <20261103113711.1832834-3-max.kellermann@ionos.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 4 Nov 2026 11:22:18 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wYYiHvDj4Bqbp_hg1H9-WsZvEBJ9h5eNdX-Kuib_f3DQ@mail.gmail.com>
X-Gm-Features: AclHuK-AvYEfhHjWxuMhWnm_a9S3p2tuGRCOJc6VKi5CiT9DNeNzN9Ic67jOPpM
Message-ID: <CAGsJ_4wYYiHvDj4Bqbp_hg1H9-WsZvEBJ9h5eNdX-Kuib_f3DQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm/vmscan: move code to lru_gen_{add,del}_memcg()
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
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9959ca158ce8..aed56d452881 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4556,6 +4556,29 @@ enum {
>         MEMCG_LRU_YOUNG,
>  };
>
> +static void lru_gen_add_memcg(struct lru_gen_memcg *memcg_lru,
> +                             struct lru_gen_folio *lrugen,
> +                             int gen, int bin, bool at_head)
> +{
> +       struct hlist_nulls_head *head =3D &memcg_lru->fifo[gen][bin];
> +
> +       lockdep_assert_held(&memcg_lru->lock);
> +
> +       if (at_head)
> +               hlist_nulls_add_head_rcu(&lrugen->list, head);
> +       else
> +               hlist_nulls_add_tail_rcu(&lrugen->list, head);

T.J. 's patch[1] has actually removed the needs for hlist_nulls_add_head_rc=
u
and it has been in mm-new branch.

> +}
> +
> +static void lru_gen_del_memcg(struct lru_gen_memcg *memcg_lru,
> +                             struct lru_gen_folio *lrugen,
> +                             int gen)
> +{
> +       lockdep_assert_held(&memcg_lru->lock);
> +
> +       hlist_nulls_del_init_rcu(&lrugen->list);
> +}
> +
>  static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
>  {
>         int seg;
> @@ -4584,12 +4607,9 @@ static void lru_gen_rotate_memcg(struct lruvec *lr=
uvec, int op)
>         WRITE_ONCE(lruvec->lrugen.seg, seg);
>         WRITE_ONCE(lruvec->lrugen.gen, new);
>
> -       hlist_nulls_del_rcu(&lruvec->lrugen.list);
> -
> -       if (op =3D=3D MEMCG_LRU_OLD)
> -               hlist_nulls_add_head_rcu(&lruvec->lrugen.list, &pgdat->me=
mcg_lru.fifo[new][bin]);
> -       else
> -               hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->me=
mcg_lru.fifo[new][bin]);
> +       lru_gen_del_memcg(&pgdat->memcg_lru, &lruvec->lrugen, old);
> +       lru_gen_add_memcg(&pgdat->memcg_lru, &lruvec->lrugen, new, bin,
> +                         op =3D=3D MEMCG_LRU_OLD);

Also, MEMCG_LRU_OLD has been removed as I replied to you in v1[2]

[1]  https://lore.kernel.org/linux-mm/20261028010611.3929937-3-tjmercier@go=
ogle.com/
[2]  https://lore.kernel.org/linux-mm/CAGsJ_4zQh9HrvgaqD32_A=3DbSdqmPqP4oV_=
SxMXMEDBrHe4jjhg@mail.gmail.com/

Best,
Barry
