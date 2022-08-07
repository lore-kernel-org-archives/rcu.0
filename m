Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F307AC19F2A
	for <rcu@archiver.kernel.org>; Sun,  7 Aug 2022 06:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiHGG4f (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 7 Aug 2022 02:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHGG4d (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 7 Aug 2022 02:56:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFD2DFCF
        for <rcu@vger.kernel.org>; Sat,  6 Aug 2022 23:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1550B80B2B
        for <rcu@vger.kernel.org>; Sun,  7 Aug 2022 06:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88858C433D6;
        Sun,  7 Aug 2022 06:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659855389;
        bh=HYzFyHXwyoiP0RexdeaPtIokgTTiYHg/mnfXxVdPVeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efVTjQWzugUHtHroQwyovIhxFnhir4mnH0HKlRgsg0Ke2ub5WDhDvU7glPzX/Ka7e
         XI4VyK2iHeELgkSRiIup94ul3MTmSdi8la/mNZ2VibZnxDPuroRDo3W8bP/Dr+gFKD
         CAgQuzdrjxbGl1gtFlSp38IFnDC3SCoo0G1ajYz4=
Date:   Sun, 7 Aug 2022 08:56:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, rcu@vger.kernel.org,
        hch@lst.de
Subject: Re: [vfs-next] RCU call-traces (task: modprobe)
Message-ID: <Yu9iGUv/jl7qpzPE@kroah.com>
References: <CA+icZUWUi_BJtjmewptMZWPUOT07FWBxu3A3yQTc-vM_F2XgTA@mail.gmail.com>
 <20220806163247.GZ2125313@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806163247.GZ2125313@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Aug 06, 2022 at 09:32:47AM -0700, Paul E. McKenney wrote:
> On Sat, Aug 06, 2022 at 08:31:26AM +0200, Sedat Dilek wrote:
> > Hi Al and Paul,
> > 
> > I pulled latest vfs-next on top of Linux v5.19 and see this in dmesg-logs:
> > 
> > root# LC_ALL=C dmesg -T | egrep -B5 -A15 'Call Trace:'
> > [Sat Aug  6 06:51:15 2022] Bluetooth: SCO socket layer initialized
> > [Sat Aug  6 06:51:15 2022] rcu: INFO: rcu_preempt detected expedited
> > stalls on CPUs/tasks: { 0-... } 6 jiffies s: 101 root: 0x1/.
> 
> This is because of the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20 in your
> .config file.  This is selected in kernels built with CONFIG_ANDROID=y,
> and results in an ultra-short 20-millisecond RCU CPU stall timeout for
> expedited grace periods.  Yes, the Android guys want and are getting
> milliseconds-scale response times from synchronize_rcu_expedited().
> 
> The last time someone ran into this, the upshot was that CONFIG_ANDROID
> was to be removed: https://lwn.net/Articles/899743/
> 
> My guess is that the CONFIG_ANDROID-removal patches are still on their way
> into mainline (they are in -next), but I added Greg KH and Christoph on CC
> just in case some other issue arose.

Not that I know of, those changes are all now in Linus's tree.

thanks,

greg k-h
