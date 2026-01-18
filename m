Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E752200C2
	for <rcu@vger.kernel.org>; Sun, 18 Jan 2026 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768716091; cv=none; b=k69iZlnGyZT3jQMy6lbVUR6/SP+r2lyYSOU5iKX2Wuy/wrrOkXQDf0hyqZdJyLStgpTKDuvEtwJNKVqz+9L6IGTdU4+y31rsWeKGGKs6+cGPKFjs+A+Fe3+Tw3CbXcVz93LvG2oXRZ09D9d322azC8OmXunB8WpP4vIHdQF4nHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768716091; c=relaxed/simple;
	bh=DIXu1xJBWswCmGBRxFXgpv7cNPr9e4eOhTTy17+c9Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmB2iucWGJKFmMMIAYoHyrx7Y+cuvpgZLTjmrHsSpG+NRd+kuu8UCTvE2U2z3+oZO+65CZcLvRw7DddQ3/Av0w8T7s5mIY2VBTdR7DQr3vecRngL0Iefy4afChqD8sG4tI7cRkCuFLiJjaE7sI1/QKvaPzhLe3pDl/ClwSo8WLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ4ZecMx; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ4ZecMx"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12332910300so3312955c88.0
        for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 22:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768716089; x=1769320889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOiV0D+CNI6UsixBopTqJbDRkz4TgZfrfHbV+iHjkxE=;
        b=DJ4ZecMxd9JBwSwjASkpX7zXm0cdyXIFoGL09auSvI7KNRRGJgXVnBGBBsoHKdnBgd
         fvimwNJs4rIktNV3WIDjm9JXdxMyPwWhGmr+cEnRbjVFukLGsQRfPtOAgmV8LBYO9VX+
         GbC0g+V5SKH2jaXQ7xJ+P59fpxKJW6rl/8qPy4+AgFmI7eJ/Kl4zBJ0MsCUjmoP6L1iY
         cXI7q4VgcaECYPnrAXM9foDJlUylhIBjhc7xU/VbP4HqDBkQEYtf0eGJyRetDCzEDo7b
         a9TMZtBFqYEGkhTnaFg2rI+9XC1ewQ6sAvjIptj0FNENcQwpAGnH7vOClKet959v4gjI
         qlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768716089; x=1769320889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sOiV0D+CNI6UsixBopTqJbDRkz4TgZfrfHbV+iHjkxE=;
        b=SkorG/WGJYDJnzkzdKZt4upUUZhf9jQFthNUgdLqOouDpCEJgfxlJqPczOCXVVxlTt
         6/uXTYY5NG7L5VeAHBzeJN9KTOH8wDmHCwWChMugBtDz7DfWkpEtrVHoBb8jUlknLYNg
         /G1F8QF/IOe6SvPiVIQtrj1P9OtFYjOzLc1GATAU93c9WPhoaJ8hV8ol/LDl/t3lVwqQ
         r1v6SoveGtXZ36NmRKqlF0c0C+Qvi/2xx7wViSoeAZUAMJI5aUnvRLHcw2V4w4wRq/Ii
         I1MYWLUDuZrR96xNQvdhSBFMDUUWyA7rYJTWnqFpLtmVuXJ3DCqkwke4J+280oQffmYz
         ZYbg==
X-Forwarded-Encrypted: i=1; AJvYcCWtYKs3dgZWzJiQ9EroFUqpwWvx6bP66J7eJZ0gtQH/Ygzwb8vW06I6lp/deYD9SDj/Jzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYmmcGacFdSsLhltUQvw5NWdF9CGGj7hgx8xh7Ml8hoHz9I0KV
	iFyXNSiHG9GWEDyBSI9X9fEes/3Kkp6Y5UHXWZnuCWB8JrNmDhOhX1yiz7f40Q==
