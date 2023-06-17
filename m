Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBDAEB64D9
	for <rcu@archiver.kernel.org>; Sat, 17 Jun 2023 17:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjFQRXS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Jun 2023 13:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjFQRXR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Jun 2023 13:23:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F55D8F;
        Sat, 17 Jun 2023 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IgTfAXDyDg9a7UN8hPp72ala2x0JP1WRzaHx3URXZl8=; b=jI5FdSf5SSIeZ1P0kfDgAMyiRG
        WmliCLColyniqehUcYWJgttcz4S7k/RZHXntsPx2g2MDtftjmRWeBPK4okhKAmR4ccLa+9Acznmcv
        nhjJeKue96pAdWl1Z17iydJ0kfXSgP6yb3xKIE19hgagu5sWlHobcQNNNlyaVn/3CrR71lRm7MuL2
        0apeDUfr+GhcTy6N7pEJAhNs2A8y1BUL7HKsRhR6R7+ZVyCXr9NjuXww9LPsA762J0Prtivxbm2+M
        hIXo0qHY+q+tYMOJ5zTlYW/aJGp+Q+C+sDHS6OFoRia0oB65siMiZLgmYysxZ2JPVGzJCvGHawpji
        OthlfteQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qAZdf-00A8XR-Ps; Sat, 17 Jun 2023 17:23:03 +0000
Date:   Sat, 17 Jun 2023 18:23:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     paulmck@kernel.org, joel@joelfernandes.org, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs/RCU: Bring smp_wmb() back
Message-ID: <ZI3r9zH8+xlzGU1H@casper.infradead.org>
References: <20230617145346.29009-1-mmpgouride@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617145346.29009-1-mmpgouride@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jun 17, 2023 at 02:53:46PM +0000, Alan Huang wrote:
> There are two memory ordering required in the insertion algorithm,
> we need to make sure obj->key is updated before obj->obj_node.next
> and obj->refcnt, atomic_set_release is not enough to provide the
> required memory barrier.
> 
> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> ---
>  Documentation/RCU/rculist_nulls.rst | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> index e06ed40bb6..77244adbdf 100644
> --- a/Documentation/RCU/rculist_nulls.rst
> +++ b/Documentation/RCU/rculist_nulls.rst
> @@ -98,7 +98,7 @@ Quoting Corey Minyard::
>  ----------------------
>  
>  We need to make sure a reader cannot read the new 'obj->obj_node.next' value
> -and previous value of 'obj->key'. Otherwise, an item could be deleted
> +and previous value of 'obj->key' at the same time. Otherwise, an item could be deleted

"at the same time" doesn't make a lot of sense to me.  CPUs don't do
anything "at the same time".  I think the way this is worded now is
fine; I tried coming up with a few variants of this, but none are as
clear and succinct as what is there now.

>  from a chain, and inserted into another chain. If new chain was empty
>  before the move, 'next' pointer is NULL, and lockless reader can not
>  detect the fact that it missed following items in original chain.
> @@ -112,7 +112,12 @@ detect the fact that it missed following items in original chain.
>    obj = kmem_cache_alloc(...);
>    lock_chain(); // typically a spin_lock()
>    obj->key = key;
> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
> +  /*
> +  * we need to make sure obj->key is updated before obj->obj_node.next
> +  * and obj->refcnt
> +  */
> +  smp_wmb();
> +  atomic_set(&obj->refcnt, 1);

Perhaps this could be a little clearer for those of us who aren't as
deep into the memory model as others ... are you saying that the
atomic_set_release() would only order references to obj->refcount and
would not order accesses to obj->key?  Because reading this:

     The use of ACQUIRE and RELEASE operations generally precludes the need
     for other sorts of memory barrier.  In addition, a RELEASE+ACQUIRE pair is
     -not- guaranteed to act as a full memory barrier.  However, after an
     ACQUIRE on a given variable, all memory accesses preceding any prior
     RELEASE on that same variable are guaranteed to be visible.  In other
     words, within a given variable's critical section, all accesses of all
     previous critical sections for that variable are guaranteed to have
     completed.

makes me think that this example is fine; anybody doing a load-acquire
on obj->refcount will see the update to obj->key that happened before
the store-release to obj->refcount.

I am not an expert and would welcome the opportunity to learn more here.
