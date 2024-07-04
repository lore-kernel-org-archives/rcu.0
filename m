Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD0E10A35;
	Thu,  4 Jul 2024 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720131505; cv=none; b=l+dDbKZCGTHYfwgArATbn+WCOQMQDi/llw1CBBdrT/igrefRyatZOOJJnkfc08iYxrzRGt9cO3u16w1My+1j29qyODrh6Jkd8VLCq2BKSZSHExYTGkCjgehYfoNCo3cs6bGHVNxfm00s0HzPV+T0pgZI6kYvvt2GX3VgScC4b/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720131505; c=relaxed/simple;
	bh=d+BVCpHA/lgf3h4px7dfugKp3IyudFXyWxITiIszq7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecdLPFbpWijcKU9wjCk9Rcr18Vyq9Sg8HfDHflJ3bnJSXqQ8GRPk1r4go7d1wiUohtzxeonGTV6Gpgn6GlAR6LwOefXAwncCuryz7PTnGEvyOquZuHZOX5vJZlldd2RhMbgM+cH7mJDxnSgPjQT64ncSStDT7h3zvydrcDUqeNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqlSwBzX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqlSwBzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8C6C3277B;
	Thu,  4 Jul 2024 22:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720131504;
	bh=d+BVCpHA/lgf3h4px7dfugKp3IyudFXyWxITiIszq7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqlSwBzXivSz4uFlXc2O81bTCSQSdkmAgIj4j0uO/P3SEpvU+Y4RJJOxrVgKQU5ms
	 eYLEyimz8bdWQBbaRuOeShbi7LwXMVfVQqEYCF8EJIf4PkLYwIHyindr2ygkK7a4N6
	 0A6GRpXNC2wGgIkx2p48lTmw0MWC5YVAQQcpsJy2PoriFRl/csslbQC9fMp7kyF0WG
	 d6tg1PokKlVh6xOlFBiE6mY8BSBYqp0yJTOZc8zN4N5IfzQxg70vb5s4aZi735tfyP
	 gu2KfzF/onKBq+qhjqq3SDJ7CCBMRzt1TCk6MAHh5jQPObDm6J7ZMtoAfegROTHMOP
	 rkRzCtmiPQ9dQ==
Date: Fri, 5 Jul 2024 00:18:22 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Leonardo Bras <leobras@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH rcu 6/9] rcu: Add rcutree.nocb_patience_delay to reduce
 nohz_full OS jitter
Message-ID: <ZocfrlMurvbl-JbY@pavilion.home>
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-6-paulmck@kernel.org>
 <ZoV6bTj0xvGopEao@localhost.localdomain>
 <99721e1b-8752-4381-af2d-526f9b5c325c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99721e1b-8752-4381-af2d-526f9b5c325c@paulmck-laptop>

