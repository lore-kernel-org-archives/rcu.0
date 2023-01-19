Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E68C00A5A
	for <rcu@archiver.kernel.org>; Thu, 19 Jan 2023 09:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjASJNC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Jan 2023 04:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjASJNB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Jan 2023 04:13:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4EDF26A0
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 01:12:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BECA41758;
        Thu, 19 Jan 2023 01:13:39 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.47.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1D833F71A;
        Thu, 19 Jan 2023 01:12:56 -0800 (PST)
Date:   Thu, 19 Jan 2023 09:12:48 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
Message-ID: <Y8kJkMp/oZRJxXUp@FVFF77S0Q05N>
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org>
 <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
 <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTtY5WNLJ4p9ggso7L38rtiCFEq2aLCwYUkQ2ckBnEsSA@mail.gmail.com>
 <20230118040058.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230118165121.GB19026@willie-the-truck>
 <CAEXW_YQ=v0u+NFCwUcvMcYfsMXknb8YJrfGgKSW=dCA56Q+a0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQ=v0u+NFCwUcvMcYfsMXknb8YJrfGgKSW=dCA56Q+a0A@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Joel, Will,

On Wed, Jan 18, 2023 at 10:01:07PM +0000, Joel Fernandes wrote:
> On Wed, Jan 18, 2023 at 4:51 PM Will Deacon <will@kernel.org> wrote:
> > On Tue, Jan 17, 2023 at 08:00:58PM -0800, Paul E. McKenney wrote:
> > > On Wed, Jan 18, 2023 at 02:17:06AM +0000, Joel Fernandes wrote:
> > >
> > > I would be happier to forgive failure to offline housekeeping CPUs than
> > > blanket forgiveness of CPU 0.  Especially given that I recently got
> > > burned by a non-zero boot cpu.  ;-)
> > >
> > > But wouldn't it be even better for cpu_is_hotpluggable() to know the
> > > NO_HZ_FULL rules of the road?
> > >
> > > > Adding Frederic to CC as well as we are talking about
> > > > housekeeping/isolation stuff.
> > >
> > > But as you say, perhaps Frederic has a better idea.
> > >
> > > > > And topology_init() sets this based on platform_can_hotplug_cpu(cpu).
> > > > > And this function sets CPU 0 as !cpu_is_hotpluggable() unless the
> > > > > architecture specifies a .cpu_can_disable() function.
> > > >
> > > > Ah, that is 32-bit ARM code only. This issue is on 64-bit ARM (arch/arm64/).
> > >
> > > Apologies!  I will look more carefully at the pathnames next time!
> > >
> > > But maybe arm64 needs something similar?
> >
> > Just chiming quickly from the arm64 side here, but there's nothing in the
> > architecture that precludes offlining CPU 0 and it certainly works on some
> > platforms, so I'd be hesitant to rule it out entirely for testing.
> >
> > One reason why hotplug can fail in practice is if a trusted OS (i.e. code
> > running on the secure side of the fence outside of Linux's view of the
> > world) is resident on a core and rejects firmware requests to power it
> > off. The PSCI code (drivers/firmware/psci/) should detect this and return
> > -EPERM, although earlier in this thread there was mention of -EBUSY so it
> > sounds like something else...
> 
> Thank you for the heads up on that. To give you context, I am
> currently testing rcutorture on stable kernels 5.10, 5.15, 6.1 on my
> ARM64 QC7180 board. I certainly don't want to hit the -EPERM in the
> future on this or other ARM64 hardware. It would be great if
> cpu_psci_cpu_can_disable() in arm64 can return false if hotplugging
> causes -EPERM indefinitely. Then we do not need to make any changes.

That should already be the case, and I think we're good on that front.

A trusted OS (which blocks offlining a CPU) will always be resident on a
specific CPU (since we don't have any code to migrate trusted OSs across CPUs
as this is not standardised, and we don't have code to instantiate a trusted OS
from Linux). Where a non-migrateable trusted OS is present, it's going to have
been instantiated prior to booting Linux, and therefore will be on CPU0 (or a
CPU that Linux is not using at all).

Given the above, the return value of cpu_psci_cpu_can_disable() should not
change for a given CPU, and it should only be able to return false on CPU0.
Most systems don't have a trusted OS blocking PSCI CPU_OFF, and CPU0 can be
offlined.

Thanks,
Mark.
