Return-Path: <SRS0=nDYm=4R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1345EC3F2CD
	for <rcu@archiver.kernel.org>; Sat, 29 Feb 2020 23:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAD42468D
	for <rcu@archiver.kernel.org>; Sat, 29 Feb 2020 23:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583018536;
	bh=MhtnpVhbsfdUJwoBQol0QJ3dg4S8ndsauk6nOCZjlZI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=mSUUTtZEeJfQLa2eHDyk0dId7eK06F+Y1Zzb3v9PmJiLGf2vtAF+MHeLFD+aVqQQQ
	 06udQ1yVqK0AJuAzJJL7xSFBghP3LNLrWhKYk2aQhiUVxKtYOp3hnMCeemtQWBdYR1
	 ycxjN8x63H/7sHULtrD5Y/Nx/JMZQhs5h4NUjAz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgB2XWQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:22:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgB2XWQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 29 Feb 2020 18:22:16 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91593222C2;
        Sat, 29 Feb 2020 23:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583018535;
        bh=MhtnpVhbsfdUJwoBQol0QJ3dg4S8ndsauk6nOCZjlZI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=G8D1P+Iu+L8sdZywkr2eF1cbF0ysisI1hjgHmywS7eBxCopDTBNfAFGPU6bQyTzRI
         wIOngiaRieyrMRQAh5mkkwKJqYGYz6T0Gobu/JUsZ71QUwTUCfT05oSR+F3zdhjXrk
         IdnjkX9PsV55rOvmXhO+eZet13/2sEm1tzwCMvrc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 59B7E3522719; Sat, 29 Feb 2020 15:22:15 -0800 (PST)
