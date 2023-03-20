Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D12C6FD1D
	for <rcu@archiver.kernel.org>; Mon, 20 Mar 2023 16:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjCTQ5w (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjCTQ5d (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Mar 2023 12:57:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39EB3929E
        for <rcu@vger.kernel.org>; Mon, 20 Mar 2023 09:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 87981CE136C
        for <rcu@vger.kernel.org>; Mon, 20 Mar 2023 16:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D68C433D2;
        Mon, 20 Mar 2023 16:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679330935;
        bh=F4lvGMMdbIHdUMIxDvTAkrzjAAhAGcWdFlxskafFdos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duEBB4NY5Coy8myz+2p+jXVtb2ATxQ4wxgT2qpFSEgRNMmLCSMUB4fCZnlpmMYyfi
         JfytLowVsXrH2qGk7F7o+X5aE2uP32Pab9+irAEktSV9EhuE3a2qeRNBWdijBRL6vP
         UjEurZJzAOH/cvuIY5vVTne1wZP+5gooG9iOVDyihTiuv9vQsYMLbkCX0kc2pFm4sM
         orICYsynd9j8jXrX3buGrFz1MHuulks5uyOQcDv4jTdTu6B7RmFw7l1m59sy40uejY
         UFQVffL3ijK4yKOujzQeqS9tr6PnXcrjtbFvFAw+H/fDly3difOzh45e96SRnlr2iX
         JggkzC7FVZ1Lw==
Date:   Mon, 20 Mar 2023 17:48:52 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pengfei Xu <pengfei.xu@intel.com>, Jens Axboe <axboe@fb.com>
Cc:     boqun.feng@gmail.com, quic_neeraju@quicinc.com, paulmck@kernel.org,
        heng.su@intel.com, lkp@intel.com, peterz@infradead.org,
        rcu@vger.kernel.org
Subject: Re: [Syzkaller & bisect] There is "sys_perf_event_open" soft lockup
 BUG in v6.3-rc2 kernel
Message-ID: <ZBiOdCtHy1I2irFT@lothringen>
References: <ZBQbUUX+cBlMckCz@xpf.sh.intel.com>
 <ZBR0qFQYoq4+2sXC@lothringen>
 <ZBUisfcPvXzqrSQh@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBUisfcPvXzqrSQh@xpf.sh.intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Mar 18, 2023 at 10:32:17AM +0800, Pengfei Xu wrote:
> Hi Frederic Weisbecker,
> 
> On 2023-03-17 at 15:09:44 +0100, Frederic Weisbecker wrote:
> > On Fri, Mar 17, 2023 at 03:48:33PM +0800, Pengfei Xu wrote:
> > > Hi Frederic Weisbecker and kernel experts,
> > > 
> > > Platform: x86 platforms
> > > There is "sys_perf_event_open" soft lockup BUG in v6.3-rc2 kernel in guest.
> > 
> > I can reproduce with you tests which is based on v6.2-rc5. However when
> > I forward port your .config to a v6.3-rc2, the issue doesn't trigger anymore.
> > 
> > Did you manage to reproduce on v6.3-rc2? And if so do you still have the related
> > .config ?
> > 
>   Ah, I fogot to say: kconfig_origin will be changed after "make olddefconfig",
>   there were many items changed in .config after "make olddefconfig" in v6.3-rc2.
> 
>  I used below way to make the .config.
>  1. Copy the kconfig origin to .config: https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/kconfig_origin
>  2. Fogort that the bisect script will change .config: CONFIG_LOCALVERSION="-kvm"  ->  CONFIG_LOCALVERSION="-eeac8ede1755", seems to have little effect.
>  3. make olddefconfig  // Then .config will be changed in v6.3-rc2 kernel code.
>     Put .config after make olddefconfig in link:
>     https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/kconfig_v6.3-rc2_after_make_olddefconfig
>  4. make -jx bzImage   //x should equal or less than cpu num your pc has
> 
>     Put v6.3-rc2 bzImage in link:
>     https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/bzImage_eeac8ede17557680855031c6f305ece2378af326
> 
> And it could be reproduced after maunally test in 150s.
> v6.3-rc2 reproduced dmesg:
> https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/v6.3-rc2_perf_related_problem_dmesg.log
> 
> And it could be reproduced on our ADL-N client x86 PC in guest.

Thanks!

Now it triggers but I get something a bit different:

[  299.258474] INFO: task kworker/u4:1:30 blocked for more than 147 seconds.
[  299.259223]       Not tainted 6.3.0-rc2-kvm-dirty #1
[  299.259657] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  299.260529] task:kworker/u4:1    state:D stack:0     pid:30    ppid:2      flags:0x00004000
[  299.261484] Workqueue: events_unbound io_ring_exit_work
[  299.262163] Call Trace:
[  299.262514]  <TASK>
[  299.262826]  __schedule+0x414/0xcb0
[  299.263303]  ? wait_for_completion+0x77/0x170
[  299.263753]  schedule+0x63/0xd0
[  299.264120]  schedule_timeout+0x2fe/0x530
[  299.264635]  ? __this_cpu_preempt_check+0x1c/0x30
[  299.265169]  ? _raw_spin_unlock_irq+0x27/0x60
[  299.265621]  ? lockdep_hardirqs_on+0x88/0x120
[  299.266054]  ? wait_for_completion+0x77/0x170
[  299.266686]  wait_for_completion+0x9e/0x170
[  299.267198]  io_ring_exit_work+0x2b0/0x810
[  299.267669]  ? __pfx_io_tctx_exit_cb+0x10/0x10
[  299.268176]  process_one_work+0x34e/0x810
[  299.268620]  ? __pfx_io_ring_exit_work+0x10/0x10
[  299.269061]  ? process_one_work+0x34e/0x810
[  299.269561]  worker_thread+0x4e/0x530
[  299.270052]  ? __pfx_worker_thread+0x10/0x10
[  299.270635]  kthread+0x128/0x160
[  299.270962]  ? __pfx_kthread+0x10/0x10
[  299.271405]  ret_from_fork+0x2c/0x50
[  299.271850]  </TASK>
