Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9867ECAAD5
	for <rcu@archiver.kernel.org>; Wed,  7 Sep 2022 01:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiIGBki (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Sep 2022 21:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIGBkh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Sep 2022 21:40:37 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF937D1D6
        for <rcu@vger.kernel.org>; Tue,  6 Sep 2022 18:40:36 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v4so12163347pgi.10
        for <rcu@vger.kernel.org>; Tue, 06 Sep 2022 18:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cqZ0Q7M2m3knCrzi8VznwVbsuHzXVlxhpPMrDhuAts4=;
        b=AJ2duHbrnUqyT7xzy3hkPXHquWpxwHnr+n7fT83NbIqvUr0O/0CkQpw05RtkJlXQjV
         Ulp8gjIoHgdO0KuSudv37++sAK8Ni72axRcoLcra8qKAHHNOOtXImSreqG/cQpPoiRVc
         okdMYX41OCsANvEAQVujxn0ZhX3rBt3vBHlLQQOPIPKO2+xo+NY0bU3UJlOUT4PNhkIb
         xw6LG1d+Vv7+b3Upkd5TwGzOHaYe6pv59mBOkl3oK7hQrPSE4X6c2UvycRB/z1lvG3Tp
         hbL4NS8+hUEua7xRwQmHdGQMqyz3fE0D7rO0RZPMlNt7N4VaVzOewYJnfn5XqR3Pzrco
         1j4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cqZ0Q7M2m3knCrzi8VznwVbsuHzXVlxhpPMrDhuAts4=;
        b=JKqFVIDIsl0sfpJnaTW+hsJCqFfmhk9ktLszoTHEbQZ4Zsk35WXjqEzJLmdRPWdiDD
         sRZIUNU9JCfYi/Za3zEc+z6NwCtUZy4MRh24QdDUARdQL7jN2RVq/6CaKlslUcLWYM+e
         wUXgpbZ/v6mYDnwTihKtlOhDqoLwTSgrss52Uh2lAwIYYqhsgHh9dAliSHZ3u+jL4MyE
         4dlXheJWpTeuZQynRt0eMAN8cTJy2NTUh32eKlu879h3JBpeCGya6gKwLD7/qIgBS6KZ
         QeH/tywmCxSGLMD0ZMDFLymgb6/ElkQnAZJ4K2qqLuxjCVHuGSxscX6tl+IwieUDKvgX
         EN8Q==
X-Gm-Message-State: ACgBeo3HCIWyE0dHVmPHg16QiLwyV0OdGN5BSGPqF6ji7ok0zfGQPyXa
        PcRf4QTWup32osOnqP+kLQ==
X-Google-Smtp-Source: AA6agR6NwoaBx9y38h3rXL9YCc+R5nDv3gfhZ9D65vA6VOPiAYsMRBqR+XEQ2+oQ9OH1yiBLsso8kA==
X-Received: by 2002:a65:6b89:0:b0:41a:69b1:8674 with SMTP id d9-20020a656b89000000b0041a69b18674mr1260325pgw.417.1662514836273;
        Tue, 06 Sep 2022 18:40:36 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090341ce00b00176e8f85147sm129586ple.83.2022.09.06.18.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 18:40:35 -0700 (PDT)
Date:   Wed, 7 Sep 2022 09:40:29 +0800
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
Message-ID: <Yxf2jRB9LXr4q6ri@piliu.users.ipa.redhat.com>
References: <20220905033852.18988-1-kernelfans@gmail.com>
 <20220906172441.GY4315@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906172441.GY4315@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 06, 2022 at 10:24:41AM -0700, Paul E. McKenney wrote:
> On Mon, Sep 05, 2022 at 11:38:50AM +0800, Pingfan Liu wrote:
> > At present, during the cpu teardown, rcu_boost_kthread_setaffinity() is
> > called twice. Firstly by rcutree_offline_cpu(), then by
> > rcutree_dead_cpu() as the CPUHP_RCUTREE_PREP  cpuhp_step callback.
> > 
> > >From the scheduler's perspective, a bit in cpu_online_mask means that the cpu
> > is visible to the scheduler. Furthermore, a bit in cpu_active_mask
> > means that the cpu is suitable as a migration destination.
> > 
> > Now turning back to the case in rcu offlining. sched_cpu_deactivate()
> > has disabled the dying cpu as the migration destination before
> > rcutree_offline_cpu().  Furthermore, if the boost kthread is on the dying
> > cpu, it will be migrated to another suitable online cpu by the scheduler.
> > So the affinity setting by rcutree_offline_cpu() is redundant and can be
> > eliminated.
> > 
> > Besides, this patch does an trival code rearrangement by unfolding
> > rcutree_affinity_setting() into rcutree_online_cpu(), considering that
> > the latter one is the only user of the former.
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > To: rcu@vger.kernel.org
> > ---
> >  kernel/rcu/tree.c | 14 +-------------
> >  1 file changed, 1 insertion(+), 13 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 79aea7df4345..b90f6487fd45 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3978,16 +3978,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
> >  	return 0;
> >  }
> >  
> > -/*
> > - * Update RCU priority boot kthread affinity for CPU-hotplug changes.
> > - */
> > -static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
> > -{
> > -	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > -
> > -	rcu_boost_kthread_setaffinity(rdp->mynode, outgoing);
> > -}
> 
> Good point, tiven how simple a wrapper this is and how little it is used,
> getting rid of it does sound like a reasonable idea.
> 
> >  /*
> >   * Near the end of the CPU-online process.  Pretty much all services
> >   * enabled, and the CPU is now very much alive.
> > @@ -4006,7 +3996,7 @@ int rcutree_online_cpu(unsigned int cpu)
> >  	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> >  		return 0; /* Too early in boot for scheduler work. */
> >  	sync_sched_exp_online_cleanup(cpu);
> > -	rcutree_affinity_setting(cpu, -1);
> > +	rcu_boost_kthread_setaffinity(rdp->mynode, -1);
> >  
> >  	// Stop-machine done, so allow nohz_full to disable tick.
> >  	tick_dep_clear(TICK_DEP_BIT_RCU);
> > @@ -4029,8 +4019,6 @@ int rcutree_offline_cpu(unsigned int cpu)
> >  	rnp->ffmask &= ~rdp->grpmask;
> >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  
> > -	rcutree_affinity_setting(cpu, cpu);
> 
> We do need to keep this one because the CPU is going away.
> 
> One the other hand, it might well be that we could get rid of the call
> to rcutree_affinity_setting() in rcutree_dead_cpu().
> 
> Or am I missing something subtle here?
> 

Oops, I think I need to rephrase my commit log to describe this nuance.
The keypoint is whether ->qsmaskinitnext is stable.

The teardown code path on a single dying cpu looks like:

sched_cpu_deactivate() // prevent this dying cpu as a migration dst.

rcutree_offline_cpu()  // as a result, the scheduler core will take care
                       // of the transient affinity mismatching until
		       // rcutree_dead_cpu(). (I think it also stands in
		       // the concurrent offlining)

rcu_report_dead()      // running on the dying cpu, and clear its bit in ->qsmaskinitnext

rcutree_dead_cpu()     // running on the initiator (a initiator cpu will
                       // execute this function for each dying cpu)
		       // At this point, ->qsmaskinitnext reflects the
		       // offlining, and the affinity can get right.

Sorry that my commit log had emphasized on the first part, but forgot to
mention the ->qsmaskinitnext.


Does this justification stand?

Thanks,

	Pingfan
