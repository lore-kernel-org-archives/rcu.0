Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F1C433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08DBE20866
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598896854;
	bh=sV61BZWqOqN6aZ1wNPfxW+MMj9m6m9nEYuRPT0u4TvQ=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=2BfQMyGQ6DN4Igqcz/lkyQiBMTRKMXpzbaQnf9ynT8NH/J4+GQz0xz+/Jr9981Txo
	 iJ5+6IqkuzNmvsJB6xjNgs0Gyr5ZG5KWVbtJvTYxo8fhSuIispwRRFFmeFpm83awX6
	 Mf7cZkqvovnLxy0BxZE93ADLDA/ew4zHcVSZS6Zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgHaSAw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgHaSAu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:00:50 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C29E2083E;
        Mon, 31 Aug 2020 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896850;
        bh=sV61BZWqOqN6aZ1wNPfxW+MMj9m6m9nEYuRPT0u4TvQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=mdpMwZgy8Kjbo0P5ODYcw/hYKgn9Tl/rCHYW00XhElZMDkgP4bSAs7K88+plPFF0C
         PGKzi0ReUQIcLbUGLfflDB9RrlDRTb7aGv+ezg975mkeFIolSQpE0+q/EQYgF3ldsc
         nv1f/HvvB9tv/HTxUqU0EavDM+0zGLzEgoUoCsVE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4534735230F1; Mon, 31 Aug 2020 11:00:50 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:00:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/24] Miscellaneous fixes for v5.10
Message-ID: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides miscellaneous fixes:

1.	Remove KCSAN stubs from tree.c.

2.	Remove KCSAN stubs from update.c.

3.	Remove KCSAN stubs from srcutree.c.

4.	Initialize at declaration time in rcu_exp_handler().

5.	rcu/trace: Print negative GP numbers correctly.

6.	rcu/trace: Use gp_seq_req in acceleration's rcu_grace_period
	tracepoint.

7.	Clarify RCU nocb CPU error message.

8.	rcu/tree: Force quiescent state on callback overload.

9.	rcu/tree: Remove CONFIG_PREMPT_RCU check in force_qs_rnp().

10.	Remove show_rcu_nocb_state() false positive printout.

11.	Add READ_ONCE() to rcu_do_batch() access to rcu_divisor.

12.	Add READ_ONCE() to rcu_do_batch() access to rcu_resched_ns.

13.	Add READ_ONCE() to rcu_do_batch() access to rcu_kick_kthreads.

14.	Add READ_ONCE() to rcu_do_batch() access to rcu_cpu_stall_ftrace_dump.

15.	Fix kerneldoc comments in rcupdate.h.

16.	Introduce list/hlist_for_each_entry_srcu() macros.

17.	mmu: page_track: Fix RCU list API usage.

18.	Move rcu_cpu_started per-CPU variable to rcu_data.

19.	rcu/nocb: Add a warning for non-GP kthread running GP code.

20.	Clarify comments about FQS loop reporting quiescent states.

21.	Make FQS more aggressive in complaining about offline CPUs.

22.	Remove unused __rcu_is_watching() function.

23.	rcu/segcblist: Prevent useless GP start if no CBs to accelerate.

24.	Shrink each possible cpu krcp.

						Thanx, Paul

------------------------------------------------------------------------

 arch/x86/kvm/mmu/page_track.c |    6 +-
 include/linux/rculist.h       |   48 +++++++++++++++++++++
 include/linux/rcupdate.h      |   12 ++---
 include/linux/rcutiny.h       |    1 
 include/linux/rcutree.h       |    1 
 include/trace/events/rcu.h    |   54 ++++++++++++------------
 kernel/entry/common.c         |    2 
 kernel/rcu/rcu_segcblist.c    |   10 ++++
 kernel/rcu/srcutree.c         |   13 -----
 kernel/rcu/tree.c             |   92 +++++++++++++++++++++---------------------
 kernel/rcu/tree.h             |    1 
 kernel/rcu/tree_exp.h         |    6 --
 kernel/rcu/tree_plugin.h      |    8 +--
 kernel/rcu/tree_stall.h       |    8 +--
 kernel/rcu/update.c           |   13 -----
 15 files changed, 154 insertions(+), 121 deletions(-)
