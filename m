Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F01FECAAA1
	for <rcu@archiver.kernel.org>; Fri, 28 Oct 2022 17:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJ1Rij (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 28 Oct 2022 13:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJ1Rii (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 28 Oct 2022 13:38:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5AB22B3B1
        for <rcu@vger.kernel.org>; Fri, 28 Oct 2022 10:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C01AB82BFD
        for <rcu@vger.kernel.org>; Fri, 28 Oct 2022 17:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ED3C433C1;
        Fri, 28 Oct 2022 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666978713;
        bh=UXmK+AEfjbNWgQWy3naY/c7GEhuJzGUnJmkE64UkG6g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BV8+wi2xVgPDpDUwyp7PIAFcOpZAFo4pGFoCR9479UemI0bij01B5pae0S1iNh+Av
         Lzb59z2WSh3AyM3SoRy3NQNbvWwEsnGkvsqA7Ot14Ripab5oeELkwj5KSvVZLOANVT
         byQp167JnRdJ21JLDqhN2iGsHCUJ5DjtOiE8SApbyInoc8qfX3ZlkdARvCqa0S3gXp
         XHtK4Oh3VxiwwEQTpFbankDpeoFmcT/VCeddDR3qlVWEZi653cypsYiLE14pnlrcry
         jvmqc/4XU/3otwvfbHHHfioLaerYIMh0ECIoH8wFyqMuUCsUei+kJaX6gbDd4HIeQI
         on4LqIC/ByTEw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8C1A15C0692; Fri, 28 Oct 2022 10:38:32 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:38:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Pingfan Liu <kernelfans@gmail.com>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        npiggin@gmail.com, sfr@canb.auug.org.au
Subject: Re: [PATCH] srcu: Delegate work to the first online cpu if using
 SRCU_SIZE_SMALL
Message-ID: <20221028173832.GL5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221026032716.78674-1-kernelfans@gmail.com>
 <20221026135211.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <8735b8tcf8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735b8tcf8.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 28, 2022 at 10:28:27PM +1100, Michael Ellerman wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > On Wed, Oct 26, 2022 at 11:27:16AM +0800, Pingfan Liu wrote:
> >> commit 994f706872e6 ("srcu: Make Tree SRCU able to operate without
> >> snp_node array") assumes that cpu 0 is always online, but that is not
> >> the truth when using maxcpus=1 in the command line for the kdump kernel.
> >> 
> >> On a PowerPC, the following kdump kernel hanging is observed:
> >
> > Adding a few PowerPC folks on CC for their thoughts systems booting with
> > some CPU other than CPU 0 as the boot CPU.  Is this intended/supported?
> 
> Yes, unfortunately.
> 
> It comes as part of kdump, where a random CPU crashes and kexec's into a
> new kernel, so we can end up booting the 2nd kernel on any CPU.
> 
> I have objections to the distro practice of booting the kdump kernel
> with maxcpus=1, but no one has ever listened to me :)

I know that feeling...  :-/

And thank you for your answers!

And one more that I should have asked to begin with...

Is it possible for the system booting on CPU N to not have CPU 0 in the
cpu_possible_mask?  As in is it possible for CPU 0's per-CPU variables
to be unmapped?

							Thanx, Paul

> >> ...
> >> [    1.740036] systemd[1]: Hostname set to <xyz.com>
> >> [  243.686240] INFO: task systemd:1 blocked for more than 122 seconds.
> >> [  243.686264]       Not tainted 6.1.0-rc1 #1
> >> [  243.686272] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >> [  243.686281] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00042000
> >> [  243.686296] Call Trace:
> >> [  243.686301] [c000000016657640] [c000000016657670] 0xc000000016657670 (unreliable)
> >> [  243.686317] [c000000016657830] [c00000001001dec0] __switch_to+0x130/0x220
> >> [  243.686333] [c000000016657890] [c000000010f607b8] __schedule+0x1f8/0x580
> >> [  243.686347] [c000000016657940] [c000000010f60bb4] schedule+0x74/0x140
> >> [  243.686361] [c0000000166579b0] [c000000010f699b8] schedule_timeout+0x168/0x1c0
> >> [  243.686374] [c000000016657a80] [c000000010f61de8] __wait_for_common+0x148/0x360
> >> [  243.686387] [c000000016657b20] [c000000010176bb0] __flush_work.isra.0+0x1c0/0x3d0
> >> [  243.686401] [c000000016657bb0] [c0000000105f2768] fsnotify_wait_marks_destroyed+0x28/0x40
> >> [  243.686415] [c000000016657bd0] [c0000000105f21b8] fsnotify_destroy_group+0x68/0x160
> >> [  243.686428] [c000000016657c40] [c0000000105f6500] inotify_release+0x30/0xa0
> >> [  243.686440] [c000000016657cb0] [c0000000105751a8] __fput+0xc8/0x350
> >> [  243.686452] [c000000016657d00] [c00000001017d524] task_work_run+0xe4/0x170
> >> [  243.686464] [c000000016657d50] [c000000010020e94] do_notify_resume+0x134/0x140
> >> [  243.686478] [c000000016657d80] [c00000001002eb18] interrupt_exit_user_prepare_main+0x198/0x270
> >> [  243.686493] [c000000016657de0] [c00000001002ec60] syscall_exit_prepare+0x70/0x180
> >> [  243.686505] [c000000016657e10] [c00000001000bf7c] system_call_vectored_common+0xfc/0x280
> >> [  243.686520] --- interrupt: 3000 at 0x7fffa47d5ba4
> >> [  243.686528] NIP:  00007fffa47d5ba4 LR: 0000000000000000 CTR: 0000000000000000
> >> [  243.686538] REGS: c000000016657e80 TRAP: 3000   Not tainted  (6.1.0-rc1)
> >> [  243.686548] MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 42044440  XER: 00000000
> >> [  243.686572] IRQMASK: 0
> >> [  243.686572] GPR00: 0000000000000006 00007ffffa606710 00007fffa48e7200 0000000000000000
> >> [  243.686572] GPR04: 0000000000000002 000000000000000a 0000000000000000 0000000000000001
> >> [  243.686572] GPR08: 000001000c172dd0 0000000000000000 0000000000000000 0000000000000000
> >> [  243.686572] GPR12: 0000000000000000 00007fffa4ff4bc0 0000000000000000 0000000000000000
> >> [  243.686572] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> >> [  243.686572] GPR20: 0000000132dfdc50 000000000000000e 0000000000189375 0000000000000000
> >> [  243.686572] GPR24: 00007ffffa606ae0 0000000000000005 000001000c185490 000001000c172570
> >> [  243.686572] GPR28: 000001000c172990 000001000c184850 000001000c172e00 00007fffa4fedd98
> >> [  243.686683] NIP [00007fffa47d5ba4] 0x7fffa47d5ba4
> >> [  243.686691] LR [0000000000000000] 0x0
> >> [  243.686698] --- interrupt: 3000
> >> [  243.686708] INFO: task kworker/u16:1:24 blocked for more than 122 seconds.
> >> [  243.686717]       Not tainted 6.1.0-rc1 #1
> >> [  243.686724] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >> [  243.686733] task:kworker/u16:1   state:D stack:0     pid:24    ppid:2      flags:0x00000800
> >> [  243.686747] Workqueue: events_unbound fsnotify_mark_destroy_workfn
> >> [  243.686758] Call Trace:
> >> [  243.686762] [c0000000166736e0] [c00000004fd91000] 0xc00000004fd91000 (unreliable)
> >> [  243.686775] [c0000000166738d0] [c00000001001dec0] __switch_to+0x130/0x220
> >> [  243.686788] [c000000016673930] [c000000010f607b8] __schedule+0x1f8/0x580
> >> [  243.686801] [c0000000166739e0] [c000000010f60bb4] schedule+0x74/0x140
> >> [  243.686814] [c000000016673a50] [c000000010f699b8] schedule_timeout+0x168/0x1c0
> >> [  243.686827] [c000000016673b20] [c000000010f61de8] __wait_for_common+0x148/0x360
> >> [  243.686840] [c000000016673bc0] [c000000010210840] __synchronize_srcu.part.0+0xa0/0xe0
> >> [  243.686855] [c000000016673c30] [c0000000105f2c64] fsnotify_mark_destroy_workfn+0xc4/0x1a0
> >> [  243.686868] [c000000016673ca0] [c000000010174ea8] process_one_work+0x2a8/0x570
> >> [  243.686882] [c000000016673d40] [c000000010175208] worker_thread+0x98/0x5e0
> >> [  243.686895] [c000000016673dc0] [c0000000101828d4] kthread+0x124/0x130
> >> [  243.686908] [c000000016673e10] [c00000001000cd40] ret_from_kernel_thread+0x5c/0x64
> >> [  366.566274] INFO: task systemd:1 blocked for more than 245 seconds.
> >> [  366.566298]       Not tainted 6.1.0-rc1 #1
> >> [  366.566305] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >> [  366.566314] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00042000
> >> [  366.566329] Call Trace:
> >> ...
> >> 
> >> In that case, note that maxcpus=1 instead of nr_cpus=1 is used in the
> >> kernel command line on the PowerPC platform. Consequently, the crash cpu
> >> is the only onlined cpu in the kdump kernel, but with its logical id not
> >> necessary 0. While SRCU queues a sdp->work on cpu 0, on which no worker
> >> thread is created, so sdp->work will be never executed and
> >> __synchronize_srcu() can not be completed.
> >> 
> >> Tackle this issue by queueing sdp->work on the first onlined cpu.
> >> 
> >> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >
> > Good catch!!!  New one on me!  ;-)
> >
> > But a few questions...
> >
> > 1.	As noted above, is booting without CPU 0 an intentional and
> > 	supported feature of PowerPC?  If not, perhaps a better approach
> > 	would be to rule out this configuration.
> >
> > 2.	When booting without CPU 0, is it guaranteed that CPU 0 will
> > 	never come online?  If not, then isn't the patch below subject
> > 	to failure modes when that happens?
> 
> In the general case no it's not guaranteed.
> 
> You could boot on CPU N and then later CPU0 could be brought online via
> hotplug.
> 
> > 3.	More generally, when CPU N is the boot CPU, is it guaranteed
> > 	that CPU M, M < N, will never come online?  Same as above on
> > 	failure modes.
> 
> No.
> 
> cheers
