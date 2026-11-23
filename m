Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795400679;
	b=fQw4g/3DBA5LMsZEM+e7H3jfVH3sPWmmg54kB0s5lhdqQLZJ0YmyDzTtKsTJXp66u4oi
	 +0ccmPVFS38IdvX32XbS/ovlNLPPNdF+zic4k/tp8yzReRdmTufM3oVw8H4wDNHL1VHpn
	 H7bpobNQMqSFEmcQChNsxrTGqr9FlrRym/8ij8YuTugraknSRm8XdFhAzaeA8MyrW341F
	 DoVqEYmOg4nB41p0WYkyOyq2656JeSMvZ4qtMjWSAzpDaBWEWp8jct13KaMuyD0IkphVI
	 wj+sRnLq8cSYnNqtGvgub1piQ15nResa5IjSeG4RkZXhwnKxqZDDm7a3pBM46cHHj8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795400679;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=57tb2/Vr7t/oaBgLBwC/I6C/d76kKekhB9lL9K1wXnM=;
	b=TfpL0N18mrlmBImrtpmnoP0mVsJ5MlIOZjWDF670piA7U0Et34FAR/CBFzmM1chScZ63
	 TcBSH3U5HyvEXCEjKw2kEdktUb9B4/qBrlkfT0N+InTIvNHcv2bbH8tB49qGAiTPvRpFp
	 YL9j3UxAoqk9MpESW+8OyUZZ80xdRgqiQPbY/kxpc2eqZWFfpSjHsupMiDw2FPjW6Ccyi
	 3zXXjlNXDIW8+YibT9B2iDFJdvIKaTBERDQGJO5fUYwg9roXFYrzSr4x5a1Eu3sBXOQGZ
	 PDBPecRJC9lNXgGBeOO0e3wYAYOHi4qOmi9s+HdRw6jozevRxjXys+zEK7y+4pPmYZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrzfS8jq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C2606A31A
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 02:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrzfS8jq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0F31F000CA
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 02:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795400678;
	bh=57tb2/Vr7t/oaBgLBwC/I6C/d76kKekhB9lL9K1wXnM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JrzfS8jq/ZdwzK7qWLGEcDSyB9OKqmNuSOS3xhsOwReZb6AV3RVA8NEiI4XXHb5uk
	 NpoLRXLnpKKSNqolb97sUYCWPyyPNs/FQlPVEIYcO6T+VqlKBBFuQIkjeYSA9+r1vd
	 uCx4NNqhngD/6HO7Jn/D7ym2JjRXQp7isD6BxQAAdtgJi4ejsnl8mFUDk7yCOAdJ3r
	 EIbPD3LqkWS8IfS15OBb2Ovqv9N2gDbaEVahpUWO6c8uVwTImsKqh3ujdnaQSUZQRx
	 u6PZFiS2I7H70MAcPkfEoXQjVw9psXSUGizSGzLlqBPXZx7h0YMGMwKCojgAjcQHR0
	 htp2KmbblZ12A==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-930c0f9c1b1so301755885a.1
        for <rcu@vger.kernel.org>; Sun, 22 Nov 2026 18:24:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHdfWY+rYQjX+kaojL7BJtmebfk7sO4xpfI4m6Jv4LQlVWOv95a0e9Dfb6+Plj9SO9QSzQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+idvWr9Why9Z4Hg2ykH52DH66vqw38SUfjcFDfuEbzByyzPcGv
	Ua4ch2bdPS7ScENNkR5WdQoEbwCdYASVU3WSpAeMOaGIHVY/vTU3/MqJU44x6mmW+NMkBgEOObj
	7pIHjrmjkQM6UAnp7KbLzRG74+4UrQqE=
X-Received: by 2002:a05:620a:269b:b0:93f:228c:5301 with SMTP id
 af79cd13be357-949bab678d4mr1820344485a.64.1795400677521; Sun, 22 Nov 2026
 18:24:37 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116081403.216452-1-max.kellermann@ionos.com> <20261116081403.216452-6-max.kellermann@ionos.com>
In-Reply-To: <20261116081403.216452-6-max.kellermann@ionos.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 23 Nov 2026 10:24:24 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y5cEBmdxz91WJqc1WJdHM=8_nMomMDO=D5As2tfnAMbQ@mail.gmail.com>
X-Gm-Features: Aa3M54po4ST5My0w1x9oemNrt7Y_OkpJAd7w1jCl5IIsGSWDYO39vxHRXon-7kE
Message-ID: <CAGsJ_4y5cEBmdxz91WJqc1WJdHM=8_nMomMDO=D5As2tfnAMbQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] mm/mglru: reschedule between memcg reclaim attempts
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
> shrink_one() can return immediately for empty or protected memcgs, and
> try_to_shrink_lruvec() can break out before reaching its
> cond_resched().  A scan through many memcgs can repeatedly rotate
> entries without giving other runnable tasks a scheduling opportunity.
>
> Call cond_resched_tasks_rcu_qs() (as the existing shrink_lruvec() loop
> does) after shrink_one(), while the memcg reference still pins the
> cursor and before reacquiring the RCU read lock.  Also call it between
> bins and nulls-marker retries, covering scans that skip every entry.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
