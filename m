Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75A13212B;
	Mon, 10 Jun 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032255; cv=none; b=ioU6qdjt8+mVN4tUs/PskSH3CIANqmRXEJPAAjN4qCXqlcWnCb11X/gRXck56377uFLglQyBqM9b0kVTQQHEGr7Z51oF29Ovs+6MzBoogF5Ki5t1JH3IUtXQFgc5A2c+sABgCt9jX8BKFGXW4ONvJBR2hzIqxh0ER52snQC8ZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032255; c=relaxed/simple;
	bh=6AlFxH4NIHxQy7Ir3kIGMAcdMCTeUeBcXMZVbDgDHQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZrz2QIQSCioHKJIq3yKBcUCxpZ54N5xDgOM/O6gF9S/6xyFDb0OevlvD1ZUZep9gkPWPMkNlBRSdc1fqi8xSbXdW1mR5diRGONE4KDCpTX9mt6ri0gfC1haizhopvnBOu6QPt6jTUKjSeCBpDsxSOkh9GUx+maEYrWa2Q8HCnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyZT3uH6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyZT3uH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D064C2BBFC;
	Mon, 10 Jun 2024 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718032255;
	bh=6AlFxH4NIHxQy7Ir3kIGMAcdMCTeUeBcXMZVbDgDHQM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CyZT3uH68inUrPXz5GzpHEUS53QFtQ/YVgvPnJcBMKRNMXs+hiVUeG69JiYo+utc9
	 +w/NwxXiZUXO+J56yN8IMSU3RgjB8GuhxtDjccvt/iep4H0q8YU6L8eaYsrBryMs+b
	 TXfN4looZ5DRppmaPFj+gpRC0l35C/86Cs2qi31sa3Tjp2V+ctyRsMnsdxvHYXWe2D
	 l64DWtjjBAk9qW7X0735xhPrMxSIcY1PwqmtdrYaEpFb7IckG89drxPfEvSbLlKkPp
	 t+RE/fUFoX5EbmN1Nl3+iPZKca1ckc9mqvN5qytR1M1Mp8WATM2wehrQeODZCHdyWu
	 ZFgjF06ZgxDjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B00B6CE2373; Mon, 10 Jun 2024 08:10:54 -0700 (PDT)
Date: Mon, 10 Jun 2024 08:10:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Leonardo Bras <leobras@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH rcu 6/9] rcu: Add rcutree.nocb_patience_delay to reduce
 nohz_full OS jitter
Message-ID: <50efb4a3-578a-4df9-9bb2-550eb8c17d43@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-6-paulmck@kernel.org>
 <ZmaJmhgpzVVyZtnC@LeoBras>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmaJmhgpzVVyZtnC@LeoBras>

On Mon, Jun 10, 2024 at 02:05:30AM -0300, Leonardo Bras wrote:
> On Tue, Jun 04, 2024 at 03:23:52PM -0700, Paul E. McKenney wrote:
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
> > specified by rcutexperiementationree.jiffies_till_first_fqs, give or take 
> > scheduling
> > delays).
> > 
> > This commit therefore adds a rcutree.nocb_patience_delay kernel boot
> > parameter that specifies the grace period age (in milliseconds)
> > before which RCU will refrain from awakening the rcuc kthread.
> > Preliminary experiementation suggests a value of 1000, that is,
> 
> Just a nit I found when cherry-picking here
> s/experiementation/experimentation/

Good eyes!  I will fix this on my next rebase, thank you!

							Thanx, Paul

> Thanks!
> Leo
> 
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
> 
