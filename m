Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D53CC433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268E864F4F
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhCDBAc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233542AbhCDAAn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:00:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48C5364F4D;
        Wed,  3 Mar 2021 23:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614815998;
        bh=NFcFT55x+4kPSjlsn6uD3T6RxJT32Hqr4d8gArbF6d0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=oXkTWbdmCJTyTms0eQYvfa+aJ6446lu41uyCOlEBN1Ci8SMbNfNghFT9pPDyJ+Bta
         vBKW0zjDzx/8U5cue/QVHnpnkq9lQ3hIvM/8XZNJAQDYJGfB3CFIlztiYN+yZedgV0
         pOc1W3DSd4JeI73gH1ihp33nFruO+e667MHq1CBCXLuXwrvPGuFpjPDSeVxoq75lWA
         I7urI7kBGthBR4kaOUr3xe+fnIL8Op8GoAvXsSCLNpdkz4ZuV0RvYgjh/L0wcZPXLZ
         9szT1WUS0A//9pgmbVEJMfExfmQ8FhnBE4T55qyN/uOVL1nHuJ13F1CY9w6pePQtK1
         VnGoGZ0ukFyQw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 103CC3522591; Wed,  3 Mar 2021 15:59:58 -0800 (PST)
Date:   Wed, 3 Mar 2021 15:59:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/10] Miscellaneous fixes for v5.13
Message-ID: <20210303235958.GA22373@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains miscellaneous fixes:

1.	Remove superfluous rdp fetch, courtesy of Frederic Weisbecker.

2.	Fix CPU-offline trace in rcutree_dying_cpu, courtesy of Neeraj
	Upadhyay.

3.	Remove spurious instrumentation_end() in rcu_nmi_enter(),
	courtesy of Zhouyi Zhou.

4.	Replace reference to atomic_ops.rst, courtesy of Akira Yokosawa.

5.	Fix kfree_rcu() docbook errors, courtesy of Mauro Carvalho Chehab.

6.	Don't try waking ksoftirqd before it has been spawned.

7.	Prevent dyntick-idle until ksoftirqd has been spawned.

8.	Correctly spell Stephen Hemminger's name.

9.	Add explicit barrier() to __rcu_read_unlock().

10.	Add a trace event for RCU CPU stall warnings, courtesy of
	Sangmoon Kim.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/RTFP.txt    |    2 +-
 include/linux/rculist_nulls.h |    2 +-
 include/linux/rcupdate.h      |    2 +-
 include/trace/events/rcu.h    |   28 ++++++++++++++++++++++++++++
 kernel/rcu/tree.c             |    4 +---
 kernel/rcu/tree_exp.h         |    1 +
 kernel/rcu/tree_plugin.h      |   14 +++++++++++++-
 kernel/rcu/tree_stall.h       |    2 ++
 kernel/softirq.c              |    2 +-
 9 files changed, 49 insertions(+), 8 deletions(-)
