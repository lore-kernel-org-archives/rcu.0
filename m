Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46FCC433FE
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 22:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90BD23A1D
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 22:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgLHWFu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:05:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730821AbgLHWFV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 17:05:21 -0500
Date:   Tue, 8 Dec 2020 23:04:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607465080;
        bh=ErtDC9vrunHIHYzpWABrHZxR7UK58ws8tPCk6REcSAY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRwUCz7ogCLiSFwhltdkpyn4GJjCfWl/ezNaNdIAJoVh9O1PX80207/VIdQYorXA2
         z7DrclfD8i2YWZMdRppqfKwMpTr2gYyX99uKgfut1UEdo+1QpVZcTL2PV4iLnqqi+j
         Q0oKP8GEvW58QUlL0cpxCypBt1KWLqjs/V6+95KrSNvXeyWS9ZnQN//cu4yOSUuvuc
         /LBl7vO2Zr/wHVHy5WqSGzFxRlcFTRlGLz6EZLMv/yTqJVFNOVydX/4NbfMjJKn22c
         NkPTlfhByJ98A+NTpI2Qg6swV9i0jTkuoQ4RVccTvocLbJTruXS0vQukswCIY0vQgv
         O4dNKvC1nBoSg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     boqun.feng@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: One potential issue with concurrent execution of RCU callbacks...
Message-ID: <20201208220438.GC3916@lothringen>
References: <20201208145810.GA4875@paulmck-ThinkPad-P72>
 <20201208155457.GA3916@lothringen>
 <20201208171927.GS2657@paulmck-ThinkPad-P72>
 <20201208175230.GB3916@lothringen>
 <20201208182409.GT2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208182409.GT2657@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 08, 2020 at 10:24:09AM -0800, Paul E. McKenney wrote:
> > It reduces the code scope running with BH disabled.
> > Also narrowing down helps to understand what it actually protects.
> 
> I thought that you would call out unnecessarily delaying other softirq
> handlers.  ;-)
> 
> But if such delays are a problem (and they might well be), then to
> avoid them on non-rcu_nocb CPUs would instead/also require changing the
> early-exit checks to check for other pending softirqs to the existing
> checks involving time, need_resched, and idle.  At which point, entering and
> exiting BH-disabled again doesn't help, other than your point about the
> difference in BH-disabled scopes on rcu_nocb and non-rcu_nocb CPUs.

Wise observation!

> 
> Would it make sense to exit rcu_do_batch() if more than some amount
> of time had elapsed and there was some non-RCU softirq pending?
> 
> My guess is that the current tlimit checks in rcu_do_batch() make this
> unnecessary.

Right and nobody has complained about it so far.

But I should add a comment explaining the reason for the BH-disabled
section in my series.

Thanks.

> 
> Thoughts?
> 
> 							Thanx, Paul
