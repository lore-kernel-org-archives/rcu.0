Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11FBC4338F
	for <rcu@archiver.kernel.org>; Thu, 22 Jul 2021 20:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71EE60EB1
	for <rcu@archiver.kernel.org>; Thu, 22 Jul 2021 20:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhGVUAh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhGVUAh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Jul 2021 16:00:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B145E60EB1;
        Thu, 22 Jul 2021 20:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626986471;
        bh=lVNSeYr3HesrTb5wbVHbOq1WnfObOU2wuAZBV2A+B/Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XIQa3ld5y1lOmaL2jUCG7j3727tRd7yMyXY8OC+Q+7D2sevwlQ2V2oiy+SXfbHTdg
         nODF7sPtoNoLDHIAS4a5RVYdUUipNhFq4w6XcUosEXFyUQdF2vcYOFOUt6TuKqUwbm
         J1nJjbo5+i6i0pqfmCS/N6DZ5TvUxV6V7aiprOFF7Bm7X8vAlhBVrh71Efs87irEhD
         YTLc6vaBAteRCx31WSIeRX9rLyJxxJ706LJSuLqaOjaEZwO9UjEvseC504N2eX1oXs
         TKx2/m+9DO6bx7izwhi84JDZBgs0KAJMWwwgXZj2W75tBZY+DqhEz2LkQwoSzY4q3J
         jW4HhhXQRHKTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 81CA35C0293; Thu, 22 Jul 2021 13:41:11 -0700 (PDT)
Date:   Thu, 22 Jul 2021 13:41:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     donghai qiao <donghai.w.qiao@gmail.com>
Cc:     rcu@vger.kernel.org
Subject: Re: RCU: rcu stall issues and an approach to the fix
Message-ID: <20210722204111.GB4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAOzhvcPb=NMCHCqyDiyWiX9DjR=RXgdQRfJDkJOdazugHe7+Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzhvcPb=NMCHCqyDiyWiX9DjR=RXgdQRfJDkJOdazugHe7+Zw@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 22, 2021 at 04:08:06PM -0400, donghai qiao wrote:
> RCU experts,
> 
> When you reply, please also keep me CC'ed.
> 
> The problem of RCU stall might be an old problem and it can happen quite often.
> As I have observed, when the problem occurs,  at least one CPU in the system
> on which its rdp->gp_seq falls behind others by 4 (qs).
> 
> e.g.  On CPU 0, rdp->gp_seq = 0x13889d, but on other CPUs, their
> rdp->gp_seq = 0x1388a1.

CPUs that are idle for long periods of time can fall back much farther.
I have seen systems with CPUs having rdp->gp_seq thousands of grace
periods behind.  So yes, this can happen when there are RCU CPU stall
warnings, but it can also happen other ways.

> Because RCU stall issues can last a long period of time, the number of callbacks
> in the list rdp->cblist of all CPUs can accumulate to thousands. In
> the worst case,
> it triggers panic.

That is quite true.

> When looking into the problem further, I'd think the problem is related to the
> Linux scheduler. When the RCU core detects the stall on a CPU, rcu_gp_kthread
> would send a rescheduling request via send_IPI to that CPU to try to force a
> context switch to make some progress. However, at least one situation can fail
> this effort, which is when the CPU is running a user thread and it is the only
> user thread in the rq, then this attempted context switching will not happen
> immediately. In particular if the system is also configured with NOHZ_FULL for
> the CPU and as long as the user thread is running, the forced context
> switch will
> never happen unless the user thread volunteers to yield the CPU. I think this
> should be one of the major root causes of these RCU stall issues. Even if
> NOHZ_FULL is not configured, there will be at least 1 tick delay which can
> affect the realtime kernel, by the way.
> 
> But it seems not a good idea to craft a fix from the scheduler side because
> this has to invalidate some existing scheduling optimizations. The current
> scheduler is deliberately optimized to avoid such context switching.  So my
> question is why the RCU core cannot effectively update qs for the stalled CPU
> when it detects that the stalled CPU is running a user thread?  The reason
> is pretty obvious because when a CPU is running a user thread, it must not
> be in any kernel read-side critical sections. So it should be safe to close
> its current RCU grace period on this CPU. Also, with this approach we can make
> RCU work more efficiently than the approach of context switch which needs to
> go through an IPI interrupt and the destination CPU needs to wake up its
> ksoftirqd or wait for the next scheduling cycle.
> 
> If my suggested approach makes sense, I can go ahead to fix it that way.

If you have not yet read through Documentation/RCU/stallwarn.rst,
please do so.  There are many potential underlying causes of RCU CPU
stall warnings, most of which are simply bugs that need to be fixed.
One common example bug is a very long in-kernel loop that is missing
a cond_resched() -- it is after all hard to provide 500-millisecond
response time when your kernel has a 21-second tight loop.

Now, if you are seeing RCU CPU stall warnings for no apparent reason,
let's take a look and find root cause.

							Thanx, Paul
