Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6D0C00140
	for <rcu@archiver.kernel.org>; Mon,  8 Aug 2022 13:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbiHHNoC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiHHNoB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 8 Aug 2022 09:44:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A611121
        for <rcu@vger.kernel.org>; Mon,  8 Aug 2022 06:44:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2D34B80E9C
        for <rcu@vger.kernel.org>; Mon,  8 Aug 2022 13:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A30C433D6;
        Mon,  8 Aug 2022 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659966238;
        bh=VJBsDYmvb0tQ2OO7CTTXe/4HN6XlJAgfCTKTxzfO45k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bKVsJXpwhz5YKZShTyPDpOZfq1/YJo3qH4l5ItdNeEE6KIoMb9fvlu0xfxz3fPLaR
         eGOhpWK2R02su2KLM/kkD5cWmnjaUjw5HFLOWgasW3bMf/9xWmUZPeJTvnBJrC+aAH
         fwSZ6D4YkwkIcMi3AXBw17iIVAdIvjWr0JuRbTP3j+H06SvxpJCv3RRzkNFdSO0q4J
         Xm+Lsr5M85VQ6YZZEtik8hLvnB68ARRCn0udOauFizYf3RBV+PW4F6SNbQwqnMfaaF
         IQ3zBZS+RwlCSTJrq1IoePdThCSEMQlvTw73niK0x3MQ7GZtdxsAPLAC1CIEx3pqD0
         8MOsuuP6mDx+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 252FB5C0A55; Mon,  8 Aug 2022 06:43:58 -0700 (PDT)
Date:   Mon, 8 Aug 2022 06:43:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, rcu@vger.kernel.org,
        hch@lst.de
Subject: Re: [vfs-next] RCU call-traces (task: modprobe)
Message-ID: <20220808134358.GC2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CA+icZUWUi_BJtjmewptMZWPUOT07FWBxu3A3yQTc-vM_F2XgTA@mail.gmail.com>
 <20220806163247.GZ2125313@paulmck-ThinkPad-P17-Gen-1>
 <Yu9iGUv/jl7qpzPE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu9iGUv/jl7qpzPE@kroah.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 07, 2022 at 08:56:25AM +0200, Greg KH wrote:
> On Sat, Aug 06, 2022 at 09:32:47AM -0700, Paul E. McKenney wrote:
> > On Sat, Aug 06, 2022 at 08:31:26AM +0200, Sedat Dilek wrote:
> > > Hi Al and Paul,
> > > 
> > > I pulled latest vfs-next on top of Linux v5.19 and see this in dmesg-logs:
> > > 
> > > root# LC_ALL=C dmesg -T | egrep -B5 -A15 'Call Trace:'
> > > [Sat Aug  6 06:51:15 2022] Bluetooth: SCO socket layer initialized
> > > [Sat Aug  6 06:51:15 2022] rcu: INFO: rcu_preempt detected expedited
> > > stalls on CPUs/tasks: { 0-... } 6 jiffies s: 101 root: 0x1/.
> > 
> > This is because of the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20 in your
> > .config file.  This is selected in kernels built with CONFIG_ANDROID=y,
> > and results in an ultra-short 20-millisecond RCU CPU stall timeout for
> > expedited grace periods.  Yes, the Android guys want and are getting
> > milliseconds-scale response times from synchronize_rcu_expedited().
> > 
> > The last time someone ran into this, the upshot was that CONFIG_ANDROID
> > was to be removed: https://lwn.net/Articles/899743/
> > 
> > My guess is that the CONFIG_ANDROID-removal patches are still on their way
> > into mainline (they are in -next), but I added Greg KH and Christoph on CC
> > just in case some other issue arose.
> 
> Not that I know of, those changes are all now in Linus's tree.

And now that I do another pull, I do see them, thank you!

So Sedat and Ben can just merge current mainline and be fine.

							Thanx, Paul
