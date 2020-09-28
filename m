Return-Path: <SRS0=f31y=DF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C730DC2D0A8
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908342076A
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601335847;
	bh=el6hcOux7y4CUYemcLLD723adYsECOKD0NgIM5zgJ5M=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=HocBf6qHa/Eys5agjJtUpT35VLpmF8RGpSzdQdNbYd4iGP+SpM8GOeZAWaj0q6QR1
	 M+ERUmcMTQBKYNrAf4XjUKsOMufBZ05aALYkUUHI/5UmCasBZv9nGPitIREqBsf85X
	 OqgVFSYyvpAiycgX6C6F/8y675s3mKfo6m3ZONI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgI1Xar (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbgI1Xam (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Sep 2020 19:30:42 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C744820719;
        Mon, 28 Sep 2020 23:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335841;
        bh=el6hcOux7y4CUYemcLLD723adYsECOKD0NgIM5zgJ5M=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=uYH+CedD3YAIcZg9MIVq3P/Yf9JoY3cNARjw4yPUThjeZtPjycIG441sjydxbkm53
         2dnxxSRWXiLl6Lkq8Jt/pEIpNul7zea0PAWXYl18BUcl6Om6YFnmmMI3J6dv/q8qg9
         srvogTTQv7WfcczNEOctrYS3vcfMX4nerTMgmEn4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8BF4F35227DB; Mon, 28 Sep 2020 16:30:41 -0700 (PDT)
Date:   Mon, 28 Sep 2020 16:30:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org
Subject: [PATCH tip/core/rcu 0/15]
Message-ID: <20200928233041.GA23230@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This is a repost of Thomas Gleixner's "Make preempt count unconditional"
series [1], but with the addition of a kvfree_rcu() bug-fix patch making
use of this PREEMPT_COUNT addition.  This series is intended for the
upcoming v5.10 merge window.

This addition fixes the -rt bug reported by Sebastian Andrzej Siewior
[2].  Please note that with the advent of the new lockdep Kconfig
option CONFIG_PROVE_RAW_LOCK_NESTING, this is now also a mainline bug.
In happy contrast to the surprisingly large number of earlier versions
of this fix, this version uses only pre-existing kernel interfaces,
and furthermore uses them in conventional ways.

1-13.	Thomas's series [1].

14.	Use the newly accurate preemptible() macro to cause kvfree_rcu()
	to do its allocations only when it is safe to do so, even in
	CONFIG_PREEMPT_NONE=y kernels, courtesy of Uladzislau Rezki.
	Again, this fixes the bug reported by Sebastian [2].

15.	Checkpatch fix removing NULL check guarding kfree(), courtesy
	of kernel test robot and Julia Lawall.

In addition, this series reduces the size of the kernel by 100 lines
of code, about two thirds of which is from Thomas's original series and
the remaining one third from the bug fix.

Changes from v1 [1]:

o	Fix trivial !SMP build failure.
o	Apply checkpatch spelling suggestions.

							Thanx, Paul

[1]	https://lore.kernel.org/linux-mm/20200914204209.256266093@linutronix.de/
[2]	https://lore.kernel.org/lkml/20200630164543.4mdcf6zb4zfclhln@linutronix.de/

------------------------------------------------------------------------

 arch/arm/include/asm/assembler.h                                 |   11 -
 arch/arm/kernel/iwmmxt.S                                         |    2 
 arch/arm/mach-ep93xx/crunch-bits.S                               |    2 
 arch/xtensa/kernel/entry.S                                       |    2 
 drivers/gpu/drm/i915/Kconfig.debug                               |    1 
 drivers/gpu/drm/i915/i915_utils.h                                |    3 
 include/linux/bit_spinlock.h                                     |    4 
 include/linux/lockdep.h                                          |    6 
 include/linux/pagemap.h                                          |    4 
 include/linux/preempt.h                                          |   37 -----
 include/linux/uaccess.h                                          |    6 
 kernel/Kconfig.preempt                                           |    6 
 kernel/rcu/tree.c                                                |   73 ++--------
 kernel/sched/core.c                                              |    6 
 lib/Kconfig.debug                                                |    5 
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-t            |    1 
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-u            |    1 
 tools/testing/selftests/rcutorture/configs/rcu/TINY01            |    1 
 tools/testing/selftests/rcutorture/doc/TINY_RCU.txt              |    5 
 tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt      |    1 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h |    1 
 21 files changed, 39 insertions(+), 139 deletions(-)
