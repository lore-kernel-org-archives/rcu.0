Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64250ECAAD3
	for <rcu@archiver.kernel.org>; Sat, 10 Sep 2022 20:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiIJUga (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 10 Sep 2022 16:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiIJUg3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 10 Sep 2022 16:36:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908653BC60
        for <rcu@vger.kernel.org>; Sat, 10 Sep 2022 13:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39204B807ED
        for <rcu@vger.kernel.org>; Sat, 10 Sep 2022 20:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C554FC433D6;
        Sat, 10 Sep 2022 20:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662842185;
        bh=KD0aPAmnApIXXT/YhEyGmvfyhmjJ0jtYktdBpvOnnu4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pz6jFJ/eFORa+7gcjTLfhpeF+PUiqY5DURvdjQFjxJyQfHHnqovJhMd3VjPLeHqqu
         GM4PY8b91A5ro5H3TNLfvAn8uASiESOhSnuzPS7AFrcl0AoxwU3WnrF95OH641sMAi
         xYLVKYAVWuZBoBXXHksV1BF5U7v1eSm9d7jrvwtJ/G8+In97rnNfOs8gIPqtZSLJB/
         MvjhGzqa7K5P1h3y5XQ18/fq1IVf/mpCxYmk4dk2LLyAKfA88TzDaAmx0weXl+m+2c
         oTlVxpZEBrjw2srudixmNuZx8Mm/Ljjwjqsvcik+5thKMPrFoftlguU9WT73vGg35z
         Bug+0k9ObSzQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4653C5C086C; Sat, 10 Sep 2022 13:36:22 -0700 (PDT)
Date:   Sat, 10 Sep 2022 13:36:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 1/3] rcu: remove redundant cpu affinity setting during
 teardown
Message-ID: <20220910203622.GI4315@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220905033852.18988-1-kernelfans@gmail.com>
 <20220906172441.GY4315@paulmck-ThinkPad-P17-Gen-1>
 <Yxf2jRB9LXr4q6ri@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxf2jRB9LXr4q6ri@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 07, 2022 at 09:40:29AM +0800, Pingfan Liu wrote:
> On Tue, Sep 06, 2022 at 10:24:41AM -0700, Paul E. McKenney wrote:
> > On Mon, Sep 05, 2022 at 11:38:50AM +0800, Pingfan Liu wrote:
> > > At present, during the cpu teardown, rcu_boost_kthread_setaffinity() is
> > > called twice. Firstly by rcutree_offline_cpu(), then by
> > > rcutree_dead_cpu() as the CPUHP_RCUTREE_PREP  cpuhp_step callback.
> > > 
> > > >From the scheduler's perspective, a bit in cpu_online_mask means that the cpu
> > > is visible to the scheduler. Furthermore, a bit in cpu_active_mask
> > > means that the cpu is suitable as a migration destination.
> > > 
> > > Now turning back to the case in rcu offlining. sched_cpu_deactivate()
> > > has disabled the dying cpu as the migration destination before
> > > rcutree_offline_cpu().  Furthermore, if the boost kthread is on the dying
> > > cpu, it will be migrated to another suitable online cpu by the scheduler.
> > > So the affinity setting by rcutree_offline_cpu() is redundant and can be
> > > eliminated.
> > > 
> > > Besides, this patch does an trival code rearrangement by unfolding
> > > rcutree_affinity_setting() into rcutree_online_cpu(), considering that
> > > the latter one is the only user of the former.
> > > 
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > > To: rcu@vger.kernel.org
> > > ---
> > >  kernel/rcu/tree.c | 14 +-------------
> > >  1 file changed, 1 insertion(+), 13 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 79aea7df4345..b90f6487fd45 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3978,16 +3978,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
> > >  	return 0;
> > >  }
> > >  
> > > -/*
> > > - * Update RCU priority boot kthread affinity for CPU-hotplug changes.
> > > - */
> > > -static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
> > > -{
> > > -	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > > -
> > > -	rcu_boost_kthread_setaffinity(rdp->mynode, outgoing);
> > > -}
> > 
> > Good point, tiven how simple a wrapper this is and how little it is used,
> > getting rid of it does sound like a reasonable idea.
> > 
> > >  /*
> > >   * Near the end of the CPU-online process.  Pretty much all services
> > >   * enabled, and the CPU is now very much alive.
> > > @@ -4006,7 +3996,7 @@ int rcutree_online_cpu(unsigned int cpu)
> > >  	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> > >  		return 0; /* Too early in boot for scheduler work. */
> > >  	sync_sched_exp_online_cleanup(cpu);
> > > -	rcutree_affinity_setting(cpu, -1);
> > > +	rcu_boost_kthread_setaffinity(rdp->mynode, -1);
> > >  
> > >  	// Stop-machine done, so allow nohz_full to disable tick.
> > >  	tick_dep_clear(TICK_DEP_BIT_RCU);
> > > @@ -4029,8 +4019,6 @@ int rcutree_offline_cpu(unsigned int cpu)
> > >  	rnp->ffmask &= ~rdp->grpmask;
> > >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >  
> > > -	rcutree_affinity_setting(cpu, cpu);
> > 
> > We do need to keep this one because the CPU is going away.
> > 
> > One the other hand, it might well be that we could get rid of the call
> > to rcutree_affinity_setting() in rcutree_dead_cpu().
> > 
> > Or am I missing something subtle here?
> 
> Oops, I think I need to rephrase my commit log to describe this nuance.
> The keypoint is whether ->qsmaskinitnext is stable.
> 
> The teardown code path on a single dying cpu looks like:
> 
> sched_cpu_deactivate() // prevent this dying cpu as a migration dst.

Suppose that this was the last CPU that the task was permitted to
run on.

> rcutree_offline_cpu()  // as a result, the scheduler core will take care
>                        // of the transient affinity mismatching until
> 		       // rcutree_dead_cpu(). (I think it also stands in
> 		       // the concurrent offlining)
> 
> rcu_report_dead()      // running on the dying cpu, and clear its bit in ->qsmaskinitnext
> 
> rcutree_dead_cpu()     // running on the initiator (a initiator cpu will
>                        // execute this function for each dying cpu)
> 		       // At this point, ->qsmaskinitnext reflects the
> 		       // offlining, and the affinity can get right.
> 
> Sorry that my commit log had emphasized on the first part, but forgot to
> mention the ->qsmaskinitnext.
> 
> 
> Does this justification stand?

We should ensure that the task's permitted set of CPUs always contained
at least one online CPU.  Unless I am missing something, your suggested
change will sometimes end up with the task having no online CPUs in
its mask.

So what am I missing here?

							Thanx, Paul
