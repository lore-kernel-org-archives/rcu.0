Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8117A920;
	Wed,  3 Jul 2024 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027558; cv=none; b=CGcbRrmKN3t4pIjUzykH0eT4IaFsZuGZLfcdleND2XEcE3qCrUOtQn3Fru6bqbj9Xd+LqzY4dhQtj7xYDdK+YE4YY0JvFaA6jSFjH48Eq6PE2NxVkJdSxigMl/Q20FKpVbpldH5m7qDE3UWXNIEOBjbi/mqGjnT6+RajIHw+PIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027558; c=relaxed/simple;
	bh=GKWsfZ3JkGnImqG9xr2UDgiql3Y2XhC7wKS7w5wfqZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJXODXVmM+rBH+Fp2UGEGkAk4GC69goDicR8hi7zs9fm9CQlo1JQev04BFSR3CW3tuJib4c3m65TtbrXsziRfi/YRAWIHhE+0MdM62Ry6K88uQcY5PsC1g5K1IiwN1CNHDWUqC3W1QZ8zItT6AEukoIdOnCNcTEgwkXh3IAjm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk6r5fyN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk6r5fyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A11C2BD10;
	Wed,  3 Jul 2024 17:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720027557;
	bh=GKWsfZ3JkGnImqG9xr2UDgiql3Y2XhC7wKS7w5wfqZc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Zk6r5fyN7M21W9Cxin/FS9JIdfXdNW+alHi2PIwOyfu8d33AnrhBo3tJi/1496G6F
	 bG2SJrpIAMUXRVKpatNmQVq2LivJNNYYZLr9uEa8Ulzhm1QV+6xGZBGD/REHNWUyjE
	 QzMwkIyx40HgQnfFfnlj99pGqQHHj+mBf+ymYZ/qJ3ZCIgFaNcPf+yVVkVk5zw19x+
	 FK2teckVt2wXq/mz5nIG8e++lozUmSva+sBrGjzP/OW3H+oFLEUGtUxuEIHpTr+O+n
	 hxN0fmJPEjSlxV9AnuIXP6dbsoDrZSEuo6AC8ojgP/ZgysQy7HkgDTXZ12AJuHExa0
	 SBY0LmOnes1aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 39BFECE0BC3; Wed,  3 Jul 2024 10:25:57 -0700 (PDT)
Date: Wed, 3 Jul 2024 10:25:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Leonardo Bras <leobras@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH rcu 6/9] rcu: Add rcutree.nocb_patience_delay to reduce
 nohz_full OS jitter
Message-ID: <99721e1b-8752-4381-af2d-526f9b5c325c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-6-paulmck@kernel.org>
 <ZoV6bTj0xvGopEao@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoV6bTj0xvGopEao@localhost.localdomain>

