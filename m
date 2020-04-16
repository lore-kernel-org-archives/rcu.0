Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216EAC2BA2B
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 20:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE70121BE5
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 20:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587068733;
	bh=Ax1s2+btAiN+vSGF1aYBcHBbwhlqjrzq5iHzB3zx0iM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=mDIud7tulYzPq8PD9MadJy6KUbHynGvMnuXx1LaEthV0PKO+Nk+dR3IoVUBohbyCl
	 dQ3+ul7AYFcBx7DFGiVLlsmxvTBGKoZWa4ZD+kqBTIciqxEB80Ddp3+YoLm9GSgQqQ
	 1cfihuy2hovfyN2MNzMU1M1AcuTFGusYoXwBPSqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgDPUZc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbgDPUZc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 16:25:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BF22076D;
        Thu, 16 Apr 2020 20:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587068731;
        bh=Ax1s2+btAiN+vSGF1aYBcHBbwhlqjrzq5iHzB3zx0iM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kiAqfzSuWI7lEgbkfg8RtUZQJf33jXd2/KL4vYexl9ADwohfpHNWp2c2FduTJaOek
         YInAY+L+/Gff6ZbW60W7flFFsnYSVxzDtHUaKH7RbUJnLI9ltFy2v6nYGOOiSDz7DQ
         Q+/lp5H5V0cYGqFMYjeRMEuP2cW5+jcjj3iI6EQ4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D92E83522859; Thu, 16 Apr 2020 13:25:30 -0700 (PDT)
Date:   Thu, 16 Apr 2020 13:25:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416202530.GX17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416151824.a372pdiphube3x3l@linutronix.de>
 <20200416184112.GA149999@google.com>
 <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
 <20200416195327.GW17661@paulmck-ThinkPad-P72>
 <20200416200557.GA11301@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416200557.GA11301@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 10:05:57PM +0200, Uladzislau Rezki wrote:
> On Thu, Apr 16, 2020 at 12:53:27PM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 16, 2020 at 03:26:23PM -0400, Steven Rostedt wrote:
> > > On Thu, 16 Apr 2020 14:59:34 -0400
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > 
> > > > But, then will it be safe for kfree_rcu() callers from hard IRQ context to
> > > > call this in PREEMPT_RT? That could would just break then as you cannot sleep
> > > > in hard IRQ context even on PREEMPT_RT.
> > > 
> > > But where in PREEMPT_RT would it be called in hard IRQ context?
> > 
> > I believe that call_rcu() is invoked with raw spinlocks held, so we should
> > allow kfree_rcu() to be invoked from similar contexts.  It obviously
> > cannot allocate memory in such contexts, so perhaps the rule is that
> > single-argument kfree_rcu() cannot be invoked within hard IRQ contexts
> > or with raw spinlocks held.  In those contexts, you would instead need
> > to invoke two-argument kfree_rcu(), which never needs to allocate memory.
> > 
> > Seem reasonable?
> > 
> Paul, just to make it more clear, even invoking two arguments fkree_rcu()
> currently does an allocation. We maintain an array that contains pointers
> for "bulk logic". 

True, but that is an optimization rather than an absolute necessity.
In addition, most two-argument kfree_rcu() callers will take another slot
from the array that has already been allocated.  So one alternative is
to do the allocation only if both interrupts and preemption are enabled.
As long as most kfree_rcu() invocations can allocate, you get good
performance and things work nicely in -rt.

Another alternative is to check to see what currently invokes kfree_rcu()
and work out what to do about any that are invoked from an environment
in which -rt does not allow memory allocation.  And deal with future
additions of kfree_rcu() to such environments.

Given that most people don't test -rt, the second alternative has
the potential of handing Sebastian an endless stream of bugs that are
kfree_rcu() usage bugs only in -rt.  But maybe he is OK with that?
(I wouldn't be, but I will let him speak for himself.)

							Thanx, Paul
