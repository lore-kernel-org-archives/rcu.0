Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9935C4167B
	for <rcu@archiver.kernel.org>; Sun,  1 Jan 2023 05:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjAAFQY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 1 Jan 2023 00:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjAAFQW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 1 Jan 2023 00:16:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B533BB19
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 21:16:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA3760D3C
        for <rcu@vger.kernel.org>; Sun,  1 Jan 2023 05:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1B1C433D2;
        Sun,  1 Jan 2023 05:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672550180;
        bh=1jdAAJEOdAl+66+MUUX1n7n+5MefOZ8leVz2LINommg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CWKYcbBiNRlSFarMWiRXTdSDEAujmXV0Htx/YXXSfMPpoD89zmAkkoz1vtYG1wxaJ
         /wSeoNtfoImpaCY3M9W6is/uXSYhEDqA1afCMi+vYiCZev+ktOsnp50m3v1CcafhMf
         6n1zoBao7xeChlaiK8TfRsqSv7VBtsYqX7XWUiywPiBJfpVR3d41JFcWCdeKtYh1gW
         BDbk8rolgAd3XANuoxeJNBRBKJRuGlDPIW47eQZEXW0FST/YWrt9CvQkJoE78cNGbR
         OgIkfr1pmJUteVGb14FZvyRblMG3I6WMIjqRu6ai4pD7Ge61+Qvd40mUTRqxWmSd5c
         Cd2SvxbjUYA4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 40DE15C0A59; Sat, 31 Dec 2022 21:16:20 -0800 (PST)
Date:   Sat, 31 Dec 2022 21:16:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
Message-ID: <20230101051620.GZ4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YStxQFB1qRyHhqFE_hjeO2f+_U-=KY07SewM0LHWv2Q+g@mail.gmail.com>
 <20221231160755.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQQphezde-o4OrzUSr42BFd-gtcJ6V9d5WG5aXVDU8VxA@mail.gmail.com>
 <20221231164650.GU4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YT9dAUc69igExbL0OC4C_Re58uvQ=oa3s2CQZ_xbefMQQ@mail.gmail.com>
 <CAEXW_YTwH-XyxWq3gNRo-xBxPEH-gYLjQt+aGp81TFGwuYsGtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTwH-XyxWq3gNRo-xBxPEH-gYLjQt+aGp81TFGwuYsGtA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Dec 31, 2022 at 06:10:40PM -0500, Joel Fernandes wrote:
> On Sat, Dec 31, 2022 at 4:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Sat, Dec 31, 2022 at 11:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > > Hmmm...  Some of the tasks run at relatively high priority.  Maybe they
> > > need to de-prioritize themselves before looping waiting to be stopped.
> > > These loops look like this:
> > >
> > >         while (!kthread_should_stop()) {
> > >                 torture_shutdown_absorb("rcu_torture_boost");
> > >                 schedule_timeout_uninterruptible(1);
> > >         }
> >
> > Yes, it appears this tight loop is live locked with the timer softirq.
> > I am trying a run with higher timeout to see if it helps.
> >
> > >
> > > Or it might be something else...
> >
> > I see that kthread_should_stop() returns false, but
> > torture_must_stop_irq() returns true in the tight while loop mentioned
> > above. So it seems like the shutdown notifier triggered first. I am
> > seeing various "is stopping" messages. However I see no "End-test"
> > messages, which means I think the torture_shutdown_hook() never ran
> > properly, or something. Anyway now I am doing heavy tracing in
> > rcu_torture_cleanup() to see what it is upto. My suspicion is it did
> > not even call torture_stop_kthread() and we are stuck without the
> > kthreads being stopped.
> 
> Now all tests pass always if I do the following change in torture_stopping():
> 
> - schedule_timeout_uninterruptible(1);
> + schedule_timeout_uninterruptible(50);
> 
> Current theory is, the timer softirq preempts the cleanup thread
> before it can call kthread_stop().
> 
> Anyway, let me know if this is an acceptable change (or not). I think
> checking for shutdown state 20 times per seconds instead of 1000 times
> per second is kind of reasonable.

Make that schedule_timeout_uninterruptible(HZ / 20) and sold!

							Thanx, Paul
