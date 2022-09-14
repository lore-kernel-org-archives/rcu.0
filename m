Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FEAECAAD3
	for <rcu@archiver.kernel.org>; Wed, 14 Sep 2022 10:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiINKMl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Sep 2022 06:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiINKMi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Sep 2022 06:12:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051406580E
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 03:12:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x1so14648810plv.5
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=I+BQcwwB9FksAWtE8UIHySzaN5PH6WM6Ov9wPqv4dAg=;
        b=f4EQi2vwf4azG0YVYHs57m+fs7+S6K1s0XdeEskbxHCuwcbPXssqMSkCsK6TnNFfN/
         TQBE2FAKbgo67UKxjqoNusMl79Erd6/DzR61mJGENaiLhSmbhXSlAlWViQ9fSAbLC71o
         LS5XRma0iQ6ozLTEb4M/Vg914m13S/TYDlGuqEY3aXnp/6IZ4UXh03gUKS76aym4AOKT
         BgSmKf9yKoYKPcnBb65HdFkAftvjKO3UlnPchNxIwS6UazrA2vDQKNFwCe5NZTEe2kVx
         laui1uzNYUIHi1m7a3LcB43nPdlUCsU0boNfbqxjBfzA/Z/QChf4QGx9PhRH5f05kRxz
         19Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=I+BQcwwB9FksAWtE8UIHySzaN5PH6WM6Ov9wPqv4dAg=;
        b=5PlzL0/MQcGIn1Chg5M7JjOKcUFHArMFVY4eXpGwMDPZzL7sUb2jnWa2Gr7p5GGi2N
         FQWKuSUojCb+HK1b93Q58a3xKNCmlSMFxco1csae8dSAgECwckhEV4uKrJhZ+0Ces9Jp
         FPsJDFCL5ki2RvJn+F0CP00AJ9pRDb3gBtv5mXdeGK/Jn/dIDiP9cKDqRZQwdnzoJ9Ph
         ZAEpF2KUaynMdGcN0hEQqfov4R/jPHEoSW0vpwXi99hQDUc3NBG3A3/pjtA5cwWN5DvW
         eKjyn88dH1Go1Uu80ojbBfaKKA2O92H1nnML7iD1RxSP6HotrEVS2Ru0v0NlPujAR8x6
         LKZA==
X-Gm-Message-State: ACrzQf0RscVtrN881T522bfHuOtw9l6aMqCz3FdmVfynbmqt8WQADYAx
        YkWaCg83jtnJCpE8fQ1sgDukavfDCQ==
X-Google-Smtp-Source: AMsMyM4cfSOqec0B+aAvVX21ZCr5Ccc+jUXVkUGm5JIaUYep4WKOijKvfVdR1ouKgXlPSIHXP8wTgQ==
X-Received: by 2002:a17:90a:8c8e:b0:202:883b:2644 with SMTP id b14-20020a17090a8c8e00b00202883b2644mr3944629pjo.89.1663150355453;
        Wed, 14 Sep 2022 03:12:35 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v2-20020aa799c2000000b0052e6c058bccsm9714550pfi.61.2022.09.14.03.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:12:34 -0700 (PDT)
Date:   Wed, 14 Sep 2022 18:12:27 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <YyGpC03H0c9EXTv9@piliu.users.ipa.redhat.com>
References: <20220905033852.18988-1-kernelfans@gmail.com>
 <20220906172441.GY4315@paulmck-ThinkPad-P17-Gen-1>
 <Yxf2jRB9LXr4q6ri@piliu.users.ipa.redhat.com>
 <20220910203622.GI4315@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910203622.GI4315@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Sep 10, 2022 at 01:36:22PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 07, 2022 at 09:40:29AM +0800, Pingfan Liu wrote:
