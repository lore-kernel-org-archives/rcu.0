Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C522E6CCD
	for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768655533; cv=none; b=g8Y6vUsWDx3drWYvw+7XTMGipjUeq0L8n2mf3vySmxv285qPCe9X2tDgHzzmzVBqaXrYEBtXy2nQypiQ+xHFuNWe/HVHeP4pvz7D+vrfhiwsDc6XlU/SfCFIyMvYYTg5ZL4y5Kx7aKXQpxnOHHUxw+9BXEvGHqMgC8Z0UKZELVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768655533; c=relaxed/simple;
	bh=WaWIqYIvzqyysLkFGBt6V3NNILdK5e7uRhOvXIl3cGY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZz4UErW6zlC/JSbDMi3zpf2HMpLbNVfkx/alQd/a1axmmCloAaIDdyWSHylEXm1H5bA5viW3ShfqT+9fO3CZ6dbDuXja7sHNGtP6XhxU11NvY9+yYsmZpfKhWKMta7KErmnLF/IsRq/tZAK9YQTRY0/8atNwPcpcLGGbUxMKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svk2yERT; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svk2yERT"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4802bb29400so4082265e9.0
        for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 05:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768655530; x=1769260330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/Q6sSsKEIGtbP7mr4JWHCQZmo/e0ttTsHB6ivhULNU=;
        b=svk2yERTxANYcjxaXKOjvBGLW3Qtu78jYOpIgFX8fiV1d7i1ykHdVg6QTaqe3MRfli
         Uv8pCk/3mHayah/t4BUQgTuKjLllHEav6DQTrPS/dqlSCQywJqX3jmvg6ZMtA6eTE19h
         oxv+3RodAKBErLye5TwBfYGqb1jVJZfL7hB6fISciJj+SNG2Kbu5AGTuAeIAgimzCbMg
         lJSEi6U48uoAnBYOHet0Uy7UgDrPVcZC9/VCzU4uOgRZI3uhqs2R8YwSfDhreq9tX090
         BoxxrhkauyCqw8zzB2+G8uH874uMsPX3/rwNXxwIrshlLfNOqpJyiFetYQiIENHJujj+
         8WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768655530; x=1769260330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/Q6sSsKEIGtbP7mr4JWHCQZmo/e0ttTsHB6ivhULNU=;
        b=RakTBxyAWOL9jSp59QwNzMRWXcRJQ0ejhogx2hxtDdTAIhEf80T+4tzc9TILUu56jK
         IAkiu0i50iYl4/BhHEVHL0bJN0eE6Fa318/9GjUBtDYIm4bQyXPGQWViyBlT+aswU/mv
         9m1K+pPRoBheSS8GL8Did3A8Jwvff168zAyLSQ/daALgRnEygoSCZ0bPZI/z4GLE3GjB
         UdfVcdo84C636up85WrcD7b863e+TtDOoWBcHrP6pQuD4C5s9tvDu+hbJoc1FW3nwZRw
         Mn/IydMQ7GkoiNm4bo+TQlNFn7U0Ne9TDtU8+rue1pA9s4qZ1v+V5qccpP0AwdJ9itt8
         amRw==
X-Forwarded-Encrypted: i=1; AJvYcCVV3LZnyN5LsE7fbNbv/hKyKVaJ0k56LLLE4b4eXRYuAP0pMze5L23+vS0R9DowGu3VRMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyINF5SR/eg+5qf5Ms1URgvmpUYGdhcgt+pC5+qJh5di205MAHj
	EJdikqcZjjXvh8DnhwYdn9N+CaiwxT7tKm9C3ILdk4bxoFLV1806ARBst5Mj5xxwdgLPfCqIdiQ
	SNNv06y3PUWyGP3kKrw==
X-Received: from wmdv17.prod.google.com ([2002:a05:600c:12d1:b0:47e:db37:5b61])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4586:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-4801e29edc9mr73321505e9.0.1768655529859;
 Sat, 17 Jan 2026 05:12:09 -0800 (PST)
