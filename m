Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504E0C43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 13:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBAA20776
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 13:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585748867;
	bh=CvwldOZwrOCHacHE+jmnj9rjAqgJ9cJeX4YmgaNFGyQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ZvJO+8BTPKsN2U9YWqEn3rAIdB/8cBYSidU554AzG2Z+O7UkbIExK1l7N5JUgZq9W
	 QVftRBUL7HvOee4h1pVSEmLEVe+DMpV+xuu9ILbaDIIRX2Bzo5yj1kOenfkqK3+Hh3
	 p/jYUWOr6HPcPwJLr6+e7fmcZDZt0KoWK4mXb2UA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbgDANrq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732289AbgDANrq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 09:47:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8DB9206F5;
        Wed,  1 Apr 2020 13:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585748865;
        bh=CvwldOZwrOCHacHE+jmnj9rjAqgJ9cJeX4YmgaNFGyQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n9dQjVEJndzYqA/D9qyvlmeRzljwKA0hKpPcwuwEarzVa+LiZrEsSpVfsP+S8HIDJ
         mzfj1ojIB7cIlLeirIEAO9Ok5YuWlmxTGha+MxAf7z2o9S93ZZtW4SUNWAVDsTM65t
         3ijG+Q8QhIylR5xd7VP0XDa0zmWTzp02vPvydJRw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9645535226AC; Wed,  1 Apr 2020 06:47:45 -0700 (PDT)
Date:   Wed, 1 Apr 2020 06:47:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401134745.GV19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331140433.GA26498@pc636>
 <20200331150911.GC236678@google.com>
 <20200331160119.GA27614@pc636>
 <20200331183000.GD236678@google.com>
 <20200401122550.GA32593@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401122550.GA32593@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 01, 2020 at 02:25:50PM +0200, Uladzislau Rezki wrote:

[ . . . ]

> > > > Paul was concerned about following scenario with hitting synchronize_rcu():
> > > > 1. Consider a system under memory pressure.
> > > > 2. Consider some other subsystem X depending on another system Y which uses
> > > >    kfree_rcu(). If Y doesn't complete the operation in time, X accumulates
> > > >    more memory.
> > > > 3. Since kfree_rcu() on Y hits synchronize_rcu() a lot, it slows it down.
> > > >    This causes X to further allocate memory, further causing a chain
> > > >    reaction.
> > > > Paul, please correct me if I'm wrong.
> > > > 
> > > I see your point and agree that in theory it can happen. So, we should
> > > make it more tight when it comes to rcu_head attachment logic.
> > 
> > Right. Per discussion with Paul, we discussed that it is better if we
> > pre-allocate N number of array blocks per-CPU and use it for the cache.
> > Default for N being 1 and tunable with a boot parameter. I agree with this.
> > 
> As discussed before, we can make use of memory pool API for such
> purpose. But i am not sure if it should be one pool per CPU or
> one pool per NR_CPUS, that would contain NR_CPUS * N pre-allocated
> blocks.

There are advantages and disadvantages either way.  The advantage of the
per-CPU pool is that you don't have to worry about something like lock
contention causing even more pain during an OOM event.  One potential
problem wtih the per-CPU pool can happen when callbacks are offloaded,
in which case the CPUs needing the memory might never be getting it,
because in the offloaded case (RCU_NOCB_CPU=y) the CPU posting callbacks
might never be invoking them.

But from what I know now, systems built with CONFIG_RCU_NOCB_CPU=y
either don't have heavy callback loads (HPC systems) or are carefully
configured (real-time systems).  Plus large systems would probably end
up needing something pretty close to a slab allocator to keep from dying
from lock contention, and it is hard to justify that level of complexity
at this point.

Or is there some way to mark a specific slab allocator instance as being
able to keep some amount of memory no matter what the OOM conditions are?
If not, the current per-CPU pre-allocated cache is a better choice in the
near term.

							Thanx, Paul

> > In current code, we have 1 cache page per CPU, but this is allocated only on
> > the first kvfree_rcu() request. So we could change this behavior as well to
> > make it pre-allocated.
> > 
> > Does this all sound good to you?
> > 
> I think that makes sense :)
> 
> --
> Vlad Rezki
