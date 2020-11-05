Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10233C388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EABD20756
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620019;
	bh=dAAsNJAtOJcjJdz8p96+umIQ588n3Rkt7c8memcRouI=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=unkuS70SU1FNnqHu8OjX5bJp6ZxwYZoEJ008SOTUExo2qRqAkhxAnuVTyVUL9hwLO
	 wXEoYvTcoVEqjf6lJ+oo977V7Do/MzTCWyRTjlYAWlRQkkOyWLUqu6MQwXR8xBBNuU
	 eseBHULwvkXjJwU00bH4To/NDjAgZrNdJ/5EFbK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgKEXq7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:46:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEXq7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:46:59 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A41C2073A;
        Thu,  5 Nov 2020 23:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620018;
        bh=dAAsNJAtOJcjJdz8p96+umIQ588n3Rkt7c8memcRouI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=lDvnAMpT7r81yRcd0zZ23dGDpeokXM2fu2mzT4cu5GjpvW5n+FKXOgqLLDYdMFDr/
         5uxTRw1qatXmxNuAOSH7xr2rKcNkOA1qtAlxK0YpWhBEO5NJ2WWhdbIJ7Rt3mbLr7p
         VU2hjOwHbNko78xwM5zd3iZGodagKa7KwKnMIeEQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 22B883522A76; Thu,  5 Nov 2020 15:46:58 -0800 (PST)
Date:   Thu, 5 Nov 2020 15:46:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/28] Torture-test updates for v5.11
Message-ID: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains torture-test updates:

1.	Bounds-check module parameters.

2.	Don't kill gdb sessions.

3.	Track time of last ->writeunlock().

4.	Periodically pause in stutter_wait().

5.	Make torture_stutter() use hrtimer.

6.	Add an alternative IPI vector.

7.	Add RCU Tasks Trace.

8.	Avoid divide by zero.

9.	Exclude "NOHZ tick-stop error" from fatal errors.

10.	Prevent hangs for invalid arguments.

11.	Prevent hangs for invalid arguments.

12.	Adjust scenarios SRCU-t and SRCU-u to make kconfig happy.

13.	Ignore nreaders_stress if no readlock support, courtesy of
	Hou Tao.

14.	Prevent hangs for invalid arguments.

15.	Prevent jitter processes from delaying failed run.

16.	Prevent hangs for invalid arguments.

17.	Force weak-hashed pointers on console log.

18.	Make stutter_wait() caller restore priority.

19.	Accept time units on kvm.sh --duration argument.

20.	Small code cleanups.

21.	Allow alternative forms of kvm.sh command-line arguments.

22.	Add full-test stutter capability.

23.	Invoke percpu_free_rwsem() to do percpu-rwsem cleanup, courtesy
	of Hou Tao.

24.	Don't do need_resched() testing if ->sync is NULL.

25.	Fix a typo in header file, courtesy of Samuel Hernandez.

26.	Make kvm-check-branches.sh use --allcpus.

27.	Fix a spelling error in a comment, courtesy of Bhaskar Chowdhury.

28.	Fix BUG parsing of console.log, courtesy of Anna-Maria Behnsen.

						Thanx, Paul

------------------------------------------------------------------------

 kernel/locking/locktorture.c                                     |   36 +++++-
 kernel/rcu/rcuscale.c                                            |   37 ++++++
 kernel/rcu/rcutorture.c                                          |   41 +++++--
 kernel/rcu/refscale.c                                            |   11 +-
 kernel/scftorture.c                                              |   53 +++++++---
 kernel/torture.c                                                 |   42 +++++--
 tools/include/nolibc/nolibc.h                                    |    4 
 tools/testing/selftests/rcutorture/bin/console-badness.sh        |    3 
 tools/testing/selftests/rcutorture/bin/functions.sh              |    1 
 tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh     |    5 
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh   |    2 
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh         |   19 +++
 tools/testing/selftests/rcutorture/bin/kvm.sh                    |   29 ++++-
 tools/testing/selftests/rcutorture/bin/parse-console.sh          |    2 
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-t            |    3 
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-u            |    3 
 tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon     |    3 
 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01      |   15 ++
 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot |    1 
 19 files changed, 246 insertions(+), 64 deletions(-)
