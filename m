Return-Path: <SRS0=1ltc=DC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C44C4363D
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 08:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9397323772
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 08:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LYeDZE5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgIYIFH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Sep 2020 04:05:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:39270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgIYIFG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Sep 2020 04:05:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601021104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wu5O5609MUWMDOLd2U3iMrF7lBjb3BlJQDZg1BdL0UY=;
        b=LYeDZE5cGIta2/hiLdCStibnZd+FZQUXseJB+hRUGd31fVkwRpEeXrjKFANxHRzfncrzHQ
        HdDX5nmRnjpmviKLu81o+AZ4fKwAohh9XMJ67Ixi4x6h3l+Mr7+DEGKTl5SbuaREFz/6nE
        yZGBNHTAY6g6HpTGPparVQkev4YpO3Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D917AA55;
        Fri, 25 Sep 2020 08:05:04 +0000 (UTC)
Date:   Fri, 25 Sep 2020 10:05:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200925080503.GC3389@dhcp22.suse.cz>
References: <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924081614.GA14819@pc636>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu 24-09-20 10:16:14, Uladzislau Rezki wrote:
> > On Wed, Sep 23, 2020 at 08:41:05AM -0700, Paul E. McKenney wrote:
> > > > Fundamentally, this is simply shifting the problem from RCU to the page
> > > > allocator because of the locking arrangements and hazard of acquiring zone
> > > > lock is a raw spinlock is held on RT. It does not even make the timing
> > > > predictable as an empty PCU list (for example, a full drain in low memory
> > > > situations) may mean the emergency path is hit anyway. About all it changes
> > > > is the timing of when the emergency path is hit in some circumstances --
> > > > it's not fixing the problem, it's simply changing the shape.
> > > 
> > > All good points!
> > > 
> > > On the other hand, duplicating a portion of the allocator functionality
> > > within RCU increases the amount of reserved memory, and needlessly most
> > > of the time.
> > > 
> > 
> > But it's very similar to what mempools are for.
> > 
> As for dynamic caching or mempools. It requires extra logic on top of RCU
> to move things forward and it might be not efficient way. As a side
> effect, maintaining of the bulk arrays in the separate worker thread
> will introduce other drawbacks:

This is true but it is also true that it is RCU to require this special
logic and we can expect that we might need to fine tune this logic
depending on the RCU usage. We definitely do not want to tune the
generic page allocator for a very specific usecase, do we?

>  a) There is an extra latency window, a time during which a fallback
>     mechanism is used until pages are obtained via the special
>     worker for further pointers collecting over arrays.

This will be always the case for async refilling. More importantly this
will be a bigger problem at the page allocator level which has other
users other than RCU so more users are suffering...

>  b) It is impossible to predict how many pages will be required to
>     cover a demand that is controlled by different workloads on
>     various systems. It would require a rough value.

I have asked for some actual numbers for real life scenarios this work
is meant to cover. There was nothing presented so far. We can hand wave
for ever but this will not move us forward much. As I've said in other
email, few dozens pages per CPU by default will hardly get noticeable.
You have a trivial initial implementation and can build on top in
incremental steps. You can kick a background allocator to start new
allocations when the pool hits a watermark and aggressivelly remove
cached pages when they are not used. You will have quite a freedom to
fine tune the scheme which is much harder for the page allocator because
there are many other consumers.

Anyway, I am afraid that we are going in circles here. We do not have
any meaningful numbers to claim memory footprint problems. There is a
clear opposition to hook into page allocator for reasons already
mentioned. You are looking for a dedicated memory pool and it should be
quite trivial to develop one and fine tune it for your specific usecase.
All that on top of page allocator. Unless this is seen as completely
unfeasible based on some solid arguments then we can start talking about
the page allocator itself.
-- 
Michal Hocko
SUSE Labs
