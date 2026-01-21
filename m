Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F52D480DDA
	for <rcu@vger.kernel.org>; Wed, 21 Jan 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001712; cv=none; b=g6vWH7VYfwwh4Ztwi1N0uQhefxzrNvESgFipWAMfWx2FsIEcVKkh+R6R7MxAM5+56AWAQBAUeZe8juhtWtGqKgKELfDwAZsDLS+oLBiinnlRbQg5P0+1UxNULTDIw/c9Oi0Msbdk+j3SyEqIv3+rd8gzAa/09imd209hqs3xBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001712; c=relaxed/simple;
	bh=qeFEdujDRgTjVGhfnth2gNTaSSL4O4zWHecK93HFYr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WyMGX+/E/Y/Fdlzzm85KBDin2p5ooixogQpAWz9zz2s51YAgVKop7v32mWJb0i/PniUnenL2aTLm/biMg+PTrRATeV0umjQIZQqd4Ie1iDUg39mKO3j/oqP9TCzGXW5YoPvbcHNKVompfaE+Z7JSafhAO+f0utDU5G7e6xUWsoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hp0iUIDc; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hp0iUIDc"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-430fc83f58dso4526479f8f.2
        for <rcu@vger.kernel.org>; Wed, 21 Jan 2026 05:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769001709; x=1769606509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WWsQUZNrYfiIWVn7HrRDJlzmTvsFg0ts6AaOLpup2w=;
        b=Hp0iUIDca3ATaBmj/CMKquJ578+HBDklme7FLgCfnMD0Fbh+jprsh5RK8tUKqsdCwz
         yKMMMDQy0J3PzPwfUHOo0v6bQ+Nnc6I6MbNvja+hynNE9v1m6FlQ2KTB/RDhbxolVbFN
         8dQdW/m2OnumVGG5hROSloRX3K37hdbKrZWEPmyJJDXNr9My8Y3I6UrcIbVYQ6e7xKBC
         hzXe+ynZsBK/XlWquSG62v2J6WcccobeKmT8pk4TaBSPdqCTOMEosxKqNv16U7laEWbh
         oV3EKwfooPkJ4TA4bdbntUBjAkI5hktZbjMZo2WFXDYH3/XtALe4IKiCNvE/msSYi3ta
         qmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769001709; x=1769606509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WWsQUZNrYfiIWVn7HrRDJlzmTvsFg0ts6AaOLpup2w=;
        b=mlQUeIuRBiFt76tgW8M59DSjHqJ+hc3e7ek+zqjKA3fx5k7Uh11XVUgzv+tD5ymK99
         4LKU8Zrwj2QYqhga/4wDUKTPuwHYVVWmF1nxBhF01YZJCLgXIWg5kF7y+qeT42rf6ihm
         K5Gop4TApz351tf6/NHc6u68RoHOjukME3JblRtUgkVX6LUSyp/8mNPmmdNVcLHboMck
         7EmEwyGbElqNNtMNiSghDepINjRZU9RGNrKamxam4pSLl1Qug+tbPlT8CcwsA9VRCJJb
         q6vRK8tH83sdaff2AD9suUCbL0YPqwOhTsSHCRbNOxgPP4/m+7564LIe0sIQ84DRsIpH
         cuZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYvlLvRMyIpCIlr8VLc5szGfvjfJONhs+GY+NrgO9B09k3slusfHE+spci0AD3j+uXl7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCDQxK7QU0JjNDx/vRK25FsMwEOGDYzJuNLToQ0JV00675/Y41
	hxcPuN0uJArqhl8i2wO+0FAVZ+QLxepV7tgnlQTbz5WTpKE+tNDHlVXPOXL1pWpWBE4yGjQf6Im
	XGj4bcW1yUPD4LGh2vA==
X-Received: from wrbck4.prod.google.com ([2002:a5d:5e84:0:b0:435:8ddc:d1f9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:3109:b0:430:96bd:411b with SMTP id ffacd0b85a97d-43569bd47e7mr27556618f8f.58.1769001708212;
 Wed, 21 Jan 2026 05:21:48 -0800 (PST)
Date: Wed, 21 Jan 2026 13:21:46 +0000
In-Reply-To: <aXDRHerRiM7TzACy@tardis-2.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com>
 <aWrSkAPFkdH_tvtN@tardis-2.local> <aWt4muGXbe7lBmXt@google.com>
 <aWt8Ze-otTkexNIe@tardis-2.local> <aWuKqLERqpNz9qtz@google.com>
 <aWuV858wU3MeYeaX@tardis-2.local> <aXDCTvyneWOeok2L@google.com> <aXDRHerRiM7TzACy@tardis-2.local>
Message-ID: <aXDS6rNbsWhDVGK9@google.com>
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

On Wed, Jan 21, 2026 at 09:14:05PM +0800, Boqun Feng wrote:
> On Wed, Jan 21, 2026 at 12:10:54PM +0000, Alice Ryhl wrote:
> > On Sat, Jan 17, 2026 at 10:00:19PM +0800, Boqun Feng wrote:
> > > On Sat, Jan 17, 2026 at 01:12:08PM +0000, Alice Ryhl wrote:
> > > [...]
> > > > > > 1) "relaxed atomic" does not sound like something that provides an
> > > > > >    address dependency to me.
> > > > > 
> > > > > If you look at rcu_dereference(), it's a READ_ONCE(), which is the same
> > > > > as a relaxed atomic load, and yes in LKMM, relaxed atomic load provides
> > > > > address dependency (Please see the DEPENDENCY part in
> > > > > tools/memory-model/Documentation/explanation.txt).
> > > > 
> > > > You argued that we should rename READ_ONCE() to atomic load on that
> > > > other patch series because "atomic load" naming is better than what LKMM
> > > > normally uses. Fine, but relaxed atomic load is a much worse name than
> > > 
> > > To be clear, in that series, my argument was not about naming, it's
> > > about READ_ONCE() being more powerful than atomic load (no, not because
> > > of address dependency, they are the same on that, it's because of the
> > > behaviors of them regarding a current access on the same memory
> > > location), and we want user to specify the intention more clearly.
> > 
> > Expressing intent more clearly is fine with me. I still think it's weird
> > for us to not have READ_ONCE() when it's a primitive operation of our
> > memory model, though.
> > 
> 
> But in our memory model, it's exact the same as atomic_read() (see
> tools/memory-model/linux-kernel.def and search for "atomic_read"), so
> why do we want to have both? ;-)

I've been saying Rust should have both because I've been repeatedly told
that they are different. If READ_ONCE() and atomic_load() are the same,
then I retract my concern.

> > And I also think we should consider using an implementation along the
> > lines of what I shared for our atomic_load() or READ_ONCE() or whatever
> > you wish to call it. The perf impact of helpers makes me sad.
> > 
> 
> I'm not totally against that, it'll actually help Atomic as well, I also
> hope that we can use `asm!()` to implement the cases where
> `{read,write}_volatile()` cannot cover. However currently I would rely
> on helper inlining to resolve this to avoid duplicate implementations.

I'm in favor of using helpers to begin with. I think it's probably worth
to do atomic_load() before we do the other ops, since it's so much
simpler to implement that particular operation than the ones using asm.

Alice
