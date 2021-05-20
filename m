Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BB5C433B4
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 14:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EEE61244
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 14:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhETOyk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 20 May 2021 10:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231418AbhETOyj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 20 May 2021 10:54:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40447611ED;
        Thu, 20 May 2021 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621522398;
        bh=zVOXEq4PpxdP/GDV+JOkW9i/z2WKjL9VqOVhutGb1E8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ovq7yVud0KeKKV/kyc6Amr+6H0oQam7AMS50agJV03rzqMXDV1or7l9t+KQed3yqj
         gkuUz2tmgTTA8uqq3JF5cTNAQJFZSfgdxsfvzukBKYIzAFixE+NmFEIQbHODOUJ86+
         g2mkXXsUP9xv/eAebDrIgL9DgIQwC3z3xp7VSxKmUuovSYwG44jPAtFcHBB7HWld3x
         TThcxb6vv6vBL1FqUs9X6GNM5Prf1igSaiAt6gae1OGM9GlSAGRhBPbXJa2pNay8sU
         GGTeEQwppzyIH0avDWuIsrR93lQ8NSG4s1lnHJCmEdubMt95S70h7lhFutMwQ/yq3a
         Odfnschgdj2yQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0D3095C00D8; Thu, 20 May 2021 07:53:18 -0700 (PDT)
Date:   Thu, 20 May 2021 07:53:18 -0700
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
Message-ID: <20210520145318.GJ4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
 <YKMbQQ0qBAixXC5p@google.com>
 <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
 <YKX/H0EwRRLM+cAa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKX/H0EwRRLM+cAa@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 20, 2021 at 03:18:07PM +0900, Sergey Senozhatsky wrote:
> On (21/05/18 16:15), Paul E. McKenney wrote:
> > 
> > In the shorter term...  PVCLOCK_GUEST_STOPPED is mostly for things like
> > guest migration and debugger breakpoints, correct?  Either way, I am
> > wondering if rcu_cpu_stall_reset() should take a lighter touch.  Right
> > now, it effectively disables all stalls for the current grace period.
> > Why not make it restart the stall timeout when the stoppage is detected?
> 
> rcu_cpu_stall_reset() is used in many other places, not sure if we can
> change its behaviour rcu_cpu_stall_reset().

There was some use case back in the day where they wanted an indefinite
suppression of RCU CPU stall warnings for the current grace period, but
all the current use cases look fine with restarting the stall timeout.

However, please see below.

> Maybe it'll be possible to just stop calling it from PV-clock and do
> something like this

This was in fact one of the things I was considering, at least until
I convinced myself that I needed to ask some questions.

One point of possibly unnecessary nervousness on my part is resetting
the start of the grace period, which might confuse diagnostics.

But how about something like this?

void rcu_cpu_stall_reset(void)
{
	WRITE_ONCE(rcu_state.jiffies_stall,
		   jiffies + rcu_jiffies_till_stall_check());
}

Would something like that work?

(One issue with this is if there has already been an RCU CPU stall
warning, in which case the timeout for repeat warnings is tripled.  But in
the current use cases, I don't see that this matters.  If it turns out to
matter, I would just add a flag to rcu_state saying whether the current
grace period had seen a stall, and use that to decide whether or not
to triple the timeout.)

							Thanx, Paul

> ---
> 
> diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
> index eda37df016f0..2d2489eda8e6 100644
> --- a/arch/x86/kernel/pvclock.c
> +++ b/arch/x86/kernel/pvclock.c
> @@ -40,7 +40,7 @@ void pvclock_touch_watchdogs(void)
>  {
>  	touch_softlockup_watchdog_sync();
>  	clocksource_touch_watchdog();
> -	rcu_cpu_stall_reset();
> +	record_gp_stall_check_time();
>  	reset_hung_task_detector();
>  }
>  
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index cb233c79f0bc..6b3165c7a2c3 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -137,7 +137,7 @@ void rcu_cpu_stall_reset(void)
>  // Interaction with RCU grace periods
>  
>  /* Start of new grace period, so record stall time (and forcing times). */
> -static void record_gp_stall_check_time(void)
> +void record_gp_stall_check_time(void)
>  {
>  	unsigned long j = jiffies;
>  	unsigned long j1;
