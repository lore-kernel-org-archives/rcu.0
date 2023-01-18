Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3C1C38147
	for <rcu@archiver.kernel.org>; Wed, 18 Jan 2023 04:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjAREBG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Jan 2023 23:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjAREBD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Jan 2023 23:01:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54DF3EC7E
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 20:01:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D66EB81B1A
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 04:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35039C433EF;
        Wed, 18 Jan 2023 04:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674014459;
        bh=veUBnwetV+hSjuqs0BW207dqFMZVpLv0n2F4zspwzEs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XMQXBnpUQh3yV+jtRnYYwwQIJVhcYdTnrkldptdd1st+3YHYQwUF+tj9LxQKgwAjJ
         h7d7uWhj2b5++uAsju24sUTJisk5X0g1tPeOqPY4k2dU5mmV4ybiGIlqImuqTg6sce
         h9Xm8SBxKxWPOnIw0iaUh8gCYg6Hflr2wPfwcWRte+RkzjuL10AZKxRKSEeIbX85gJ
         fF8oEQtYPjTpvG4G96fxcPCriYFYqe7A39sEjpnu4lloWEmuS5+nZONqGksL2LnwOX
         OVbaQEj/ti1BXzhxdgi0KugEqVQ+ebW3KpseAOEIsUrO2s4eNjZC3Y5J/BTVTrr3yH
         DldO2CEyPZx4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C4DAD5C1052; Tue, 17 Jan 2023 20:00:58 -0800 (PST)
Date:   Tue, 17 Jan 2023 20:00:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
Message-ID: <20230118040058.GV2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org>
 <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
 <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTtY5WNLJ4p9ggso7L38rtiCFEq2aLCwYUkQ2ckBnEsSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTtY5WNLJ4p9ggso7L38rtiCFEq2aLCwYUkQ2ckBnEsSA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 18, 2023 at 02:17:06AM +0000, Joel Fernandes wrote:
