Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795397760;
	b=p5b8/6+q1clrYJPnpKYfomLJNytwaebaYRosSRTW527Ajf8FcqLcaSbkK5XYfQdg9m8W
	 LHIT3CDLI7USQ6jVpKT/RCHawpnnTZLvT6ZzLKBe3+kVjuf4HNR8gjWIxzSYqS3eU0Vee
	 0AdqWca0+T+2gzHnFSj3h151L5PhhIIweL0Lk9LvOlmwHP0rZSz/0MMvzvavIJPvFIruO
	 GSu47SdKae22QfJJHT2RxDsd91w1/Qi1BzJqq4mMm0qT9ibB5ibdm8qy4h4UTGeBgs4EA
	 GJVNKK18WLhjWLJXrTWpt1FNZrMrudXkNpeASRBs05YRE6HF3Yy6SoO79HIJZ34q6kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397760;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LtCu/Lv31KKfbMFIllslMcSrDnoqZxMzFxkbUKmBWlg=;
	b=L0zWvcHyLCyNfwadF+goYfq5RAT9cOvDJhpXfZ8EkLcXNcBYUtru4VA4UWOA0xU8sL/9
	 NEPfejrpRgqFj1hX2x7JDk4aIKiE39qdU8wFHy4Be84NkCywhYAkh6DYFWxFwWAg/JOEy
	 2RNKxhE1u4Fi9eMq529ScQL+KnMUoQEsS8xjQkdgxcYSNicEzdcuLi/QWJ+iYd6Y6aFc/
	 BbzXFcOKKDqn0DEt2lIYoV/mxXJPJDpfDe66AatiCTKwyVbCM9091Gmb7BPedHcQ0qozc
	 1Mgs7AhyN6rc5lCykYTGKs1aFQuxAKvQvVBpy1yEh44tj4fOKFu30X4W9sX4qABLAMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDlnfJv+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8862606A31A
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDlnfJv+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E591F000E0
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 01:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795397760;
	bh=LtCu/Lv31KKfbMFIllslMcSrDnoqZxMzFxkbUKmBWlg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iDlnfJv+Z9rSHd8GLoqfvgkwVTlx53iufTvvD1pHLs2ng42geuqVkxpT5Kp/tTTyW
	 RjkgvdXFDsSSJmhS2ex1j6QN7ONvTnCDL89BErBSWbjAQC9rv8K8NrJSVsPzJjlXUa
	 RjvNPgluwksPzX6TdJn4l0n8C9SiGmDURxp70FErfFfuemISKxPM44v1qiCw7FjTV8
	 LlHrqbsHm9giby2oFgQWfzrvSNwHapobAr/VMZCjswN/qW1SgGWJ0lL940f1NjeLUG
	 QqGMoA6q2RTOimIGb9AczqNtGeY26CzsI5mAw0i+vrZ3RoZeICd8bSIt/GA1Y8XVqa
	 4EHLsvPoaZltQ==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-94962d80d34so172748885a.2
        for <rcu@vger.kernel.org>; Sun, 22 Nov 2026 17:36:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEax+K6rQ+pGs9yWu4sRAN3q/upwTkA5u+eERMXpZ/qmLUVEkfelDXLbwi9oJ/irDFvzd8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ru404HD+ytlR2Mk5o4Fky/uiUKg8aMGMYi3e/ZjnL+/c2dE1b
	HY3F6/SyFxvfy0sL2Y1WzSB5W45NbRTz9xIHoSeFHEeio0GYvWR1W6e2RoYaHP2tAuV4Xm8N1Rt
	BsYzdPARsF30Erdxg8aU+Mbu9/4wqBYk=
X-Received: by 2002:a05:620a:838a:b0:949:3521:b627 with SMTP id
 af79cd13be357-949ba9ff2b7mr1644030785a.38.1795397759398; Sun, 22 Nov 2026
 17:35:59 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116081403.216452-1-max.kellermann@ionos.com> <20261116081403.216452-3-max.kellermann@ionos.com>
In-Reply-To: <20261116081403.216452-3-max.kellermann@ionos.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 23 Nov 2026 09:35:47 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wit5jKGn4L-NDTqzxDRNS8s8-FV3g0m5e6BOcG2Gx2Eg@mail.gmail.com>
X-Gm-Features: Aa3M54oWK8aP7uwb_r3XD3rWcrMQ-9dwA-s2hQH_XdkfS1nJ0lq-9viUM0tfLcs
Message-ID: <CAGsJ_4wit5jKGn4L-NDTqzxDRNS8s8-FV3g0m5e6BOcG2Gx2Eg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm/vmscan: move code to lru_gen_{add,del}_memcg()
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
> Preparation for the following patch that adds tail caching.
>
> For simplicity, hlist_nulls_del_init_rcu() is now always used, which
> is also valid during rotation, because the entry is immediately
> reinserted under `memcg_lru.lock`.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Reviewed-by: Barry Song <baohua@kernel.org>
