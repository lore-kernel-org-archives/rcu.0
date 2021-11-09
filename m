Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8875EC433EF
	for <rcu@archiver.kernel.org>; Tue,  9 Nov 2021 20:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DED561105
	for <rcu@archiver.kernel.org>; Tue,  9 Nov 2021 20:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244500AbhKIUkD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 9 Nov 2021 15:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244036AbhKIUkC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 9 Nov 2021 15:40:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 293F961078;
        Tue,  9 Nov 2021 20:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636490236;
        bh=KcTbvZLvMYfwboS/njgeGriNrmZIZBb5tP7FgObYEig=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uYW9Yt+lcTOEOoOUtjzlP34PVx8vITGZvDYFU1LlDeHKVvZPZyF9aNy6I9Mylx7WP
         85XdXhxPvAG/Qpvn0fwNew5lEM2dmPEnbAfQejuaxgPV+xVePYfJHoZR7NMCJxr/HI
         WrDAwzc85HItjFmFdCAzPILxDowMojjRQK6lyQSgP/j19ae4HBQgNlMy1ul/PkSUri
         v6YVKVTfUjEe3aD6VfZKEGi1AWKvEAnR6f1slQwDaXpNcUqjiO6IsrTCyEKzE7qZ76
         zgvBa7KiweNNUEc9buO6VJMnOD/bqeBgGTYjW/buyWyDxinhnq80tg5BToAskQ4Prj
         KxI2lXK11d5Ag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EDB2A5C0938; Tue,  9 Nov 2021 12:37:15 -0800 (PST)
Date:   Tue, 9 Nov 2021 12:37:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     wander@redhat.com
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:TORTURE-TEST MODULES" <linux-kernel@vger.kernel.org>,
        "open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>
Subject: Re: [PATCH] rcutorture: Avoid soft lockup during cpu stall
Message-ID: <20211109203715.GW641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211109174602.407644-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109174602.407644-1-wander@redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 09, 2021 at 02:46:02PM -0300, wander@redhat.com wrote:
> From: Wander Lairson Costa <wander@redhat.com>
> 
> If we use the module stall_cpu option, we may get a soft lockup warning
> if we also don't pass the stall_cpu_block option.
> 
> We introduce the stall_no_softlockup option to avoid a soft lockup on
> cpu stall even if we don't use the stall_cpu_block option.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

This looks plausible to me, though it would be good to hear others'
thoughts.  In the meantime, could you please forward-port this to
the "dev" branch of the -rcu tree?

https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcutodo.html

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 40ef5417d954..0a2a9a6533d1 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -10,6 +10,7 @@
>   * See also:  Documentation/RCU/torture.rst
>   */
>  
> +#include "linux/nmi.h"
>  #define pr_fmt(fmt) fmt
>  
>  #include <linux/types.h>
> @@ -109,6 +110,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
>  torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
>  torture_param(int, stall_cpu_holdoff, 10,
>  	     "Time to wait before starting stall (s).");
> +torture_param(bool, stall_no_softlockup, false,
> +	     "Avoid softlockup warning during cpu stall.");
>  torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
>  torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
>  torture_param(int, stall_gp_kthread, 0,
> @@ -2024,6 +2027,8 @@ static int rcu_torture_stall(void *args)
>  				    stop_at))
>  			if (stall_cpu_block)
>  				schedule_timeout_uninterruptible(HZ);
> +			else if (stall_no_softlockup)
> +				touch_softlockup_watchdog();
>  		if (stall_cpu_irqsoff)
>  			local_irq_enable();
>  		else if (!stall_cpu_block)
> -- 
> 2.27.0
> 
