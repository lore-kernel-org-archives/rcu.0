Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FF9C00140
	for <rcu@archiver.kernel.org>; Wed, 10 Aug 2022 06:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiHJGHv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 Aug 2022 02:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiHJGHu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 Aug 2022 02:07:50 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E10161DAF
        for <rcu@vger.kernel.org>; Tue,  9 Aug 2022 23:07:49 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id bb16so16542671oib.11
        for <rcu@vger.kernel.org>; Tue, 09 Aug 2022 23:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/WQeDk9X8yQPjrr4EvDXd7eEWCvHY+GEzbtLSEI+10o=;
        b=KLcnv54hw9fZOQ97MuEakeeLcxQjGmVl+Pwcv3PAxl1IkX4A0Jzg9wU1bcreT49J4R
         nlWwZ9AzW6+NRVuayX70vliM8U9f2UXXfpxQbg/ojWG6ELHfXzdZEKMXhHxmJrR8WNZE
         ldq43nbXdY53XCY7KB2K4bOObt7mHkGjD5nI2E+XLefAZ8Jiio5Jl4q0L5PwbdrOphdR
         WggmvDOYtjzuigbpr3r0qSWbysyDK7s+jDQxz46nOYjANzeRQF7DyKIN3CnGa/EJShLo
         hZ2xAn20Nsp1sW/tslQxbaoc3RP/pyIEMVhVIy1sN070ocn2kEZpUeyR1js6s8bXxXzW
         1gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/WQeDk9X8yQPjrr4EvDXd7eEWCvHY+GEzbtLSEI+10o=;
        b=elUvE6C+FIaxmN6fpka/rIsj0tBiTpTI2XkT2GwpyDaZzm4dbB7o+gOaKhkODdnQ1o
         Gg5TsJPG3s1PlNsV8BT5HKgueUsuVnbTPzOv0fQKA1QT0OAnAc3CzBbAn1ygq1yrevkx
         GhpeqxvdD59FXe1/G7ku2mPLae85hrHIb+yJaSRGqEet3xLdUXDrOnKcv49mrposvEc0
         WFz2fhpunr/5QfOoCqAw7BUhp6Zpp7UFKzg8aV6CkQk83zIjUFMLbN75LuPqiKGU4qNl
         r1mvHhBv/U1CtDAuzlGU+Fkk0Rh+3aWvZsM4zaJTFRAnapryRSS3lbWaJ7MO23aX+yiL
         mbiA==
X-Gm-Message-State: ACgBeo1W7qI7+bGFZkgWXy6mJc18AEZFJZP+pG587/QIrDshcCc5P88g
        70LEFC/+kXUBdQy85+Ft43JKqtCBBfZcLaX3gJLmm96ZetMXiQ==
X-Google-Smtp-Source: AA6agR7QdiPwKsT4pQjW/QM1MExHioYpjPTFn2mC+MkXvBxOep0y9RJsvKMEbWrkrUCaOG4LBFCaGIH9NItVlZoW57o=
X-Received: by 2002:aca:aac2:0:b0:343:3435:a270 with SMTP id
 t185-20020acaaac2000000b003433435a270mr191960oie.252.1660111668673; Tue, 09
 Aug 2022 23:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWUi_BJtjmewptMZWPUOT07FWBxu3A3yQTc-vM_F2XgTA@mail.gmail.com>
 <20220806163247.GZ2125313@paulmck-ThinkPad-P17-Gen-1> <Yu9iGUv/jl7qpzPE@kroah.com>
 <20220808134358.GC2125313@paulmck-ThinkPad-P17-Gen-1> <CA+icZUUPgMe10=mD-OZS0DQDi7r10T7jEaOkxL1Na8poi_9azw@mail.gmail.com>
 <CA+icZUXanO7_-Nz1CfGTRMxAaHS7zsFEUsZENLgqLPnRAMuq2w@mail.gmail.com> <20220809141358.GL2125313@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220809141358.GL2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 10 Aug 2022 08:07:15 +0200
