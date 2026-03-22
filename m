Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13B83161A2;
	Sun, 22 Mar 2026 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774211166; cv=none; b=uOLW/Ql83y8LdBboZuku5x1obPQJAcLjiJtCAGAn1ML1fKYvlvKUDXAN0FxHYJA0QDyyXPRLWWEzjmnCPl31cmpeFJIJZCkOKGwzgoeUCXUY8Dx7abnch4zFPEp8qMA3Uco/CXKL6WoEgKcAT6fvy/XUpPD9acSZ28DS0AR6NsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774211166; c=relaxed/simple;
	bh=bVWNm2dKsCls0a7N1Tug0d6sE21E0P7jq1I7qZa5TzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+Z0WtyUGmx8PXAXDO+5Z4PbMjKpTYeR9gKcGtILCEPZ+zbc9MRkf2Nd7IO/Co4LKq+hNt8Yht8qkdhzBideatHO+n+HYeq56Cl61PozCHE9fBMxSt7Wq/HeaupiD9pA2o+qJjIbHiqGh2TxtTJ6pYCZ6nsDNztgvAwL80LI05M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3abxCiZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3abxCiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1193DC19424;
	Sun, 22 Mar 2026 20:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774211165;
	bh=bVWNm2dKsCls0a7N1Tug0d6sE21E0P7jq1I7qZa5TzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3abxCiZ4GX47CIT7uw0MW8ZtBo0C5J8+E/AL6/PCNmSrD2MApxW9FzBesS2Zqyzl
	 EeqclfxGZ+rr9fTxQQ2RKxkO3o6qBZPBYJi4EtXuPvooWxSyP7IZLy7QGLu2PR3key
	 IyiUuNiY8v9lhFQXjgPMw/MMAhy2Z4Xq679kylTE0i9KQWENC7LuHxGR24GuHX7+12
	 omKZFSOHA/5Zbn1dgF8QnxI7Nw6AyZavTYTPNjZzckpVKNqoy/U/FhmcXmxJ5gRUsh
	 nmhV8ePRLYDWJ7SnA1iCLx3Yaf6atedsUSwfo/QxYnOjC83rilgXp6X3XPOpYvCuDM
	 ZVfbNfep8mb9g==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 04A63F40082;
	Sun, 22 Mar 2026 16:26:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 22 Mar 2026 16:26:04 -0400
X-ME-Sender: <xms:W1DAac4h_4R7D8XaFARrsuYWYiZjHK07AJu6f2idjcbOBcIniUkEEg>
    <xme:W1DAaXTETnjhYkJQWaWAkLvWMfYQLi-S3FusVYG5zwOv98magVvNWNZlhvIeTGUXr
    lhiSjoJjJAcoeHUoaODNp2LlqZ20xOgYgsnKWjA6nYNcDrfkWtb_g>
X-ME-Received: <xmr:W1DAaT8b-YBNW9LKKrjWR4r3CVlLF4WWlSKGxMAg7Kqyl1Dnfj2N4g8XaERQjny0ynqm9jRLuCCgii2eH5nmWTuTmLWKatnj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeijeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekgffhhfeuheelhfekteeuffejveetjeefffettedtteegfefftdduteduudfgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgr
    uhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlrghgnhgvlhhfse
    hnvhhiughirgdrtghomhdprhgtphhtthhopehmvghmgihorhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoh
    epfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdr
    ihhithhruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhrvgiikhhisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:W1DAaQqy17SVytuIuDM5a3_AY_0EWzo4XbwDefVupEYLDIRpYOpYyQ>
    <xmx:W1DAaRXQsHVZu2pw3OYV0wd1hDfTsRtgoztFmO28bXa2sC2kpNrBow>
    <xmx:W1DAad5AGa6GvQ6dfMB2yMFaqIkOvqExD-asPRhvrGqqq2H1pZUryA>
    <xmx:W1DAafC0pdtAEbOGoNG3WSsKq2kN0-5vQNGj4Q-SloNaYtjve6O2Gw>
    <xmx:W1DAaRdpopwZPT8cwBwsfXTuQDNXD09SLLJijG0pdaM75QUTdbACXpW_>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Mar 2026 16:26:03 -0400 (EDT)
Date: Sun, 22 Mar 2026 13:26:02 -0700
From: Boqun Feng <boqun@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <acBQWioQYgaJxG4Y@tardis.local>
References: <ab71Vz9zmlVywWQT@tardis.local>
 <4d2b07a9-e3fd-4a95-8924-0839bdfc28b3@paulmck-laptop>
 <ab7623FFsiUOocHP@tardis.local>
 <3486c7a2-73e6-46f2-a030-c9349ce964dd@paulmck-laptop>
 <acAV-16pYQvy06aw@tardis.local>
 <902d80c5-02a9-46d0-9d6a-06e8cd94cd37@paulmck-laptop>
 <acAnYrlkkUvbNkGG@tardis.local>
 <e5fdd5db-4897-4975-a2db-ddb951385e89@paulmck-laptop>
 <acAyN0gMvOPfdP8H@tardis.local>
 <f5764f69-2fe1-4d9c-88ca-3838059c95ea@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5764f69-2fe1-4d9c-88ca-3838059c95ea@paulmck-laptop>

