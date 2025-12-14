Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9EB2CCC0
	for <rcu@vger.kernel.org>; Sun, 14 Dec 2025 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765745356; cv=none; b=UieaZyjOH7lVI3GUW6ZQoeYFS+X0Wu31Ki8ysFtL5Zom5W7apX/pygXkZky/UY6fvHFYMCAd946OGAFFZirSXiJ4FiEjIID0HhoBc/Sm+25ONy+RXWK8m1qOcHv0jN9CDHh82jqIuNzr6AoaLQJoVmkc5EUChN4qCsr+v9vlMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765745356; c=relaxed/simple;
	bh=qt6i46a5nmXswLTj33rD2kNCeFJuIdGqSvEOX3Eq1SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLXrnswVZFJ9YGACn4sTkLefzQTpJ3ltjfI0FbsRqjiAHGiQuT7MRdVM/Ahx57733GKDRUgP8T10Xh2AmLgJN/6QSonYSE1siYHCci2zt2+kHFFCDsCjJ2i+MXka//GmreDRFH0ChJxVg3n3VhqsSE/1hdqQlmNH2mfhfUiMv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwiSRAz1; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwiSRAz1"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so28829456d6.2
        for <rcu@vger.kernel.org>; Sun, 14 Dec 2025 12:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765745354; x=1766350154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDumCZdJRfnNgy1wwIGbvp6cPqA+8322HTWvIIAJe4M=;
        b=TwiSRAz1Ts8W0GgE9nBo6BDJ3ELzh9GqSXsKjIjI38tyItSTwrZO+vkTYAxPIenPXg
         tbcHFQUjAi9EN5cbRskYcLmeYiA4UpOm4KWSQLHAaXU/kKlHMavYyo4W+D6Ex720MuJw
         sjbItBEpKJxlpHStudCdK1Sw8uU9De+XkQFS7aY/42HCl/flkvKflNkideaQfEj7U8AW
         wdFZyeT0S8RLL2CDpTKYXlPTPpq7f/PpNPhd+mqK6HAFpuu6ZX6VkJZngJPraqqh5V+I
         0v/ngpRbhvUmjNr8+LHBPhvF2jMZJ/qFaqZeEdgFZsfQTJ8+PEKouQGA2LSKbcJG1uqU
         QxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765745354; x=1766350154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hDumCZdJRfnNgy1wwIGbvp6cPqA+8322HTWvIIAJe4M=;
        b=oycE2nXme+RV1VoY6bo/bIWjmQ71BkpYOz1E4RBToEoRqwqLPvPunlFuh2d4o9A6Jg
         yFsE5ekZWLRUW4uoXg6buUvU0OCWZDUZ2/z4PXXYgqaL/+TS0PMyWAaT40TGzlf9BfU0
         CrixXLuO0wKhxCr7Rt2exptS9y/hOx9hbkZtgDlsquD3LF6O8Lbrz9lguJTVjFvpLaQI
         QgHU6voBQKIAHIlSCUjRFj4xvAoxFKvfTm7llPgMt02pEtyjVANAxJ1+kAT/dcrjBJmJ
         3qFjy8hmwmo8B7yzWZxzbPTZiS5GyJdYMbs4FwyyLYmTMm+AVZtwaYY4OUAR8Nyw9dgL
         om+g==
X-Forwarded-Encrypted: i=1; AJvYcCW7sw6DSQsAzzTQYzBLK6JEZVVEF0DM83oJBS76EqUkBGhTI2PaoFTwKJN9jl4oGYj5RXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnz3M9Pziba4/YIWM/LGFH8MwQ8h/UmVqZk5bitPw5Dc9llVgw
	M86+50cD2QY1JRP+FQ19DH/bVrPETX1fVA6Zx7miNeK7B97UW3uRCFO9
X-Gm-Gg: AY/fxX5DqXdMz1Bpm3zoQVhkoJ7wPIfrXtm+ly/A+WJkmmNO1ha/67lYjPtP1cI3+DY
	MOekTXvmUkk0ToQecB9ex4s4RsUp5AbrXBHWgAnlsh1d3lJJJTrOPDHf9tnXW/n57WiwK0RTxqK
	6u0GGkIUv59R7a4pH7QPQ0OApRMfWWnzqO0m9KIdjb/ScqTBVtuaelrqQ964/yX9ts20l6nbZKH
	KU9h95hAwrLQxp3h4DOYHus/ym+EgDi9UAaGBIiOtjUqjhdVE0zw4UhP3IIT23UpeQOnQWk19bG
	8qQcG9LwCrQOEC3oT+7v62X4u8yahlKDBgyC8d8yYVn81yiTSYWfASN5wm4D7NPJmuhNWz4LWLE
	1NsHoEWH/NaealcZkbKOZalXKewcV6ne7ADg0DZAJC67Lb+/GsOgVeYLsZY3oU2Aqd0+tC69kss
	XGliezzhDGe3VwtdBbVzw9Fai6eMo4Uuv+ejouEtEuByrzbxucV4MwNm+jmuebFLw4oOiM2x1Pj
	8I4b4ZIOM0rp/g=
