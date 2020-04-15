Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB40C2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFF22078B
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586971841;
	bh=hW9m1HKvvZPLpR5oWB0oo/Sta70eFShr77qVrs4Ya58=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=OdFuSp/IslAQKNqllGI1cbVMTyo3l0L97iym/OLlQdvMIV8EKjdbTdNDhuiCr6a+s
	 s5wOBk+H3jh+4TYGYxeP7wo4cXx/z7+UTZNLaUl9AlD8t1FtJWb/tt2L2Gm3ubt/TB
	 YL4t8JX2YCjKoNCkSRbNmETdMNq6SXPQ3W4m1jRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411107AbgDORak (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411102AbgDORai (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:30:38 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2F442076D;
        Wed, 15 Apr 2020 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971837;
        bh=hW9m1HKvvZPLpR5oWB0oo/Sta70eFShr77qVrs4Ya58=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=lNBsdDqUTKazdIrU3BeWCs2JBFrG+Z+FzxMBTXN706tHIyKvtw9xtfAl3EetG6nkT
         bomMLEwjVN6NYeiQ7MppTT5h62wPszF97MYzmKPbFMug8Ew50bpZTWP4Glo98HPusX
         vEehiQ/coJL03IuYvehJprdCBuaysZbG1ONmtLno=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B3F2B3522AD1; Wed, 15 Apr 2020 10:30:37 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:30:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/18] Torture-test updates for v5.8
Message-ID: <20200415173037.GA9768@paulmck-ThinkPad-P72>
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

This series contains a variety of torture-test updates:

1.	Add KCSAN stubs.

2.	Make kvm-recheck-rcu.sh handle truncated lines.

3.	Mark data-race potential for rcu_barrier() test statistics.

4.	locktorture.c: Fix if-statement empty body warnings, courtesy
	of Randy Dunlap.

5.	Default enable RCU list lockdep debugging with PROVE_RCU,
	courtesy of Madhuparna Bhowmik.

6.	Add flag to produce non-busy-wait task stalls.

7.	Right-size TREE10 CPU consumption.

8.	Allow rcutorture to starve grace-period kthread.

9.	Add --kcsan argument to top-level kvm.sh script.

10.	Make --kcsan argument also create a summary.

11.	Make rcu_fwds and rcu_fwd_emergency_stop static, courtesy of
	Jason Yan.

12.	Eliminate duplicate #CHECK# from ConfigFragment.

13.	Abstract application of additional Kconfig options.

14.	Allow --kconfig options to override --kcsan defaults.

15.	Allow scenario-specific Kconfig options to override CFcommon.

16.	Save a few lines by using config_override_param initially.

17.	Add a --kasan argument.

18.	Convert ULONG_CMP_LT() to time_before().

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt           |   12 +
 include/linux/torture.h                                   |    2 
 kernel/rcu/Kconfig.debug                                  |   11 -
 kernel/rcu/rcu.h                                          |    2 
 kernel/rcu/rcutorture.c                                   |   63 +++++++--
 kernel/rcu/tree.c                                         |   27 ++++
 tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh  |   22 +++
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh |   16 ++
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh     |    9 +
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh  |   90 +++++++-------
 tools/testing/selftests/rcutorture/bin/kvm.sh             |   17 ++
 tools/testing/selftests/rcutorture/configs/rcu/TREE10     |    2 
 12 files changed, 198 insertions(+), 75 deletions(-)
