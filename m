Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD15C19F2D
	for <rcu@archiver.kernel.org>; Tue,  9 Aug 2022 14:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiHIOOE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 9 Aug 2022 10:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242643AbiHIOOC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 9 Aug 2022 10:14:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5965C11C2F
        for <rcu@vger.kernel.org>; Tue,  9 Aug 2022 07:14:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9ED8B8111F
        for <rcu@vger.kernel.org>; Tue,  9 Aug 2022 14:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B825C4314C;
        Tue,  9 Aug 2022 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660054438;
        bh=OfAT/IBAIcgv7Cp7h0SzLUbkzSKrcww1Ft7qJtWvLjA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fhVrXg16xcbe4B1m81lDd4Vljrns9agOw0SmBj8yT5B6ucea1bB64o8TskXxvsniO
         vohOIAspXcTCRmmO8ANxcLxMDzj/lckJPjHqaHGAPTjChRZPo82xIJoaAdWJOduMER
         WbYG3gsFw+NFKup7q7A1/a20m4Mh9RRV1obdRIlRqID/5wVk48bkcCxJMJPY5q7G5r
         iziHCnnlEh7S2NoKe4urlIGRqW0qzc26Is4CNb8UySckqF3EHbSf5yIFoTC4iHJyjy
         N8zjv89v5sRdvmropwtt69OszyyeA4dA0lydYhqerEacEUk+pumWZ4pjbrqncJF/mu
         4LNMPfFyLb28Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 46FA45C0151; Tue,  9 Aug 2022 07:13:58 -0700 (PDT)
Date:   Tue, 9 Aug 2022 07:13:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, rcu@vger.kernel.org,
        hch@lst.de
Subject: Re: [vfs-next] RCU call-traces (task: modprobe)
Message-ID: <20220809141358.GL2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CA+icZUWUi_BJtjmewptMZWPUOT07FWBxu3A3yQTc-vM_F2XgTA@mail.gmail.com>
 <20220806163247.GZ2125313@paulmck-ThinkPad-P17-Gen-1>
 <Yu9iGUv/jl7qpzPE@kroah.com>
 <20220808134358.GC2125313@paulmck-ThinkPad-P17-Gen-1>
 <CA+icZUUPgMe10=mD-OZS0DQDi7r10T7jEaOkxL1Na8poi_9azw@mail.gmail.com>
 <CA+icZUXanO7_-Nz1CfGTRMxAaHS7zsFEUsZENLgqLPnRAMuq2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXanO7_-Nz1CfGTRMxAaHS7zsFEUsZENLgqLPnRAMuq2w@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 09, 2022 at 11:19:00AM +0200, Sedat Dilek wrote:
> On Tue, Aug 9, 2022 at 11:06 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Mon, Aug 8, 2022 at 3:43 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sun, Aug 07, 2022 at 08:56:25AM +0200, Greg KH wrote:
> > > > On Sat, Aug 06, 2022 at 09:32:47AM -0700, Paul E. McKenney wrote:
> > > > > On Sat, Aug 06, 2022 at 08:31:26AM +0200, Sedat Dilek wrote:
> > > > > > Hi Al and Paul,
> > > > > >
> > > > > > I pulled latest vfs-next on top of Linux v5.19 and see this in dmesg-logs:
> > > > > >
> > > > > > root# LC_ALL=C dmesg -T | egrep -B5 -A15 'Call Trace:'
> > > > > > [Sat Aug  6 06:51:15 2022] Bluetooth: SCO socket layer initialized
> > > > > > [Sat Aug  6 06:51:15 2022] rcu: INFO: rcu_preempt detected expedited
> > > > > > stalls on CPUs/tasks: { 0-... } 6 jiffies s: 101 root: 0x1/.
> > > > >
> > > > > This is because of the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20 in your
> > > > > .config file.  This is selected in kernels built with CONFIG_ANDROID=y,
> > > > > and results in an ultra-short 20-millisecond RCU CPU stall timeout for
> > > > > expedited grace periods.  Yes, the Android guys want and are getting
> > > > > milliseconds-scale response times from synchronize_rcu_expedited().
> > > > >
> > > > > The last time someone ran into this, the upshot was that CONFIG_ANDROID
> > > > > was to be removed: https://lwn.net/Articles/899743/
> > > > >
> > > > > My guess is that the CONFIG_ANDROID-removal patches are still on their way
> > > > > into mainline (they are in -next), but I added Greg KH and Christoph on CC
> > > > > just in case some other issue arose.
> > > >
> > > > Not that I know of, those changes are all now in Linus's tree.
> > >
> > > And now that I do another pull, I do see them, thank you!
> > >
> > > So Sedat and Ben can just merge current mainline and be fine.
> > >
> >
> > For the records:
> >
> > commit 1045a06724f322ed61f1ffb994427c7bdbe64647
> > "remove CONFIG_ANDROID"
> >
> > diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> > index 9b64e55d4f615..e875f4f889656 100644
> > --- a/kernel/rcu/Kconfig.debug
> > +++ b/kernel/rcu/Kconfig.debug
> > @@ -86,8 +86,7 @@ config RCU_EXP_CPU_STALL_TIMEOUT
> >   int "Expedited RCU CPU stall timeout in milliseconds"
> >   depends on RCU_STALL_COMMON
> >   range 0 21000
> > - default 20 if ANDROID
> > - default 0 if !ANDROID
> > + default 0
> >   help
> >     If a given expedited RCU grace period extends more than the
> >     specified number of milliseconds, a CPU stall warning is printed.
> >
> > -Sedat-
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1045a06724f322ed61f1ffb994427c7bdbe64647
> 
> Hmm, with latest Debian-kernel I see the same call-trace as reported:
> 
> root# grep -B5 -A15 'Call Trace:' dmesg-T_5.19.0-trunk-amd64.txt
> 836-[Tue Aug  9 10:56:52 2022] iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
> 837-[Tue Aug  9 10:56:52 2022] rcu: INFO: rcu_preempt detected
> expedited stalls on CPUs/tasks: { 2-... } 6 jiffies s: 213 root: 0x4/.

