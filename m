Return-Path: <SRS0=7AYa=45=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3E2C10DCE
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 18:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E06206B1
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 18:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584036979;
	bh=5Y/FXshugFk88mbf2jBH+CLi7LSB/TsKL13J+4ijKmk=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=lzBZaKgN3tc/lVfWLSLTFctfFRA83hvOdvvq9Ho0dGgCj/t7MEseBWzUVfEAMnA9t
	 nzj9ovTWX0thE/uSkoe7A7WmLGvUhPiWxZFkjpq3TWP9OPbQGLESSDd4h0ezxxqi2j
	 ov8k2y6J4hzS7qLiHXOrGpV4JBDVH6C3wYf2cISQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgCLSQT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgCLSQS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Mar 2020 14:16:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB772067C;
        Thu, 12 Mar 2020 18:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584036978;
        bh=5Y/FXshugFk88mbf2jBH+CLi7LSB/TsKL13J+4ijKmk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=i40WgyFpq1VeKVPJIPqmLQ1GYqvqpo6RpTzw/BQFf4H74rL3Yyyhc+g44+bH5Qp1q
         HsNpNaCroShYJofAnio0pRaWacMyMUdAqnMtbtwmH3gUwKqtiEGCrsjkZjTXlGOWwl
         UKK04NOCOcubwigGvzmoV6gM1Ff+qqCBYh42+Lqg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3BF9035226D0; Thu, 12 Mar 2020 11:16:18 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:16:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mutt@paulmck-ThinkPad-P72, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH RFC tip/core/rcu 0/16] Prototype RCU usable from idle,
 exception, offline
Message-ID: <20200312181618.GA21271@paulmck-ThinkPad-P72>
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

This series provides two variants of Tasks RCU, a rude variant inspired
by Steven Rostedt's use of schedule_on_each_cpu(), and a tracing variant
requested by the BPF folks and perhaps also of use for other tracing
use cases.

The tracing variant has explicit read-side markers to permit finite grace
periods even given in-kernel loops in PREEMPT=n builds It also protects
code in the idle loop, on exception entry/exit paths, and on the various
CPU-hotplug online/offline code paths, thus having protection properties
similar to SRCU.  However, unlike SRCU, this variant avoids expensive
instructions in the read-side primitives, thus having read-side overhead
similar to that of preemptible RCU.

There are of course downsides.  The grace-period code can send IPIs to
CPUs, even when those CPUs are in the idle loop or in nohz_full userspace.
It is necessary to scan the full tasklist, much as for Tasks RCU.  There
is a single callback queue guarded by a single lock, again, much as for
Tasks RCU.  If needed, these downsides can be at least partially remedied.

Perhaps most important, this variant of RCU does not affect the vanilla
flavors, rcu_preempt and rcu_sched.  The fact that RCU Tasks Trace
readers can operate from idle, offline, and exception entry/exit in no
way allows rcu_preempt and rcu_sched readers to also do so.

This effort benefited greatly from off-list discussions of BPF
requirements with Alexei Starovoitov and Andrii Nakryiko, as well as from
numerous on-list discussions, at least some of which are captured in the
"Link:" tags on the patches themselves.

The patches in this series are as follows:

1.	Add function to sample state of non-running function.
	I would guess that the API is still subject to change.  ;-)

2.	Use the above function to add per-task state to RCU CPU stall
	warnings.

3.	Add rcutorture module parameter to produce non-busy-wait task
	stalls, thus allowing the above RCU CPU stall change to be
	exercised.

4.	Move Tasks RCU to its own file.

5.	Create struct to hold RCU-tasks state information.

6.	Reinstate synchronize_rcu_mult(), as there will likely once
	again be a need to wait on multiple flavors of RCU.

7.	Add an rcutorture test for synchronize_rcu_mult().

8.	Refactor RCU-tasks to allow variants to be added.

9.	Add an RCU-tasks rude variant, based on Steven Rostedt's
	use of schedule_on_each_cpu().

10.	Add torture tests for RCU Tasks Rude.

11.	Use unique names for RCU-Tasks kthreads and messages.

12.	Further refactor RCU-tasks to allow adding even more variants.

13.	Code movement to allow even more Tasks RCU variants.

14.	Add an RCU Tasks Trace to simplify protection of tracing hooks,
	including BPF.

15.	Add torture tests for RCU Tasks Trace.

16.	Add stall warnings for RCU Tasks Trace.

The new versions of Tasks RCU pass moderate rcutorture testing, and more
severe testing is in the offing.  They are not yet ready for production
use, however!

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt             |    5 
 include/linux/rcupdate.h                                    |    9 
 include/linux/rcupdate_trace.h                              |   84 
 include/linux/rcupdate_wait.h                               |   19 
 include/linux/sched.h                                       |    8 
 include/linux/wait.h                                        |    2 
 init/init_task.c                                            |    4 
 kernel/fork.c                                               |    4 
 kernel/rcu/Kconfig                                          |   34 
 kernel/rcu/Kconfig.debug                                    |    4 
 kernel/rcu/rcu.h                                            |    2 
 kernel/rcu/rcutorture.c                                     |   96 
 kernel/rcu/tasks.h                                          | 1730 +++++++++---
 kernel/rcu/tree_stall.h                                     |   38 
 kernel/rcu/update.c                                         |  370 --
 kernel/sched/core.c                                         |   49 
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST       |    2 
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01       |   10 
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot  |    1 
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01      |   10 
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot |    1 
 21 files changed, 1702 insertions(+), 780 deletions(-)
