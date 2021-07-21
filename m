Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0211AC6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAFCD61248
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhGUTkH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhGUTkG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C703161241;
        Wed, 21 Jul 2021 20:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898842;
        bh=3ZwnJC2bCANAQgpR4BBA8w9DHAKAugVN42u+uvp+bzs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=PMCSb840lHp7D8bZp/vCyUeGZHHbFwU1cXzqw9sr9yIK05SNXNhUJPec34ojv8URE
         bFXkkgsbP77RJgENBzxHiI81+CXn8QlEpFAqrRer7EVRrkwH6bXE+P2ga/CkWToTdQ
         RW6AKI8EHDTpYdmy63WMVfoMxI8aQMV2fdlkvam2tZm/9VeM8x22iFRAzF7nINzQ8e
         3pruwKCyUJ7o/QcYoqqCJhaWBZTusSDOvWJB8zcWjcnxPxOqbama2dfK5bsUUheJRk
         QqPg8ymTqxOfpgld7LAACr7K4EELSdCGq/YraIadlqXSX7meqazS8Vfpc8O6KVjkjS
         ILKDuftl7RDyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8649D5C09A4; Wed, 21 Jul 2021 13:20:42 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:20:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/18] Miscellaneous fixes for v5.15
Message-ID: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides miscellaneous fixes:

1.	Fix to include first blocked task in stall warning, courtesy of
	Yanfei Xu.

2.	Fix stall-warning deadlock due to non-release of rcu_node ->lock,
	courtesy of Yanfei Xu.

3.	Remove special bit at the bottom of the ->dynticks counter,
	courtesy of "Joel Fernandes (Google)".

4.	Weaken ->dynticks accesses and updates.

5.	Mark accesses to ->rcu_read_lock_nesting.

6.	Unify documentation about missing list_empty_rcu(), courtesy of
	Julian Wiedmann.

7.	Handle VM stoppage in stall detection, courtesy of Sergey
	Senozhatsky.

8.	Do not disable GP stall detection in rcu_cpu_stall_reset(),
	courtesy of Sergey Senozhatsky.

9.	Start timing stall repetitions after warning complete.

10.	Mark read-side data races.

11.	Mark lockless ->qsmask read in rcu_check_boost_fail().

12.	Make rcu_gp_init() and rcu_gp_fqs_loop noinline to conserve stack.

13.	Remove trailing spaces and tabs, courtesy of Zhen Lei.

14.	Mark accesses in tree_stall.h.

15.	Remove useless "ret" update in rcu_gp_fqs_loop(), courtesy of
	Liu Song.

16.	Use per_cpu_ptr to get the pointer of per_cpu variable, courtesy
	of Liu Song.

17.	Explain why rcu_all_qs() is a stub in preemptible TREE RCU,
	courtesy of Frederic Weisbecker.

18.	Print human-readable message for schedule() in RCU reader.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rculist.h  |   35 +++++++-------
 b/include/linux/rcupdate.h |    2 
 b/include/linux/rcutiny.h  |    3 -
 b/include/linux/srcutiny.h |    8 +--
 b/kernel/rcu/srcutiny.c    |    2 
 b/kernel/rcu/tasks.h       |    2 
 b/kernel/rcu/tree.c        |   77 +++++---------------------------
 b/kernel/rcu/tree.h        |    2 
 b/kernel/rcu/tree_plugin.h |    9 ++-
 b/kernel/rcu/tree_stall.h  |    4 -
 b/kernel/sched/core.c      |   11 ++++
 kernel/rcu/tree.c          |   62 ++++++++++++++++----------
 kernel/rcu/tree_plugin.h   |    2 
 kernel/rcu/tree_stall.h    |  107 ++++++++++++++++++++++++++++-----------------
 14 files changed, 165 insertions(+), 161 deletions(-)
