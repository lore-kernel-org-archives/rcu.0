Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C93101B4
	for <rcu@vger.kernel.org>; Sun, 22 Mar 2026 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774203450; cv=none; b=AqTk49/koqMPrIfKaMH3pyIblkqAYJIS2Bn8vg3GfOW1WzNiSEoNk1fL9LhKGnxi/mHemEbnYQh3Jhfvc4lI8IR1jS/N+zDWpZReRyhNQterrrs6/usIWFEXQq+fNIS4JnRnWvPa4K1Ed40Ic0CDbozm62hJcietfuo6+DPnA90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774203450; c=relaxed/simple;
	bh=hFIbevRwe6C0ZcRuRyNGomzHYKZkodjdpNAwhM8y4Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsJDlxTb0xEGArhCa+tuCQzt2jOwgQnB2aqBPbhLvf9m7MXN39+x+9kd8KKe1qa1KcjfGs1TBfKgbVrwl8rWx6eab9TK10YpaztF9Jw76KLEQZphtfB0M/1TTpCZ3m5/iQVQAlPd5FRYkL0F8fag4S60mEgNcmDKyxWj7ow7uvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFxOIegr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFxOIegr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B16C19424;
	Sun, 22 Mar 2026 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774203450;
	bh=hFIbevRwe6C0ZcRuRyNGomzHYKZkodjdpNAwhM8y4Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AFxOIegrOk7e331twVTSrUuaoK8nGwyVtlVBP5KUOl4rkXEG2uqMyS8vyQXcD91Ns
	 y8SM3Eyu4vgzz/QdKn1+KvQEhhTe2v9os3NVMf5VgDBVImXpY/xl6Vl4wTO6vwNlvx
	 QLAJcVJFuuGSnEuOSAV5Bd6snUes01mc1+VcZGuA5CtKbbK+TUGa5wB8xWXEM5/z6y
	 hHIPp1OyTPGtOUTmgQPmMllxqhnZ6N51gRYhvwoEOytiYeRFnMhTpFz9E7BzCFUZtI
	 xszlMjuqDszSth7e/oWbPvcsY3Jkz8JNw75bT7JFWdfnhbwM4Fcz9bzAXwxU3EFaaR
	 oQKoGVtB1AHtg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id A5777F4006F;
	Sun, 22 Mar 2026 14:17:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 22 Mar 2026 14:17:28 -0400
X-ME-Sender: <xms:ODLAaZieqognUrzfZpw-XahU3Ll8i0z6IZ1-GM7lRfR2cMjyB1wU6g>
    <xme:ODLAaXZiqFANHqd1gNA0XhHkR3EY6I5WQA9yMitzPLwPoJq5NQiIyIp5XEMoeFh6e
    pVWt1gLHd50gMPVHZbX68K6xr0CpsNRD9T3GD8a009nxZDzMqO9Sg>
X-ME-Received: <xmr:ODLAaRku74hjHK40dLTtVJZRnpBzXJHHBqaeBfTxBWkR461_zSIzPf5mHqgUi44D1PbCLe3isGTPQqXQi2aQntBJR2s2jZOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeihedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ODLAadyUhZq2oaWYMQJoCC5L9A3Q6vp6E66uKuxNsdJNpuWX4iQt8Q>
    <xmx:ODLAaX8PG7BThnkYeuHEMkGHGR15p5JlesvjEgr6PuCKP5TdyBGRqQ>
    <xmx:ODLAaQB9B2QfMfsT7oJP2oBXMFI7APwm3UYT41hqMJLQxNnPmIUq3Q>
    <xmx:ODLAaWrbc0d1PK08fjp2tvXwDLYEbw7GkPuOMHGP4VGOT8MF8tx9lg>
    <xmx:ODLAaQlncv5g3O3Zpbcv8g3Znuf0rVP3dnhsyEQnw904FItssw7SL_tv>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Mar 2026 14:17:28 -0400 (EDT)
