Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E844C433F5
	for <rcu@archiver.kernel.org>; Mon,  7 Mar 2022 21:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiCGVzP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242878AbiCGVzL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Mar 2022 16:55:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBCB7E08B
        for <rcu@vger.kernel.org>; Mon,  7 Mar 2022 13:54:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B12D60C50
        for <rcu@vger.kernel.org>; Mon,  7 Mar 2022 21:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE37C340EF;
        Mon,  7 Mar 2022 21:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646690054;
        bh=JU6sw/VDpGWN6h7wN6PTJdevVP5rAJlEA9nTXLfzP6k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Lqs2AhlYJJXneG+BdPTtudpytYH8VdmJySrfb6gwf0D2AQYIkiyuOIA7N134neSa4
         1iLl5ChPdn/GwErAvp6Ao5JrwAv3SeHXmttrDBYPmpXvf6sExNZ6UdprLmbwcHK0XQ
         6K5Xo9/HJKRORw82vjU5SjdZUqZ73DmxssnoHQcdGczaGhBHwHPJV/AALdiiIcu/GI
         EZdVg9mGRHhh8HbUsod4/0KWXYGYsiMHPifpQFkr2NYLE42zg+V6D870hPTgx6tJ/x
         3e8WKyzyxKmaSNagO+vg3VoryLLx1QUfNs9ixzCYOwWDGd4fRiLxbK9VYDXlv7K105
         fruI7ht8Gkg2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 326B35C0260; Mon,  7 Mar 2022 13:54:14 -0800 (PST)
Date:   Mon, 7 Mar 2022 13:54:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu-tasks: Use rcuwait for the rcu_tasks_kthread().
Message-ID: <20220307215414.GP4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
 <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <YiHy7Y5fTU3jRdMi@linutronix.de>
 <20220305044007.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <YiXp4+2atG0Ni2rJ@linutronix.de>
 <20220307150913.GI4285@paulmck-ThinkPad-P17-Gen-1>
 <YiZHp68bPJvLzvhV@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YiZHp68bPJvLzvhV@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 07, 2022 at 06:57:59PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-03-07 07:09:13 [-0800], Paul E. McKenney wrote:
> > > Correct. Possible due to the removal of wait_queue_head (plus there is
> > > nothing else that would stand in the way otherwise).
> > 
> > Very good!
> > 
> > If the overhead becomes a problem in mainline, presumably we can do
> > a compile-time switch based on CONFIG_PREEMPT_RT or similar.
> 
> the rcuwake is a lot cheaper than waitqueue in terms of code or data
> involved, locks, …. The _HARD flag is a nop on !RT.
> So it should be a win-win situation here.

Even better!

> > > > If so, I am wondering if there are other
> > > > irq_work instances that need to move to _HARD.
> > > 
> > > We already have:
> > > kernel/rcu/tree.c:      rdp->rcu_iw = IRQ_WORK_INIT_HARD(rcu_iw_handler);
> > 
> > Because you prompted me to change it from IRQ_WORK_INIT() some time
> > back?  ;-)
> 
> Right. We have printk() for instance using the !HARD irq-work so this
> mostly a case-by-case decision usually avoiding HARD.

Sounds about right.  ;-)

							Thanx, Paul
