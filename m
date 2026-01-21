Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EF2428498
	for <rcu@vger.kernel.org>; Wed, 21 Jan 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997463; cv=none; b=TR/7c/zvzhUwlJRlJTf2Sbkwv3yNk7c+lPeOcXsZFLN3mi+f+jemNjvo4tK/kftJKyMfHwtTvV4ATeQr8Py931cDwgMf1iFgzECzD5vL36+E24IwPEfe07UGmzXGavxcbTb5ntNEv5hiuneXZU9pNg0/5RYXD9KrYaYbytAVtO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997463; c=relaxed/simple;
	bh=ylscVMtDsSAWluUPcU1ZBTpSkzchflyIObPGvesyXuM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rpjDtsszklWEY1oilqyJgE0l5MFIEjnJCPFxd/JrAGVjJrVgjsjdHiBRApXnVhCmSX7xys6V3jFmcfjFBLk3pKHQqwVAmwmEayp8Pn1N+elbhHj3R1a9qEMSAoP15C3yDRE6l89HPPtUaCOhaPOFlP2F61JAK4U1lckqnvutFGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNp6jT2O; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNp6jT2O"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47d62cc05daso46897905e9.3
        for <rcu@vger.kernel.org>; Wed, 21 Jan 2026 04:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768997455; x=1769602255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ziR3r9m7pUVvYH96OZBkYpK+ngyEyWi7rW5109gK7C4=;
        b=mNp6jT2O1Y/FGHhtA1pGHtNKQscKKZkq455Mmb2wQxQjewEwRaoRwabP/F+ZYVHLsH
         QyTdt/ptuIUnJKFQqAq1zbYioIvET58VSH5huRtcq+h7TYDHz8v0962Kl55oYiZwjNXL
         G/mse2feK6crL48Dgf1Hvu2H8YFymYuKq7qMP3v11DpzeVWyQUQbIMY61WCoYuYOQJH3
         rG3pLoKyTQyV9vlvkA+IlXlMRrfQio+sY7lzTyPTCrf2diwGzwQIlWQK4m+2nUtKaesn
         oNaJ91H7xWQdjRAl7eIy8XD8n7MW/JxkLcHBJ1UtYXa5fcbi/gLj+wSTGnAuHOax2vjx
         eieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768997455; x=1769602255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziR3r9m7pUVvYH96OZBkYpK+ngyEyWi7rW5109gK7C4=;
        b=UHP40VjoVB1bHhwj8ftpEH86BqFa9RYWWgv2nNcivE8jHBBnOOgCwH4v5FTZi3NV2B
         S+VwAkwmMKm+SOt8SHrO+HndSnYl81uyzXVmuLdSdGfHAydguJbBQzQUB30kfIN2Bu5H
         ryWzKtwTbOazur+sysRTvyvzuSY8Asr0tUoHpoA0B/2DnQDfdPa5kfvpdH/9gqg6xWco
         vGxAbYrEZCEF3F9uAUZwy20910szNBQMIv6cmtA83IIgUmbd8Col9dBsegAAL8pQGx14
         L65arVC+JnIHLvpJLrxybm0jy+PR00XaB/q3FPVbiLOFYj9EAo6FJfKw0kWkFuKZ11Ud
         FNiw==
X-Forwarded-Encrypted: i=1; AJvYcCUCj145VIRXzqS5TdLTiGkWBKNSODuk1A2ErFMY4Ts8/44UA+aDHuGlGPd1yfj9skqRwnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsNhtbr+P2ofYCuX5PMS/Va6SbEEAdDnUba9zl4YuwPK2ziZxp
	GWVqOaJ4aGKbnAmuuhJEokay7VmAoNA+dKYR/2PetA5OGH5DYJ+tp7slbHBbMsoKrx4HfQbhLAS
	Aw3v5+e2/kRIRu/qCyg==
