Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C0013B787;
	Fri, 10 May 2024 03:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715313569; cv=none; b=Q5ScD6VIgS2E38wyCNTtbZTRr/SCBDSvOdXwkq1+t2WnNJBQJbk5L+VlSMcdjLaAoR12HrhfqZoVCVvwDXvuWNk9Y+F+3UiZq3+GFMMuZok/7aiE6yitMFFocAqg4oV/1TKvswqQxtC/zWGMvS0Og329S8Wnll24aL0BlEI7LMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715313569; c=relaxed/simple;
	bh=lR/6ycEqY8yVvEsBHCwGyES8BgQErTXVxwI8zleD1NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSxQd85H7m0rmN1BeJhNRZhF6tnT/Im08tnl73ykNZkWdotpQxFE7ruBZE3HCrwHF4gEq/d4J9g/tqjqwPhKZ29htV2mjSOvKF/eqJPCSVTZv3SvFF9K1WU5VeRgJgd0Oe/KYJWFcT0Cm1USNVF5xOEIHgDHVeVOdbbq3IK9rsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKrtnzVL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKrtnzVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E860C113CC;
	Fri, 10 May 2024 03:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715313568;
	bh=lR/6ycEqY8yVvEsBHCwGyES8BgQErTXVxwI8zleD1NE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HKrtnzVLRcXxjc6T4iiv2lcTSxnFLFqXlBoRRu83BAqcaOOllh7T5YPXgvpJg+7Cv
	 JnyYiMoyOijEMewV/dtG+JdpoyTit3dq5PA/6tuz+qSsdv1+mtlsCkABZmBUuNSJSX
	 ew0RRSQOtgAfdQVL7JyEL5HqzbliKhOC40WuorC7GD+qgyY36ulJPDgnykKu1fRG9h
	 q3Zp75EpVKtKOu0qM6GBIaHgOw6vcB05ZTOHeqrHWC0yLvf5P3eOvs29r8lfl/7KTG
	 J5QfI1qq3suM/wUUVkaZ10c4FRwO8l1PKyei7xB0L2H/oCvSVDL/fJahLtalmKqPRR
	 WPlmUz3Kysn5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 302F3CE12E9; Thu,  9 May 2024 20:59:28 -0700 (PDT)
Date: Thu, 9 May 2024 20:59:28 -0700
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
Message-ID: <f0a02cfe-7fc2-494c-8734-e5583f42a8f7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240509151312.GA22612@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509151312.GA22612@redhat.com>

On Thu, May 09, 2024 at 05:13:12PM +0200, Oleg Nesterov wrote:
> On 05/07, Paul E. McKenney wrote:
> >
> > On Tue, May 07, 2024 at 10:54:41AM -0400, Oleg Nesterov wrote:
> > > Hello,
> > >
> > > I feel I don't really like this patch but I am travelling without my working
> > > laptop, can't read the source code ;) Quite possibly I am wrong, I'll return
> > > to this when I get back on May 10.
> >
> > By the stricter data-race rules used in RCU code [1], this is a bug that
> > needs to be fixed.
> 
> Now that I can read the code... Sorry, still can't understand.
> 
> > which is read locklessly,
> 
> Where???
> 
> OK, OK, we have
> 
> 	// rcu_sync_exit()
> 	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0)
> 
> and
> 
> 	// rcu_sync_dtor()
> 	WARN_ON_ONCE(READ_ONCE(rsp->gp_count));
> 
> other than that ->gp_count is always accessed under ->rss_lock.
> 
> And yes, at least WARN_ON_ONCE() in rcu_sync_exit() can obviously race with
> rcu_sync_enter/exit which update gp_count. I think this is fine correctness-wise.
> 
> But OK, we need to please KCSAN (or is there another problem I missed ???)
> 
> We can move these WARN_ON()'s into the ->rss_lock protected section.
> 
> Or perhaps we can use data_race(rsp->gp_count) ? To be honest I thought
> that READ_ONCE() should be enough...
> 
> Or we can simply kill these WARN_ON_ONCE()'s.

Or we could move those WARN_ON_ONCE() under the lock.  If this would
be a lock-contention issue, we could condition them with something like
IS_ENABLED(CONFIG_PROVE_RCU).  Then all accesses to those variables would
always be protected by the lock, and the WRITE_ONCE() and READ_ONCE()
calls could be dropped.  (Or am I missing another lockless access?)

Which would have the further advantage that if anyone accessed these
without holding the lock, KCSAN would complain.

> I don't understand why should we add more WRITE_ONCE()'s into the critical
> section protected by ->rss_lock.

There are indeed several ways to fix this.  Which would you prefer?

> Help! ;)

;-) ;-) ;-)

							Thanx, Paul

> Oleg.
> 
> 
> which in turn results in a data race.  The fix is to mark
> > the updates (as below) with WRITE_ONCE().
> >
> > Or is there something in one or the other of these updates to ->gp_count
> > that excludes lockless readers?  (I am not seeing it, but you know this
> > code way better than I do!)
> >
> > 							Thanx, Paul
> >
> > [1] https://docs.google.com/document/d/1FwZaXSg3A55ivVoWffA9iMuhJ3_Gmj_E494dLYjjyLQ/edit?usp=sharing
> >
> > > Oleg.
> > >
> > > On 05/07, Uladzislau Rezki (Sony) wrote:
> > > >
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > >
> > > > The rcu_sync structure's ->gp_count field is updated under the protection
> > > > of ->rss_lock, but read locklessly, and KCSAN noted the data race.
> > > > This commit therefore uses WRITE_ONCE() to do this update to clearly
> > > > document its racy nature.
> > > >
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  kernel/rcu/sync.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
> > > > index 86df878a2fee..6c2bd9001adc 100644
> > > > --- a/kernel/rcu/sync.c
> > > > +++ b/kernel/rcu/sync.c
> > > > @@ -122,7 +122,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
> > > >  		 * we are called at early boot time but this shouldn't happen.
> > > >  		 */
> > > >  	}
> > > > -	rsp->gp_count++;
> > > > +	WRITE_ONCE(rsp->gp_count, rsp->gp_count + 1);
> > > >  	spin_unlock_irq(&rsp->rss_lock);
> > > >
> > > >  	if (gp_state == GP_IDLE) {
> > > > @@ -151,11 +151,15 @@ void rcu_sync_enter(struct rcu_sync *rsp)
> > > >   */
> > > >  void rcu_sync_exit(struct rcu_sync *rsp)
> > > >  {
> > > > +	int gpc;
> > > > +
> > > >  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
> > > >  	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
> > > >
> > > >  	spin_lock_irq(&rsp->rss_lock);
> > > > -	if (!--rsp->gp_count) {
> > > > +	gpc = rsp->gp_count - 1;
> > > > +	WRITE_ONCE(rsp->gp_count, gpc);
> > > > +	if (!gpc) {
> > > >  		if (rsp->gp_state == GP_PASSED) {
> > > >  			WRITE_ONCE(rsp->gp_state, GP_EXIT);
> > > >  			rcu_sync_call(rsp);
> > > > --
> > > > 2.39.2
> > > >
> > >
> >
> 