Date: Sat, 17 Jan 2026 13:12:08 +0000
In-Reply-To: <aWt8Ze-otTkexNIe@tardis-2.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com>
 <aWrSkAPFkdH_tvtN@tardis-2.local> <aWt4muGXbe7lBmXt@google.com> <aWt8Ze-otTkexNIe@tardis-2.local>
Message-ID: <aWuKqLERqpNz9qtz@google.com>
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

On Sat, Jan 17, 2026 at 08:11:17PM +0800, Boqun Feng wrote:
> On Sat, Jan 17, 2026 at 11:55:06AM +0000, Alice Ryhl wrote:
> > On Sat, Jan 17, 2026 at 08:06:40AM +0800, Boqun Feng wrote:
> > > On Fri, Jan 16, 2026 at 03:46:35PM +0000, Alice Ryhl wrote:
> > > > I'm sending this RFC to share an experiment I'm looking at. This may let
> > > > us replace the range allocator in Rust Binder with a maple tree.
> > > > 
> > > 
> > > Thank you, Alice.
> > > 
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
> > 1) "relaxed atomic" does not sound like something that provides an
> >    address dependency to me.
> 
> If you look at rcu_dereference(), it's a READ_ONCE(), which is the same
> as a relaxed atomic load, and yes in LKMM, relaxed atomic load provides
> address dependency (Please see the DEPENDENCY part in
> tools/memory-model/Documentation/explanation.txt).

You argued that we should rename READ_ONCE() to atomic load on that
other patch series because "atomic load" naming is better than what LKMM
normally uses. Fine, but relaxed atomic load is a much worse name than
READ_ONCE() if what you want to convey is "has address dependency".
That's not what "relaxed" means!

I suppose you can argue that the word "relaxed" means different things
in LKMM than it does elsewhere, but I looked over the doc you mentioned,
and there the LKMM calls said operation READ_ONCE(). The word "relaxed"
does not appear even once. If we're going to change terminology / use
new terminology, let's at least pick terminology that's not
contradictory with the rest of the world.

> > 2) How do you intend to provide mutable access? By waiting a grace
> >    period?
> 
> Please see the {read_}copy_update() in the RCU patches that I linked.
> In short, you don't wait a grace for mutable access, since in RCU,
> readers don't block updaters, but instead updater will copy the object,
> atomically update the pointer and then get an `RcuOld`,
> which you can either synchronize_rcu() or {call,kfree}_rcu().

Hm, ok. I don't really need that. What I want rcu for is the internal
maple tree data structure, so mtree_load() doesn't need to block on the
maple tree internal spinlock. The contents of the box would be protected
by a separate lock (probably via LockedBy).

> > > As for the progress of that effort, the Rcu atomic pointer is almost
> > > ready [2], I will likely send it early next week. For the `HasRcuHead`
> > > part, as you may be aware, I'm working on a generic `HasField` approach
> > > to avoid duplication of `Has*` trait and macros [3], that requires some
> > > syn adjustments from Gary and Benno, but they should be available next
> > > cycle. I will probably send the patches for reviews before that. Once we
> > > have that `HasRcuHead` should be easily to add.
> > > 
> > > Given the WIP code I have, I *think* we are not that far from providing
> > > what you need for binder.
> > 
> > Hmm, so I looked over [2], and I think my RcuBox is an RcuOld<_> rather
> > than an Rcu<_> under this model. Though I can't afford to pay
> 
> I don't think so, `RcuOld` represents an unpublished object while `Rcu`
> represents a published object, you can update an `Rcu` pointer to
> another object, which is normally how you update with RCU. But maybe
> it's easy to discuss this with updater side code in picture.

When the RcuBox<_> is an owned value in Rust code, it's unpublished.
It's only published while it's foreign-owned by the maple tree.

Alice
