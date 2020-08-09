Return-Path: <SRS0=RTr5=BT=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39179C433E0
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 03:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECB72065C
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 03:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596944771;
	bh=bFlUlDV3Cihkr8evBW0G/Xjt6hvHyIsxuvJnwJ3lPxA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=y1UHj2eDCsn8tmneH8UFB+B6pdq9alJhdLkn4L7keb5DNTy6kLAf+HXq1ebNESyCO
	 BHQDbfGlrvrEKz0CPfzhP0HQrEHB6oaRnc0UWcYAr+ruveZBhfAZoKqongUi/yJxzx
	 N9hMUbNcrqiTBmfQ6GduFJgzOtJJdrmKpXAhU69c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgHIDqK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 8 Aug 2020 23:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgHIDqK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 8 Aug 2020 23:46:10 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 197672065C;
        Sun,  9 Aug 2020 03:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596944769;
        bh=bFlUlDV3Cihkr8evBW0G/Xjt6hvHyIsxuvJnwJ3lPxA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fQCrCO5kmI3sHLDFCfv5zPT2dMif2M1ETsafzww/AA+N6+qFjs1h8p3uE+xbkTmtp
         j/sYCTB3TNcA4TOJQrVaZeHxX84Ke7wxJp40PCz29TnXHrMh1XZJZoHexOK6PB8AyG
         YEx5jXlzIYFos+YC+8BT4XS5LO6u3FRsvX1mqYIE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D11A73522FEF; Sat,  8 Aug 2020 20:46:08 -0700 (PDT)
Date:   Sat, 8 Aug 2020 20:46:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     William Tambe <tambewilliam@gmail.com>
Cc:     rcu@vger.kernel.org
Subject: Re: delayed_put_task_struct() used through call_rcu() by
 put_task_struct_rcu_user() never gets called
Message-ID: <20200809034608.GE4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAF8i9mNFFrSqfoREnQoR-vrt+b_auq=xd9-yEP0eK-q1J-PvwA@mail.gmail.com>
 <CAF8i9mO3AcW+dnXvGsiJ7STu42OQEuqkTG0PGaCpZT=9OQq=Ug@mail.gmail.com>
 <CAF8i9mMJCdadZkVDxCENhQbEVD4wmA1hU50nBo6AOhU16Y6cMg@mail.gmail.com>
 <20200808220930.GD4295@paulmck-ThinkPad-P72>
 <CAF8i9mNTYhbOsA5QScM6EAZZz70Fa40JoTitxzLB-xoez5nLzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8i9mNTYhbOsA5QScM6EAZZz70Fa40JoTitxzLB-xoez5nLzw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Aug 08, 2020 at 09:31:11PM -0500, William Tambe wrote:
> On Sat, Aug 8, 2020 at 5:09 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sat, Aug 08, 2020 at 04:19:42PM -0500, William Tambe wrote:
> > > On Sat, Aug 8, 2020 at 4:17 PM William Tambe <tambewilliam@gmail.com> wrote:
> > > >
> > > > On Sat, Aug 8, 2020 at 1:21 PM William Tambe <tambewilliam@gmail.com> wrote:
> > > > >
> > > > > I am having an issue in my kernel where delayed_put_task_struct() used
> > > > > through call_rcu() by put_task_struct_rcu_user() never gets called.
> > > >
> > > > I am able to trace this issue to invoke_rcu_core() not getting called
> > > > in __call_rcu_core() due to rcu_is_watching() always returning true.
> >
> > That in fact should be the common case.  Normally, you would be invoking
> > call_rcu() and thus __call_rcu_core() from a context that RCU is watching.
> >
> > But what happens after that in __call_rcu_core()?
> >
> > > > Any idea why I am seeing such an issue ?
> >
> > One way would be if every single one of your call_rcu() invocations was
> > done with irqs disabled.  And if the scheduling-clock interrupt was turned
> > off.  And if the CPU in question never received any other interrupts.
> >
> > As in all of those things have to be in effect in order to indefinitely
> > postpone the call to delayed_put_task_struct().  In this case, v5.8's
> > __call_rcu_core() would always exit via this path:
> >
> >         if (irqs_disabled_flags(flags) || cpu_is_offline(smp_processor_id()))
> >                 return;

Any status on this?

