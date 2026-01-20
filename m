Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C935D44D685
	for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923986; cv=none; b=K5KklNu+KzYm/PMciDuem1Z/yKbwP5eYFPx5lpbEgb9jpIrjW+lsOT3fFWygzsHPht77YMrWtAP6ymlcA1MNQdb9jRcmcJpquWe+r4YNhvY+rFOqMuG9F53Ut1npzLY8u05w09W/6Lvv9yN+KHmmfYckYn7QTPgKau/jQywevGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923986; c=relaxed/simple;
	bh=KEgCwIHV91V/HRggN5GK/V4JBaIXW7US9kJ8q/CbBhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kxt5kvHhGHl8pIz6NckCpI3frpvbsdtCBdtNZYj/viXiFOKgL3m7ggGoINRTUJ+473G0fjNm3ijplnjleHGiXWRLaXRte3e704skVkX3VNSPE7Ecj/dUQLNm5DBmGjDjoq6717ydWKBaX2oFMtAkEleHPlt3ROxPMbSB7OA9320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUhdgM8m; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUhdgM8m"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7cfcb5b1e2fso3473114a34.3
        for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 07:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768923983; x=1769528783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyXouSFdgGvsNJv0Rfk+0bxHd/9nuw4emSyLP3jbzKo=;
        b=AUhdgM8mCkrP48N1hphyWhYWX9AqPU00+UqnIVb7O3pwquKXMLGjMUokR2GNnVIl2G
         B3SaEhAdHNovAxOASJmQa1FYd+khedWGUBhWPwH+VI6KXK1BJBG3D4J4zMVPISv68izG
         UcmI5louDK6EqJL5omssjI5GgLywHz/nUr7YjF+GtuEXG5JgFMLYUMCHqR77QCLzaEGC
         9Usi9HhgBclW6Plfmf3SZWOdlu/HqpXota+G4TyZZQhbE1rY4lFLhLDt9R8eTxibbvJy
         myr+WZHbsXZaSaknJS+fRlI2QRjTP4MyQsa9nH8diuwjaBGWGHf1ZsDsXfj/1+tVQc05
         fd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768923983; x=1769528783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyXouSFdgGvsNJv0Rfk+0bxHd/9nuw4emSyLP3jbzKo=;
        b=R3Na7gZpzy5+txd3BbPURkVUyVrqaLCW0QiVCjvHeHHff1pnYT3lUQA5wPsMtgKehr
         7WhLT/vBHXrIWe8+8bc9EOjYlDuTniORi9+RFEp/Gan/YmFtdAaIIEuvosSA6NVFB7Rw
         UFQb/dCSle3YR4gckwf8xnr+wyeQXHCbAqT2i7pezmCXm10devKQYrVjlxHLo8qnI12i
         5lcMVK9GerrJEsKvp3+qCYnM9/QNWR44KI0Y1tLP55dQw0a3Gf/ReXoyjGwaoI7mHNX6
         nrBv6E5Ta+8dpNjwoICnJw9tWkKzomn6ylNC7IB62UlB/zzXZxfREA82/Yg3DRl+rr1o
         rNdA==
X-Forwarded-Encrypted: i=1; AJvYcCVBCaWTrw64C5EgfTjQK4PVGNA1A4QukvRTwFoL99+JfKS1YISfAId0KMyw9/3YExCmZb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDMjwEPmy26t0QF4q94M9GTOtT2D6TwZscO2UtROn5mf0Tqvg
	a8vWfqjP1HANNC8EH4/jZQDhhXsiT2SrJyzf1hFnLgCyLDMt6U8EJekTDcCjWwPB
X-Gm-Gg: AY/fxX5/mPrLEGOjPUOglaJ/dmCh4eB4wvO9hoJvqXebeyPJaHqlcviTLIUM+hg+CLr
	Q9vjOzhxBNzbgWMHUyIhvOsxAsOjJWllGzVyBZHJYEHVZ+R/XZHIDXztj4zU53jM9NTwr8PT6YQ
	8n2psdWDo0LAghuyNCZhtBxHqm9oZ1xUGYSb6gL1M8Y2SrPIunEydT7psQfcoculNaNKqa/zMAT
	qrbz7jigilK9GQgM3zhYBbtGNBc8N4VwWO96Ez4Q/eTdaE8XWO2T5NkZzFNi5pfv5pHnDiynZLV
	OozHh7AhJ2X3HEyDGsOwcmtig3sQRcv4FySw5Nb3uPx747roAqVbg+9HPTXCLR4VD0Q7rL80Ia5
	BEykKkD2iBgKvXgPCU70gMdXxFAT8vBIr3H/zTzUfe+bK/cYrCFlhEanZ7tKKbC1Fr2poYT41K/
	zorOihXHuif1Nc2//5Lci5v41xj7F0F/rplWk4kzpcEG7xDhm31Bjps4J/EqOOMHDKbxa+qaz8u
	vr1haKil6R3cYQ=
