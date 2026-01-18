Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E94334C34
	for <rcu@vger.kernel.org>; Sun, 18 Jan 2026 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768748263; cv=none; b=NHX5vPxzoZZBae03IUUdXBhjn+e1Xrt5lyV8BPc0THXdu8jPaKPOK8PpzRY6b3yPyF4NzSJ78eDeWK3uBH8dY6k7TR/AM0Ty2tBWGanmx803ODX4JXWlC7t9AhB5IN9VbLz4l8lJbzqJMZIfNsSZ1hjAs4OPJwPuaGRZ64UTnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768748263; c=relaxed/simple;
	bh=z0KLMHw/ngV2EDzNPq3PZUHUH0yS2kMxX72n4PgVnOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqCm5oHMl9JYElVnb+rwQy/1Pad39O+f9Hw0mCrKK9gzFZZm2CPIxr7hQ6JjbHplVrYbHE8Ev8SSjLEyjpuFQc/ZjZ8pnipg513GgAu9wU/NrapKx3IcpWV1IkWfcFa07ULzHy7EE7g/I1ZL2xPNPlxwHFFBek9/vzNrivk76vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX05uhSY; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX05uhSY"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c5349ba802so334246685a.1
        for <rcu@vger.kernel.org>; Sun, 18 Jan 2026 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768748261; x=1769353061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxkD3y/JM8IrHeeArH3JorG5vzoWquy0eBJRy7nIqK0=;
        b=gX05uhSYOPR1xVuaXSPMh5zWeJFB1D0o1rk753W0in7h7VCQhy+zbLiDA/KUqWPlDA
         QABJjzLvp+ZAiLCfp/KDnG4gaHyOAstrKo65pcXZayeT2uUgEHAJuZXPhDYrkIM91HEU
         pu8U09uh+b9+pW3u8t6kX6/hDUFZYY+N1cqSvWFtxOZs2Emib9z4YocE2lJBAQcuyr1F
         sPngdvyhtR9ksFP2TEpgpbmyiV+LTJkgKKBPuGKgD5TB0imBUGwHRdmB8fO87FfJNnR0
         pfVDwicMmtgoSfAi+AMVPFE957z5l3ExenC8in8Y/EninRAtZMSg8sIUzfY7o+1tewfA
         KW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768748261; x=1769353061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qxkD3y/JM8IrHeeArH3JorG5vzoWquy0eBJRy7nIqK0=;
        b=lniOLls/OpWn2kqmdGZ17kURtpz1cPXHf2L7PWecHcffga8wP7tantjd/bplkhilrg
         tBMrxqjz03Vb2yvoSGa4YBqvZAKLMgfkpbrjgkjvy5Y7xDL1NfdV/O2ST0oc8Ba5HxPx
         7hocd4dnJrblgJPjUjqkgQuh5Q+naRYTiT4Yb+fA+zDjncxQAOPuv3Q+qRVp4v4TlVvf
         J02LoCF+Tlvvzdj8EJ2yDntebDl5ZvFQGM4kgPHVA9pyAF2DpvimNT24+HyZtyTQIrmz
         elGI0Y1fIoEMpBL84eLSJmFFfqX428mJ9wqbSEdYgJH6UtXmkzfvP+n8Y1KEFcsTKIuz
         spiw==
X-Forwarded-Encrypted: i=1; AJvYcCVkZX65PkqjgEzvycHGqskS5OYQBIMCVyPg8WV3WmYrK3GfjjnXsDVI96t62efHCAAgnJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyKmD3CjrtW0i9Vm4T/1dY2SJQofcPHwv2F4xiFsffRfrgjtsi
	EBD0vizrO4BjuKJF95Oqxow6KZ/JOrt/0Ul+QvUtgfndj66vOFLwvRuf
