Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979312B94
	for <rcu@vger.kernel.org>; Mon, 24 Feb 2025 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740372565; cv=none; b=UvKzrc+YREztlfMN1apNrV/M0vMfEOGczK427qRxA49gQqVR6VCqyUZNYrS+99qO9Jtji7Yp121qw4Rr1Jxl11h8DFy+fq5QkLFgopCsrziXixeZ0gm8FpYzuU9+IQ80pb4shbdIVbNllssqBP8R3twLq8nq26HHxzh9kf2tAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740372565; c=relaxed/simple;
	bh=m+ya0m48Hy05uufbgBSlRUASp/gEt5wNCSXXagY3Veo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfDO4XNVmfEkdgNKB5Vk+kdgU1v1paZ0k5QmHFzPJLBivK3/WmsLbSu6Qd/EwMikaJktcnMRbHSnbawu+2v1wqaeJdwni2GOiB8TX4ko0p9TvjLMuznM6a+YHgMB3jOV/mxxnlhMJ7S5LGhWUo3FM2zlSqWggBkVauYD419DK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNr66Qvo; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNr66Qvo"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e67bc04a3bso45560956d6.3
        for <rcu@vger.kernel.org>; Sun, 23 Feb 2025 20:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740372562; x=1740977362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZytZEk8JtOudqPt3UiEgxftAzf8RUB8NEf9J511wOpk=;
        b=QNr66Qvooh9BnEzaIgKsoFNb19Dv5ldlStapOifOXVxQXASZs8UMOgX59b0ELA120v
         m5jiQoECR7nDYEVEu9WpyGjwkdL5TBJ+x0Hz/Ho0htmbbHPRJGgEL7JAyIRDDZv1D8xh
         wu9l33czgf/r0nc86kjBBjZJbvyYFPjlTVBf7f5uQyatmiq+9SJZ2Pr2J1yyzTnY8WCb
         bK7hYT6THVwkuRyKDOfFIL67AoOl9JvdisUhFBNOESfNSqY7HAsHaixBUZemptTqM+rO
         g4apzvNx0hNSzzVvtGCXMKKceFUuYEZJRQK2M3Gch7mknt9Ga7dsDEaHGpZnwqEnEzFP
         NIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740372562; x=1740977362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZytZEk8JtOudqPt3UiEgxftAzf8RUB8NEf9J511wOpk=;
        b=ZsuwFzo+Cu+zPewihq/GTgM+fiUe4dFXtkVPkc6S5IeQiHSElpJoEhi/98G2tuUP0y
         +VltiyUE8UlrRI+4Rlp7+20H2abu+uQUHV5Bk1x9mQQa3/0l8gnaflcsfeR9ul+Sm5Jj
         p3bTFaANzCeDrBLbdPmTxbaWoWCqV6PM7dpDzGnxvVlcERgeiM4HSGOZ9DHXoU+V7Qlt
         wj/gGTL3wKuyJi3K2yKhUH7grZkozYzVgD1SU48K0lSdywG3ceF5mNm0w9ysT+e4P8HT
         6IKkEgd3kzsfRGxeeC6raBhbkwjqMgkUq6YeVmCT+yDCziQceg3vo6VqtBaU91ujBZOI
         hT9w==
X-Forwarded-Encrypted: i=1; AJvYcCXmN340a/xPzHTx+FM48v7bNxTswgG0HbuXV5mJ79WN3ymUWzQERyyR8Hlqbg1hgTy2KQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7LL8HD8Vj7iTJC39qNRalnUth91k5n/YyY7uqEAE6wng/gyu
	PTYlkQY+aw9U5U48OuXnQ/LUTvOmI1HISESgQHSX89SifdBDs4BF
X-Gm-Gg: ASbGncsZCsxhSDrgMz24uuu/qyT7bdB5lPC50mWQY2+5zugW1tI6vZKFdD2nqv/4XfY
	F0VHYM7QREsTVgJQznQLpz+qyyHUFNcBHwQFTMz1lw6Cd/uzRdERCeSZEY059vbezgQKoYd9fC4
	GkV0/Ef8XHSVGyhPNQTRwSW5ZS2BTRwf9EsZPzxpE2xS7HAy46a7OxeWfLMjHlgtGZSSaCnQOhW
	3m5EENADI/3GBv2mUAEfQnmpkAnbEQC9YoUYmgYumfQJym3b9O8W+DAzM5o1+DB31TNzvNpiAKN
	HWsF/S+IokJtB6U2EJcX40G0cFueoGrKv+3V9QG1DBqloec4TbBwz6aW12iPMF9DAzdc+Kj499G
	JBhPi67iOSiDgbmyO
