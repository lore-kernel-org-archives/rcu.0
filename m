Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808D3C19F2D
	for <rcu@archiver.kernel.org>; Tue,  9 Aug 2022 09:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiHIJHM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 9 Aug 2022 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiHIJHL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 9 Aug 2022 05:07:11 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4266F625A
        for <rcu@vger.kernel.org>; Tue,  9 Aug 2022 02:07:09 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id c185so13137661oia.7
        for <rcu@vger.kernel.org>; Tue, 09 Aug 2022 02:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc;
        bh=z0K1iyY9/fnHfT9pwxmEtemgZmcr3HrkpTlZN4B8ap8=;
        b=BwajYxe4ARuN6CG+4g1oFUO7T3uMEXeSVJdLai5+ced+VCeGYjJor0PaqgXUHC6HCr
         tKERxeYVo46iADpcL0bbEmyd37i1xEiol86Ip5owJ71Dgbv2Lc+YOobNiewktVj+TXvQ
         SnxXG4fokMC2eKLq+VVUbJDcNfrH+sj0qhBIBwkps0Kz2GgWv7sgDuBv77F/p3w3dEV7
         ptwCIFsOaz46Pc7VZr0MU7/wzvIznwWiaIGtDHh0moEcn8JWMe6PPLmTSdrdDFi4F7kT
         PKBMIE96ex3VrY7+58r8PQG9My2Bjap/mzX2KPm6URW0INR7o2N8tEDlACXYA8Ysiglq
         4MSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=z0K1iyY9/fnHfT9pwxmEtemgZmcr3HrkpTlZN4B8ap8=;
        b=AVesz4+IxVPYeXV+lQ5p4LpLz08zoLGAaOuQNDZ9OEZyTDINEW0rKzN1p3NsqHPoNZ
         39bD/1P8Lloyv1uT8dl1b7ja/9jLVDKedtH/cnpKq5LCzllMSFFnspJp6IbjxdV7vBY+
         aQpwEW9UkibuTYe6RxNYfWR2DuMgRE8RV4Tp7q4xmenFSCeXNIoWAg/ELXVvst8m0wSM
         mhkpjMrvUWwhWWVXit/OJGVElEagJSlFB1MtaA0HTdumiUC5dFv51af1M7HByiOfmouP
         yMVlTVS747J34xhcPL5u0ApmdRT8DmTIH2xk1fUQe+qchN3ztUiPwm/3USJzVhRjdRnf
         y3MA==
X-Gm-Message-State: ACgBeo28XQ8hDsRSwQVd+S1WdBq/P2XTMBgZhgZrd5GV67HuSnnLdmaP
        JLjydPAKwvne41jn/h+GX94+2Z0IRIi+1/miWC8=
X-Google-Smtp-Source: AA6agR5aJV4qGGjeJbn2iJnLOhDH+n+WGbLW+14w7bSsqd+uTX8ww4xsOZkT7+fwKLGgEVTO9fBah3zhWwaPUWnOzyU=
X-Received: by 2002:a05:6808:302b:b0:2f9:eeef:f03 with SMTP id
 ay43-20020a056808302b00b002f9eeef0f03mr12467005oib.128.1660036028511; Tue, 09
 Aug 2022 02:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWUi_BJtjmewptMZWPUOT07FWBxu3A3yQTc-vM_F2XgTA@mail.gmail.com>
 <20220806163247.GZ2125313@paulmck-ThinkPad-P17-Gen-1> <Yu9iGUv/jl7qpzPE@kroah.com>
 <20220808134358.GC2125313@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220808134358.GC2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 9 Aug 2022 11:06:32 +0200
Message-ID: <CA+icZUUPgMe10=mD-OZS0DQDi7r10T7jEaOkxL1Na8poi_9azw@mail.gmail.com>
Subject: Re: [vfs-next] RCU call-traces (task: modprobe)
To:     paulmck@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, rcu@vger.kernel.org,
        hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 8, 2022 at 3:43 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Aug 07, 2022 at 08:56:25AM +0200, Greg KH wrote:
> > On Sat, Aug 06, 2022 at 09:32:47AM -0700, Paul E. McKenney wrote:
> > > On Sat, Aug 06, 2022 at 08:31:26AM +0200, Sedat Dilek wrote:
> > > > Hi Al and Paul,
> > > >
> > > > I pulled latest vfs-next on top of Linux v5.19 and see this in dmesg-logs:
> > > >
> > > > root# LC_ALL=C dmesg -T | egrep -B5 -A15 'Call Trace:'
> > > > [Sat Aug  6 06:51:15 2022] Bluetooth: SCO socket layer initialized
> > > > [Sat Aug  6 06:51:15 2022] rcu: INFO: rcu_preempt detected expedited
> > > > stalls on CPUs/tasks: { 0-... } 6 jiffies s: 101 root: 0x1/.
> > >
> > > This is because of the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20 in your
> > > .config file.  This is selected in kernels built with CONFIG_ANDROID=y,
> > > and results in an ultra-short 20-millisecond RCU CPU stall timeout for
> > > expedited grace periods.  Yes, the Android guys want and are getting
> > > milliseconds-scale response times from synchronize_rcu_expedited().
> > >
> > > The last time someone ran into this, the upshot was that CONFIG_ANDROID
> > > was to be removed: https://lwn.net/Articles/899743/
> > >
> > > My guess is that the CONFIG_ANDROID-removal patches are still on their way
> > > into mainline (they are in -next), but I added Greg KH and Christoph on CC
> > > just in case some other issue arose.
> >
> > Not that I know of, those changes are all now in Linus's tree.
>
> And now that I do another pull, I do see them, thank you!
>
> So Sedat and Ben can just merge current mainline and be fine.
>

For the records:

commit 1045a06724f322ed61f1ffb994427c7bdbe64647
"remove CONFIG_ANDROID"

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 9b64e55d4f615..e875f4f889656 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -86,8 +86,7 @@ config RCU_EXP_CPU_STALL_TIMEOUT
  int "Expedited RCU CPU stall timeout in milliseconds"
  depends on RCU_STALL_COMMON
  range 0 21000
- default 20 if ANDROID
- default 0 if !ANDROID
+ default 0
  help
    If a given expedited RCU grace period extends more than the
    specified number of milliseconds, a CPU stall warning is printed.

-Sedat-

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1045a06724f322ed61f1ffb994427c7bdbe64647
