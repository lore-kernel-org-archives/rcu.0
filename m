Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A744C4361A
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 00:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCB322DD3
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 00:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgLEAlD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Dec 2020 19:41:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgLEAlC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Dec 2020 19:41:02 -0500
Date:   Fri, 4 Dec 2020 16:40:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607128822;
        bh=sTrddOHUARRjPrBPOmL3jLG/F+XsHep/EkJCIjlSO0M=;
        h=From:To:Cc:Subject:Reply-To:From;
        b=YskyC6KTk5Poxto+IqKhV4eBvLGw58/MhuVoRaD8iXdON0i56dDZkhBdzGN0qbVn8
         QuznYc5THyRkb4pm3qTjdGwdujTP11Stc0B+pZnIpN7Y76vBviKUz+LlO2oZ6f0rXf
         zYbqFF/JjrPNdyO3P93LonABYae3uy6J3MiH2PI5oEa0IUPJ9bLiQ/2MpIud5ja3Tm
         9+2ptiVmbi/wc3eQcyxkePcJd1IT8TMjlR6R9/QRtLB1+Y8tUYSTF1/bSTdn5ZdQ15
         VaM6LR9B6SzupaVKpJHM2VRqPOLIfCc79PCpeQK70nj7z2GotKLyIx3tGSroICfbtg
         Bf0RiQb+/ztNA==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH RFC sl-b] Export return addresses for better diagnostics
Message-ID: <20201205004022.GA31166@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series improves diagnostics by providing access to return addresses
and stack traces collected by the sl*b allocators.  If the allocator is
not configured to collect this information, the diagnostics fall back
to a reasonable approximation of their earlier state.

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

1.	Add kmem_last_alloc() to return last allocation for memory block.

2.	Add kmem_last_alloc_errstring() to provide more kmem_last_alloc()
	info.

3.	Make call_rcu() print allocation address of double-freed callback.

4.	Create kmem_last_alloc_stack() to provide stack trace in slub.

5.	percpu_ref: Print allocator upon reference-count underflow.

6.	percpu_ref: Print stack trace upon reference-count underflow.

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/slab.h  |   15 ++++++++
 kernel/rcu/tree.c     |   12 +++++-
 lib/percpu-refcount.c |   39 ++++++++++++++++------
 mm/slab.c             |   61 +++++++++++++++++++++++------------
 mm/slab_common.c      |   87 ++++++++++++++++++++++++++++++++++++++++++++------
 mm/slob.c             |   11 +++++-
 mm/slub.c             |   44 +++++++++++++++++++++++--
 7 files changed, 222 insertions(+), 47 deletions(-)
