Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AF5C32771
	for <rcu@archiver.kernel.org>; Mon, 26 Sep 2022 22:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIZWX6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiIZWX5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 26 Sep 2022 18:23:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567E482778
        for <rcu@vger.kernel.org>; Mon, 26 Sep 2022 15:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3FDCB812A5
        for <rcu@vger.kernel.org>; Mon, 26 Sep 2022 22:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A19C433D6;
        Mon, 26 Sep 2022 22:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664231032;
        bh=MlZ7oJTQxEPGEmKw13jIs8ma283usy/00N8W7J+OvlM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WhHWsJsNRxcbBK7kCK9zx5x1aXvr9JfSYTR1DbzmNa6QZDBVjHy1ikgfAVxyNd04u
         7OIder3UkCy4ZPRQMNs215dulX0L1pl7y2UKD2AAWPlsv5OrVFvYhg4gbFkLI799bR
         +aoBWouRdDC+tqllCzZiuiXgCmqSF2tM5i+lBFBVap2m237UXI9ANRmbs1opc5H92J
         /js4dGOkZ/+6GaXVxE+7u+V/VARBaavIqG8G9z/CakS1rzZRzKl6efcKfhqQFCNA/A
         JUVReImGrqWv5hFofwC//eQ2bDkN2FjwtY88W4zT0nRFfDWaM1cp6Pub1BRSrK6qKV
         uoGPqTSGSNHRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2D8925C05B1; Mon, 26 Sep 2022 15:23:52 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:23:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
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
Message-ID: <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-4-kernelfans@gmail.com>
 <20220916134258.GB25891@lothringen>
 <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
 <20220920094645.GG69891@lothringen>
 <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
 <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com>
 <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzFH6WSMX/Yht+i1@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzFH6WSMX/Yht+i1@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 26, 2022 at 02:34:17PM +0800, Pingfan Liu wrote:
> Sorry to reply late. I just realize this e-mail misses in my gmail.
> 
> On Thu, Sep 22, 2022 at 06:54:42AM -0700, Paul E. McKenney wrote:
> [...]
> > 
> > If you have tools/.../rcutorture/bin on your path, yes.  This would default
> > to a 30-minute run.  If you have at least 16 CPUs, you should add
>                                             ^^^ TREE04 has CONFIG_NR_CPUS=8, so I think here the num is 8

Yes, you will get some benefit from --allcpus on systems with from 9-15
CPUs as well as for 16 and more.  At 8 CPUs, it wouldn't matter.

> > "--allcpus" to do concurrrent runs.  For example, given 64 CPUs you could
> > do this:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs "4*TREE04"
> > 
> 
> I have tried to find a two socket system with 128 cpus and run
>   sh kvm.sh --allcpus --duration 250h --bootargs rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30 --configs 16*TREE04
> 
> Where 250*16=4000

That would work.

> > This would run four concurrent instances of the TREE04 scenario, each for
> > 10 hours, for a total of 40 hours of test time.
> > 
> > > > It does take some time to run.  I did 4,000 hours worth of TREE04
> > >                                         ^^^ '--duration=4000h' can serve this purpose?
> > 
> > You could, at least if you replace the "=" with a space character, but
> > that really would run a six-month test, which is probably not what you
> > want to do.  There being 8,760 hours in a year and all that.
> > 
> > > Is it related with the cpu's freq?
> > 
> > Not at all.  '--duration 10h' would run ten hours of wall-clock time
> > regardless of the CPU frequencies.
> > 
> > > > to confirm lack of bug.  But an 80-CPU dual-socket system can run
> > > > 10 concurrent instances of TREE04, which gets things down to a more
> > > 
> > > The total demanded hours H = 4000/(system_cpu_num/8)?
> > 
> > Yes.  You can also use multiple systems, which is what kvm-remote.sh is
> > intended for, again assuming 80 CPUs per system to keep the arithmetic
> > simple:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm-remote.sh "sys1 sys2 ... sys20" --duration 20h --cpus 80 --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs "200*TREE04"
> > 
> 
> That is appealing.
> 
> I will see if any opportunity to grasp a batch of machines to run the
> test.

Initial tests with smaller numbers of CPUs are also useful, for example,
in case reversion causes some bug due to bad interaction with a later
commit.

Please let me know how it goes!

							Thanx, Paul

> Thanks,
> 
> 	Pingfan
> > Here "sys1" is the name of the system, on which you must have an account
> > so that "ssh sys1 date" runs the date command on the first remote system.
> > You really do have to use the "--cpus 80" because kvm-remote.sh does not
> > assume that the system that it is running on is one of the test systems.
> > 
> > > > manageable 400 hours.  Please let me know if you don't have access
> > > > to a few such systems.
> > > 
> > > I am happy to have a try if needed. I will try to get a powerful
> > > machine, which can shrink the test time.
> > 
> > Larger numbers of little systems work, also, but in my experience you need
> > a dual-socket system to have a reasonable chance of reproducing this bug.
> > Each socket can be small, though, if that helps.
> > 
> > If you work for a cloud provider or some such, you can probably get a
> > large number of systems.  If you can only get a few, you can do initial
> > testing, and then we can work out what to do about heavier-duty testing.
> > 
> > > > I will let Frederic identify which commit(s) should be reverted in
> > > > order to test the test.
> > > > 
> > > 
> > > My understanding is after removing the tick dep by
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 79aea7df4345..cbfc884f04a4 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2171,8 +2171,6 @@ int rcutree_dead_cpu(unsigned int cpu)
> > >         WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> > >         /* Adjust any no-longer-needed kthreads. */
> > >         rcu_boost_kthread_setaffinity(rnp, -1);
> > > -       // Stop-machine done, so allow nohz_full to disable tick.
> > > -       tick_dep_clear(TICK_DEP_BIT_RCU);
> > >         return 0;
> > >  }
> > > 
> > > @@ -4008,8 +4006,6 @@ int rcutree_online_cpu(unsigned int cpu)
> > >         sync_sched_exp_online_cleanup(cpu);
> > >         rcutree_affinity_setting(cpu, -1);
> > > 
> > > -       // Stop-machine done, so allow nohz_full to disable tick.
> > > -       tick_dep_clear(TICK_DEP_BIT_RCU);
> > >         return 0;
> > >  }
> > > 
> > > @@ -4031,8 +4027,6 @@ int rcutree_offline_cpu(unsigned int cpu)
> > > 
> > >         rcutree_affinity_setting(cpu, cpu);
> > > 
> > > -       // nohz_full CPUs need the tick for stop-machine to work quickly
> > > -       tick_dep_set(TICK_DEP_BIT_RCU);
> > >         return 0;
> > >  }
> > > 
> > > If the TREE04 can success, then move on to revert the commit(s)
> > > identified by Frederic, and do test again.
> > > 
> > > At this time, a TREE04 failure is expected.
> > > 
> > > If the above two results are observed, TICK_DEP_BIT_RCU can be
> > > removed.
> > > 
> > > Is my understanding right?
> > 
> > Seems plausible to me, but I again defer to Frederic.
> > 
> > 							Thanx, Paul
