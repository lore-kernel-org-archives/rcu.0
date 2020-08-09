Return-Path: <SRS0=RTr5=BT=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887FEC433E0
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 02:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4862067D
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 02:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vR5NpTCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgHICb2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgHICb1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 8 Aug 2020 22:31:27 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEF9C061756
        for <rcu@vger.kernel.org>; Sat,  8 Aug 2020 19:31:26 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h19so6030354ljg.13
        for <rcu@vger.kernel.org>; Sat, 08 Aug 2020 19:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRAjS3+tkvgTpiTNv/xLXAY72qAg5x+du22av1rW7q8=;
        b=vR5NpTCxEoMmixkPF/mcwDEwFIRz2bqGI1IuRX3K6Gw6IfrSfLljGZT7pRyFMD+0t9
         FHbq4A5X77kzuL27LMH+xGYaT6JNEtNmeUNkoSsbf6w1SAS3BUc3EW7tBCoiX/9rF/Cn
         M35XyhwhPLM2BVDgE/btz/61WXkXy6KE56WlZOT6Tjs75xRE2h+W20rtyWJ7cPF0eVIU
         pfclrFMmDW3iesfoiwJyCJAX6WQzGa3P897jbEK1uaaHT40x47GBOgNZo2S5Krs7lBNa
         vAB3c9RPRMgrGBh9rs0ALEi4gT4vd3sviyjd/WlG3us3ijDIeGVoYR25FM3NDwcSqmYk
         1uCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRAjS3+tkvgTpiTNv/xLXAY72qAg5x+du22av1rW7q8=;
        b=mPOBHatLQrZF3xKw0lDivX41Ro+o5ovK8pCaRQNJq/9ra+kkJ8a4BpbfVzBDWQqw0N
         dNInt3yytB7PiC0q7Bxo9hWCaVxjuMJABP4LMF+7u8xglGmuuZX0OHmOTdZLPLLu7Lhm
         qwhrzGpBt289o1XVTgHA1GDRf+BI/wppETYYGi3s3BMl8ukjhGozSrxDM46OFBJdAHy7
         ZMSAJlYUwg81iC0sZ+/Sw60exSJUBBrSoaggTHLc5o14nclljzrZtU/qBSnKmnMduAa7
         8LhGfvbBGT49Tnf8OKngZXDfFoG+/nuE2i9SHTbcqQ671oBa5mn5lFCfGBndxq9rTPHh
         GVng==
X-Gm-Message-State: AOAM5333JUW6Cw5SVdTBiSSb+Wy9scqfJqoIbq4FMa2ZHQn8MHU9C97J
        kcXjOp+z8XWLzqxbuTuyQh+2OSGJCEP4P32W5optveyS
X-Google-Smtp-Source: ABdhPJzocR7x9fTIyN5YRfVMlroxnukyK4wnTxZMK7MxlSDM0nNUFC/kulhyPt5fammpEfS+A3iNelqpUyGJPpiDUhc=
X-Received: by 2002:a2e:9396:: with SMTP id g22mr10287872ljh.446.1596940283934;
 Sat, 08 Aug 2020 19:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8i9mNFFrSqfoREnQoR-vrt+b_auq=xd9-yEP0eK-q1J-PvwA@mail.gmail.com>
 <CAF8i9mO3AcW+dnXvGsiJ7STu42OQEuqkTG0PGaCpZT=9OQq=Ug@mail.gmail.com>
 <CAF8i9mMJCdadZkVDxCENhQbEVD4wmA1hU50nBo6AOhU16Y6cMg@mail.gmail.com> <20200808220930.GD4295@paulmck-ThinkPad-P72>
