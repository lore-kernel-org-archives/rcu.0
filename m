Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F65BC433DF
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 13:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6AE20855
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 13:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597412092;
	bh=2k7wrk2A5zGJi+fRb0tRgIS913bmaCEjSwO77FwaKMk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zAogGBoQdDWO9JpKxVGRrm02lQVRvS74vaHOS/l/AE5jQqTiPv77UkfEeDYJ9EeoF
	 0u5KD4RCoVTcBYV0sDxc8DQ7IBqgh50FMqs2RD8zaMwSX9nREDtFdW9qfK+ZeCmDWI
	 8h5nOYEZFcWUQDzLyKZr1LJTkxLMHFjas3IQngsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgHNNew (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 09:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgHNNev (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 09:34:51 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 340AC20791;
        Fri, 14 Aug 2020 13:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597412090;
        bh=2k7wrk2A5zGJi+fRb0tRgIS913bmaCEjSwO77FwaKMk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YlODcCPqwINvpVojzhyjjz9MxMddRD2aNthmQFLCxvr7+MUtcFPc4z91us+eHTIZL
         8OAsOl83Enw+lY6w5D+/XQorw3v+fsiNEbXVHM41up30924ZTOKcGKcAYTDgwjyQyO
         rPTylFhazdcgJuUxq+EO5IuraNs79rfZrW/FBJPI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1485D3522A0E; Fri, 14 Aug 2020 06:34:50 -0700 (PDT)
Date:   Fri, 14 Aug 2020 06:34:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200814133450.GK4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <87lfiitquu.fsf@nanos.tec.linutronix.de>
 <20200814071750.GZ9477@dhcp22.suse.cz>
 <20200814121544.GA32598@pc636>
 <20200814124832.GD9477@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814124832.GD9477@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14, 2020 at 02:48:32PM +0200, Michal Hocko wrote:
> On Fri 14-08-20 14:15:44, Uladzislau Rezki wrote:
> > > On Thu 13-08-20 19:09:29, Thomas Gleixner wrote:
> > > > Michal Hocko <mhocko@suse.com> writes:
> > > [...]
> > > > > Why should we limit the functionality of the allocator for something
> > > > > that is not a real problem?
> > > > 
> > > > We'd limit the allocator for exactly ONE new user which was aware of
> > > > this problem _before_ the code hit mainline. And that ONE user is
> > > > prepared to handle the fail.
> > > 
> > > If we are to limit the functionality to this one particular user then
> > > I would consider a dedicated gfp flag a huge overkill. It would be much
> > > more easier to have a preallocated pool of pages and use those and
> > > completely avoid the core allocator. That would certainly only shift the
> > > complexity to the caller but if it is expected there would be only that
> > > single user then it would be probably better than opening a can of worms
> > > like allocator usable from raw spin locks.
> > > 
> > Vlastimil raised same question earlier, i answered, but let me answer again:
> > 
> > It is hard to achieve because the logic does not stick to certain static test
> > case, i.e. it depends on how heavily kfree_rcu(single/double) are used. Based
> > on that, "how heavily" - number of pages are formed, until the drain/reclaimer
> > thread frees them.
> 
> How many pages are talking about - ball park? 100s, 1000s?

Under normal operation, a couple of pages per CPU, which would make
preallocation entirely reasonable.  Except that if someone does something
that floods RCU callbacks (close(open) in a tight userspace loop, for but
one example), then 2000 per CPU might not be enough, which on a 64-CPU
system comes to about 500MB.  This is beyond excessive for preallocation
on the systems I am familiar with.

And the flooding case is where you most want the reclamation to be
efficient, and thus where you want the pages.

This of course raises the question of how much memory the lockless caches
contain, but fortunately these RCU callback flooding scenarios also
involve process-context allocation of the memory that is being passed
to kfree_rcu().  That allocation should keep the lockless caches from
going empty in the common case, correct?

Please note that we will also need to apply this same optimization to
call_rcu(), which will have the same constraints.

> > Preloading pages and keeping them for internal use, IMHO, seems not optimal
> > from the point of resources wasting. It is better to have a fast mechanism to
> > request a page and release it back for needs of others. As described about
> > we do not know how much we will need.
> 
> It would be wasted memory but if we are talking about relatively small
> number of pages. Note that there are not that many pages on the
> allocator's pcp list anyway.

Indeed, if we were talking a maximum of (say) 10 pages per CPU, we would
not be having this conversation.  ;-)

							Thanx, Paul
