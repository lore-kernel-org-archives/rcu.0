Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C150BC4332B
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 17:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A20720754
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584639706;
	bh=kFYy6eHOfgxXyI8tRZ4ScvOVxBPCqcDs4Bzn7BH7JTw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=NeQvHpJAr5QH70G5XfaBsU219xqsBI/dlwIlSpRxJmCaoQ9GP9DNqJ9SiSgjw727C
	 g/Os7qdZkiHMZgV57x5s/UN4xh3goP00PATqLLtyZGrEuVY8Lxwb404vmmfVjlQ7aB
	 Mf3Yqae+rz0m5yeoJe0CrqV01fUcY9leLeJHjksI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCSRlq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbgCSRlp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Mar 2020 13:41:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64F902071C;
        Thu, 19 Mar 2020 17:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584639704;
        bh=kFYy6eHOfgxXyI8tRZ4ScvOVxBPCqcDs4Bzn7BH7JTw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NWgmY2/uT/gsgnGfNEWRmgppBPkoJpj21ZwuXmUDal+NRoibXBiJpRVK1E4yRlRwz
         p5AJddyUhi4nQKIVLXo94ykxKIDJeg8NPwimOOdzWE4WFoVNdJEKk0cmNyFXjWlPNN
         QgDGU876yWGdVqyMYXRBetUEifdWPKTrAzt81S64=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2F91935226B9; Thu, 19 Mar 2020 10:41:44 -0700 (PDT)
Date:   Thu, 19 Mar 2020 10:41:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH RFC v2 tip/core/rcu 02/22] rcu: Add per-task state to RCU
 CPU stall warnings
Message-ID: <20200319174144.GJ3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319001100.24917-2-paulmck@kernel.org>
 <20200319132731.49b0d020@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319132731.49b0d020@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 19, 2020 at 01:27:31PM -0400, Steven Rostedt wrote:
> On Wed, 18 Mar 2020 17:10:40 -0700
> paulmck@kernel.org wrote:
> 
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > Currently, an RCU-preempt CPU stall warning simply lists the PIDs of
> > those tasks holding up the current grace period.  This can be helpful,
> > but more can be even more helpful.
> > 
> > To this end, this commit adds the nesting level, whether the task
> > things it was preempted in its current RCU read-side critical section,
> 
> s/things/thinks/

I thing that was an excellent catch, thank you!  ;-)

> > whether RCU core has asked this task for a quiescent state, whether the
> > expedited-grace-period hint is set, and whether the task believes that
> > it is on the blocked-tasks list (it must be, or it would not be printed,
> > but if things are broken, best not to take too much for granted).
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree_stall.h | 38 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 36 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 502b4dd..e19487d 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -192,14 +192,40 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
> >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  }
> >  
> > +// Communicate task state back to the RCU CPU stall warning request.
> > +struct rcu_stall_chk_rdr {
> > +	int nesting;
> > +	union rcu_special rs;
> > +	bool on_blkd_list;
> > +};
> > +
> > +/*
> > + * Report out the state of a not-running task that is stalling the
> > + * current RCU grace period.
> > + */
> > +static bool check_slow_task(struct task_struct *t, void *arg)
> > +{
> > +	struct rcu_node *rnp;
> > +	struct rcu_stall_chk_rdr *rscrp = arg;
> > +
> > +	if (task_curr(t))
> > +		return false; // It is running, so decline to inspect it.
> 
> Since it can be locked on_rq(), should we report that too?

If it is locked on_rq() but !task_curr(t), it is runnable but not running.
Because the runqueue lock is held in that case, it cannot start running,
so the remainder of this function can safely inspect its state.  The
runqueue locks will supply the required ordering, ensuring a consistent
snapshot of the task's state.

However, if it is task_curr(t), which implies on_rq() as I understand
it, the task is running and therefore might be changing its state, and
doing so without any sort of attention to synchronization.  After all,
it is the task's private state that it is changing, so we don't want to
be paying the cost of any synchronization anyway.  Hence the return of
false above.

Or am I missing your point?

							Thanx, Paul

> -- Steve
> 
> > +	rscrp->nesting = t->rcu_read_lock_nesting;
> > +	rscrp->rs = t->rcu_read_unlock_special;
> > +	rnp = t->rcu_blocked_node;
> > +	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
> > +	return true;
> > +}
> > +
> >  /*
> >   * Scan the current list of tasks blocked within RCU read-side critical
> >   * sections, printing out the tid of each.
> >   */
> >  static int rcu_print_task_stall(struct rcu_node *rnp)
> >  {
> > -	struct task_struct *t;
> >  	int ndetected = 0;
> > +	struct rcu_stall_chk_rdr rscr;
> > +	struct task_struct *t;
> >  
> >  	if (!rcu_preempt_blocked_readers_cgp(rnp))
> >  		return 0;
> > @@ -208,7 +234,15 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
> >  	t = list_entry(rnp->gp_tasks->prev,
> >  		       struct task_struct, rcu_node_entry);
> >  	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
> > -		pr_cont(" P%d", t->pid);
> > +		if (!try_invoke_on_locked_down_task(t, check_slow_task, &rscr))
> > +			pr_cont(" P%d", t->pid);
> > +		else
> > +			pr_cont(" P%d/%d:%c%c%c%c",
> > +				t->pid, rscr.nesting,
> > +				".b"[rscr.rs.b.blocked],
> > +				".q"[rscr.rs.b.need_qs],
> > +				".e"[rscr.rs.b.exp_hint],
> > +				".l"[rscr.on_blkd_list]);
> >  		ndetected++;
> >  	}
> >  	pr_cont("\n");
> 
