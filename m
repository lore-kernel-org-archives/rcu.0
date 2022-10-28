Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382D6C38A02
	for <rcu@archiver.kernel.org>; Fri, 28 Oct 2022 11:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJ1L2m (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 28 Oct 2022 07:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiJ1L2l (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 28 Oct 2022 07:28:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DF61D0D7D
        for <rcu@vger.kernel.org>; Fri, 28 Oct 2022 04:28:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MzKzx6Tgyz4xG9;
        Fri, 28 Oct 2022 22:28:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1666956512;
        bh=J/AYahW+Dz6kZbTH/xRfZDSFnQc89GXn+beJG+k4zl8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pTuB/ItKANYiOoOOnTFhCEEHLdZABRrsQkFcw0W2WgJYpWRkYf2ChWbcvhXNNU7xe
         tDMEiu/6nYKAfEMnUB6OuBtD4ZQy4BXf3dLR5K0foNaj/FHWJcWXjAA2kO/cEIEbt8
         cNGl0xi6czTycWl3t7q7rvX4CuXTeEIXlMBeqAC144PbQVgGbEnDc+q7xguMJg4a/I
         Bjwmw3MeibQ1c8D4t6FJV4YwecYwgVKwWj6f35H7QdRVhiVOdBMIp//pXKwn/wr9/c
         o4dWcQRF7qoWwdT85Pqy6KDpTvBk1Tmma/3hkR4/rhKzgx5rOS1Q4B7dQYP2HC/jqK
         uKRWETkBFnD9A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     paulmck@kernel.org, Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        npiggin@gmail.com, sfr@canb.auug.org.au
Subject: Re: [PATCH] srcu: Delegate work to the first online cpu if using
 SRCU_SIZE_SMALL
In-Reply-To: <20221026135211.GI5600@paulmck-ThinkPad-P17-Gen-1>
References: <20221026032716.78674-1-kernelfans@gmail.com>
 <20221026135211.GI5600@paulmck-ThinkPad-P17-Gen-1>
Date:   Fri, 28 Oct 2022 22:28:27 +1100
Message-ID: <8735b8tcf8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:
> On Wed, Oct 26, 2022 at 11:27:16AM +0800, Pingfan Liu wrote:
>> commit 994f706872e6 ("srcu: Make Tree SRCU able to operate without
>> snp_node array") assumes that cpu 0 is always online, but that is not
>> the truth when using maxcpus=1 in the command line for the kdump kernel.
>> 
>> On a PowerPC, the following kdump kernel hanging is observed:
>
> Adding a few PowerPC folks on CC for their thoughts systems booting with
> some CPU other than CPU 0 as the boot CPU.  Is this intended/supported?

Yes, unfortunately.

It comes as part of kdump, where a random CPU crashes and kexec's into a
new kernel, so we can end up booting the 2nd kernel on any CPU.

I have objections to the distro practice of booting the kdump kernel
with maxcpus=1, but no one has ever listened to me :)

>> ...
>> [    1.740036] systemd[1]: Hostname set to <xyz.com>
>> [  243.686240] INFO: task systemd:1 blocked for more than 122 seconds.
>> [  243.686264]       Not tainted 6.1.0-rc1 #1
>> [  243.686272] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  243.686281] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00042000
>> [  243.686296] Call Trace:
>> [  243.686301] [c000000016657640] [c000000016657670] 0xc000000016657670 (unreliable)
>> [  243.686317] [c000000016657830] [c00000001001dec0] __switch_to+0x130/0x220
>> [  243.686333] [c000000016657890] [c000000010f607b8] __schedule+0x1f8/0x580
>> [  243.686347] [c000000016657940] [c000000010f60bb4] schedule+0x74/0x140
>> [  243.686361] [c0000000166579b0] [c000000010f699b8] schedule_timeout+0x168/0x1c0
>> [  243.686374] [c000000016657a80] [c000000010f61de8] __wait_for_common+0x148/0x360
>> [  243.686387] [c000000016657b20] [c000000010176bb0] __flush_work.isra.0+0x1c0/0x3d0
>> [  243.686401] [c000000016657bb0] [c0000000105f2768] fsnotify_wait_marks_destroyed+0x28/0x40
>> [  243.686415] [c000000016657bd0] [c0000000105f21b8] fsnotify_destroy_group+0x68/0x160
>> [  243.686428] [c000000016657c40] [c0000000105f6500] inotify_release+0x30/0xa0
>> [  243.686440] [c000000016657cb0] [c0000000105751a8] __fput+0xc8/0x350
>> [  243.686452] [c000000016657d00] [c00000001017d524] task_work_run+0xe4/0x170
>> [  243.686464] [c000000016657d50] [c000000010020e94] do_notify_resume+0x134/0x140
>> [  243.686478] [c000000016657d80] [c00000001002eb18] interrupt_exit_user_prepare_main+0x198/0x270
>> [  243.686493] [c000000016657de0] [c00000001002ec60] syscall_exit_prepare+0x70/0x180
>> [  243.686505] [c000000016657e10] [c00000001000bf7c] system_call_vectored_common+0xfc/0x280
>> [  243.686520] --- interrupt: 3000 at 0x7fffa47d5ba4
>> [  243.686528] NIP:  00007fffa47d5ba4 LR: 0000000000000000 CTR: 0000000000000000
>> [  243.686538] REGS: c000000016657e80 TRAP: 3000   Not tainted  (6.1.0-rc1)
>> [  243.686548] MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 42044440  XER: 00000000
>> [  243.686572] IRQMASK: 0
>> [  243.686572] GPR00: 0000000000000006 00007ffffa606710 00007fffa48e7200 0000000000000000
>> [  243.686572] GPR04: 0000000000000002 000000000000000a 0000000000000000 0000000000000001
>> [  243.686572] GPR08: 000001000c172dd0 0000000000000000 0000000000000000 0000000000000000
>> [  243.686572] GPR12: 0000000000000000 00007fffa4ff4bc0 0000000000000000 0000000000000000
>> [  243.686572] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [  243.686572] GPR20: 0000000132dfdc50 000000000000000e 0000000000189375 0000000000000000
>> [  243.686572] GPR24: 00007ffffa606ae0 0000000000000005 000001000c185490 000001000c172570
>> [  243.686572] GPR28: 000001000c172990 000001000c184850 000001000c172e00 00007fffa4fedd98
>> [  243.686683] NIP [00007fffa47d5ba4] 0x7fffa47d5ba4
>> [  243.686691] LR [0000000000000000] 0x0
>> [  243.686698] --- interrupt: 3000
>> [  243.686708] INFO: task kworker/u16:1:24 blocked for more than 122 seconds.
>> [  243.686717]       Not tainted 6.1.0-rc1 #1
>> [  243.686724] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  243.686733] task:kworker/u16:1   state:D stack:0     pid:24    ppid:2      flags:0x00000800
>> [  243.686747] Workqueue: events_unbound fsnotify_mark_destroy_workfn
>> [  243.686758] Call Trace:
>> [  243.686762] [c0000000166736e0] [c00000004fd91000] 0xc00000004fd91000 (unreliable)
>> [  243.686775] [c0000000166738d0] [c00000001001dec0] __switch_to+0x130/0x220
>> [  243.686788] [c000000016673930] [c000000010f607b8] __schedule+0x1f8/0x580
>> [  243.686801] [c0000000166739e0] [c000000010f60bb4] schedule+0x74/0x140
>> [  243.686814] [c000000016673a50] [c000000010f699b8] schedule_timeout+0x168/0x1c0
>> [  243.686827] [c000000016673b20] [c000000010f61de8] __wait_for_common+0x148/0x360
>> [  243.686840] [c000000016673bc0] [c000000010210840] __synchronize_srcu.part.0+0xa0/0xe0
>> [  243.686855] [c000000016673c30] [c0000000105f2c64] fsnotify_mark_destroy_workfn+0xc4/0x1a0
>> [  243.686868] [c000000016673ca0] [c000000010174ea8] process_one_work+0x2a8/0x570
>> [  243.686882] [c000000016673d40] [c000000010175208] worker_thread+0x98/0x5e0
>> [  243.686895] [c000000016673dc0] [c0000000101828d4] kthread+0x124/0x130
>> [  243.686908] [c000000016673e10] [c00000001000cd40] ret_from_kernel_thread+0x5c/0x64
>> [  366.566274] INFO: task systemd:1 blocked for more than 245 seconds.
>> [  366.566298]       Not tainted 6.1.0-rc1 #1
>> [  366.566305] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  366.566314] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00042000
>> [  366.566329] Call Trace:
>> ...
>> 
>> In that case, note that maxcpus=1 instead of nr_cpus=1 is used in the
>> kernel command line on the PowerPC platform. Consequently, the crash cpu
>> is the only onlined cpu in the kdump kernel, but with its logical id not
>> necessary 0. While SRCU queues a sdp->work on cpu 0, on which no worker
>> thread is created, so sdp->work will be never executed and
>> __synchronize_srcu() can not be completed.
>> 
>> Tackle this issue by queueing sdp->work on the first onlined cpu.
>> 
>> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>
> Good catch!!!  New one on me!  ;-)
>
> But a few questions...
>
> 1.	As noted above, is booting without CPU 0 an intentional and
> 	supported feature of PowerPC?  If not, perhaps a better approach
> 	would be to rule out this configuration.
>
> 2.	When booting without CPU 0, is it guaranteed that CPU 0 will
> 	never come online?  If not, then isn't the patch below subject
> 	to failure modes when that happens?

In the general case no it's not guaranteed.

You could boot on CPU N and then later CPU0 could be brought online via
hotplug.

> 3.	More generally, when CPU N is the boot CPU, is it guaranteed
> 	that CPU M, M < N, will never come online?  Same as above on
> 	failure modes.

No.

cheers
