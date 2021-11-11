Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA68C433F5
	for <rcu@archiver.kernel.org>; Thu, 11 Nov 2021 00:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2900C61247
	for <rcu@archiver.kernel.org>; Thu, 11 Nov 2021 00:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhKKALt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:11:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234285AbhKKALt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 Nov 2021 19:11:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7B8D6103C;
        Thu, 11 Nov 2021 00:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636589340;
        bh=v+NyK5maH0Zq1WEqTfD47eXM/F383z8TNC+eQNyTHR0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KyFE6Bi+GdRuBhoAN0QbU0AtXjSyVR/VZoq3gFRrR6WXOagzT8Ib52/pjsbjVsXFI
         ErT4XdBD90CmLQTSj12qNITtEQ49w+IzqBtCg42VS7pZv4j9Ehdg1bItiRFaBNHoRG
         FTcAPsMtdYnz8kJobbLOX25JWKP7JwrC2U42LbCeTNa/rgXpqG7CM45jA4SvGIA6yI
         6PsEdnq0fv35EpUA6Y3Bw4PTL9Az+HqvPnkUdDNeeiE1eCWhut+KsJdRIEkq6BKkLN
         TTaktwqz6iJW9HMar4o3MFSAiW2VpyuUIGiJpuIFTiS3PKA/LqfMwLzqP/shM5uORt
         XMysyL863Y1TA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6418D5C0A70; Wed, 10 Nov 2021 16:09:00 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:09:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:TORTURE-TEST MODULES" <linux-kernel@vger.kernel.org>,
        "open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] rcutorture: Avoid soft lockup during cpu stall
Message-ID: <20211111000900.GI641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211110143745.468361-1-wander@redhat.com>
 <20211110143745.468361-2-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110143745.468361-2-wander@redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 10, 2021 at 11:37:45AM -0300, Wander Lairson Costa wrote:
> If we use the module stall_cpu option, we may get a soft lockup warning
> in case we also don't pass the stall_cpu_block option.
> 
> Introduce the stall_no_softlockup option to avoid a soft lockup on
> cpu stall even if we don't use the stall_cpu_block option.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Queued for review and further testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 36a273589a35..bc854f935548 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -46,6 +46,7 @@
>  #include <linux/oom.h>
>  #include <linux/tick.h>
>  #include <linux/rcupdate_trace.h>
> +#include <linux/nmi.h>
>  
>  #include "rcu.h"
>  
> @@ -112,6 +113,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
>  torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
>  torture_param(int, stall_cpu_holdoff, 10,
>  	     "Time to wait before starting stall (s).");
> +torture_param(bool, stall_no_softlockup, false,
> +	     "Avoid softlockup warning during cpu stall.");
>  torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
>  torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
>  torture_param(int, stall_gp_kthread, 0,
> @@ -2085,6 +2088,8 @@ static int rcu_torture_stall(void *args)
>  #else
>  				schedule_timeout_uninterruptible(HZ);
>  #endif
> +			} else if (stall_no_softlockup) {
> +				touch_softlockup_watchdog();
>  			}
>  		if (stall_cpu_irqsoff)
>  			local_irq_enable();
> -- 
> 2.27.0
> 
