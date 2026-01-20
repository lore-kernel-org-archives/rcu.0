Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C823D6465
	for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948642; cv=none; b=G4QgoNnlaXbJGfo5iaJc4rLgunRHBv990hTn7Qvtw/KO77dc6goXqtAaKP+VwHVBfsI6D0a47re6ouiCliAgX8lH7mqMpprq8po8vL9cLzdXSQM3bnfqkidKbRhvNfd6aCYADpBV6lemEGjS9eR9rH6U2v6p8rs2IhCw4NTgfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948642; c=relaxed/simple;
	bh=SCuvlNzEZ7UQ+2kx4IZoBg20PyTWVc8GwsruEBfjr9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElkuLBa0XakZRr6+F8i0dy9FBMtRAGgT/m1w6gpDlPdbs2+30MrvM56jWze4vwm/sPYhg4gORAs9yN4TVxGjplBG+Zv1ix7NnPPIX26+ynRCfJvpBsVjpS9VdaiV+W1ChOKGqyvg934uVwYdDF0CPQVwllhg0EXj+SQjIq23fNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9y/tryb; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9y/tryb"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5637b96211aso5049393e0c.2
        for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 14:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768948639; x=1769553439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaX7O8khQ4I4NV6eOiLSvzgbdQ/3C6pFK5pqXcxYMdw=;
        b=Y9y/trybZk7GuHgA4w8jPxSdDwcuyNH9rlNdpKxuF0dYl0SN+aHE+kOHusnIMNtMEq
         HDpb5sBfaSf3UfLJyE9eHgA4gpm9wH9d9wiM82pZV7bllUoQkRULPsx12TcA3vKE/PgK
         3FGy25WJ3OEE9wS2fs+ZSgcXPEfn2JyFZoa5ujHMV3Vr9oBIsJtARSbmNVNeW1m0n4BR
         79es9jNuX11uZzzdmYcLTeeHMDtxJVyvEzwb1qP8PC610G7MT/9p32LnmlNsZeSd1MxU
         Jr17k8OZ3tXfWcxQM0BEMb9HTW3vzMLsi3i9rWppHElX6wBEGFzKX28HsgSVhXHYHF/O
         OEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768948639; x=1769553439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eaX7O8khQ4I4NV6eOiLSvzgbdQ/3C6pFK5pqXcxYMdw=;
        b=qyoqdZuBrnLdEHQTbMofWkgkclWcV8Wegffr5W7aE7c8lEeDbOrEkcTfjJGKaDVggX
         tu2kdbYxCI6F0BCFovj3d5XlXMEMYSffcRgAoeQnusKJ3MGQ82/X8Txp70T6vDjyA/fw
         93X6R8kOkcqvu+oPT85lfepIzuw8Sc4kUX97feFjNc+A4uV62Fqz0EQ/hs6qNK2QUkZk
         qECkoIewOC9U7PS01MbtF9upYf66n7szNmGCylmen7se8V1VKzMLkvYsEAol/7X5xyQw
         CdeLv4LUXdsxf8DEjv4QE5sRI4aFS0kubuapuyQqjwRhRMd5Tj/Jk5RW7IxUNknXscfG
         u+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUfvUq4A2onhBPiPXDYeGGcgRcshhcL5PQiiaYSTGyLNc1ZWof58CgjO6t0s33rf8+DEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQEk7ACAIKYgvQd1tnZNrjmKZ+qW8bq4PI0c8u6hL+AuSZmc9H
	Lzt/jhzZ7q4PzTUrgiXtO5ob7gNSnizuECaxadGItV4e+5PSgtP4Lp4zcT5Mz9WU
X-Gm-Gg: AZuq6aJqqM7jgQJbW0KoCnkk/0T6EYQR3lWlc3+iCHS6dQtUNhoyY+TG88oHU1MEmlE
	dXhyw32XZheqg23QptYpGyPUfQVO8M1hl4odq8imJV+sVUpEUDO6elHJmKW/po/3CbG6U+tWyY0
	z3eJMfjbkwS4ysdT2uASjotBm0n0uUkWacSdboQ4EPsOA1e3L2nTtcL6mDdEVbOcYErErDK7eAM
	6JDg5xem/QeeZ3H/ukDoMLYK1CdWeC4piFuxjF38ZHKeW5aKV1gquIVyoMRxN3d/66X33yIqGQe
	fXR6Z2o76u35oOW3FU3u/97bLDBxbyEXUF1XqBojRk0uuh2ostyZ+8bq9e1LeRwoArDaIoAmqzH
	nEQzQu4RW5JgTOCWvhp1Gw2+8PohMBnGP0hsUswfPl24zSkFq/GnYSQRKai47LR/qPtn2Myt6UC
	P7l3umzOPMGw4hSPF9cvkRN4m05WmGGpx2m8KwJ58lA+FG/6VrLpW+dj3dX8ehLatZjL259kfZB
	Ax27FJeoFO7tE0=
X-Received: by 2002:a05:620a:178e:b0:8c6:ab8b:29cf with SMTP id af79cd13be357-8c6ccdab52amr397765885a.17.1768943033146;
        Tue, 20 Jan 2026 13:03:53 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6043a6sm117196466d6.18.2026.01.20.13.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 13:03:52 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 33A63F4006D;
	Tue, 20 Jan 2026 16:03:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 20 Jan 2026 16:03:51 -0500