Message-ID: <CA+icZUVKuM+L+1JhdbqUU+eLS9n5hwTU2RL0B+f8rwkoj4qq=Q@mail.gmail.com>
Subject: Re: [vfs-next] RCU call-traces (task: modprobe)
To:     paulmck@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, rcu@vger.kernel.org,
        hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 9, 2022 at 4:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Aug 09, 2022 at 11:19:00AM +0200, Sedat Dilek wrote:
> > On Tue, Aug 9, 2022 at 11:06 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Mon, Aug 8, 2022 at 3:43 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Sun, Aug 07, 2022 at 08:56:25AM +0200, Greg KH wrote:
> > > > > On Sat, Aug 06, 2022 at 09:32:47AM -0700, Paul E. McKenney wrote:
> > > > > > On Sat, Aug 06, 2022 at 08:31:26AM +0200, Sedat Dilek wrote:
> > > > > > > Hi Al and Paul,
> > > > > > >
> > > > > > > I pulled latest vfs-next on top of Linux v5.19 and see this in dmesg-logs:
> > > > > > >
> > > > > > > root# LC_ALL=C dmesg -T | egrep -B5 -A15 'Call Trace:'
> > > > > > > [Sat Aug  6 06:51:15 2022] Bluetooth: SCO socket layer initialized
> > > > > > > [Sat Aug  6 06:51:15 2022] rcu: INFO: rcu_preempt detected expedited
> > > > > > > stalls on CPUs/tasks: { 0-... } 6 jiffies s: 101 root: 0x1/.
> > > > > >
> > > > > > This is because of the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20 in your
> > > > > > .config file.  This is selected in kernels built with CONFIG_ANDROID=y,
> > > > > > and results in an ultra-short 20-millisecond RCU CPU stall timeout for
> > > > > > expedited grace periods.  Yes, the Android guys want and are getting
> > > > > > milliseconds-scale response times from synchronize_rcu_expedited().
> > > > > >
> > > > > > The last time someone ran into this, the upshot was that CONFIG_ANDROID
> > > > > > was to be removed: https://lwn.net/Articles/899743/
> > > > > >
> > > > > > My guess is that the CONFIG_ANDROID-removal patches are still on their way
> > > > > > into mainline (they are in -next), but I added Greg KH and Christoph on CC
> > > > > > just in case some other issue arose.
> > > > >
> > > > > Not that I know of, those changes are all now in Linus's tree.
> > > >
> > > > And now that I do another pull, I do see them, thank you!
> > > >
> > > > So Sedat and Ben can just merge current mainline and be fine.
> > > >
> > >
> > > For the records:
> > >
> > > commit 1045a06724f322ed61f1ffb994427c7bdbe64647
> > > "remove CONFIG_ANDROID"
> > >
> > > diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> > > index 9b64e55d4f615..e875f4f889656 100644
> > > --- a/kernel/rcu/Kconfig.debug
> > > +++ b/kernel/rcu/Kconfig.debug
> > > @@ -86,8 +86,7 @@ config RCU_EXP_CPU_STALL_TIMEOUT
> > >   int "Expedited RCU CPU stall timeout in milliseconds"
> > >   depends on RCU_STALL_COMMON
> > >   range 0 21000
> > > - default 20 if ANDROID
> > > - default 0 if !ANDROID
> > > + default 0
> > >   help
> > >     If a given expedited RCU grace period extends more than the
> > >     specified number of milliseconds, a CPU stall warning is printed.
> > >
> > > -Sedat-
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1045a06724f322ed61f1ffb994427c7bdbe64647
> >
> > Hmm, with latest Debian-kernel I see the same call-trace as reported:
> >
> > root# grep -B5 -A15 'Call Trace:' dmesg-T_5.19.0-trunk-amd64.txt
> > 836-[Tue Aug  9 10:56:52 2022] iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
> > 837-[Tue Aug  9 10:56:52 2022] rcu: INFO: rcu_preempt detected
> > expedited stalls on CPUs/tasks: { 2-... } 6 jiffies s: 213 root: 0x4/.
>
> Given only 6 jiffies (then 25, then 44, and so on), this kernel still
> has ANDROID, and thus CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20, correct?
>
> Or are we seeing some other bug here?
>

