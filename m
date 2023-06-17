Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469CEEB64D9
	for <rcu@archiver.kernel.org>; Sat, 17 Jun 2023 18:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjFQSHr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Jun 2023 14:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQSHr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Jun 2023 14:07:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D6F173A;
        Sat, 17 Jun 2023 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=IYtLttQejzj/f6KCagW6yEHCiczcRwwTrjAij6vr3Yc=; b=sv0pfmMPnQL/Ja5s/dcnNw/hL+
        odeUZYa/GXSl68fCYBcTUXgIuTUx/4Qer7JUfUuHl+T3zQAtkR1+aPJqDgFu66oVy8ClHwtwLxCo4
        2T2Ihsc+yQDRcQ9/4/hPhhxoJrHjOLHuQJqvDgxBuwxCco5IOo7YGOAf/ChvShUuDfDf4afXS1l1p
        H2V/s8jOEmSMAClL4lJCFLKTp9V+IMZvtsSocpCG8Mfjr8bZNvMdQvPRpVzf2dOUUx7g7uBz0bY7M
        GsL7JHpuviy//RDB+e8dg6Gnyp4famK1PkGsOjZixwdqp8tCpI79LgoCKp3Eb8HT//FhSMioUu8t4
        m5wk9DNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qAaKl-00AAFZ-R3; Sat, 17 Jun 2023 18:07:35 +0000
Date:   Sat, 17 Jun 2023 19:07:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs/RCU: Bring smp_wmb() back
Message-ID: <ZI32Zzxm/6m30L7g@casper.infradead.org>
References: <20230617145346.29009-1-mmpgouride@gmail.com>
 <ZI3r9zH8+xlzGU1H@casper.infradead.org>
 <CC48F50F-0121-4E77-95CF-9E0DEE6991E4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CC48F50F-0121-4E77-95CF-9E0DEE6991E4@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jun 18, 2023 at 01:55:10AM +0800, Alan Huang wrote:
> 
> > 2023年6月18日 01:23，Matthew Wilcox <willy@infradead.org> 写道：
> > 
> > On Sat, Jun 17, 2023 at 02:53:46PM +0000, Alan Huang wrote:
> >> There are two memory ordering required in the insertion algorithm,
> >> we need to make sure obj->key is updated before obj->obj_node.next
> >> and obj->refcnt, atomic_set_release is not enough to provide the
> >> required memory barrier.
> >> 
> >> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> >> ---
> >> Documentation/RCU/rculist_nulls.rst | 9 +++++++--
> >> 1 file changed, 7 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> >> index e06ed40bb6..77244adbdf 100644
> >> --- a/Documentation/RCU/rculist_nulls.rst
> >> +++ b/Documentation/RCU/rculist_nulls.rst
> >> @@ -98,7 +98,7 @@ Quoting Corey Minyard::
> >> ----------------------
> >> 
> >> We need to make sure a reader cannot read the new 'obj->obj_node.next' value
> >> -and previous value of 'obj->key'. Otherwise, an item could be deleted
> >> +and previous value of 'obj->key' at the same time. Otherwise, an item could be deleted
> > 
> > "at the same time" doesn't make a lot of sense to me.  CPUs don't do
> > anything "at the same time".  I think the way this is worded now is
> > fine; I tried coming up with a few variants of this, but none are as
> > clear and succinct as what is there now.
> > 
> >> from a chain, and inserted into another chain. If new chain was empty
> >> before the move, 'next' pointer is NULL, and lockless reader can not
> >> detect the fact that it missed following items in original chain.
> >> @@ -112,7 +112,12 @@ detect the fact that it missed following items in original chain.
> >>   obj = kmem_cache_alloc(...);
> >>   lock_chain(); // typically a spin_lock()
> >>   obj->key = key;
> >> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
> >> +  /*
> >> +  * we need to make sure obj->key is updated before obj->obj_node.next
> >> +  * and obj->refcnt
> >> +  */
> >> +  smp_wmb();
> >> +  atomic_set(&obj->refcnt, 1);
> > 
> > Perhaps this could be a little clearer for those of us who aren't as
> > deep into the memory model as others ... are you saying that the
> > atomic_set_release() would only order references to obj->refcount and
> > would not order accesses to obj->key?  Because reading this:
> > 
> >     The use of ACQUIRE and RELEASE operations generally precludes the need
> >     for other sorts of memory barrier.  In addition, a RELEASE+ACQUIRE pair is
> >     -not- guaranteed to act as a full memory barrier.  However, after an
> >     ACQUIRE on a given variable, all memory accesses preceding any prior
> >     RELEASE on that same variable are guaranteed to be visible.  In other
> >     words, within a given variable's critical section, all accesses of all
> >     previous critical sections for that variable are guaranteed to have
> >     completed.
> > 
> > makes me think that this example is fine; anybody doing a load-acquire
> > on obj->refcount will see the update to obj->key that happened before
> > the store-release to obj->refcount.
> 
> Two memory ordering required here, atomic_set_release only provides one of them (the one you mentioned)
> 
> The objects are allocated with SLAB_TYPESAFE_BY_RCU, and there is:
> 	
> 		n->next = first;
> 
> in hlist_add_head_rcu, which modifies obj->obj_node.next.

But isn't that the bug?  ie this assignment should be WRITE_ONCE() or
smp_store_release() or rcu_assign_pointer() or whichever of these
similar functions is actually appropriate?

> So, we must make sure obj->key is updated before obj->obj_node.next, without smp_wmb(), we can read
> the new 'obj->obj_node.next’ value and previous value of 'obj->key’ at the same time, and in this case, we
> can not detect the movement of the object.
> 
> The following link might be helpful:
> 
> 		https://patchwork.ozlabs.org/project/netdev/patch/491C282A.5050802@cosmosbay.com/
> 
> 
> > 
> > I am not an expert and would welcome the opportunity to learn more here.
> 
> 
