Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BBB39E19A;
	Thu,  4 Jun 2026 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598545; cv=none; b=sXPTqFwLByVTY/RNmX8KR/o0eySD7ZEVP8L4i+gcdbpd3BHZL2OqSYSiZ1ccTzKB9978DSDiBy6jWk8ZjP4NLDwLJBR0PYLLkhS5NKPLbJG5RrygziBRQtWqb+UzGuXodSfSDwesImFHhN04nI8knmqadwwSjFT2YUBt7FLNElQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598545; c=relaxed/simple;
	bh=kVtjAvwGDxQS+kXbSVR6PLpD1wuJ3VN2AG8U+niIq3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+zfOi6y5LhPilEIe9y1oRL5Ds9BD/qzJZneVtMzOkvDUhFQ53P8lsOnDS8jdUpgH7qdtFcpaHiHI5tLAH/pm8du6Mrb1ZZFq0etXbZhv5W7UpEErvYLMoJRXwWZUvljZRiKQLvMuxUvN72h4762prxE2QrT0tgmAHkFEVHT1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR2fRmag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR2fRmag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B501F00893;
	Thu,  4 Jun 2026 18:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780598544;
	bh=DKNK85BC0isZstWD2d7sYRzSd4qqc56ABhaHKaPdUBE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=jR2fRmagMJ1nLv/KB6VhnakM3E6ZwOjUoWKxmxcfWXA4B3VJBTsVqtIzJBz9pBkg5
	 9pDztXaX6sD6uFY4YTMXac0uFuYNZck4uQynoITddMMobUkFiAOaDMHx2EP5OQHiwc
	 CwwEy3AkaItzz5sU1IN5/Ef0bD5lD4j7EaO2rRDou7PxQukRfYmw51IlhYgM4EC1S9
	 uGr0RZW2AuGpL+Uu4x85w7DZfxmZa89PaV9pY0mlpFcUeJ8CxZSLUg5iNZjMyHNnKk
	 hZSx0mk5Spgp4FbSW8BsFsBXFE0GX2fGFUXjoAskCvVKxM31wpH+O+5XMAUPpFbhrr
	 4iUK5HAKf7TIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1486FCE0555; Thu,  4 Jun 2026 11:42:24 -0700 (PDT)
Date: Thu, 4 Jun 2026 11:42:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, peterz@infradead.org, fujita.tomonori@gmail.com,
	tamird@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v9 1/4] rust: helpers: add SRCU helpers
Message-ID: <8f8bf63e-f7b7-449c-af2a-b118e94cd102@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260529134004.396743-1-work@onurozkan.dev>
 <20260529134004.396743-2-work@onurozkan.dev>
 <5d82d96f-5dbb-46bd-b34b-25411be157ce@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d82d96f-5dbb-46bd-b34b-25411be157ce@paulmck-laptop>

On Thu, Jun 04, 2026 at 11:40:59AM -0700, Paul E. McKenney wrote:
> On Fri, May 29, 2026 at 04:39:51PM +0300, Onur Özkan wrote:
> > Add helper wrappers for SRCU functions that are exposed to Rust
> > through generated bindings.
> > 
> > Signed-off-by: Onur Özkan <work@onurozkan.dev>
> > 
> > ---
> >  include/linux/srcu.h   | 29 ++++++++++++++++++++---------
> >  kernel/rcu/srcutiny.c  | 10 +++++-----
> >  kernel/rcu/srcutree.c  |  9 +++++----
> >  rust/helpers/helpers.c |  1 +
> >  rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++
> >  5 files changed, 61 insertions(+), 18 deletions(-)
> >  create mode 100644 rust/helpers/srcu.c
> 
> On the next version, please split the rust/helpers changes into a
> separate patch.  It looks like the simplification to SRCU adds code
> rather than deleting it?
> 
> But let me see if I understand the structure.

[ . . . ]

> I am surprised not to see any changes involving cleanup_srcu_struct().
> What did I miss?

Never mind, next patch!

							Thanx, Paul