On Wed, Jul 03, 2024 at 06:21:01PM +0200, Frederic Weisbecker wrote:
> Le Tue, Jun 04, 2024 at 03:23:52PM -0700, Paul E. McKenney a écrit :
> > If a CPU is running either a userspace application or a guest OS in
> > nohz_full mode, it is possible for a system call to occur just as an
> > RCU grace period is starting.  If that CPU also has the scheduling-clock
> > tick enabled for any reason (such as a second runnable task), and if the
> > system was booted with rcutree.use_softirq=0, then RCU can add insult to
> > injury by awakening that CPU's rcuc kthread, resulting in yet another
> > task and yet more OS jitter due to switching to that task, running it,
> > and switching back.
> > 
> > In addition, in the common case where that system call is not of
> > excessively long duration, awakening the rcuc task is pointless.
> > This pointlessness is due to the fact that the CPU will enter an extended
> > quiescent state upon returning to the userspace application or guest OS.
> > In this case, the rcuc kthread cannot do anything that the main RCU
> > grace-period kthread cannot do on its behalf, at least if it is given
> > a few additional milliseconds (for example, given the time duration
> > specified by rcutree.jiffies_till_first_fqs, give or take scheduling
> > delays).
> > 
> > This commit therefore adds a rcutree.nocb_patience_delay kernel boot
> > parameter that specifies the grace period age (in milliseconds)
> > before which RCU will refrain from awakening the rcuc kthread.
> > Preliminary experiementation suggests a value of 1000, that is,
> > one second.  Increasing rcutree.nocb_patience_delay will increase
> > grace-period latency and in turn increase memory footprint, so systems
> > with constrained memory might choose a smaller value.  Systems with
> > less-aggressive OS-jitter requirements might choose the default value
> > of zero, which keeps the traditional immediate-wakeup behavior, thus
> > avoiding increases in grace-period latency.
> > 
> > [ paulmck: Apply Leonardo Bras feedback.  ]
> > 
> > Link: https://lore.kernel.org/all/20240328171949.743211-1-leobras@redhat.com/
> > 
> > Reported-by: Leonardo Bras <leobras@redhat.com>
> > Suggested-by: Leonardo Bras <leobras@redhat.com>
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
> >  kernel/rcu/tree.c                               | 10 ++++++++--
> >  kernel/rcu/tree_plugin.h                        | 10 ++++++++++
> >  3 files changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 500cfa7762257..2d4a512cf1fc6 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5018,6 +5018,14 @@
> >  			the ->nocb_bypass queue.  The definition of "too
> >  			many" is supplied by this kernel boot parameter.
> >  
> > +	rcutree.nocb_patience_delay= [KNL]
> > +			On callback-offloaded (rcu_nocbs) CPUs, avoid
> > +			disturbing RCU unless the grace period has
> > +			reached the specified age in milliseconds.
> > +			Defaults to zero.  Large values will be capped
> > +			at five seconds.  All values will be rounded down
> > +			to the nearest value representable by jiffies.
> > +
> >  	rcutree.qhimark= [KNL]
> >  			Set threshold of queued RCU callbacks beyond which
> >  			batch limiting is disabled.
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 35bf4a3736765..408b020c9501f 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -176,6 +176,9 @@ static int gp_init_delay;
> >  module_param(gp_init_delay, int, 0444);
> >  static int gp_cleanup_delay;
> >  module_param(gp_cleanup_delay, int, 0444);
> > +static int nocb_patience_delay;
> > +module_param(nocb_patience_delay, int, 0444);
> > +static int nocb_patience_delay_jiffies;
> >  
> >  // Add delay to rcu_read_unlock() for strict grace periods.
> >  static int rcu_unlock_delay;
> > @@ -4344,11 +4347,14 @@ static int rcu_pending(int user)
> >  		return 1;
> >  
> >  	/* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
> > -	if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
> > +	gp_in_progress = rcu_gp_in_progress();
> > +	if ((user || rcu_is_cpu_rrupt_from_idle() ||
> > +	     (gp_in_progress &&
> > +	      time_before(jiffies, READ_ONCE(rcu_state.gp_start) + nocb_patience_delay_jiffies))) &&
> > +	    rcu_nohz_full_cpu())
> 
> The rcu_nohz_full_cpu() test should go before anything in order to benefit from
> the static key in tick_nohz_full_cpu().

That has had the wrong order since forever.  ;-)

But good to fix.  I will queue a separate patch for Neeraj to consider
for the v6.12 merge window.

> And since it only applies to nohz_full, should it be called
> nohz_full_patience_delay ?
> 
> Or do we want to generalize it to all nocb uses
> (which means only rely on rcu_is_cpu_rrupt_from_idle() if not nohz_full). Not
> sure if that would make sense...

I don't believe that this makes sense except for nohz_full guest OSes.

I am good with nohz_full_patience_delay_jiffies.  (Or did you really
want to drop "_jiffies", and if so, did you also want some other units?)

Last chance to object to the name.  ;-)

And next time we go through the patches a bit longer before the merge
window!

							Thanx, Paul

> Thanks.
> 
> >  		return 0;
> >  
> >  	/* Is the RCU core waiting for a quiescent state from this CPU? */
> > -	gp_in_progress = rcu_gp_in_progress();
> >  	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm && gp_in_progress)
> >  		return 1;
> >  
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 340bbefe5f652..31c539f09c150 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -93,6 +93,16 @@ static void __init rcu_bootup_announce_oddness(void)
> >  		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_init_delay);
> >  	if (gp_cleanup_delay)
> >  		pr_info("\tRCU debug GP cleanup slowdown %d jiffies.\n", gp_cleanup_delay);
> > +	if (nocb_patience_delay < 0) {
> > +		pr_info("\tRCU NOCB CPU patience negative (%d), resetting to zero.\n", nocb_patience_delay);
> > +		nocb_patience_delay = 0;
> > +	} else if (nocb_patience_delay > 5 * MSEC_PER_SEC) {
> > +		pr_info("\tRCU NOCB CPU patience too large (%d), resetting to %ld.\n", nocb_patience_delay, 5 * MSEC_PER_SEC);
> > +		nocb_patience_delay = 5 * MSEC_PER_SEC;
> > +	} else if (nocb_patience_delay) {
> > +		pr_info("\tRCU NOCB CPU patience set to %d milliseconds.\n", nocb_patience_delay);
> > +	}
> > +	nocb_patience_delay_jiffies = msecs_to_jiffies(nocb_patience_delay);
> >  	if (!use_softirq)
> >  		pr_info("\tRCU_SOFTIRQ processing moved to rcuc kthreads.\n");
> >  	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
> > -- 
> > 2.40.1
> > 
> > 
