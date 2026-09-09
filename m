Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B5320393
	for <rcu@vger.kernel.org>; Wed,  9 Sep 2026 03:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924957; cv=none; b=rhix7lb9Fbdju6CTlUOUndiil8NfBis753ktuLG29xTmFpoEco01UFSF1RiHxO05VFWpz4dXpbYSNUoAHcUfvsoI7rbkKgKKmmCCLt7q8avhuF3URMP91obgnWeGV6yyOyop+j82Toslr51f+NO/8IJyQEJWeFgZJ7GkRMyIAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924957; c=relaxed/simple;
	bh=qgpnyyF/4Gf5v/qT00wUMXsFVueOpzRVzIQ/M7FjTSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/KDRIUku6H44OOShTwUI3PRA34hpjAPUKouwj8s3+LRt9jPTBO58ABPeoYxWhimhdH69EKL9YxddZjIuwxeGU4bafwF2multxXRlDd46TFmoMOeo3pSbvNYNl3RgVezT7s37/HxCfykD0R8X4n5t4QOwIMx7p5XY8QKKEnzYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TohjZNi6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TohjZNi6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso46765795ad.3
        for <rcu@vger.kernel.org>; Tue, 08 Sep 2026 20:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788924956; x=1789529756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oYrPFDc8VCXN4ipBSlQL/si5rs5sJ/hlXymUwQCTqLY=;
        b=TohjZNi6aPhWZ+UrA/Y69gQac5x7gLlXQA9i9REcZZcO8hozcdcvbmoVbwdfJNu6ex
         5pA7p+v7JJi8dcYH3ol0ulMmPq9dCPGe40MH/WAp0HU5fnMrAGlwIV5iV0oIYz7nmJiO
         AaQOdfnpqyKqEYJ2vZ/4JMvbe1J1pnw7MynQmN1EVr/Hc1gwdmPp5ICd7XnDAa6M+Cd7
         Ajcz7Y7gJMZx+fAEwMj8GD1CjuRtXRT0Ndi885NDKt2Z9oJSMy4+8A7TnMDEqoCAxWPt
         UqXrEQX7nugCuaofZA1v36tCfke+ck3XgbQa4JSRNXvuNnaVaPQX5UnxlFkGdphR5SVd
         SDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788924956; x=1789529756;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oYrPFDc8VCXN4ipBSlQL/si5rs5sJ/hlXymUwQCTqLY=;
        b=H3hDsIXl4ezA20eaXfdqw4X1tHFLoXDr6vEifKcv8w+xrOvEIZkujMuIMiK4y6Ek2l
         97XSVkAAtgf8HNjoCg9iQg/z8ktiNFgKZRpO3f+1xabY07Z1cx2LXN4QOODRat4GLZtU
         OMt8EHbmaZUVG/G4Mr3cBRI4Ic0qhbRyEUTevi78awA8tP7LJWhhcIRI8BPI1IoJfzaB
         kqqSrMevuQonCzQcoCbqMtNV6S64v6E+LWU9KNa6KDe/Ao87qdWVJlO+YnwzLdgJspQL
         lE5O2GSYO/jsTPOiUZiZ/d6JO8N2sZwqjzBAbKKnSPb3bkPBlO/X9hq3FzHBM466qM7S
         AK5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzhtfzPfjTLkUNsZltJkwNuvAjaq9B/JM/vO4WGWRycNExsjFRg3pqzEHZHoWIHvB5QE2M=@vger.kernel.org
X-Gm-Message-State: AFuF++nGnnLRS5+XKo/wGAhAJnwlO/ZfsLWt2Fj33UDEzzjtLoWTAZyj
	XeR/MBTY947e1gw5x3OfdrsCCi6+nWQSPulCgr4TF8OtK+poLRNPbvlKdTwDpGnfq9U=
X-Gm-Gg: AYBFou2q3kCCPZcQTlA6v2uxL9z9ZZjcX/ksjPwTgiw1wmoaSHSFY1CDefhw2iAbeVz
	XzUXzawrj9ImYCry1iuzOMes/PiAKbCgj5mBISbFgdZCq/3ud22c0Vj3UK5IJq9IYetUTBSZ3LY
	UqiiTmsS6QIlW6Iod15QXhMfNfC4zLlJ/jUIG13hm5Sq/GqCN2ywTPyz9VKNJqQMBvy7SkRHL9u
	6mVlLAMExaG59jDRUkirGVS2quTaFZVUpn2i9cZnJw/gcwLtW5wDu1aDPzPJP5qTOdvHQtO+baR
	Fx9mLKQVHK963YZf1eNKCDWUbqYU60ioOuNmmKUnPu4Ad378yOtdz6LJ1J7kXnW/teB6/OpPWc8
	JainLFTCd3VHQ1WcVjB5+dcX+bn1+/G2EeSH6AWIT4iXSbBKmwmAV+DC1NplA8GEjvlN0tAj51J
	c2+ZzYqlKounDrYnJ4K5EWKqcGFLFG+bcPP5PUJZmR5RxEI4Nu4hlbarstSMhjOWs0pqrbvg==