X-Received: by 2002:a05:6830:6a12:b0:7c9:5bef:e9b with SMTP id 46e09a7af769-7cfdfe21e9dmr7501113a34.3.1768918029463;
        Tue, 20 Jan 2026 06:07:09 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf000b80sm8639228a34.0.2026.01.20.06.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:07:09 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C6219F40069;
	Tue, 20 Jan 2026 09:07:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 20 Jan 2026 09:07:06 -0500
X-ME-Sender: <xms:CoxvaY8oGFFIjsu8VKC_elbc3tfGKNFNuBGzy2Ae6bR_lGVgAcAWew>
    <xme:Coxvaegb-qWiupOEhDACJxe3lxOtrDVIPdDZNgbNXMhBvT8TDP56N1ngEyOC26H4x
    39NmTwe55y0rEqMg3xQviZGSCwo2c_u7iff3u2079-aLNsLlAoUSw>
X-ME-Received: <xmr:Coxvae7QUmusPXsp-kQ5CF-0e0opzmYz3tGB-zeesBT4t9vFtmbKnTiW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedvvdeh
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhr
    tghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsjhhorhhnfegpghhh
    sehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CoxvaTbQOHCP5AjlX9Tu1ekoCkORdWJTGgV-JqeDd-v8HjCobjSzJA>
    <xmx:CoxvaTfiuYAh8RmJhLamF0Irw8DNXnPipxzx08bLbQnZlD6aZkSdYg>
    <xmx:CoxvaY6QnkPBKY6MSYKRCQjv7vDzXnK0wOZfPJ3YIfm6-pc465cd-w>
    <xmx:CoxvaXVmJfpjGmDFYp7EePz2aYDX65qrG0B0nrtJx8AvBAe9x-YTiA>
    <xmx:CoxvaXZ5JiTWCb-yfZUMKvLtdFa4jSNGq9jkbRH8R8ql1kf8Cc75gN0g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 09:07:06 -0500 (EST)
Date: Tue, 20 Jan 2026 22:07:04 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
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
Message-ID: <aW-MCLIk74gsDump@tardis-2.local>
References: <20260117122243.24404-1-boqun.feng@gmail.com>
 <20260117122243.24404-5-boqun.feng@gmail.com>
 <DFR0Z3KHYS62.37Y0R286DPTUQ@garyguo.net>
 <aWxfV4Y3fnNR0Kje@tardis-2.local>
 <aW9276jXCz0S-Ec6@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW9276jXCz0S-Ec6@google.com>

On Tue, Jan 20, 2026 at 12:37:03PM +0000, Alice Ryhl wrote:
> On Sun, Jan 18, 2026 at 12:19:35PM +0800, Boqun Feng wrote:
> > On Sat, Jan 17, 2026 at 05:03:15PM +0000, Gary Guo wrote:
> > > On Sat Jan 17, 2026 at 12:22 PM GMT, Boqun Feng wrote:
> > > > +// SAFETY:
> > > > +//
> > > > +// - `*mut T` has the same size and alignment with `*const c_void`, and is round-trip
> > > > +//   transmutable to `*const c_void`.
> > > > +// - `*mut T` is safe to transfer between execution contexts. See the safety requirement of
> > > > +//   [`AtomicType`].
> > > > +unsafe impl<T: Sized> super::AtomicType for *mut T {
> > > > +    type Repr = *const c_void;
> > > > +}
> > > 
> > > How about *const T?
> > > 
> > 
> > In general I want to avoid const raw pointers since it provides very
> > little extra compared to mut raw pointers. For compiler optimization,
> > provenenace is more important than "const vs mut" modifier, for
> > dereference, it's unsafe anyway and users need to provide reasoning
> > (including knowing the provenance and other accesses may happen to the
> > same address), so I feel the type difference of "*const T" vs "*mut T"
> > doesn't do anything extra either.
> > 
> > Think about it, in Rust std, there are two pointer types only maps to
> > "*mut T": NonNull<T> (as_ptr() returns a `*mut T`) and AtomicPtr<T>
> > (as_ptr() returns a `*mut *mut T`). And there is no type like
> > NonNullConst<T> and AtomicConstPtr<T>. This is a lint to me that we may
> > not need to support `*const T` in most cases.
> > 
> > But maybe I'm missing something? If you have a good reason, we can
> > obviously add the support for `*const T`.
> 
> It was pretty inconvenient in:
> https://lore.kernel.org/all/20260117-upgrade-poll-v1-1-179437b7bd49@google.com/
> since I had to cast_mut() a bunch of places.
> 

Let's add it then ;-)

https://lore.kernel.org/rust-for-linux/20260120140503.62804-1-boqun.feng@gmail.com/

Regards,
Boqun

> Alice
