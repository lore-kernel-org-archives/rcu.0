Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E42C433EF
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7621260F8F
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhIOXq6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232836AbhIOXq6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:46:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D7FC610E8;
        Wed, 15 Sep 2021 23:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749538;
        bh=2RTg2+cSa0gROS3lcGbDH7nYj3g+s7AzMM0dBHEAEqM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=cdC2D6ojS3PUpCSqV9xLyA65S4RaQxTGKQ1vnt4hojKoxCaGM7L1EJKY4Yh5GO4tN
         7qXf+0d5YHbsJFvkeRvzkqywDfrIT/beX9ZWFEYVfyupI8dMsBgTPXPz/Balb2v7yK
         inhXhAbGE60gmCJXKrfph6Fu/yniG4DeNCDVLotzVHS12X7Yyjmz2zp7np8nmTA2+y
         /rmsx9k8w0yD6z8Xy3CyKxRnl+kPxjzP8fnRJcDaX6jwq/BVa8ZlCfZZ94rTFY4Tdy
         Kiz1WPvfyBTNSO5a+ud+t7y9bmH2bRgxxPu4/SpNxu7XY/LnIOHolEN5i0XhzmxVE4
         hB8ZX2m43fyOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 548C35C054E; Wed, 15 Sep 2021 16:45:38 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:45:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/13] Tasks RCU updates for v5.16
Message-ID: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides a number of bug fixes for RCU Tasks Trace, most
of which were uncovered in review sessions with Boqun Feng, Frederic
Weisbecker, and Neeraj Upadhyay.

1.	rcu-tasks: Wait for trc_read_check_handler() IPIs.

2.	rcu-tasks: Simplify trc_read_check_handler() atomic operations.

3.	rcu-tasks: Add trc_inspect_reader() checks for exiting critical
	section.

4.	rcu-tasks: Remove second argument of
	rcu_read_unlock_trace_special().

5.	rcu-tasks: Fix s/instruction/instructions/ typo in comment.

6.	rcu-tasks: Move RTGS_WAIT_CBS to beginning of rcu_tasks_kthread()
	loop.

7.	rcu-tasks: Fix s/rcu_add_holdout/trc_add_holdout/ typo in comment,
	courtesy of Neeraj Upadhyay.

8.	rcu-tasks: Correct firstreport usage in
	check_all_holdout_tasks_trace, courtesy of Neeraj Upadhyay.

9.	rcu-tasks: Correct comparisons for CPU numbers in
	show_stalled_task_trace, courtesy of Neeraj Upadhyay.

10.	rcu-tasks: Clarify read side section info for rcu_tasks_rude GP
	primitives, courtesy of Neeraj Upadhyay.

11.	rcu-tasks: Fix read-side primitives comment for
	call_rcu_tasks_trace, courtesy of Neeraj Upadhyay.

12.	rcu-tasks: Fix IPI failure handling in trc_wait_for_one_reader,
	courtesy of Neeraj Upadhyay.

13.	rcu-tasks: Update comments to cond_resched_tasks_rcu_qs().

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate_trace.h |    5 +-
 b/kernel/rcu/tasks.h             |   14 +++++
 kernel/rcu/tasks.h               |   97 ++++++++++++++++-----------------------
 3 files changed, 57 insertions(+), 59 deletions(-)
