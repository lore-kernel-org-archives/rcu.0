Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C1BC433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4173361625
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhEKXDv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhEKXDv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:03:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 936ED61606;
        Tue, 11 May 2021 23:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774164;
        bh=iwAChxWhGvH/KcZDbPAQ6E0e5/tY6h0oc8fTfC+LBgg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=pak6OnfsuStfQ8jbJqUkxTPjnZJrzsc579WL1JMKMA5QGUtVVxAIZ3dXmGHX16H39
         bYbQaKdEm4E8Pm9vv+vhoN5tv4sqp1QGrdpoUnO3zwR0h5HRcUukHb+/k4ClG2rCR7
         mHNlEDR0QBrysl6QpVrJXI/SEbBKX7gq4qMkoPqJloitetPmfTNNOd9K0eQ0vrqh07
         L6eDtmHzo+OosGNcnIvx5s+EswpXFwwo9DA6Be3iWxvNaH2cndnt/1mBnNK5mhGrom
         h30c+8P3NQhH8AQiMxNaOiwsndGvVU6ttn2pEyRrem4OxaI1naXTLV1zQ9QYDwg4ls
         flA7MZ5f0Wr8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3EE425C0138; Tue, 11 May 2021 16:02:44 -0700 (PDT)
Date:   Tue, 11 May 2021 16:02:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/10] No-CBs CPU updates for v5.14
Message-ID: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series continues work towards runtime switching of CPUs between
offloaded and not, including a number of cleanups and consolidations:

1.	Use the rcuog CPU's ->nocb_timer, courtesy of Frederic Weisbecker.

2.	Revert "timer: Add timer_curr_running()", courtesy of Frederic
	Weisbecker.

3.	Directly call __wake_nocb_gp() from bypass timer, courtesy of
	Frederic Weisbecker.

4.	Allow de-offloading rdp leader, courtesy of Frederic Weisbecker.

5.	Cancel nocb_timer upon nocb_gp wakeup, courtesy of Frederic
	Weisbecker.

6.	Delete bypass_timer upon nocb_gp wakeup, courtesy of Frederic
	Weisbecker.

7.	Only cancel nocb timer if not polling, courtesy of Frederic
	Weisbecker.

8.	Prepare for fine-grained deferred wakeup, courtesy of Frederic
	Weisbecker.

9.	Unify timers, courtesy of Frederic Weisbecker.

10.	Fix various typos in comments, courtesy of Ingo Molnar.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/timer.h                                           |    2 
 b/include/trace/events/rcu.h                                      |    1 
 b/kernel/rcu/srcutree.c                                           |    4 
 b/kernel/rcu/sync.c                                               |    4 
 b/kernel/rcu/tasks.h                                              |    8 
 b/kernel/rcu/tree.c                                               |    2 
 b/kernel/rcu/tree.h                                               |    1 
 b/kernel/rcu/tree_plugin.h                                        |  140 +++++-----
 b/kernel/time/timer.c                                             |   14 -
 b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h |    2 
 kernel/rcu/tree.c                                                 |    4 
 kernel/rcu/tree.h                                                 |   10 
 kernel/rcu/tree_plugin.h                                          |  140 ++++------
 13 files changed, 160 insertions(+), 172 deletions(-)
