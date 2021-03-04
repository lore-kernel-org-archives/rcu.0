Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD65AC433E6
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77DF64F0B
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbhCDBBM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1451109AbhCDAaC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:30:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0707964E51;
        Thu,  4 Mar 2021 00:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817760;
        bh=AlcP9oRR1CF3YUw+Ll0+91xPhKLXEaKJyeIgn+etWDE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ne4K+3YvR08R/ULpHZO7coBm/H6RPlYinIiBFtC934Cy/UizfenHcEVufiBTMtTD/
         fNdvpqFr3IAWeP+KRQE28PNLVi9gQDcSgAJYhUv7cjF8TeCymEJUQMMVq64A5pP3u1
         hWhxJ5la3a+FiBDjFD5gFly7famIDuaqJPPAGbuxUJe+2yK6V+DRGCOxmCSM1OQpLC
         G9nWYk8rvdXgw/uFuaiDd1wXvOfDJIou756J3nKEdyvJvj2bdRXfx66wWr1OyAUNqp
         FqDVe2jTXsh6hhimtxojvUnglPDMrDhs4k7bnuOr2z1ITMQy10KAfqxSWIeGvyTNI9
         b6JtbKKQOavmg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A06F93522591; Wed,  3 Mar 2021 16:29:19 -0800 (PST)
Date:   Wed, 3 Mar 2021 16:29:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/5] Realtime-related RCU updates for v5.13
Message-ID: <20210304002919.GA24003@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

These commits are related to RCU's realtime support, including better
testing preemption, improving testing of RCU priority boosting, and
ensuring that at least one rcutorture scenario tests use_softirq=0.

1.	Expedite deboost in case of deferred quiescent state.

2.	Make TREE03 use real-time tree.use_softirq setting.

3.	Fix testing of RCU priority boosting.

4.	Make rcu_read_unlock_special() expedite strict grace periods.

5.	Make jitter.sh handle large systems.

						Thanx, Paul

------------------------------------------------------------------------

 kernel/rcu/rcutorture.c                                    |   36 +++++++------
 kernel/rcu/tree_plugin.h                                   |   27 +++++----
 tools/testing/selftests/rcutorture/bin/jitter.sh           |    8 +-
 tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot |    1 
 4 files changed, 42 insertions(+), 30 deletions(-)