X-Google-Smtp-Source: AGHT+IGnXSefCWc4oWLPPHhi69yWWIUm1AnAs4TPOgYh56szCBvPMhvX1OdI4rsUUqRW+t1uNrHcwg==
X-Received: by 2002:a05:6214:20a8:b0:888:6227:3e57 with SMTP id 6a1803df08f44-8887e3ff480mr154644586d6.16.1765745353781;
        Sun, 14 Dec 2025 12:49:13 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8899ea36210sm37181456d6.27.2025.12.14.12.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 12:49:13 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id D485BF4006A;
	Sun, 14 Dec 2025 15:49:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 14 Dec 2025 15:49:12 -0500
X-ME-Sender: <xms:yCI_abX75URCMwcjUKXSozmOikh04vEt2lsU6NOq7tcqjq2tqUuD4g>
    <xme:yCI_aV3OuvVh-uOb3foeUmVp9wDPSXbc4g0_ODBlcNx-W34w03TVmdHept1vsJA5k
    w53MVIC15M5nAxT5ZHgzZUKHVUBaogO0tz_eHzSeBuEqY9jV3zFSA>
X-ME-Received: <xmr:yCI_aZpH8URPB8OmdZYjPVxtaNbvRRNtYeKdwbjK158zq_6_GEgtQmvmeBGGvEuJn7Sd31Fs7Y9oXKg2qaJ03xcBB-FPGrJt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepffegveelieeffeefjeffveffkeeitdefteevieefieehffeileeiuddvtdfhhefg
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdpvghffhhitghiohhsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphht
    thhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepphgruh
    hlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomh
    dprhgtphhtthhopehrohhmrghnrdhguhhshhgthhhinheslhhinhhugidruggvvhdprhgt
    phhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:yCI_acVGtz0oADvLan6kEosK0Zurqx3nvXc4h9QnjM7Re0_u9um4-Q>
    <xmx:yCI_aUb07kvU7tOoFX5bFfmj1OIj0gvCsTb8YG06MV-kBEuDgZ-XAg>
    <xmx:yCI_aZdFCju1MxsPtb7dNrkcYvXdKl00dDCfaXU_mOcErq-DkS1rfg>
    <xmx:yCI_ae2m8-omfI3hxaIUzSPaxY2vzVn7pOQSaOIAcnqWlBc5jU9KMg>
    <xmx:yCI_aQL8m-igaWoeDdpXNEZdVb9wrIG2b8XyQ_EZOtsShldjCnt-mf2z>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Dec 2025 15:49:12 -0500 (EST)
Date: Mon, 15 Dec 2025 05:49:07 +0900
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
Subject: Re: Handling large numbers of hazard pointers
Message-ID: <aT8iw4zfk3sTKtMH@tardis-2.local>
References: <77ffb53f-91fb-4bd4-96d4-e16b0e6ff0f1@paulmck-laptop>
 <091915fa-d6a9-4aba-99c6-d93d9b65e0de@efficios.com>
 <961B6DB0-3071-41D0-9AB6-70B76C547F19@nvidia.com>
 <207B1F17-D789-48DC-88E3-352ECF0DAF11@nvidia.com>
 <1ee9bfee-d754-48db-b72d-763193cb92ca@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee9bfee-d754-48db-b72d-763193cb92ca@efficios.com>

On Sun, Dec 14, 2025 at 08:43:18AM -0500, Mathieu Desnoyers wrote:
[...]
> > ... By the way I wanted to emphasize my PoV, that requiring storage
> > provided by the user seems to negate one of the big benefits of hazard

TBH, if users don't want to do the extra allocation, they probably want
to just use RCU ;-) and even we can hide the allocation behind the
API, the performance penalty is still there when the "allocation"
happens. For example, in Mathieu's proposal below, when this cpu's slot
is used (which should be normal if we allow preemptible hazptr readers)
every hazptr_try_protect() will become a mutex acquisition, that means
we are back to locking in common cases. I in general don't think
allocating or filling in the backup slot while _try_protect() is a
good idea, unless we can avoid the cost in common cases.

> > pointers I think. Unless there is a solid use case for it, we should
> > probably not require the user to provide separate storage IMHO (or make
> > allocation internal to the api as I mentioned).
> I think the solution I have in mind takes care of the negative aspects
> of preallocation requirement. Here is how it would be used (see
> [1] for the current prototype). The "backup slot" is within the

A few issues in the prototype:

* hazptr_load_try_protect_percpu() needs to either be called in
  preemption disabling context or disable preemption itself.

* In __hazptr_load_try_protect(), seems to me that we shouldn't return
  after hazptr_chain_backup_slot() being called, but rather continue,
  otherwise we would miss the updater changes.

* As I mentioned above, since we allow preemption during hazptr readers,
  then when we have multiple users, it's likely that the per-CPU slot is
  used at most of the time, and other try_protect()s would always go
  into the slow path, which downgrade us to normal locking.

Regards,
Boqun

> struct hazptr_ctx, so from a user perspective, it's under the hood.
> 
> The user just has to provide a context variable on its stack.
> 
> (untested example below)
> 
> void *ptr;
> 
> void fct(void)
> {
> 	struct hazptr_ctx ctx;
> 	void *addr;
> 
> 	addr = hazptr_load_try_protect(&ctx, &ptr);
> 	if (!addr)
> 		return;
> 	[critical section]
> 	hazptr_release(&ctx, addr);
> }
> 
> Thanks,
> 
> Mathieu
> 
> [1] https://github.com/compudj/linux-dev/commit/5e33fc13f950929e630a60ef44249e7b0978e80f
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
