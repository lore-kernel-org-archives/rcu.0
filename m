Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D568CC6FA90
	for <rcu@archiver.kernel.org>; Tue, 27 Sep 2022 09:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiI0Jmu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Sep 2022 05:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiI0Jmt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Sep 2022 05:42:49 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052DAB3B07
        for <rcu@vger.kernel.org>; Tue, 27 Sep 2022 02:42:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a29so9210364pfk.5
        for <rcu@vger.kernel.org>; Tue, 27 Sep 2022 02:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ycU5lq2RPeXyBwh0N+0vOAJ1PLet8SVu1AuppshVkSM=;
        b=M/WLwKOIaGbQ3gHskAG3ZQi9IG4PgCqMgUW5NHEowoI1AJcnW7UU2kvMRHnKfEdsfi
         UbG0xuMkCItFjuAIKmYnuKWbgdQcohzT4Z+arnao8Kzxs6pZkcAOyFetA+d4tMxu77mH
         ysNPXrSOmAvtEqmnVrWocVYT8ZBvSluJNJOe38vVc+yBZTKI/6/Zx6jDU4uXqW9929yJ
         veQRX6SSGqam6pG2rHy8oQlDCyGyqWTbXugQ08Wub3f0qIGw55ntEEjS86+t3N4DSnGr
         QXqptLXQ8FWJvXgACOyqzrc3E3nt19xQh8cVIGzOpBmTuAfZK/PEO2/CpbbVRbq8++fj
         agyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ycU5lq2RPeXyBwh0N+0vOAJ1PLet8SVu1AuppshVkSM=;
        b=ZDb+3mGn578QwuXvRWVMvlmlTiz4jFjZyfY8NiNPQ1+mT+z8HObNLp9VruU1hJ64Sa
         uRy+D7jbnG/dMK5ajrAGQjk/ghwHQ1K87qoSdV6Cd3tZ3zo0P+awrX0KF7dDtumK5Q5s
         pLOK/oBeaDoU8uo4xGodl2SJfQy/4fGJ+gfBN8qyCBKmCAEMmkJOhB8EQfJy6UxphZwy
         hLIPpRQf+xoTrKPw/jDGxc28Z7CalWX6jgNX6Psf/Uhuj2yEmuu0SuoMCPEGadSBbG1K
         ezMbQifFHteXH1VRY+1lM0k61pIB8/Tg7dvRRjUzIPBSN6Vzy1fi/yNxY+0UHBV4AIOm
         PzGA==
X-Gm-Message-State: ACrzQf1rpBSBKw66GJn4EYW6DxGmC9NXh3eL1VQsyIpucWMOMotmen4p
        HbOuYoPJHug3Vm8tCBK52gEbfqW2haWS
X-Google-Smtp-Source: AMsMyM6bMyCXXsz9BHbscwbYjDWL2ZjAG41rcyUgbf+MPj1FcFSmw2CM0rcaFMTIZTfWl5DHkZESOg==
X-Received: by 2002:a63:f057:0:b0:438:5c6c:de26 with SMTP id s23-20020a63f057000000b004385c6cde26mr23120988pgj.509.1664271766418;
        Tue, 27 Sep 2022 02:42:46 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902784d00b0015e8d4eb26esm1033253pln.184.2022.09.27.02.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:42:45 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:42:39 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Message-ID: <YzLFj8CMyHtXGqOI@piliu.users.ipa.redhat.com>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-4-kernelfans@gmail.com>
 <YzHPthRZAr4xPXkq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzHPthRZAr4xPXkq@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 26, 2022 at 04:13:42PM +0000, Joel Fernandes wrote:
> On Thu, Sep 15, 2022 at 01:58:25PM +0800, Pingfan Liu wrote:
> > As Paul pointed out  "The tick_dep_clear() is SMP-safe because it uses
> > atomic operations, but the problem is that if there are multiple
> > nohz_full CPUs going offline concurrently, the first CPU to invoke
> > rcutree_dead_cpu() will turn the tick off.  This might require an
> > atomically manipulated counter to mediate the calls to
> > rcutree_dead_cpu(). "
> > 
> > This patch introduces a new member ->dying to rcu_node, which reflects
> > the number of concurrent offlining cpu. TICK_DEP_BIT_RCU is set by
> > the first entrance and cleared by the last.
> > 
> > Note: now, tick_dep_set() is put under the rnp->lock, but since it takes
> > no lock, no extra locking order is introduced.
> > 
> > Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
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
> >  kernel/rcu/tree.c | 19 ++++++++++++++-----
> >  kernel/rcu/tree.h |  1 +
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 8a829b64f5b2..f8bd0fc5fd2f 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2164,13 +2164,19 @@ int rcutree_dead_cpu(unsigned int cpu)
> >  {
> >  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> >  	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> > +	unsigned long flags;
> > +	u8 dying;
> >  
> >  	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> >  		return 0;
> >  
> >  	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> > -	// Stop-machine done, so allow nohz_full to disable tick.
> > -	tick_dep_clear(TICK_DEP_BIT_RCU);
> > +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > +	dying = --rnp->dying;
> > +	if (!dying)
> > +		// Stop-machine done, so allow nohz_full to disable tick.
> > +		tick_dep_clear(TICK_DEP_BIT_RCU);
> > +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> >  	return 0;
> >  }
> >  
> > @@ -4020,17 +4026,20 @@ int rcutree_offline_cpu(unsigned int cpu)
> >  	unsigned long flags;
> >  	struct rcu_data *rdp;
> >  	struct rcu_node *rnp;
> > +	u8 dying;
> >  
> >  	rdp = per_cpu_ptr(&rcu_data, cpu);
> >  	rnp = rdp->mynode;
> >  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> >  	rnp->ffmask &= ~rdp->grpmask;
> 
> Just to ensure the first increment sets the tick dep and the last decrement
> resets it, it would be nice to add a check here:
> 
> WARN_ON_ONCE(!rnp->dying && tick_dep_test(TICK_DEP_BIT_RCU));
> 
> And correpondingly on the tick decrement:
> WARN_ON_ONCE(rnp->dying > 0 && !tick_dep_test(TICK_DEP_BIT_RCU));
> 
> Of course that will require adding a new API: tick_dep_test, but might be
> worth it.
> 
> (I think this should catch concurrency bugs such as involving the rnp lock
> that Frederic pointed out).
> 

Thank for your suggestion. But let us see the agressive method firstly,
i.e. removing the tick dep completely. At present, it seems promising.


Thanks,

	Pingfan
