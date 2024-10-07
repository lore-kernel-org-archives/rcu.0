Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07B6FC5;
	Mon,  7 Oct 2024 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284811; cv=none; b=B1c2fyxqLdwk0o+P0UCoW2j0jx+G5qvjokKt9lI5Zo2UpqpWjz7M63spR6nL/A9yIKOuspKrvrxRcwRkeODY/Xyucd+hQMBCVlAcyPGIqXdMQ6v7pCcuieRezKscu9rFTXzBetw6B3rOBmF0+2AXirtGkXFm6Wj9uG6R76qhrws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284811; c=relaxed/simple;
	bh=G42xkt2HXDJsEm/1X6zsNTuNdHNDZFtY/2XKj0r1FmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnFCqQs1D83awZM/4rr8dgURiQpoJYRELmeZBk2GxTWJd4HcKrWg+ZM/KU7vr6mbdTXhrPXR00ybaH8v6Tk32196Cwyx9KI3BGd3tNCl1zPjNzGVclSZCIsZBk6tW9wsSEeJQbPYpPyyFTXcF3tiICLIoihiHontAIvV/Xr0c98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kbZl2yLI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kbZl2yLI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WPrGACetzn240lxkdUEDnFIeJe4VvQIHLBhegiGUuD8=; b=kbZl2yLI7r24lQNgu54c9qhvF8
	lV9ZOhzm0IWhCk97HGiqo6tTyV7M1r7fvKtrXu1ZbtJ5Yz2qzfmYi3XCKDVyY0Y2kzfWwxoi2JjyS
	f0fedCVjGXq7A0YlId+p5Mn3tgowZ20sS3RxQl1AYPLGzm+VyjLKwqo97s+3U/CnEn5uuX2zgPfMm
	K/LYc5j5hbgn0nl7Bb8/PvxXhOr61coobajXrXOaV8nd+iE5qtFgUJnsOOnPHJ74sj0bl2Z6ZXIQG
	A+YMYwyA3kPWNWuL/YAQuxnUeiyhR2N0BIsGE3zyUURj6GVK8ChjWPOyfXLKD6R0YEx4v5u0qs1rN
	aTNb3RDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxhp6-00000004NYw-1PAI;
	Mon, 07 Oct 2024 07:06:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5FF6A30088D; Mon,  7 Oct 2024 09:06:27 +0200 (CEST)
Date: Mon, 7 Oct 2024 09:06:27 +0200
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
Message-ID: <20241007070627.GC18071@noisy.programming.kicks-ass.net>
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgztWbA4z85xKob4eS9P=Nt5h4j=HnN+Pc90expskiCRA@mail.gmail.com>
 <20241005161537.GB18071@noisy.programming.kicks-ass.net>
 <CAHk-=whvxq3378vOn++=ZiOQc9=4N-3ejUWr+dXEJ5ti43kT6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whvxq3378vOn++=ZiOQc9=4N-3ejUWr+dXEJ5ti43kT6w@mail.gmail.com>

On Sat, Oct 05, 2024 at 09:56:24AM -0700, Linus Torvalds wrote:
> On Sat, 5 Oct 2024 at 09:16, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Oct 02, 2024 at 10:39:15AM -0700, Linus Torvalds wrote:
> > > So I think the real issue is that "active_mm" is an old hack from a
> > > bygone era when we didn't have the (much more involved) full TLB
> > > tracking.
> >
> > I still seem to have these patches that neither Andy nor I ever managed
> > to find time to finish:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/lazy
> 
> Yes, that looks very much like what I had in mind.
> 
> In fact, it looks a lot smaller and simpler than what my mental model was.
> 
> I was thinking I'd do it by removing "active_mm" entirely from 'struct
> task_struct', and turn it into a per-cpu variable instead, and then
> try to massage that into some global new world order. That patch
> series you point to seems to be much simpler and clearer.
> 
> Of course, you also say "never managed to finish", so presumably
> there's something completely broken in that series, and it doesn't
> actually work?

Last time I tried it, it worked fine. I just didn't get around to
actually fully thinking it trough and making sure nothing subtle was
broken etc. Pesky details and such..
