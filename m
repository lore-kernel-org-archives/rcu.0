Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C1C6379F
	for <rcu@archiver.kernel.org>; Tue, 17 Jan 2023 21:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjAQV7b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjAQV7J (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Jan 2023 16:59:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7477C840
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 12:42:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60EC16154A
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 20:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56A8C433D2;
        Tue, 17 Jan 2023 20:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673988151;
        bh=+LEDHZV8xLtNKUNSDfiElVZVvZ2g2QpdmNwzu//4FxQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WhGF38XHOSW9qMw25lSMc4yEGsrNEausdnxn74ucthPJ2GyaacLWq9RDNwK+1w9qL
         EtyayqMs3hUFs67Bd0AJ7RxlNNqGulII92yv2RSwkwZ8fvFUUBJZqSrD01/N0IYByd
         yNmEZRHRBc2eroh7ffPA1hVZJKLJ5yTbtvQyzRYMrG2t5danRQJ33txzrkL/uPYFr3
         AtRMjp7gmeqJDz+G8YeFmbyUH0Vt8dTEP4axFgV+59dqyYRykl4BHBtWRh9yJgl1yI
         CzdsIll/fJHTmWl4IuPUoVtDjoHLo3vLN1fGjQ+6S2UbEFJw4QvyENUPkGHlvtCu2T
         KKA+ZXxZd/htQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6D0A75C10CA; Tue, 17 Jan 2023 12:42:31 -0800 (PST)
Date:   Tue, 17 Jan 2023 12:42:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
Message-ID: <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org>
 <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 17, 2023 at 08:02:24PM +0000, Joel Fernandes wrote:
> On Tue, Jan 17, 2023 at 4:54 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Jan 16, 2023 at 11:36:57PM -0500, Joel Fernandes wrote:
> > > > On Jan 16, 2023, at 11:30 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > ﻿On Tue, Jan 17, 2023 at 12:15:07AM +0000, Joel Fernandes wrote:
> > > >>> On Mon, Jan 16, 2023 at 05:38:00PM -0500, Joel Fernandes wrote:
> > > >>> Hi Zhouyi,
> > > >>>
> > > >>> On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> > > >>>>
> > > >>> [..]
> > > >>>> On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >>>>>
> > > >>>>> Hello,
> > > >>>>> I am seeing -EBUSY returned a lot during torture_onoff() when running
> > > >>>>> rcutorture on arm64. This causes hotplug failure 30% of the time. I am
> > > >>>>> also seeing this in 6.1-rc kernels. I believe see this only for CPU0.
> > > >>>>>
> > > >>>>> This causes warnings in torture tests:
> > > >>>>> [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > >>>>> [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > >>>>>
> > > >>>>> Full kernel log here:
> > > >>>>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TREE04/console.log
> > > >>>>>
> > > >>>>> Any ideas on why this is happening and only for CPU 0 (presumably the
> > > >>>>> boot CPU)? I'd personally need these warnings to go away for my tests
> > > >>>>> as this causes rcutorture's tests to not cleanly pass for me. It
> > > >>>>> appears remove_cpu() -> device_offline() is what returns the error.
> > > >>>>>
> > > >>>> I guess this probably because CPU 0 is the tick_do_timer_cpu in
> > > >>>> nohz_full mode, which prevent that cpu from
> > > >>>> going offline [1]. We have discussed this topic, but there is no
> > > >>>> agreement on how to solve it yet.
> > > >>>
> > > >>> But I am seeing the issue in TRACE02 config which is:
> > > >>> CONFIG_NO_HZ_IDLE=y
> > > >>> # CONFIG_NO_HZ_FULL is not set
> > > >>>
> > > >>> So that is not NO_HZ_FULL:
> > > >>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/console.log.diags/
> > > >>> However, I can't seem to find the full kernel logs for that.
> > > >>>
> > > >>> Also, other than the TRACE02 fail, I only see the issue with configs
> > > >>> with CONFIG_NO_HZ_FULL=y
> > > >>>
> > > >>> Can you try TRACE02 specifically, and see if you can reproduce the
> > > >>> same issue on your setup? Meanwhile, I'll try to trace what is
> > > >>> returning the -EBUSY.
> > > >>
> > > >> How about something simple like the following? (untested)
> > > >>
> > > >> ---8<-----------------------
> > > >>
> > > >> diff --git a/kernel/torture.c b/kernel/torture.c
> > > >> index bc8fb361efc0..cd64110694c0 100644
> > > >> --- a/kernel/torture.c
> > > >> +++ b/kernel/torture.c
> > > >> @@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
> > > >>            // PCI probe frequently disables hotplug during boot.
> > > >>            (*n_offl_attempts)--;
> > > >>            s = " (-EBUSY forgiven during boot)";
> > > >> +        } else if (tick_nohz_full_running && ret == -EBUSY) {
> > > >> +            (*n_offl_attempts)--;
> > > >> +            s = " (-EBUSY forgiven if nohz_full is running)";
> > > >
> > > > But this should be forgiven for the timekeeping CPU, not everyone,
> > > > correct?
> > > >
> > > > Yes, I know that CPU-hotplug operations can fail, but in my testing
> > > > they almost never do.  This means that a new failure might well be a
> > > > real bug somewhere that needs attention.
> > >
> > > Sure. We may need to expose some API to reveal that.
> > >
> > > It appeared though that Thomas in the other thread related to patch
> > > from Zhouyi, was suggesting that rcutorture tolerate hotplug failure
> > > though, because they are not abnormal, right?
> >
> > Based on my rcutorture testing experience on x86, they are not at all
> > normal.  The only time I have seen rcutorture CPU-hotplug failures has
> > been due to some bug that needed fixing.
> 
> I see, ok. I need to debug what is returning -EBUSY for !NO_HZ_FULL on
> arm64, I will report back once I do.
> 
> Meanwhile, Marc I am wondering if you are able to reproduce the issue
> on your side on TRACE02 config, like I am?
> 
> Here is the TRACE02 config fragment:
> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/ConfigFragment/*view*/
> 
> Here are instructions on how to run it (torture test parameters etc)
> if you are loading the module yourself:
> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/bare-metal/*view*/

I am assuming that this is directed to someone having easy access
to ARM hardware.

> > Is there a plan to make CPU hotplug failures more frequent?
> 
> I am not aware of such a plan but I was going by "There are quite some
> reasons why a CPU-hotplug or a hot-unplug operation can fail, which is
> not a fatal problem, really." in [1].
> 
> What about an rcutorture to skip hotplug for a certain cpu id,
> rcutorture.skip_hotplug_cpus="0". Can be a last resort. But we/I
> should debug this issue more before getting to that.

Yes, in fact there already are some checks along those lines, for example,
the torture_offline() function's check of cpu_is_hotpluggable().  So for
example, as I understand it, a CONFIG_NO_HZ_FULL=y system should mark
the housekeeping CPU as !cpu_is_hotpluggable().

And topology_init() sets this based on platform_can_hotplug_cpu(cpu).
And this function sets CPU 0 as !cpu_is_hotpluggable() unless the
architecture specifies a .cpu_can_disable() function.

So architectures that don't want specific CPUs to be hotpluggable
can and should so specify.

							Thanx, Paul

> Thanks,
> 
> - Joel
> [1] https://lkml.org/lkml/2022/11/27/182
