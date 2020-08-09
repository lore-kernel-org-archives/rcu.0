Return-Path: <SRS0=RTr5=BT=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494DAC433E0
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169BE206B2
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 14:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCy1j8Zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHIOXJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 9 Aug 2020 10:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgHIOXJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 9 Aug 2020 10:23:09 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE77C061756
        for <rcu@vger.kernel.org>; Sun,  9 Aug 2020 07:23:08 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id i10so6924334ljn.2
        for <rcu@vger.kernel.org>; Sun, 09 Aug 2020 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSrnf7+vmZR5PjdCD2kFqfu8cWWCQdZ61Qmd33D/ocw=;
        b=ZCy1j8Zv96l9itfUw0yWWraDvdBuk471m8x9fyO8h8YEIJA/BuYW+75h++azMxlu+p
         j8w2gmTEnYCFoZ/BbqhVCW+5noqg80gaNckLvgPJVn02wrSx/XPmLe7S6nC2Xmo/EaaD
         Bq47nXY2p4qECfEOOxj0uAKUNTcqr5J60QG+6sLm57onWtihXazj+qzrBwl5p74Tizi/
         +lF2KSAd4pAbkwk7LK0YZVUstg0A8HBqVDRlDjhwZYb9tYgC2/TZCV+4T+guI/X6AUYj
         hnS4MOWX11Cl3KTlG2+NY780y91E2FHVBoEVst+Zr3/MgjFZh8DVhPR4TnNWhIo2Dxwa
         9wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSrnf7+vmZR5PjdCD2kFqfu8cWWCQdZ61Qmd33D/ocw=;
        b=jqlzsDymgtCMq95R1454qA0xNsf09gLfu3MNoyIu2mgZEi3tGD1kahsdAHnVdB0zIm
         kHU9kGvW0naYe/MlJFUssKDUtAdlRRGmiTc2PSW2DHfjHHRvf8fcLvGrcWK6sZCukQhv
         rpjeZhfxLShBQzHokzWjAObxtXLH2sO6v+hin+9lU8HwIjE3S40xLkhOFH0f375uoaak
         8NIOBTsSXnutFUGJDkRBL0IX/D/3VdPQzzv3UhXEDzKynQhbm2diHa2Q2MgQ/IBVvyNy
         2qFu8JS0xwmagOg94XvDugMj0P+q53RkrsdmroAxXk5d7dTC/lAqjAc6qDjyvIQTaTK+
         jbqg==
X-Gm-Message-State: AOAM530iwktC5b0nrG+1odu3wz6u8hKGUkQhWj1S1C10tbCwuZLSeAB9
        2wtq8BvN9FJJNP5yf1K33U0w6PXiUUrC3sQPej4=
X-Google-Smtp-Source: ABdhPJx/kPLzngWrd/EO8rlmU8s45qfbQZCVlU+MYzCEC71ylDItHUCFqh8HKCtPOJG3wxzouSURovHVOfbMOZo7pvs=
X-Received: by 2002:a2e:9dd0:: with SMTP id x16mr10043115ljj.144.1596982987149;
 Sun, 09 Aug 2020 07:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8i9mNFFrSqfoREnQoR-vrt+b_auq=xd9-yEP0eK-q1J-PvwA@mail.gmail.com>
 <CAF8i9mO3AcW+dnXvGsiJ7STu42OQEuqkTG0PGaCpZT=9OQq=Ug@mail.gmail.com>
 <CAF8i9mMJCdadZkVDxCENhQbEVD4wmA1hU50nBo6AOhU16Y6cMg@mail.gmail.com>
 <20200808220930.GD4295@paulmck-ThinkPad-P72> <CAF8i9mNTYhbOsA5QScM6EAZZz70Fa40JoTitxzLB-xoez5nLzw@mail.gmail.com>
 <20200809034608.GE4295@paulmck-ThinkPad-P72>