Date:   Sat, 29 Feb 2020 15:22:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: rcu_sched stalls on 4.14
Message-ID: <20200229232215.GN2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAOMZO5CrvxZDuRfBvwLV6uJJwtPuj1-vqoELKP3j15k3TbSjyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5CrvxZDuRfBvwLV6uJJwtPuj1-vqoELKP3j15k3TbSjyg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Feb 29, 2020 at 11:26:08AM -0300, Fabio Estevam wrote:
> Hi Paul,
> 
> An ARM64 i.MX8QXP user reported the following rcu_sched stalls on 4.14.98:
> 
> [55255.673846] INFO: rcu_sched detected stalls on CPUs/tasks:
> [55255.679365]  0-...: (1 GPs behind) idle=74a/2/0
> softirq=311527/311574 fqs=36000
> [55255.686763]  (detected by 1, t=225888 jiffies, g=460, c=459, q=57)
> [55255.692949] Task dump for CPU 0:
> [55255.696182] swapper/0       R  running task        0     0      0 0x00000022
> [55255.703244] Call trace:
> [55255.705708] [<ffff0000080853b4>] __switch_to+0x94/0xd8
> [55282.491408] INFO: rcu_preempt self-detected stall on CPU
> [55282.496747]  0-...: (1 GPs behind) idle=74a/2/0
> softirq=311572/311574 fqs=1676930
> [55282.504319]   (t=8844361 jiffies g=63547 c=63546 q=60986)
> [55282.509725] Task dump for CPU 0:
> [55282.512956] swapper/0       R  running task        0     0      0 0x00000022
> [55282.520018] Call trace:
> [55282.522475] [<ffff0000080892f0>] dump_backtrace+0x0/0x3c8
> [55282.527878] [<ffff0000080896cc>] show_stack+0x14/0x20
> [55282.532933] [<ffff0000080f5164>] sched_show_task+0x14c/0x180
> [55282.538595] [<ffff0000080f60b8>] dump_cpu_task+0x40/0x50
> [55282.543916] [<ffff000008126788>] rcu_dump_cpu_stacks+0x94/0xd4
> [55282.549752] [<ffff00000812554c>] rcu_check_callbacks+0x64c/0x958
> [55282.555764] [<ffff0000081296f4>] update_process_times+0x2c/0x58
> [55282.561692] [<ffff000008138b98>] tick_sched_handle.isra.4+0x30/0x48
> [55282.567961] [<ffff000008138bf0>] tick_sched_timer+0x40/0x90
> [55282.573538] [<ffff00000812a370>] __hrtimer_run_queues+0xe8/0x168
> [55282.579549] [<ffff00000812a5f0>] hrtimer_interrupt+0xa8/0x230
> [55282.585305] [<ffff0000085c70e0>] arch_timer_handler_phys+0x28/0x48
> [55282.591497] [<ffff000008118e50>] handle_percpu_devid_irq+0x80/0x138
> [55282.597767] [<ffff000008113684>] generic_handle_irq+0x24/0x38
> [55282.603518] [<ffff000008113cf4>] __handle_domain_irq+0x5c/0xb8
> [55282.609356] [<ffff000008080fe0>] gic_handle_irq+0x78/0x174
> [55282.614845] Exception stack(0xffff000008003d90 to 0xffff000008003ed0)
> [55282.621292] 3d80:
> 0000000000000000 ffff000008cc5880
> [55282.629129] 3da0: 0000000000000000 00000001004acd07
> 000000000000000f 0000000000000002
> [55282.636966] 3dc0: 444c1236fa69ce5f ffff80003ff60180
> ffff80003a020248 ffff000008003c70
> [55282.644801] 3de0: 00000000960ca760 0000000000000001
> 0000000000000400 ffff0000091ed860
> [55282.652638] 3e00: 0000000000000000 0000000000000000
> ffff00000813d758 0000000000000000
> [55282.660474] 3e20: 0000000000000000 ffff000008b1e000
> 000000000000001a ffff000008cc5880
> [55282.668310] 3e40: ffff000008b1e018 ffff800012405480
> ffff000008cc4000 00000001004acd06
> [55282.676146] 3e60: ffff000008004000 ffff000008870000
> 0000000000000001 ffff000008003ed0
> [55282.683983] 3e80: ffff0000080cf8e8 ffff000008003ed0
> ffff000008081184 0000000040000145
> [55282.691819] 3ea0: ffff8000125a78a4 ffff8000125a7800
> 0000ffffffffffff ffff8000125a7828
> [55282.699652] 3ec0: ffff000008003ed0 ffff000008081184
> [55282.704535] [<ffff000008082a30>] el1_irq+0xb0/0x124
> [55282.709418] [<ffff000008081184>] __do_softirq+0xa4/0x218
> [55282.714737] [<ffff0000080cf8e8>] irq_exit+0xd0/0xf0
> [55282.719618] [<ffff000008113cf8>] __handle_domain_irq+0x60/0xb8
> [55282.725455] [<ffff000008080fe0>] gic_handle_irq+0x78/0x174
> [55282.730944] Exception stack(0xffff000008c43dd0 to 0xffff000008c43f10)
> [55282.737391] 3dc0:
> 0000000000000000 0000000000000000
> [55282.745229] 3de0: 0000000000000001 0000000000000000
> ffff000008b22108 ffff000008c43f00
> [55282.753066] 3e00: 000080003743e000 ffff80003ff65b60
> ffff000008c55240 ffff000008c43e90
> [55282.760901] 3e20: 00000000000008e0 0000000000000000
> 0000000000000001 0000000000000000
> [55282.768737] 3e40: 00000000f6292434 0000000000000000
> ffff00000813d758 0000000000000000
> [55282.776574] 3e60: 0000000000000000 ffff000008b1e018
> ffff000008c4a000 ffff000008c4a000
> [55282.784410] 3e80: ffff000008b26a30 ffff000008c4a9e0
> 0000000000000000 0000000000000000
> [55282.792246] 3ea0: ffff000008c54900 0000000000000400
> 0000000080cc0018 ffff000008c43f10
> [55282.800082] 3ec0: ffff000008084f04 ffff000008c43f10
> ffff000008084f08 0000000000000145
> [55282.807918] 3ee0: 0000000000000000 00000000bfe9eb84
> ffffffffffffffff ffff000008138d14
> [55282.815752] 3f00: ffff000008c43f10 ffff000008084f08
> [55282.820635] [<ffff000008082a30>] el1_irq+0xb0/0x124
> [55282.825519] [<ffff000008084f08>] arch_cpu_idle+0x10/0x18
> [55282.830835] [<ffff0000081063e0>] do_idle+0x120/0x1e0
> [55282.835804] [<ffff000008106638>] cpu_startup_entry+0x20/0x28
> [55282.841472] [<ffff000008840fe4>] rest_init+0xcc/0xd8
> [55282.846442] [<ffff000008ac0b88>] start_kernel+0x37c/0x390

In the above stack trace, the stalled CPU (that is, CPU 0) is in the idle
loop, correct?  Then it took an interrupt and was processing softirqs
upon return from that interrupt when it took a scheduling clock interrupt,
which did the self-reported stall warning.

Is this analysis correct?

If so, and assuming that this is reproducible, I suggest building your
kernel with CONFIG_RCU_EQS_DEBUG=y, which enables additional debugging
that might be helpful with this issue.

> They were initially using 4.14.68, which did not show this problem.
> 
> Git bisect pointed to the ollowing commit:
> 
> 016a8fc59d14 ("rcu: Make need_resched() respond to urgent RCU-QS needs")
> 
> Reverting this commit on top of 4.14.98 fixes the problem.
> 
> They have also tried applying:
>  e97a32a5a3bc ("rcu: Do RCU GP kthread self-wakeup from softirq and interrupt")
> 
> without reverting 016a8fc59d14, but it does not fix the problem.
> 
> Any suggestions/help are appreciated.

My guess is that there is an interrupt/exception entry path on this
hardware that is failing to invoke rcu_irq_enter(), which would explain
why this CPU believes it is idle despite its being in a softirq handler.

But that is of course just a guess at this point, so let's see what
turns up with CONFIG_RCU_EQS_DEBUG=y.

							Thanx, Paul
