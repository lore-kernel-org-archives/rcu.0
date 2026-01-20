Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2E363C6D
	for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910240; cv=none; b=AkVGjaU3EPEXlCG1b1GXgyMuNvhiuoLscG7VEJkOedq++x6MQC6JjouFlgVxJzqDFg+UzX9If/Cb1z4BvbSaT/s3w4uvNXqm6fAZKt8VjUAuQgtrWV88uXkHUS4wt/Iu9lryIRN//jbPUpkt1ZZtUKW99E/PfVsQPyJFY56bi8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910240; c=relaxed/simple;
	bh=agm9KBOhBN8+g7TLwkDdan99LAXg6mVvt4PoNScAJO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqzHOcuT4BExlEySLC5BuA+CZcEoZpWm5GpKEXjfabbMTx4YeTiGlTqJxA37TRxJ8zibJnSjokQAK3G3koQJqWYTKYwZk1MzYVkKee1pjCmQj0fcsSzboWcHzAn84vDd1FiXLZ8r2ky9tNSyV7WPseEp9pg/l+RuYU6+5VftNdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oe7kYb4l; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe7kYb4l"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8888a444300so55544746d6.1
        for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 03:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768910238; x=1769515038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sTvvk+KdM5q/e/gdJHMCdACqZD1qP5BBwxDDuLN1Zc=;
        b=Oe7kYb4luni4tszGcWQd5fqNom/YPPJyy28q5ljwXG8ipGIqmQTFrvDiL6bmJJQfP4
         rerotuX1IZ9yijRXXLF/OE6HQD6fuKMN304iKsZ04PjL+xea/7Dnx2/dYg7Lr4UH/0so
         267WHksgrzqi+O3X6Ce5KKf7qQSDVd7/7vWnsZtFHajY/0vBfE0Z4gE8oOSEj3uor+bC
         2YCmDjrrzQHrucFew75L+69zg1mXTa4nsO26+ltEBQgnweQUO9e5tUz18BMGqvyfpti/
         NkUdBfwyR+QxWVhEaSBe1cZG1w2xlRw0H9irQE64G1SoTKsZelqcH+MUzVDa8pVVlmBv
         Wlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768910238; x=1769515038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1sTvvk+KdM5q/e/gdJHMCdACqZD1qP5BBwxDDuLN1Zc=;
        b=fECe0Q/SHl2B+yt1C/EHTF9DncPkaYdyAMT3lCojhndS1IDTilgruha5Y//Ny75TbP
         ABHd4ZqHk+1gas5GNK+s66rH81pLq6NT5Hr3IpIZvvyL+3fkl1cQPJGItxkQtzzBUewO
         N4AWizu2hswJG5ImqL9B2cKtq8SeR9oxavA3rcV3LANcD/oojNN0ZsjhVarsomHa4e21
         gkjLngynfcwjyHdf/a8V1hMd5h+sC8aJ2F9+C2ociD3ieLINcfH80zNS26LXbXnPAD3G
         SMEZkM2EZNXtnHK2+JBEVgmFAYqygJLBTFSBTF9mtiDESFxxrqYSjuIIo6mleR4Op7yl
         BGrg==
X-Forwarded-Encrypted: i=1; AJvYcCWGBzRcMSkJ7XW+cLQPVbxW0VNuwCELtW8M/aCRnFMYyYkAV0cRMPNfrQg7gIsG2FmHF0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YysGlYVSwhJMtF8AaOt3jQCovAhYy8yi5+5WFc7qmsIa8VAx4d8
	MRFEplW/pe8DYWw8dCH1cDFeWaFidPpgo/6uSldGQhjxrTfZU6fIY0g+
