Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700897;
	b=X85ex9wCsYALGx7CUXgyFsde4qPmjZyDOdD2X9G0JHls5zQKQFu4An7fMoflTJ9V9Hg5
	 8NAVJwEOgTWxYBTnleGBfp2sVYMtlhInD3pkKbRm3Mx5w3lVDN0ZhwjDA0g7Iim9rPYKh
	 A02VWEMirJ38A6gpct57cNX2gAaAlUyhO/8tFNp6KNvn0s2dqS4DAb6j/xFoLQHSR0nqL
	 mFgrhUMIxTSQFEzPpHMqWYzqaM8nA49kh8w6Dexq3O/HbXkMvIt3Fhehzf602jAzWXgY7
	 DQ+ZC4KB2SesiCwAyVzX2EYXUCyif5z/4sqAKPHS2Ibj3CaSPqF5ArtKKnM8tPkMseA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700897;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jqwECtvJ6u0WXCetJHRwIFMx9iKDN0fT5jXgsr5loWQ=;
	b=gRWUZtyh6clyC7R/kQoShSvj/98yxcYVf4CZgbvRUAqWW4b4ros9Uo8RoZSwdFlsWFQ9
	 VoCuYszr19U4u1V61xmSg8EQFS06QliePo7TsoSv26cGDIo1witAF9GpOphW+qg/31h3+
	 H9871XUZ826amYyoaYxUVQ6RGVngmvplVtLJ9IheKt1RRNZTpMzITD9UJc9dB/ycCpx5l
	 FXgZPbvIXPeFzq9You+eWBZsZIN80dX6EI+N7j5314KzreMQO3fN30VqnIPwtcjz+3Rfq
	 o6wrT6qJCXEwDBOJaDhm4fEKRc5p9Tq7E7Um/WK2YEPqz9foZeqzPJf7VTxwS5+SoJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARtF1On4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E260A382A
	for <rcu@vger.kernel.org>; Tue,  3 Nov 2026 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARtF1On4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB571F0157A
	for <rcu@vger.kernel.org>; Tue,  3 Nov 2026 10:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700896;
	bh=jqwECtvJ6u0WXCetJHRwIFMx9iKDN0fT5jXgsr5loWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ARtF1On4Y3++hq+BvsbtHb9HfZ2OJj6B/TvjM1lge8G9PyPscyMjkYiubFnS5tI9S
	 Xr03vbGBjVYXG+7PnPlB62hQRupMEEiHFSXEyfyBPlo+KJyQbj5Z+XtptO8OV1t7xB
	 0qHgmAuRpmxZAC7d/NrggXosVlnpk1fwAhZmo8pqDu5cu0sA1Cj42GM3c/ONn7F7xQ
	 8gMSFdXiGrl1nMPgI0CPsFQLVfK7vc1B4Llq4bTgArgSYDaQOtuPm/jU5brdnN+NU2
	 1rG+zZrVX/XiRfuUYwf9AuAEVYgERIkMruNtEV+UBO/CiMy0J1JFAUcJWz6TzxBQYK
	 c1XEHAhwQDkTA==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91b8306b9f8so69205116d6.3
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 02:14:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByi0C3OucE4Va8oqczMaHxoeIxunl2B1RG5WBkkLS6Vnk2nW2p7rdl7JcYBDMZ/AOzs96s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iEkiRiHTSSQftcosi3DPaurO+pa55EgO05cNIbE1qtfQ2mjAC
	/FfZdl0Ft3nLGAT/1PnCQ2mAfJYnTc7dqrdrxgXbYWJQP9Ek91Y3Yg9aO1WIwIMRPux+vqFX4Sx
	TijKknrkeKsjNqcrFV7Jg5dzVW6zNJ2o=
X-Received: by 2002:a05:620a:8395:b0:93e:ce12:aadd with SMTP id
 af79cd13be357-944217b270bmr1858889885a.58.1793700896121; Tue, 03 Nov 2026
 02:14:56 -0800 (PST)
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
 <20261012205447.2717801-3-max.kellermann@ionos.com> <CAGsJ_4zQh9HrvgaqD32_A=bSdqmPqP4oV_SxMXMEDBrHe4jjhg@mail.gmail.com>
 <CAKPOu+_coR4Z=cbsWOG6zgbSWGvmp4=9=uUphkC3TWTTGn0Pqw@mail.gmail.com>
In-Reply-To: <CAKPOu+_coR4Z=cbsWOG6zgbSWGvmp4=9=uUphkC3TWTTGn0Pqw@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 3 Nov 2026 18:14:45 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zOnfjsM_jR-hdeH4YwqKgRYNwj5pv8sFJz-0sJQqojEg@mail.gmail.com>
X-Gm-Features: AclHuK_R4FODI0ZSMjhFi0nwMKEXiaxVpKfhugt2bmG4DXnFW2ixLEichw0jm98
Message-ID: <CAGsJ_4zOnfjsM_jR-hdeH4YwqKgRYNwj5pv8sFJz-0sJQqojEg@mail.gmail.com>
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

On Mon, Nov 2, 2026 at 4:27=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> On Sun, Nov 1, 2026 at 10:03=E2=80=AFPM Barry Song <baohua@kernel.org> wr=
ote:
> > T.J. series[1] removed MEMCG_LRU_OLD, i guess you will need some rebase=
.
>
> Aye, will do if you decide the series is worth merging.
>

Having to find the TAIL seems quite inefficient.
I don't see why we shouldn't use your approach.

Best,
Barry
