Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F20C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE01E2076E
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872182;
	bh=e0daXwQDRMHOr/Ja0nG7+V2OLepHHXHl2Ifwn/PsucU=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=BDaJK2Pb2/TAzyxCTZLjh/wHbFGNl8YNZId7WDFNjouR9LACCztA1ZDQKo0lcLZ3r
	 jPNwQnkWxRWJu5AZh0fcB4OFYKD6Kk7AlffYHqp7yEApA6joAazvH0jeYODGDE5gFQ
	 e5ewHUPpZDMaQx8DfEYbQowdh+urxV8ZfzWnnkmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbgFWA3m (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731222AbgFWA3m (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:29:42 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6822020706;
        Tue, 23 Jun 2020 00:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872181;
        bh=e0daXwQDRMHOr/Ja0nG7+V2OLepHHXHl2Ifwn/PsucU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=QU4WumCWneSt7f+bd1mWloEKUB89tYLAPt5UFUjuTgta4ZxAEBnIL5QNo54j6Q7WE
         zuFadmMSCDt43IKhWXMNou+SLwnEs+pR9kOk5NCpo/A/OjjUb7wY0pZv9jycbyO3ro
         S9aC8rHK5+yXZ70E8e2015EPyKVRhZCVK5dJ1j+Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 48E23352306A; Mon, 22 Jun 2020 17:29:41 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:29:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/30] Add read-side scalability tests for v5.9
Message-ID: <20200623002941.GA26089@paulmck-ThinkPad-P72>
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

This series adds a refscale set of read-side scalability tests for
reference counting, reader-writer locking, and RCU.

1.	Remove useless while loops around wait_event, courtesy of
	Joel Fernandes.

2.	Add a test to measure performance of read-side synchronization,
	courtesy of Joel Fernandes.

3.	Add comments explaining the high reader overhead.

4.	Add refperf to the rcutorture scripting.

5.	Add holdoff parameter to allow CPUs to come online.

6.	Hoist function-pointer calls out of the loop.

7.	Allow decimal nanoseconds.

8.	Convert nreaders to a module parameter.

9.	Provide module parameter to specify number of experiments.

10.	Dynamically allocate experiment-summary output buffer.

11.	Dynamically allocate thread-summary output buffer.

12.	Make functions static.

13.	Tune reader measurement interval.

14.	Convert reader_task structure's "start" field to int.

15.	More closely synchronize reader start times.

16.	Add warmup and cooldown processing phases.

17.	Label experiment-number column "Runs".

18.	Output per-experiment data points.

19.	Simplify initialization-time wakeup protocol.

20.	Add read-side delay module parameter.

21.	Adjust refperf.loop default value.

22.	Document rcuperf's module parameters.

23.	Work around 64-bit division, courtesy of Arnd Bergmann.

24.	Change readdelay module parameter to nanoseconds.

25.	Add test for RCU Tasks Trace readers..

26.	Add test for RCU Tasks readers.

27.	rcu-tasks: Fix synchronize_rcu_tasks_trace() header comment.

28.	Rename RCU_REF_PERF_TEST to RCU_REF_SCALE_TEST.

29.	Rename refperf.c to refscale.c and change internal names.

30.	Change --torture type from refperf to refscale.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt                      |   53 
 include/linux/rcupdate_trace.h                                       |    4 
 kernel/rcu/Kconfig.debug                                             |   23 
 kernel/rcu/Makefile                                                  |    5 
 kernel/rcu/rcuperf.c                                                 |   25 
 kernel/rcu/refperf.c                                                 | 1037 ++++++++--
 kernel/rcu/refscale.c                                                |  182 -
 kernel/rcu/tasks.h                                                   |    9 
 tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh        |   73 
 tools/testing/selftests/rcutorture/bin/kvm-recheck-refscale.sh       |    8 
 tools/testing/selftests/rcutorture/bin/kvm.sh                        |   17 
 tools/testing/selftests/rcutorture/bin/parse-console.sh              |    8 
 tools/testing/selftests/rcutorture/configs/refperf/CFLIST            |    2 
 tools/testing/selftests/rcutorture/configs/refperf/CFcommon          |    4 
 tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT         |   18 
 tools/testing/selftests/rcutorture/configs/refperf/PREEMPT           |   18 
 tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh  |   20 
 tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh |    1 
 18 files changed, 1205 insertions(+), 302 deletions(-)
