Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2449DC433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CBD22CB1
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbhAFBQo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:16:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbhAFBQo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 20:16:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9128E22CB9;
        Wed,  6 Jan 2021 01:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609895763;
        bh=gqYGodUeEfE+IFOU5c94LdliSPO97nX2c6Hd1dXR480=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=K/560yCCAHiLp3e3H254eK5j/GtSHTlfnAhYmbx4EvD5QYWlo2xqjbCvgpXljs2yi
         Mkt4g1igxrD6o67ouNmENuLb93JFqF8/jJWrwq+ZRPS3+h6VYxP3hc3X4exzOZPSbM
         TbgUd8M9uNPu19la9rA0IAulqKwEuhEnv7fht0HVOGxJg16O8tv07ar8iTBTHjdF4f
         m6S2snyzv+KGF6QcLgGOD8FQdiBBnvKkIH9/FtsR2Mado8F532qjFzx/fYXRR8juGF
         RPudlqIQxislos7qx8adDPAmkCtFng4FUX80Ufa8MTGKkT4hSMVtMIEyxEBzDSQLOS
         cI+JtOLuONV3g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5B1B135228C6; Tue,  5 Jan 2021 17:16:03 -0800 (PST)
Date:   Tue, 5 Jan 2021 17:16:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        ming.lei@redhat.com, axboe@kernel.dk, kernel-team@fb.com
Subject: [PATCH v4 sl-b 0/6] Export return addresses etc. for better
 diagnostics
Message-ID: <20210106011603.GA13180@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This is v4 of the series the improves diagnostics by providing access
to additional information including the return addresses, slab names,
offsets, and sizes collected by the sl*b allocators and by vmalloc().
If the allocator is not configured to collect this information, the
diagnostics fall back to a reasonable approximation of their earlier
state.

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
what part of the kernel is responsible for the reference-count underflow
(though perhaps the slab and offsets might help in some cases).  However,
CONFIG_STACKTRACE=y kernels (such as those enabling ftrace) using slub
with debugging enabled also collect stack traces.  This series therefore
also provides a way of extracting these stack traces to provide additional
information to those debugging percpu_ref reference-count underflows.

The patches are as follows:

1.	Add mem_dump_obj() to print source of memory block.

2.	Make mem_dump_obj() handle NULL and zero-sized pointers.

3.	Make mem_dump_obj() handle vmalloc() memory.

4.	Make mem_obj_dump() vmalloc() dumps include start and length.

5.	Make call_rcu() print mem_dump_obj() info for double-freed
	callback.

6.	percpu_ref: Dump mem_dump_obj() info upon reference-count
	underflow.

						Thanx, Paul

Changes since v3 (https://lore.kernel.org/lkml/20201211011907.GA16110@paulmck-ThinkPad-P72/):

o	Extract more information from CONFIG_SLUB_DEBUG=n builds.

o	Add Joonsoo Kim's Acked-by to 1/6 above.

o	Rebased onto v5.11-rc1.

Changes since v2:

o	Apply more feedback from Joonsoo Kim on naming and code structure.

o	Based on discussions with Vlastimil Babka, added code to print
	offsets and sizes where available.  This can help identify which
	structure is involved.

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
 include/linux/vmalloc.h |    6 +++
 kernel/rcu/tree.c       |    7 +++-
 lib/percpu-refcount.c   |   12 +++++--
 mm/slab.c               |   20 ++++++++++++
 mm/slab.h               |   12 +++++++
 mm/slab_common.c        |   74 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/slob.c               |    6 +++
 mm/slub.c               |   40 +++++++++++++++++++++++++
 mm/util.c               |   45 ++++++++++++++++++++++++-----
 mm/vmalloc.c            |   15 +++++++++
 12 files changed, 228 insertions(+), 13 deletions(-)
