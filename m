Return-Path: <SRS0=c1tG=B4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BD4C433DF
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 16:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96CA120674
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597767528;
	bh=ztQWIiCgI7Bq3K85J7yZF7Hq7f5Jor39R4CppN3X1vs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Pq6r1cve/dZvxC0bkJxI+4aqgAw7MGzwrG5t8jRi6IgGpd1lC5B0PZtB6U6pa+l7e
	 UrE+EL9sqGCyhFJfAzD0etaewabU7vGVMwPhqRVrlMqevnkFHhlW7j8cCTEBaAz+kx
	 Ks+ZHdFwZrkOLS7PdPL2bXf2KCi+ynhJ1ixARcWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHRQSr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgHRQSr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Aug 2020 12:18:47 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 398D42065D;
        Tue, 18 Aug 2020 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597767526;
        bh=ztQWIiCgI7Bq3K85J7yZF7Hq7f5Jor39R4CppN3X1vs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=frqNPImMBZsrS2POlEYAWp11xdase4Bhk5jX6qkrtiPRUSP8dxGYrNlLoGxth2nO0
         zXgGSEHbBPt5pa9kQ5cZXhbqVRj59fTn4+z1541HKuydA2wYTgz6JDgKUeAp/bX3AR
         uozD4DhWsIfUEXHyQVcstK1PXZR5/O1H2Cb1ctuU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1837635228F5; Tue, 18 Aug 2020 09:18:46 -0700 (PDT)
Date:   Tue, 18 Aug 2020 09:18:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200818161846.GF27891@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200814180224.GQ4295@paulmck-ThinkPad-P72>
 <875z9lkoo4.fsf@nanos.tec.linutronix.de>
 <20200814204140.GT4295@paulmck-ThinkPad-P72>
 <20200814215206.GL3982@worktop.programming.kicks-ass.net>
 <20200816225655.GA17869@pc636>
 <20200817082849.GA28270@dhcp22.suse.cz>
 <20200817222803.GE23602@paulmck-ThinkPad-P72>
 <20200818074344.GL28270@dhcp22.suse.cz>
 <20200818135327.GF23602@paulmck-ThinkPad-P72>
 <20200818150232.GQ28270@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818150232.GQ28270@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 18, 2020 at 05:02:32PM +0200, Michal Hocko wrote:
> On Tue 18-08-20 06:53:27, Paul E. McKenney wrote:
> > On Tue, Aug 18, 2020 at 09:43:44AM +0200, Michal Hocko wrote:
> > > On Mon 17-08-20 15:28:03, Paul E. McKenney wrote:
> > > > On Mon, Aug 17, 2020 at 10:28:49AM +0200, Michal Hocko wrote:
> > > > > On Mon 17-08-20 00:56:55, Uladzislau Rezki wrote:
> > > > 
> > > > [ . . . ]
> > > > 
> > > > > > wget ftp://vps418301.ovh.net/incoming/1000000_kmalloc_kfree_rcu_proc_percpu_pagelist_fractio_is_8.png
> > > > > 
> > > > > 1/8 of the memory in pcp lists is quite large and likely not something
> > > > > used very often.
> > > > > 
> > > > > Both these numbers just make me think that a dedicated pool of page
> > > > > pre-allocated for RCU specifically might be a better solution. I still
> > > > > haven't read through that branch of the email thread though so there
> > > > > might be some pretty convincing argments to not do that.
> > > > 
> > > > To avoid the problematic corner cases, we would need way more dedicated
> > > > memory than is reasonable, as in well over one hundred pages per CPU.
> > > > Sure, we could choose a smaller number, but then we are failing to defend
> > > > against flooding, even on systems that have more than enough free memory
> > > > to be able to do so.  It would be better to live within what is available,
> > > > taking the performance/robustness hit only if there isn't enough.
> > > 
> > > Thomas had a good point that it doesn't really make much sense to
> > > optimize for flooders because that just makes them more effective.
> > 
> > The point is not to make the flooders go faster, but rather for the
> > system to be robust in the face of flooders.  Robust as in harder for
> > a flooder to OOM the system.
> 
> Do we see this to be a practical problem? I am really confused because
> the initial argument was revolving around an optimization now you are
> suggesting that this is actually system stability measure. And I fail to
> see how allowing an easy way to deplete pcp caches completely solves
> any of that. Please do realize that if allow that then every user who
> relies on pcp caches will have to take a slow(er) path and that will
> have performance consequences. The pool is a global and a scarce
> resource. That's why I've suggested a dedicated preallocated pool and
> use it instead of draining global pcp caches.

Both the optimization and the robustness are important.

The problem with this thing is that I have to start describing it
somewhere, and I have not yet come up with a description of the whole
thing that isn't TL;DR.

> > And reducing the number of post-grace-period cache misses makes it
> > easier for the callback-invocation-time memory freeing to keep up with
> > the flooder, thus avoiding (or at least delaying) the OOM.
> > 
> > > > My current belief is that we need a combination of (1) either the
> > > > GFP_NOLOCK flag or Peter Zijlstra's patch and
> > > 
> > > I must have missed the patch?
> > 
> > If I am keeping track, this one:
> > 
> > https://lore.kernel.org/lkml/20200814215206.GL3982@worktop.programming.kicks-ass.net/
> 
> OK, I have certainly noticed that one but didn't react but my response
> would be similar to the dedicated gfp flag. This is less of a hack than
> __GFP_NOLOCK  but it still exposes very internal parts of the allocator
> and I find that a quite problematic from the future maintenance of the
> allocator. The risk of an easy depletion of the pcp pool is also there
> of course.

I had to ask.  ;-)

							Thanx, Paul
