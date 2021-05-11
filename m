Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E325C433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1FD8611AC
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhEKXI2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKXI1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:08:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF15061624;
        Tue, 11 May 2021 23:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774440;
        bh=yzKPT+7LtDzUJiDRdgdlRvVzoGZDchUlGAgsxE7hcEc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=qhW7gBt495rh+Mkjzq6Ezn2Gw+T5ah9bcw1Ytra1YZw+z3DaEEFVpwprKIsPLR41T
         XYqC8iKqrq9EetDqSlmRDbHclnZ1uKk7MQk64gO3jUjVul4LbpALi2rH+Izti3YK0X
         xPDHV8hIT6x09in8tcq9MsY4CDiqn7K1VlAFROCcPOaoi9gi4Y7w3oSGPJFi/WLgtu
         bqukGt5j5w4AiVKJQPFp8YENyH8/kQSlzLu/ywi94hQxhh3s1FSu0rGQ4BmPrwDJLp
         tDLcqW746qE9Pxgxc04vMwxKHjil+sBXvg5YJHszO1E+TGL7TT6LMUc/a+5VfnwCTt
         WP/BTnjHoQbNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6283F5C0138; Tue, 11 May 2021 16:07:20 -0700 (PDT)
Date:   Tue, 11 May 2021 16:07:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/6] SRCU updates for v5.14
Message-ID: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides some updates for SRCU, all courtesy of Frederic
Weisbecker.

1.	Remove superfluous sdp->srcu_lock_count zero filling.

2.	Remove superfluous ssp initialization for early callbacks.

3.	Unconditionally embed struct lockdep_map.

4.	Initialize SRCU after timers.

5.	Fix broken node geometry after early ssp init.

6.	Early test SRCU polling start.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcu.h     |    6 ++++++
 b/include/linux/srcutree.h |    2 --
 b/init/main.c              |    2 ++
 b/kernel/rcu/rcu.h         |    6 ------
 b/kernel/rcu/srcutree.c    |   12 ++----------
 b/kernel/rcu/tiny.c        |    1 -
 b/kernel/rcu/tree.c        |    1 -
 b/kernel/rcu/update.c      |    6 +++++-
 kernel/rcu/rcu.h           |    2 ++
 kernel/rcu/srcutree.c      |    9 ++++++++-
 kernel/rcu/tree.c          |   16 +++++++++++++++-
 11 files changed, 40 insertions(+), 23 deletions(-)
