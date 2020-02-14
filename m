Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF0BC35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93DD217F4
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724539;
	bh=KEo/GehLU6szeskdr7+olKGrvFRujJqrCTlhIP7fPzM=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=aRI/sAzEoggExZjjamlX4LR7hTla7g6Vpfg0pSVRMQf8D1dodsBlysPTadWq4C3KA
	 Pd5ilfAHoEXX0dP6TOgJmk/Q+s+SjSRULVnrICujiYIEox9eW3YWg/9H48rTStUYhm
	 JH8T0KKm3JP3WkPo9qLMsHoY3ubV3voox+t18598=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgBNXzj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:55:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbgBNXzj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:55:39 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A90D2072D;
        Fri, 14 Feb 2020 23:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724538;
        bh=KEo/GehLU6szeskdr7+olKGrvFRujJqrCTlhIP7fPzM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=rvnUPmX+IfWHND8MR77sOOwUebVF+Hv5BDP01YewrTV0523Klisdj6ipI0kme1EIV
         E1i1c/jsdFlrTx/wCOPNjWl1soPYqpt64CUAAIzSF6fNatnaZd0LbJ4Bb/x2k9bKLS
         Pvmo9OAcYWajAbxe5imlyVoK3Mk7pdtujlrnWsew=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A857D3520D46; Fri, 14 Feb 2020 15:55:36 -0800 (PST)
Date:   Fri, 14 Feb 2020 15:55:36 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/30] Miscellaneous fixes for v5.7
Message-ID: <20200214235536.GA13364@paulmck-ThinkPad-P72>
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

This series provides miscellaneous fixes.

1.	Fix nfs_access_get_cached_rcu() sparse error, courtesy of
	Madhuparna Bhowmik.

2.	Warn on for_each_leaf_node_cpu_mask() from non-leaf rcu_node
	structure.

3.	Fix exp_funnel_lock()/rcu_exp_wait_wake() datarace.

4.	Provide debug symbols and line numbers in KCSAN runs.

5.	Add WRITE_ONCE() to rcu_node ->qsmask update.

6.	Add WRITE_ONCE to rcu_node ->exp_seq_rq store.

7.	Add READ_ONCE() to rcu_node ->gp_seq.

8.	Add WRITE_ONCE() to rcu_state ->gp_req_activity.

9.	Add WRITE_ONCE() to rcu_node ->qsmaskinitnext.

10.	Add WRITE_ONCE() to rt_mutex ->owner.

11.	Add READ_ONCE() to rcu_segcblist ->tails[].

12.	*_ONCE() for grace-period progress indicators.

13.	Fix typos in beginning comments, courtesy of SeongJae Park.

14.	Add READ_ONCE() to rcu_data ->gpwrap.

15.	Add *_ONCE() to rcu_data ->rcu_forced_tick.

16.	Add *_ONCE() to rcu_node ->boost_kthread_status.

17.	Use hlist_unhashed_lockless() in timer_pending(), courtesy of
	Eric Dumazet.

18.	Remove dead code from rcu_segcblist_insert_pend_cbs().

19.	Add WRITE_ONCE() to rcu_state ->gp_start.

20.	Fix rcu_barrier_callback() race condition.

21.	Add brackets around cond argument in __list_check_rcu macro,
	courtesy of Amol Grover.

22.	Don't flag non-starting GPs before GP kthread is running.

23.	Add missing annotation for rcu_nocb_bypass_lock(), courtesy
	of Jules Irenge.

24.	Add missing annotation for rcu_nocb_bypass_unlock(), courtesy
	of Jules Irenge.

25.	Optimize and protect atomic_cmpxchg() loop.

26.	Tighten rcu_lockdep_assert_cblist_protected() check.

27.	Make nocb_gp_wait() double-check unexpected-callback warning.

28.	Mark rcu_state.ncpus to detect concurrent writes.

29.	Mark rcu_state.gp_seq to detect concurrent writes.

30.	Make rcu_barrier() account for offline no-CBs CPUs.

							Thanx, Paul

------------------------------------------------------------------------

 fs/nfs/dir.c               |    2 
 include/linux/rculist.h    |    4 -
 include/linux/timer.h      |    2 
 include/trace/events/rcu.h |    1 
 kernel/locking/rtmutex.c   |    2 
 kernel/rcu/Makefile        |    4 +
 kernel/rcu/rcu.h           |    6 +-
 kernel/rcu/rcu_segcblist.c |    4 -
 kernel/rcu/srcutree.c      |    2 
 kernel/rcu/tree.c          |  134 +++++++++++++++++++++++++--------------------
 kernel/rcu/tree_exp.h      |    4 -
 kernel/rcu/tree_plugin.h   |   21 ++++---
 kernel/rcu/tree_stall.h    |   41 +++++++------
 kernel/time/timer.c        |    7 +-
 14 files changed, 135 insertions(+), 99 deletions(-)
