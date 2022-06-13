Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AA8C43334
	for <rcu@archiver.kernel.org>; Mon, 13 Jun 2022 22:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiFMWsq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiFMWsp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 13 Jun 2022 18:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C2A31387
        for <rcu@vger.kernel.org>; Mon, 13 Jun 2022 15:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7977D61536
        for <rcu@vger.kernel.org>; Mon, 13 Jun 2022 22:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13D4C34114;
        Mon, 13 Jun 2022 22:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655160523;
        bh=9shom3QjIdk3a+ETDVmRihkHoDJCcPRYC8NuHqJycRE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YIMhTjsGRTbEqsYFYE3OCpBb8xRHlJ1LyhUUwXsSp/StRVZosZX9sduZeGq7zVuay
         1mwGSQ4ruwb2mRmmcP4sd/OncMdmSV5MmkBOhzb2jlUBSuz0Y5QM3Bt8xKyChsrY/S
         QooLwYrUn06LX30TXkyqP//VXriAES9hgippVtIYDNNkS6Oayx5xGiqZ40AKudEQSY
         Jd+nMz7ofGArO5tLFo5CtubSS/UlqZDIp/MRCra6XT9HdiGxFADTzJNldXlbDbBw6Y
         TmIvqwiKm26JER1Vr4NEhiTLGhAhRvmHpQxDkGioUdSDsl+tPv0Rc1K9RYdyHSLWT/
         BkNfpwT3NYlTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 76A265C02F9; Mon, 13 Jun 2022 15:48:43 -0700 (PDT)
Date:   Mon, 13 Jun 2022 15:48:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <20220613224843.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <YqeHp0Zmm512x5nx@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqeHp0Zmm512x5nx@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 13, 2022 at 06:53:27PM +0000, Joel Fernandes wrote:
> On Thu, May 12, 2022 at 03:04:28AM +0000, Joel Fernandes (Google) wrote:
> > Hello!
> > Please find the proof of concept version of call_rcu_lazy() attached. This
> > gives a lot of savings when the CPUs are relatively idle. Huge thanks to
> > Rushikesh Kadam from Intel for investigating it with me.
> 
> Just a status update, we're reworking this code to use the bypass lists which
> takes care of a lot of corner cases. I've had to make changes the the rcuog
> thread code to handle wakes up a bit differently and such. Initial testing is
> looking good. Currently working on the early-flushing of the lazy CBs based
> on memory pressure.
> 
> Should be hopefully sending v2 soon!

Looking forward to seeing it!

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> 
> > 
> > Some numbers below:
> > 
> > Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
> > The observation is that due to a 'trickle down' effect of RCU callbacks, the
> > system is very lightly loaded but constantly running few RCU callbacks very
> > often. This confuses the power management hardware that the system is active,
> > when it is in fact idle.
> > 
> > For example, when ChromeOS screen is off and user is not doing anything on the
> > system, we can see big power savings.
> > Before:
> > Pk%pc10 = 72.13
> > PkgWatt = 0.58
> > CorWatt = 0.04
> > 
> > After:
> > Pk%pc10 = 81.28
> > PkgWatt = 0.41
> > CorWatt = 0.03
> > 
> > Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> > can see that the display pipeline is constantly doing RCU callback queuing due
> > to open/close of file descriptors associated with graphics buffers. This is
> > attributed to the file_free_rcu() path which this patch series also touches.
> > 
> > This patch series adds a simple but effective, and lockless implementation of
> > RCU callback batching. On memory pressure, timeout or queue growing too big, we
> > initiate a flush of one or more per-CPU lists.
> > 
> > Similar results can be achieved by increasing jiffies_till_first_fqs, however
> > that also has the effect of slowing down RCU. Especially I saw huge slow down
> > of function graph tracer when increasing that.
> > 
> > One drawback of this series is, if another frequent RCU callback creeps up in
> > the future, that's not lazy, then that will again hurt the power. However, I
> > believe identifying and fixing those is a more reasonable approach than slowing
> > RCU down for the whole system.
> > 
> > NOTE: Add debug patch is added in the series toggle /proc/sys/kernel/rcu_lazy
> > at runtime to turn it on or off globally. It is default to on. Further, please
> > use the sysctls in lazy.c for further tuning of parameters that effect the
> > flushing.
> > 
> > Disclaimer 1: Don't boot your personal system on it yet anticipating power
> > savings, as TREE07 still causes RCU stalls and I am looking more into that, but
> > I believe this series should be good for general testing.
> > 
> > Disclaimer 2: I have intentionally not CC'd other subsystem maintainers (like
> > net, fs) to keep noise low and will CC them in the future after 1 or 2 rounds
> > of review and agreements.
> > 
> > Joel Fernandes (Google) (14):
> >   rcu: Add a lock-less lazy RCU implementation
> >   workqueue: Add a lazy version of queue_rcu_work()
> >   block/blk-ioc: Move call_rcu() to call_rcu_lazy()
> >   cred: Move call_rcu() to call_rcu_lazy()
> >   fs: Move call_rcu() to call_rcu_lazy() in some paths
> >   kernel: Move various core kernel usages to call_rcu_lazy()
> >   security: Move call_rcu() to call_rcu_lazy()
> >   net/core: Move call_rcu() to call_rcu_lazy()
> >   lib: Move call_rcu() to call_rcu_lazy()
> >   kfree/rcu: Queue RCU work via queue_rcu_work_lazy()
> >   i915: Move call_rcu() to call_rcu_lazy()
> >   rcu/kfree: remove useless monitor_todo flag
> >   rcu/kfree: Fix kfree_rcu_shrink_count() return value
> >   DEBUG: Toggle rcu_lazy and tune at runtime
> > 
> >  block/blk-ioc.c                            |   2 +-
> >  drivers/gpu/drm/i915/gem/i915_gem_object.c |   2 +-
> >  fs/dcache.c                                |   4 +-
> >  fs/eventpoll.c                             |   2 +-
> >  fs/file_table.c                            |   3 +-
> >  fs/inode.c                                 |   2 +-
> >  include/linux/rcupdate.h                   |   6 +
> >  include/linux/sched/sysctl.h               |   4 +
> >  include/linux/workqueue.h                  |   1 +
> >  kernel/cred.c                              |   2 +-
> >  kernel/exit.c                              |   2 +-
> >  kernel/pid.c                               |   2 +-
> >  kernel/rcu/Kconfig                         |   8 ++
> >  kernel/rcu/Makefile                        |   1 +
> >  kernel/rcu/lazy.c                          | 153 +++++++++++++++++++++
> >  kernel/rcu/rcu.h                           |   5 +
> >  kernel/rcu/tree.c                          |  28 ++--
> >  kernel/sysctl.c                            |  23 ++++
> >  kernel/time/posix-timers.c                 |   2 +-
> >  kernel/workqueue.c                         |  25 ++++
> >  lib/radix-tree.c                           |   2 +-
> >  lib/xarray.c                               |   2 +-
> >  net/core/dst.c                             |   2 +-
> >  security/security.c                        |   2 +-
> >  security/selinux/avc.c                     |   4 +-
> >  25 files changed, 255 insertions(+), 34 deletions(-)
> >  create mode 100644 kernel/rcu/lazy.c
> > 
> > -- 
> > 2.36.0.550.gb090851708-goog
> > 
