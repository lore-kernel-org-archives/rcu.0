Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440441;
	b=yyclAhbZCJwE2+NBhdjLwY7qLLdiYWLJlnC95MZs4emVxfmN8GIQgmWC4Fq8oMZC0dm5
	 zxNKeMik9+ZKaftbyM0d0vjeCEthX9x+vHaYrsgIRdbQMhItb4bTu3gzcwnv6PLj13Qf8
	 YrGPRTZKyZn9ZbS2QpwCZox9r81KMefea3LrN3Vl+iwk0iM/VV98hQBzuqt7iO+99mTYo
	 DVmIT4AVZLZM2GXr5ljUEycTCoPtGnnbQT/L0Y/fAsitwp6HWxiHAHQmrWqvpNkzzzcSt
	 74gV/FffszdM0x/aac9IG4GR/LHQDlHO+SfMjyjpzdA5YbKrvHeKhT/pDDLC+zp3JjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440441;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HJWW3lAYD4SS32dHbc78BmhWsFKqKKOPG4WVSgqL+ZE=;
	b=QHUq26UXfltlYfcwsECCOMzhx1KmQX4EGVxiehtgpf74m+thvOe25EYcih9wFodOy2rr
	 EQDpxPbtF75gSG1PGKXTUAzLEGHlu1Xpp58FBM+5XWp3hBqC6tK1DA3+Rg0TCOjG4eh6j
	 jAC/RQh/lzEQw+2Ngy0HfbGchqrtI0fJi7ml6lkG/CzNg9qS08rMsFfTUXA2rQsYNJMNP
	 tAuq4rBqxQOOBynBqhPUWvupAMFRT/Gb/t1h7Ws5zouvMj5pEKdI+YxTdjn14pC6enl7r
	 E9RWuM3Cmo5R2UeJF4iepMf4bXd6WVMTKoxEHUGVTsvRb+cJ2v0zgX0bYbCMmt4oy2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VhAuS/1v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911A606A321
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhAuS/1v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79EA1F00A00
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440440;
	bh=HJWW3lAYD4SS32dHbc78BmhWsFKqKKOPG4WVSgqL+ZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VhAuS/1vfW959+qJtrgNkgsp9BQcjJ89ZYVRqF9lApBNYmRhuL1jCe/hQIJS5a0A9
	 GUvRbCFV5jCYPWhITNYsRb0hDaVRh2HI/zspmCyG0VPj7XNguNNlfJTvH0XzOH7UEG
	 BF82WauajIjmSlowZTIpfzv/tq1fCIdVNMavzRR7Yvsnku/5pj1grRKShsY944tZqX
	 nzLvcA2wtkrxzNc5BhUyE4BaWOHGybHQdoD9QO0gC4PuWkFoAHBhXxhuKwd9c9BKwh
	 Xfx0AA9pcn0cvfhU1SEo5z4KHHNUEa6S0eR3NGJPLo8oTih+RDbYCUqVMIl7LRNU1x
	 i4C6uVAqqWqWA==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-94961bfe1a0so220518485a.3
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 05:27:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHjkoHftgv4cC/neb2DR8/JDLRL3Q0Ms0Oo7xwFrE17kejrQz9KplCoz3NiC/zilgNef2U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BPxZTGVl0oc3yDYgkvD0uxyMblQUz56l03xLiTeCFASFHGuXb
	VuXft17bHhrNLvIIfN5irSyBFfIf2hCXPG0hAqPNiHmChjgqzjQqUoqHfDe1DQyRmtlxdXjjd+0
	jVKC+wYxlXV849qWurcCU6Ppe/fXvV14=
X-Received: by 2002:a05:620a:31aa:b0:949:3066:5551 with SMTP id
 af79cd13be357-949bac80948mr1952036985a.79.1795440439933; Mon, 23 Nov 2026
 05:27:19 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116081403.216452-1-max.kellermann@ionos.com>
 <20261116081403.216452-5-max.kellermann@ionos.com> <CAGsJ_4w3cP+tgCGhTFu5p27Wi-9AFCneQgwLUAUg7X-gvX=e4Q@mail.gmail.com>
 <CAKPOu+-Pzp-ovWNq394yBD0Qa5zCLZjx=sE3ixLs+WLf4EgZBw@mail.gmail.com>
In-Reply-To: <CAKPOu+-Pzp-ovWNq394yBD0Qa5zCLZjx=sE3ixLs+WLf4EgZBw@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 23 Nov 2026 21:27:07 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yV=RvOMqpmaxFJGeBorPm-mz1VGoTb7_dLs-4pvrD56A@mail.gmail.com>
X-Gm-Features: Aa3M54pg3_5VxI8d6rS-DICxqkbqp2A05_T4kaagAVAVzN0pAmcXIWNuJR8gCys
Message-ID: <CAGsJ_4yV=RvOMqpmaxFJGeBorPm-mz1VGoTb7_dLs-4pvrD56A@mail.gmail.com>
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

On Mon, Nov 23, 2026 at 9:13=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Mon, Nov 23, 2026 at 3:01=E2=80=AFAM Barry Song <baohua@kernel.org> wr=
ote:
> > I know it was my suggestion to avoid unnecessary calls to
> > get_random_u32_below() unless we actually need them.
> >
> > You then pointed out that this would move get_random_u32_below()
> > inside the spinlock, which I had overlooked. Sorry about that.
> >
> > Have you tested whether calling get_random_u32_below() under the
> > spinlock increases lock contention?
>
> Yes, indeed it makes a big difference.
>
> My initial version which always called get_random_u32_below() at the
> beginning of lru_gen_rotate_memcg(), prior to locking
> pgdat->memcg_lru.lock (but some of these "bin" values would never be
> used with this patch):
>
>                   &pgdat->memcg_lru.lock:     103487653      103501074
>           0.06         301.90   195317628.84           1.89
> 113777275      116290184           0.04         339.54    30052760.20
>          0.26
>
>  Completed: 681 (success: 1, EAGAIN: 680, errors: 0)
>  Elapsed: 61.23 s; requests/s: 11.12
>  Latency: mean 713.05 ms; max 7470.24 ms
>
> With the get_random_u32_below() call moved inside the lock, however
> only called when it's really needed:
>
>                   &pgdat->memcg_lru.lock:      99442644       99458122
>           0.05         342.95   243043664.06           2.44
> 102985677      104642320           0.05         231.58    34095676.89
>          0.33
>
>  Completed: 548 (success: 0, EAGAIN: 548, errors: 0)
>  Elapsed: 60.66 s; requests/s: 9.03
>  Latency: mean 880.18 ms; max 3847.24 ms
>
> I did a few runs, and while there was a lot of noise, but the
> difference is real and reproducible.  Surprises me, I wouldn't have
> thought this would be measurable.
>
> I guess I'll move the call back out of the lock section?
>

Thanks for testing, Max!

Yes, I agree. Let's move it back outside the lock, even if that
means doing some redundant work. The cost of increased lock
contention is much higher.

Thanks,
Barry
