Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCCB4C7D;
	Fri, 10 May 2024 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349880; cv=none; b=OKFiUzqoq1cWeWa7QgSruKS/R6DgiwRDPF4WFgc9O5b/qQrcq4Toqjo3rRurOj06hmHJS2IF745FOdrEBys5fbB65+gdluoXzTxpEw03hIRpkvbL6e9CPvq35xrhxTLR/HPIJAYjKbTdXRgIYk6VDBzfAW9TW1elAfqvYcSXh98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349880; c=relaxed/simple;
	bh=OMQirsPOvIsCqngOdZSf4NXRE1YYUnkNF9Ko/lyxpj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx4jfZ4Lh78KGDcBI33sLcZksK/IdqapPmXI+r2Ak9iKnYedWFdFcbVHwyH5mB4EDkcb9O8NOTVRpNEsla3DSyS/V6DHV7DQoAp0nXK/hjsbuBIqvodHkpq1Ukjuq0z80ZSvBj46tUEorOJJvgVimbvj7x2hUD3Jrq/zrUI0G70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WewIYTGe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WewIYTGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9309C113CC;
	Fri, 10 May 2024 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715349879;
	bh=OMQirsPOvIsCqngOdZSf4NXRE1YYUnkNF9Ko/lyxpj8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WewIYTGe6PKfxcsYWDNi5CTQOavoidlNFH48EOtRB65njedZo2QOVFDbCbwWQ8G1a
	 0Bxe1FLM2iPWObDVgjCaU5lABm1uZfK5eOXhdo9chyKJFr9c1j1Mvf1hbHA4nvNxmw
	 shyau6+QxpmZN7pLK2/o92l9Tw8QeQnicCqRRUc13en/D6+EPuO0QJXPxopkLXifv1
	 S2xEfj7eE6kAASHCXSpCXmQnZkeJ2iInDPwObfRsuW/YahlRuSiwIm9bT5ri5q1riM
	 y//vQ57PH1sNGKqHhcNfH296hjDcbSK/rz3Fps8tilRrctEDI4+9cyZwb329VmObu5
	 XCMzYDHJQIRlw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 815A6CE08A1; Fri, 10 May 2024 07:04:39 -0700 (PDT)
Date: Fri, 10 May 2024 07:04:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
Message-ID: <8ca02df3-5034-4483-8e64-3fc22eb14431@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240509151312.GA22612@redhat.com>
 <f0a02cfe-7fc2-494c-8734-e5583f42a8f7@paulmck-laptop>
 <20240510113149.GA24764@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510113149.GA24764@redhat.com>

On Fri, May 10, 2024 at 01:31:49PM +0200, Oleg Nesterov wrote:
> On 05/09, Paul E. McKenney wrote:
> >
> > On Thu, May 09, 2024 at 05:13:12PM +0200, Oleg Nesterov wrote:
> > >
> > > We can move these WARN_ON()'s into the ->rss_lock protected section.
> > >
> > > Or perhaps we can use data_race(rsp->gp_count) ? To be honest I thought
> > > that READ_ONCE() should be enough...
> > >
> > > Or we can simply kill these WARN_ON_ONCE()'s.
> >
> > Or we could move those WARN_ON_ONCE() under the lock.
> 
> Sure, see above.
> 
> But could you help me to understand this magic? I naively thought
> that READ_ONCE() is always "safe"...
> 
> So, unless I am totally confused it turns out that, say,
> 
> 	CPU 0			CPU 1
> 	-----			-----
> 
> 	spin_lock(LOCK);
> 	++X;			READ_ONCE(X); // data race
> 	spin_unlock(LOCK);
> 
> is data-racy accoring to KCSAN, while
> 
> 	CPU 0			CPU 1
> 	-----			-----
> 
> 	spin_lock(LOCK);
> 	WRITE_ONCE(X, X+1);	READ_ONCE(X); // no data race
> 	spin_unlock(LOCK);
> 
> is not.

Agreed, in RCU code.

> Why is that?

Because I run KCSAN on RCU using Kconfig options that cause KCSAN
to be more strict.

> Trying to read Documentation/dev-tools/kcsan.rst... it says
> 
> 	KCSAN is aware of *marked atomic operations* (``READ_ONCE``, WRITE_ONCE``,
> 
> 	...
> 
> 	if all accesses to a variable that is accessed concurrently are properly
> 	marked, KCSAN will never trigger a watchpoint
> 
> but how can KCSAN detect that all accesses to X are properly marked? I see nothing
> KCSAN-related in the definition of WRITE_ONCE() or READ_ONCE().

The trick is that KCSAN sees the volatile cast that both READ_ONCE()
and WRITE_ONCE() use.

> And what does the "all accesses" above actually mean? The 2nd version does
> 
> 	WRITE_ONCE(X, X+1);
> 
> but "X + 1" is the plain/unmarked access?

That would be the correct usage in RCU code if there were lockless
accesses to X, which would use READ_ONCE(), but a lock was held across
that WRITE_ONCE() such that there would be no concurrent updates of X.
In that case, the "X+1" cannot be involved in a data race, so KCSAN
won't complain.

But if all accesses to X were protected by an exclusive lock, then there
would be no data races involving X, and thus no marking of any accesses
to X.  Which would allow KCSAN to detect buggy lockless accesses to X.

							Thanx, Paul
