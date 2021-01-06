Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62D1C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F9223123
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbhAFRQN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:16:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbhAFRQN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:16:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F3A122B2B;
        Wed,  6 Jan 2021 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953332;
        bh=hMXWI6Rtv/QIDxQnmDd4rULkZi19U/9afBZSYZQyizw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=d/wR+E/kjlOuv97xyrSHpJTYNu0X1bpNPBdpNtiZTN2ud1n2nxcWcRX561Vp/eDLi
         kyTbTiQINwWeNc+N6sBBgL0Vui7Ob1KCDlaf/ziAgAA9AUJztV6doNNIrmOr0ta41P
         j9unq1QvudmrSkRRPSLWYb8Aqqxr6kY25sIp3mKvSwt6UWDw1olFt7nBCCzl98ehxX
         9s7ZqhdXU213QkLVMtNdy4hX+VJMxjhm1VCak0Xf+RX5EE4Xhyhkmqx6wyhyP7LBP2
         4g+hJUdTcpn8rStvYqqH4XBOl+0IQASE/8tn/ApYB/oygFzrpAfG+RPOF+f5BdHxJl
         A82gO6uXFdskQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6713E35225EC; Wed,  6 Jan 2021 09:15:32 -0800 (PST)
Date:   Wed, 6 Jan 2021 09:15:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/17] Torture-test updates for v5.12
Message-ID: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides torture-test updates, and must be applied on top
of the SRCU series.

1.	Add testing for RCU's global memory ordering.

2.	Add debug output for wrong-CPU warning.

3.	Allow summarization of verbose output.

4.	Require entire stutter period be post-boot.

5.	Make synctype[] and nsynctype be static global.

6.	Make rcu_torture_fakewriter() use blocking wait primitives.

7.	Add fuzzed hrtimer-based sleep functions.

8.	Use torture_hrtimeout_jiffies() to avoid busy-waits.

9.	Make stutter use torture_hrtimeout_*() functions.

10.	Use hrtimers for reader and writer delays.

11.	Make refscale throttle high-rate printk()s.

12.	Throttle VERBOSE_TOROUT_*() output.

13.	Make object_debug also double call_rcu() heap object.

14.	Clean up after torture-test CPU hotplugging.

15.	Maintain torture-specific set of CPUs-online books.

16.	Break affinity of kthreads last running on outgoing CPU.

17.	Add rcutree.use_softirq=0 to RUDE01 and TASKS01.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt             |   14 
 include/linux/torture.h                                     |   27 +
 kernel/rcu/rcutorture.c                                     |  246 ++++++++----
 kernel/rcu/refscale.c                                       |   25 -
 kernel/scftorture.c                                         |    6 
 kernel/torture.c                                            |  184 +++++++-
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot  |    1 
 tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot |    1 
 8 files changed, 400 insertions(+), 104 deletions(-)