Date: Sun, 22 Mar 2026 11:17:27 -0700
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
Message-ID: <acAyN0gMvOPfdP8H@tardis.local>
References: <ab7eQ0QDNV9ZjQMN@tardis.local>
 <609b5df1-aa06-46a9-8e93-0bf9eb8b7738@paulmck-laptop>
 <ab71Vz9zmlVywWQT@tardis.local>
 <4d2b07a9-e3fd-4a95-8924-0839bdfc28b3@paulmck-laptop>
 <ab7623FFsiUOocHP@tardis.local>
 <3486c7a2-73e6-46f2-a030-c9349ce964dd@paulmck-laptop>
 <acAV-16pYQvy06aw@tardis.local>
 <902d80c5-02a9-46d0-9d6a-06e8cd94cd37@paulmck-laptop>
 <acAnYrlkkUvbNkGG@tardis.local>
 <e5fdd5db-4897-4975-a2db-ddb951385e89@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5fdd5db-4897-4975-a2db-ddb951385e89@paulmck-laptop>

On Sun, Mar 22, 2026 at 10:44:58AM -0700, Paul E. McKenney wrote:
[...]
> > > > > Longer term, shouldn't lockdep take into account the fact that on !SMP,
> > > > > the disabling of preemption (or interrupts or...) is essentially the same
> > > > > as acquiring a global lock?  This means that only one task at a time can
> > > > > be acquiring a raw spinlock on !SMP, so that the order of acquisition
> > > > > of raw spinlocks on !SMP is irrelevant?  (Aside from self-deadlocking
> > > > > double acquisitions, perhaps.)  In other words, shouldn't lockdep leave
> > > > > raw spinlocks out of lockdep's cycle-detection data structure?
> > > > 
> > > > Lockdep doesn't know whether a code path is UP-only, so it'll apply the
> > > > general locking rule to check. Similar as lockdep still detect
> > > > PREEMPT_RT locking issue for !PREEMPT_RT kernel. Maybe we can add a
> > > > separate kconfig to narrow down lockdep detection for UP-only if UP=y.
> > > 
> > > But lockdep *does* know when it is running in a CONFIG_SMP=n kernel,
> > > correct?  In which case all the code paths are UP-only.
> > 
> > Why? UP and SMP can share the same code path, no? Just because lockdep
> > is running in UP and see a code path, doesn't mean that code path is
> > UP-only, right? What I was trying to say is Lockdep detects generel
> > locking rule violation, so even when it's running in UP kernel, it'll
> > use rules that SMP uses.
> 
> I know that this is what lockdep is doing.  I am instead saying that
> what lockdep is doing is not a good thing.  ;-)
> 

I see.

> > > The situation with CONFIG_PREEMPT_RT=y is quite different: The motivation
> > > was for people running lockdep on CONFIG_PREEMPT_RT=n kernels to
> > > detect and fix locking issues that would otherwise only show up in
> > > CONFIG_PREEMPT_RT=y kernels.
> > 
> > I'm not sure how it's different than people wanted to detect SMP=y
> > locking issues when running UP kernel. Of course, I didn't know whether
> > that's the intention because I wasn't there ;-)
> 
> It is very different.
> 
> There were very few people developing and running PREEMPT_RT, so it
> was quite difficult for them to clean up the lock-context issues that
> everyone else was creating.  Making lockdep check for PREEMPT_RT issues
> in !PREEMPT_RT kernels was therefore very helpful, at least to the
> PREEMPT_RT guys.
> 
> In contrast (and unlike 20 years ago), almost everyone runs SMP, so there

(It also means the people who cares UP is almost none ;-))

> is no harm in !SMP lockdep ignoring things that would be deadlocks in
> SMP kernels.  The ample SMP lockdep testing will catch those issues,
> so there is no need for extra help from UP lockdep testing.
> 

Fair point. If anyone cares UP enough to submit a patch in lockdep, I'm
happy to take a look.

Regards,
Boqun

> 							Thanx, Paul
> 
> > Regards,
> > Boqun
> > 
> > > And of course, CONFIG_SMP=n kernels still need deadlock detection for
> > > mutexes and the like.
> > > 
> > > 							Thanx, Paul