> > > Also, the issue is not happening when using highres=off .
> >
> > Might highres=off be forcing the scheduling-clock interrupt to be
> > enabled?
> >
> > > > > Any idea ?
> >
> > If you are running oldish kernels and the CPU in question is a nohz_full
> > CPU, the scheduling-clock interrupt would be turned off.  (In more recent
> > kernel versions, RCU will force it back on if things are not progressing.)
> 
> I am running v5.8.

OK, good to know, and that means no need to worry about the various
behaviors of older kernels.

> I further observed that without highres=off, the function
> tick_nohz_handler() is not getting called, hence
> update_process_times() and rcu_sched_clock_irq() are not getting
> called.

But update_process_times() is invoked from various placed depending
on configuration.

> How can I debug why tick_nohz_handler() is not getting called when
> booting without highres=off ?

Given that tick_nohz_handler() is, according to it header comment,
"The nohz low res interrupt handler", might this be expected behavior?

> The timer interrupt is implemented as follow:
> 
> void timer_intr (void) {
>      arch_local_irq_disable();
>      irq_enter();
>      struct clock_event_device *e =
>      per_cpu(clkevtdevs, smp_processor_id());
>      e->event_handler(e);
>     irq_exit();
>     arch_local_irq_enable();
> }
> 
> >
> > To say more, I would need your exact kernel version (including any
> > patches and any other out-of-tree source code) and your .config file.
> 
> I am using v5.8; currently unable to release out-of-tree source.

I suggest comparing v5.8's actions on a hardware platform that is
directly supported by v5.8 to its actions with your out-of-tree source.
Given that v5.8 is running just fine elsewhere, the hope would be that
this will help you find the bug, whether that bug be in v5.8 itself,
or, as has historically been much more likely, in your out-of-tree source.

For example, do your out-of-tree patches do anything with timer hardware?
Bugs in that area commonly cause problems that look similar to what you
are seeing.

Alternatively, if you hardware platform is supported by stock v5.8,
please try that for comparison purposes.

> The defconfig is as follow:
> CONFIG_NO_HZ_IDLE=y

OK, non-idle CPUs should see scheduling-clock interrupts.

> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_PREEMPT=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_USERFAULTFD=y
> CONFIG_EMBEDDED=y
> # CONFIG_SLUB_DEBUG is not set
> CONFIG_SIMHDD=y
> # CONFIG_MQ_IOSCHED_DEADLINE is not set
> # CONFIG_MQ_IOSCHED_KYBER is not set
> CONFIG_BINFMT_MISC=y
> CONFIG_NET=y
> CONFIG_PACKET=y
> CONFIG_PACKET_DIAG=y
> CONFIG_UNIX=y
> CONFIG_UNIX_DIAG=y
> CONFIG_INET=y
> CONFIG_INET_UDP_DIAG=y
> CONFIG_INET_RAW_DIAG=y
> CONFIG_INET_DIAG_DESTROY=y
> # CONFIG_IPV6 is not set
> CONFIG_BRIDGE=y
> CONFIG_NETLINK_DIAG=y
> # CONFIG_WIRELESS is not set
> # CONFIG_ETHTOOL_NETLINK is not set
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> # CONFIG_LEGACY_PTYS is not set
> # CONFIG_VGA_CONSOLE is not set
> # CONFIG_VIRTIO_MENU is not set
> # CONFIG_VHOST_MENU is not set
> CONFIG_EXT4_FS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> # CONFIG_MISC_FILESYSTEMS is not set
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3_ACL=y
> CONFIG_NFS_V4=y
> CONFIG_NFS_V4_1=y
> CONFIG_DEBUG_INFO=y
> CONFIG_GDB_SCRIPTS=y
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
> CONFIG_SCHED_STACK_END_CHECK=y
> CONFIG_DEBUG_MEMORY_INIT=y
> CONFIG_PANIC_TIMEOUT=1
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_WQ_WATCHDOG=y
> # CONFIG_RCU_TRACE is not set
> CONFIG_RCU_EQS_DEBUG=y

This should detect interrupt handlers and similar that are not properly
announcing their entry and exit, so good.

> # CONFIG_RUNTIME_TESTING_MENU is not set
> CONFIG_MEMTEST=y

Best of everything tracking this down!

							Thanx, Paul
