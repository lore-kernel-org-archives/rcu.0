Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE63DC32793
	for <rcu@archiver.kernel.org>; Wed, 18 Jan 2023 17:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjARR4k (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Jan 2023 12:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjARR4j (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Jan 2023 12:56:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2984537F0E
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 09:56:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7A3FB81E66
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 17:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AD1C433D2;
        Wed, 18 Jan 2023 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674064595;
        bh=cmDhZpFOMrK2I3PDHm2cpre02sim6FNy5tmvNkl/WTk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OYr1GVWgvWe3ev4FRHZhkr7AiwxKf1BmuDeRwmueAVvAMjO8NIH4qdD6xl3QHKgQ9
         1SGR7wi8lJ46DDfl+NLEQTfUmPCI8JUcn16/HS127kNkoC12sSyx3vSSCJHzSyGDvf
         sTMpX8dDbr2uDAtwWfSQ07nvv+VYA33HU6wAGQdSxORK1ttewUbxdtvUgZeANmC77X
         4J6xayR+xlkTA7F1KZNjIJ+QNPkyj/Stmucgs8lSj5AXVGQxRtkrlnQ/6Y3LORnGZk
         cPiW3r6AqeaqlDwB7WbHvmUpm+fDmonT5DWMt7dbF78pp4rLzTwY86cGf6jV3RtSdY
         L+TL/H0PBSokQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2ECA45C0920; Wed, 18 Jan 2023 09:56:35 -0800 (PST)
Date:   Wed, 18 Jan 2023 09:56:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
Message-ID: <20230118175635.GC2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org>
 <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
 <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTtY5WNLJ4p9ggso7L38rtiCFEq2aLCwYUkQ2ckBnEsSA@mail.gmail.com>
 <20230118040058.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230118165121.GB19026@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118165121.GB19026@willie-the-truck>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 18, 2023 at 04:51:22PM +0000, Will Deacon wrote:
> On Tue, Jan 17, 2023 at 08:00:58PM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 18, 2023 at 02:17:06AM +0000, Joel Fernandes wrote:
> >
> > I would be happier to forgive failure to offline housekeeping CPUs than
> > blanket forgiveness of CPU 0.  Especially given that I recently got
> > burned by a non-zero boot cpu.  ;-)
> > 
> > But wouldn't it be even better for cpu_is_hotpluggable() to know the
> > NO_HZ_FULL rules of the road?
> > 
> > > Adding Frederic to CC as well as we are talking about
> > > housekeeping/isolation stuff.
> > 
> > But as you say, perhaps Frederic has a better idea.
> > 
> > > > And topology_init() sets this based on platform_can_hotplug_cpu(cpu).
> > > > And this function sets CPU 0 as !cpu_is_hotpluggable() unless the
> > > > architecture specifies a .cpu_can_disable() function.
> > > 
> > > Ah, that is 32-bit ARM code only. This issue is on 64-bit ARM (arch/arm64/).
> > 
> > Apologies!  I will look more carefully at the pathnames next time!
> > 
> > But maybe arm64 needs something similar?
> 
> Just chiming quickly from the arm64 side here, but there's nothing in the
> architecture that precludes offlining CPU 0 and it certainly works on some
> platforms, so I'd be hesitant to rule it out entirely for testing.
> 
> One reason why hotplug can fail in practice is if a trusted OS (i.e. code
> running on the secure side of the fence outside of Linux's view of the
> world) is resident on a core and rejects firmware requests to power it
> off. The PSCI code (drivers/firmware/psci/) should detect this and return
> -EPERM, although earlier in this thread there was mention of -EBUSY so it
> sounds like something else...

We can certainly special-case -EPERM in rcutorture.  But what should we
expect?  Would this be a random encounter with a trusted OS, or should we
expect that a given trusted OS instance would grab a giving CPU long-term?
My guess is the former, but I do feel the need to ask.  ;-)

							Thanx, Paul