X-Gm-Gg: AY/fxX5hKmgSSGjJyw9068hVWe4PmVPyMPkW1cooOwlT5KALHYNu9KudR97m8Mn5ZDq
	+DdLO3No7suUwZGCs3JJyJot4yie4qUOzmD9HFq0BQLAMQBHtRpSEHx/TT8J+MZ+0TAjGjWgNAm
	/eOg2BlUcYP8bckYpIPArUEShJPLefSQtYW86S91IfB7H3wu2H5xTHzIlMSqOceAt3IlTjt/oKY
	8hd4RebUm1LfN2+bPx+/jz/Ze2OANDlopLyx27lVvYXg9ngfrntZAG4idRoVkKAI2NVfHywXuDb
	qB+CgB+BCbpNSHCUbDCcTxEjdYA7IO8eSn63F2ZUlVD5hnWTPZp4ywOGkauA2T4N1hhQcAdqhVZ
	PxulwC8gnnkjH7ei2YCRFxKbIS0vHYgqDDmFBuXbmcfwaTl7gDphaUO/n/IsUr5iPHuJabF/sNv
	vJ7PI8rPQY1cYBNAbT34xLwt0NB36C6yNxJJo5my/lK4RczqkwJEfGP+bnadssVhO0QQxMrjhkg
	QQ5a+imnT49wh38e1Tmq8jLcQ==
X-Received: by 2002:a05:622a:14cb:b0:501:4b22:b9c0 with SMTP id d75a77b69052e-502a175e37dmr104860631cf.79.1768709979829;
        Sat, 17 Jan 2026 20:19:39 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6214c5sm54662016d6.25.2026.01.17.20.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 20:19:39 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5F538F4007B;
	Sat, 17 Jan 2026 23:19:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 17 Jan 2026 23:19:38 -0500
X-ME-Sender: <xms:Wl9saajb0DH3KIV8b33TqfrgR5j4k10izHdb2sqmhk9TFfWcktvEhA>
    <xme:Wl9saUFslWPPVLFMNQYNwRty1L8Zh1R2xOGYAI1NctpwvWFotCONqubeb_YgLJ5lQ
    lYV_nnSHx6pgnXDplRFPqVg-Y_jk6vLDBdDlIh-S6qmNm1R49aVKA>
X-ME-Received: <xmr:Wl9sabLaOdSVrjVtl-DFjDPjqxdGBfypElxy89kXs2285BO1LH5MSO9J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeefjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehruhhsthdqfh
    horhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtg
    husehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrd
    gtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvg
    hrhihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:Wl9safCIGHBhENOWy5WUjh1Bh9zd3-Y8log6Y52dZw16mxAqqYJGTg>
    <xmx:Wl9saRD1kXkA1n3u-JxGcvUDiP4LWh6MBRACLR_26PAyfaMbcsI4MA>
    <xmx:Wl9saQlvwpcdVNe5xNSpWUZuAmfFi74eBCgHCzXi7fdPsJ82d-2Fjw>
    <xmx:Wl9safgxX65m4fwY9ZAYk8pXI1S45l8DlnBw5au2XceaeoBltcqsWQ>
    <xmx:Wl9saZdc5zghvgxioK2PiaVpuo_cMMPeyLVS0IYzovuz24pULWBCMM19>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 23:19:37 -0500 (EST)
Date: Sun, 18 Jan 2026 12:19:35 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <aWxfV4Y3fnNR0Kje@tardis-2.local>
References: <20260117122243.24404-1-boqun.feng@gmail.com>
 <20260117122243.24404-5-boqun.feng@gmail.com>
 <DFR0Z3KHYS62.37Y0R286DPTUQ@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFR0Z3KHYS62.37Y0R286DPTUQ@garyguo.net>

On Sat, Jan 17, 2026 at 05:03:15PM +0000, Gary Guo wrote:
> On Sat Jan 17, 2026 at 12:22 PM GMT, Boqun Feng wrote:
> > Atomic pointer support is an important piece of synchronization
> > algorithm, e.g. RCU, hence provide the support for that.
> >
> > Note that instead of relying on atomic_long or the implementation of
> > `Atomic<usize>`, a new set of helpers (atomic_ptr_*) is introduced for
> > atomic pointer specifically, this is because ptr2int casting would
> > lose the provenance of a pointer and even though in theory there are a
> > few tricks the provenance can be restored, it'll still be a simpler
> > implementation if C could provide atomic pointers directly. The side
> > effects of this approach are: we don't have the arithmetic and logical
> > operations for pointers yet and the current implementation only works
> > on ARCH_SUPPORTS_ATOMIC_RMW architectures, but these are implementation
> > issues and can be added later.
> >
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> I am happy that this is now using dedicated helpers for pointers, and not going
> through an intermediate integer which can lose provenance.
> 
> Some feedbacks below, but in general LGTM.
> 
> Reviewed-by: Gary Guo <gary@garyguo.net>
> 

Thanks!