X-Received: by 2002:a17:90b:2d0b:b0:398:c794:ca26 with SMTP id 98e67ed59e1d1-39b263167f7mr47665056a91.25.1788924955272;
        Tue, 08 Sep 2026 20:35:55 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ba0a7b2c3sm5291085a91.0.2026.09.08.20.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 20:35:54 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	paulmck@kernel.org,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] srcutree: Add reader-free fastpath to synchronize_srcu_atomic()
Date: Wed,  9 Sep 2026 11:35:45 +0800
Message-ID: <20260909033546.2432205-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0d4af6318ac67486858be1df8d436147b444a2d2.camel@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 23:26:06 +0100 David Woodhouse <dwmw2@infradead.org> wrote:

> On Tue, 2026-09-08 at 13:29 -0700, Paul E. McKenney wrote:
> > On Mon, Sep 07, 2026 at 03:58:19PM +0800, Kunwu Chan wrote:
> > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > 
> > > synchronize_srcu_atomic() is restricted to srcu_read_lock_atomic() and
> > > srcu_read_unlock_atomic(), whose read-side critical sections disable
> > > preemption.  In the common case where there are no readers at all, the
> > > grace period therefore need not do the index flip.  Add a fastpath
> > > that sums both ranks of the per-CPU ->srcu_ctrs[] counters and, if the
> > > lock counts match the unlock counts on both ranks, ends the grace
> > > period immediately, skipping the srcu_advance_state() scans, mirroring
> > > the similar Tiny SRCU fastpath.
> > > 
> > > Correctness requires the counter-sum proof to follow the grace-period
> > > anchor written by srcu_gp_start(); placing it before the anchor could
> > > let this grace period miss a pre-existing reader and return without
> > > waiting for it.  The smp_mb() between the unlock and lock sums pairs
> > > with the smp_mb() in __srcu_read_lock().  The grace period is ended
> > > manually under ->lock and ->srcu_atomic_gp_flag.
> > > 
> > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > 
> > Adding David Woodhouse on CC.
> > 
> > David, does this provide appropriate performance in your use case?
> 
> Compared with the early bail that I had before, there's a *slight*
> shift into the higher-latency buckets as expected, but definitely not
> enough that I care. We're doing this whole thing to eliminate the
> multi-millisecond p100 latencies that happen when we invoke the
> workqueue, and the differences we're looking at in the table below are
> *well* below what we care about:
> 
> 
>   ┌─────────────┬───────────────────┬───────────────────┬───────┐
>   │   bucket    │  try-first (#10)  │    Kunwu (#11)    │   Δ   │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [0,1µs)     │ 5,338,474 (60.8%) │ 4,953,657 (56.8%) │ −7%   │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [1,2)       │ 1,077,998         │ 1,087,133         │ ≈     │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [2,4)       │ 803,244           │ 790,489           │ ≈     │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [4,8)       │ 811,708           │ 880,673           │ +8%   │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [8,16)      │ 366,183           │ 597,443           │ +63%  │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [16,32)     │ 338,731           │ 361,243           │ +7%   │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [32,64)     │ 14,290            │ 28,823            │ ×2.0  │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [64,128)    │ 2,549             │ 3,655             │ +43%  │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [128,256)   │ 555               │ 783               │ +41%  │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [256,512)   │ 456               │ 625               │ +37%  │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [512µs+)    │ 13                │ 8                 │ ≈     │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ max         │ 1.07ms            │ 1.56ms            │ +46%  │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ total walks │ 8,777,514         │ 8,723,453         │ −0.6% │
>   └─────────────┴───────────────────┴───────────────────┴───────┘
> 
>   (192-CPU PREEMPT_RT host, 12 concurrent gfn_to_pfn_cache invalidation
>   reproducers, 300-second windows; each "walk" is one invalidation drain
>   which includes the synchronize_srcu_atomic() call. #10/#11 are just
>   local build numbers.)
> 

Thanks, David, for testing this with your KVM workload and confirming 
the current approach works well.

I’ll keep looking into the fastpath for synchronize_srcu_expedited() 
as well, while preserving the existing SRCU semantics.

Thanks,
KunWu