Le Wed, Jul 03, 2024 at 10:25:57AM -0700, Paul E. McKenney a écrit :
> On Wed, Jul 03, 2024 at 06:21:01PM +0200, Frederic Weisbecker wrote:
> > Le Tue, Jun 04, 2024 at 03:23:52PM -0700, Paul E. McKenney a écrit :
> > > If a CPU is running either a userspace application or a guest OS in
> > > nohz_full mode, it is possible for a system call to occur just as an
> > > RCU grace period is starting.  If that CPU also has the scheduling-clock
> > > tick enabled for any reason (such as a second runnable task), and if the
> > > system was booted with rcutree.use_softirq=0, then RCU can add insult to
> > > injury by awakening that CPU's rcuc kthread, resulting in yet another
> > > task and yet more OS jitter due to switching to that task, running it,
> > > and switching back.
> > > 
> > > In addition, in the common case where that system call is not of
> > > excessively long duration, awakening the rcuc task is pointless.
> > > This pointlessness is due to the fact that the CPU will enter an extended
> > > quiescent state upon returning to the userspace application or guest OS.
> > > In this case, the rcuc kthread cannot do anything that the main RCU
> > > grace-period kthread cannot do on its behalf, at least if it is given
> > > a few additional milliseconds (for example, given the time duration
> > > specified by rcutree.jiffies_till_first_fqs, give or take scheduling
> > > delays).
> > > 
> > > This commit therefore adds a rcutree.nocb_patience_delay kernel boot
> > > parameter that specifies the grace period age (in milliseconds)
> > > before which RCU will refrain from awakening the rcuc kthread.
> > > Preliminary experiementation suggests a value of 1000, that is,
> > > one second.  Increasing rcutree.nocb_patience_delay will increase
> > > grace-period latency and in turn increase memory footprint, so systems
> > > with constrained memory might choose a smaller value.  Systems with
> > > less-aggressive OS-jitter requirements might choose the default value
> > > of zero, which keeps the traditional immediate-wakeup behavior, thus
> > > avoiding increases in grace-period latency.
> > > 
> > > [ paulmck: Apply Leonardo Bras feedback.  ]
> > > 
> > > Link: https://lore.kernel.org/all/20240328171949.743211-1-leobras@redhat.com/
> > > 
> > > Reported-by: Leonardo Bras <leobras@redhat.com>
> > > Suggested-by: Leonardo Bras <leobras@redhat.com>
> > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> > > ---
> > >  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
> > >  kernel/rcu/tree.c                               | 10 ++++++++--
> > >  kernel/rcu/tree_plugin.h                        | 10 ++++++++++
> > >  3 files changed, 26 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 500cfa7762257..2d4a512cf1fc6 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -5018,6 +5018,14 @@
> > >  			the ->nocb_bypass queue.  The definition of "too
> > >  			many" is supplied by this kernel boot parameter.
> > >  
> > > +	rcutree.nocb_patience_delay= [KNL]
> > > +			On callback-offloaded (rcu_nocbs) CPUs, avoid
> > > +			disturbing RCU unless the grace period has
> > > +			reached the specified age in milliseconds.
> > > +			Defaults to zero.  Large values will be capped
> > > +			at five seconds.  All values will be rounded down
> > > +			to the nearest value representable by jiffies.
> > > +
> > >  	rcutree.qhimark= [KNL]
> > >  			Set threshold of queued RCU callbacks beyond which
> > >  			batch limiting is disabled.
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 35bf4a3736765..408b020c9501f 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -176,6 +176,9 @@ static int gp_init_delay;
> > >  module_param(gp_init_delay, int, 0444);
> > >  static int gp_cleanup_delay;
> > >  module_param(gp_cleanup_delay, int, 0444);
> > > +static int nocb_patience_delay;
> > > +module_param(nocb_patience_delay, int, 0444);
> > > +static int nocb_patience_delay_jiffies;
> > >  
> > >  // Add delay to rcu_read_unlock() for strict grace periods.
> > >  static int rcu_unlock_delay;
> > > @@ -4344,11 +4347,14 @@ static int rcu_pending(int user)
> > >  		return 1;
> > >  
> > >  	/* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
> > > -	if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
> > > +	gp_in_progress = rcu_gp_in_progress();
> > > +	if ((user || rcu_is_cpu_rrupt_from_idle() ||
> > > +	     (gp_in_progress &&
> > > +	      time_before(jiffies, READ_ONCE(rcu_state.gp_start) + nocb_patience_delay_jiffies))) &&
> > > +	    rcu_nohz_full_cpu())
> > 
> > The rcu_nohz_full_cpu() test should go before anything in order to benefit from
> > the static key in tick_nohz_full_cpu().
> 
> That has had the wrong order since forever.  ;-)
> 
> But good to fix.  I will queue a separate patch for Neeraj to consider
> for the v6.12 merge window.
> 
> > And since it only applies to nohz_full, should it be called
> > nohz_full_patience_delay ?
> > 
> > Or do we want to generalize it to all nocb uses
> > (which means only rely on rcu_is_cpu_rrupt_from_idle() if not nohz_full). Not
> > sure if that would make sense...
> 
> I don't believe that this makes sense except for nohz_full guest OSes.
> 
> I am good with nohz_full_patience_delay_jiffies.  (Or did you really
> want to drop "_jiffies", and if so, did you also want some other units?)
> 
> Last chance to object to the name.  ;-)

A bit long but I don't have a better proposal :-)

> 
> And next time we go through the patches a bit longer before the merge
> window!

My bad, I overlooked that one when it was posted.

Thanks.
