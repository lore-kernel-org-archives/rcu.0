Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582122;
	b=s9nifdqZMr5joxN20Ir+7aEJaTIN8pmOuV5a2XUA5TYIgycspF9gMCnpZ3XMnfU7eZSd
	 qV2JSEtgLnUlppdG1mQSG2zPbmaszMX/aMuzAXH9oTHuo9jmAwCRsIQw32DgMTgaazqvJ
	 FYbdwX/Guvwer5KtXEkKRJBAEgoGZe9olmsYB3lXe1RxUCrotOGjbbwcTROVDS2Q5y7GW
	 /m+ine1ywoas9Wn/3rUnkM/8dB5gXbI0UwSO7ELOJ/8jDfuu3u6wwm0/moTTqldcuJ91E
	 Qc9uCK2cndXho98pf0opo88/+lIAdZRcjKR1p8Pvh9ufj9z52QBv9AxDxl1UvS7bwlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582122;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=c1ydNhXZkrpIcDabsUGByAbljSA1UVTJnknGaWqA0AQ=;
	b=5n0xVXXh0s/6UndRm2ZlL1Go7kaXtvWFuTAT/LLLBKrzrB9Yj8NNnXxVeRCzMXKNzVv2
	 geM8YDFY/nOVNrtq7hkkkUhbRdd8SNhP9PxMXzSJrQkR5dZyRk+TKiczJIjjbdwm2E0tl
	 WZMtzOWFBt0lpq7JKvPnAB9jgN4cFaZLPKzY2RS159CjjAUZqUFvkjAPce0NZE05jq2Nm
	 4Hw5UKNbPgcFhrH1PnHjrEZwli998+zqgcNJ5tq6W7aHZ50ntgOCWz5ptyGlBKUZr7q+Z
	 vSaOWajisAY3lmr2sW2UzmBxBpNLw+QANC+/ErguwM656DtS7gwPx3RTZ2l/sSckh0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iryWmJIG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0784D606A324
	for <rcu@vger.kernel.org>; Mon,  2 Nov 2026 01:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iryWmJIG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910A51F0093A
	for <rcu@vger.kernel.org>; Mon,  2 Nov 2026 01:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793582121;
	bh=c1ydNhXZkrpIcDabsUGByAbljSA1UVTJnknGaWqA0AQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iryWmJIGRW5NS4sFryfzJ4j4sdDUtwitKp/D3zJtiRlmVvaUVim+9Ll8MzJDSJKgQ
	 l1L0z+jki3FUEaJZrc51kek2uw7n8BKlJG4Hi7zmv7LzUE9YhkfrzEMAoLQvXEsGgj
	 2c/nl4rTr4bMzbAh5wprHaqDos0QEcZZJAcVoK86mXwqrua+5g8jQPTdCrL3oIi2uC
	 fkre5HfooVMlenoUWif6nF5bUbJ6pZzzR3IVlmCpksgnuOHhVUuhIxO92ql9CTrAbk
	 nl58p31kTAU9MGwpyhL9WEz+vMYeTktpVB13Rsh9M5H5ZSU1p3Kc+H4BzT0SWIZNsz
	 k1t10Cyc2qExg==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93cc1ab5f6cso305934185a.0
        for <rcu@vger.kernel.org>; Sun, 01 Nov 2026 17:15:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzUvy0p24grlFGsmvH9oMoVG1p+tjDcskloTd6TV3zy0plChRaPRp4WK+9VlysGqvtOMqU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9/qEfLcF2my0aNC0TIEJBRfOC/+yEYUa7y51AtcGPlnbZJ6L1
	/9BBFW293AMHtPpvP/m6fnws5fxXOmBTsHAVNGJjg3jBDYB2qrcp1EIQ62Gnu10nNGwpJAsnF+x
	+J2XMeiZBXdTfPCA+sM984XcHFM82B8s=
X-Received: by 2002:a05:620a:2709:b0:93f:571b:c72c with SMTP id
 af79cd13be357-944216b818bmr1410541785a.46.1793582120965; Sun, 01 Nov 2026
 17:15:20 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012205447.2717801-1-max.kellermann@ionos.com> <20261012205447.2717801-6-max.kellermann@ionos.com>
In-Reply-To: <20261012205447.2717801-6-max.kellermann@ionos.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 2 Nov 2026 09:15:09 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wbQtQ8zfokd44_QM39J_02xDVJoeTK20+jo03_NxAx8Q@mail.gmail.com>
X-Gm-Features: AclHuK9whBgQrct_OeJcyHaK0NXW_FaGiSG_xFHphpXJFrXesDxcsJ6xBdY9ow4
Message-ID: <CAGsJ_4wbQtQ8zfokd44_QM39J_02xDVJoeTK20+jo03_NxAx8Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/mglru: reschedule between memcg reclaim attempts
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
> shrink_one() can return immediately for empty or protected memcgs, and
> try_to_shrink_lruvec() can break out before reaching its
> cond_resched().  A scan through many memcgs can repeatedly rotate
> entries without giving other runnable tasks a scheduling opportunity.
>
> Call cond_resched_tasks_rcu_qs() (as the existing shrink_lruvec() loop
> does) after shrink_one(), while the memcg reference still pins the
> cursor and before reacquiring the RCU read lock.  Also call it between
> bins and nulls-marker retries, covering scans that skip every entry.

I'd appreciate it if you could provide more details in the
changelog. Without this patch, are we seeing an RCU stall,
a soft lockup, or something else, right?

Also, as Andrew asked [1], does this patch alone fix the
problem?

I assume patches 3/5 are needed for the performance
improvement, but patch 5/5 is also needed as a quick fix
for the stalls.

[1] https://lore.kernel.org/linux-mm/20261101135047.61fc3f209b3235ed6fc9618=
3@linux-foundation.org/

>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Best,
Barry
