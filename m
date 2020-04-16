Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEACC2BA2B
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F578221F7
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587070859;
	bh=cHvhCqD83KcQJWhHWAUoO3IOfqNoyyUNTuzFi2Joi4M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=mIbMMzGWBiViXFrd9QO/ebDlY2tJwnX8WUrNLw6Jz3UOAEb5N8Xf6eFoAJ8vqV/2f
	 OASXGV9GPUltDVDTny2xUzTAnq1KerDZYdOdQUiaKA47X3jXFXA4uoqYOa0g/1lfng
	 oJHNzq/qHYSZwqWEpT/h0q0TR0hdMzC/YJXf5jZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgDPVA7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgDPVA6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 17:00:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1439F2076D;
        Thu, 16 Apr 2020 21:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587070858;
        bh=cHvhCqD83KcQJWhHWAUoO3IOfqNoyyUNTuzFi2Joi4M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gLSupjA6Bz8ke0/sUL/rdpY6QBy4Iun4tpOWN+caRiMJcIBEoa7nwhE7MkAfyiGdG
         0qSTIMZRi5ApZfbUvCjkay5biQufRfAKRcO5FQMTobyRBNv0BmGmlYwGp8kV+dt78g
         hjFM8TSn9YDzrws+9Ldi9m9YbbtkjlN6XKLhwClA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D540E3522859; Thu, 16 Apr 2020 14:00:57 -0700 (PDT)
Date:   Thu, 16 Apr 2020 14:00:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416210057.GY17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416151824.a372pdiphube3x3l@linutronix.de>
 <20200416184112.GA149999@google.com>
 <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
 <20200416203637.GA176663@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416203637.GA176663@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 04:36:37PM -0400, Joel Fernandes wrote:
> On Thu, Apr 16, 2020 at 03:26:23PM -0400, Steven Rostedt wrote:
> > On Thu, 16 Apr 2020 14:59:34 -0400
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > But, then will it be safe for kfree_rcu() callers from hard IRQ context to
> > > call this in PREEMPT_RT? That could would just break then as you cannot sleep
> > > in hard IRQ context even on PREEMPT_RT.
> > 
> > But where in PREEMPT_RT would it be called in hard IRQ context?
> 
> I am not saying that it is called now, but in the future if it is called for
> an interrupt that is not threaded on -rt, it would be a problem right?
> 
> > Note, most interrupt handlers in PREEMPT_RT are turned into threads (except
> > for a very few, which shouldn't be calling kfree_rcu()).
> 
> Yes those very few is what I was referring to. It also sounds like from the
> other thread, Paul is saying it should be allowed to be called from some
> contexts that are not sleepable. In those cases also the rtmutex will fall
> apart.

We might need different calling-context restrictions for the two variants
of kfree_rcu().  And we might need to come up with some sort of lockdep
check for "safe to use normal spinlock in -rt".

							Thanx, Paul
