Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DF7C04A95
	for <rcu@archiver.kernel.org>; Fri, 23 Sep 2022 22:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiIWWNy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 23 Sep 2022 18:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiIWWNx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 23 Sep 2022 18:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36983115BD5
        for <rcu@vger.kernel.org>; Fri, 23 Sep 2022 15:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C813F61F97
        for <rcu@vger.kernel.org>; Fri, 23 Sep 2022 22:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7788C433D6;
        Fri, 23 Sep 2022 22:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663971232;
        bh=TsLMeTmidaHA5PZoiV0Fa4o9aDg2/pJNDEUpoUxmr4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwK2jw+KqpQdm2L8P809zA5FjF0+0+I3hsZ//qQc1Ns24fhvS/MpIhyul7t/npo64
         6SayQYS0oauqNtOFyn5cpCFotu7JPyfIcig5w8MHRCEFbSv3SySMjs5jDV1ewlMMlv
         IwqhOJR7cHWDis2tGVbgNd2I/aAHHipix9OIprSBWa6ZodomMb1FTJzcJqi0JRAKU8
         nDpFNWQuF4+OO89krIIfet7CSNhE4DyJEpjNuA7FDDanNmVhQDO8ZwuqJlLKaYH5ZK
         jACMaRMfoca2vBxhYyk/zXE6/aGbwNb4oGU6tWPfoXOZUJmHJau0zSN/XxO7J6p3fn
         tl+3WFRvp3EZg==
Date:   Sat, 24 Sep 2022 00:13:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Message-ID: <20220923221349.GA161211@lothringen>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-4-kernelfans@gmail.com>
 <20220916134258.GB25891@lothringen>
 <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
 <20220920094645.GG69891@lothringen>
 <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
 <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com>
 <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 22, 2022 at 06:54:42AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 22, 2022 at 05:29:32PM +0800, Pingfan Liu wrote:
> > My understanding is after removing the tick dep by
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 79aea7df4345..cbfc884f04a4 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2171,8 +2171,6 @@ int rcutree_dead_cpu(unsigned int cpu)
> >         WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> >         /* Adjust any no-longer-needed kthreads. */
> >         rcu_boost_kthread_setaffinity(rnp, -1);
> > -       // Stop-machine done, so allow nohz_full to disable tick.
> > -       tick_dep_clear(TICK_DEP_BIT_RCU);
> >         return 0;
> >  }
> > 
> > @@ -4008,8 +4006,6 @@ int rcutree_online_cpu(unsigned int cpu)
> >         sync_sched_exp_online_cleanup(cpu);
> >         rcutree_affinity_setting(cpu, -1);
> > 
> > -       // Stop-machine done, so allow nohz_full to disable tick.
> > -       tick_dep_clear(TICK_DEP_BIT_RCU);
> >         return 0;
> >  }
> > 
> > @@ -4031,8 +4027,6 @@ int rcutree_offline_cpu(unsigned int cpu)
> > 
> >         rcutree_affinity_setting(cpu, cpu);
> > 
> > -       // nohz_full CPUs need the tick for stop-machine to work quickly
> > -       tick_dep_set(TICK_DEP_BIT_RCU);
> >         return 0;
> >  }
> > 
> > If the TREE04 can success, then move on to revert the commit(s)
> > identified by Frederic, and do test again.
> > 
> > At this time, a TREE04 failure is expected.
> > 
> > If the above two results are observed, TICK_DEP_BIT_RCU can be
> > removed.
> > 
> > Is my understanding right?
> 
> Seems plausible to me, but I again defer to Frederic.

Right, more precisely the commit to revert is:

     96926686deab ("rcu: Make CPU-hotplug removal operations enable tick")

which is the diff Pingfan Liu proposed above. The other uses of TICK_DEP_BIT_RCU
will still be needed though.

Thanks.