In-Reply-To: <20200809034608.GE4295@paulmck-ThinkPad-P72>
From:   William Tambe <tambewilliam@gmail.com>
Date:   Sun, 9 Aug 2020 09:22:54 -0500
Message-ID: <CAF8i9mO_LVbGPzafnkgRrLd8NzZHMuZBDpNQ78Nhfy7YpZc79w@mail.gmail.com>
Subject: Re: delayed_put_task_struct() used through call_rcu() by
 put_task_struct_rcu_user() never gets called
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Aug 8, 2020 at 10:46 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sat, Aug 08, 2020 at 09:31:11PM -0500, William Tambe wrote:
> > On Sat, Aug 8, 2020 at 5:09 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sat, Aug 08, 2020 at 04:19:42PM -0500, William Tambe wrote:
> > > > On Sat, Aug 8, 2020 at 4:17 PM William Tambe <tambewilliam@gmail.com> wrote:
> > > > >
> > > > > On Sat, Aug 8, 2020 at 1:21 PM William Tambe <tambewilliam@gmail.com> wrote:
> > > > > >
> > > > > > I am having an issue in my kernel where delayed_put_task_struct() used
> > > > > > through call_rcu() by put_task_struct_rcu_user() never gets called.
> > > > >
> > > > > I am able to trace this issue to invoke_rcu_core() not getting called
> > > > > in __call_rcu_core() due to rcu_is_watching() always returning true.
> > >
> > > That in fact should be the common case.  Normally, you would be invoking
> > > call_rcu() and thus __call_rcu_core() from a context that RCU is watching.
> > >
> > > But what happens after that in __call_rcu_core()?
> > >
> > > > > Any idea why I am seeing such an issue ?
> > >
> > > One way would be if every single one of your call_rcu() invocations was
> > > done with irqs disabled.  And if the scheduling-clock interrupt was turned
> > > off.  And if the CPU in question never received any other interrupts.
> > >
> > > As in all of those things have to be in effect in order to indefinitely
> > > postpone the call to delayed_put_task_struct().  In this case, v5.8's
> > > __call_rcu_core() would always exit via this path:
> > >
> > >         if (irqs_disabled_flags(flags) || cpu_is_offline(smp_processor_id()))
> > >                 return;
>
> Any status on this?

It does not return there and __call_rcu_core() continues executing.

