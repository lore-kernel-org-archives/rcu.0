Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A788331A6F
	for <rcu@vger.kernel.org>; Sun, 18 Jan 2026 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768748712; cv=none; b=Ph3kNByXlCv2T6l4kWVp8ZNJypSxvk9Dl4WBcfhWgt7a5fb3NsJ4cDXRL+8/Q5S/HVfUUG14PkKFZtGiUiKP6rUjzFsANmfw5FoZrnLAUsHofXAFsa3A4A33eextGUEWle3kGsnyQEFJS1imhSeP2hl7WlmMamUn4mvVWIpWcLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768748712; c=relaxed/simple;
	bh=5vRsRWeMNtoPVYsJZKkrfh9mzvgru9Cb2lGawFduPS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON4EXMAHMicHu3pyKgPPl0kmVGPI5UpLWMb6KZ0YmZzgew/+bc/jXhitee0iC02fyFFQJzgrBlwgnBvwNo6vtI4g4GJaQj4X+sCaHd5Ugq6zgBziaGQ133tfzgFVJ2IVeYOtx5rmWRNuJ3qLWsjwsbr/hlG1lA0Ef5Ox4pukVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z98NeYzm; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z98NeYzm"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c5320536bfso384967585a.1
        for <rcu@vger.kernel.org>; Sun, 18 Jan 2026 07:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768748709; x=1769353509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21uLaqJ17tNxzyJX/CswTc0v9JKdWpeTLh7D9bEVPhE=;
        b=Z98NeYzmpw+qePaVCufd1WPP3bJIB+wGRdTbU7jPuzCTubMba+PWkNktg2028HGJ0D
         q/g3A9SrEPZGcmlkNQ+l+Sadj8coEP956cjiz1z9VNg1vMpGSaVb2dfevmol7IqILot5
         g3HDRp6za2qlhHqZ7jNhxhD9bhutWV+64rclYFh/vsDMaRMlZnp1GGwXjhqFi+X5mHyb
         3+pZwpn8Stp/LJHAJy3WIX4YPGkHlR073Y9BtSXfJLJp8YZqaFChsJrfeT6m7v7/zGnx
         18AqZISBtF+NLkFsYwDZndmyvd7N+3JSxdXQumhpWjfJIseamxfgjT12R/UbWAc5fKsw
         y/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768748709; x=1769353509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=21uLaqJ17tNxzyJX/CswTc0v9JKdWpeTLh7D9bEVPhE=;
        b=ALwBYsCOv6dtSHEaAcVSCviHxRTVMPgsjmYCEFEK6s7flXJ8GLW/s1R0lIMMu6mHEg
         bbOHwvlZi3I0KpgND9t31ul27ZHKDoOl6CPAkNPxvqbAeJtHmDUGIYDZXTWbN1i9I4x/
         /CP7QL5N6dSFb+8sEn9RJO5UUZw0RMvV4T2FWywSUxscuYaERqsQkKQRamUM7MfoQxSs
         Vj7BjLH0kGRThV+4wFfQcVtQm5n2c4M0UQHlO4S6mtRbOXCg2Aeu6R7MkplVEDhFUn74
         XShc2xGtGsmLSRcDg+0iXVyWKxcFMRw1Ik0/rrHVmMzqD5Uh1Grt2fOcCRt7NW6PvO0o
         PiAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2+EDhkCmw5ALJJPgWaPg2LsMu0pnjVMNHClEUtToOVhINwSz4QCus+8iF47NI758rDjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyteMAiy3gdYHTt+uaZBSyPsFZWfk6rEFcnICsqRKEeQs/E1Fc8
	RTupp/AS5BNOHz2VwjWyTvz/VwkSzByNzKLnLvT7cKtY43IOLSkktiCh
X-Gm-Gg: AY/fxX4W3N+c45hqHlyb9MpRgqUfiO6ynpvVBQullLWenFgltG9VPtLn/yaQRnXFun3
	nwjIxLeduEltl4tPrvynEhtijzXaCjHca1GoC1sP+sbdkjDoxVr3WJg+5UU9A/gpIOAnynnnTIU
	amG5zyi3fHavpzMVkq/e205gwKvcVKl5K/Q6dEp4OzzlsELVGOMSUEoaNMpZvChoNuHcTc8RbSm
	fu4WPeksRDyM2NAlVLvWvPqqLOK/TbnKzgB8AFEv75Zuun7y9+KOkeAUqQeBuVQ6IRYvCmhY4Zl
	UE0PxrS+EFD9ytI44R1ldj7sH1ddre3o3LSDv+5IPPrQ+x57isGZWlwejb4hHvi2XqIHeSLQUR0
	IA0loOhMzCyq/FBrwQr/si824XnCiXPbYTEynQBUCkAMuQiKaUyD991IXuvQA1ZXSsEh2gsn9XP
	VoUxwV/ZsegydLnexjPFYaV/Cfdu8kLl6tIf3rjvgFuwmZLtJQai6khcBdEkgZgVZb+fCdofVvu
	alyvAzGmxp6PZI=