Given only 6 jiffies (then 25, then 44, and so on), this kernel still
has ANDROID, and thus CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20, correct?

Or are we seeing some other bug here?

							Thanx, Paul

> 838-[Tue Aug  9 10:56:52 2022] rcu: blocking rcu_node structures
> (internal RCU debug):
> 839-[Tue Aug  9 10:56:52 2022] Task dump for CPU 2:
> 840-[Tue Aug  9 10:56:52 2022] task:systemd-udevd   state:R  running
> task     stack:    0 pid:  347 ppid:   303 flags:0x00004008
> 841:[Tue Aug  9 10:56:52 2022] Call Trace:
> 842-[Tue Aug  9 10:56:52 2022]  <TASK>
> 843-[Tue Aug  9 10:56:52 2022]  ? change_page_attr_set_clr+0x155/0x1c0
> 844-[Tue Aug  9 10:56:52 2022]  ? ftrace_module_enable+0xad/0x370
> 845-[Tue Aug  9 10:56:52 2022]  ? load_module+0x1bbc/0x2050
> 846-[Tue Aug  9 10:56:52 2022]  ? __do_sys_finit_module+0xb4/0x130
> 847-[Tue Aug  9 10:56:52 2022]  ? __do_sys_finit_module+0xb4/0x130
> 848-[Tue Aug  9 10:56:52 2022]  ? do_syscall_64+0x3b/0xc0
> 849-[Tue Aug  9 10:56:52 2022]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 850-[Tue Aug  9 10:56:52 2022]  </TASK>
> 851-[Tue Aug  9 10:56:52 2022] rcu: INFO: rcu_preempt detected
> expedited stalls on CPUs/tasks: { 2-... } 25 jiffies s: 213 root:
> 0x4/.
> 852-[Tue Aug  9 10:56:52 2022] rcu: blocking rcu_node structures
> (internal RCU debug):
> 853-[Tue Aug  9 10:56:52 2022] Task dump for CPU 2:
> 854-[Tue Aug  9 10:56:52 2022] task:systemd-udevd   state:R  running
> task     stack:    0 pid:  347 ppid:   303 flags:0x00004008
> 855:[Tue Aug  9 10:56:52 2022] Call Trace:
> 856-[Tue Aug  9 10:56:52 2022]  <TASK>
> 857-[Tue Aug  9 10:56:52 2022]  ? change_page_attr_set_clr+0x155/0x1c0
> 858-[Tue Aug  9 10:56:52 2022]  ? ftrace_module_enable+0xad/0x370
> 859-[Tue Aug  9 10:56:52 2022]  ? load_module+0x1bbc/0x2050
> 860-[Tue Aug  9 10:56:52 2022]  ? __do_sys_finit_module+0xb4/0x130
> 861-[Tue Aug  9 10:56:52 2022]  ? __do_sys_finit_module+0xb4/0x130
> 862-[Tue Aug  9 10:56:52 2022]  ? do_syscall_64+0x3b/0xc0
> 863-[Tue Aug  9 10:56:52 2022]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 864-[Tue Aug  9 10:56:52 2022]  </TASK>
> 865-[Tue Aug  9 10:56:53 2022] rcu: INFO: rcu_preempt detected
> expedited stalls on CPUs/tasks: { 2-... } 44 jiffies s: 213 root:
> 0x4/.
> 866-[Tue Aug  9 10:56:53 2022] rcu: blocking rcu_node structures
> (internal RCU debug):
> 867-[Tue Aug  9 10:56:53 2022] Task dump for CPU 2:
> 868-[Tue Aug  9 10:56:53 2022] task:systemd-udevd   state:R  running
> task     stack:    0 pid:  347 ppid:   303 flags:0x00004008
> 869:[Tue Aug  9 10:56:53 2022] Call Trace:
> 870-[Tue Aug  9 10:56:53 2022]  <TASK>
> 871-[Tue Aug  9 10:56:53 2022]  ? change_page_attr_set_clr+0x155/0x1c0
> 872-[Tue Aug  9 10:56:53 2022]  ? ftrace_module_enable+0xad/0x370
> 873-[Tue Aug  9 10:56:53 2022]  ? load_module+0x1bbc/0x2050
> 874-[Tue Aug  9 10:56:53 2022]  ? __do_sys_finit_module+0xb4/0x130
> 875-[Tue Aug  9 10:56:53 2022]  ? __do_sys_finit_module+0xb4/0x130
> 876-[Tue Aug  9 10:56:53 2022]  ? do_syscall_64+0x3b/0xc0
> 877-[Tue Aug  9 10:56:53 2022]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 878-[Tue Aug  9 10:56:53 2022]  </TASK>
> 879-[Tue Aug  9 10:56:53 2022] rcu: INFO: rcu_preempt detected
> expedited stalls on CPUs/tasks: { 2-... } 63 jiffies s: 213 root:
> 0x4/.
> 880-[Tue Aug  9 10:56:53 2022] rcu: blocking rcu_node structures
> (internal RCU debug):
> 881-[Tue Aug  9 10:56:53 2022] Task dump for CPU 2:
> 882-[Tue Aug  9 10:56:53 2022] task:systemd-udevd   state:R  running
> task     stack:    0 pid:  347 ppid:   303 flags:0x00004008
> 883:[Tue Aug  9 10:56:53 2022] Call Trace:
> 884-[Tue Aug  9 10:56:53 2022]  <TASK>
> 885-[Tue Aug  9 10:56:53 2022]  ? change_page_attr_set_clr+0x155/0x1c0
> 886-[Tue Aug  9 10:56:53 2022]  ? ftrace_module_enable+0xad/0x370
> 887-[Tue Aug  9 10:56:53 2022]  ? load_module+0x1bbc/0x2050
> 888-[Tue Aug  9 10:56:53 2022]  ? __do_sys_finit_module+0xb4/0x130
> 889-[Tue Aug  9 10:56:53 2022]  ? __do_sys_finit_module+0xb4/0x130
> 890-[Tue Aug  9 10:56:53 2022]  ? do_syscall_64+0x3b/0xc0
> 891-[Tue Aug  9 10:56:53 2022]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 892-[Tue Aug  9 10:56:53 2022]  </TASK>
> 893-[Tue Aug  9 10:56:53 2022] zram0: detected capacity change from 0 to 1004656
> 894-[Tue Aug  9 10:56:53 2022] i915 0000:00:02.0: vgaarb: deactivate vga console
> 895-[Tue Aug  9 10:56:53 2022] Console: switching to colour dummy device 80x25
> 896-[Tue Aug  9 10:56:53 2022] i915 0000:00:02.0: vgaarb: changed VGA
> decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> 897-[Tue Aug  9 10:56:53 2022] [drm] Initialized i915 1.6.0 20201103
> for 0000:00:02.0 on minor 0
> 898-[Tue Aug  9 10:56:53 2022] ACPI: video: Video Device [GFX0]
> (multi-head: yes  rom: no  post: no)
> 
> Just see Ben integrated [1]:
> 
> android: Remove CONFIG_ANDROID
> - Drop "wireguard: Clear keys after suspend despite CONFIG_ANDROID=y"
> - pm/sleep: Add PM_USERSPACE_AUTOSLEEP Kconfig
> - remove CONFIG_ANDROID
> - Enable/disable ANDROID_BINDER_IPC to match previous configuration
> 
> This fixes two more cases where kernel behaviour was changed by
> CONFIG_ANDROID.
> 
> -Sedat-
> 
> [1] https://salsa.debian.org/kernel-team/linux/-/commit/78fcd943947d24bb162fcebf1a9ca86795e1b2b1
