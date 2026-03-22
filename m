Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FB61A6815;
	Sun, 22 Mar 2026 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774208863; cv=none; b=Yi//15588sJEORwwMjrRWkl923Ss28+ungWevIBpfh8S30H0QeTCTNwRzK8gvaZvT6apa705dffyJygWmNvB+0VExPj2Nre4ejLDrQ+oWpRMxrc1qDt4zqtBQhs9vHGGfMEgQ08A22f7GQbAMqo7P2p+gQDD9gl1Cxh4zwowQU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774208863; c=relaxed/simple;
	bh=3XAtgmML0t27NSYTmxu6FxdFaFLAF5B5MHR1oWmTwjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpumtDbk8g/snDsZjZJAzRrtiZAdaO31AhmYM4IQG4eF4Sj2kwaIzrkBH7pmlS3EWCvxRlrvxoLNAH4Wckhqc/PzbYDLWa/QWvDS6MNBs7PMOPn6zthQqMAlE2Mh6SlJ6A9lp45Z3FhgU5yFzzQ8qsj7h7FXEMb7VAumlXEOqNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvY40wXP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvY40wXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA8AC19424;
	Sun, 22 Mar 2026 19:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774208863;
	bh=3XAtgmML0t27NSYTmxu6FxdFaFLAF5B5MHR1oWmTwjM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FvY40wXPaxVX+70k9O7EK4o6SCazMJKZyt4rC++EXDBYt5imTDS4AahS2xB3nWpX1
	 r6zg/gBGtEH2hhqvAiLB9Br633v5CZcQoS69316jFjthZOds5UOrrOx7fffWXt9vkJ
	 SIM1CM1FYClzJmyci/F0B+B4dsYSa5GDH2/H5QgQb47Ae97DaEtOPiCfEQOYYB3nl5
	 2jRJuVETM/v+qyubePmO7kKLWMNpprdjyLhBv3rc+NVpDjb5038cwFoNFlelSoo/qg
	 NLPH9olBL8y4NP5hje0piRBDNrl25XS8zlpMtO8GNAp8AgZt2xpQ/WCXo74lJtbF7l
	 /5QE8M/z2ybBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B079CE0FFC; Sun, 22 Mar 2026 12:47:41 -0700 (PDT)
Date: Sun, 22 Mar 2026 12:47:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()
Message-ID: <f5764f69-2fe1-4d9c-88ca-3838059c95ea@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <609b5df1-aa06-46a9-8e93-0bf9eb8b7738@paulmck-laptop>
 <ab71Vz9zmlVywWQT@tardis.local>
 <4d2b07a9-e3fd-4a95-8924-0839bdfc28b3@paulmck-laptop>
 <ab7623FFsiUOocHP@tardis.local>
 <3486c7a2-73e6-46f2-a030-c9349ce964dd@paulmck-laptop>
 <acAV-16pYQvy06aw@tardis.local>
 <902d80c5-02a9-46d0-9d6a-06e8cd94cd37@paulmck-laptop>
 <acAnYrlkkUvbNkGG@tardis.local>
 <e5fdd5db-4897-4975-a2db-ddb951385e89@paulmck-laptop>
 <acAyN0gMvOPfdP8H@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acAyN0gMvOPfdP8H@tardis.local>

On Sun, Mar 22, 2026 at 11:17:27AM -0700, Boqun Feng wrote:
> On Sun, Mar 22, 2026 at 10:44:58AM -0700, Paul E. McKenney wrote:
> [...]
> > > > > > Longer term, shouldn't lockdep take into account the fact that on !SMP,
> > > > > > the disabling of preemption (or interrupts or...) is essentially the same
> > > > > > as acquiring a global lock?  This means that only one task at a time can
> > > > > > be acquiring a raw spinlock on !SMP, so that the order of acquisition
> > > > > > of raw spinlocks on !SMP is irrelevant?  (Aside from self-deadlocking
> > > > > > double acquisitions, perhaps.)  In other words, shouldn't lockdep leave
> > > > > > raw spinlocks out of lockdep's cycle-detection data structure?
> > > > > 
> > > > > Lockdep doesn't know whether a code path is UP-only, so it'll apply the
> > > > > general locking rule to check. Similar as lockdep still detect
> > > > > PREEMPT_RT locking issue for !PREEMPT_RT kernel. Maybe we can add a
> > > > > separate kconfig to narrow down lockdep detection for UP-only if UP=y.
> > > > 
> > > > But lockdep *does* know when it is running in a CONFIG_SMP=n kernel,
> > > > correct?  In which case all the code paths are UP-only.
> > > 
> > > Why? UP and SMP can share the same code path, no? Just because lockdep
> > > is running in UP and see a code path, doesn't mean that code path is
> > > UP-only, right? What I was trying to say is Lockdep detects generel
> > > locking rule violation, so even when it's running in UP kernel, it'll
> > > use rules that SMP uses.
> > 
> > I know that this is what lockdep is doing.  I am instead saying that
> > what lockdep is doing is not a good thing.  ;-)
> 
> I see.
> 
> > > > The situation with CONFIG_PREEMPT_RT=y is quite different: The motivation
> > > > was for people running lockdep on CONFIG_PREEMPT_RT=n kernels to
> > > > detect and fix locking issues that would otherwise only show up in
> > > > CONFIG_PREEMPT_RT=y kernels.
> > > 
> > > I'm not sure how it's different than people wanted to detect SMP=y
> > > locking issues when running UP kernel. Of course, I didn't know whether
> > > that's the intention because I wasn't there ;-)
> > 
> > It is very different.
> > 
> > There were very few people developing and running PREEMPT_RT, so it
> > was quite difficult for them to clean up the lock-context issues that
> > everyone else was creating.  Making lockdep check for PREEMPT_RT issues
> > in !PREEMPT_RT kernels was therefore very helpful, at least to the
> > PREEMPT_RT guys.
> > 
> > In contrast (and unlike 20 years ago), almost everyone runs SMP, so there
> 
> (It also means the people who cares UP is almost none ;-))

I don't know about that, given that the sets of people who run SMP and
who care about UP are not necessarily disjoint.  But those who care *only*
about UP definitely are no longer the vast majority.  ;-)

> > is no harm in !SMP lockdep ignoring things that would be deadlocks in
> > SMP kernels.  The ample SMP lockdep testing will catch those issues,
> > so there is no need for extra help from UP lockdep testing.
> 
> Fair point. If anyone cares UP enough to submit a patch in lockdep, I'm
> happy to take a look.

Fair enough.

In other news, the SMP-check hack to rcutorture does suppress this lockdep
issue, at least in my testing.  But I applied that change to my -rcu tree,
which reverted me back to v1 of your patch and re-introduced the earlier
lockdep issue.

So I am restarting the tests.

							Thanx, Paul

> Regards,
> Boqun
> 
> > 							Thanx, Paul
> > 
> > > Regards,
> > > Boqun
> > > 
> > > > And of course, CONFIG_SMP=n kernels still need deadlock detection for
> > > > mutexes and the like.
> > > > 
> > > > 							Thanx, Paul
