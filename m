Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ADDC433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B05A6192B
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhEKWxy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230167AbhEKWxs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:53:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7387561184;
        Tue, 11 May 2021 22:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773561;
        bh=Xn+AIPqTrejOU6g7pgGUlUjZH9nKVNH6Ey5HLiEnDe0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Zg7ih0ebJsGTkUEamP/QiJdiGyH8BF+ghE5Aalg1dF/DUh9unzPjdNL2BBlxiy26G
         3SHpHsZuQ+46F9PKWT48EvfgKrxqyhkFEIeHu3maMTaBNFrNMs+gJ50H/dflj5O5kz
         vbTVQ7+pBOufIGJbP+4yXjP4GFaAqnRalP5hPFHkDNZZZVFX7+Gr33sklNyvZ3/NPC
         sx6AkuAH3YdTQROKG+7njwy4Ra3V9WHrYLprEwWRAnZ4GKQSpfCusziVwPRUaGuhXU
         8m+WJDa44mxnx+BavgG+bUqYfovYVlurzFUqtcWxgeMZqxV7KwInrE4AoTohh/CaBs
         VJiYd6poPvfLQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 43BE65C0138; Tue, 11 May 2021 15:52:41 -0700 (PDT)
Date:   Tue, 11 May 2021 15:52:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/19] Miscellaneous fixes for v5.14
Message-ID: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains miscellaneous fixes, perhaps most notably the
rescusitation of RCU priority boosting.

1.	Fix typo in comment: kthead -> kthread, courtesy of Rolf Eike
	Beer.

2.	Remove the unused rcu_irq_exit_preempt() function.

3.	Improve tree.c comments and add code cleanups, courtesy of
	Zhouyi Zhou.

4.	Invoke rcu_spawn_core_kthreads() from rcu_spawn_gp_kthread().

5.	Add ->rt_priority and ->gp_start to show_rcu_gp_kthreads() output.

6.	Add ->gp_max to show_rcu_gp_kthreads() output.

7.	Explicitly flag likely false-positive report.

8.	Reject RCU_LOCKDEP_WARN() false positives.

9.	Add quiescent states and boost states to show_rcu_gp_kthreads()
	output.

10.	Make RCU priority boosting work on single-CPU rcu_node structures.

11.	Make show_rcu_gp_kthreads() dump rcu_node structures blocking GP.

12.	Restrict RCU_STRICT_GRACE_PERIOD to at most four CPUs.

13.	Make rcu_gp_cleanup() be noinline for tracing.

14.	Point to documentation of ordering guarantees.

15.	Create an unrcu_pointer() to remove __rcu from a pointer.

16.	reconcile rcu_nocbs= and nohz_full=, courtesy of Paul Gortmaker.

17.	Improve comments describing RCU read-side critical sections.

18.	Remove obsolete rcu_read_unlock() deadlock commentary.

19.	Add missing __releases() annotation, courtesy of Jules Irenge.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |    2 -
 b/include/linux/rcutiny.h  |    1 
 b/include/linux/rcutree.h  |    1 
 b/kernel/locking/lockdep.c |    6 ++-
 b/kernel/rcu/Kconfig.debug |    2 -
 b/kernel/rcu/srcutree.c    |    3 +
 b/kernel/rcu/tree.c        |   22 ------------
 b/kernel/rcu/tree.h        |    1 
 b/kernel/rcu/tree_plugin.h |    2 -
 b/kernel/rcu/tree_stall.h  |    8 ++--
 b/kernel/rcu/update.c      |    2 -
 b/kernel/sched/isolation.c |    4 --
 b/mm/oom_kill.c            |    2 -
 include/linux/rcupdate.h   |   82 ++++++++++++++++++++++++++-------------------
 kernel/rcu/tree.c          |   74 +++++++++++++++++++++++++---------------
 kernel/rcu/tree.h          |    2 -
 kernel/rcu/tree_plugin.h   |   30 ++++------------
 kernel/rcu/tree_stall.h    |   21 ++++++++---
 18 files changed, 138 insertions(+), 127 deletions(-)
