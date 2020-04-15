Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E00C2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C242084D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586973533;
	bh=TKkglCUHmzV1bcpaBXIFp8YemM642vzgYz6zwxMIPso=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=Ps0TpyxO2XG8tmGN3i++c2+bLgRI31uizIC0ZWTmXvrC4WCkapuTFJSjGT1zqg3qr
	 ewCy4ybuQynVfwmYhR6l8X+TjKpIoIzb1PtYNIlOObXnuvG3ARzDNdJ6zT5HgRT5Nz
	 NV6Jp/Dw9JW2GDGppmFzJxJrW8+OPw4n0Dort/Io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411585AbgDOR6u (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416537AbgDORzo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:55:44 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A79942084D;
        Wed, 15 Apr 2020 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586973343;
        bh=TKkglCUHmzV1bcpaBXIFp8YemM642vzgYz6zwxMIPso=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ycyauEHqDXsDRV0blw4N0HFwD+NV0Tn8HvwSPjOuUzdGOnTlJKacvb/M0JbTCvva9
         C4B66P6agu+OOwN0m/OZLGR1hsxpPKW19D/LbdEfahfBxwRWbABiG+SY80EAVYf33O
         f2239bDr1qM8e+CFPoELRw9Yw0wRngA7Ex/BxdJs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6DC093522AD1; Wed, 15 Apr 2020 10:55:43 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:55:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/6] Remove scheduler restriction, update for
 v5.8
Message-ID: <20200415175543.GA10416@paulmck-ThinkPad-P72>
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

This series removes the long-standing restriction preventing holding
of scheduler locks across rcu_read_unlock() unless interrupts have
been disabled across the entire RCU read-side critical section.

For example, with this series, the following code is now perfectly legal,
and is in fact tested by rcutorture:

	// Preemption is enabled.
	rcu_read_lock();
	do_something();
	raw_spin_lock_irqsave(&current->pi_lock, flags);
	rcu_read_unlock();
	raw_spin_unlock_irqrestore(&current->pi_lock, flags);

This change was enabled by the earlier changes that turn on
scheduler-clock interrupts for nohz_full CPUs that take too long to
report a quiescent state during a given grace period.  (Yes, nohz_full
CPUs executing in userspace still have their quiescent states implicitly
reported by the RCU grace-period kthread!)

And here is the series:

1.	Add KCSAN stubs to update.c.

2.	Make rcu_read_unlock_special() safe for rq/pi locks.

3.	Don't set nesting depth negative in rcu_preempt_deferred_qs(),
	courtesy of Lai Jiangshan.

4.	Remove unused ->rcu_read_unlock_special.b.deferred_qs field,
	courtesy of Lai Jiangshan.

5.	Don't use negative nesting depth in __rcu_read_unlock(),
	courtesy of Lai Jiangshan.

6.	Add test of holding scheduler locks across rcu_read_unlock().

							Thanx, Paul

------------------------------------------------------------------------

 include/linux/sched.h    |    2 +-
 kernel/rcu/rcutorture.c  |   10 +++++++++-
 kernel/rcu/tree_exp.h    |   31 +++++--------------------------
 kernel/rcu/tree_plugin.h |   45 +++++++++++++++------------------------------
 kernel/rcu/update.c      |   13 +++++++++++++
 5 files changed, 43 insertions(+), 58 deletions(-)
