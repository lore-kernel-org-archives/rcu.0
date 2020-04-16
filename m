Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD403C2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 19:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D2F221F9
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 19:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587066809;
	bh=z0LrFy9BEDmOvS/lPZHJTKdhqeIFrsRM113gV9Z8kQk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=gadDjCaoX5T1lKeL2xFKRyqtx8/mXmGlnmuKBiihu7BpiK318DljZOsD51HNzoMId
	 rb3aQFBVx67gI0ycabKDbr9yKBdfoepR4cTbspNrynY9+fFqTvvmeNXTOuXk5Zxthy
	 zCaqDrxjWxG7CPchZsEFMIxlEqQq9FPWwPkcak+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgDPTx3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 15:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727886AbgDPTx1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 15:53:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E0420786;
        Thu, 16 Apr 2020 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587066807;
        bh=z0LrFy9BEDmOvS/lPZHJTKdhqeIFrsRM113gV9Z8kQk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=2Ncw2sCIOCy9VS8DtLP0agYinsPQMA9cWCKUVgSq6SWZpRe+WVgKstdpiFVGz6S5R
         QJxNM8eJYtpWC5bizU7yXfQdMiffEHbiXEm6wKrE7QJE0THOzHXWHvpla+CLybW6Az
         vHmi4dtTT6lakFrasDk67bHqkRm1KxPQ/7gb7l7s=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 214EF3522859; Thu, 16 Apr 2020 12:53:27 -0700 (PDT)
Date:   Thu, 16 Apr 2020 12:53:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416195327.GW17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416151824.a372pdiphube3x3l@linutronix.de>
 <20200416184112.GA149999@google.com>
 <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416152623.48125628@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 03:26:23PM -0400, Steven Rostedt wrote:
> On Thu, 16 Apr 2020 14:59:34 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > But, then will it be safe for kfree_rcu() callers from hard IRQ context to
> > call this in PREEMPT_RT? That could would just break then as you cannot sleep
> > in hard IRQ context even on PREEMPT_RT.
> 
> But where in PREEMPT_RT would it be called in hard IRQ context?

I believe that call_rcu() is invoked with raw spinlocks held, so we should
allow kfree_rcu() to be invoked from similar contexts.  It obviously
cannot allocate memory in such contexts, so perhaps the rule is that
single-argument kfree_rcu() cannot be invoked within hard IRQ contexts
or with raw spinlocks held.  In those contexts, you would instead need
to invoke two-argument kfree_rcu(), which never needs to allocate memory.

Seem reasonable?

							Thanx, Paul

> Note, most interrupt handlers in PREEMPT_RT are turned into threads (except
> for a very few, which shouldn't be calling kfree_rcu()).
> 
> -- Steve
