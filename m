Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1FFC388F9
	for <rcu@archiver.kernel.org>; Mon, 16 Nov 2020 22:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE4F206E0
	for <rcu@archiver.kernel.org>; Mon, 16 Nov 2020 22:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr5uP2Ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgKPWBy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:01:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:44542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730558AbgKPWBx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Nov 2020 17:01:53 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614DE20729;
        Mon, 16 Nov 2020 22:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605564113;
        bh=7Cwv1bYHbUQxsXyRFNkvF6kCBu8xgcspou1Dr4dTpK0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=cr5uP2Akdb7peDlKRhNy5bfy+aPlUu8O2ulpHZ3rs9KQkEFh/aHMyPWZHOU7XLfkk
         U1ZPqcs1PoSMECk5Xp8ZayGbZTgYMgCCA/OVUgWt1c9v0Nk5oMLLs/Vyx3QCpQfOFN
         LdvovBlmxeOWSacf+ikW0ixafiINylKIqoyM5ZpU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 143693522684; Mon, 16 Nov 2020 14:01:53 -0800 (PST)
Date:   Mon, 16 Nov 2020 14:01:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, kernel-team@fb.com, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, bigeasy@linutronix.de
Subject: [GIT RFC PULL rcu/urgent] Fix lockdep issue in rcu_print_task_stall()
Message-ID: <20201116220153.GA22623@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This pull request contains a single commit that fixes a bug that was
introduced a couple of merge windows ago, but which rather more recently
converged to an agreed-upon fix.  The bug is that interrupts can be
incorrectly enabled while holding an irq-disabled spinlock.  This can
of course result in self-deadlocks.

The bug is a bit difficult to trigger.  It requires that a preempted
task be blocking a preemptible-RCU grace period long enough to trigger
an RCU CPU stall warning.  In addition, an interrupt must occur at just
the right time, and that interrupt's handler must acquire that same
irq-disabled spinlock.  Still, a deadlock is a deadlock.

Furthermore, we do now have a fix, and that fix survives kernel test
robot, -next, and rcutorture testing.  It has also been verified by
Sebastian as fixing the bug.  Therefore...

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent-fixes

for you to fetch changes up to c583bcb8f5edd48c1798798e341f78afb9bf4f6f:

  rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled (2020-11-10 17:10:38 -0800)

----------------------------------------------------------------
Paul E. McKenney (1):
      rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled

 kernel/rcu/tree_stall.h | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)