X-ME-Sender: <xms:t-1vadypL7SsgCGM6rVDjMNECCch_7Qf8xV7PbzI1S1GK2MHE9PkAQ>
    <xme:t-1vaSYRW3MCL0PU9cCOnvykNhtFn6GT1mO-zNdc0uSOh33dPtkgiEFUTiUHLNvM4
    Yc39BM5onfN426QW4Se46t5yZ-oz0Sz5AcSpBFa-V5Obbxw6r97eA>
X-ME-Received: <xmr:t-1vael65wFlH89SrZu9HfSGxBrvTjMzjw7a-AFTjtpSR2e4WOHonDOe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedvveevleevhfekhefftdekieeh
    vdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghp
    thhtohepvdekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhho
    shhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgt
    ohhm
X-ME-Proxy: <xmx:t-1vaXGMdiL6RyYv6fp_ak6JFThdyGIvTQsKB-7qsmu1Bxhw_sDn9Q>
    <xmx:t-1vaVil9uEEBeTj03mW7r4sksToz96vXDQyQsQuM2DeTG4wu2AkRg>
    <xmx:t-1vaZlgbHBOSdCAGofZSCyyZfYJYUphyEynBNnurJQp1l0AuWVyaQ>
    <xmx:t-1vaecaRnSk4cw1RssSwl33iLVrtKWD2YF1HAIXlvMn3iLdJjeOzQ>
    <xmx:t-1vaTFmXsn3NLnKwjYZD8KVZQazLb8HVQUjLz1a1J0T8c9qWmXidbSB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 16:03:50 -0500 (EST)
Date: Wed, 21 Jan 2026 05:03:48 +0800
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
	Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,	Dirk Behme <dirk.behme@gmail.com>
Subject: Re: [PATCH v2 1/2] rust: sync: atomic: Clarify the need of
 CONFIG_ARCH_SUPPORTS_ATOMIC_RMW
Message-ID: <aW_ttGVK11On-SIW@tardis-2.local>
References: <20260120140503.62804-1-boqun.feng@gmail.com>
 <20260120140503.62804-2-boqun.feng@gmail.com>
 <DFTKOAJE7DSB.1QJWJVC4FJY0O@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFTKOAJE7DSB.1QJWJVC4FJY0O@garyguo.net>

On Tue, Jan 20, 2026 at 04:54:51PM +0000, Gary Guo wrote:
> On Tue Jan 20, 2026 at 2:05 PM GMT, Boqun Feng wrote:
> > Currently, since all the architectures that support Rust all have
> > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW selected, the helpers of atomic
> > load/store on i8 and i16 relies on CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y.
> > It's generally fine since most of architectures support that.
> >
> > The plan for CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=n architectures is adding
> > their (probably lock-based) atomic load/store for i8 and i16 as their
> > atomic_{read,set}() and atomic64_{read,set}() counterpart when they
> > plans to support Rust.
> >
> > Hence use a statis_assert!() to check this and remind the future us the
> > need of the helpers. This is more clear than the #[cfg] on impl blocks
> > of i8 and i16.
> >
> > Suggested-by: Dirk Behme <dirk.behme@gmail.com>
> > Suggested-by: Benno Lossin <lossin@kernel.org>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Reviewed-by: Gary Guo <gary@garyguo.net>
> 

Thanks!

> > ---
> >  rust/kernel/sync/atomic/internal.rs | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
> > index 0dac58bca2b3..ef516bcb02ee 100644
> > --- a/rust/kernel/sync/atomic/internal.rs
> > +++ b/rust/kernel/sync/atomic/internal.rs
> > @@ -37,16 +37,23 @@ pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
> >      type Delta;
> >  }
> >  
> > -// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
> > -// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
> > -#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> > +// The current helpers of load/store of atomic `i8` and `i16` use `{WRITE,READ}_ONCE()` hence the
> > +// atomicity is only guaranteed against read-modify-write operations if the architecture supports
> > +// native atomic RmW.
> > +//
> > +// In the future when a CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=n architecture plans to support Rust, the
> > +// load/store helpers that guarantee atomicity against RmW operations (usually via a lock) need to
> > +// be added.
> > +crate::static_assert!(
> > +    cfg!(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW),
> > +    "The current implementation of atomic i8/i16/ptr relies on the architecure being \
> > +    ARCH_SUPPORTS_ATOMIC_RMW"
> 
> The printed string when assertion fails will have 5 spaces between "being" and
> "ARCH", although it probably doesn't matter..
> 

Are you sure? My test result shows:

ERROR:root:error[E0080]: evaluation panicked: The current implementation of atomic i8/i16/ptr relies on the architecure being ARCH_SUPPORTS_ATOMIC_RMW

similar is the following playground example:

https://play.rust-lang.org/?version=stable&mode=debug&edition=2024&gist=5dd0098247503be792bc35cda8f2630f

Regards,
Boqun

> Best,
> Gary
> 
> > +);
> > +
> >  impl AtomicImpl for i8 {
> >      type Delta = Self;
> >  }
> >  
> > -// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
> > -// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
> > -#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> >  impl AtomicImpl for i16 {
> >      type Delta = Self;
> >  }
> 
