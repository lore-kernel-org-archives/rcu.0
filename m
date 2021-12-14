Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4DBC433EF
	for <rcu@archiver.kernel.org>; Tue, 14 Dec 2021 14:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhLNOtJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Dec 2021 09:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhLNOtI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Dec 2021 09:49:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89039C061574
        for <rcu@vger.kernel.org>; Tue, 14 Dec 2021 06:49:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34D4E61524
        for <rcu@vger.kernel.org>; Tue, 14 Dec 2021 14:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2E3C34601;
        Tue, 14 Dec 2021 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639493347;
        bh=AJ2a9VTcAM3aNkOYseLM56V7jSPhDhqQ/ByvJkBLUzc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FgCwD7lomUApD1G8H7jF6xYELWFl1xmZBgZBj7/MlLQTegFyPWrtDX2dWxDRKeo/3
         TmgiRfI7TssSP7ncH4Kkc6oYefISfs4TjOpxdmNbMcplotFmv7T8kIWfXkH8ag28UJ
         gx5RCFHwMCZxB2jAr8KUEAQh6mphiZRUBOP9wj1Lsy5lbPGe8lG0uxU+VVyWc5NSEa
         XJkysInUwnH5ckTtLFTITCpte85PXq4IVfPYEISBnIWyk+GFcTurzo8iO8zqT2WLnx
         Vi+qzzuakcoOootojJIlmAm3TnvP9AKBoFudywA4qCoIGbbk0ex/3HvZu1E6c2IaEI
         PSP6qRN2dQYrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7110C5C00E3; Tue, 14 Dec 2021 06:49:07 -0800 (PST)
Date:   Tue, 14 Dec 2021 06:49:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, elver@google.com
Subject: Re: KCSAN report from rcu_nocb_cb_kthread()
Message-ID: <20211214144907.GY641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211206185529.GA774467@paulmck-ThinkPad-P17-Gen-1>
 <20211214112434.GB795121@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214112434.GB795121@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 14, 2021 at 12:24:34PM +0100, Frederic Weisbecker wrote:
> On Mon, Dec 06, 2021 at 10:55:29AM -0800, Paul E. McKenney wrote:
> > Hello, Frederic!
> > 
> > KCSAN complains about the following when augmented by Marco's latest patch
> > series:
> > 
> > [   15.432187] ==================================================================
> > [   15.440802] BUG: KCSAN: data-race in rcu_nocb_cb_kthread / rcu_nocb_gp_kthread
> > [   15.441715]
> > [   15.441895] read (marked) to 0xffff8a05df5acb50 of 1 bytes by task 153 on cpu 7:
> > [   15.443781]  rcu_nocb_gp_kthread+0x237/0x1180
> > [   15.444272]  kthread+0x29b/0x2b0
> > [   15.444617]  ret_from_fork+0x22/0x30
> > [   15.445123]
> > [   15.445280] no locks held by rcuog/12/153.
> > [   15.445694] irq event stamp: 7379
> > [   15.446063] hardirqs last  enabled at (7379): [<ffffffffa8b1b23a>] _raw_spin_unlock_irqrestore+0x3a/0x70
> > [   15.447870] hardirqs last disabled at (7378): [<ffffffffa75b14c2>] rcu_nocb_gp_kthread+0x2d2/0x1180
> > [   15.449478] softirqs last  enabled at (7232): [<ffffffffa74bf844>] __irq_exit_rcu+0x64/0xc0
> > [   15.451430] softirqs last disabled at (7225): [<ffffffffa74bf844>] __irq_exit_rcu+0x64/0xc0
> > [   15.452259]
> > [   15.452418] write to 0xffff8a05df5acb50 of 1 bytes by task 169 on cpu 10:
> > [   15.454395]  rcu_nocb_cb_kthread+0x4b0/0x760
> > [   15.454835]  kthread+0x29b/0x2b0
> > [   15.458271]  ret_from_fork+0x22/0x30
> > [   15.458657]
> > [   15.458817] 1 lock held by rcuop/14/169:
> > [   15.459220]  #0: ffff8a05df5acc70 (&rdp->nocb_lock){-.-.}-{2:2}, at: rcu_nocb_cb_kthread+0x2ff/0x760
> > [   15.460127] irq event stamp: 62
> > [   15.460441] hardirqs last  enabled at (61): [<ffffffffa74bf40a>] __local_bh_enable_ip+0xca/0x120
> > [   15.461305] hardirqs last disabled at (62): [<ffffffffa75b2657>] rcu_nocb_cb_kthread+0x2e7/0x760
> > [   15.462169] softirqs last  enabled at (60): [<ffffffffa75adbed>] local_bh_enable+0xd/0x30
> > [   15.462973] softirqs last disabled at (58): [<ffffffffa75ad35d>] local_bh_disable+0xd/0x30
> > 
> > And gdb fingers these two accesses:
> > 
> > (gdb) l*rcu_nocb_gp_kthread+0x237
> > 0xffffffff811b1427 is in rcu_nocb_gp_kthread (kernel/rcu/rcu_segcblist.h:71).
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
> > (gdb) l*rcu_nocb_cb_kthread+0x4b0
> > 0xffffffff811b2820 is in rcu_nocb_cb_kthread (kernel/rcu/rcu_segcblist.h:59).
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
> > Any reason not to turn that "rsclp->flags |= flags" into a WRITE_ONCE()?
> > Maybe a READ_ONCE() as well, if multiple CPUs can be updating this field
> > (but I hope not!).
> 
> The write side update should be taken care of by locking and/or irqs
> disabling. But I'll check that more thoroughly for the next nocb update. I
> have a few related items to take care of after Neeraj's and your reviews.

Looking forward to seeing what you come up with!

							Thanx, Paul
