Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14491367
	for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768655516; cv=none; b=AbD6rkTtfxu2UjkjYaVnJ6QVNFH2mGGWX73Uyx11KnetsRWS88iBQ/9V8/1q7Z8DQrvuQhg88dyKXr2jxllyS1ZkDp8/spDdrqkuNSqM8JU60nleFhuwZQCe4TFoioZBBYqp+Lg/H5BNkPQSARqZAan9JNKvdLraa2dt3c+UorM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768655516; c=relaxed/simple;
	bh=F9+NetmOvfbgFjslgvJwK7ZP49AbY0olv9NCAZ1pnFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC/9rTrRlDI99neSqP/cvFAcxPQWX0Ei45i50S5dwR8EGmvYVh1DGBMckwp6Ta92owYjaSsdZVz2PCK6knSEYYbxaVsjkvntj3C7jIADJ+6WY3SKLcbMUMJygGPmxbrTIrddUhkIKHaDlahzrdS1qlQCRFI/wbSC9ahPOGisiLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTV4OR8Q; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTV4OR8Q"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88a2b99d8c5so23844306d6.1
        for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 05:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768655514; x=1769260314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTrHmEc1BYd79fY4MjqTS6sMPKSqsWTUhgoBbfphsL0=;
        b=aTV4OR8Q2kYqFCxCHgWuOCs6uGDptnVVby5EGdflQys6tPoN8E0WKgpNfzfznFXipc
         f4Ogy97L9qWgA9asx0cIzgbn8z3kSEyc67zXuNAbQYS65VUQt6Z1f+CU8dlM0+4ueCc2
         QJm99nH29WPvYC/zjwth0x4FWfH1gnDVPzTCdKBt9N7ub8jEFKv04VLsD5oxFYvSt7D4
         vXih48KYKQsC+9u533SVsmXT5En5wUslWAVhaD0kg+y95A6E4deHPWNG3uSoUuJcC4JP
         kKGnnbGtt8wWvqRpSIo9LzY0JSUtcn+eMBVeZ4YrlBef6pXoJvqFRDibrlT07Xay3nn2
         2ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768655514; x=1769260314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BTrHmEc1BYd79fY4MjqTS6sMPKSqsWTUhgoBbfphsL0=;
        b=WXs7WEB8s56esUQIivPx78SUzV+naaWEuLX2FVSsEogyEsWQOWtze80JFHi2Xp/zK0
         n/AGERd4KntIR/+HLZQ0PmqClsgQ8SYvUMU87THu0mOTyGnMvpZ+c6B6fiy+1LeZcy/N
         uVP9USFmKYCscIbR7NEDgptRgaWcStm3jheSSuT1Fwl/x2Ar7nRnEOr+ghsP7vn4I4pL
         M5uLOVbIF2FZCnSzsO5pMpNls3MBodZJgHy0SIgwo82/X8KdpKxAk86RmK0HZQh4jaGi
         o1PCe271yQcZqzQBlvWNGKu703dc7c3yYIkAt0sWSSkX9s2LDQ5RfOT1S3E+eJOwUi99
         DdXA==
X-Forwarded-Encrypted: i=1; AJvYcCXDkAe6ErS7fNK4+XnT33WdHOTIRtLwDyX9RKa+pL6tI7hLNfXOMkDq4L6uWEwlx7EM5HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTprxBGHqK+DX4TJbdgNeZmVhNpRPGPGriz1FYgTqVUxcVCU5b
	307Yf6TKPTnqzZKwT1cxNeYqV/WNZDnvuHk4uVCcYn424ArWJ7jl93aE
X-Gm-Gg: AY/fxX6ej+NXVyEOn8Kox+WCmGbWanXPreNGOst/s6F2eLgyDvhHfasK9eaKhaM6eX+
	KBR1NAEnuUkg6GOJdodfonGL3KwIt5Wegvt+/ebg/luaV0Jvj4OF7BenEWsqQ1HB7ycj5UYpNqx
	qSZeSA65M2I89EDVU33QmkANYSCZGzs5FqDHrsshplMN0aPPLS27E1B+xdZY0Vted+zP/8GKuEE
	NggU8RTZTRTLNOi3Fh7+xJPr6IogKfNrB/Gnf6kccUzWKs2qtPRJ7c7mKqvR68rQYLcxfH4wuWC
	YhObwWDiyhZT69H45dzQFiWk0OLA0+2gMP5jbaWfutgxjUrn4ZORP4cwoFCqcpMSqkKg58n7hIl
	EfUVaxKYiEH69oLIgzgUp4fA+g/rIWB9L2MnlnkZr9k5k6NhBNr9W5ibj/BBiHlVSHPILQU3RLy
	1sN87DfD/I2XMKAyvSAmRN7340gF/by9i5Lvpzko+UXo2JUYg4QHtrk1bhSvuufilGAHGvt/ZLp
	KKP0v4wy+YMRm0=
