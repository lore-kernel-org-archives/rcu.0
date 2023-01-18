Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE42C32793
	for <rcu@archiver.kernel.org>; Wed, 18 Jan 2023 16:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjARQvl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjARQv3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Jan 2023 11:51:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6022A32E48
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 08:51:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EED1C618F2
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 16:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD40AC433D2;
        Wed, 18 Jan 2023 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674060687;
        bh=jrwgvvkiVjUz4THmEOOKIEMdcOeOO6Mv7bDiFipPOKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDjNewCRdNi9DEe/vDJIBGfISr3E+SwCUieMDcJFuvzDfZVuhoXz6pCK+3IlLSJRM
         QpObUqF00jcf7POoegQQa9j7U3t+22flo8Fetdxp0OMCH9QRc/o9GNl+/++HG2+oOb
         wO239dCxWi+54F2j+ho40BhtrVXKM3F//VXTjwpXt9ptyWyoUItppqy5T5sQHhwdVd
         iCmC3/LEWqXKpW2A01O1fHKrmjItZa8uyVK6qt7ynDQXrm1yrcXeBJWD8XcbRwsRv6
         BqwIOZOZQmS/gRL6PhzFDoDwAj/H0k1ZF4Id4fLN1Pj5v88wrrEgUb2PIIUQKsjCQP
         tnkVD6scBjhzA==
Date:   Wed, 18 Jan 2023 16:51:22 +0000
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20230118165121.GB19026@willie-the-truck>
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org>
 <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
 <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTtY5WNLJ4p9ggso7L38rtiCFEq2aLCwYUkQ2ckBnEsSA@mail.gmail.com>
 <20230118040058.GV2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118040058.GV2948950@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 17, 2023 at 08:00:58PM -0800, Paul E. McKenney wrote:
> On Wed, Jan 18, 2023 at 02:17:06AM +0000, Joel Fernandes wrote:
>
> I would be happier to forgive failure to offline housekeeping CPUs than
> blanket forgiveness of CPU 0.  Especially given that I recently got
> burned by a non-zero boot cpu.  ;-)
> 
> But wouldn't it be even better for cpu_is_hotpluggable() to know the
> NO_HZ_FULL rules of the road?
> 
> > Adding Frederic to CC as well as we are talking about
> > housekeeping/isolation stuff.
> 
> But as you say, perhaps Frederic has a better idea.
> 
> > > And topology_init() sets this based on platform_can_hotplug_cpu(cpu).
> > > And this function sets CPU 0 as !cpu_is_hotpluggable() unless the
> > > architecture specifies a .cpu_can_disable() function.
> > 
> > Ah, that is 32-bit ARM code only. This issue is on 64-bit ARM (arch/arm64/).
> 
> Apologies!  I will look more carefully at the pathnames next time!
> 
> But maybe arm64 needs something similar?

Just chiming quickly from the arm64 side here, but there's nothing in the
architecture that precludes offlining CPU 0 and it certainly works on some
platforms, so I'd be hesitant to rule it out entirely for testing.

One reason why hotplug can fail in practice is if a trusted OS (i.e. code
running on the secure side of the fence outside of Linux's view of the
world) is resident on a core and rejects firmware requests to power it
off. The PSCI code (drivers/firmware/psci/) should detect this and return
-EPERM, although earlier in this thread there was mention of -EBUSY so it
sounds like something else...

Will
