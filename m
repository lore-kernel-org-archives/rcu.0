Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8CFC4361B
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 00:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C109523A79
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 00:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbgLIADr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 19:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730770AbgLIADr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 19:03:47 -0500
Date:   Tue, 8 Dec 2020 16:03:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607472186;
        bh=tsbHTtA1h77+5t5JMRQdlcl1i8nDNeuMrZZuZvaqp8g=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JUnC0OYLB2rkwXp2OGatU0Ye3o9J/VcmTbWGVYikCuUnvICd+mp2HvbsscjACo9XH
         EiODDj6tpOwtwE0nEVcrVb1fJZ8CUUc8IxFW4eQBiDS5eg3tix2XGUijpDglbhqjRN
         u1AXMizC28yrwwm1aHNs5O09EkRv8Bhw/05ZUtZygQhXk0Z8Awcsya8MSx6vD2hAN2
         ZdWRjs7//SxQCXQMmuZ1LLA0qv5mY6ePx9/3Z4sWo5fF0xIJMqDGdvv1sXlEKR8iO9
         u6qvIO2VO2fe1T/sWj6dZshW254gbiEnbJXWQ8kZH9TWYyC1VR8I8iSMFEOhoERiTp
         8zR3qJupSat/g==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     boqun.feng@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: One potential issue with concurrent execution of RCU callbacks...
Message-ID: <20201209000306.GZ2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201208145810.GA4875@paulmck-ThinkPad-P72>
 <20201208155457.GA3916@lothringen>
 <20201208171927.GS2657@paulmck-ThinkPad-P72>
 <20201208175230.GB3916@lothringen>
 <20201208182409.GT2657@paulmck-ThinkPad-P72>
 <20201208220438.GC3916@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208220438.GC3916@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 08, 2020 at 11:04:38PM +0100, Frederic Weisbecker wrote:
> On Tue, Dec 08, 2020 at 10:24:09AM -0800, Paul E. McKenney wrote:
> > > It reduces the code scope running with BH disabled.
> > > Also narrowing down helps to understand what it actually protects.
> > 
> > I thought that you would call out unnecessarily delaying other softirq
> > handlers.  ;-)
> > 
> > But if such delays are a problem (and they might well be), then to
> > avoid them on non-rcu_nocb CPUs would instead/also require changing the
> > early-exit checks to check for other pending softirqs to the existing
> > checks involving time, need_resched, and idle.  At which point, entering and
> > exiting BH-disabled again doesn't help, other than your point about the
> > difference in BH-disabled scopes on rcu_nocb and non-rcu_nocb CPUs.
> 
> Wise observation!
> 
> > Would it make sense to exit rcu_do_batch() if more than some amount
> > of time had elapsed and there was some non-RCU softirq pending?
> > 
> > My guess is that the current tlimit checks in rcu_do_batch() make this
> > unnecessary.
> 
> Right and nobody has complained about it so far.

If they did, my thought would be to add another early-exit check,
but under the tlimit check, so that pending non-RCU softirqs might
set a shorter time limit.  For example, instead of allowing up to the
current one second in rcu_do_batch(), allow only up to 100 milliseconds
or whatever.  But there are lots of choices, which is one reason to wait
until it becomes a problem.

> But I should add a comment explaining the reason for the BH-disabled
> section in my series.

That sounds like a most excellent idea, please do!

							Thanx, Paul
