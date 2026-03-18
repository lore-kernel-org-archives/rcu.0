Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B43EF650
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849080; cv=none; b=Fi6sLkiVNIGpmYqwap8Ag6qaUNUKFbZ4X7V0U/ltaCqYftE5pa5Au+19uvyT7sgaGFQZWgpT25MWVHoCqmG2myLvjei8zcvjJBXjDN4LE6qOi3N7pJX+Zr2pwswyarPKK6whmh9C92Une8PhAI2R93i6JzOj4/FxDW61uiqtY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849080; c=relaxed/simple;
	bh=UD+uy9GCF/jf5Mm7ZY7xhizu5LZy/INHQ0Zg6Y9eqyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT3byIwK5QO5LQYMJhKC9MM6Hlimm8L1MRYEln2mAGM38djG4lcwfksFgYB0w0xaSrHE7wbf+mWPtP2tiOMbvuJK+uUojvAy0FMk/z5ShEIxvPBvvx242TfR3+rtdnJ/Psa6wuZrAbDgR9cjvpCyC5y7prsmCOu7H9uSp1oSvuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxIDKpmS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxIDKpmS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FB8C2BCB1;
	Wed, 18 Mar 2026 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773849080;
	bh=UD+uy9GCF/jf5Mm7ZY7xhizu5LZy/INHQ0Zg6Y9eqyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxIDKpmSzj7AAirTDlMI/6H7bDMyrIBv9p9vIBiG+aYbF3SGbfqe0YBnZSNEcV4jY
	 I7iHx2ONv9IDpzm804qPQh6OacxoK2KDJEI11sCEm0qLf1MQgJs1uJECuJuY8uk+nn
	 NvxOcaooUNfxsdrVgt2LkuJFS7p/aDNuOQ9Pyysi1oiZy1h5lxH6V0kS+tUK2ChgRX
	 DjjXDh1LvPdwgDxpDtdghGvkg7uxd1UctxBPnJkXk7yHR0xwDQI812FBkD7KfqObBR
	 rhPTCpH7mwzd7jleZCKRhES8SOQpHMJK56FHm3FxtoAcSH146AQqraZrGtZVIUM8gO
	 xzT6zuEGywZ8w==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4128DF40068;
	Wed, 18 Mar 2026 11:51:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 18 Mar 2026 11:51:18 -0400
X-ME-Sender: <xms:9sm6abftS3wiIhBjg64alSdccji3uyl34qbGzWWds3vP7ez4vUW3YA>
    <xme:9sm6adyHZnLzWrZYzPx3VlIR7nsVeLp3DVbn3HVf-klGa0H47IWeWuiqDsJWsz1IU
    cS5g0MWucHBxsyEVIegqu3iKCDUhxKkK-jVipIpeSywm13omYplBQ>
X-ME-Received: <xmr:9sm6aY-5LU4mKlXbfPHaqAKfw0-Ych7xdBIoYEOZHdVvDVYGFhG89v6HHAXPbnBcP732PBqY1a1_I_WLyBxnbj1ShdlpYHaT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekgffhhfeuheelhfekteeuffejveetjeefffettedtteegfefftdduteduudfgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghi
    ghgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehprghulhhmtghkse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgvvghrrghjrdhiihhtrhdutdesghhmrghilhdrtghomhdprh
    gtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehjohgvlhgr
    ghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvghmgihorhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:9sm6aTx9d6BDD9eTtkgxpJf0bEHw7x9Q82ITT65D5M5FDh7vkE7izw>
    <xmx:9sm6aYoS0oSWj7CJTo5NJlRir9x3GyV_jVXVhxpgxdLT-T4lbMBiCA>
    <xmx:9sm6aUpYVOYr6vPack7KMjQgqhIpH3QqJLhyZewg6TJFhQyItm6rpw>
    <xmx:9sm6aYB8NP1LNmKvV4OQwf4HQggJplTlQLmcNiKOjUKSIfscaufNdg>
    <xmx:9sm6aSsTpn_kASd9im-zFDnVT_uH9Io5jWmCAdogCTqXS1Vr73d-hzi8>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 11:51:17 -0400 (EDT)
Date: Wed, 18 Mar 2026 08:51:16 -0700
From: Boqun Feng <boqun@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
	neeraj.iitr10@gmail.com, urezki@gmail.com, joelagnelf@nvidia.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <abrJ9C637V6keRvd@tardis.local>
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318144305.xI6RDtzk@linutronix.de>

On Wed, Mar 18, 2026 at 03:43:05PM +0100, Sebastian Andrzej Siewior wrote:
[..]
> > > > way that vanilla RCU's call_rcu_core() function takes an early exit if
> > > > interrupts are disabled.  Of course, vanilla RCU can rely on things like
> > > > the scheduling-clock interrupt to start any needed grace periods [1],
> > > > but SRCU will instead need to manually defer this work, perhaps using
> > > > workqueues or IRQ work.
> > > > 
> > > > In addition, rcutorture needs to be upgraded to sometimes invoke
> > > > ->call() with the scheduler pi lock held, but this change is not fixing
> > > > a regression, so could be deferred.  (There is already code in rcutorture
> > > > that invokes the readers while holding a scheduler pi lock.)
> > > > 
> > > > Given that RCU for this week through the end of March belongs to you guys,
> > > > if one of you can get this done by end of day Thursday, London time,
> > > > very good!  Otherwise, I can put something together.
> > > > 
> > > > Please let me know!
> > > 
> > > Given that the current locking does allow it and lockdep should have
> > > complained, I am curious if we could rule that out ;)
> 
> Your patch just s/spinlock_t/raw_spinlock_t so we get the locking/
> nesting right. The wakeup problem remains, right?
> But looking at the code, there is just srcu_funnel_gp_start(). If its
> srcu_schedule_cbs_sdp() / queue_delayed_work() usage is always delayed
> then there will be always a timer and never a direct wake up of the
> worker. Wouldn't that work?
> 

Late to the party, so just make sure I understand the problem. The
problem is the wakeup in call_srcu() when it's called with scheduler
lock held, right? If so I think the current code works as what you
already explain, we defer the wakeup into a workqueue.

(but Paul, we are not talking about calling call_srcu(), that requires
some more work to get it work)

> > It would be nice, but your point about needing to worry about spinlocks
> > is compelling.
> > 
> > But couldn't lockdep scan the current task's list of held locks and see
> > whether only raw spinlocks are held (including when no spinlocks of any
> > type are held), and complain in that case?  Or would that scanning be
> > too high of overhead?  (But we need that scan anyway to check deadlock,
> > don't we?)
> 
> PeterZ didn't like it and the nesting thing identified most of the
> problem cases. It should also catch _this_ one.
> 
> Thinking about it further, you don't need to worry about
> local_bh_disable() but RCU will becomes another corner case. You would
> have to exclude "rcu_read_lock(); spin_lock();" on a !preempt kernel
> which would otherwise lead to false positives.
> But as I said, this case as explained is a nesting problem and should be
> reported by lockdep with its current features.
> 

Right, otherwise there is a lockdep bug ;-)

Regards,
Boqun
