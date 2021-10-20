Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2742EC433F5
	for <rcu@archiver.kernel.org>; Wed, 20 Oct 2021 00:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE36D610F8
	for <rcu@archiver.kernel.org>; Wed, 20 Oct 2021 00:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJTARC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Oct 2021 20:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJTARC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Oct 2021 20:17:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC60C06161C;
        Tue, 19 Oct 2021 17:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d1USsjMHwBTuCTCn9CDScKlY7uzKlLJIU5B92Dq78Ec=; b=PV9eu7ualpJgGPeGY58X0whIOh
        tIsWVOnVvePkK/JXwu5P2xpdoU5e4Q1ldZiI4qez4oWkLPTgo4TGgxG4kDf9KcXuNSy+6xcB+isSF
        z+veD3C9HWD1tk0r4XtT141zq9bNIFSUX5QFQ3rmAe9P8rNVbc4DQtqYIlnQAn2UbcX09x7JrpLNv
        CKaGUOcj8TYFziHuGSuLRq6+CCDdd6xmk1UozzhncmQsf1Grb4m/V9eeRzl7Oa4h3sI72DZ+sHgRw
        CIG3SDb8taigt/7rn/T3xtZGhiyPpw3tEiK5pJWQrjq1909uDCpYMuW+ublTyRxBv8e3Q8LlMa/4r
        e+HEh/Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mczEg-00C73v-61; Wed, 20 Oct 2021 00:13:59 +0000
Date:   Wed, 20 Oct 2021 01:13:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Add refcount analogy to What is RCU
Message-ID: <YW9fMt04JqsaComr@casper.infradead.org>
References: <163468470814.17149.17892190693057737430@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163468470814.17149.17892190693057737430@noble.neil.brown.name>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 20, 2021 at 10:05:08AM +1100, NeilBrown wrote:

some more minor glitches ...

> +7.  ANALOGY WITH REFERENCE COUNTING
> +-----------------------------------
> +
> +Many uses of RCU do not look so much like reader-writer locking as
> +illustrated by the previous section and so it can be helpful to have
> +other analogies to draw on.  One such analogy involves thinking of its
> +behaviour as similar to reference counting: RCU effectively provides a
> +temporary protected reference on "everything".

This paragraph is a bit clunky.  How about:

The reader-writer analogy (illustrated by the previous section) is not
always the easiest way to think about using RCU.  Another analogy which
can be helpful is to consider RCU as providing an effective reference
count on everything which is protected by RCU.

> +A reference count typically does not prevent the referenced object from
> +changes to values, but does prevent changes to type - particularly the
> +gross change of type that happens when the memory used to store the
> +object is freed and reclaimed for some other purpose.  Once a
> +type-safe reference to the object is obtained some other mechanism is

Comma between "obtained" and "some"?

> +needed to ensure consistent access to the data in the object.  This
> +could involve taking a spinlock, but with RCU the typical approach is to
> +perform reads with SMP-aware operations such as smp_load_acquire(), to
> +perform updates with atomic read-modify-write operations, and to be
> +careful of ordering the operations.  RCU provides a number of support
> +functions that embedded the required operations and ordering, such as the

s/embedded/embed/

> +list_for_each_entry_rcu() in the example of the previous section.
> +
> +A more precise statement of the reference counting behaviour is that,
> +between rcu_read_lock() and rcu_read_unlock(), any reference taken with
> +rcu_dereference() on a pointer marked as ``__rcu`` can be treated as
> +though a reference-count on that object has been temporarily increased.
> +This prevents the object from changing type.  Exactly what this means
> +will depend on normal expectations of objects of that type, but it
> +typically includes that spinlocks can still be safely locked, normal
> +reference counters can be safely manipulated, and ``__rcu`` pointers can
> +be safely dereferenced.
> +
> +Some operations that one might expect to see on an object for
> +which an RCU reference is held include:
> + - copying out data that is guaranteed to be stable by the type of the
> +   object.
> + - Using kref_get_unless_zero() or similar to get a longer-term 
> +   reference.  This may fail of course.
> + - Claiming a spinlock in the object, and checking if the object still
> +   is the expected object and if so, manipulating it freely.
> +
> +The understanding that RCU provides a reference that only prevents a
> +change of type is particularly visible with objects allocated from a
> +slab cache marked SLAB_TYPESAFE_BY_RCU.  RCU operations may yield a
> +reference to and object from such a cache that has been concurrently

s/and/an/

> +freed and reallocated to a completely different object, though of the
> +same type.  In this case RCU doesn't even protect the identity of the
> +object from changing, only its type.  So the object found may not be the
> +one expected, but it will be one where it is safe to take a reference or
> +spinlock and then confirm that the identity matches the expectations.
> +
> +With traditional reference counting - such as that implemented by the
> +kref library in Linux - there is typically code that runs when the last
> +reference to an object is dropped.  With kref, this is the function
> +passed to kref_put().  When RCU is being used such finalization code
> +must not be run until all ``__rcu`` pointers referencing the object have
> +been updated, and then a grace period has passed.  Every remaining
> +globally visible pointer to the object must be considered to be a
> +potential counted reference, and the finalization code it typically run
> +using call_rcu() only after all those pointers have been changed.
> +
> +To see how to choose between there two analogies - of RCU as a
> +reader-writer lock and RCU as a reference counting system - it is useful
> +to reflect on the scale of the thing being protected.  The reader-writer
> +lock analogy looks at larger multi-part objects such as a linked list
> +and shows how RCU can facilitate concurrency while elements are add to,

s/add/added/

> +and removed from, the list.  The reference-count analogy looks at the
> +individual objects and looks at how they can be accessed safely within
> +whatever whole they are a part of.
