Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BE5C54EE9
	for <rcu@archiver.kernel.org>; Thu, 22 Sep 2022 13:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiIVNyy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiIVNyx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Sep 2022 09:54:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E47522B3E
        for <rcu@vger.kernel.org>; Thu, 22 Sep 2022 06:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 622F1634A9
        for <rcu@vger.kernel.org>; Thu, 22 Sep 2022 13:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B359AC433C1;
        Thu, 22 Sep 2022 13:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663854882;
        bh=O/UDeFDWf0tMyVJUvRf9by/0947W5Labn61kAzroBk0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B/tKXIqkj1jmfNw75FSGBnpHrTXoiuM+6H8QyDJt+gFLXNUrPz/jzu+/gzDe3QbWY
         y6fC1ZDIN4avGoGistivDQf5/8iSavJVn8Q1VYt3JcMBn7WDCDRRl+dpJq2ZDx6xAH
         3ZYOLZJOGnEfIOcbY529VUquuP+ZMpUGidWwtm5e0Mfi74Dsg13k1qi8ywwZ7egb5s
         EZxbBrC/EdRf3oB1hrjMYmRzhEfOAzbCdHWN/BqVjfpx6CeBWgmdDb25tZ/i/2Ll+y
         YK7lkqhq0sGf9jtYkrhsG25PmUDbymixhHHvULniC9fU9CChTplnKXNzbltAu/Hyy0
         q8DYLyPzFOw1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 543A45C06D0; Thu, 22 Sep 2022 06:54:42 -0700 (PDT)
Date:   Thu, 22 Sep 2022 06:54:42 -0700
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
Message-ID: <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-4-kernelfans@gmail.com>
 <20220916134258.GB25891@lothringen>
 <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
 <20220920094645.GG69891@lothringen>
 <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
 <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 22, 2022 at 05:29:32PM +0800, Pingfan Liu wrote:
> On Tue, Sep 20, 2022 at 12:13:39PM -0700, Paul E. McKenney wrote:
> > On Tue, Sep 20, 2022 at 11:46:45AM +0200, Frederic Weisbecker wrote:
> > > On Tue, Sep 20, 2022 at 03:26:28PM +0800, Pingfan Liu wrote:
> > > > On Fri, Sep 16, 2022 at 03:42:58PM +0200, Frederic Weisbecker wrote:
> > > > > Note this is only locking the rdp's node, not the root node.
> > > > > Therefore if CPU 0 and CPU 256 are going off at the same time and they
> > > > > don't belong to the same node, the above won't protect against concurrent
> > > > > TICK_DEP_BIT_RCU set/clear.
> > > > > 
> > > > 
> > > > Nice, thanks for the careful thoughts. How about moving the counting
> > > > place to the root node?
> > > 
> > > You could but then you'd need to lock the root node.
> > > 
> > > > > My suspicion is that we don't need this TICK_DEP_BIT_RCU tick dependency
> > > > > anymore. I believe it was there because of issues that were fixed with:
> > > > > 
> > > > > 	53e87e3cdc15 (timers/nohz: Last resort update jiffies on nohz_full IRQ entry)
> > > > > and:
> > > > > 
> > > > > 	a1ff03cd6fb9 (tick: Detect and fix jiffies update stall)
> > > > > 
> > > > > It's unfortunately just suspicion because the reason for that tick dependency
> > > > > is unclear but I believe it should be safe to remove now.
> > > > > 
> > > > 
> > > > I have gone through this tick dependency again, but got less.
> > > > 
> > > > I think at least from the RCU's viewpoint, it is useless since
> > > > multi_cpu_stop()->rcu_momentary_dyntick_idle() has eliminate the
> > > > requirement for tick interrupt.
> > > 
> > > Partly yes.
> > > 
> > > > Is there a way to have a convincing test so that these code can be removed?
> > > > Or this code will be got along with?
> > > 
> > > Hmm, Paul might remember which rcutorture scenario would trigger it?
> > 
> > TREE04 on multisocket systems, preferably with faster CPU-hotplug
> > operations.  This can be accomplished by adding this to the kvm.sh
> > command line:
> > 
> > 	rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30
> > 
> 
> Is it ok with "sh kvm.sh  --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs TREE04"

