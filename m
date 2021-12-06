Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F39C433F5
	for <rcu@archiver.kernel.org>; Mon,  6 Dec 2021 18:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347938AbhLFS7D (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Dec 2021 13:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbhLFS7C (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Dec 2021 13:59:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933BEC0613F8
        for <rcu@vger.kernel.org>; Mon,  6 Dec 2021 10:55:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A0AFCCE177C
        for <rcu@vger.kernel.org>; Mon,  6 Dec 2021 18:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C24C341C5;
        Mon,  6 Dec 2021 18:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638816929;
        bh=6Se2S60vQuZUyCGBlngVVRmc7KSEl9YGnxoAMJTzTtM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=LTHt9Lxov5pJPSZDWVYsMCU4w1/JFpcwZ7eSXqg14wQ0GD077IuUSOytgG1CJqohV
         6WmQdASgitJQX2GVdh2Y2twiGhnECk2RRPpvtoCPKjxNjXz3fF8MTuxD3erje4r3Cc
         GQezLknNRbipg6reE38SOxliHlu5d0E+k1cZBqLgWK8J8kMEz7yV84d9LkEtexUPsZ
         0HdtNHPV8vHgPZSCOr6pZWkTWnwevVrhyUus++kwUAmS0Db/j61sEdsYj4Jm8SiWE2
         0ugFKGuVylXhhbF1cPo2ZGxkxpxnh9yactf49Ryp99HXEldbImWtJuFAQcCf4DEDLO
         1d/vfqpPhROyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8E34A5C1461; Mon,  6 Dec 2021 10:55:29 -0800 (PST)
Date:   Mon, 6 Dec 2021 10:55:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     frederic@kernel.org
Cc:     rcu@vger.kernel.org, elver@google.com
Subject: KCSAN report from rcu_nocb_cb_kthread()
Message-ID: <20211206185529.GA774467@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Frederic!

KCSAN complains about the following when augmented by Marco's latest patch
series:

[   15.432187] ==================================================================
[   15.440802] BUG: KCSAN: data-race in rcu_nocb_cb_kthread / rcu_nocb_gp_kthread
[   15.441715]
[   15.441895] read (marked) to 0xffff8a05df5acb50 of 1 bytes by task 153 on cpu 7:
[   15.443781]  rcu_nocb_gp_kthread+0x237/0x1180
[   15.444272]  kthread+0x29b/0x2b0
[   15.444617]  ret_from_fork+0x22/0x30
[   15.445123]
[   15.445280] no locks held by rcuog/12/153.
[   15.445694] irq event stamp: 7379
[   15.446063] hardirqs last  enabled at (7379): [<ffffffffa8b1b23a>] _raw_spin_unlock_irqrestore+0x3a/0x70
[   15.447870] hardirqs last disabled at (7378): [<ffffffffa75b14c2>] rcu_nocb_gp_kthread+0x2d2/0x1180
[   15.449478] softirqs last  enabled at (7232): [<ffffffffa74bf844>] __irq_exit_rcu+0x64/0xc0
[   15.451430] softirqs last disabled at (7225): [<ffffffffa74bf844>] __irq_exit_rcu+0x64/0xc0
[   15.452259]
[   15.452418] write to 0xffff8a05df5acb50 of 1 bytes by task 169 on cpu 10:
[   15.454395]  rcu_nocb_cb_kthread+0x4b0/0x760
[   15.454835]  kthread+0x29b/0x2b0
[   15.458271]  ret_from_fork+0x22/0x30
[   15.458657]
[   15.458817] 1 lock held by rcuop/14/169:
[   15.459220]  #0: ffff8a05df5acc70 (&rdp->nocb_lock){-.-.}-{2:2}, at: rcu_nocb_cb_kthread+0x2ff/0x760
[   15.460127] irq event stamp: 62
[   15.460441] hardirqs last  enabled at (61): [<ffffffffa74bf40a>] __local_bh_enable_ip+0xca/0x120
[   15.461305] hardirqs last disabled at (62): [<ffffffffa75b2657>] rcu_nocb_cb_kthread+0x2e7/0x760
[   15.462169] softirqs last  enabled at (60): [<ffffffffa75adbed>] local_bh_enable+0xd/0x30
[   15.462973] softirqs last disabled at (58): [<ffffffffa75ad35d>] local_bh_disable+0xd/0x30

And gdb fingers these two accesses:

(gdb) l*rcu_nocb_gp_kthread+0x237
0xffffffff811b1427 is in rcu_nocb_gp_kthread (kernel/rcu/rcu_segcblist.h:71).
66      }
67
68      static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
69                                                  int flags)
70      {
71              return READ_ONCE(rsclp->flags) & flags;
72      }
73
74      /*
75       * Is the specified rcu_segcblist enabled, for example, not corresponding
(gdb) l*rcu_nocb_cb_kthread+0x4b0
0xffffffff811b2820 is in rcu_nocb_cb_kthread (kernel/rcu/rcu_segcblist.h:59).
54      }
55
56      static inline void rcu_segcblist_set_flags(struct rcu_segcblist *rsclp,
57                                                 int flags)
58      {
59              rsclp->flags |= flags;
60      }
61
62      static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
63                                                   int flags)

Any reason not to turn that "rsclp->flags |= flags" into a WRITE_ONCE()?
Maybe a READ_ONCE() as well, if multiple CPUs can be updating this field
(but I hope not!).

This also found the following rcutorture data race that I will be beating
my head against.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

(gdb) l*rcu_torture_fwd_prog+0x5ee
0xffffffff81194fbe is in rcu_torture_fwd_prog (kernel/rcu/rcutorture.c:2386).
2381                   !shutdown_time_arrived() &&
2382                   !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
2383                    rfcp = READ_ONCE(rfp->rcu_fwd_cb_head);
2384                    rfcpn = NULL;
2385                    if (rfcp)
2386                            rfcpn = READ_ONCE(rfcp->rfc_next);
2387                    if (rfcpn) {
2388                            if (rfcp->rfc_gps >= MIN_FWD_CB_LAUNDERS &&
2389                                ++n_max_gps >= MIN_FWD_CBS_LAUNDERED)
2390                                    break;
(gdb) l*rcu_torture_fwd_cb_cr+0x3d
0xffffffff81195e8d is in rcu_torture_fwd_cb_cr (kernel/rcu/rcutorture.c:2211).
2206            int i;
2207            struct rcu_fwd_cb *rfcp = container_of(rhp, struct rcu_fwd_cb, rh);
2208            struct rcu_fwd_cb **rfcpp;
2209            struct rcu_fwd *rfp = rfcp->rfc_rfp;
2210
2211            rfcp->rfc_next = NULL;
2212            rfcp->rfc_gps++;
2213            spin_lock_irqsave(&rfp->rcu_fwd_lock, flags);
2214            rfcpp = rfp->rcu_fwd_cb_tail;
2215            rfp->rcu_fwd_cb_tail = &rfcp->rfc_next;
