Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294A2C433EF
	for <rcu@archiver.kernel.org>; Tue, 14 Dec 2021 14:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhLNOsI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Dec 2021 09:48:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60786 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhLNOsI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Dec 2021 09:48:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2199D6152A
        for <rcu@vger.kernel.org>; Tue, 14 Dec 2021 14:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8359EC34605;
        Tue, 14 Dec 2021 14:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639493287;
        bh=rSPmR7O2Jjo4fzrFQBnLRQu8b/iVS1TtmQWwTfiK1f4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WiUUAktnp4MGRUyIsgd3bDJT61sS3oaDBig7t9XbJKzZxmuaeXiRRiKZEAVsI21gD
         ek/hIWQiyQ4r7O/W9B0Jin9maCXzouEWxQMH3PZhC+Z+qO9Yf9Ed/TY3w7cCkVOzxN
         SAXAI+fwqJtIb9Rlx98PtHiuJZ1sR6iO8Fq2So61Ax0hSl6VRe9VNmZ7yLzxbkcGtG
         7quOmH1ODEFNOjYivERcUmqC96bOCFyI6FjWu2+bWmE/CKXuWHiYtSAw5clj0IOI/M
         K7qqGutZpXVB/Z+nEQv3IiULlixF5WubJyypcJFzDorC/8j8yGjCFLNtx1W3IDjDsJ
         hRAsn1ac/Ub0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2038A5C00E3; Tue, 14 Dec 2021 06:48:07 -0800 (PST)
Date:   Tue, 14 Dec 2021 06:48:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: FYI, a few new KCSAN splats
Message-ID: <20211214144807.GX641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211214045758.GA1713844@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2xOHYLxSAfSfQgCXXEuNXYM=uU-cDS_KO+MLcQAV_yCoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2xOHYLxSAfSfQgCXXEuNXYM=uU-cDS_KO+MLcQAV_yCoQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 14, 2021 at 04:38:13PM +0800, Zhouyi Zhou wrote:
> Hi Paul,
> 
> On Tue, Dec 14, 2021 at 3:28 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Hello!
> >
> > At first glance, a WRITE_ONCE() in rcu_segcblist_set_flags() would cure
> > all these, but I thought I should double check.  Thoughts?
> 
> I think rcu_segcblist_clear_flags also needs a WRITE_ONCE()

This is my reproducer on a 16-hardware-thread laptop:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --configs "TREE01 TREE03 TREE04" --kcsan --kmake-arg "CC=clang-11" --trust-make

And many of these happened only once or twice during that 20-hour run
(10 hours of TREE03 and then another ten hours of TREE01 and TREE04).

Most of them were TREE01, so you could get there faster like this:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5h --configs "2*TREE01" --kcsan --kmake-arg "CC=clang-11" --trust-make

So, no, it is not all that easy to reproduce.  ;-)

                                                        Thanx, Paul

