Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B21410D04
	for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912628; cv=none; b=PZtTT1XmROFdb2lgg79vq7GiDqqIDt1zU4OhJZL/3ZYc5S+ggkbM0GgA6Y7Z/pwoGl0gFOE/dMi32MiiaQbv6tOP1YTtUCIfYfiNoDgLfLxw8W79AdwLwJFTG4lzsX+N/fol61crtuFssWrqC7HdA//9YU4J1aePhIuR2LEZnc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912628; c=relaxed/simple;
	bh=j6dYM/4zN59VPdw7lyZb0SBlG2HMjjwVYeLXV/raE7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JPSBcwZ4tYhNWh798SoUvap77mMzOzijSpghEH2eZ2KqUkY24SMT9iZgWtEfyqsPlz3TW2nlluc1xTVH3KHmsIQvFk/XMTlCwyji2aNQqmNcTodfxOy5kvjmqnQzPTpB/LGK3EY9EWO38Z4XvHQEmiL94Qwv8SeeP5pYHOJ7cJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fEuk1Xog; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fEuk1Xog"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47ee7346f8bso29726995e9.2
        for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 04:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768912625; x=1769517425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=peqPqCS+G6Z6adx4YllB5EdAS0iLXd/iStCanJ35cU4=;
        b=fEuk1Xog4ZdHWc7Tsd12YQy/4q5JoWpJbkifEAL3lUQLdxp45cb0iT9ACPRXenaSEl
         8ga+fyfQzt1l8LRFXGj3sOPaTFBUl3EJsJAL9njufUJza34cI1X0T37xWM4nKp8CHY3Q
         nTlQoJ2n4afJVPiOE3iq3wN311VKLTzdpswnSStBXzfXHItxLLN8DPMn8EMzYFooP2ZA
         kMBBnrZRa6OMlDNy7DWzl7T/HV3NFiPOrAY+qMr8DmJDSA+p+1cpiHvPxcSKAqNka/JO
         /TC58VOW8fXVvZ+7H2S1QQuxZMW9gJzyc5c8TsfxiVB56On+IDt1K5v4kdp3ZzJ9pwR5
         kulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912625; x=1769517425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peqPqCS+G6Z6adx4YllB5EdAS0iLXd/iStCanJ35cU4=;
        b=GW8oJXUz0nW+K0FDE6/zycpnL2JeuGmmmcTkekV9bFqY+mUG2rEogOUfLNDVEI1Yot
         PqIDZmsDXbr+yZnAVLcLMdHRcnbKM6ZOkdR4rxm5I6ZdYm3XVirKcunAUPJWpdrr8Y70
         3ntDPX9WNHQKlOFm/zwKnBU9b6J4wmuxjvr6Fn6FUfvMnVAzdo+ckPFEyafunkd8A61g
         +P3ZWfY+/yJnvwpZMSTQUQf6h+sCE8CX5ESNQYVVFOhO2aEyt+MdbyaoutdzGI0XVUiC
         pZ8nOfPUn+KsTz6/nJaIZnGO0ZuKLQoy+p76g+AnSKsXFkjBTxRGCoaX6RYt11AVrpgC
         op4w==
X-Forwarded-Encrypted: i=1; AJvYcCW4KkW4g3C2K42YeizJRCI7GpwkzSRM4YW6HQRwbuiqCmtphOGUPgtneFUgus2CD4NYGCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKwehN9z2YR6qFp3SQpxISvqw5ZsPT+pIXKISJ4DNezRjtdGBW
	FI1BOsY8pIsIoya/miIkmcvJFmuDgo+HYNEK/+rgQye1BbMmdgYgyY+F05EUdetIU+xYZWriPly
	8UtsX0rNtT9Vi2VE8Iw==
X-Received: from wmlz23.prod.google.com ([2002:a05:600c:2217:b0:477:7aa2:99cb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8285:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-4801eac3169mr150047715e9.11.1768912624848;
 Tue, 20 Jan 2026 04:37:04 -0800 (PST)
Date: Tue, 20 Jan 2026 12:37:03 +0000
In-Reply-To: <aWxfV4Y3fnNR0Kje@tardis-2.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117122243.24404-1-boqun.feng@gmail.com> <20260117122243.24404-5-boqun.feng@gmail.com>
 <DFR0Z3KHYS62.37Y0R286DPTUQ@garyguo.net> <aWxfV4Y3fnNR0Kje@tardis-2.local>
Message-ID: <aW9276jXCz0S-Ec6@google.com>
Subject: Re: [PATCH 4/5] rust: sync: atomic: Add Atomic<*mut T> support
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Sun, Jan 18, 2026 at 12:19:35PM +0800, Boqun Feng wrote:
> On Sat, Jan 17, 2026 at 05:03:15PM +0000, Gary Guo wrote:
> > On Sat Jan 17, 2026 at 12:22 PM GMT, Boqun Feng wrote:
> > > +// SAFETY:
> > > +//
> > > +// - `*mut T` has the same size and alignment with `*const c_void`, and is round-trip
> > > +//   transmutable to `*const c_void`.
> > > +// - `*mut T` is safe to transfer between execution contexts. See the safety requirement of
> > > +//   [`AtomicType`].
> > > +unsafe impl<T: Sized> super::AtomicType for *mut T {
> > > +    type Repr = *const c_void;
> > > +}
> > 
> > How about *const T?
> > 
> 
> In general I want to avoid const raw pointers since it provides very
> little extra compared to mut raw pointers. For compiler optimization,
> provenenace is more important than "const vs mut" modifier, for
> dereference, it's unsafe anyway and users need to provide reasoning
> (including knowing the provenance and other accesses may happen to the
> same address), so I feel the type difference of "*const T" vs "*mut T"
> doesn't do anything extra either.
> 
> Think about it, in Rust std, there are two pointer types only maps to
> "*mut T": NonNull<T> (as_ptr() returns a `*mut T`) and AtomicPtr<T>
> (as_ptr() returns a `*mut *mut T`). And there is no type like
> NonNullConst<T> and AtomicConstPtr<T>. This is a lint to me that we may
> not need to support `*const T` in most cases.
> 
> But maybe I'm missing something? If you have a good reason, we can
> obviously add the support for `*const T`.

It was pretty inconvenient in:
https://lore.kernel.org/all/20260117-upgrade-poll-v1-1-179437b7bd49@google.com/
since I had to cast_mut() a bunch of places.

Alice
