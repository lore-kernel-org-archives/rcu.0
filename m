Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C580DC07E95
	for <rcu@archiver.kernel.org>; Tue, 13 Jul 2021 13:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A251D60FF1
	for <rcu@archiver.kernel.org>; Tue, 13 Jul 2021 13:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhGMNVD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Jul 2021 09:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236283AbhGMNVC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Jul 2021 09:21:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7E55610CB;
        Tue, 13 Jul 2021 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626182292;
        bh=mFHtavYuxH/fzZeLZE9LpQ1vHGSC7cR2ChXAS4fuTdY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FGAUcSTsoovKJpqn+ri4tnppV6LUKAzI2SIBBAQxCPJZGWpCnr2c9lLcrr1WQSdeD
         Vk+xRvf2oiQ2tEenuGCh72Kk49V/6SEbw1Fd5qC6OMHkURw9TVOhG4Phl2JmhhDVjE
         JjJzR0o2E/hb3duKTEGTf7KohoofaYBWrN66Emi1Vx3ZQLb7p4Iy4ZBO6Ydv/a2zUS
         8DkC5aBHa4LoyiNP3MdBCKkP9YxJTbhale7JPxNjilZkz1qmpkG8yo6ndKio7Gs9Th
         zfCB/AYn962204rsgH6uxJMshfsqYz5hjPJyUS81a/hswneBolkLA2d6oJCvLablVq
         ix60g8+kJ9RvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B7C2D5C0367; Tue, 13 Jul 2021 06:18:12 -0700 (PDT)
Date:   Tue, 13 Jul 2021 06:18:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     zhouzhouyi@gmail.com, Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
Message-ID: <20210713131812.GV4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210713005645.8565-1-zhouzhouyi@gmail.com>
 <20210713041607.GU4397@paulmck-ThinkPad-P17-Gen-1>
 <520385500.15226.1626181744332.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <520385500.15226.1626181744332.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 13, 2021 at 09:09:04AM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 13, 2021, at 12:16 AM, paulmck paulmck@kernel.org wrote:
> 
> > On Tue, Jul 13, 2021 at 08:56:45AM +0800, zhouzhouyi@gmail.com wrote:
> >> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >> 
> >> Hi Paul,
> >> 
> >> During my studying of RCU, I did a grep in the kernel source tree.
> >> I found there are 3 places where the macro name CONFIG_TASKS_RCU_TRACE
> >> should be CONFIG_TASKS_TRACE_RCU instead.
> >> 
> >> Without memory fencing, the idle/userspace task inspection may not
> >> be so accurate.
> >> 
> >> Thanks for your constant encouragement for my studying.
> >> 
> >> Best Wishes
> >> Zhouyi
> >> 
> >> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > 
> > Good eyes, and those could cause real bugs, so thank you!
> 
> Hi Paul,
> 
> This makes me wonder: what is missing testing-wise in rcutorture to
> catch those issues with testing before they reach mainline ?

My guess:  Running on weakly ordered architectures.  ;-)

							Thanx, Paul