If you have tools/.../rcutorture/bin on your path, yes.  This would default
to a 30-minute run.  If you have at least 16 CPUs, you should add
"--allcpus" to do concurrrent runs.  For example, given 64 CPUs you could
do this:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs "4*TREE04"

This would run four concurrent instances of the TREE04 scenario, each for
10 hours, for a total of 40 hours of test time.

> > It does take some time to run.  I did 4,000 hours worth of TREE04
>                                         ^^^ '--duration=4000h' can serve this purpose?

You could, at least if you replace the "=" with a space character, but
that really would run a six-month test, which is probably not what you
want to do.  There being 8,760 hours in a year and all that.

> Is it related with the cpu's freq?

Not at all.  '--duration 10h' would run ten hours of wall-clock time
regardless of the CPU frequencies.

> > to confirm lack of bug.  But an 80-CPU dual-socket system can run
> > 10 concurrent instances of TREE04, which gets things down to a more
> 
> The total demanded hours H = 4000/(system_cpu_num/8)?

Yes.  You can also use multiple systems, which is what kvm-remote.sh is
intended for, again assuming 80 CPUs per system to keep the arithmetic
simple:

tools/testing/selftests/rcutorture/bin/kvm-remote.sh "sys1 sys2 ... sys20" --duration 20h --cpus 80 --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs "200*TREE04"

Here "sys1" is the name of the system, on which you must have an account
so that "ssh sys1 date" runs the date command on the first remote system.
You really do have to use the "--cpus 80" because kvm-remote.sh does not
assume that the system that it is running on is one of the test systems.

> > manageable 400 hours.  Please let me know if you don't have access
> > to a few such systems.
> 
> I am happy to have a try if needed. I will try to get a powerful
> machine, which can shrink the test time.

Larger numbers of little systems work, also, but in my experience you need
a dual-socket system to have a reasonable chance of reproducing this bug.
Each socket can be small, though, if that helps.

If you work for a cloud provider or some such, you can probably get a
large number of systems.  If you can only get a few, you can do initial
testing, and then we can work out what to do about heavier-duty testing.

> > I will let Frederic identify which commit(s) should be reverted in
> > order to test the test.
> > 
> 
> My understanding is after removing the tick dep by
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 79aea7df4345..cbfc884f04a4 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2171,8 +2171,6 @@ int rcutree_dead_cpu(unsigned int cpu)
>         WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
>         /* Adjust any no-longer-needed kthreads. */
>         rcu_boost_kthread_setaffinity(rnp, -1);
> -       // Stop-machine done, so allow nohz_full to disable tick.
> -       tick_dep_clear(TICK_DEP_BIT_RCU);
>         return 0;
>  }
> 
> @@ -4008,8 +4006,6 @@ int rcutree_online_cpu(unsigned int cpu)
>         sync_sched_exp_online_cleanup(cpu);
>         rcutree_affinity_setting(cpu, -1);
> 
> -       // Stop-machine done, so allow nohz_full to disable tick.
> -       tick_dep_clear(TICK_DEP_BIT_RCU);
>         return 0;
>  }
> 
> @@ -4031,8 +4027,6 @@ int rcutree_offline_cpu(unsigned int cpu)
> 
>         rcutree_affinity_setting(cpu, cpu);
> 
> -       // nohz_full CPUs need the tick for stop-machine to work quickly
> -       tick_dep_set(TICK_DEP_BIT_RCU);
>         return 0;
>  }
> 
> If the TREE04 can success, then move on to revert the commit(s)
> identified by Frederic, and do test again.
> 
> At this time, a TREE04 failure is expected.
> 
> If the above two results are observed, TICK_DEP_BIT_RCU can be
> removed.
> 
> Is my understanding right?

Seems plausible to me, but I again defer to Frederic.

							Thanx, Paul
