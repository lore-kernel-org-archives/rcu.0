Return-Path: <SRS0=RTr5=BT=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E37C433E0
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 16:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE12E2068F
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 16:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsVblkNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHIQ0n (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIQ0m (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 9 Aug 2020 12:26:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F05C061756
        for <rcu@vger.kernel.org>; Sun,  9 Aug 2020 09:26:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b30so3462199lfj.12
        for <rcu@vger.kernel.org>; Sun, 09 Aug 2020 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3TrqkBcxuPgJ5n/mzaBH0WhN/CH/4ntcRLPmuS75U4=;
        b=tsVblkNY6ahyMCWQTZ5HOqMBvpmYJSk04hT0Ikh9dycdyZenZnvBlnIT8kde9FiKHo
         snBr3w0yeXl2gBo+Z2l4bXpKqovuHyhfwXgHe8r9Zn3Ef/xojXBCUcDbVj7Tor1xVxJ2
         AssTM0ec1YCleI7Kfvq9fTnRepjPY3vGPNWicpcnXQGNxr5oDhCeGi6QuaoRwqcI9iuz
         F5qo1HC+jVPiGF9Nz9p1ngqRG1dWUZPd+WCQuBSeY71VQ8I42ZX+DoghCZAfHHWg+t1p
         Cn/meYwerGD1RPdE9T9M7I0m87wuL9FhkdDLGusCsS/0J0Wozb4/sGHWdjk+NLN0QI8+
         B37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3TrqkBcxuPgJ5n/mzaBH0WhN/CH/4ntcRLPmuS75U4=;
        b=VbkpCVGP5kcDQpOQeox7Zz+AZvLXa7gAwtIatvIRuBRCfH+ojjIdHkFrU1g4Zrthhx
         xYImlyamKteWm/prwg3fCqXPk1J676Wrz/LUBhxGyQwSfEcEq++J2ln/NiDFGqJ8CkrO
         m6fmZmo/ZAH1UZ5AF1/5e0bXLr3YU4cNq62JZ6H13cr8rOs4rneWFm1u3XQeP4Zkv3El
         bd1eAQkMaW0Ig396e2syEznc/En5jjIxhpm7P52w0GN7ABtoiy7B27WT3DX+9MekMOYF
         onQU2KS9nyQVsQE5J2//Xg4HAAoWGMQC2ekV1G+Hd7qKIs8VZULD1c178vEnSWU9M74i
         4PXA==
X-Gm-Message-State: AOAM532XKg+0SZ3cGptH7/aeBBo2hM+fhxgG/orYD3hoZm8i+jOEM1Tl
        OH8e1wKRRS84lroZlAo9xnEgPCIRS14gz+Mz9c0yQGYJ
X-Google-Smtp-Source: ABdhPJzalnJZkTDh7SlrYl0hfFjss22cZI18JpJWle7yS9QVLUg//px6X6uxltjaYOWCPpecLbpE2OzWgrLFcHHpFVc=
X-Received: by 2002:a19:8314:: with SMTP id f20mr11574266lfd.199.1596990400218;
 Sun, 09 Aug 2020 09:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8i9mNFFrSqfoREnQoR-vrt+b_auq=xd9-yEP0eK-q1J-PvwA@mail.gmail.com>
 <CAF8i9mO3AcW+dnXvGsiJ7STu42OQEuqkTG0PGaCpZT=9OQq=Ug@mail.gmail.com>
 <CAF8i9mMJCdadZkVDxCENhQbEVD4wmA1hU50nBo6AOhU16Y6cMg@mail.gmail.com>
 <20200808220930.GD4295@paulmck-ThinkPad-P72> <CAF8i9mNTYhbOsA5QScM6EAZZz70Fa40JoTitxzLB-xoez5nLzw@mail.gmail.com>
 <20200809034608.GE4295@paulmck-ThinkPad-P72> <CAF8i9mO_LVbGPzafnkgRrLd8NzZHMuZBDpNQ78Nhfy7YpZc79w@mail.gmail.com>
 <20200809153538.GF4295@paulmck-ThinkPad-P72>
In-Reply-To: <20200809153538.GF4295@paulmck-ThinkPad-P72>
From:   William Tambe <tambewilliam@gmail.com>
Date:   Sun, 9 Aug 2020 11:26:27 -0500
Message-ID: <CAF8i9mMAcfqb_i87oR2OMDQtVfM_wXJJ0qnmGhyySRR+rBwdFA@mail.gmail.com>
Subject: Re: delayed_put_task_struct() used through call_rcu() by
 put_task_struct_rcu_user() never gets called
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 9, 2020 at 10:35 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Aug 09, 2020 at 09:22:54AM -0500, William Tambe wrote:
> > On Sat, Aug 8, 2020 at 10:46 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sat, Aug 08, 2020 at 09:31:11PM -0500, William Tambe wrote:
> > > > On Sat, Aug 8, 2020 at 5:09 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Sat, Aug 08, 2020 at 04:19:42PM -0500, William Tambe wrote:
> > > > > > On Sat, Aug 8, 2020 at 4:17 PM William Tambe <tambewilliam@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sat, Aug 8, 2020 at 1:21 PM William Tambe <tambewilliam@gmail.com> wrote:
> > > > > > > >
> > > > > > > > I am having an issue in my kernel where delayed_put_task_struct() used
> > > > > > > > through call_rcu() by put_task_struct_rcu_user() never gets called.
> > > > > > >
> > > > > > > I am able to trace this issue to invoke_rcu_core() not getting called
> > > > > > > in __call_rcu_core() due to rcu_is_watching() always returning true.
> > > > >
> > > > > That in fact should be the common case.  Normally, you would be invoking
> > > > > call_rcu() and thus __call_rcu_core() from a context that RCU is watching.
> > > > >
> > > > > But what happens after that in __call_rcu_core()?
> > > > >
> > > > > > > Any idea why I am seeing such an issue ?
> > > > >
> > > > > One way would be if every single one of your call_rcu() invocations was
> > > > > done with irqs disabled.  And if the scheduling-clock interrupt was turned
> > > > > off.  And if the CPU in question never received any other interrupts.
> > > > >
> > > > > As in all of those things have to be in effect in order to indefinitely
> > > > > postpone the call to delayed_put_task_struct().  In this case, v5.8's
> > > > > __call_rcu_core() would always exit via this path:
> > > > >
> > > > >         if (irqs_disabled_flags(flags) || cpu_is_offline(smp_processor_id()))
> > > > >                 return;
> > >
> > > Any status on this?
> >
> > It does not return there and __call_rcu_core() continues executing.
>
> Thank you, and presumably the next "if" does not trigger, at least not
> unless that CPU has more than 10,000 callbacks queued (given the usual
> default settings).
>
> I am also assuming that callbacks are -not- offloaded because I did
> not see CONFIG_RCU_NOCB_CPUS=y
>
> Until that 10,000th callback is queued, RCU is relying on either a return
> to idle or a scheduling-clock interrupt.  In the idle case:
>
> o       If CONFIG_RCU_FAST_NO_HZ=y, RCU will ask for a four-jiffies timer
>         out of idle.  It will also periodically assign grace periods to
>         new callbacks.  The question in this case is "What is preventing
>         the call out of idle?"  I didn't see this in your defconfig, so
>         I am assuming this is -not- your system is set up.
>
> o       If CONFIG_RCU_FAST_NO_HZ=n, RCU will ask that the scheduling-clock
>         interrupt be left enabled, despite the return to idle.  This puts
>         us into the next case, the scheduling-clock interrupt.
>
>         You should be able to check this by looking at the return value
>         from the rcu_needs_cpu() function on this CPU, which should be
>         non-zero given that you have a callback queued on the current CPU.
>         (It is just fine for other CPUs without callbacks to return zero,
>         by the way.)

I do not have CONFIG_RCU_FAST_NO_HZ; it is not defined in my config.

Using a breakpoint at rcu_needs_cpu(), I see it always returning 1.

Note that my setup is a single CPU, and without SMP in the kernel.

>
> A scheduling-clock interrupt invokes rcu_sched_clock_irq(), which
> invokes rcu_pending(), which on a CPU with newly queued callbacks
> should return non-zero via this path or some earlier one:
>
>         /* Has RCU gone idle with this CPU needing another grace period? */
>         if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
>             (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
>              !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
>             !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
>                 return 1;
>
> If the CPU is not getting scheduling-clock interrupts (as in no calls to
> update_process_times() and thus no calls to rcu_sched_clock_irq()), then
> that is a bug that you need to fix.  Note that different CPU architectures
> invoke update_process_times() in different ways from different places.
> And even the generic support invokes update_process_times() from either
> tick_periodic() or tick_sched_handle(), depending on configuration.

I am expecting update_process_times() to be called by the timer
interrupt through e->event_handler(e);

Without using highres=off, the timer interrupt is calling
hrtimer_interrupt() through e->event_handler(e);
With using highres=off, the timer interrupt is calling
tick_nohz_handler() through e->event_handler(e);

When tick_nohz_handler() is used, update_process_times() gets called.
When hrtimer_interrupt() is used, update_process_times() does not get called.

Note that the issue I am seeing occurs when I do not use highres=off ,
in other words issue occurs with high resolution timers enabled.

>
> Then you will need to work out what is happening instead, given the
> expectations for whatever CPU architecture and configuration you are
> using.
>
>                                                         Thanx, Paul
>
> > > > > > Also, the issue is not happening when using highres=off .
> > > > >
> > > > > Might highres=off be forcing the scheduling-clock interrupt to be
> > > > > enabled?
> > > > >
> > > > > > > > Any idea ?
> > > > >
> > > > > If you are running oldish kernels and the CPU in question is a nohz_full
> > > > > CPU, the scheduling-clock interrupt would be turned off.  (In more recent
> > > > > kernel versions, RCU will force it back on if things are not progressing.)
> > > >
> > > > I am running v5.8.
> > >
> > > OK, good to know, and that means no need to worry about the various
> > > behaviors of older kernels.
> > >
> > > > I further observed that without highres=off, the function
> > > > tick_nohz_handler() is not getting called, hence
> > > > update_process_times() and rcu_sched_clock_irq() are not getting
> > > > called.
> > >
> > > But update_process_times() is invoked from various placed depending
> > > on configuration.
> > >
> > > > How can I debug why tick_nohz_handler() is not getting called when
> > > > booting without highres=off ?
> > >
> > > Given that tick_nohz_handler() is, according to it header comment,
> > > "The nohz low res interrupt handler", might this be expected behavior?
> > >
> > > > The timer interrupt is implemented as follow:
> > > >
> > > > void timer_intr (void) {
> > > >      arch_local_irq_disable();
> > > >      irq_enter();
> > > >      struct clock_event_device *e =
> > > >      per_cpu(clkevtdevs, smp_processor_id());
> > > >      e->event_handler(e);
> > > >     irq_exit();
> > > >     arch_local_irq_enable();
> > > > }
> > > >
> > > > >
> > > > > To say more, I would need your exact kernel version (including any
> > > > > patches and any other out-of-tree source code) and your .config file.
> > > >
> > > > I am using v5.8; currently unable to release out-of-tree source.
> > >
> > > I suggest comparing v5.8's actions on a hardware platform that is
> > > directly supported by v5.8 to its actions with your out-of-tree source.
> > > Given that v5.8 is running just fine elsewhere, the hope would be that
> > > this will help you find the bug, whether that bug be in v5.8 itself,
> > > or, as has historically been much more likely, in your out-of-tree source.
> > >
> > > For example, do your out-of-tree patches do anything with timer hardware?
> > > Bugs in that area commonly cause problems that look similar to what you
> > > are seeing.
> > >
> > > Alternatively, if you hardware platform is supported by stock v5.8,
> > > please try that for comparison purposes.
> > >
> > > > The defconfig is as follow:
> > > > CONFIG_NO_HZ_IDLE=y
> > >
> > > OK, non-idle CPUs should see scheduling-clock interrupts.
> > >
> > > > CONFIG_HIGH_RES_TIMERS=y
> > > > CONFIG_PREEMPT=y
> > > > CONFIG_IKCONFIG=y
> > > > CONFIG_IKCONFIG_PROC=y
> > > > CONFIG_KALLSYMS_ALL=y
> > > > CONFIG_USERFAULTFD=y
> > > > CONFIG_EMBEDDED=y
> > > > # CONFIG_SLUB_DEBUG is not set
> > > > CONFIG_SIMHDD=y
> > > > # CONFIG_MQ_IOSCHED_DEADLINE is not set
> > > > # CONFIG_MQ_IOSCHED_KYBER is not set
> > > > CONFIG_BINFMT_MISC=y
> > > > CONFIG_NET=y
> > > > CONFIG_PACKET=y
> > > > CONFIG_PACKET_DIAG=y
> > > > CONFIG_UNIX=y
> > > > CONFIG_UNIX_DIAG=y
> > > > CONFIG_INET=y
> > > > CONFIG_INET_UDP_DIAG=y
> > > > CONFIG_INET_RAW_DIAG=y
> > > > CONFIG_INET_DIAG_DESTROY=y
> > > > # CONFIG_IPV6 is not set
> > > > CONFIG_BRIDGE=y
> > > > CONFIG_NETLINK_DIAG=y
> > > > # CONFIG_WIRELESS is not set
> > > > # CONFIG_ETHTOOL_NETLINK is not set
> > > > CONFIG_DEVTMPFS=y
> > > > CONFIG_DEVTMPFS_MOUNT=y
> > > > CONFIG_BLK_DEV_LOOP=y
> > > > CONFIG_VT_HW_CONSOLE_BINDING=y
> > > > # CONFIG_LEGACY_PTYS is not set
> > > > # CONFIG_VGA_CONSOLE is not set
> > > > # CONFIG_VIRTIO_MENU is not set
> > > > # CONFIG_VHOST_MENU is not set
> > > > CONFIG_EXT4_FS=y
> > > > CONFIG_TMPFS=y
> > > > CONFIG_TMPFS_POSIX_ACL=y
> > > > # CONFIG_MISC_FILESYSTEMS is not set
> > > > CONFIG_NFS_FS=y
> > > > CONFIG_NFS_V3_ACL=y
> > > > CONFIG_NFS_V4=y
> > > > CONFIG_NFS_V4_1=y
> > > > CONFIG_DEBUG_INFO=y
> > > > CONFIG_GDB_SCRIPTS=y
> > > > CONFIG_DEBUG_KMEMLEAK=y
> > > > CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
> > > > CONFIG_SCHED_STACK_END_CHECK=y
> > > > CONFIG_DEBUG_MEMORY_INIT=y
> > > > CONFIG_PANIC_TIMEOUT=1
> > > > CONFIG_SOFTLOCKUP_DETECTOR=y
> > > > CONFIG_WQ_WATCHDOG=y
> > > > # CONFIG_RCU_TRACE is not set
> > > > CONFIG_RCU_EQS_DEBUG=y
> > >
> > > This should detect interrupt handlers and similar that are not properly
> > > announcing their entry and exit, so good.
> > >
> > > > # CONFIG_RUNTIME_TESTING_MENU is not set
> > > > CONFIG_MEMTEST=y
> > >
> > > Best of everything tracking this down!
> >
> > Thanks
> >
> > >
> > >                                                         Thanx, Paul