X-Gm-Gg: AY/fxX463byPGMp7UWNRaVTvCzApZKj9ZGWEUXGqqZoyiVmY9ayxpfUCL7pTIWxJW1N
	z2kHCwJQGJDgOwCi5O6/SH3A5+GROBKGx/kacAcaf6uWNw4vZQs7R/pCT6j8aWzL5JQ0ATrqJAO
	mk1iwG/Y1PYZ8xcqHB2xuWFXFvWGyl7QrLMfTSgQJyc21jWhGOXLKr4shS6Y6UjIT74S/d9OycD
	aRYCzjU97o96uPIMn5XcHuBTOwgeXZ2du/AOuTo9aA2lzaTg3PFSagw6F9INL7xEyNxJkbWLvAX
	WKCGwFeeAmQVkLHI2weZJ/1v4BQWH6RUXGlsxCKoUw+RY1hg01U7unK7iL2O9pFq4Bj/FipfYiW
	udOg0OIS8GfgsBDgzAPFwBBV/yPx6BEkhH3emqrJLjig9xsYjoKXMFp2KdQka8NfE8IKjvxLE++
	9fNzX3pFORl8yFQ1JPYOBD2oypni07o638LJgYjikALIRroI2UWyxa8dnqaQQv7yW5SP756a6Vq
	in+J+GDUq22hMKe6V1Za/R43A==
X-Received: by 2002:a05:620a:3f8f:b0:8c6:a8d1:bd8 with SMTP id af79cd13be357-8c6a8d11388mr698299585a.87.1768748261370;
        Sun, 18 Jan 2026 06:57:41 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e45a7sm66114946d6.1.2026.01.18.06.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 06:57:40 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1CD59F4006B;
	Sun, 18 Jan 2026 09:57:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 18 Jan 2026 09:57:40 -0500
X-ME-Sender: <xms:5PRsaekaeYKLilQmyiWTXRKKdKuxeS4slavcLzhLtqi8Beh6kwiuVw>
    <xme:5PRsaTQRZIt4MJyVaTri52hrBoGvbuvx27hiVAXPyR1VEfrGQOUwKK3JEQcyCUzoN
    z41bxY_4cvY24_UXacz_0y2o9wOt0eRG86kojizOCZtnjcerNctBQ>
X-ME-Received: <xmr:5PRsacnGUFO_E0poWsR36DCRvggOn5RlxJ4eCLxl79o_VFmA_taVdWNT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopeguihhrkhdrsggvhhhmvgesghhmrghilhdrtghomhdprhgtphhtthhopehruh
    hsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpd
    hrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnug
    gsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5PRsaUPSjQWOAdiWyOLZLcKlXOLK0MPxUlTUGLyxBzXxaWbIX86kaQ>
    <xmx:5PRsac0Q0-LPoHAiW4hn_To2g8B1GXQrCSYKt65jqGne7QUWP4EI5Q>
    <xmx:5PRsaQaHUGktj9gcvIvk06fXA2LyXZdGLUaoQU9sq9G0mJ_Yi3BU0g>
    <xmx:5PRsac5K8ifkWetQFSkby7lEGmapw7AJZ7VjlBO3SHTEwqjj7podZg>
    <xmx:5PRsafhMVo_6TJq44Qhii_hSq0ocMWgECHULFX7XokoW22H0eYyA-Smv>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Jan 2026 09:57:39 -0500 (EST)
Date: Sun, 18 Jan 2026 22:57:37 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Dirk Behme <dirk.behme@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 4/5] rust: sync: atomic: Add Atomic<*mut T> support
Message-ID: <aWz04Tb7SSDQls8T@tardis-2.local>
References: <20260117122243.24404-1-boqun.feng@gmail.com>
 <20260117122243.24404-5-boqun.feng@gmail.com>
 <67e5482b-93ed-4b5f-8375-f7e68c50a436@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e5482b-93ed-4b5f-8375-f7e68c50a436@gmail.com>

On Sun, Jan 18, 2026 at 09:38:36AM +0100, Dirk Behme wrote:
[...]
> >  
> > +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
> 
> uses -> use ?
> 

Will fix, thank you!

> > +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
> > +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> > +impl AtomicImpl for *const c_void {
> > +    type Delta = isize;
> > +}
> 
> Are all users of this guarded with CONFIG_ARCH_SUPPORTS_ATOMIC_RMW as
> well? Or do we want (need?) to cover the

No, the users don't need to guard with CONFIG_ARCH_SUPPORTS_ATOMIC_RMW,
the purpose of this #[cfg] is to avoid surprise that when
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=n arch supports Rust, when that happens,
we need to add the support to the helpers of i8/i16/ptr.

> non-CONFIG_ARCH_SUPPORTS_ATOMIC_RMW cases where someone tries to use

Note that these arches are very rare, so we might not have any problem
for a while.

Regards,
Boqun

> this as well?
> 
> Best regards
> 
> Dirk
> 
> 
> 
