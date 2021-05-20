Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691CBC433ED
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 14:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E73460FE6
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 14:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhETO6b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 20 May 2021 10:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhETO6a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 20 May 2021 10:58:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A35F6611AB;
        Thu, 20 May 2021 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621522628;
        bh=XJvIQDi+saIs1gaAgXqt71w6q3SoD9fvLuWaePm7epQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=O0hwZ8K4fHvWUPfTHtftMmMhpF3nakTR2lbKEnl56XM4vroPiS+ZPaqQgbi57LkAj
         nGWil68koBLiJaH1f3XnLgDx0VGdd+M83mqe284Y+GikFlS2Zpmcbn/C/EC/SVAXcw
         1IR7QRpz3LA0Vz+0eEL2l2zSJJPwuB89AN2xqSaRKvh94uIoGF4k/jeUC8zX92a3Kf
         JsuY7S1azd7fiMM2FFOFMwB9O1mqdhwVcD7tKFKS+e3ZyuCs9aYQzlWMIfKDu6uNnO
         0ng2ZHnY77i+OXc4mF34X9G0fTua/jv7soHm0B4fHIIxvfTKKErWOobXK+gfIzH2c9
         CMjgjzp7KpOAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 690105C00D8; Thu, 20 May 2021 07:57:08 -0700 (PDT)
Date:   Thu, 20 May 2021 07:57:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <20210520145708.GK4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
 <YKMbQQ0qBAixXC5p@google.com>
 <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
 <YKX4ueNIabfd1DAD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKX4ueNIabfd1DAD@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 20, 2021 at 02:50:49PM +0900, Sergey Senozhatsky wrote:
> On (21/05/18 16:15), Paul E. McKenney wrote:
> > 
> > In the shorter term...  PVCLOCK_GUEST_STOPPED is mostly for things like
> > guest migration and debugger breakpoints, correct?
> 
> Our use case is a bit different. We suspend VM when user puts the host
> system into sleep (which can happen multiple times a day).

OK, that is an interesting use case that I don't see.

> > Either way, I am wondering if rcu_cpu_stall_reset() should take a lighter
> > touch.  Right now, it effectively disables all stalls for the current grace
> > period. Why not make it restart the stall timeout when the stoppage is detected?
> 
> Sounds good. I can cook a patch and run some tests.
> Or do you want to send a patch?

Given that you have the test setup, things might go faster if you do
the patch, especially taking timezones into consideration.  Of course,
if you run into difficulties, you know where to find me.

> > The strange thing is that unless something is updating the jiffies counter
> > to make it look like the system was up during the stoppage time interval,
> > there should be no reason to tell RCU anything.  Is the jiffies counter
> > updated in this manner?  (Not seeing it right offhand, but I don't claim
> > to be familiar with this code.)
> 
> VCPUs are not resumed all at once. It's up to the host to schedule VCPUs
> for execution. So, for example, when we resume VCPU-3 and it discovers
> this_cpu PVCLOCK_GUEST_STOPPED, other VCPUs, e.g. VCPU-0, can already be
> resumed, up and running processing timer interrupts and adding ticks to
> jiffies.
> 
> I can reproduce it.
> While VCPU-2 has PVCLOCK_GUEST_STOPPED set (resuming) and is in
> check_cpu_stall(), the VCPU-3 is executing:
> 
> 	apic_timer_interrupt()
> 	 tick_irq_enter()
> 	  tick_do_update_jiffies64()
> 	   do_timer()

OK, but the normal grace period time is way less than one second, and
the stall timeout in mainline is 21 seconds, so that would be a -lot-
of jiffies of skew.  Or does the restarting really take that long a time?

							Thanx, Paul
