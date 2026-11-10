Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337392;
	b=Ngxaue9bzOMIj9SM1Nm4oLHSQg57oCbrexyvhJEnqrtqyI4As8lZdR99RTgN009Aaw+L
	 QrOWkRUA5iz3hOC/sHq3WFqRYWf+1ifUrTErrgK+IYdZwAs/XsOGnzVx/s0NZ9ErXIM+T
	 IZcm6P+PVc5E04w6btBUHYLJSB0iu23K4aw/bPZZDEAi08/jRDLZR8aN8Fwt8sE+Hz/Z5
	 bhyvt2W2glJmWd16K5KGMdui8VSaSWhjfuV9HGmNH7HqKdbdrVbqEPIMdILwWhi98NFuh
	 X1ban9DLNVBwMpkt+jLAfw6Q5KlDfGq47umfq/DryTLI5hpSnzed5aNPflg8W4aJ53Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337392;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=bekQ0kWwdLRAS0Ig0iEy6992/HDQ2m8y9hYfsYqrh/c=;
	b=3BrstzuPHRZKxuO5AdTW13CxKbS3phspri7Qd6B99Biu3WQtYVR0lpu/dPUb9nqF1typ
	 rPQupD73j5Mj8a23oLB1O6I/eK14CBTVDukte6Iw87STu2UvK4AYVVjlKg594w38ygawC
	 lP5YRW4J1sG7YUC72E8GElljfckJpZZY3WX4VkTB1EIr+hjlTqD+FYoDgQgfTnWzB8gQi
	 QtQaZIkklGJAus0SCc/cpLcCI4Cx/MmnIyb7jcA7CCSBMGzlm1ri9ownOvwPSWGM6AeWF
	 cBf5FKpqjjPzXynQfhluUddA/e1O697RkVppUV4gYQCTX4WCBc1OA2C3VxAIhickRlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYddgtLb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87107606A321;
	Tue, 10 Nov 2026 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYddgtLb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA241F008A1;
	Tue, 10 Nov 2026 19:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337392;
	bh=bekQ0kWwdLRAS0Ig0iEy6992/HDQ2m8y9hYfsYqrh/c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=hYddgtLbSEF2hew9xCqpEA8t7m3zVPJ2cSJ++Bm2xcEs+eWPjE0niEKK84RTINEDr
	 7xRSHw77d5sAHIR21msrfdLWObmYMUAE13+ZjgITPaJHuaEWcW+n+mvkQSYaxCnVfw
	 Ls21375DT3tFUcDJxD2m6E2EMLxZRiqxpiY+NvYNrLmRrj115x/7ukJpgduZaCJgVz
	 UfblOgLqwLJaN0un1NR16UxJEkBENKJ8hwGerneD5K7xSybPUKvlh5kXrtQLGzNZrJ
	 +m6Rs5732a6/B0RLMryO6wEMx/8iFylUc7a8Q7ZX5OmYCNxhR4IHqHEKXUPDQA8wzL
	 M2UeAz4k2OWTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DAD95CE0AD8; Tue, 10 Nov 2026 11:03:11 -0800 (PST)
Date: Tue, 10 Nov 2026 11:03:11 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Puranjay Mohan <puranjay@kernel.org>, linux-kernel@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	rcu@vger.kernel.org
Subject: Re: [RFC PATCH 00/12] RCU pseudo-transactions
Message-ID: <06b1b844-8c2c-4199-b8ca-5d6e21cb1c58@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
 <20261023181940.457424-1-puranjay@kernel.org>
 <f785237c-ee5e-4ad3-8ee9-79474f5f45c8@efficios.com>
 <9667c08c-333e-4fe5-9812-c5ccaa183e36@efficios.com>
 <853d8469-94a4-4b33-a0d5-d6d2138fe3ef@paulmck-laptop>
 <597586c9-35ae-43bd-9b79-7abf62057838@efficios.com>
 <3cb75140-1d10-4de3-86e6-c9d70edd2da5@paulmck-laptop>
 <84fdca577207092bd16fc8f3949c9b7a776750ba.camel@infradead.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84fdca577207092bd16fc8f3949c9b7a776750ba.camel@infradead.org>

On Tue, Nov 10, 2026 at 10:49:03AM -0800, David Woodhouse wrote:
> On Mon, 2026-11-09 at 17:34 -0800, Paul E. McKenney wrote:
> > > Could the atomic flavor count its readers as srcu_read_lock_nmisafe()
> > > does? Then a reader could also enter from NMI. The code I have for the
> > > next version keeps one counter per NMI nesting level for this. With
> > > SRCU, the sums of locks and unlocks handle the nesting already.
> > 
> > The other user that I know of is David Woodhouse, now CCed.
> > 
> > David, would you be OK with srcu_read_lock_atomic() using NMI-safe
> > counters, similar to __srcu_read_lock_fast()?
> 
> I can't see any reason why I should object to that, as long as the
> synchronize_srcu_atomic() stays in the 4-16µs bracket which was our
> major criterion for this approach.

Then full speed ahead!  ;-)

> I'm still iterating on the KVM GPC use case¹, as sashiko-bot keeps
> finding things that my own local sashiko runs don't. 
> 
> ¹ https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/gpc-srcu-v3

I know that feeling...

							Thanx, Paul
