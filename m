Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FCFEE14D0
	for <rcu@archiver.kernel.org>; Wed,  6 Sep 2023 21:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjIFVhs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Sep 2023 17:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjIFVhs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Sep 2023 17:37:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECC719A4
        for <rcu@vger.kernel.org>; Wed,  6 Sep 2023 14:37:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DDFC433C7;
        Wed,  6 Sep 2023 21:37:43 +0000 (UTC)
Date:   Wed, 6 Sep 2023 22:37:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Christoph Paasch <cpaasch@apple.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <ZPjxJJjuHJbPVyfT@arm.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
 <20230905111725.GA3737639@google.com>
 <ZPc+HGjmY2ZC4WO3@arm.com>
 <20230906143529.GB1127143@google.com>
 <ZPizxVT5s9JA5MPw@arm.com>
 <24f3d4fc-56c0-46bd-8e5b-af57f09fa777@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24f3d4fc-56c0-46bd-8e5b-af57f09fa777@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 06, 2023 at 12:11:12PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 06, 2023 at 06:15:49PM +0100, Catalin Marinas wrote:
> > On Wed, Sep 06, 2023 at 02:35:29PM +0000, Joel Fernandes wrote:
> > > On Tue, Sep 05, 2023 at 03:41:32PM +0100, Catalin Marinas wrote:
> > > > On Tue, Sep 05, 2023 at 11:17:25AM +0000, Joel Fernandes wrote:
> > > > > The correct fix then should probably be to mark the object as
> > > > > kmemleak_not_leak() until a grace period elapses. This will cause the object
> > > > > to not be reported but still be scanned until eventually the lower layers
> > > > > will remove the object from kmemleak-tracking after the grace period. Per the
> > > > > docs also, that API is used to prevent false-positives.
> > > > 
> > > > This should work as well but I'd use kmemleak_ignore() instead of
> > > > kmemleak_not_leak(). The former, apart from masking the false positive,
> > > > also tells kmemleak not to scan the object. After a kvfree_rcu(), the
> > > > object shouldn't have any valid references to other objects, so not
> > > > worth scanning.
> > > 
> > > Yes I am also OK with that, however to me I consider the object as alive as
> > > long as the grace period does not end. But I agree with you and it may not be
> > > worth tracking them or scanning them.
> > 
> > I guess from an RCU perspective, the object is still alive. From the
> > kvfree_rcu() caller perspective though, it can disappear at any point
> > after the grace period, so it shouldn't rely on its content being valid
> > and referencing other objects (other than transiently e.g. in RCU list
> > traversal).
> > 
> > It probably only matters if we have some very long grace periods (I'm
> > not up to date with the recent RCU developments). In such cases, the
> > object still being scanned could introduce false negatives. That's my
> > reasoning for suggesting kmemleak_ignore() rather than
> > kmemleak_not_leak().
> 
> Very long RCU readers still result in very long RCU grace periods.  And,
> after some tens of seconds, RCU CPU stall warnings.  So don't let your
> RCU readers run for that long.  But you knew that already.  ;-)

That's still ok. I was more thinking of deferred freeing well past the
RCU readers completing.

> > @@ -3388,6 +3389,14 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> >  		success = true;
> >  	}
> >  
> > +	/*
> > +	 * The kvfree_rcu() caller considers the pointer freed at this point
> > +	 * and likely removes any references to it. Since the the actual slab
> > +	 * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignore
> > +	 * this object (no scanning or false positives reporting).
> > +	 */
> > +	kmemleak_ignore(ptr);
> 
> Do we want to un-ignore it at the end of the grace period?  Or will that
> happen automatically when it is passed to kfree()?  (My guess is that
> the answer to both questions is "yes", but I figured that I should ask.)

No need to un-ignore. This function only tells kmemleak it's not a
leak and doesn't have any interesting data to scan. Kmemleak still keeps
track of it until properly freed.

-- 
Catalin