This Debian-kernel has CONFIG_ANDROID=y.
No new bugs - just a confirmation.

-Sedat-

>                                                         Thanx, Paul
>
> > 838-[Tue Aug  9 10:56:52 2022] rcu: blocking rcu_node structures
> > (internal RCU debug):
> > 839-[Tue Aug  9 10:56:52 2022] Task dump for CPU 2:
> > 840-[Tue Aug  9 10:56:52 2022] task:systemd-udevd   state:R  running
> > task     stack:    0 pid:  347 ppid:   303 flags:0x00004008
> > 841:[Tue Aug  9 10:56:52 2022] Call Trace:
> > 842-[Tue Aug  9 10:56:52 2022]  <TASK>
> > 843-[Tue Aug  9 10:56:52 2022]  ? change_page_attr_set_clr+0x155/0x1c0
> > 844-[Tue Aug  9 10:56:52 2022]  ? ftrace_module_enable+0xad/0x370
> > 845-[Tue Aug  9 10:56:52 2022]  ? load_module+0x1bbc/0x2050
> > 846-[Tue Aug  9 10:56:52 2022]  ? __do_sys_finit_module+0xb4/0x130
> > 847-[Tue Aug  9 10:56:52 2022]  ? __do_sys_finit_module+0xb4/0x130
> > 848-[Tue Aug  9 10:56:52 2022]  ? do_syscall_64+0x3b/0xc0
> > 849-[Tue Aug  9 10:56:52 2022]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 850-[Tue Aug  9 10:56:52 2022]  </TASK>
> > 851-[Tue Aug  9 10:56:52 2022] rcu: INFO: rcu_preempt detected
> > expedited stalls on CPUs/tasks: { 2-... } 25 jiffies s: 213 root:
> > 0x4/.
> > 852-[Tue Aug  9 10:56:52 2022] rcu: blocking rcu_node structures
> > (internal RCU debug):
> > 853-[Tue Aug  9 10:56:52 2022] Task dump for CPU 2:
> > 854-[Tue Aug  9 10:56:52 2022] task:systemd-udevd   state:R  running
> > task     stack:    0 pid:  347 ppid:   303 flags:0x00004008
> > 855:[Tue Aug  9 10:56:52 2022] Call Trace:
> > 856-[Tue Aug  9 10:56:52 2022]  <TASK>
> > 857-[Tue Aug  9 10:56:52 2022]  ? change_page_attr_set_clr+0x155/0x1c0
> > 858-[Tue Aug  9 10:56:52 2022]  ? ftrace_module_enable+0xad/0x370
> > 859-[Tue Aug  9 10:56:52 2022]  ? load_module+0x1bbc/0x2050
> > 860-[Tue Aug  9 10:56:52 2022]  ? __do_sys_finit_module+0xb4/0x130
> > 861-[Tue Aug  9 10:56:52 2022]  ? __do_sys_finit_module+0xb4/0x130
> > 862-[Tue Aug  9 10:56:52 2022]  ? do_syscall_64+0x3b/0xc0
> > 863-[Tue Aug  9 10:56:52 2022]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 864-[Tue Aug  9 10:56:52 2022]  </TASK>
> > 865-[Tue Aug  9 10:56:53 2022] rcu: INFO: rcu_preempt detected
> > expedited stalls on CPUs/tasks: { 2-... } 44 jiffies s: 213 root:
> > 0x4/.
> > 866-[Tue Aug  9 10:56:53 2022] rcu: blocking rcu_node structures
> > (internal RCU debug):
> > 867-[Tue Aug  9 10:56:53 2022] Task dump for CPU 2:
> > 868-[Tue Aug  9 10:56:53 2022] task:systemd-udevd   state:R  running
> > task     stack:    0 pid:  347 ppid:   303 flags:0x00004008
> > 869:[Tue Aug  9 10:56:53 2022] Call Trace:
> > 870-[Tue Aug  9 10:56:53 2022]  <TASK>
> > 871-[Tue Aug  9 10:56:53 2022]  ? change_page_attr_set_clr+0x155/0x1c0
> > 872-[Tue Aug  9 10:56:53 2022]  ? ftrace_module_enable+0xad/0x370
> > 873-[Tue Aug  9 10:56:53 2022]  ? load_module+0x1bbc/0x2050
> > 874-[Tue Aug  9 10:56:53 2022]  ? __do_sys_finit_module+0xb4/0x130
> > 875-[Tue Aug  9 10:56:53 2022]  ? __do_sys_finit_module+0xb4/0x130
> > 876-[Tue Aug  9 10:56:53 2022]  ? do_syscall_64+0x3b/0xc0
> > 877-[Tue Aug  9 10:56:53 2022]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 878-[Tue Aug  9 10:56:53 2022]  </TASK>
> > 879-[Tue Aug  9 10:56:53 2022] rcu: INFO: rcu_preempt detected
> > expedited stalls on CPUs/tasks: { 2-... } 63 jiffies s: 213 root:
> > 0x4/.
> > 880-[Tue Aug  9 10:56:53 2022] rcu: blocking rcu_node structures
> > (internal RCU debug):
> > 881-[Tue Aug  9 10:56:53 2022] Task dump for CPU 2:
> > 882-[Tue Aug  9 10:56:53 2022] task:systemd-udevd   state:R  running
> > task     stack:    0 pid:  347 ppid:   303 flags:0x00004008
> > 883:[Tue Aug  9 10:56:53 2022] Call Trace:
> > 884-[Tue Aug  9 10:56:53 2022]  <TASK>
> > 885-[Tue Aug  9 10:56:53 2022]  ? change_page_attr_set_clr+0x155/0x1c0
> > 886-[Tue Aug  9 10:56:53 2022]  ? ftrace_module_enable+0xad/0x370
> > 887-[Tue Aug  9 10:56:53 2022]  ? load_module+0x1bbc/0x2050
> > 888-[Tue Aug  9 10:56:53 2022]  ? __do_sys_finit_module+0xb4/0x130
> > 889-[Tue Aug  9 10:56:53 2022]  ? __do_sys_finit_module+0xb4/0x130
> > 890-[Tue Aug  9 10:56:53 2022]  ? do_syscall_64+0x3b/0xc0
> > 891-[Tue Aug  9 10:56:53 2022]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 892-[Tue Aug  9 10:56:53 2022]  </TASK>
> > 893-[Tue Aug  9 10:56:53 2022] zram0: detected capacity change from 0 to 1004656
> > 894-[Tue Aug  9 10:56:53 2022] i915 0000:00:02.0: vgaarb: deactivate vga console
> > 895-[Tue Aug  9 10:56:53 2022] Console: switching to colour dummy device 80x25
> > 896-[Tue Aug  9 10:56:53 2022] i915 0000:00:02.0: vgaarb: changed VGA
> > decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> > 897-[Tue Aug  9 10:56:53 2022] [drm] Initialized i915 1.6.0 20201103
> > for 0000:00:02.0 on minor 0
> > 898-[Tue Aug  9 10:56:53 2022] ACPI: video: Video Device [GFX0]
> > (multi-head: yes  rom: no  post: no)
> >
> > Just see Ben integrated [1]:
> >
> > android: Remove CONFIG_ANDROID
> > - Drop "wireguard: Clear keys after suspend despite CONFIG_ANDROID=y"
> > - pm/sleep: Add PM_USERSPACE_AUTOSLEEP Kconfig
> > - remove CONFIG_ANDROID
> > - Enable/disable ANDROID_BINDER_IPC to match previous configuration
> >
> > This fixes two more cases where kernel behaviour was changed by
> > CONFIG_ANDROID.
> >
> > -Sedat-
> >
> > [1] https://salsa.debian.org/kernel-team/linux/-/commit/78fcd943947d24bb162fcebf1a9ca86795e1b2b1
