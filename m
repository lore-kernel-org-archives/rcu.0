Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866C256C84
	for <rcu@vger.kernel.org>; Mon, 19 Jan 2026 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790369; cv=none; b=PNJMFZW7ed293ONql1A1dTcCUFI4vokClQ0s12T8sENYEAHoFa9sC5T6r0/spiIyRx/JFeH68O4ty1PeBT3ID+AuZu3ZT63BKVmbbfvbjZ+FFhPq0Ue7XMYkC1tQR7PeGEvdpVlYVMlglHhA70Lha3GdfeMoP8b2wmIdzxo59PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790369; c=relaxed/simple;
	bh=u6BKctv4khQOGwF3sR58+ZP8VrfFt6vOgdUxnwbyZEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEL3WY4FUPApiCUp7+sQbCY7dPU+P+4pixDfB7f9MfbF+/pOAB8Zez5BxO2CAbFZo7P1v64+j5gN/WYTBFHJaCtzG36OFoDOs6/w16aKu+SialIPPX90oR2HFGF4RGKyTYUzJ2Y+MA4WzEs+gW0wSR3ic1KJvdVQsGzFwep1PfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2ryMwC2; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2ryMwC2"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-65f65538a90so2843271eaf.1
        for <rcu@vger.kernel.org>; Sun, 18 Jan 2026 18:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768790356; x=1769395156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ga4T1rTKShKL1387lYEokMW72Q2esUrK3DVRNtHg3I=;
        b=C2ryMwC2NyltlvYsDkQNyNvQtIUcOB0Mxu5Wq0rlOOuUvFobeoojTnCczcCM87GquD
         iQoNrr4txL3uwn+pCccApmUy0XsrnZX63YnU6O6ceMUG8lMtIRO9PVK9BbebfkO3FNyl
         GgRDDhVDRFhwIa85hVkX2bqhav/G5wVtquDjbt2FUwYTwAB7lpNwai2PweLZlgrAYNxs
         2sRQX63++GPv5RIEqTE5bv7AsGFBHqrB0IIrH7jh2ST2YF/7lq9TK5nx2CSIXuzesHLd
         8XFE2u2fkKYNTQ9vRzIz2vVSM5C/ME7+nKaAY2oJId181N38WMqxf+EkfoeORUElseAD
         30EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768790356; x=1769395156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Ga4T1rTKShKL1387lYEokMW72Q2esUrK3DVRNtHg3I=;
        b=veVPdHZnn/ORkqSzUWTSBuAo3I/3CzfVx6I/aHoWvHwob3kWi8iR5+JPF93A7WZdFB
         2xNdzuaDnrWVrcYi86wnLLm66LIzOhblN0uPykW5PKO9kjqxucYjC55EDXaZBq1PieQD
         i1UGc3Nb4V6seRMS8niAsxhso8EZEzkBNlWXZNweXJNXFv+3U42MMHe6heXkgjgOQqZ6
         epyP2efMx6bYapayzmMtsk8F027UrHiSG+Cz3u/anJ57nja51B4lB/EFy1/sj4TBjH7Y
         bLKcgYTzvixWIveCZqS26o651lt+yrCkiV94VFX6DtNYMI3NdVbkzlL6dNO1T+2PG8jA
         heMA==
X-Forwarded-Encrypted: i=1; AJvYcCV/nGFiaHXQW6waUXOdcuM+QHta8EVDeW1UkIK97N5BJHvfAUnG+zMeJBoL0IKhcvyExzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP1ckPnMKhOJr6/s9M1TlkQ3Fd6YESYRsb+WQ8dNEVWl5davde
	oc1EtDnf5BU53r/sgzbJhO+zALOLBbDsY1Vuh/bon6IRAvZg07psmiISVl9tINo0
X-Gm-Gg: AY/fxX7yHX2Y37QHUhy0QaoPz7CXc2bhnGLNmmord4/gdCHEZF4Ud2CqeZZezVHz3Z/
	3aoydWGCpeGMCzABZX5qlLoAcnwfcIK1mcQlYc46nNfMRXxHV3sib9H0rkmOPsKMgf4C/4yoGUp
	0Ge4f89f9x5L1iyhWMfqv44h/qRt7jnnF87dfmm8Q0pRtwz4z+kuD/K4MLpeEKknjAPFSzx7cAR
	ta0FV6MAE49NQycR6Wev6QbWhmVo77DfSa2NU5WpI/hD2OjGNsuPSNlJaB979KSofCYx2qwavXU
	dO3+gpl+dilsJ1S6OTzA8x2sWYnNs9Ow82dEgwn+5Kp9u5dk3zmtQnYLWyWVlJvsSD17pzFCWvu
	ObqRMIWHYC5+VnPPrSXIOOM0+zL/XW+eILjHjE0K3TqNeZE13KkOhBdCJ4A51ZI7qqMqOEb9Itj
	IX2QJx89UAYytwPRpKa5s7OfAw1FngqDx/b/LpY18v4g9GfDbpARfQVgojEgPFB5GVLcCOCWIwn
	SiKlw1z4UEV8o01GPUnfejTgQ==
