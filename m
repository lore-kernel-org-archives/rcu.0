Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88DA433D9;
	Sun,  2 Mar 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740937185; cv=none; b=peC+J5Nws3C2LHuHN2VsMEVO0Y4dZ3CUHLZ3pPzb50oioI70tHhyaTRfzwOir8Bb7WtPG5w/0uowJMC4vwa5pvpgw4wXFvacEz9ygFZqWJZJtYjazeKLQGMbB8BJu/4Z3akOVLLqoCIlc4J7zXaNX22VXJCqMZIM9hsjxTR6+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740937185; c=relaxed/simple;
	bh=7e9ji4XsLmPzo38zMA9WI7OmWmr48fhIOD+WeN0TUgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tk8h9G+J3K0lZiVkLQ4ATFBTqWw5V49yrOuBG12UtXEv6dqKM8N97JoLKdYSx3mUxQzwz4zzOY+xFDZ2ir6ydf7/jCBBH9K09+7lxALaB8+9DrNtk5YvSYmH+P2aFJFlN7YuWu3uHyJolbRI3kpVZ/ESjnX4KLbrDsbDyuFdPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBNrKCib; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBNrKCib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105D2C4CED6;
	Sun,  2 Mar 2025 17:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740937185;
	bh=7e9ji4XsLmPzo38zMA9WI7OmWmr48fhIOD+WeN0TUgg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NBNrKCibXDw3vAa+0cpfqe4U6Rpnt3ljj7P9JgVecNDY8e8z8INyFsFVTGvNISw5l
	 xy6mjBpiFDf0Dd5dTZOrA7BWcVHdBkTqh6WjtIVJ0y8MbmXAApaYrMqbdDbHer99ng
	 LcdpV37Ad9/rvVjxzEIia3b2f6w0lHAAZwwFFte/uo56pw187HRwcYWb4gWND0DqVv
	 eP15HQ8n3aQ8MXYIv1mpKCOEMuYWswsg0OcXRZRpDskLu3zfty7+F15F8U+TK6uS7d
	 02NCVPcjbtxLQ6FtyGwhKqEgzy68DJh3H5nGXp+CzdCjVxA31JbIAUP0xuznHjPLi8
	 kziLxwe1oCFzQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A742FCE05B1; Sun,  2 Mar 2025 09:39:44 -0800 (PST)
Date: Sun, 2 Mar 2025 09:39:44 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <d90bd6d9-d15c-4b9b-8a69-95336e74e8f4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <Z8QwwBCoWb4J3_Xv@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8QwwBCoWb4J3_Xv@pc636>

On Sun, Mar 02, 2025 at 11:19:44AM +0100, Uladzislau Rezki wrote:
> On Fri, Feb 28, 2025 at 05:08:49PM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 28, 2025 at 11:59:55AM -0800, Paul E. McKenney wrote:
> > > On Fri, Feb 28, 2025 at 08:12:51PM +0100, Uladzislau Rezki wrote:
> > > > Hello, Paul!
> > > > 
> > > > > > > > > 
> > > > > > > > > Except that I got this from overnight testing of rcu/dev on the shared
> > > > > > > > > RCU tree:
> > > > > > > > > 
> > > > > > > > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > > > > > > > > 
> > > > > > > > > I see this only on TREE05.  Which should not be too surprising, given
> > > > > > > > > that this is the scenario that tests it.  It happened within five minutes
> > > > > > > > > on all 14 of the TREE05 runs.
> > > > > > > > > 
> > > > > > > > Hm.. This is not fun. I tested this on my system and i did not manage to
> > > > > > > > trigger this whereas you do. Something is wrong.
> > > > > > > 
> > > > > > > If you have a debug patch, I would be happy to give it a go.
> > > > > > > 
> > > > > > I can trigger it. But.
> > > > > > 
> > > > > > Some background. I tested those patches during many hours on the stable
> > > > > > kernel which is 6.13. On that kernel i was not able to trigger it. Running
> > > > > > the rcutorture on the our shared "dev" tree, which i did now, triggers this
> > > > > > right away.
> > > > > 
> > > > > Bisection?  (Hey, you knew that was coming!)
> > > > > 
> > > > Looks like this: rcu: Fix get_state_synchronize_rcu_full() GP-start detection
> > > > 
> > > > After revert in the dev, rcutorture passes TREE05, 16 instances.
> > > 
> > > Huh.  We sure don't get to revert that one...
> > > 
> > > Do we have a problem with the ordering in rcu_gp_init() between the calls
> > > to rcu_seq_start() and portions of rcu_sr_normal_gp_init()?  For example,
> > > do we need to capture the relevant portion of the list before the call
> > > to rcu_seq_start(), and do the grace-period-start work afterwards?
> > 
> > I tried moving the call to rcu_sr_normal_gp_init() before the call to
> > rcu_seq_start() and got no failures in a one-hour run of 200*TREE05.
> > Which does not necessarily mean that this is the correct fix, but I
> > figured that it might at least provide food for thought.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 48384fa2eaeb8..d3efeff7740e7 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1819,10 +1819,10 @@ static noinline_for_stack bool rcu_gp_init(void)
> >  
> >  	/* Advance to a new grace period and initialize state. */
> >  	record_gp_stall_check_time();
> > +	start_new_poll = rcu_sr_normal_gp_init();
> >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> >  	rcu_seq_start(&rcu_state.gp_seq);
> >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > -	start_new_poll = rcu_sr_normal_gp_init();
> >  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> >  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> >  	raw_spin_unlock_irq_rcu_node(rnp);
> >
> Running this 24 hours already. TREE05 * 16 scenario. I do not see any
> warnings yet. There is a race, indeed. The gp_seq is moved forward,
> wheres clients can still come until rcu_sr_normal_gp_init() places a
> dummy-wait-head for this GP.
> 
> Thank you for testing Paul and looking to this :)

Very good!  This is a bug in this commit of mine:

012f47f0f806 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")

Boqun, could you please fold this into that commit with something like
this added to the commit log just before the paragraph starting with
"Although this fixes 91a967fd6934"?

	However, simply changing get_state_synchronize_rcu_full() function
	to use rcu_state.gp_seq instead of the root rcu_node structure's
	->gp_seq field results in a theoretical bug in kernels booted
	with rcutree.rcu_normal_wake_from_gp=1 due to the following
	sequence of events:

	o	The rcu_gp_init() function invokes rcu_seq_start()
		to officially start a new grace period.

	o	A new RCU reader begins, referencing X from some
		RCU-protected list.  The new grace period is not
		obligated to wait for this reader.

	o	An updater removes X, then calls synchronize_rcu(),
		which queues a wait element.

	o	The grace period ends, awakening the updater, which
		frees X while the reader is still referencing it.

	The reason that this is theoretical is that although the
	grace period has officially started, none of the CPUs are
	officially aware of this, and thus will have to assume that
	the RCU reader pre-dated the start of the grace period.

	Except for kernels built with CONFIG_PROVE_RCU=y, which use the
	polled grace-period APIs, which can and do complain bitterly when
	this sequence of events occurs.  Not only that, there might be
	some future RCU grace-period mechanism that pulls this sequence
	of events from theory into practice.  This commit therefore
	also pulls the call to rcu_sr_normal_gp_init() to precede that
	to rcu_seq_start().

I will let you guys decide whether the call to rcu_sr_normal_gp_init()
needs a comment, and, if so, what that comment should say.  ;-)

							Thanx, Paul
