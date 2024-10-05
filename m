Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB93A8F0;
	Sat,  5 Oct 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728144965; cv=none; b=Wm9nqOIEylGuEkn6MR/HW/ns0YdETYRUqvXk0DBF5atCirzIXnplPTjav/Bq5Bo8xnAY2RJ91Rqsuz71ef+5CE7CUxLMq6bobPJXCkLZ9vdD84RWQCY58PQBQXVQeYZf8CIA5i9g8e3sweUlCb6Q8bGn3Fx+vjFsqB5jsHvFeb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728144965; c=relaxed/simple;
	bh=NDOuv9c6OoMTnsPeMlM7UrlGCaiI2uB2ZCHeP9G8S88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpnfuox3mbWgdKqIyBYjRpvMofl0qpR7nZXsE7Kl0TT6QhhAY+cVEWiTRHg28isM9ZGJcV24MN6Ny78XAe2b2nIb0GSEipBX+vujPorA3x41AAOERIxGSZqRJdzN3M83nykOwav1s0QSKsS2+zDxw68x21rnywbZAj5wobpLuFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h/ow6/P1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h/ow6/P1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hyCIjsZcXoZycF6/wP9qAmK3t+lawcUgpYpbgndQbwM=; b=h/ow6/P1k95fYePhOrvkJEEQx/
	mV9pltad/g2CgR0mQjRGwGTnKupuNGrL7xJ9Ru5A9K8ZkxK9X9fveURcW++3LhIjLF9yuiVPDDGNI
	gFfpoSE0hk0WVPAwqnTDi2K+4ikDicV1ZRGBN61O9tlbzCiOnWhnP+/sDAuBfY7aImp4Bwyq/JG5X
	0Rg3nbn7yc7ZRji3YizvDy59mfFG7xhuNjCg6R5RA+GTZDzQblaJtzzmlROLC+GTprqPeYedPk5CA
	eRAn9xXRnwg9tVuyJNTXGrvpTxRFF3LHUkWrudRIhIBVXOqLDHmSu6VtCCyIb9WEpDD9zx5f4CoE3
	uETOQxjA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sx7RS-000000044LA-0K5U;
	Sat, 05 Oct 2024 16:15:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B2EA6300777; Sat,  5 Oct 2024 18:15:37 +0200 (CEST)
Date: Sat, 5 Oct 2024 18:15:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH 0/4] sched+mm: Track lazy active mm existence with
 hazard pointers
Message-ID: <20241005161537.GB18071@noisy.programming.kicks-ass.net>
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgztWbA4z85xKob4eS9P=Nt5h4j=HnN+Pc90expskiCRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgztWbA4z85xKob4eS9P=Nt5h4j=HnN+Pc90expskiCRA@mail.gmail.com>

On Wed, Oct 02, 2024 at 10:39:15AM -0700, Linus Torvalds wrote:
> So I think the real issue is that "active_mm" is an old hack from a
> bygone era when we didn't have the (much more involved) full TLB
> tracking.

I still seem to have these patches that neither Andy nor I ever managed
to find time to finish:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/lazy
