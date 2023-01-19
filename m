Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10992C38159
	for <rcu@archiver.kernel.org>; Thu, 19 Jan 2023 00:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjASAPP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Jan 2023 19:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjASAPO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Jan 2023 19:15:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DA651430
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 16:15:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A25DB81E66
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 00:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10979C433EF;
        Thu, 19 Jan 2023 00:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674087311;
        bh=JYPVr8b2hOcXOf0FlyH+WLONGP39KDf3Pk1oMHnfKsA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SVqTlqKc+SjqFTTsOk+jPO8pFb83kHtAYNVm4TucUd9ifv/gKoxQ/SO+rbSbshVop
         bbO68ahlNRveBxIkYjYBOKJZ5toDVX6jTVD3PwIOaK6v3jSHxlU9dfWFdQaS6FDu+Z
         xl9vH2gIJS4WGAJPYlMzW8PBOvFBzy85Us4OnTOxw61cUt7dP1UopQCBMB2TSBBAg5
         MiCMm4KtVN6eR7aCPJ3nOCC84z/Qxi3yjpHd3fvh0pr2iEf7UZhFnvCpjgoYaDH+z1
         bb5z/68IUM8ABcoduFiOiaw0f5v4JQIBRSy0zcC9vXCYbdS/QUOSAp9P9cFbBhjbSu
         fNTkNg8h+WGsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A24F85C0A1A; Wed, 18 Jan 2023 16:15:10 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:15:10 -0800
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
Message-ID: <20230119001510.GO2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org>
 <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
 <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTtY5WNLJ4p9ggso7L38rtiCFEq2aLCwYUkQ2ckBnEsSA@mail.gmail.com>
 <20230118040058.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8h0lDnQ9Z0VtXfV@google.com>
 <CAEXW_YTscMEtrMXK7nAGdey+EK0+voL6Fvd1Qrdq2stR2wUZPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTscMEtrMXK7nAGdey+EK0+voL6Fvd1Qrdq2stR2wUZPg@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 18, 2023 at 10:39:28PM +0000, Joel Fernandes wrote:
> On Wed, Jan 18, 2023 at 10:37 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Tue, Jan 17, 2023 at 08:00:58PM -0800, Paul E. McKenney wrote:
> > [...]
> > > > > > > Is there a plan to make CPU hotplug failures more frequent?
> > > > > >
> > > > > > I am not aware of such a plan but I was going by "There are quite some
> > > > > > reasons why a CPU-hotplug or a hot-unplug operation can fail, which is
> > > > > > not a fatal problem, really." in [1].
> > > > > >
> > > > > > What about an rcutorture to skip hotplug for a certain cpu id,
> > > > > > rcutorture.skip_hotplug_cpus="0". Can be a last resort. But we/I
> > > > > > should debug this issue more before getting to that.
> > > > >
> > > > > Yes, in fact there already are some checks along those lines, for example,
> > > > > the torture_offline() function's check of cpu_is_hotpluggable().  So for
> > > > > example, as I understand it, a CONFIG_NO_HZ_FULL=y system should mark
> > > > > the housekeeping CPU as !cpu_is_hotpluggable().
> > > >
> > > > I don't think CONFIG_NO_HZ_FULL does any such marking (at least I am
> > > > not seeing it). Even on x86, if you enable
> > > > CONFIG_BOOTPARAM_HOTPLUG_CPU0=y , and CONFIG_NO_HZ_FULL=y, and run
> > > > rcutorture with boot args:
> > > >
> > > > nohz_full=0-3 rcutorture.onoff_interval=100 rcutorture.onoff_holdoff=2
> > > > rcutorture.shutdown_secs=30
> > > >
> > > > You will see this in the kernel logs:
> > > > [    2.816022] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > > [    2.975913] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > >
> > > > So RCU torture test clearly thought the CPUs were hot-pluggable, when
> > > > they was chance for them to return -EBUSY (due to housekeeping and
> > > > what not). So this issue seems to be architecture independent, in that
> > > > sense.
> > > >
> > > > So the 2 ways forward I see are:
> > > > - Make the torture test aware of which CPUs are 'house keeping'
> > > > - Make it possible to turn off CPU0 hotplugging on ARM64 by default
> > > > (via CONFIG or boot option).
> > > >
> > > > Another option could be, forgive -EBUSY on CPU0 for
> > > > CONFIG_NO_HZ_FULL=y.  Is it possible to assign a non-0 CPU id as a
> > > > housekeeping CPU?
> > >
> > > I would be happier to forgive failure to offline housekeeping CPUs than
> > > blanket forgiveness of CPU 0.  Especially given that I recently got
> > > burned by a non-zero boot cpu.  ;-)
> > >
> > > But wouldn't it be even better for cpu_is_hotpluggable() to know the
> > > NO_HZ_FULL rules of the road?
> >
> > That's a great idea. I found a way to do that without having to do the
> > EXPORT_SYMBOL (like in Zhouyi's patch).
> >
> > Would the following be acceptable (only build-tested)?
> >
> > I can run more tests and submit a patch:
> >
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index 55405ebf23ab..f73bc520b70e 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
> >  bool cpu_is_hotpluggable(unsigned int cpu)
> >  {
> >         struct device *dev = get_cpu_device(cpu);
> > -       return dev && container_of(dev, struct cpu, dev)->hotpluggable;
> > +       return dev && container_of(dev, struct cpu, dev)->hotpluggable
> > +               && !tick_nohz_cpu_hotpluggable(cpu);
> 
> Oops, I should lose that "!" , but otherwise should be ok.

Looks plausible to me, but I must defer to Frederic and the various
architecture maintainers.

							Thanx, Paul