On Sun, Mar 22, 2026 at 12:47:41PM -0700, Paul E. McKenney wrote:
> On Sun, Mar 22, 2026 at 11:17:27AM -0700, Boqun Feng wrote:
> > On Sun, Mar 22, 2026 at 10:44:58AM -0700, Paul E. McKenney wrote:
> > [...]
> > > > > > > Longer term, shouldn't lockdep take into account the fact that on !SMP,
> > > > > > > the disabling of preemption (or interrupts or...) is essentially the same
> > > > > > > as acquiring a global lock?  This means that only one task at a time can
> > > > > > > be acquiring a raw spinlock on !SMP, so that the order of acquisition
> > > > > > > of raw spinlocks on !SMP is irrelevant?  (Aside from self-deadlocking
> > > > > > > double acquisitions, perhaps.)  In other words, shouldn't lockdep leave
> > > > > > > raw spinlocks out of lockdep's cycle-detection data structure?
> > > > > > 
> > > > > > Lockdep doesn't know whether a code path is UP-only, so it'll apply the
> > > > > > general locking rule to check. Similar as lockdep still detect
> > > > > > PREEMPT_RT locking issue for !PREEMPT_RT kernel. Maybe we can add a
> > > > > > separate kconfig to narrow down lockdep detection for UP-only if UP=y.
> > > > > 
> > > > > But lockdep *does* know when it is running in a CONFIG_SMP=n kernel,
> > > > > correct?  In which case all the code paths are UP-only.
> > > > 
> > > > Why? UP and SMP can share the same code path, no? Just because lockdep
> > > > is running in UP and see a code path, doesn't mean that code path is
> > > > UP-only, right? What I was trying to say is Lockdep detects generel
> > > > locking rule violation, so even when it's running in UP kernel, it'll
> > > > use rules that SMP uses.
> > > 
> > > I know that this is what lockdep is doing.  I am instead saying that
> > > what lockdep is doing is not a good thing.  ;-)
> > 
> > I see.
> > 
> > > > > The situation with CONFIG_PREEMPT_RT=y is quite different: The motivation
> > > > > was for people running lockdep on CONFIG_PREEMPT_RT=n kernels to
> > > > > detect and fix locking issues that would otherwise only show up in
> > > > > CONFIG_PREEMPT_RT=y kernels.
> > > > 
> > > > I'm not sure how it's different than people wanted to detect SMP=y
> > > > locking issues when running UP kernel. Of course, I didn't know whether
> > > > that's the intention because I wasn't there ;-)
> > > 
> > > It is very different.
> > > 
> > > There were very few people developing and running PREEMPT_RT, so it
> > > was quite difficult for them to clean up the lock-context issues that
> > > everyone else was creating.  Making lockdep check for PREEMPT_RT issues
> > > in !PREEMPT_RT kernels was therefore very helpful, at least to the
> > > PREEMPT_RT guys.
> > > 
> > > In contrast (and unlike 20 years ago), almost everyone runs SMP, so there
> > 
> > (It also means the people who cares UP is almost none ;-))
> 
> I don't know about that, given that the sets of people who run SMP and
> who care about UP are not necessarily disjoint.  But those who care *only*
> about UP definitely are no longer the vast majority.  ;-)
> 

You're right, I should have said "UP-only". And I *think* the reality is
that most of the sub-systems share the code path between UP and SMP, and
it works fine for them, because UP tests help them find SMP deadlock as
well. That's probably why lockdep has been doing this "not a good thing"
for a while.

> > > is no harm in !SMP lockdep ignoring things that would be deadlocks in
> > > SMP kernels.  The ample SMP lockdep testing will catch those issues,
> > > so there is no need for extra help from UP lockdep testing.
> > 
> > Fair point. If anyone cares UP enough to submit a patch in lockdep, I'm
> > happy to take a look.
> 
> Fair enough.
> 
> In other news, the SMP-check hack to rcutorture does suppress this lockdep
> issue, at least in my testing.  But I applied that change to my -rcu tree,
> which reverted me back to v1 of your patch and re-introduced the earlier
> lockdep issue.
> 
> So I am restarting the tests.
> 

Thank you!

Regards,
Boqun

> 							Thanx, Paul
> 
> > Regards,
> > Boqun
> > 
> > > 							Thanx, Paul
> > > 
> > > > Regards,
> > > > Boqun
> > > > 
> > > > > And of course, CONFIG_SMP=n kernels still need deadlock detection for
> > > > > mutexes and the like.
> > > > > 
> > > > > 							Thanx, Paul