> > ------------------------------------------------------------------------
> I tried to reproduce the KCSAN Bug Report on my virtual machine but I
> can't, I don't know why (I have detected the KCSAN Bug in e1000 nic
> driver using the same environment before)
> 
> 1) My virtual machine:
> kvm -cpu host -smp 16 -hda ./Images/debian10.qcow2 -m 4096 -net
> user,hostfwd=tcp::5556-:22,hostfwd=tcp::5555-:19 -net nic,model=e1000
> -vnc :30
> 
> 2) The KCSAN kernel compile with clang-12:
> CONFIG_HAVE_ARCH_KCSAN=y
> CONFIG_HAVE_KCSAN_COMPILER=y
> CONFIG_KCSAN=y
> CONFIG_KCSAN_SELFTEST=y
> # CONFIG_KCSAN_EARLY_ENABLE is not set
> CONFIG_KCSAN_NUM_WATCHPOINTS=64
> CONFIG_KCSAN_UDELAY_TASK=80
> CONFIG_KCSAN_UDELAY_INTERRUPT=20
> CONFIG_KCSAN_DELAY_RANDOMIZE=y
> CONFIG_KCSAN_SKIP_WATCH=4000
> CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE=y
> # CONFIG_KCSAN_INTERRUPT_WATCHER is not set
> CONFIG_KCSAN_REPORT_ONCE_IN_MS=3000
> # CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN is not set
> # CONFIG_KCSAN_STRICT is not set
> CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=y
> # CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is not set
> CONFIG_KCSAN_IGNORE_ATOMICS=y
> CONFIG_KCSAN_PERMISSIVE=y
> 
> 3)kernel command line
> root@debian:~# cat /proc/cmdline
> earlyprintk=serial net.ifnames=0
> sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb
> nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000
> nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000
> nf-conntrack-sane.ports=20000 binder.debug_mask=0
> rcupdate.rcu_expedited=1 no_hash_pointers page_owner=on
> sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4
> secretmem.enable=1 root=/dev/sda console=ttyS0 vsyscall=native
> numa=fake=2 kvm-intel.nested=1 spec_store_bypass_disable=prctl nopcid
> vivid.n_devs=16 vivid.multiplanar=1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2
> netrom.nr_ndevs=16 rose.rose_ndevs=16 dummy_hcd.num=8
> watchdog_thresh=55 workqueue.watchdog_thresh=140
> sysctl.net.core.netdev_unregister_timeout_secs=140
> BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc5+
> root=UUID=85844675-467a-4aac-9014-ad7e85e833bd ro crashkernel=256M
> iomem=relaxed quiet nohz_full=2,3 rcu_nocbs=2,3
> 
> 4)The test:
> modprobe rcutorture nocbs_nthreads=8
> 
> Thanks Zhouyi
> >
> > BUG: KCSAN: data-race in rcu_nocb_cb_kthread / rcu_nocb_gp_kthread
> >
> > [34453.430323] read (marked) to 0xffff9dd1df26cb50 of 1 bytes by task 24 on cpu 13:
> > [34453.431069]  rcu_nocb_cb_kthread+0x18b/0x760
> > [34453.431523]  kthread+0x29b/0x2b0
> > [34453.431864]  ret_from_fork+0x22/0x30
> > [34453.432245]
> > [34453.432418] no locks held by rcuop/1/24.
> > [34453.432823] irq event stamp: 13161844
> > [34453.433208] hardirqs last  enabled at (13161844): [<ffffffff9c71b23a>] _raw_spin_unlock_irqrestore+0x3a/0x70
> > [34453.434220] hardirqs last disabled at (13161843): [<ffffffff9c71b053>] _raw_spin_lock_irqsave+0x53/0xb0
> > [34453.435129] softirqs last  enabled at (13161839): [<ffffffff9b1ade6d>] local_bh_enable+0xd/0x30
> > [34453.435979] softirqs last disabled at (13161837): [<ffffffff9b1ad5dd>] local_bh_disable+0xd/0x30
> > [34453.436857]
> > [34453.437020] write to 0xffff9dd1df26cb50 of 1 bytes by task 15 on cpu 3:
> > [34453.437680]  rcu_nocb_gp_kthread+0x3a3/0x1180
> > [34453.438137]  kthread+0x29b/0x2b0
> > [34453.438482]  ret_from_fork+0x22/0x30
> > [34453.438861]
> > [34453.439028] 1 lock held by rcuog/0/15:
> > [34453.439414]  #0: ffff9dd1df26cc70 (&rdp->nocb_lock){-.-.}-{2:2}, at: rcu_nocb_gp_kthread+0x2f2/0x1180
> > [34453.440382] irq event stamp: 22823959
> > [34453.440721] hardirqs last  enabled at (22823958): [<ffffffff9c71b23a>] _raw_spin_unlock_irqrestore+0x3a/0x70
> > [34453.441892] hardirqs last disabled at (22823959): [<ffffffff9b1b1722>] rcu_nocb_gp_kthread+0x2d2/0x1180
> > [34453.442831] softirqs last  enabled at (22823695): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> > [34453.443721] softirqs last disabled at (22823672): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> >
> > 0xffffffff811b275b is in rcu_nocb_cb_kthread (kernel/rcu/rcu_segcblist.h:71).
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> > 70      {
> > 71              return READ_ONCE(rsclp->flags) & flags;
> > 72      }
> > 73
> > 74      /*
> > 75       * Is the specified rcu_segcblist enabled, for example, not corresponding
> >
> > 0xffffffff811b17f3 is in rcu_nocb_gp_kthread (kernel/rcu/rcu_segcblist.h:59).
> > 54      }
> > 55
> > 56      static inline void rcu_segcblist_set_flags(struct rcu_segcblist *rsclp,
> > 57                                                 int flags)
> > 58      {
> > 59              rsclp->flags |= flags;
> > 60      }
> > 61
> > 62      static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
> > 63                                                   int flags)
> >
> > ------------------------------------------------------------------------
> >
> > BUG: KCSAN: data-race in rcu_core / rcu_nocb_cb_kthread
> >
> > [35979.380848]
> > [35979.380999] read (marked) to 0xffff9dd1df5ecb50 of 1 bytes by interrupt on cpu 15:
> > [35979.381735]  rcu_core+0x57/0x860
> > [35979.382058]  rcu_core_si+0x12/0x20
> > [35979.382400]  __do_softirq+0x1f9/0x37c
> > [35979.382749]  run_ksoftirqd+0x4c/0x80
> > [35979.383097]  smpboot_thread_fn+0x28b/0x390
> > [35979.383492]  kthread+0x29b/0x2b0
> > [35979.383805]  ret_from_fork+0x22/0x30
> > [35979.384149]
> > [35979.384298] no locks held by ksoftirqd/15/173.
> > [35979.384711] irq event stamp: 2431400
> > [35979.385049] hardirqs last  enabled at (2431400): [<ffffffff9ca000de>] __do_softirq+0xde/0x37c
> > [35979.385841] hardirqs last disabled at (2431398): [<ffffffff9b0c060e>] run_ksoftirqd+0x2e/0x80
> > [35979.386631] softirqs last  enabled at (2431394): [<ffffffff9b0c062c>] run_ksoftirqd+0x4c/0x80
> > [35979.387429] softirqs last disabled at (2431399): [<ffffffff9b0c062c>] run_ksoftirqd+0x4c/0x80
> > [35979.388215]
> > [35979.388364] write to 0xffff9dd1df5ecb50 of 1 bytes by task 176 on cpu 10:
> > [35979.388996]  rcu_nocb_cb_kthread+0x479/0x760
> > [35979.389427]  kthread+0x29b/0x2b0
> > [35979.389752]  ret_from_fork+0x22/0x30
> > [35979.390106]
> > [35979.390260] 1 lock held by rcuop/15/176:
> > [35979.390634]  #0: ffff9dd1df5ecc70 (&rdp->nocb_lock){-.-.}-{2:2}, at: rcu_nocb_cb_kthread+0x2ff/0x760
> >
> > 0xffffffff811ad657 is in rcu_core (kernel/rcu/rcu_segcblist.h:71).
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> > 70      {
> > 71              return READ_ONCE(rsclp->flags) & flags;
> > 72      }
> > 73
> > 74      /*
> > 75       * Is the specified rcu_segcblist enabled, for example, not corresponding
> >
> > 0xffffffff811b2a49 is in rcu_nocb_cb_kthread (kernel/rcu/rcu_segcblist.h:65).
> > 60      }
> > 61
> > 62      static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
> > 63                                                   int flags)
> > 64      {
> > 65              rsclp->flags &= ~flags;
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> >
> > ------------------------------------------------------------------------
> >
> > BUG: KCSAN: data-race in rcu_nocb_cb_kthread / rcu_rdp_is_offloaded
> >
> > [27570.512032] read (marked) to 0xffff9dd1df5ecb50 of 1 bytes by task 0 on cpu 15:
> > [27570.512770]  rcu_rdp_is_offloaded+0x63/0x1c0
> > [27570.513222]  rcu_needs_cpu+0x80/0xa0
> > [27570.513601]  tick_nohz_next_event+0x1d4/0x300
> > [27570.514063]  tick_nohz_idle_stop_tick+0x8f/0x3d0
> > [27570.514532]  do_idle+0x108/0x2b0
> > [27570.514884]  cpu_startup_entry+0x15/0x20
> > [27570.515301]  secondary_startup_64_no_verify+0xc3/0xcb
> > [27570.515858]
> > [27570.515997] write to 0xffff9dd1df5ecb50 of 1 bytes by task 176 on cpu 0:
> > [27570.516577]  rcu_nocb_cb_kthread+0x479/0x760
> > [27570.517358]  kthread+0x29b/0x2b0
> > [27570.517712]  ret_from_fork+0x22/0x30
> > [27570.518121]
> > [27570.518284] 1 lock held by rcuop/15/176:
> > [27570.518691]  #0: ffff9dd1df5ecc70 (&rdp->nocb_lock){-.-.}-{2:2}, at: rcu_nocb_cb_kthread+0x2ff/0x760
> > [27570.519677] irq event stamp: 20494903
> > [27570.520068] hardirqs last  enabled at (20494902): [<ffffffff9b0bf40a>] __local_bh_enable_ip+0xca/0x120
> > [27570.536982] hardirqs last disabled at (20494903): [<ffffffff9b1b28b7>] rcu_nocb_cb_kthread+0x2e7/0x760
> > [27570.537913] softirqs last  enabled at (20494901): [<ffffffff9b1ade6d>] local_bh_enable+0xd/0x30
> > [27570.538697] softirqs last disabled at (20494899): [<ffffffff9b1ad5dd>] local_bh_disable+0xd/0x30
> >
> > rcu_rdp_is_offloaded+0x63
> > 0xffffffff8119a543 is in rcu_rdp_is_offloaded (kernel/rcu/rcu_segcblist.h:71).
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> > 70      {
> > 71              return READ_ONCE(rsclp->flags) & flags;
> > 72      }
> > 73
> > 74      /*
> > 75       * Is the specified rcu_segcblist enabled, for example, not corresponding
> >
> > 0xffffffff811b2a49 is in rcu_nocb_cb_kthread (kernel/rcu/rcu_segcblist.h:65).
> > 60      }
> > 61
> > 62      static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
> > 63                                                   int flags)
> > 64      {
> > 65              rsclp->flags &= ~flags;
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> >
> > ------------------------------------------------------------------------
> >
> > BUG: KCSAN: data-race in rcu_nocb_gp_kthread / rcu_segcblist_ready_cbs
> >
> > [22938.718032] read (marked) to 0xffff9dd1df5ecb50 of 1 bytes by interrupt on cpu 15:
> > [22938.718839]  rcu_segcblist_ready_cbs+0x1a/0x40
> > [22938.719333]  rcu_core+0x351/0x860
> > [22938.719703]  rcu_core_si+0x12/0x20
> > [22938.720076]  __do_softirq+0x1f9/0x37c
> > [22938.720470]  run_ksoftirqd+0x4c/0x80
> > [22938.720879]  smpboot_thread_fn+0x28b/0x390
> > [22938.721339]  kthread+0x29b/0x2b0
> > [22938.721703]  ret_from_fork+0x22/0x30
> > [22938.722089]
> > [22938.722252] no locks held by ksoftirqd/15/173.
> > [22938.722719] irq event stamp: 1553879
> > [22938.723104] hardirqs last  enabled at (1553879): [<ffffffff9b1a7a8c>] note_gp_changes+0x1ac/0x1e0
> > [22938.723996] hardirqs last disabled at (1553878): [<ffffffff9b1a793b>] note_gp_changes+0x5b/0x1e0
> > [22938.724835] softirqs last  enabled at (1553871): [<ffffffff9b0c062c>] run_ksoftirqd+0x4c/0x80
> > [22938.736913] softirqs last disabled at (1553876): [<ffffffff9b0c062c>] run_ksoftirqd+0x4c/0x80
> > [22938.737836]
> > [22938.738013] write to 0xffff9dd1df5ecb50 of 1 bytes by task 154 on cpu 10:
> > [22938.738725]  rcu_nocb_gp_kthread+0x328/0x1180
> > [22938.739210]  kthread+0x29b/0x2b0
> > [22938.739564]  ret_from_fork+0x22/0x30
> > [22938.739963]
> > [22938.740141] 1 lock held by rcuog/12/154:
> > [22938.740578]  #0: ffff9dd1df5ecc70 (&rdp->nocb_lock){-.-.}-{2:2}, at: rcu_nocb_gp_kthread+0x2f2/0x1180
> > [22938.741584] irq event stamp: 19190924
> > [22938.741987] hardirqs last  enabled at (19190923): [<ffffffff9c71b23a>] _raw_spin_unlock_irqrestore+0x3a/0x70
> > [22938.743018] hardirqs last disabled at (19190924): [<ffffffff9b1b1722>] rcu_nocb_gp_kthread+0x2d2/0x1180
> > [22938.743991] softirqs last  enabled at (19189530): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> > [22938.744919] softirqs last disabled at (19189525): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> >
> > 0xffffffff811b397a is in rcu_segcblist_ready_cbs (kernel/rcu/rcu_segcblist.h:71).
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> > 70      {
> > 71              return READ_ONCE(rsclp->flags) & flags;
> > 72      }
> > 73
> > 74      /*
> > 75       * Is the specified rcu_segcblist enabled, for example, not corresponding
> >
> > 0xffffffff811b1778 is in rcu_nocb_gp_kthread (kernel/rcu/rcu_segcblist.h:65).
> > 60      }
> > 61
> > 62      static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
> > 63                                                   int flags)
> > 64      {
> > 65              rsclp->flags &= ~flags;
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> >
> > ------------------------------------------------------------------------
> >
> > BUG: KCSAN: data-race in rcu_core / rcu_nocb_gp_kthread
> >
> > [17703.531588] read (marked) to 0xffff9dd1df4ecb50 of 1 bytes by interrupt on cpu 11:
> > [17703.532349]  rcu_segcblist_ready_cbs+0x1a/0x40
> > [17703.532801]  rcu_core+0x351/0x860
> > [17703.533151]  rcu_core_si+0x12/0x20
> > [17703.533515]  __do_softirq+0x1f9/0x37c
> > [17703.533910]  run_ksoftirqd+0x4c/0x80
> > [17703.534296]  smpboot_thread_fn+0x28b/0x390
> > [17703.534741]  kthread+0x29b/0x2b0
> > [17703.535111]  ret_from_fork+0x22/0x30
> > [17703.535502]
> > [17703.535671] no locks held by ksoftirqd/11/143.
> > [17703.536162] irq event stamp: 1277315
> > [17703.536541] hardirqs last  enabled at (1277315): [<ffffffff9c71b23a>] _raw_spin_unlock_irqrestore+0x3a/0x70
> > [17703.537604] hardirqs last disabled at (1277314): [<ffffffff9b1a793b>] note_gp_changes+0x5b/0x1e0
> > [17703.538666] softirqs last  enabled at (1277307): [<ffffffff9b0c062c>] run_ksoftirqd+0x4c/0x80
> > [17703.539560] softirqs last disabled at (1277312): [<ffffffff9b0c062c>] run_ksoftirqd+0x4c/0x80
> > [17703.540445]
> > [17703.540611] write to 0xffff9dd1df4ecb50 of 1 bytes by task 117 on cpu 0:
> > [17703.541320]  rcu_nocb_gp_kthread+0x328/0x1180
> > [17703.541774]  kthread+0x29b/0x2b0
> > [17703.542154]  ret_from_fork+0x22/0x30
> > [17703.542544]
> > [17703.542712] 1 lock held by rcuog/8/117:
> > [17703.543126]  #0: ffff9dd1df4ecc70 (&rdp->nocb_lock){-.-.}-{2:2}, at: rcu_nocb_gp_kthread+0x2f2/0x1180
> > [17703.544068] irq event stamp: 14934462
> > [17703.544454] hardirqs last  enabled at (14934461): [<ffffffff9c71b23a>] _raw_spin_unlock_irqrestore+0x3a/0x70
> > [17703.545469] hardirqs last disabled at (14934462): [<ffffffff9b1b1722>] rcu_nocb_gp_kthread+0x2d2/0x1180
> > [17703.546442] softirqs last  enabled at (14934440): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> > [17703.547667] softirqs last disabled at (14934429): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> >
> > 0xffffffff811b397a is in rcu_segcblist_ready_cbs (kernel/rcu/rcu_segcblist.h:71).
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> > 70      {
> > 71              return READ_ONCE(rsclp->flags) & flags;
> > 72      }
> > 73
> > 74      /*
> > 75       * Is the specified rcu_segcblist enabled, for example, not corresponding
> >
> > 0xffffffff811b1778 is in rcu_nocb_gp_kthread (kernel/rcu/rcu_segcblist.h:65).
> > 60      }
> > 61
> > 62      static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
> > 63                                                   int flags)
> > 64      {
> > 65              rsclp->flags &= ~flags;
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> >
> > ------------------------------------------------------------------------
> >
> > BUG: KCSAN: data-race in rcu_nocb_cb_kthread / rcu_nocb_rdp_deoffload
> >
> > [25747.783445] read (marked) to 0xffff9dd1df5acb50 of 1 bytes by task 28476 on cpu 14:
> > [25747.784193]  rcu_nocb_rdp_deoffload+0x1a3/0x380
> > [25747.784675]  work_for_cpu_fn+0x32/0x50
> > [25747.785071]  process_one_work+0x54f/0x840
> > [25747.785488]  worker_thread+0x79c/0xa90
> > [25747.785884]  kthread+0x29b/0x2b0
> > [25747.786230]  ret_from_fork+0x22/0x30
> > [25747.786611]
> > [25747.786778] 2 locks held by kworker/14:2/28476:
> > [25747.787244]  #0: ffff9dd1c1054738 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x4d7/0x840
> > [25747.788196]  #1: ffffabe581ce3dd0 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_one_work+0x508/0x840
> > [25747.789216] irq event stamp: 47423
> > [25747.789563] hardirqs last  enabled at (47423): [<ffffffff9c71b23a>] _raw_spin_unlock_irqrestore+0x3a/0x70
> > [25747.790533] hardirqs last disabled at (47422): [<ffffffff9c71b053>] _raw_spin_lock_irqsave+0x53/0xb0
> > [25747.791450] softirqs last  enabled at (47410): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> > [25747.792253] softirqs last disabled at (47405): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> > [25747.804153]
> > [25747.804319] write to 0xffff9dd1df5acb50 of 1 bytes by task 169 on cpu 13:
> > [25747.805254]  rcu_nocb_cb_kthread+0x479/0x760
> > [25747.805701]  kthread+0x29b/0x2b0
> > [25747.806156]  ret_from_fork+0x22/0x30
> > [25747.806581]
> > [25747.806747] 1 lock held by rcuop/14/169:
> > [25747.807344]  #0: ffff9dd1df5acc70 (&rdp->nocb_lock){-.-.}-{2:2}, at: rcu_nocb_cb_kthread+0x2ff/0x760
> > [25747.809333] irq event stamp: 19677863
> > [25747.810093] hardirqs last  enabled at (19677862): [<ffffffff9b0bf40a>] __local_bh_enable_ip+0xca/0x120
> > [25747.820095] hardirqs last disabled at (19677863): [<ffffffff9b1b28b7>] rcu_nocb_cb_kthread+0x2e7/0x760
> > [25747.822317] softirqs last  enabled at (19677861): [<ffffffff9b1ade6d>] local_bh_enable+0xd/0x30
> > [25747.824060] softirqs last disabled at (19677859): [<ffffffff9b1ad5dd>] local_bh_disable+0xd/0x30
> >
> > 0xffffffff811a5853 is in rcu_nocb_rdp_deoffload (kernel/rcu/rcu_segcblist.h:71).
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> > 70      {
> > 71              return READ_ONCE(rsclp->flags) & flags;
> > 72      }
> > 73
> > 74      /*
> > 75       * Is the specified rcu_segcblist enabled, for example, not corresponding
> >
> > 0xffffffff811b2a49 is in rcu_nocb_cb_kthread (kernel/rcu/rcu_segcblist.h:65).
> > 60      }
> > 61
> > 62      static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
> > 63                                                   int flags)
> > 64      {
> > 65              rsclp->flags &= ~flags;
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> >
> > ------------------------------------------------------------------------
> >
> > BUG: KCSAN: data-race in rcu_nocb_gp_kthread / rcu_nocb_rdp_offload
> >
> > [15688.905747] read (marked) to 0xffff9dd1df56cb50 of 1 bytes by task 154 on cpu 9:
> > [15688.906550]  rcu_nocb_gp_kthread+0x237/0x1180
> > [15688.907050]  kthread+0x29b/0x2b0
> > [15688.907421]  ret_from_fork+0x22/0x30
> > [15688.907824]
> > [15688.908022] no locks held by rcuog/12/154.
> > [15688.908468] irq event stamp: 13085451
> > [15688.908865] hardirqs last  enabled at (13085451): [<ffffffff9c71b23a>] _raw_spin_unlock_irqrestore+0x3a/0x70
> > [15688.909929] hardirqs last disabled at (13085450): [<ffffffff9c71b053>] _raw_spin_lock_irqsave+0x53/0xb0
> > [15688.910949] softirqs last  enabled at (13085112): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> > [15688.911908] softirqs last disabled at (13085107): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> > [15688.912849]
> > [15688.913043] write to 0xffff9dd1df56cb50 of 1 bytes by task 16476 on cpu 13:
> > [15688.913830]  rcu_nocb_rdp_offload+0x24e/0x2c0
> > [15688.914364]  work_for_cpu_fn+0x32/0x50
> > [15688.914805]  process_one_work+0x54f/0x840
> > [15688.915159]  worker_thread+0x79c/0xa90
> > [15688.915544]  kthread+0x29b/0x2b0
> > [15688.915907]  ret_from_fork+0x22/0x30
> > [15688.916325]
> > [15688.916502] 3 locks held by kworker/13:0/16476:
> > [15688.917016]  #0: ffff9dd1c1054738 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x4d7/0x840
> > [15688.918073]  #1: ffffabe585163dd0 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_one_work+0x508/0x840
> > [15688.919153]  #2: ffff9dd1df56cc70 (&rdp->nocb_lock){-.-.}-{2:2}, at: rcu_nocb_rdp_offload+0x237/0x2c0
> > [15688.920171] irq event stamp: 198553
> > [15688.920539] hardirqs last  enabled at (198552): [<ffffffff9c71b23a>] _raw_spin_unlock_irqrestore+0x3a/0x70
> > [15688.921577] hardirqs last disabled at (198553): [<ffffffff9b1a5d5e>] rcu_nocb_rdp_offload+0x21e/0x2c0
> > [15688.922553] softirqs last  enabled at (198341): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> > [15688.923462] softirqs last disabled at (198336): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> >
> > 0xffffffff811b1687 is in rcu_nocb_gp_kthread (kernel/rcu/rcu_segcblist.h:71).
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> > 70      {
> > 71              return READ_ONCE(rsclp->flags) & flags;
> > 72      }
> > 73
> > 74      /*
> > 75       * Is the specified rcu_segcblist enabled, for example, not corresponding
> >
> > 0xffffffff811a5d8e is in rcu_nocb_rdp_offload (kernel/rcu/rcu_segcblist.h:65).
> > 60      }
> > 61
> > 62      static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
> > 63                                                   int flags)
> > 64      {
> > 65              rsclp->flags &= ~flags;
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> >
> > ------------------------------------------------------------------------
> >
> > BUG: KCSAN: data-race in rcu_nocb_gp_kthread / rcu_rdp_is_offloaded
> >
> > [30067.322599] read (marked) to 0xffff9dd1df2ecb50 of 1 bytes by interrupt on cpu 3:
> > [30067.323367]  rcu_rdp_is_offloaded+0x63/0x1c0
> > [30067.323929]  rcu_sched_clock_irq+0x9d2/0x18d0
> > [30067.324269]  update_process_times+0xe9/0x110
> > [30067.324692]  tick_sched_timer+0xfd/0x170
> > [30067.325195]  __hrtimer_run_queues+0x28a/0x450
> > [30067.325647]  hrtimer_interrupt+0x234/0x6d0
> > [30067.326519]  __sysvec_apic_timer_interrupt+0xb8/0x1a0
> > [30067.327039]  sysvec_apic_timer_interrupt+0x9a/0xc0
> > [30067.327557]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> > [30067.328105]  __tsan_read8+0x167/0x240
> > [30067.328503]  rcutorture_one_extend+0x211/0x590
> > [30067.328994]  rcu_torture_one_read+0x785/0xc90
> > [30067.329444]  rcu_torture_reader+0x19b/0x2e0
> > [30067.330309]  kthread+0x29b/0x2b0
> > [30067.330654]  ret_from_fork+0x22/0x30
> > [30067.331075]
> > [30067.331240] 2 locks held by rcu_torture_rea/93:
> > [30067.331700]  #0: ffffffff9d35c208 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire+0x11/0x40
> > [30067.332708]  #1: ffffffff9d35c238 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x11/0x40
> > [30067.333656] irq event stamp: 2508045894
> > [30067.334185] hardirqs last  enabled at (2508045893): [<ffffffff9b0bf40a>] __local_bh_enable_ip+0xca/0x120
> > [30067.335192] hardirqs last disabled at (2508045894): [<ffffffff9c70e1f7>] sysvec_apic_timer_interrupt+0x17/0xc0
> > [30067.342726] softirqs last  enabled at (2508045892): [<ffffffff9b1956fd>] local_bh_enable+0xd/0x30
> > [30067.354637] softirqs last disabled at (2508045890): [<ffffffff9b1956cd>] local_bh_disable+0xd/0x30
> > [30067.355483]
> > [30067.355627] write to 0xffff9dd1df2ecb50 of 1 bytes by task 15 on cpu 0:
> > [30067.356228]  rcu_nocb_gp_kthread+0x3a3/0x1180
> > [30067.356628]  kthread+0x29b/0x2b0
> > [30067.356936]  ret_from_fork+0x22/0x30
> > [30067.357284]
> > [30067.357431] 1 lock held by rcuog/0/15:
> > [30067.357873]  #0: ffff9dd1df2ecc70 (&rdp->nocb_lock){-.-.}-{2:2}, at: rcu_nocb_gp_kthread+0x2f2/0x1180
> > [30067.358746] irq event stamp: 19891260
> > [30067.359093] hardirqs last  enabled at (19891259): [<ffffffff9c71b23a>] _raw_spin_unlock_irqrestore+0x3a/0x70
> > [30067.359998] hardirqs last disabled at (19891260): [<ffffffff9b1b1722>] rcu_nocb_gp_kthread+0x2d2/0x1180
> > [30067.360860] softirqs last  enabled at (19890706): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> > [30067.361694] softirqs last disabled at (19890697): [<ffffffff9b0bf844>] __irq_exit_rcu+0x64/0xc0
> >
> > 0xffffffff8119a543 is in rcu_rdp_is_offloaded (kernel/rcu/rcu_segcblist.h:71).
> > 66      }
> > 67
> > 68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
> > 69                                                  int flags)
> > 70      {
> > 71              return READ_ONCE(rsclp->flags) & flags;
> > 72      }
> > 73
> > 74      /*
> > 75       * Is the specified rcu_segcblist enabled, for example, not corresponding
> >
> > 0xffffffff811b17f3 is in rcu_nocb_gp_kthread (kernel/rcu/rcu_segcblist.h:59).
> > 54      }
> > 55
> > 56      static inline void rcu_segcblist_set_flags(struct rcu_segcblist *rsclp,
> > 57                                                 int flags)
> > 58      {
> > 59              rsclp->flags |= flags;
> > 60      }
> > 61
> > 62      static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
> > 63                                                   int flags)
