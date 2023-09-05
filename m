Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4BCCA0FFB
	for <rcu@archiver.kernel.org>; Tue,  5 Sep 2023 16:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351885AbjIEQ0W (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354815AbjIEOln (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Sep 2023 10:41:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55A518C
        for <rcu@vger.kernel.org>; Tue,  5 Sep 2023 07:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79F2B60919
        for <rcu@vger.kernel.org>; Tue,  5 Sep 2023 14:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45910C433C7;
        Tue,  5 Sep 2023 14:41:35 +0000 (UTC)
Date:   Tue, 5 Sep 2023 15:41:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christoph Paasch <cpaasch@apple.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <ZPc+HGjmY2ZC4WO3@arm.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
 <20230905111725.GA3737639@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905111725.GA3737639@google.com>
X-TUID: JtodgA1Ocs8V
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 05, 2023 at 11:17:25AM +0000, Joel Fernandes wrote:
> On Mon, Sep 04, 2023 at 10:22:56PM +0100, Catalin Marinas wrote:
> > On Wed, Aug 30, 2023 at 09:37:23AM -0700, Christoph Paasch wrote:
> > > for the MPTCP upstream project, we are running syzkaller [1] continuously to
> > > qualify our kernel changes.
> > > 
> > > We found one issue with kmemleak and its handling of kfree_rcu.
> > > 
> > > Specifically, it looks like kmemleak falsely reports memory-leaks when the
> > > object is being freed by kfree_rcu after a certain grace-period.
> > > 
> > > For example, https://github.com/multipath-tcp/mptcp_net-next/issues/398#
> > > issuecomment-1584819482 shows how the syzkaller program reliably produces a
> > > kmemleak report, although the object is not leaked (we confirmed that by simply
> > > increasing MSECS_MIN_AGE to something larger than the grace-period).
> > 
> > Not sure which RCU variant you are using but most likely the false
> > positives are caused by the original reference to the object being lost
> > and the pointer added to a new location that kmemleak does not track
> > (e.g. bnode->records[] in the tree-based variant).
> > 
> > A quick attempt (untested, not even compiled):
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> 
> I am not sure if that works. Correct me if I'm wrong but the issue is that
> the allocated pointer being RCU-freed is no longer reachable by kmemleak (it
> is scanned but not reachable), however it might still be reachable via an
> RCU reader. In such a situation, it is a false-positive.

Yes, with a small correction that the object being RCU-freed is not
scanned if it cannot be reached by kmemleak (unless explicitly marked as
not a leak).

> The correct fix then should probably be to mark the object as
> kmemleak_not_leak() until a grace period elapses. This will cause the object
> to not be reported but still be scanned until eventually the lower layers
> will remove the object from kmemleak-tracking after the grace period. Per the
> docs also, that API is used to prevent false-positives.

This should work as well but I'd use kmemleak_ignore() instead of
kmemleak_not_leak(). The former, apart from masking the false positive,
also tells kmemleak not to scan the object. After a kvfree_rcu(), the
object shouldn't have any valid references to other objects, so not
worth scanning.

> Instead what the below diff appears to do is to mark the bnode cache as a
> kmemleak object itself, which smells a bit wrong. The bnode is not an
> allocated object in the traditional sense, it is simple an internal data
> structure.

We do this in other places for objects containing pointers and which
aren't tracked by kmemleak (it doesn't track page allocations as there
would be too many leading to lots of false positives or overlapping
objects - the slab itself uses the page allocator). An example where we
do something similar is alloc_large_system_hash(). We could add a
wrapper API if kmemleak_alloc() feels wrong but underlying in kmemleak
it would use the same mechanism for recording and scanning the bnode.

> That may not solve the issue as the false-positive unreachable
> object is still unreachable.

It should solve the issue as long as the bnode is reachable from the
root objects (e.g. the data/bss sections; I think it is via the
per_cpu_ptr(&krc, cpu)->bkvcache llist_head). When the bnode is scanned,
it will find the pointer to the RCU-freed object and mark it as
referenced (not a leak).

Anyway, as we trust the RCU freeing implementation not to leak data, we
can go with your simpler suggestion of a kmemleak_ignore() call on the
kvfree_rcu() path. Probably even better as the object pending to be
freed will no longer be scanned.

-- 
Catalin