>
> > > > Also, the issue is not happening when using highres=off .
> > >
> > > Might highres=off be forcing the scheduling-clock interrupt to be
> > > enabled?
> > >
> > > > > > Any idea ?
> > >
> > > If you are running oldish kernels and the CPU in question is a nohz_full
> > > CPU, the scheduling-clock interrupt would be turned off.  (In more recent
> > > kernel versions, RCU will force it back on if things are not progressing.)
> >
> > I am running v5.8.
>
> OK, good to know, and that means no need to worry about the various
> behaviors of older kernels.
>
> > I further observed that without highres=off, the function
> > tick_nohz_handler() is not getting called, hence
> > update_process_times() and rcu_sched_clock_irq() are not getting
> > called.
>
> But update_process_times() is invoked from various placed depending
> on configuration.
>
> > How can I debug why tick_nohz_handler() is not getting called when
> > booting without highres=off ?
>
> Given that tick_nohz_handler() is, according to it header comment,
> "The nohz low res interrupt handler", might this be expected behavior?
>
> > The timer interrupt is implemented as follow:
> >
> > void timer_intr (void) {
> >      arch_local_irq_disable();
> >      irq_enter();
> >      struct clock_event_device *e =
> >      per_cpu(clkevtdevs, smp_processor_id());
> >      e->event_handler(e);
> >     irq_exit();
> >     arch_local_irq_enable();
> > }
> >
> > >
> > > To say more, I would need your exact kernel version (including any
> > > patches and any other out-of-tree source code) and your .config file.
> >
> > I am using v5.8; currently unable to release out-of-tree source.
>
> I suggest comparing v5.8's actions on a hardware platform that is
> directly supported by v5.8 to its actions with your out-of-tree source.
> Given that v5.8 is running just fine elsewhere, the hope would be that
> this will help you find the bug, whether that bug be in v5.8 itself,
> or, as has historically been much more likely, in your out-of-tree source.
>
> For example, do your out-of-tree patches do anything with timer hardware?
> Bugs in that area commonly cause problems that look similar to what you
> are seeing.
>
> Alternatively, if you hardware platform is supported by stock v5.8,
> please try that for comparison purposes.
>
> > The defconfig is as follow:
> > CONFIG_NO_HZ_IDLE=y
>
> OK, non-idle CPUs should see scheduling-clock interrupts.
>
> > CONFIG_HIGH_RES_TIMERS=y
> > CONFIG_PREEMPT=y
> > CONFIG_IKCONFIG=y
> > CONFIG_IKCONFIG_PROC=y
> > CONFIG_KALLSYMS_ALL=y
> > CONFIG_USERFAULTFD=y
> > CONFIG_EMBEDDED=y
> > # CONFIG_SLUB_DEBUG is not set
> > CONFIG_SIMHDD=y
> > # CONFIG_MQ_IOSCHED_DEADLINE is not set
> > # CONFIG_MQ_IOSCHED_KYBER is not set
> > CONFIG_BINFMT_MISC=y
> > CONFIG_NET=y
> > CONFIG_PACKET=y
> > CONFIG_PACKET_DIAG=y
> > CONFIG_UNIX=y
> > CONFIG_UNIX_DIAG=y
> > CONFIG_INET=y
> > CONFIG_INET_UDP_DIAG=y
> > CONFIG_INET_RAW_DIAG=y
> > CONFIG_INET_DIAG_DESTROY=y
> > # CONFIG_IPV6 is not set
> > CONFIG_BRIDGE=y
> > CONFIG_NETLINK_DIAG=y
> > # CONFIG_WIRELESS is not set
> > # CONFIG_ETHTOOL_NETLINK is not set
> > CONFIG_DEVTMPFS=y
> > CONFIG_DEVTMPFS_MOUNT=y
> > CONFIG_BLK_DEV_LOOP=y
> > CONFIG_VT_HW_CONSOLE_BINDING=y
> > # CONFIG_LEGACY_PTYS is not set
> > # CONFIG_VGA_CONSOLE is not set
> > # CONFIG_VIRTIO_MENU is not set
> > # CONFIG_VHOST_MENU is not set
> > CONFIG_EXT4_FS=y
> > CONFIG_TMPFS=y
> > CONFIG_TMPFS_POSIX_ACL=y
> > # CONFIG_MISC_FILESYSTEMS is not set
> > CONFIG_NFS_FS=y
> > CONFIG_NFS_V3_ACL=y
> > CONFIG_NFS_V4=y
> > CONFIG_NFS_V4_1=y
> > CONFIG_DEBUG_INFO=y
> > CONFIG_GDB_SCRIPTS=y
> > CONFIG_DEBUG_KMEMLEAK=y
> > CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
> > CONFIG_SCHED_STACK_END_CHECK=y
> > CONFIG_DEBUG_MEMORY_INIT=y
> > CONFIG_PANIC_TIMEOUT=1
> > CONFIG_SOFTLOCKUP_DETECTOR=y
> > CONFIG_WQ_WATCHDOG=y
> > # CONFIG_RCU_TRACE is not set
> > CONFIG_RCU_EQS_DEBUG=y
>
> This should detect interrupt handlers and similar that are not properly
> announcing their entry and exit, so good.
>
> > # CONFIG_RUNTIME_TESTING_MENU is not set
> > CONFIG_MEMTEST=y
>
> Best of everything tracking this down!

Thanks

>
>                                                         Thanx, Paul
