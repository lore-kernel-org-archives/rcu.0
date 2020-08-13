Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D21C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 22:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7134920771
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 22:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jKv8GqrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMWGg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMWGf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 18:06:35 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101ACC061757;
        Thu, 13 Aug 2020 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ErzwXfMAZv3xEGRgsJEvMJhUXvljJ3nFsFpsjv0+gvc=; b=jKv8GqrLvXer6/E1Hs9pJKS4/r
        +eZF/mMz8/p6BX7RrgfXlS/EFHCF57uUb3qjyhHHitaGkufm2ndRqQUtO3W6Wp49HYNCLrDq2EvPi
        xNDMmRevmkpqYEWMOwQt9Vimgngy/fJwtQpqgxLpqT/XWAXIuFpcrg3CnUL+dSNP375QgC6JNEjCV
        5Q2bSJ+2fx0MiKdHxwZ4lOPgP2L/GKS6yvdmFUBQWoyhb+Rs9QNsg7/P5B5Iws1M0Q2bCSarzAFB/
        Le46j37i11ZXdLoMsixhAl+sAjxOWiHt8qnh/mGDzPW5hD8qyqEjbclTpp6iMQ6WEBL3sxHWA/PXc
        P9mdaB3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6LMb-0004bF-Qg; Thu, 13 Aug 2020 22:06:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C834304D58;
        Fri, 14 Aug 2020 00:06:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 229EC2B929A56; Fri, 14 Aug 2020 00:06:19 +0200 (CEST)
Date:   Fri, 14 Aug 2020 00:06:19 +0200
From:   peterz@infradead.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813220619.GA2674@hirez.programming.kicks-ass.net>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813182618.GX2674@hirez.programming.kicks-ass.net>
 <20200813185257.GF4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813185257.GF4295@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 11:52:57AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 13, 2020 at 08:26:18PM +0200, peterz@infradead.org wrote:

> > I thought the rule was:
> > 
> >  - No allocators (alloc/free) inside raw_spinlock_t, full-stop.
> > 
> > Why are we trying to craft an exception?
> 
> So that we can reduce post-grace-period cache misses by a factor of
> eight when invoking RCU callbacks.  This reduction in cache misses also
> makes it more difficult to overrun RCU with floods of either call_rcu()
> or kfree_rcu() invocations.
> 
> The idea is to allocate page-sized arrays of pointers so that the callback
> invocation can sequence through the array instead of walking a linked
> list, hence the reduction in cache misses.

I'm still not getting it, how do we end up trying to allocate memory
from under raw spinlocks if you're not allowed to use kfree_rcu() under
one ?

Can someone please spell out the actual problem?
