Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7D3C433F5
	for <rcu@archiver.kernel.org>; Sun,  2 Oct 2022 16:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJBQ5y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Oct 2022 12:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiJBQ5x (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Oct 2022 12:57:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D101E252B3
        for <rcu@vger.kernel.org>; Sun,  2 Oct 2022 09:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8834AB80D6E
        for <rcu@vger.kernel.org>; Sun,  2 Oct 2022 16:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6F3C433D6;
        Sun,  2 Oct 2022 16:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664729870;
        bh=HaNhofCOA+qda8DVrwDUmgSi5WNHDK7KAwQSl6Kj+dM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=D+oznJSaZLqp+IsE3RkV7VEu9Qkbo2TsAPkmK3D8k0k0lDxmS+jZrz3hppga2/WVG
         CZIey8PYCjFG8ZXieYUQYgGhY740NW0GxO5EBjNk7Th/oVV6XEhACzM7tUj/6h0K97
         gFd6NqcM5bgz3iU+yModtUo8d7eu9CgFmLQUxPa3jf+wXsgrEeWKYzUm1wjddh+5Tg
         5winEnchoPrSm2aTMZoBLAIUMFbPn/dcWK+9ARF9c8hpUdqXFOXkSskVVl/kHja3hU
         5+1ABOONtXr0KyHBc3TeRrH6MxcFrsJicJjpSmiu6GKAJVzeVFvlZ95evqwqlhtou3
         /7bBG7eDbooGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 922CB5C086D; Sun,  2 Oct 2022 09:57:49 -0700 (PDT)
Date:   Sun, 2 Oct 2022 09:57:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Message-ID: <20221002165749.GU4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221002162442.GT4196@paulmck-ThinkPad-P17-Gen-1>
 <23461472-D3B0-448F-8819-F3F23C285E3B@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23461472-D3B0-448F-8819-F3F23C285E3B@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Oct 02, 2022 at 12:30:52PM -0400, Joel Fernandes wrote:
> 
> 
> > On Oct 2, 2022, at 12:24 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Sun, Oct 02, 2022 at 12:11:07PM -0400, Joel Fernandes wrote:
> >> 
> >> 
> >>> On 10/2/2022 10:06 AM, Pingfan Liu wrote:
> >>> On Fri, Sep 30, 2022 at 9:04 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >>>> 
> >>>> On Thu, Sep 29, 2022 at 4:21 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >>>>> 
> >>>>> On Thu, Sep 29, 2022 at 4:19 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >>>>>> 
> >>>>> [...]
> >>>>>> "
> >>>>>> 
> >>>>>> I have no idea whether this is related to the reverted commit.
> >>>>>> 
> >>>>> 
> >>>>> I have started another test against clean v6.0-rc7 to see whether this
> >>>>> is an issue with the mainline.
> >>>> 
> >>>> I am not sure what exactly you are reverting (you could clarify that),
> >>> 
> >>> commit 96926686deab ("rcu: Make CPU-hotplug removal operations enable tick").
> >>> But due to conflict, "git revert" can not work directly. So I applied
> >>> it by hand.
> >>> 
> >>>> but if you are just removing the entire TICK_DEP_BIT_RCU, I do
> >>>> remember (and mentioned on IRC to others recently) that without this
> >>>> NOHZ_FULL has a hard time ending grace-periods because the forcing of
> >>>> tick is needed for this configuration if we are spinning in the kernel
> >>>> with the tick turned off. That seems to align with your TREE04
> >>>> (NOHZ_FULL) configuration.
> >>>> 
> >>> 
> >>> Yes, that is the scenario.
> >>> 
> >>>> Also, the commit Frederic suggested to revert seems to be a cosmetic
> >>>> optimization in the interrupt-entry path. That should not change
> >>>> functionality I believe. So I did not fully follow why reverting that
> >>>> is relevant (maybe Frederic can clarify?).
> >>>> 
> >>> 
> >>> Leave this question to Frederic.
> >> 
> >> I take this comment back, Sorry. Indeed the commits Frederic mentioned will make
> >> a functional change to CPU hotplug path.
> >> 
> >> Sorry for the noise.
> >> 
> >> Excited to see exact reason why TICK_DEP_BIT_RCU matters in the hotplug paths. I
> >> might jump into the investigation with you guys, but I have to make time for
> >> Lazy-RCU v7 next :)
> > 
> > One historical reason was that a nohz_full CPU could enter the kernel with
> > the tick still disabled, and stay that way indefinitely.  Among other
> > things, this can interfere with the grace-period wait in the offlining
> > code path.
> 
> Thanks for clarification/confirmation, that was my hunch as well. Does the emergency forcing on of the tick not suffice for that? If I understand you are sending an IPI to set the same tick dependency if grace periods are being held too long. Another potential fix instead of setting tick dependency in hotplug, then, could be to reduce the time before which emergency IPIs are sent to free up nohz_full CPUs, I think.

Why not try modifying it to work this way and seeing what (if anything)
breaks?  If nothing breaks, then there is still the option of digging
into the code.

In both cases, after Lazy-RCU v7, of course.  ;-)

								Thanx, Paul
