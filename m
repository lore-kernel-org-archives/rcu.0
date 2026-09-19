Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9B37F8BA;
	Sat, 19 Sep 2026 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841913; cv=none; b=HvbPQ4LlywA9VXZ+m4j522zob5hzDkSt/uHnUpjBrWxMQ1ZTFXo/pJ9HM32C+CF0HTqeyQkyY5zmhB9Yd1WgC5jV3nDlx4LVzBIa+nKqSfsJEmcZj6v7wRDFg4ou4MU1JICvFp3nARoVePDzGIM1hPteEQ7j28fqmqHlTQy3pQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841913; c=relaxed/simple;
	bh=hJ3wA6wLwUK3w8BKiqUYmor+iYzZ9BPed8AZHsmu54M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hg1UA8iOLq3skaU2NhVTxzic37pp7oMRMgR1I8hRhp+9DZ201pprwH3yYBukXK7pNf3jU8dVryL/sLcHutVTGZCPbgwZdjm/7OQ+7bceCeDo5o2kvJe2mFPiX0F8PFHlYHip5D+BSuWD+gBliA4sPT9nWyFg0FmQPM1UwBEkBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/8IJ+cP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/8IJ+cP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3508B1F000FF;
	Sat, 19 Sep 2026 18:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789841909;
	bh=pyIemgWwjEQt3L+L8axqzmGHSvJ7AdeLk598yESsBGI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=C/8IJ+cPchuSvWh2/MxbtZPVyL1SjYKc4WXhx6R5cZ8sO849empy9OJwygnCknBX9
	 LS0Iqqfn6V5Z1h0JG1qUVKf9ea2HYVT30qIGRHdnP1XZ8UWHJ4YpkgHmC2HkV5s0gX
	 mx0/oSOBh7QA3iOZ0E/hOerVDWNOt+SOJUGUJsSea826IzlwZFx6EKFYhiXVOWrygb
	 dFgoRw90kA2b19NGTt6Z1+i6jE++aYpKXWkfZJmT3MCxltSlIRdRsx4YKWYg7FmUUl
	 v57bGYi8C3acUYW1teyDCheNQDUiXJTOBLdtqRjHN/XWQW65fUQ6bmgFxOj15iYWL/
	 ai9pfvIYdXxCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E6C70CE1579; Sat, 19 Sep 2026 11:18:28 -0700 (PDT)
Date: Sat, 19 Sep 2026 11:18:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bradley Morgan <brads@mainlining.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev, Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH 01/28] hazptr: Implement Hazard Pointers
Message-ID: <c67ddf7a-6f79-4145-858a-291df86e5274@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-1-paulmck@kernel.org>
 <CAHk-=wj9knmxXD01=top1DQ9_aqrN2a3kpWRS5DQv6QLwLOztg@mail.gmail.com>
 <6B1FC39D-6EB0-433A-8E49-E5EFC9379AD7@mainlining.org>
 <CAHk-=wjyniJy-CX1muCrsZp-i-sLGRYeRYEPN7sw9orRZUCwag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjyniJy-CX1muCrsZp-i-sLGRYeRYEPN7sw9orRZUCwag@mail.gmail.com>

On Sat, Sep 19, 2026 at 10:00:06AM -0700, Linus Torvalds wrote:
> On Sat, 19 Sept 2026 at 09:35, Bradley Morgan <brads@mainlining.org> wrote:
> >
> > I think hazard pointers are good, what test do YOU suggest we do here?
> 
> I want to see a single real-world example of "look, this speeds this
> real load up by 10%, and the kernel code was actually cleaned up in
> the process because hazard pointers are great".
> 
> Not a microbenchmark that tests just the hazard pointers themselves,
> but a real kernel feature that has been converted to hazard pointers,
> and in the process actually shows improvement.
> 
> The ONLY reason for hazard pointers to ever be merged is if they
> actually buy us something real.
> 
> So I want to see that 'real" thing.
> 
> I want to see how easy/hard it is to actually convert a real current
> user, and I want to see how it actually results in measurable
> improvements in performance.
> 
> Something *core*. Something that everybody uses. Because I'm not in
> the least interested in a new subtle feature that interacts with the
> scheduler and is only used for some random driver or (to pick the only
> example I have ever seen) AppArmor.

Just a historical note for those who were not around at the time.

Linus had a similar healthy skepticism of RCU back in the day, and
we (well, mostly Dipankar Sarma) did deliver the required use cases
and performance results.  It took about two years, with the earliest
discussions at OLS 2000.

And I won't be sending a hazard-pointer pull request to Linus unless and
until we have something convincing.  And if I turn out to be easier to
convince than Linus is, I am sure that he will let me know.  ;-)

> Now, obviously, the thing that would impress me is something like the
> dcache. If *that* can be converted, and it shows real improvements on
> some real benchmark, then I'm sold.

And yes, the reason that I am pushing this is that some corner cases are
stressing RCU a bit, and perhaps hazard pointers can do a better job of
addressing these situations.  And maybe dcache is one of those corner
cases, but it would not be first on my list, in part because hazard
pointers tends to have a bit higher read-side overhead than does RCU.
And I don't see a way that hazard pointers could eliminate dcache's use
of seqlock.

The most obvious potential hazard-pointers use case is where someone
wanted to use per-CPU reference counts, but couldn't due to the high
memory footprint of all those per-CPU counters.  With a key word being
"potential" because I don't know of such a use case.

But if one shows up on an emergency basis, I want at least a prototype
of a ready solution.  After all, the Linux kernel is a *lot* less
bug-tolerant than it was in the early RCU days.

> Now, I don't really expect that kind of major test-case, but I do
> expect *something* meaningful. Not a driver. Not a test module. Real
> code.
> 
> IOW: "Show me the money".
> 
> Because the kernel is *not* some kind of acadmic project. Never has been.
> 
> I simply don't want to merge something that is touted as an
> alterantive to RCU - which we obviously depend on very very heavily -
> without something *major* that actually uses it and shows the
> real-world advantages.
> 
> The discussion about hazard pointers in the kernel has been around for
> a few years by now. If there isn't some real core feature that was
> converted to show that, then I think that's already a failure
> indication.

That is of course completely fair.

And there are a couple of potential hazard-pointers use cases that have a
reasonable chance of working out.  If something compelling does show up,
you will of course see a pull request.  If not, maybe I maintain hazard
pointers out of tree for a few more years and then drop it.  (At which
point, Murphy being who he is, a use case would promptly appear.)

> I'm hoping that those patches and numbers already exist, and I just
> haven't seen them.

There are some, but not yet compelling.  This is still a work in progress.

So why bother you with premature hazard-pointer patches?

Because if a hazard-pointers-shaped problem does show up in the kernel
somewhere outside of my admittedly narrow field of view, it would be
good if you were aware.

							Thanx, Paul
