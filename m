Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D18C19F2D
	for <rcu@archiver.kernel.org>; Thu,  4 Aug 2022 16:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiHDQah (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbiHDQad (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 4 Aug 2022 12:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A571EAC2
        for <rcu@vger.kernel.org>; Thu,  4 Aug 2022 09:30:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51EF6614A2
        for <rcu@vger.kernel.org>; Thu,  4 Aug 2022 16:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B204AC433C1;
        Thu,  4 Aug 2022 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659630631;
        bh=2qJvKa/DAnim17dU0p2FjK/IObDezT47GIOooZthgFs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NdKrVmq9GhIINWbzYRXhfw3s4DUi5f6HccJHsQHO3zmWsL1Qb6QYKRQVg+dfNaTu/
         kwRDKDWSKhULQODd6s0uZ3/cRPO9R0WzvOJ9qrIVdji6w+LMbVpV+aUIDmdUA1C49R
         Er6n5MACuXOWSQrXmECxY20+ysElPj+hYRSurLgtOYUM/01wOebwH3OyPWrCOcMflf
         phMOa3rvHRxyheo1pxsTfqBqavJ8YnjtGa3DWDzgrD/yOL5VEtcBikK/lUAMmZcnV4
         CiBQVj+XbccMS7vlMNb66JmXdB4LCBqJ4KpRohmcXnhGEF3OlTEcA0NkZOdMZBQD/5
         PQvfLRU5kUQsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4E9295C04D0; Thu,  4 Aug 2022 09:30:31 -0700 (PDT)
Date:   Thu, 4 Aug 2022 09:30:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     rcu@vger.kernel.org
Subject: Re: Incomplete RCU stall splats ... Why?
Message-ID: <20220804163031.GO2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1d469564-2ea0-d450-7d07-8d48a2686a06@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d469564-2ea0-d450-7d07-8d48a2686a06@arm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 04, 2022 at 04:54:14PM +0200, Dietmar Eggemann wrote:
> Hi Paul,

Adding the rcu list on CC in case someone with more ARM experience
than I have has additional insights.

> one of my colleagues here in Arm approached me with an RCU stall issue
> on `5.4.0-66 Low Latency (Ubuntu)` (on Arm64 Ampere Altra server) he
> gets when he tries to bring-up a network card for which he only has the
> binary module for this kernel version. I tried to help him understanding
> it but after checking all the kernel config switches and studying the
> RCU code we still haven't found the culprit here. I was hoping you can
> give us some advice on this matter.

Do other kernel versions work better?  If so, I suggest manually forcing
an RCU CPU stall warning and bisecting.  (But you knew that already!)

> (1) What he gets when he launches the card is:
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [15766.032270] rcu: 0-...0: (2 GPs behind) idle=866/0/0x1 softirq=109892/109892 fqs=7186
> [15766.040260] rcu: 7-...0: (51 ticks this GP) idle=bc6/1/0x4000000000000000 softirq=7973/7975 fqs=7187
> [15766.049552] rcu: 19-...0: (18 ticks this GP) idle=842/1/0x4000000000000000 softirq=1289/1289 fqs=7187
> [15766.058931] rcu: 33-...0: (1 GPs behind) idle=36e/1/0x4000000000000000 softirq=132936/132936 fqs=7187
> [15766.068309] rcu: 37-...0: (2 GPs behind) idle=c86/0/0x1 softirq=117951/117951 fqs=7187
> 
> w/o any task or stack information (1a). Even the line:
> 
> [    X.XXXXXX] (detected by X, t=XXX jiffies, g=XXX, q=XX)
> 
> is missing (1b).

I never have seen this, aside from the usual printk() messages being
lost due to overrunning the console device.  But then you will at least
sometimes get messages saying that output was lost.

> (2) He got only one time:
> 
> [ 1631.488289] rcu: rcu_sched kthread starved for 26711 jiffies! g26057 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=77

The above line is important.  If you don't allow the rcu_sched kthread to
run, RCU is very limited in what it can do for you.  In this particular
case, the rcu_sched kthread is trying to sleep for a few jiffies, but
was never awoken.  This is often due to timer issues.

And if it is timer issues, perhaps that is behind the lost printk()
messages.

> [ 1631.498709] rcu: RCU grace-period kthread stack dump: (0)
> 
> But also w/o the stack dump.

If this was a CPU rather that a kthread being dumped, I would suggest
that the target CPU was idle.  Of course, that usually results in a
line stating that the stack dump was omitted because the CPU was idle.

Your point about "try_get_task_stack()" below is a good one, though.

> ---
> 
> (1) print_other_cpu_stall()
>       print_cpu_stall_info(cpu) <-- works fine but
> 
> (1b) print_other_cpu_stall()
>        pr_cont("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n", )
>        -- is not there? and
> 
> (1a) print_other_cpu_stall()
>        if (ndetected)
>          rcu_dump_cpu_stacks() 
>            ...
>            dump_cpu_task(cpu)
>            -- doesn't print anything even though ndetected must be > 0

Keying off of the ndetected, if you were running a preemptible kernel
(which you are not, see the "rcu_sched" above), I would suggest
backporting this commit:

e6a901a44f76 ("rcu: Fix to include first blocked task in stall warning")

> (2) I can see that no stack dump happens if we can't get the task stack.
> 
> rcu_check_gp_kthread_starvation()
> 
>   pr_err("RCU grace-period kthread stack dump:\n");
>   sched_show_task(gpk);
> 
>     if (!try_get_task_stack(p))
>       return;
> 
> So I can see why under (2) he doesn't get the stack dump but I can't
> see why he ends up w/o any task or stack information and w/o the
> `detected by X` line under (1)?

That surprises me as well.

> In case I play with RCU and try to provoke a stall I always get the
> information from (1) and (2).

Which is what I see.

> My question now is how can this happen and is there a way to convince
> the system to hand out the missing information?
> Other folks were suggesting to use kdump kernel w/ panic_on_rcu_stall=1
> and then use the crash tool. I haven't use this so far.

That makes a lot of sense to me!

You could then look through the rcu_state data structure, including
the rcu_state.node[] array to see what is stalling the grace period.

> I was hoping you can shed some light on this issue.

Another possibility would be to set hbreak breakpoints in gdb.

> Many thanks in advance!

Too much fun!  ;-)

							Thanx, Paul
