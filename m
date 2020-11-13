Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94D3C388F7
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5618322240
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PstkH/Wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgKMMNt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:13:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgKMMNp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:13:45 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E49C2085B;
        Fri, 13 Nov 2020 12:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269624;
        bh=F9MUOquSB7T4ePXdM6eH0VAMkUBZhDoVNIIhHNUF+00=;
        h=From:To:Cc:Subject:Date:From;
        b=PstkH/Wk4pOHTyQTTSN8eIDX4EId0UA+xuSvN/phSk0Un5k08cPlk9X1KYRdfgGlZ
         vfv5KSxK/vkW6mSU5FQWBHROTSW8sWumVGWm4hwckLDC4YQ7UlxpCV2AGghznzjixo
         ZyqcCIA3iZRo8HwdJHFn7fuZHrB5R03FPi6ILvCg=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH 00/19] rcu/nocb: De-offload and re-offload support v4
Date:   Fri, 13 Nov 2020 13:13:15 +0100
Message-Id: <20201113121334.166723-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This keeps growing up. Rest assured, most of it is debug code and sanity
checks.

Boqun Feng found that holding rnp lock while updating the offloaded
state of an rdp isn't needed, and he was right despite my initial
reaction. The sites that read the offloaded state while holding the rnp
lock are actually protected because they read it locally in a non
preemptible context.

So I removed the rnp lock in "rcu/nocb: De-offloading CB". And just to
make sure I'm not missing something, I added sanity checks that ensure
we always read the offloaded state in a safe way (3 last patches).

Still passes TREE01 (but I had to fight!)

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/nocb-toggle-v4

HEAD: 579e15efa48fb6fc4ecf14961804051f385807fe

Thanks,
	Frederic
---

Frederic Weisbecker (19):
      rcu/nocb: Turn enabled/offload states into a common flag
      rcu/nocb: Provide basic callback offloading state machine bits
      rcu/nocb: Always init segcblist on CPU up
      rcu/nocb: De-offloading CB kthread
      rcu/nocb: Don't deoffload an offline CPU with pending work
      rcu/nocb: De-offloading GP kthread
      rcu/nocb: Re-offload support
      rcu/nocb: Shutdown nocb timer on de-offloading
      rcu: Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY
      rcu/nocb: Set SEGCBLIST_SOFTIRQ_ONLY at the very last stage of de-offloading
      rcu/nocb: Only cond_resched() from actual offloaded batch processing
      rcu/nocb: Process batch locally as long as offloading isn't complete
      rcu/nocb: Locally accelerate callbacks as long as offloading isn't complete
      tools/rcutorture: Support nocb toggle in TREE01
      rcutorture: Remove weak nocb declarations
      rcutorture: Export nocb (de)offloading functions
      cpu/hotplug: Add lockdep_is_cpus_held()
      timer: Add timer_curr_running()
      rcu/nocb: Detect unsafe checks for offloaded rdp


 include/linux/cpu.h                                |   1 +
 include/linux/rcu_segcblist.h                      | 119 +++++-
 include/linux/rcupdate.h                           |   4 +
 include/linux/timer.h                              |   2 +
 kernel/cpu.c                                       |   7 +
 kernel/rcu/rcu_segcblist.c                         |  13 +-
 kernel/rcu/rcu_segcblist.h                         |  45 ++-
 kernel/rcu/rcutorture.c                            |   3 -
 kernel/rcu/tree.c                                  |  49 ++-
 kernel/rcu/tree.h                                  |   2 +
 kernel/rcu/tree_plugin.h                           | 416 +++++++++++++++++++--
 kernel/time/timer.c                                |  13 +
 .../selftests/rcutorture/configs/rcu/TREE01.boot   |   4 +-
 13 files changed, 614 insertions(+), 64 deletions(-)
