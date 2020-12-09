Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62B1C4361B
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 01:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A347923B4B
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 01:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgLIBMG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:12:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgLIBMG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 20:12:06 -0500
Date:   Tue, 8 Dec 2020 17:11:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607476285;
        bh=86Y3uT99F3tJGRc8oJiWdNyf9+evidkYld7zLrp6oNc=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=X9rmamK9/+r5LLPPa/TL37AwFxp6X6oP1JIacIvrCcMDjjwlOglfnuHCO84ayub71
         KaWsORbxvFMIcoRRtKtOVNFb410+Fn5aJLHg7nqpC6qnirjOzMPDtqkNujtWKLAFZN
         XyeYHG7Fb4wCSowZ1Z4CGKWvFb4j4dvsdJrNpKOJcYGc3Yh+wGnB4flcDIfoEtFSSa
         efICFCjAIqBcAqEnEI84d75l1I46LeWTFmVLUjF+YgwgOPzanHogQpQj40gKhgUDMc
         qWQGgepKxwAI+58/QoA90Ul/IOD/UyvA/BL0ltwGj7zelIYy1dF4nAVPgfYSRkjPvN
         ro6qSb5bGe32A==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH RFC v2 sl-b] Export return addresses etc. for better
 diagnostics
Message-ID: <20201209011124.GA31164@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201205004022.GA31166@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205004022.GA31166@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This is v2 of the series the improves diagnostics by providing access to
additional information including the return addresses collected by the
sl*b allocators and by vmalloc().  If the allocator is not configured
to collect this information, the diagnostics fall back to a reasonable
approximation of their earlier state.

One use case is the queue_rcu_work() function, which might be used
by any number of kernel subsystems.  If the caller does back-to-back
invocations of queue_rcu_work(), this constitutes a double-free bug,
and (if so configured) the debug-objects system will flag this, printing
the callback function.  In most cases, printing this function suffices.
However, for double-free bugs involving queue_rcu_work(), the RCU callback
function will always be rcu_work_rcufn(), which provides almost no help to
the poor person trying to find this double-free bug.  The return address
from the allocator of the memory containing the rcu_work structure can
provide an additional valuable clue.

Another use case is the percpu_ref_switch_to_atomic_rcu() function,
which detects percpu_ref reference-count underflow.  Unfortunately,
the only data that this function has access to doesn't have much in the
way of identifying characteristics.  Yes, it might be possible to gain
more information from a crash dump, but it is more convenient for the
needed hints to be in the console log.

Unfortunately, printing the return address in this case is of little help
because this object is allocated from percpu_ref_init(), regardless of
what part of the kernel is responsible for the reference-count underflow.
However, CONFIG_STACKTRACE=y kernels (such as those enabling ftrace)
using slub with debugging enabled also collect stack traces.  This series
therefore also provides a way of extracting these stack traces to provide
additional information to those debugging percpu_ref reference-count
underflows.

The patches are as follows:

1.	Add mem_dump_obj() to print source of memory block.

2.	Make mem_dump_obj() handle NULL and zero-sized pointers.

3.	Make mem_dump_obj() handle vmalloc() memory.

4.	Make call_rcu() print mem_dump_obj() info for double-freed
	callback.

5.	Dump mem_dump_obj() info upon reference-count underflow.

						Thanx, Paul


Changes since v1:

o	Apply feedback from Joonsoo Kim, mostly around naming and
	code structure.

o	Apply fix suggested by Stephen Rothwell for a bug that was
	also located by kbuild test robot.

o	Add support for vmalloc().

o	Add support for special pointers.

o	Additional rework simplifying use of mem_dump_obj(), which
	simplifies both the RCU and the percpu_ref uses.

------------------------------------------------------------------------

 include/linux/mm.h      |    2 +
 include/linux/slab.h    |    2 +
 include/linux/vmalloc.h |    6 ++++
 kernel/rcu/tree.c       |    7 +++-
 lib/percpu-refcount.c   |   12 ++++++--
 mm/slab.c               |   28 +++++++++++++++++++
 mm/slab.h               |   11 +++++++
 mm/slab_common.c        |   69 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/slob.c               |    7 ++++
 mm/slub.c               |   40 +++++++++++++++++++++++++++
 mm/util.c               |   44 ++++++++++++++++++++++++++----
 mm/vmalloc.c            |   12 ++++++++
 12 files changed, 229 insertions(+), 11 deletions(-)