X-Received: by 2002:a05:6214:cc1:b0:892:68f8:aaa6 with SMTP id 6a1803df08f44-8942dd29578mr77537336d6.18.1768655513740;
        Sat, 17 Jan 2026 05:11:53 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6b22bb7cbsm154629785a.39.2026.01.17.05.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 05:11:53 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6D76CF40070;
	Sat, 17 Jan 2026 08:11:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sat, 17 Jan 2026 08:11:52 -0500
X-ME-Sender: <xms:mIpraatouuzYmY290PICbgo-cUjJ8YERdLYtdps-8CE5PUvoFiSQFg>
    <xme:mIprafWx7i08mFu3COd79g5ZIRMx-wD1ke3oj52cc39PGqEq4IrdHBt3_JL2nPlnU
    WO9zfBF8ucNXitKVaiJbrcOdOIUzJySLi8LPKISqiDsQjNX92jNpw>
X-ME-Received: <xmr:mIpraTHqN9021MJgEklW0YJorHzIgFQZyHze1He0zNc-KbmczYITFscF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedukeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprg
    hulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihgrmhdrhhhofihlvght
    thesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvg
    htpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghj
    ohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsih
    hnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:mIpraRZ0E7gQgihiTBQGdk8NJzk5LHjpDnTsajNwQqCynVnyNvCabA>
    <xmx:mIpraYEGZCkdhSLth-YP0-uFI4SBokX8bsf6KZSefEJ9ZP1LCK-8tA>
    <xmx:mIpraezwNK35Y-fH7Km4_s8sjxZ88bvhgy2T3d4O0SuvtsnG1uNU2Q>
    <xmx:mIpraSFY3y_AZlldHk6dUC5yFgvZYgveNpl1JLcNkKFgoy1vEiRCoQ>
    <xmx:mIprabvE9lGOY8-3epT5PTdzFEn1xPI2GBg5_OGF8Og5Nk64i3jcIzXQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 08:11:51 -0500 (EST)
Date: Sat, 17 Jan 2026 21:11:49 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/2] rcu box container for Rust + maple tree load_rcu
Message-ID: <aWuKlR4a-VJhBeWj@tardis-2.local>
References: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com>
 <aWrSkAPFkdH_tvtN@tardis-2.local>
 <aWt4muGXbe7lBmXt@google.com>
 <aWt8Ze-otTkexNIe@tardis-2.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWt8Ze-otTkexNIe@tardis-2.local>

On Sat, Jan 17, 2026 at 08:11:17PM +0800, Boqun Feng wrote:
[...]
> > > > An RcuBox is like a Box except that it lets you obtain a &T that
> > > > outlives the box by a grace period. It does not allow mutable access to
> > > 
> > > I think the `RcuBox` can be folded into the more generic RCU pointer api
> > > [1], e.g. Rcu<Box<RcuBoxInner<T>>> where RcuBoxInner<T>: HasRcuHead. The
> > > benefits are at least 1) we use relaxed atomic read for RCU readers
> > > which guarantees address dependency that RCU needs under LKMM (while in
> > > the RcuBox here, we just use plain reads), 2) we also support mutable
> > > access as well.
> > 
> > 1) But mtree_load() does use rcu_dereference() to obtain the pointer?

I see, I need to change my reply to "RcuOld" below..

[...]

> > 
> > Hmm, so I looked over [2], and I think my RcuBox is an RcuOld<_> rather
> > than an Rcu<_> under this model. Though I can't afford to pay
> 
> I don't think so, `RcuOld` represents an unpublished object while `Rcu`
> represents a published object, you can update an `Rcu` pointer to
> another object, which is normally how you update with RCU. But maybe
> it's easy to discuss this with updater side code in picture.
> 

I think a more accurate reply should be `RcuOld` is still not designed
for the usage of `RcuBox`. You're right that `RcuBox` is not an `Rcu<_>`
since `RcuBox` don't have the atomic pointer part, instead it relies
other atomic pointer operations to work (for example, the
rcu_dereference() in mtree_load()).

`RcuBox` represents an object pointed (and protected) by RCU.

`Rcu<_>` is an atomic pointer that maintains read and update for RCU, in
your usage, you don't need it because maple tree does that for you.

`RcuOld<_>` works with `Rcu<_>` to provide an API for users to decide
how to handle RCU reclaim. In Rcu + RcuOld design, RcuBox is just a Box
because these two pointer types handle reclaim + accesses.


We will need to use `Rcu` and `RcuOld` where the RCU access code is in
Rust.


I think there are similarities between `RcuOld` and `RcuBox`, but they
are sort of designed with different usages in mind, lemme think more..

Regards,
Boqun
 
> > synchronize_rcu() for cleanup - I need kfree_rcu().
> > 
> 
> That's something we can add later, for example, we can give `Rcu` (we
> can add the similar thing to `RcuOld`) a generic const like:
> 
>     struct Rcu<P, const ASYNC: u64 = 0>(..)
> 
> where Rcu<P, 0> use synchronize_rcu() and Rcu<P, 1> use kfree_rcu() or
> call_rcu() (once we have HasRcuHead support).
> 
> Regards,
> Boqun
> 
> > Alice
