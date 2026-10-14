Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FE37A848
	for <rcu@vger.kernel.org>; Wed, 14 Oct 2026 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953215; cv=none; b=ESPUTFsHJi3TDzbyZefoHuWjk8PCyQA+9HpaBKK93xc4CR56FXwIDgJmuSQ+nscVYyL0Vvu94lm+dVA3S4WW9S8wR8x1v3vtlOgQJjYyOD7bMt4GsU6RzWkvptyJ9cva4PfINoelV06vWNqlZ3G66NAAQA+lm/bZVQ4Ia1UovW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953215; c=relaxed/simple;
	bh=YdcDYQHnvG8d50ez60dcr6M46F9miUwHHwv/BLN639I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2N8pN+iy90u6sWGhpCN/z1Y2MCUaRKzkFxefpHndS0S+T6pDKY8lSJFflKleKYDaFOzvKQdb7IExu1Ym/ydYYXZS18/B61G1i2oel4W8pqA4kfJ+3kU4Lsdt6dZi+ZVEW4RNckIo45X8Ng1Cg4imM3Gdj8eHLYVp9gxWrCeVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ynn2eBTU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ynn2eBTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175741F0089E
	for <rcu@vger.kernel.org>; Wed, 14 Oct 2026 04:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791953214;
	bh=GOBAAntqs+1udpw3fkkHGyAvF+q+wF+2NHy3MJ/XtcE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ynn2eBTUc3w60hIV2e288f6OYMHEdO4qJI26rrf1lVAyKpxPGrnZc9kownP87KKEQ
	 IKXLYw2lhm+Zz71F6eJlpA8jpO3TpRM0TOy2uPC0cbVt5CkQNuCG0p1g+BXPq2y69y
	 n0ODVYMgK27HfizdR5eHGEpwpba/qsVKtsQPhsWVqr/jmjfssBYWqtCKElsXthRTqm
	 /4GKAluI8u73xS2JfxrGL+x/rrHH7zE04N/qRwfxqlMY1Yw3xs6kDMX1MUk8opBGt/
	 qvA7JKnLRpEoQ2BI7MwlYGVwy6Otke0zyYx4dv3UNgctuvPafrPLXnhjmC0VisP06z
	 OXyI54Vx0BOaQ==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93cb9e9405fso192507585a.2
        for <rcu@vger.kernel.org>; Tue, 13 Oct 2026 21:46:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByvysPEc7YaCjk0j+iY7IboJ4yG5FfrOwRF6vfox8rXFOqLY1ayrrqWkAF/WoZtxrdJNVI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpY2sAZeVA+4U1sZvPLxMl4o2PhrZRFWsRf09G9tBZvjX13fsq
	esu4SNB1BdQZ/fhKZR6WuHq8ZjM1xFD7nMSwyyYTG/bsg1qfwyG4/wOZkqwelZE2hVvtRcFIUZ2
	VrpqDStlaauYJyVFDrsA9IKcUlnyk/pY=
X-Received: by 2002:a05:620a:370c:b0:93e:7944:b874 with SMTP id
 af79cd13be357-93ebd244676mr2342724585a.33.1791953213386; Tue, 13 Oct 2026
 21:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012205447.2717801-1-max.kellermann@ionos.com>
 <20261012205447.2717801-4-max.kellermann@ionos.com> <a64f6a98-de70-4004-aac0-312cb05aaf92@linux.dev>
 <CAKPOu+83bH2CRtiAio+1VTTQrYFF9th5XfG5wL45ujEavPS3Dg@mail.gmail.com>
In-Reply-To: <CAKPOu+83bH2CRtiAio+1VTTQrYFF9th5XfG5wL45ujEavPS3Dg@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 14 Oct 2026 12:46:42 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y_c3TZb5=rNK-sQ5bJWozL42bGo_zgvAtY6hW5eoMcmQ@mail.gmail.com>
X-Gm-Features: AclHuK_pOHHzKZZH_dTCG6g8kkCM2rEF8JtYxcMjCWMOy51d0raKwsKHCVbMgDI
Message-ID: <CAGsJ_4y_c3TZb5=rNK-sQ5bJWozL42bGo_zgvAtY6hW5eoMcmQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm/mglru: cache the last memcg node, make tail
 insertion constant time
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Ridong Chen <ridong.chen@linux.dev>, akpm@linux-foundation.org, kasong@tencent.com, 
	qi.zheng@linux.dev, shakeel.butt@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev, 
	baolin.wang@linux.alibaba.com, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:58=E2=80=AFAM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> On Wed, Oct 14, 2026 at 5:31=E2=80=AFAM Ridong Chen <ridong.chen@linux.de=
v> wrote:
> > I've also submitted an RFC patch that addresses this issue.
>
> Oh, interesting!  I did not know but your patch, but it looks very
> similar to mine (but without the hlist_nulls refactoring so yours
> comes with some code duplicating the hlist_nulls header).
>
> Too bad your RFC went nowhere, that would have saved us from a
> production incident...  Anyway, even if neither gets merged, I'll keep
> my patches on our internal kernel fork, because they do help a lot
> with our workload.

Hi Max, Ridong,

Let me discuss this with you and Ridong, run some tests, and get back
to you. I'd be very interested in getting this optimization upstream.
I'm also happy to discuss it with Ridong privately, as that's easier
for me.

Best Regards
Barry