X-Received: by 2002:a05:620a:1911:b0:8c5:33da:219f with SMTP id af79cd13be357-8c6a651dc32mr1341810185a.43.1768784259107;
        Sun, 18 Jan 2026 16:57:39 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72602f3sm701200385a.40.2026.01.18.16.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 16:57:38 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id CE3E8F4008C;
	Sun, 18 Jan 2026 19:57:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 18 Jan 2026 19:57:37 -0500
X-ME-Sender: <xms:gYFtaQg1ajI27WEf2Ka7Lp_no1r1nGhAkuhhZ93-VMyYTrBI7sKyMQ>
    <xme:gYFtaWcKGAk75JJvtKdkMEfM3v4x-YaUhZ0n-bIpqyina_kDkYp5uTriOOf0734lt
    MJtL5uowvjOfnmpCbgb6oflhjtCNpBMk0OS5QZtoWxNBL4a6PUoLQ>
X-ME-Received: <xmr:gYFtaYCz2X-69P3XKjfax7csHYWDqTStuXA9ZaT1Tlov-DzgTlbZAe7u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedvveevleevhfekhefftdekieeh
    vdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghp
    thhtohepvdejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhsshhinheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepughirhhkrdgsvghhmhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhies
    ghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonh
    hmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:gYFtaS4GO-tZIdHyS4sV1l1vpA83iVyuFxIouyMx5usNjBbt33bMHg>
    <xmx:gYFtadxN2_BYdNDDBhxITZ78X0vSrCFsRlFIevyzMiwy2RCPsQRYJw>
    <xmx:gYFtaWkAghWwsyN8bPwnqBF5nCYviYuMyqJeiUm9iqVlio5dXPv5ZA>
    <xmx:gYFtafXrVa15fqLNOCFfbfYCj4OG47QtJXNB-ilhmxf_iOPRK_uytw>
    <xmx:gYFtaZP0fj_xrNNKmzKiU3fPxJ0WZFsq6ce9TFZKDz7io6X-44tjd3ET>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Jan 2026 19:57:37 -0500 (EST)
Date: Mon, 19 Jan 2026 08:57:35 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Dirk Behme <dirk.behme@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
Message-ID: <aW2Bfykqj7qz79hS@tardis-2.local>
References: <20260117122243.24404-1-boqun.feng@gmail.com>
 <20260117122243.24404-5-boqun.feng@gmail.com>
 <67e5482b-93ed-4b5f-8375-f7e68c50a436@gmail.com>
 <aWz04Tb7SSDQls8T@tardis-2.local>
 <aWz2oZqMaQHQWe-e@tardis-2.local>
 <DFRZCBBXBTM8.2BSEQFA5F28W9@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFRZCBBXBTM8.2BSEQFA5F28W9@kernel.org>

On Sun, Jan 18, 2026 at 08:59:09PM +0100, Benno Lossin wrote:
> On Sun Jan 18, 2026 at 4:05 PM CET, Boqun Feng wrote:
> > On Sun, Jan 18, 2026 at 10:57:37PM +0800, Boqun Feng wrote:
> >> On Sun, Jan 18, 2026 at 09:38:36AM +0100, Dirk Behme wrote:
> >> [...]
> >> > >  
> >> > > +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
> >> > 
> >> > uses -> use ?
> >> > 
> >> 
> >> Will fix, thank you!
> >> 
> >> > > +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
> >> > > +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> >> > > +impl AtomicImpl for *const c_void {
> >> > > +    type Delta = isize;
> >> > > +}
> >> > 
> >> > Are all users of this guarded with CONFIG_ARCH_SUPPORTS_ATOMIC_RMW as
> >> > well? Or do we want (need?) to cover the
> >> 
> >> No, the users don't need to guard with CONFIG_ARCH_SUPPORTS_ATOMIC_RMW,
> >> the purpose of this #[cfg] is to avoid surprise that when
> >> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=n arch supports Rust, when that happens,
> >> we need to add the support to the helpers of i8/i16/ptr.
> >> 
> >
> > Hmm... I guess at this moment, I probably should do
> >
> > #[cfg(not(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW))]
> > static_assert!(false,
> >                "Support of architectures that don't have native atomic needs to implement helpers in atomic_ext.c");
> >
> > I can add a patch in the next version if it looks good to everyone.
> 
> I think this is a great idea!
> 
> By the way, did you know about `cfg!` [1]?:
> 
>     static_assert!(
>         cfg!(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW),
>         "Support of architectures that don't have native atomic needs to implement helpers in atomic_ext.c",
>     );
> 

Even better! Thanks. I've added a new patch that converts the existing
#[cfg] on impl blocks to this. I've added Suggested-by of both you and
Dirk ;-)

Regards,
Boqun

> 
> [1]: https://doc.rust-lang.org/core/macro.cfg.html
> 
> Cheers,
> Benno
