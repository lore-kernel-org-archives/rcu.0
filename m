Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A39C433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE8F20720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871690;
	bh=iX6NQF4MW+6RZ8g2rca1Xu6wtzcfoz4qRxSdPz0uTFM=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=BFiniL6jRGcnAHMzmUeyoU23cYguQy1XhKYy4RNkOAN7Yw7xfWiNObzeukOEwPAcR
	 PgqhuNFEM2aJ5w0z0RgaIlxsFRTJq/HET0Z7gPKNfs+7zVPd3XhzLJ62Dxj7/36E+q
	 JA1RoZuCm+euBZknu1ikkoiZ8zB93RkenyMGRB9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgFWAVa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730421AbgFWAVa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B730C20702;
        Tue, 23 Jun 2020 00:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871688;
        bh=iX6NQF4MW+6RZ8g2rca1Xu6wtzcfoz4qRxSdPz0uTFM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=NJOSd1S5iE1b/7I5b5uUuJBgFvt+J/9IHrm8JjXxyNFgcmOgjf1TksP3kPpm8mcf2
         oITYZCsGh3y0WANDyZDn7DUqrelJVDJdWG7oMT34zf7xply2V4DQ7TqU3/Yf9OojdW
         ScI3TT7wmDmwb+A3PbUHKFlY6hcP6TIEFmtOfUf8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9BB9C352306A; Mon, 22 Jun 2020 17:21:28 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:21:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/26] Miscellaneous fixes for v5.9
Message-ID: <20200623002128.GA25456@paulmck-ThinkPad-P72>
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

1.	Initialize and destroy rcu_synchronize only when necessary,
	courtesy of Wei Yang.

2.	mm/mmap.c: Add cond_resched() for exit_mmap() CPU stalls.

3.	Simplify the calculation of rcu_state.ncpus, courtesy of Wei Yang.

4.	Add callbacks-invoked counters.

5.	Add comment documenting rcu_callback_map's purpose.

6.	events: rcu: Change description of rcu_dyntick trace event,
	courtesy of Madhuparna Bhowmik.

7.	Grace-period-kthread related sleeps to idle priority.

8.	Priority-boost-related sleeps to idle priority.

9.	No-CBs-related sleeps to idle priority.

10.	Expedited grace-period sleeps to idle priority.

11.	fs/btrfs: Add cond_resched() for try_release_extent_mapping()
	stalls.

12.	Update comment from rsp->rcu_gp_seq to rsp->gp_seq, courtesy
	of Lihao Liang.

13.	tick/nohz: Narrow down noise while setting current task's tick
	dependency, courtesy of Frederic Weisbecker.

14.	Fix some kernel-doc warnings, courtesy of Mauro Carvalho Chehab.

15.	Remove initialized but unused rnp from check_slow_task().

16.	Mark rcu_nmi_enter() call to rcu_cleanup_after_idle() noinstr.

17.	Complain only once about RCU in extended quiescent state.

18.	Replace 1 with true, courtesy of Jules Irenge.

19.	Stop shrinker loop, courtesy of Peter Enderborg.

20.	gp_max is protected by root rcu_node's lock, courtesy of Wei Yang.

21.	grplo/grphi just records CPU number, courtesy of Wei Yang.

22.	grpnum just records group number, courtesy of Wei Yang.

23.	kernel/rcu/tree.c: Fix kernel-doc warnings, courtesy of Randy
	Dunlap.

24.	Fix some kernel-doc warnings, courtesy of Mauro Carvalho Chehab.

25.	Remove KCSAN stubs.

26.	Remove KCSAN stubs from update.c.

							Thanx, Paul

------------------------------------------------------------------------

 fs/btrfs/extent_io.c       |    2 ++
 include/linux/rculist.h    |    2 +-
 include/trace/events/rcu.h |   11 ++++++-----
 kernel/locking/lockdep.c   |    4 +---
 kernel/rcu/tree.c          |   39 +++++++++++++--------------------------
 kernel/rcu/tree.h          |   15 ++++++++-------
 kernel/rcu/tree_exp.h      |    2 +-
 kernel/rcu/tree_plugin.h   |    4 ++--
 kernel/rcu/tree_stall.h    |    5 +++--
 kernel/rcu/update.c        |   28 +++++++++-------------------
 kernel/time/tick-sched.c   |   22 +++++++++++++++-------
 mm/mmap.c                  |    1 +
 12 files changed, 62 insertions(+), 73 deletions(-)
