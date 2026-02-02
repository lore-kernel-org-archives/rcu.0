Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77D2DFF19;
	Mon,  2 Feb 2026 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026318; cv=none; b=e6BtJF45N4wuiNe2YzXFJBjT0MJnqTiqwlCXjc8qS9/ZxItmwuHJdYuGr1odEapuvHtxRpP5BvYLrwOpyB46mXRouj6QLEn/cRtsfzkPVGME3FxrAyG/r/E6AkDBqcodApjYciYVEyJ8EdILPtVL7DuB1Q9j5LGIgVIjLEIpgxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026318; c=relaxed/simple;
	bh=3zAg+xMecZQVbuu/i/k+Q3Ul5++wnLO7y7WifYgqqes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIhFjV00TkNppdoRVwCCIfmU+UDz6OWdIQsk5Lj1KitGL0PBeNXMh7NQjfnl+Y6GRyTroDeMAlhEKZhNNOpzIE7v7qD5Vnt1E7NBZsunnBGFds4iFqKQQQVdbliqZZMhTWOFEB4gQyd+tAXP1BexKVleA/1uVysEBT8WoDOi2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aPvAYVot; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aPvAYVot"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b9phH9p/ZZC1unSSQzSrvSMjFKwe9909c2vceEfaPWE=; b=aPvAYVot0AoI3qO5WQGBEDh/ER
	t3owscRh+3qhABi6Q/YgRw1ZWVsbXBm39kGhT1Ox4huytCP1kEsj5A0/WbZrTALGhW4itjWEt4iK1
	vWS1ksi4d3SZkATbTZtzYxlc4AwDyVMwSCDeqZ9loou3tFr5jXa+lOzI2Kah/X7KggqdXMYMIImhc
	zrDxuI/s8GsbCve5Ofy4bPamO044l4xx0r5sux3kBYrJq52xaJVYc8Z085EOgnuGtqCpSw5qxjjUN
	MAdDyXcPWDjLfaO4xpSZF4rEalOWcYF5vxavWAx3lEQ6yq6vfVrPWKZ6Q+df5yPTLguSejY15QHzu
	GgIMPpzg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmqhK-0000000GJNR-0ysB;
	Mon, 02 Feb 2026 09:58:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2B88E303031; Mon, 02 Feb 2026 10:58:21 +0100 (CET)
Date: Mon, 2 Feb 2026 10:58:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: mark lockdep_assert_rcu_helper() __always_inline
Message-ID: <20260202095821.GF2995752@noisy.programming.kicks-ass.net>
References: <20260202095507.1237440-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202095507.1237440-1-arnd@kernel.org>

On Mon, Feb 02, 2026 at 10:55:01AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are some configurations in which lockdep_assert_rcu_helper() ends up
> not being inlined, for some reason. This leads to a link failure because
> now the caller tries to pass a nonexistant __ctx_lock_RCU structure:
> 
> ld: lib/test_context-analysis.o: in function `test_rcu_assert_variants':
> test_context-analysis.c:(.text+0x275c): undefined reference to `RCU'
> ld: test_context-analysis.c:(.text+0x276c): undefined reference to `RCU_BH'
> ld: test_context-analysis.c:(.text+0x2774): undefined reference to `RCU_SCHED'
> 
> I saw this in one out of many 32-bit arm builds using gcc-15.2, but
> it probably happens in others as well.
> 
> Mark this function as __always_inline to fix the build.
> 
> Fixes: fe00f6e84621 ("rcu: Support Clang's context analysis")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!