X-Received: by 2002:a05:620a:c4b:b0:8c6:a608:5abc with SMTP id af79cd13be357-8c6a670532dmr1195312785a.28.1768748709345;
        Sun, 18 Jan 2026 07:05:09 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e603a8bsm64025876d6.17.2026.01.18.07.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 07:05:08 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 28814F4006A;
	Sun, 18 Jan 2026 10:05:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 18 Jan 2026 10:05:08 -0500
X-ME-Sender: <xms:pPZsaW-pcTbiRv1pgFwZ1zUQ7fjQ70T_q0eOjDJvbgWGhUmd6heEwA>
    <xme:pPZsaUIkzRPwbq3kL9vQHtOAlw8ZXWBajOnj1YgvAXLryhuP2LOZQovwAuDTPAUys
    zJjG35LDckyhBUS43BJiWpYFyGcAoOsd__v4jF4w8K5yZoNC8-rlw>
X-ME-Received: <xmr:pPZsab93FIRODLq4dCC9UvuDgH4RGLGcoQAgJf4P4ok5CHDFrJ6qifP3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeehtddtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:pPZsaQEvpRDFFrcitxjb8Mj2QrQHs1sYj4s1oYuhuv0et-qgHSwMMg>
    <xmx:pPZsabNBQNx5LmYfORsiYduFr39OjM9APU2MCWh1c8hmz1Q34rDoDA>
    <xmx:pPZsafT8xD5iRy7v1CvLMctT_JCnUw6JxPezcmiLAUnYHnJYtFE5XQ>
    <xmx:pPZsaSRV5Md2gRUp5st0McfxJZo9vOWP6OAxILg9PtRAFAt9pBj8Ig>
    <xmx:pPZsaZb39TlipkHU7f1abqtKo6TFXDTTIw9M0ZTGXE7_pASypAEfS9Xe>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Jan 2026 10:05:07 -0500 (EST)
Date: Sun, 18 Jan 2026 23:05:05 +0800
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
Message-ID: <aWz2oZqMaQHQWe-e@tardis-2.local>
References: <20260117122243.24404-1-boqun.feng@gmail.com>
 <20260117122243.24404-5-boqun.feng@gmail.com>
 <67e5482b-93ed-4b5f-8375-f7e68c50a436@gmail.com>
 <aWz04Tb7SSDQls8T@tardis-2.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWz04Tb7SSDQls8T@tardis-2.local>

On Sun, Jan 18, 2026 at 10:57:37PM +0800, Boqun Feng wrote:
> On Sun, Jan 18, 2026 at 09:38:36AM +0100, Dirk Behme wrote:
> [...]
> > >  
> > > +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
> > 
> > uses -> use ?
> > 
> 
> Will fix, thank you!
> 
> > > +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
> > > +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> > > +impl AtomicImpl for *const c_void {
> > > +    type Delta = isize;
> > > +}
> > 
> > Are all users of this guarded with CONFIG_ARCH_SUPPORTS_ATOMIC_RMW as
> > well? Or do we want (need?) to cover the
> 
> No, the users don't need to guard with CONFIG_ARCH_SUPPORTS_ATOMIC_RMW,
> the purpose of this #[cfg] is to avoid surprise that when
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=n arch supports Rust, when that happens,
> we need to add the support to the helpers of i8/i16/ptr.
> 

Hmm... I guess at this moment, I probably should do

#[cfg(not(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW))]
static_assert!(false,
               "Support of architectures that don't have native atomic needs to implement helpers in atomic_ext.c");

I can add a patch in the next version if it looks good to everyone.

Regards,
Boqun

> > non-CONFIG_ARCH_SUPPORTS_ATOMIC_RMW cases where someone tries to use
> 
> Note that these arches are very rare, so we might not have any problem
> for a while.
> 
> Regards,
> Boqun
> 
> > this as well?
> > 
> > Best regards
> > 
> > Dirk
> > 
> > 
> > 