> > ---
> > diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
[...]
> > index 4aebeacb961a..4d2a5228c2e4 100644
> > --- a/rust/kernel/sync/atomic.rs
> > +++ b/rust/kernel/sync/atomic.rs
> > @@ -51,6 +51,10 @@
> >  #[repr(transparent)]
> >  pub struct Atomic<T: AtomicType>(AtomicRepr<T::Repr>);
> >  
> > +// SAFETY: `Atomic<T>` is safe to transfer between execution contexts because of the safety
> > +// requirement of `AtomicType`.
> > +unsafe impl<T: AtomicType> Send for Atomic<T> {}
> > +
> >  // SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
> >  unsafe impl<T: AtomicType> Sync for Atomic<T> {}
> >  
> > @@ -68,6 +72,11 @@ unsafe impl<T: AtomicType> Sync for Atomic<T> {}
> >  ///
> >  /// - [`Self`] must have the same size and alignment as [`Self::Repr`].
> >  /// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
> > +/// - [`Self`] must be safe to transfer between execution contexts, if it's [`Send`], this is
> > +///   automatically satisfied. The exception is pointer types that are even though marked as
> > +///   `!Send` (e.g. raw pointers and [`NonNull<T>`]) but requiring `unsafe` to do anything
> > +///   meaningful on them. This is because transferring pointer values between execution contexts is
> > +///   safe as long as the actual `unsafe` dereferencing is justified.
> 
> I think the discussion about `Send` on pointers should be moved to the `impl<T>
> AtomicType for *mut T` side.
> 

The reason I put something here was to answer the potential question
"why don't you require AtomicType being a subtrait of Send?", that's
more of a question for people who read about `AtomicType`, so I figured
we need some explanation. But I'm fine if you think we should move some
of the comments to the impl block, or we duplicate some. Although I
don't think the current version is worse. Considering we do:

    /// - [`Self`] must have the same size and alignment as [`Self::Repr`].
    /// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
    /// - [`Self`] must be safe to transfer between execution contexts, if it's [`Send`], this is
    ///   automatically satisfied.

for AtomicType, I'm not sure someone read about `AtomicType` could have
everything they need to understand why it's not `: Send`.

[...]
> > +// SAFETY:
> > +//
> > +// - `*mut T` has the same size and alignment with `*const c_void`, and is round-trip
> > +//   transmutable to `*const c_void`.
> > +// - `*mut T` is safe to transfer between execution contexts. See the safety requirement of
> > +//   [`AtomicType`].
> > +unsafe impl<T: Sized> super::AtomicType for *mut T {
> > +    type Repr = *const c_void;
> > +}
> 
> How about *const T?
> 

In general I want to avoid const raw pointers since it provides very
little extra compared to mut raw pointers. For compiler optimization,
provenenace is more important than "const vs mut" modifier, for
dereference, it's unsafe anyway and users need to provide reasoning
(including knowing the provenance and other accesses may happen to the
same address), so I feel the type difference of "*const T" vs "*mut T"
doesn't do anything extra either.

Think about it, in Rust std, there are two pointer types only maps to
"*mut T": NonNull<T> (as_ptr() returns a `*mut T`) and AtomicPtr<T>
(as_ptr() returns a `*mut *mut T`). And there is no type like
NonNullConst<T> and AtomicConstPtr<T>. This is a lint to me that we may
not need to support `*const T` in most cases.

But maybe I'm missing something? If you have a good reason, we can
obviously add the support for `*const T`.

Regards,
Boqun

> > +
> >  // SAFETY: `i32` has the same size and alignment with itself, and is round-trip transmutable to
> >  // itself.
> >  unsafe impl super::AtomicType for i32 {
> > @@ -215,4 +226,16 @@ fn atomic_bool_tests() {
> >          assert_eq!(false, x.load(Relaxed));
> >          assert_eq!(Ok(false), x.cmpxchg(false, true, Full));
> >      }
> > +
> > +    #[test]
> > +    fn atomic_ptr_tests() {
> > +        let mut v = 42;
> > +        let mut u = 43;
> > +        let x = Atomic::new(&raw mut v);
> > +
> > +        assert_eq!(x.load(Acquire), &raw mut v);
> > +        assert_eq!(x.cmpxchg(&raw mut u, &raw mut u, Relaxed), Err(&raw mut v));
> > +        assert_eq!(x.cmpxchg(&raw mut v, &raw mut u, Relaxed), Ok(&raw mut v));
> > +        assert_eq!(x.load(Relaxed), &raw mut u);
> > +    }
> >  }
> 
