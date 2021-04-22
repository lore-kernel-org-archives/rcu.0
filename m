Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B23C433B4
	for <rcu@archiver.kernel.org>; Thu, 22 Apr 2021 16:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EE16140F
	for <rcu@archiver.kernel.org>; Thu, 22 Apr 2021 16:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhDVQDL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Apr 2021 12:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232670AbhDVQDI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Apr 2021 12:03:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD50B61407;
        Thu, 22 Apr 2021 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619107353;
        bh=iwNnBSPocGDcZJFVdLewrFrMqd6F1nTcCY6z8lMaTYY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kfaZvyn+NaG9ZeCXI/KL5fYZZ+kCKKRSP/XCwZRJI0zkYOVZLqtTYeWbwvQedZPeF
         hTmoSR+Yb8bj34NC0dsbf3/6NPV+bvYrrt658CNB0c/nn8rriGixkLnhRt2/3eW/LM
         bGEP/beif57NMExaTKvngW+965RAMGXpH2CYvdT1GAR7j8kscKqU7OMkTvnFm+0qJ6
         PQ4/0+jd30IQc4KPpqzKN9Q/2QY9qCgkzCr2JtngYdIac1zqUkG2RdbVmuOgJKwZOK
         /C2Z0Mfd/EZl2gWZgbyTZ5lKC94ImF3fAoIGZH/qnAdAOMtoF1v4/W2EtQ/W8DUGBt
         5vftP5k//T7Tg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 537655C03C3; Thu, 22 Apr 2021 09:02:33 -0700 (PDT)
Date:   Thu, 22 Apr 2021 09:02:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: RCU stall query
Message-ID: <20210422160233.GF975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <52dabee9-9c00-d9f9-7df2-4ae1dc643349@huawei.com>
 <20210422143552.GE975577@paulmck-ThinkPad-P17-Gen-1>
 <412926e8-d3e1-3071-8cb9-098a7f49b64c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412926e8-d3e1-3071-8cb9-098a7f49b64c@huawei.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 22, 2021 at 04:45:00PM +0100, John Garry wrote:
> On 22/04/2021 15:35, Paul E. McKenney wrote:
> > On Thu, Apr 22, 2021 at 10:20:51AM +0100, John Garry wrote:
> > > Hi RCU experts,
> > > 
> 
> Thanks Paul
> 
> > > Recently I have noticed that I can trigger an RCU stall quite easily on my
> > > system under specific conditions.
> > > 
> > > I have a fair idea why it happens, but need to analyze a proper solution
> > > further. It looks like a hard IRQ handler and threaded part are tied to
> > > specific CPU and getting swamped and not relinquishing.

I should hasten to confirm that saturating a CPU with interrupts can
also result in RCU CPU stall warnings, so please do continue your
efforts fixing this as well.

> > > However, mixed in the RCU splats, I have noticed many BUG logs, like:
> > > 
> > > [  207.788748] BUG: spinlock recursion on CPU#46, fio/1470
> > This is a self-deadlock.  Given that deadlock, and given that spinlocks
> > disable preemption, the RCU CPU stall warnings are expected behavior.
> > After all, your code really is grabbing a CPU by the throat and shaking
> > it indefinitely.
> > 
> > Please build your kernel with CONFIG_PROVE_LOCKING=y and then fix the
> > issues it calls out.  Then please also fix the bugs resulting in the
> > "sleeping function called from invalid context" and in the "scheduling
> > while atomic".
> 
> Here's the rub, the issue goes away with CONFIG_PROVE_LOCKING and all the
> extra debugging it adds. Hmmm.

That can happpen.  You have enough going on that fixing what you already
know about might eventually get things to where CONFIG_PROVE_LOCKING
does something useful to you.

							Thanx, Paul

> But I get the point that these are separate and need to be fixed also.
> 
> > 
> > In addition, there are quite a few idle tasks called out in your list of
> > stalled CPUs.  This is often due to RCU's grace-period kthread (named
> > "rcu_preempt" in this case) not getting any CPU time.  This is not
> > unexpected given the "RT throttling activated".  If you are going to run
> > code at real-time priorities, you must ensure that any number of kernel
> > kthreads get the CPU time that they need.  As Spiderman's uncle said
> > "With great power comes great responsibility".
> 
> OK, I need to check on that separately also.
> 
> Cheers,
> John
