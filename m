Return-Path: <SRS0=FT7R=6V=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F3C28CBC
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 02:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3A72082E
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 02:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588819502;
	bh=c1DfSJoV1zqnWgtEai7LCjjyLAu7ymNcS3ojoas3BL0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=esJ3Y2rCGsj51t1HlCvYAHEAcIYC6PDpebzZyxIqrbS9mCsx9Aztekm1yZT0MpQJB
	 NHmAmYGMXSbJDqOl+ULpDy3menmsNjxwlQ1bEFnyqpGz6zTgpupdrUsr9Tk4m4oXOt
	 PqlhQXvlVK1kA8pfBr4/TDDJgv2mmXb4zHXHdqBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgEGCpB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 May 2020 22:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbgEGCpB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 May 2020 22:45:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFB820736;
        Thu,  7 May 2020 02:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588819500;
        bh=c1DfSJoV1zqnWgtEai7LCjjyLAu7ymNcS3ojoas3BL0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bYTvxmHhzmSfawjMSbJ3AJwdV7drwoTSbokpMzjdDaS8c8nE4HSflSte10O259yXC
         s2FfjMf/CA2iBIiSJjH7tGkJ6iTUVBHWEqYX80JiTkDUSh+e7+rNHlzh+zyEY5KhtX
         pA0TAll6gNBUo6MSN5PLLIGc4e0AlB33FOVnq3dE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 64A98352268D; Wed,  6 May 2020 19:45:00 -0700 (PDT)
Date:   Wed, 6 May 2020 19:45:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH RFC tip/core/rcu] Add shrinker to shift to
 fast/inefficient GP mode
Message-ID: <20200507024500.GH2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200507004240.GA9156@paulmck-ThinkPad-P72>
 <20200506175535.d4986a4d497071a410b69765@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506175535.d4986a4d497071a410b69765@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 06, 2020 at 05:55:35PM -0700, Andrew Morton wrote:
> On Wed, 6 May 2020 17:42:40 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > This commit adds a shrinker so as to inform RCU when memory is scarce.
> > RCU responds by shifting into the same fast and inefficient mode that is
> > used in the presence of excessive numbers of RCU callbacks.  RCU remains
> > in this state for one-tenth of a second, though this time window can be
> > extended by another call to the shrinker.
> > 
> > If it proves feasible, a later commit might add a function call directly
> > indicating the end of the period of scarce memory.
> 
> (Cc David Chinner, who often has opinions on shrinkers ;))
> 
> It's a bit abusive of the intent of the slab shrinkers, but I don't
> immediately see a problem with it.  Always returning 0 from
> ->scan_objects might cause a problem in some situations(?).

I could just divide the total number of callbacks by 16 or some such,
if that would work better.

> Perhaps we should have a formal "system getting low on memory, please
> do something" notification API.

That would be a very good thing to have!  But from what I can see, the
shrinker interface is currently the closest approximation to such an
interface.

> How significant is this?  How much memory can RCU consume?

This depends on the configuration and workload.  By default, RCU starts
getting concerned if any CPU exceeds 10,000 callbacks.  It is not all
-that- hard to cause RCU to have tens of millions of callbacks queued,
though some would argue that workloads doing this are rather abusive.
But at 1K per, this maps to 10GB of storage.

But in more normal workloads, I would expect the amount of storage
awaiting an RCU grace period to not even come close to a gigabyte.

Thoughts?

							Thanx, Paul

> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2368,8 +2368,15 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
> >  	struct rcu_data *rdp;
> >  	struct rcu_node *rnp;
> >  
> > -	rcu_state.cbovld = rcu_state.cbovldnext;
> > +	// Load .oomovld before .oomovldend, pairing with .oomovld set.
> > +	rcu_state.cbovld = smp_load_acquire(&rcu_state.oomovld) || // ^^^
> > +			   rcu_state.cbovldnext;
> >  	rcu_state.cbovldnext = false;
> > +	if (READ_ONCE(rcu_state.oomovld) &&
> > +	    time_after(jiffies, READ_ONCE(rcu_state.oomovldend))) {
> > +		WRITE_ONCE(rcu_state.oomovld, false);
> > +		pr_info("%s: Ending OOM-mode grace periods.\n", __func__);
> > +	}
> >  	rcu_for_each_leaf_node(rnp) {
> >  		cond_resched_tasks_rcu_qs();
> >  		mask = 0;
> > @@ -2697,6 +2704,35 @@ static void check_cb_ovld(struct rcu_data *rdp)
> >  	raw_spin_unlock_rcu_node(rnp);
> >  }
> >  
> > +/* Return a rough count of the RCU callbacks outstanding. */
> > +static unsigned long rcu_oom_count(struct shrinker *unused1,
> > +				   struct shrink_control *unused2)
> > +{
> > +	int cpu;
> > +	unsigned long ncbs = 0;
> > +
> > +	for_each_possible_cpu(cpu)
> > +		ncbs += rcu_get_n_cbs_cpu(cpu);
> > +	return ncbs;
> > +}
> > +
> > +/* Start up an interval of fast high-overhead grace periods. */
> > +static unsigned long rcu_oom_scan(struct shrinker *unused1,
> > +				  struct shrink_control *unused2)
> > +{
> > +	pr_info("%s: Starting OOM-mode grace periods.\n", __func__);
> > +	WRITE_ONCE(rcu_state.oomovldend, jiffies + HZ / 10);
> > +	smp_store_release(&rcu_state.oomovld, true); // After .oomovldend
> > +	rcu_force_quiescent_state();  // Kick grace period
> > +	return 0;  // We haven't actually reclaimed anything yet.
> > +}
> > +
> > +static struct shrinker rcu_shrinker = {
> > +	.count_objects = rcu_oom_count,
> > +	.scan_objects = rcu_oom_scan,
> > +	.seeks = DEFAULT_SEEKS,
> > +};
> > +
> >  /* Helper function for call_rcu() and friends.  */
> >  static void
> >  __call_rcu(struct rcu_head *head, rcu_callback_t func)
> > @@ -4146,6 +4182,7 @@ void __init rcu_init(void)
> >  		qovld_calc = DEFAULT_RCU_QOVLD_MULT * qhimark;
> >  	else
> >  		qovld_calc = qovld;
> > +	WARN_ON(register_shrinker(&rcu_shrinker));
> >  }
> >  
> >  #include "tree_stall.h"
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index 2d7fcb9..c4d8e96 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -326,6 +326,8 @@ struct rcu_state {
> >  	int ncpus_snap;				/* # CPUs seen last time. */
> >  	u8 cbovld;				/* Callback overload now? */
> >  	u8 cbovldnext;				/* ^        ^  next time? */
> > +	u8 oomovld;				/* OOM overload? */
> > +	unsigned long oomovldend;		/* OOM ovld end, jiffies. */
> >  
> >  	unsigned long jiffies_force_qs;		/* Time at which to invoke */
> >  						/*  force_quiescent_state(). */