> > On Tue, Sep 06, 2022 at 10:24:41AM -0700, Paul E. McKenney wrote:
> > > On Mon, Sep 05, 2022 at 11:38:50AM +0800, Pingfan Liu wrote:
> > > > At present, during the cpu teardown, rcu_boost_kthread_setaffinity() is
> > > > called twice. Firstly by rcutree_offline_cpu(), then by
> > > > rcutree_dead_cpu() as the CPUHP_RCUTREE_PREP  cpuhp_step callback.
> > > > 
> > > > >From the scheduler's perspective, a bit in cpu_online_mask means that the cpu
> > > > is visible to the scheduler. Furthermore, a bit in cpu_active_mask
> > > > means that the cpu is suitable as a migration destination.
> > > > 
> > > > Now turning back to the case in rcu offlining. sched_cpu_deactivate()
> > > > has disabled the dying cpu as the migration destination before
> > > > rcutree_offline_cpu().  Furthermore, if the boost kthread is on the dying
> > > > cpu, it will be migrated to another suitable online cpu by the scheduler.
> > > > So the affinity setting by rcutree_offline_cpu() is redundant and can be
> > > > eliminated.
> > > > 
> > > > Besides, this patch does an trival code rearrangement by unfolding
> > > > rcutree_affinity_setting() into rcutree_online_cpu(), considering that
> > > > the latter one is the only user of the former.
> > > > 
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > > > To: rcu@vger.kernel.org
> > > > ---
> > > >  kernel/rcu/tree.c | 14 +-------------
> > > >  1 file changed, 1 insertion(+), 13 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 79aea7df4345..b90f6487fd45 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3978,16 +3978,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -/*
> > > > - * Update RCU priority boot kthread affinity for CPU-hotplug changes.
> > > > - */
> > > > -static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
> > > > -{
> > > > -	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > > > -
> > > > -	rcu_boost_kthread_setaffinity(rdp->mynode, outgoing);
> > > > -}
> > > 
> > > Good point, tiven how simple a wrapper this is and how little it is used,
> > > getting rid of it does sound like a reasonable idea.
> > > 
> > > >  /*
> > > >   * Near the end of the CPU-online process.  Pretty much all services
> > > >   * enabled, and the CPU is now very much alive.
> > > > @@ -4006,7 +3996,7 @@ int rcutree_online_cpu(unsigned int cpu)
> > > >  	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> > > >  		return 0; /* Too early in boot for scheduler work. */
> > > >  	sync_sched_exp_online_cleanup(cpu);
> > > > -	rcutree_affinity_setting(cpu, -1);
> > > > +	rcu_boost_kthread_setaffinity(rdp->mynode, -1);
> > > >  
> > > >  	// Stop-machine done, so allow nohz_full to disable tick.
> > > >  	tick_dep_clear(TICK_DEP_BIT_RCU);
> > > > @@ -4029,8 +4019,6 @@ int rcutree_offline_cpu(unsigned int cpu)
> > > >  	rnp->ffmask &= ~rdp->grpmask;
> > > >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > >  
> > > > -	rcutree_affinity_setting(cpu, cpu);
> > > 
> > > We do need to keep this one because the CPU is going away.
> > > 
> > > One the other hand, it might well be that we could get rid of the call
> > > to rcutree_affinity_setting() in rcutree_dead_cpu().
> > > 
> > > Or am I missing something subtle here?
> > 
> > Oops, I think I need to rephrase my commit log to describe this nuance.
> > The keypoint is whether ->qsmaskinitnext is stable.
> > 
> > The teardown code path on a single dying cpu looks like:
> > 
> > sched_cpu_deactivate() // prevent this dying cpu as a migration dst.
> 
> Suppose that this was the last CPU that the task was permitted to
> run on.
> 

Get your concern, please see the comment below.

> > rcutree_offline_cpu()  // as a result, the scheduler core will take care
> >                        // of the transient affinity mismatching until
> > 		       // rcutree_dead_cpu(). (I think it also stands in
> > 		       // the concurrent offlining)
> > 
> > rcu_report_dead()      // running on the dying cpu, and clear its bit in ->qsmaskinitnext
> > 
> > rcutree_dead_cpu()     // running on the initiator (a initiator cpu will
> >                        // execute this function for each dying cpu)
> > 		       // At this point, ->qsmaskinitnext reflects the
> > 		       // offlining, and the affinity can get right.
> > 
> > Sorry that my commit log had emphasized on the first part, but forgot to
> > mention the ->qsmaskinitnext.
> > 
> > 
> > Does this justification stand?
> 
> We should ensure that the task's permitted set of CPUs always contained
> at least one online CPU.  Unless I am missing something, your suggested
> change will sometimes end up with the task having no online CPUs in
> its mask.
> 

Actually, the scheduler will pick up one online cpu for the boost
thread.

On the last cpu, boost is subject to migration, and is pushed away by
__balance_push_cpu_stop()
{
        if (task_rq(p) == rq && task_on_rq_queued(p)) {
                cpu = select_fallback_rq(rq->cpu, p);
                rq = __migrate_task(rq, &rf, p, cpu);
        }
}

Now, turning to select_fallback_rq(), inside that function, if
p->cpus_ptr has no suitable cpus, then case cpuset or possible will make it
point to cpuset or cpu_possible_mask.  So finally, there is a valid cpu
is picked up. (I have not found the online cpu there. The trick should hide
elsewhere. But that rendered the same result as in v5.16, where
rcu_boost_kthread_setaffinity()->cpumask_setall(cm))

But now, in 6.0, it changes into housekeeping_cpumask(HK_TYPE_RCU),
which appeals for a more careful thinking.
If there is a cpuset for housekeeping so that select_fallback_rq() can
pick up one from that cpuset?

To Frederic, could you show some light here and is it worth introducing
such a cpuset so that select_fallback_rq() can pick up a cpu in
housekeeping set in this case?


Anyway, as the last resort, TICK_DEP_BIT_RCU has already appealed for
the awareness of the concurrent rcutree_offline_cpu(), the affinity
setting could be done there if select_fallback_rq() can not work.


Thanks,

	Pingfan