> Hi Paul,
> 
> On Tue, Jan 17, 2023 at 8:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Jan 17, 2023 at 08:02:24PM +0000, Joel Fernandes wrote:
> > > On Tue, Jan 17, 2023 at 4:54 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Mon, Jan 16, 2023 at 11:36:57PM -0500, Joel Fernandes wrote:
> > > > > > On Jan 16, 2023, at 11:30 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > ﻿On Tue, Jan 17, 2023 at 12:15:07AM +0000, Joel Fernandes wrote:
> > > > > >>> On Mon, Jan 16, 2023 at 05:38:00PM -0500, Joel Fernandes wrote:
> > > > > >>> Hi Zhouyi,
> > > > > >>>
> > > > > >>> On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> > > > > >>>>
> > > > > >>> [..]
> > > > > >>>> On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > >>>>>
> > > > > >>>>> Hello,
> > > > > >>>>> I am seeing -EBUSY returned a lot during torture_onoff() when running
> > > > > >>>>> rcutorture on arm64. This causes hotplug failure 30% of the time. I am
> > > > > >>>>> also seeing this in 6.1-rc kernels. I believe see this only for CPU0.
> > > > > >>>>>
> > > > > >>>>> This causes warnings in torture tests:
> > > > > >>>>> [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > > > >>>>> [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > > > >>>>>
> > > > > >>>>> Full kernel log here:
> > > > > >>>>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TREE04/console.log
> > > > > >>>>>
> > > > > >>>>> Any ideas on why this is happening and only for CPU 0 (presumably the
> > > > > >>>>> boot CPU)? I'd personally need these warnings to go away for my tests
> > > > > >>>>> as this causes rcutorture's tests to not cleanly pass for me. It
> > > > > >>>>> appears remove_cpu() -> device_offline() is what returns the error.
> > > > > >>>>>
> > > > > >>>> I guess this probably because CPU 0 is the tick_do_timer_cpu in
> > > > > >>>> nohz_full mode, which prevent that cpu from
> > > > > >>>> going offline [1]. We have discussed this topic, but there is no
> > > > > >>>> agreement on how to solve it yet.
> > > > > >>>
> > > > > >>> But I am seeing the issue in TRACE02 config which is:
> > > > > >>> CONFIG_NO_HZ_IDLE=y
> > > > > >>> # CONFIG_NO_HZ_FULL is not set
> > > > > >>>
> > > > > >>> So that is not NO_HZ_FULL:
> > > > > >>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/console.log.diags/
> > > > > >>> However, I can't seem to find the full kernel logs for that.
> > > > > >>>
> > > > > >>> Also, other than the TRACE02 fail, I only see the issue with configs
> > > > > >>> with CONFIG_NO_HZ_FULL=y
> > > > > >>>
> > > > > >>> Can you try TRACE02 specifically, and see if you can reproduce the
> > > > > >>> same issue on your setup? Meanwhile, I'll try to trace what is
> > > > > >>> returning the -EBUSY.
> > > > > >>
> > > > > >> How about something simple like the following? (untested)
> > > > > >>
> > > > > >> ---8<-----------------------
> > > > > >>
> > > > > >> diff --git a/kernel/torture.c b/kernel/torture.c
> > > > > >> index bc8fb361efc0..cd64110694c0 100644
> > > > > >> --- a/kernel/torture.c
> > > > > >> +++ b/kernel/torture.c
> > > > > >> @@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
> > > > > >>            // PCI probe frequently disables hotplug during boot.
> > > > > >>            (*n_offl_attempts)--;
> > > > > >>            s = " (-EBUSY forgiven during boot)";
> > > > > >> +        } else if (tick_nohz_full_running && ret == -EBUSY) {
> > > > > >> +            (*n_offl_attempts)--;
> > > > > >> +            s = " (-EBUSY forgiven if nohz_full is running)";
> > > > > >
> > > > > > But this should be forgiven for the timekeeping CPU, not everyone,
> > > > > > correct?
> > > > > >
> > > > > > Yes, I know that CPU-hotplug operations can fail, but in my testing
> > > > > > they almost never do.  This means that a new failure might well be a
> > > > > > real bug somewhere that needs attention.
> > > > >
> > > > > Sure. We may need to expose some API to reveal that.
> > > > >
> > > > > It appeared though that Thomas in the other thread related to patch
> > > > > from Zhouyi, was suggesting that rcutorture tolerate hotplug failure
> > > > > though, because they are not abnormal, right?
> > > >
> > > > Based on my rcutorture testing experience on x86, they are not at all
> > > > normal.  The only time I have seen rcutorture CPU-hotplug failures has
> > > > been due to some bug that needed fixing.
> > >
> > > I see, ok. I need to debug what is returning -EBUSY for !NO_HZ_FULL on
> > > arm64, I will report back once I do.
> > >
> > > Meanwhile, Marc I am wondering if you are able to reproduce the issue
> > > on your side on TRACE02 config, like I am?
> > >
> > > Here is the TRACE02 config fragment:
> > > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/ConfigFragment/*view*/
> > >
> > > Here are instructions on how to run it (torture test parameters etc)
> > > if you are loading the module yourself:
> > > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/bare-metal/*view*/
> >
> > I am assuming that this is directed to someone having easy access
> > to ARM hardware.
> >
> > > > Is there a plan to make CPU hotplug failures more frequent?
> > >
> > > I am not aware of such a plan but I was going by "There are quite some
> > > reasons why a CPU-hotplug or a hot-unplug operation can fail, which is
> > > not a fatal problem, really." in [1].
> > >
> > > What about an rcutorture to skip hotplug for a certain cpu id,
> > > rcutorture.skip_hotplug_cpus="0". Can be a last resort. But we/I
> > > should debug this issue more before getting to that.
> >
> > Yes, in fact there already are some checks along those lines, for example,
> > the torture_offline() function's check of cpu_is_hotpluggable().  So for
> > example, as I understand it, a CONFIG_NO_HZ_FULL=y system should mark
> > the housekeeping CPU as !cpu_is_hotpluggable().
> 
> I don't think CONFIG_NO_HZ_FULL does any such marking (at least I am
> not seeing it). Even on x86, if you enable
> CONFIG_BOOTPARAM_HOTPLUG_CPU0=y , and CONFIG_NO_HZ_FULL=y, and run
> rcutorture with boot args:
> 
> nohz_full=0-3 rcutorture.onoff_interval=100 rcutorture.onoff_holdoff=2
> rcutorture.shutdown_secs=30
> 
> You will see this in the kernel logs:
> [    2.816022] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> [    2.975913] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> 
> So RCU torture test clearly thought the CPUs were hot-pluggable, when
> they was chance for them to return -EBUSY (due to housekeeping and
> what not). So this issue seems to be architecture independent, in that
> sense.
> 
> So the 2 ways forward I see are:
> - Make the torture test aware of which CPUs are 'house keeping'
> - Make it possible to turn off CPU0 hotplugging on ARM64 by default
> (via CONFIG or boot option).
> 
> Another option could be, forgive -EBUSY on CPU0 for
> CONFIG_NO_HZ_FULL=y.  Is it possible to assign a non-0 CPU id as a
> housekeeping CPU?

I would be happier to forgive failure to offline housekeeping CPUs than
blanket forgiveness of CPU 0.  Especially given that I recently got
burned by a non-zero boot cpu.  ;-)

But wouldn't it be even better for cpu_is_hotpluggable() to know the
NO_HZ_FULL rules of the road?

> Adding Frederic to CC as well as we are talking about
> housekeeping/isolation stuff.

But as you say, perhaps Frederic has a better idea.

> > And topology_init() sets this based on platform_can_hotplug_cpu(cpu).
> > And this function sets CPU 0 as !cpu_is_hotpluggable() unless the
> > architecture specifies a .cpu_can_disable() function.
> 
> Ah, that is 32-bit ARM code only. This issue is on 64-bit ARM (arch/arm64/).

Apologies!  I will look more carefully at the pathnames next time!

But maybe arm64 needs something similar?

							Thanx, Paul

> Thanks,
> 
>  - Joel
> 
> 
> > So architectures that don't want specific CPUs to be hotpluggable
> > can and should so specify.
> >
> >                                                         Thanx, Paul
> >
> > > Thanks,
> > >
> > > - Joel
> > > [1] https://lkml.org/lkml/2022/11/27/182