X-Gm-Gg: AZuq6aLo3pCduTFi4waqpEilsCBNhNNOaERERoCDgMXo46iZ2BiEPDNhQePeodx4vZd
	F9JnyU6D8wxdHXgOM0kSgvmQr2R6Yh3qDcq0UQdbZNfPUoAzjjR/7Ek0xAvtyBc8fHkE93Z6Sx4
	3LDsk09aL4YOspd1IwJdJ/v/1GJyS7tQH1+KC832J4mX2u1wmy5EFUqgdY5HpFUFwuQHoTXUpgr
	4e08dfby4DGesn0XoVO27dQ9kVruFHapW9TGEpyU/YViYl8eAsnd7wCRf7YhYJoCpQ3d5Ykf8Fq
	l4pFTReBxNTEXnPMwzUwIPV1xTlr5O5NwIddCqKkzAWLWS+bVLa1mgW/89Ld1Nz+xRE7kFk7vs+
	BNkqE+nYjGQz8kLdkU1vNMhVeXUt0wK0mmLQ0fg8UyP7ZM87hdfvEDxG14+miWc4zpqTngZw+xR
	nEZKUeYeR8HgoxVpAq6xtWvr19WwFWTQOPmYhbdOxUUW0FMHZFRvaEynuL3F/HCv5colhNvqwU7
	RgQvOnxf4kv+MM=
X-Received: by 2002:a05:6214:1c43:b0:88a:568b:f4af with SMTP id 6a1803df08f44-894638dc532mr22404656d6.23.1768910238061;
        Tue, 20 Jan 2026 03:57:18 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8946299c551sm13245996d6.51.2026.01.20.03.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:57:17 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id DCA9FF4006B;
	Tue, 20 Jan 2026 06:57:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 20 Jan 2026 06:57:15 -0500
X-ME-Sender: <xms:m21vacCzG6-T_rWhIyDIOASR-QuxfFFJJtAaHTY9jKfWjGVhO_mI4A>
    <xme:m21vacVltqsyBGNXqCwRZJn0jTRUe56ZRHB-xxV_4d3yIxy-8JtBruF2-nPkF2WB_
    PpEebT7WMskI7ty3-pqAyQCjdfh8Ay9alJq6wTH4TRSnnz9SwR9HxU>
X-ME-Received: <xmr:m21vaQfSlsTR07OB8xQcym423pExHsSRJnPokPGzSI-qEMxR5MUu-sbY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtfeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:m21vadu9NTyO-8c8fjvFpAIkKkZjsQorGjrCljhcta0DqPCcX5JmEg>
    <xmx:m21vaXhPCcMyQwOU8DW7znL7bLWpIOYMBFWH3YLk18vEXQE21xMpig>
    <xmx:m21vaTt7hPFbjXeE3awlehGQKgwT1gaPiPFBaERz196TRPsAhbLx6A>
    <xmx:m21vaR7AXfN8K1TUIyb63g7LJGRp1qet1nvxHSqu7MrdpMSf9I5zqQ>
    <xmx:m21vaWt8fhd38L-xsH2CGzh3gnJeO9mkvprmD3nMYFFizKf3qz5qRjiJ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 06:57:15 -0500 (EST)
Date: Tue, 20 Jan 2026 19:57:13 +0800
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
Message-ID: <aW9tmbVWaqSVOiD8@tardis-2.local>
References: <20260117122243.24404-1-boqun.feng@gmail.com>
 <20260117122243.24404-5-boqun.feng@gmail.com>
 <DFR0Z3KHYS62.37Y0R286DPTUQ@garyguo.net>
 <aWxfV4Y3fnNR0Kje@tardis-2.local>
 <DFRTTN1T431A.2BLP8QZY02E6Q@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFRTTN1T431A.2BLP8QZY02E6Q@garyguo.net>

On Sun, Jan 18, 2026 at 03:39:40PM +0000, Gary Guo wrote:
[...]
> >> 
> >> How about *const T?
> >> 
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
> 
> Actually `NonNull` is internally `*const T`, because it's covariant, unlike
> `*mut T` which is invariant.
> 

Ah, right!

> Now, for atomics, it's less likely that you actually want covariance. So this
> difference matters less.
> 

Agreed.

> >
> > But maybe I'm missing something? If you have a good reason, we can
> > obviously add the support for `*const T`.
> 
> It just feels that it is somewhat inconsistent. There's no good motivation right
> now. I am fine to leave it out and add when needed.
> 

Yeah, we can also add it later. Thanks!

Regards,
Boqun

> Best,
> Gary
