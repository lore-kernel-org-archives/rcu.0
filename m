Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893B6C433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5176522D04
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbhAFBkc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbhAFBkb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 20:40:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0ACE22D04;
        Wed,  6 Jan 2021 01:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609897190;
        bh=QrzztmIfEhs2ucrqovZbL/ro9SUcb+s8135r+hiRtxU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=YInG5Qsyt4P0YqqtnPO5qB7tZSGx99j7C3hoXsaA7DBttjLV9lNd8aSNFWpJiPVS8
         8s5RXuWn/4nS7xJoD2KX6RjYKvGFcMM2XaWSOvPBgG8IRWl+4StKzfbo+PKsEj2DJw
         7FpFXJYXikc++gDDSDZMy2gwbFKkDcG8P84T23+CwRniRXfFecN0WHUUf6ophsZw2A
         XWddO0BUDfvXpICCO23kYRqncGT0nScilwAMacwccT+S4kWoxW9AWtzJWFboTKuuPe
         pIx0QP+7ThsUG3TlubUNwcMPJILUEWlP9GPIAJN7Qz03vZxdYa7/cuxea5M60uP/9Y
         usRsPYneQ5jNA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 988D235228C6; Tue,  5 Jan 2021 17:39:50 -0800 (PST)
Date:   Tue, 5 Jan 2021 17:39:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/21] Provide runtime switching of offloaded CPUs
Message-ID: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

Currently, it is necessary to reboot to change a given CPU between
invoking its own RCU callbacks via softirq and offloading callback
invocation to an rcuo kthread.  This series allows CPUs that were
initially offloaded to be toggled back and forth at runtime, without
requiring a reboot.

Note that you can boot with all CPUs offloaded, de-offload them
as needed immediately after boot, and thereafter toggled back and
forth as desired.

1.	Turn enabled/offload states into a common flag, courtesy of
	Frederic Weisbecker.

2.	Provide basic callback offloading state machine bits, courtesy
	of Frederic Weisbecker.

3.	Always init segcblist on CPU up, courtesy of Frederic Weisbecker.

4.	De-offloading CB kthread, courtesy of Frederic Weisbecker.

5.	Don't deoffload an offline CPU with pending work, courtesy of
	Frederic Weisbecker.

6.	De-offloading GP kthread, courtesy of Frederic Weisbecker.

7.	Re-offload support, courtesy of Frederic Weisbecker.

8.	Shutdown nocb timer on de-offloading, courtesy of Frederic
	Weisbecker.

9.	Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY, courtesy of
	Frederic Weisbecker.

10.	Set SEGCBLIST_SOFTIRQ_ONLY at the very last stage of
	de-offloading, courtesy of Frederic Weisbecker.

11.	Only cond_resched() from actual offloaded batch processing,
	courtesy of Frederic Weisbecker.

12.	Process batch locally as long as offloading isn't complete,
	courtesy of Frederic Weisbecker.

13.	Locally accelerate callbacks as long as offloading isn't complete,
	courtesy of Frederic Weisbecker.

14.	Add lockdep_is_cpus_held(), courtesy of Frederic Weisbecker.

15.	Add timer_curr_running(), courtesy of Frederic Weisbecker.

16.	Test runtime toggling of CPUs' callback offloading.

17.	Support nocb toggle in TREE01, courtesy of Frederic Weisbecker.

18.	Add grace period and task state to show_rcu_nocb_state() output.

19.	Add nocb CB kthread list to show_rcu_nocb_state() output.

20.	Code-style nits in callback-offloading toggling.

21.	Do any deferred nocb wakeups at CPU offline time.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt            |    8 
 include/linux/cpu.h                                        |    2 
 include/linux/rcu_segcblist.h                              |  121 +++
 include/linux/rcupdate.h                                   |    4 
 include/linux/timer.h                                      |    2 
 kernel/cpu.c                                               |    7 
 kernel/rcu/rcu_segcblist.c                                 |   17 
 kernel/rcu/rcu_segcblist.h                                 |   79 +-
 kernel/rcu/rcutorture.c                                    |   90 ++
 kernel/rcu/tree.c                                          |   31 
 kernel/rcu/tree.h                                          |    2 
 kernel/rcu/tree_plugin.h                                   |  433 +++++++++++--
 kernel/time/timer.c                                        |   13 
 tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot |    4 
 14 files changed, 714 insertions(+), 99 deletions(-)
