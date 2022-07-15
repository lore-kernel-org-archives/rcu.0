Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E89C433EF
	for <rcu@archiver.kernel.org>; Fri, 15 Jul 2022 17:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiGORR5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Jul 2022 13:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiGORR4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Jul 2022 13:17:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0DE45980
        for <rcu@vger.kernel.org>; Fri, 15 Jul 2022 10:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 257FBB82D22
        for <rcu@vger.kernel.org>; Fri, 15 Jul 2022 17:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2999C34115;
        Fri, 15 Jul 2022 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657905472;
        bh=FD3x+OfmOGn5Pw8Y/ennRpprEYYEvOXZw6ccx6Nc2h4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hsGZOxlJB7o8eUvKn36Fm1h85aZcz9st5jZrzpVIQXSX+LO9KO6BIlMbOgKBhzcvU
         Ci0KObassFT9r101Z8zB2LK7Lme7hFvSgCljnTP1G4Fw7z0iqHfjdFd2NN2PhvXkIg
         bji/uCHzd29tGBrntvWmYwtuPL983nJTtbJwaaZvW3KjlrNonalHcxbjFydP0jonyq
         ovIsmpYK8ir2pnYUaUt3+3L0ckuqoy24aQDjAMhxw2J1Z/wutWd9Dmj0lIsICTqHM5
         eL6brL+cAFyV5FZ7iRakB/WCzXqtb/EILejubuVPwMYRQXj1zcgIViiM+i+I9M/Ws+
         F90amwECF7eWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 57BBE5C03A3; Fri, 15 Jul 2022 10:17:52 -0700 (PDT)
Date:   Fri, 15 Jul 2022 10:17:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 0/5] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <20220715171752.GB1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220713213237.1596225-1-joel@joelfernandes.org>
 <20220714205154.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220714222131.GA3321557@paulmck-ThinkPad-P17-Gen-1>
 <YtGFLFbzuZncfDeN@google.com>
 <20220715152937.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <YtGKcScgTh3t4SYS@google.com>
 <YtGMucOzKDy5A1UK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtGMucOzKDy5A1UK@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 15, 2022 at 03:50:17PM +0000, Joel Fernandes wrote:
> On Fri, Jul 15, 2022 at 03:40:33PM +0000, Joel Fernandes wrote:
> > On Fri, Jul 15, 2022 at 08:29:37AM -0700, Paul E. McKenney wrote:
> > > On Fri, Jul 15, 2022 at 03:18:04PM +0000, Joel Fernandes wrote:
> > > > On Thu, Jul 14, 2022 at 03:21:31PM -0700, Paul E. McKenney wrote:
> > > > > On Thu, Jul 14, 2022 at 01:51:54PM -0700, Paul E. McKenney wrote:
> > > > > > On Wed, Jul 13, 2022 at 09:32:32PM +0000, Joel Fernandes (Google) wrote:
> > > > > > > Hello!
> > > > > > > 
> > > > > > > Please find the next improved version of call_rcu_lazy() attached.  The main
> > > > > > > difference between the previous versions is that:
> > > > > > > - In v2 rcu_barrier is fixed to not hang (I found this to be due to a missing
> > > > > > >   GP thread wakeup), now I am limiting this wake up only to rcu_barrier() as
> > > > > > >   requested by Paul.
> > > > > > > - Fixed checkpatch and build robot issues.
> > > > > > > - Some more changes to 'lazy' parameter passing and consolidation of segcblist
> > > > > > >   functions.
> > > > > > > - more testing via rcutorture and rcuscale.
> > > > > > 
> > > > > > Thank you!  What I am going to do is to pull these into an experimental
> > > > > > not-for-mainline branch and run the usual set of rcutorture tests.
> > > > > > I will then take a look at the patches.
> > > > > 
> > > > > And there were a few conflicts with the nocb patch series in -rcu.
> > > > > The allegedly conflict-resolved series is here: joel.2022.07.14a
> > > > > Please let me know if I messed something up.
> > > > 
> > > > Thanks, it looks Ok. There is one robot fix for hexagon's arch where I think
> > > > TREE_RCU is disabled, could you apply the diff below to patch 1/5 ?
> > > > 
> > > > Or, I can also just keep it in my version of 1/5 to go out with the next rev.
> > > 
> > > Given that I am not testing on hexagon, I will let you fix this one on
> > > the next rev.  If someone out there is testing this branch on hexagon,
> > > they should feel free to apply your patch locally.  ;-)
> > 
> > I am pretty sure this is the feature that was going to make Hexagon widely
> > adopted, but your call ;-)

Then they should be highly motivated to apply your patch.  ;-)

> Jokes apart, I am sure this feature will be useful to a lot of folks and
> architectures but lets keep this diff for the next revision as you said.
> 
> Actually never heard of Hexagon till today... 32-bit and 4x VLIW, Cool! :
> https://en.wikipedia.org/wiki/Qualcomm_Hexagon

Indeed, there are still about 20 different types of processors running Linux.

							Thanx, Paul
