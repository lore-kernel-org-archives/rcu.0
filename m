Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D56EC433F5
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 17:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5666C60C40
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 17:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349705AbhIPRn2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Sep 2021 13:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355630AbhIPRlx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Sep 2021 13:41:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF70361A89;
        Thu, 16 Sep 2021 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631811204;
        bh=44P1ANeIAD9swC18fBnaZOjVI5kO3dW9XWUbhixKd10=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OFlD1ELi/aKDiS+3aLndNJJb7vlkstd0PA+w+ndcU2iUgoyqvR31Ii/T8ooimo/Iy
         5BMjedmvQiepbsxnpVlPavnluEyt6yABTvWdWYQROLOijC/xsKGt6A5NEfwc6PVyeo
         2k2jcO/aSExftl32ZMZJUv8BRAAbaLBcTD8PALpJq+NjlvMu+Sym+8Y7Zbe572AZBI
         Mbb/lUa7x+/gtvDDjchIrWVv9Jgno4mXMRskQQOidloE+XiaZvHCneY3vL6PdShZsw
         1EnXPOWBGxSkGsOwHU92oIiEDRhenIeWKjMpUsgIJepDHg32QGotIweM49IcW5CGRG
         Iwmn5wUH26IIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A194C5C02AB; Thu, 16 Sep 2021 09:53:24 -0700 (PDT)
Date:   Thu, 16 Sep 2021 09:53:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH rcu 11/14] rcu: Make rcu_normal_after_boot writable again
Message-ID: <20210916165324.GG4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
 <20210915233343.3906738-11-paulmck@kernel.org>
 <YULyiT+RbAgHxO7u@hirez.programming.kicks-ass.net>
 <20210916135712.GB4156@paulmck-ThinkPad-P17-Gen-1>
 <YUNUQ564PKq9wtTF@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUNUQ564PKq9wtTF@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 16, 2021 at 04:27:15PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 16, 2021 at 06:57:12AM -0700, Paul E. McKenney wrote:
> > RT systems they avoid expedited grace periods by booting with either
> > the rcupdate.rcu_normal or the rcupdate.rcu_normal_after_boot kernel
> > boot parameters.  And here is the definition for the latter:
> > 
> > static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
> > 
> > In other words, RT systems shut off expedited grace periods by default,
> > and are thus free to use nohz_full CPU or not, as they choose.  When using
> > nohz_full, they can also enable expedited grace periods by booting with
> > rcupdate.rcu_normal_after_boot=0.  Or not, sysadm's choice.
> > 
> > So I am not seeing a problem here.  What am I missing?
> 
> That wasn't at all clear to me from the Changelog. I thought it was
> enabling expedited crud for RT.

This paragraph of the current commit log covers that point:

	Make rcupdate.rcu_normal_after_boot= again writeable on RT (if
	NO_HZ_ FULL is defined), but keep its default value to 1 (enabled)
	to avoid regressions. Users who need synchronize_rcu_expedited()
	will boot with rcupdate.rcu_normal_after_ boot=0 in the kernel
	cmdline.

Does that cover it from your viewpoint?  If not, any suggested changes
for clarification?

							Thanx, Paul