In-Reply-To: <20200808220930.GD4295@paulmck-ThinkPad-P72>
From:   William Tambe <tambewilliam@gmail.com>
Date:   Sat, 8 Aug 2020 21:31:11 -0500
Message-ID: <CAF8i9mNTYhbOsA5QScM6EAZZz70Fa40JoTitxzLB-xoez5nLzw@mail.gmail.com>
Subject: Re: delayed_put_task_struct() used through call_rcu() by
 put_task_struct_rcu_user() never gets called
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Aug 8, 2020 at 5:09 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sat, Aug 08, 2020 at 04:19:42PM -0500, William Tambe wrote:
> > On Sat, Aug 8, 2020 at 4:17 PM William Tambe <tambewilliam@gmail.com> wrote:
> > >
> > > On Sat, Aug 8, 2020 at 1:21 PM William Tambe <tambewilliam@gmail.com> wrote:
> > > >
> > > > I am having an issue in my kernel where delayed_put_task_struct() used
> > > > through call_rcu() by put_task_struct_rcu_user() never gets called.
> > >
> > > I am able to trace this issue to invoke_rcu_core() not getting called
> > > in __call_rcu_core() due to rcu_is_watching() always returning true.
>
> That in fact should be the common case.  Normally, you would be invoking
> call_rcu() and thus __call_rcu_core() from a context that RCU is watching.
>
> But what happens after that in __call_rcu_core()?
>
> > > Any idea why I am seeing such an issue ?
>
> One way would be if every single one of your call_rcu() invocations was
> done with irqs disabled.  And if the scheduling-clock interrupt was turned
> off.  And if the CPU in question never received any other interrupts.
>
> As in all of those things have to be in effect in order to indefinitely
> postpone the call to delayed_put_task_struct().  In this case, v5.8's
> __call_rcu_core() would always exit via this path:
>
>         if (irqs_disabled_flags(flags) || cpu_is_offline(smp_processor_id()))
>                 return;
>
> > Also, the issue is not happening when using highres=off .
>
> Might highres=off be forcing the scheduling-clock interrupt to be
> enabled?
>
> > > > Any idea ?
>
> If you are running oldish kernels and the CPU in question is a nohz_full
> CPU, the scheduling-clock interrupt would be turned off.  (In more recent
> kernel versions, RCU will force it back on if things are not progressing.)

I am running v5.8.

I further observed that without highres=off, the function
tick_nohz_handler() is not getting called, hence
update_process_times() and rcu_sched_clock_irq() are not getting
called.

How can I debug why tick_nohz_handler() is not getting called when
booting without highres=off ?

The timer interrupt is implemented as follow:

void timer_intr (void) {
     arch_local_irq_disable();
     irq_enter();
     struct clock_event_device *e =
     per_cpu(clkevtdevs, smp_processor_id());
     e->event_handler(e);
    irq_exit();
    arch_local_irq_enable();
}

>
> To say more, I would need your exact kernel version (including any
> patches and any other out-of-tree source code) and your .config file.

I am using v5.8; currently unable to release out-of-tree source.

The defconfig is as follow:
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS_ALL=y
CONFIG_USERFAULTFD=y
CONFIG_EMBEDDED=y
# CONFIG_SLUB_DEBUG is not set
CONFIG_SIMHDD=y
# CONFIG_MQ_IOSCHED_DEADLINE is not set
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_BINFMT_MISC=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=y
CONFIG_INET=y
CONFIG_INET_UDP_DIAG=y
CONFIG_INET_RAW_DIAG=y
CONFIG_INET_DIAG_DESTROY=y
# CONFIG_IPV6 is not set
CONFIG_BRIDGE=y
CONFIG_NETLINK_DIAG=y
# CONFIG_WIRELESS is not set
# CONFIG_ETHTOOL_NETLINK is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_VT_HW_CONSOLE_BINDING=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_VGA_CONSOLE is not set
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VHOST_MENU is not set
CONFIG_EXT4_FS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_V4_1=y
CONFIG_DEBUG_INFO=y
CONFIG_GDB_SCRIPTS=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_PANIC_TIMEOUT=1
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_WQ_WATCHDOG=y
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y

>
>                                                         Thanx, Paul