X-Google-Smtp-Source: AGHT+IGjls3lBddW8jue9cvVaCf9vRvupnJQ9GTSqDJC38TUqs63gYmU+yWxY3XU8XZjabI9hBLEsA==
X-Received: by 2002:a05:6214:c88:b0:6e4:9b59:d9ce with SMTP id 6a1803df08f44-6e6ae7c6e0fmr154787516d6.5.1740372562507;
        Sun, 23 Feb 2025 20:49:22 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d779446sm129229726d6.1.2025.02.23.20.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 20:49:22 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id A1E7E120006A;
	Sun, 23 Feb 2025 23:49:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 23 Feb 2025 23:49:21 -0500
X-ME-Sender: <xms:Ufq7ZxZT6_hf1f2H2yHrUk1Kn9v2kMHXnMpI_IipPkCQZWg9iAJSoQ>
    <xme:Ufq7Z4ZAFl0h1bkcH-VTPTHme6J1bPJmIDNSVldwECeI6yA-K5hA0ayh3y8uIfSDY
    xFQIqqQ-VcnEuDkyA>
X-ME-Received: <xmr:Ufq7Zz81WkcjWPTOSd5JBfGIT6AYBoMU0geSsm_khJaT8rES6Wd0yvPX8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepohhlihhvvghrrdhsrghnghesihhnthgvlh
    drtghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrnhhkuhhrrdgrrdgrrhhorhgrsehorhgrtghlvgdrtghomhdprhgtphhtthhope
    hovgdqlhhkpheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlkhhpsehi
    nhhtvghlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlrghgnh
    gvlhhfsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:Ufq7Z_qxNmoTRj4Q0TZvqePNINaIkNDHi0eGkRoK4UwsdyKNuhf9DA>
    <xmx:Ufq7Z8on7Hd1kh2H6PvfCIwOZqKEEC18qhKG7kcyE0FSSWXhJwmxvQ>
    <xmx:Ufq7Z1QJa5ZrDDtygzpj6hLYZsHH-mOjBHi0mAqyEdD77gZWsyJGOw>
    <xmx:Ufq7Z0oCAhqgf3oCNiMW1yKnk32g-VStHTTKo1d6L0bzW8Rm3j2mqg>
    <xmx:Ufq7Z15C0jGZqqjTMzQ-yvUwZA6k-w-d0fueUuQfQ7pC1EjlQGDCbSeF>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 23:49:21 -0500 (EST)
Date: Sun, 23 Feb 2025 20:49:20 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v2 2/2] rcutorture: Update ->extendables check for lazy
 preemption
Message-ID: <Z7v6UD8SeXPoTkXG@Mac.home>
References: <Z7v4MytjhhBZkG4S@Mac.home>
 <20250224044310.14373-1-boqun.feng@gmail.com>
 <20250224044310.14373-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224044310.14373-2-boqun.feng@gmail.com>

[Cc Joel]

On Sun, Feb 23, 2025 at 08:43:10PM -0800, Boqun Feng wrote:
> The rcutorture_one_extend_check() function's second last check assumes
> that "preempt_count() & PREEMPT_MASK" is non-zero only if
> RCUTORTURE_RDR_PREEMPT or RCUTORTURE_RDR_SCHED bit is set.
> 
> This works for preemptible RCU and for non-preemptible RCU running in
> a non-preemptible kernel.  But it fails for non-preemptible RCU running
> in a preemptible kernel because then rcu_read_lock() is just
> preempt_disable(), which increases preempt count.
> 
> This commit therefore adjusts this check to take into account the case
> fo non-preemptible RCU running in a preemptible kernel.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  kernel/rcu/rcutorture.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 280bff706017..4cae119dece8 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1901,8 +1901,16 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
>  	WARN_ONCE(cur_ops->extendables &&
>  		  !(curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
>  		  (preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
> -	WARN_ONCE(cur_ops->extendables &&
> -		  !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
> +
> +	/*
> +	 * non-preemptible RCU in a preemptible kernel uses preempt_disable()
> +	 * as rcu_read_lock().
> +	 */
> +	mask = RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> +		mask |= RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
> +
> +	WARN_ONCE(cur_ops->extendables && !(curstate & mask) &&
>  		  (preempt_count() & PREEMPT_MASK), ROEC_ARGS);
>  
>  	/*
> -- 
> 2.39.5 (Apple Git-154)
> 
> 