X-Received: from wmqh8.prod.google.com ([2002:a05:600c:3508:b0:47d:5dae:74f0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6388:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-4803e713cc2mr75064445e9.0.1768997455476;
 Wed, 21 Jan 2026 04:10:55 -0800 (PST)
Date: Wed, 21 Jan 2026 12:10:54 +0000
In-Reply-To: <aWuV858wU3MeYeaX@tardis-2.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com>
 <aWrSkAPFkdH_tvtN@tardis-2.local> <aWt4muGXbe7lBmXt@google.com>
 <aWt8Ze-otTkexNIe@tardis-2.local> <aWuKqLERqpNz9qtz@google.com> <aWuV858wU3MeYeaX@tardis-2.local>
Message-ID: <aXDCTvyneWOeok2L@google.com>
Subject: Re: [PATCH RFC 0/2] rcu box container for Rust + maple tree load_rcu
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Andrew Ballance <andrewjballance@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Sat, Jan 17, 2026 at 10:00:19PM +0800, Boqun Feng wrote:
> On Sat, Jan 17, 2026 at 01:12:08PM +0000, Alice Ryhl wrote:
> [...]
> > > > 1) "relaxed atomic" does not sound like something that provides an
> > > >    address dependency to me.
> > > 
> > > If you look at rcu_dereference(), it's a READ_ONCE(), which is the same
> > > as a relaxed atomic load, and yes in LKMM, relaxed atomic load provides
> > > address dependency (Please see the DEPENDENCY part in
> > > tools/memory-model/Documentation/explanation.txt).
> > 
> > You argued that we should rename READ_ONCE() to atomic load on that
> > other patch series because "atomic load" naming is better than what LKMM
> > normally uses. Fine, but relaxed atomic load is a much worse name than
> 
> To be clear, in that series, my argument was not about naming, it's
> about READ_ONCE() being more powerful than atomic load (no, not because
> of address dependency, they are the same on that, it's because of the
> behaviors of them regarding a current access on the same memory
> location), and we want user to specify the intention more clearly.

Expressing intent more clearly is fine with me. I still think it's weird
for us to not have READ_ONCE() when it's a primitive operation of our
memory model, though.

And I also think we should consider using an implementation along the
lines of what I shared for our atomic_load() or READ_ONCE() or whatever
you wish to call it. The perf impact of helpers makes me sad.

> > READ_ONCE() if what you want to convey is "has address dependency".
> > That's not what "relaxed" means!
> > 
> 
> Also note that my previous reply was explaining why we don't need to
> call rcu_dereference() from Rust, because implementation-wise the
> LKMM relaxed atomic load provides the address dependency. Depending on
> what we want to do, we can limit this address dependency only to
> rcu_dereference() and make it a special case, this means we disallow the
> address dependency provided by the "relaxed" in normal cases. Or we can
> add a Consume ordering (a type alias to Relaxed) that makes user to
> explicitly use it when they rely on the address dependency. I think
> either would resolve your concern about the name of "relaxed".

Yes, I suppose that would resolve my concern about the name.

Well, I do have one partial concern there, which is that the wrong name
will show up in stack traces as long as helpers are used.

> > I suppose you can argue that the word "relaxed" means different things
> > in LKMM than it does elsewhere, but I looked over the doc you mentioned,
> > and there the LKMM calls said operation READ_ONCE(). The word "relaxed"
> > does not appear even once. If we're going to change terminology / use
> > new terminology, let's at least pick terminology that's not
> > contradictory with the rest of the world.
> > 
> > > > 2) How do you intend to provide mutable access? By waiting a grace
> > > >    period?
> > > 
> > > Please see the {read_}copy_update() in the RCU patches that I linked.
> > > In short, you don't wait a grace for mutable access, since in RCU,
> > > readers don't block updaters, but instead updater will copy the object,
> > > atomically update the pointer and then get an `RcuOld`,
> > > which you can either synchronize_rcu() or {call,kfree}_rcu().
> > 
> > Hm, ok. I don't really need that. What I want rcu for is the internal
> > maple tree data structure, so mtree_load() doesn't need to block on the
> > maple tree internal spinlock. The contents of the box would be protected
> > by a separate lock (probably via LockedBy).
> > 
> 
> You mean after `load_rcu()`, we could access mutably by a lock? You need
> to hold that lock and the rcu_read_lock() while mutably accessing the
> return of `load_rcu()`, right? That is basically using RCU as a proof
> for existence.

Yeah, that's right.

Alice
