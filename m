Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044DD3101A9
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852133; cv=none; b=WpmJGkqvQhqj7ZtMTdYzzaIfFQ14rcxbdA/+Dw3UgxxvVav532z5Yj/MzWR8kzqKY/rKABQsqiwtttF5yHP0ONCECgwAi2koIIeveRDe9BsSeBtP8MFyRJOMgt3EwWPCNCmyzxACSXA3jkm/z3Veyw8RvXj83huQP9Qd5glGTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852133; c=relaxed/simple;
	bh=xU97FWneH73EKziKqfokt+cDZwVxQchF5Ck7byA9iRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMd4v6KZS8VOJ/elNky8b7XUbV+MePSYk3ksnvq/9JJZjMr93mqzqC51qDnduDoegzqTJsnya7VfGyQuXHpzoYpaPCcezcAxhMg/S63ysjBZNqmNIfmym/klA3sVEqMmZ9oRYau+k/OtCHyuPySTbPfpkWAnVkBy9+Z+m+lHzDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Isa9CKI9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Isa9CKI9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01601C19421;
	Wed, 18 Mar 2026 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773852132;
	bh=xU97FWneH73EKziKqfokt+cDZwVxQchF5Ck7byA9iRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Isa9CKI9dZwRXfXro1mQ1qyOzRyd3L+FRQJVaoSxyWBOJxnktiueBmo4kUIUUgL9K
	 1Pjhonw3rkYmE/y4n2SJ2e9pxrc/IO2HaQWw/T6fY7+Zjh3jnOkT3BUGOT+Y8aof0f
	 qScQ7HjxAbpjJ6ffBgDaqo1Tj7U09oUTS61WYpb37Bn6pCJgSY7rwoEQfg/Qd4FBlF
	 tSqRCbkg45heXJR8mA9kvUTjrAK5LpjVCT5yiGuA5/XCUYBqGubA+Y4tB1sUxts1yt
	 CZa6wljfj2TAjzW7fCNJqEgA8wmJB3RBq4X1tJmAGHyO34s4+5Vd9A93ANzauDYvXf
	 AhS5YYCUA8SwQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id BD96AF40074;
	Wed, 18 Mar 2026 12:42:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 18 Mar 2026 12:42:10 -0400
X-ME-Sender: <xms:4tW6aSxUnF8CsxjOGzYxkpI52FE_1aRRrtFaxl3KH4Xjk5hKLNKgHw>
    <xme:4tW6aa1Fi2GfrZ38i6eXS14ZApE4l9EoyTF9s1NQmU6tAE_w_HIAqJCMafg22YxpF
    7W5KH21FIpMsoLaTYgCzNnGVgUbaVZ1GykEsyCHBV4QHN0L58Nl>
X-ME-Received: <xmr:4tW6aYxRCF5ujFUs09itDCgr3bYNH99jixi1J3WSQuHaTbi2gHqI-CD0V-I1jKwjW623LfCbvjYTlPWJAJCVmRA6lVX7b6Pn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekgffhhfeuheelhfekteeuffejveetjeefffettedtteegfefftdduteduudfgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgr
    uhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghighgvrghshieslhhinh
    huthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgvvghrrghjrdhiihhtrhdutdesghhmrghilhdrtghomhdprh
    gtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehjohgvlhgr
    ghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvghmgihorhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:4tW6afWBU0jH3wEBZP_IhwkwVVjBSf9_z8cOxJDK67c3dPxQZNpPZA>
    <xmx:4tW6aU9LSnLMXEK_kJ-sNgyAKXQo05VVvCs3q7eTZHhkhOKXHwRHug>
    <xmx:4tW6aSuCITEejcvtapgQXhJq6HFjh_0ZRKk_MFcuqg3uaX450rU5BA>
    <xmx:4tW6aU13m-OZoND0k_ycEUnHYn5nXaDM2dYQEjs4L_maUHfH2JQ1WA>
    <xmx:4tW6aXQKzxmfn7kfA9HwYDoeu5R1eLUOUtdQ7mhHS4vPxLyu14D9A4rk>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 12:42:10 -0400 (EDT)
Date: Wed, 18 Mar 2026 09:42:09 -0700
From: Boqun Feng <boqun@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org,
	neeraj.iitr10@gmail.com, urezki@gmail.com, joelagnelf@nvidia.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <abrV4VResx7QERRo@tardis.local>
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <76ef9a5e-7343-4b8e-bf3c-cabd8753ecdb@paulmck-laptop>
 <20260318160445.IyUiWV0T@linutronix.de>
 <06a0cb91-1737-4691-a810-8340e1acf1d6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a0cb91-1737-4691-a810-8340e1acf1d6@paulmck-laptop>

On Wed, Mar 18, 2026 at 09:32:07AM -0700, Paul E. McKenney wrote:
> On Wed, Mar 18, 2026 at 05:04:45PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-03-18 08:43:32 [-0700], Paul E. McKenney wrote:
> > > > Your patch just s/spinlock_t/raw_spinlock_t so we get the locking/
> > > > nesting right. The wakeup problem remains, right?
> > > > But looking at the code, there is just srcu_funnel_gp_start(). If its
> > > > srcu_schedule_cbs_sdp() / queue_delayed_work() usage is always delayed
> > > > then there will be always a timer and never a direct wake up of the
> > > > worker. Wouldn't that work?
> > > 
> > > Right, that patch fixes one lockdep problem, but another remains.
> > 
> > What remains?
> 
> With that patch, we no longer have call_srcu() directly acquiring a
> non-raw spinlock, but as you say, we still have the wakeup problem.
> 

I don't think we have a wakeup problem since we use workqueue to defer
the wakeup, but maybe I'm missing something here?

Regards,
Boqun
