Return-Path: <SRS0=1ltc=DC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EC4C4363D
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 08:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E6420888
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 08:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PRR15rGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgIYI0c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Sep 2020 04:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIYI0c (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Sep 2020 04:26:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473FCC0613CE;
        Fri, 25 Sep 2020 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B26/iC+1mNbAVpwoje/bCXQml3NwgBVwZs92eAZmgtk=; b=PRR15rGJbRe4N3EQkHV+s2uXWX
        kPkr/QZht+Vz4q4dSYjAvMygE1DTeJcdgscWkQD7taAnDNUgfwG8k+x8zUS0rJ3/yZ9K8nrHSwEQq
        /SnQ6f8x++W54UMgfgyYI+wyOyi8WZNZv6qvs7mSASGKfmGfB6JgAFOknB+q7hBVrlE5opl2OnlCh
        a2LEfy2rUT17HgyAv9U+1V0Y4zTmhcFUOuB7SW/c479ytBV7Pun7QJffBUR1Kqlde2tWDgC5W2fOB
        tNo/TY4MZNZEt/jYydweut7xZVHnQeUdAQwdpzxgFjK6algKnRBPIPvylW3U/nEbYxviVl8fJgz0Y
        FVgsi/+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLj3c-0003P0-Bs; Fri, 25 Sep 2020 08:26:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FCDA301A27;
        Fri, 25 Sep 2020 10:26:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 38B1A200D4BD1; Fri, 25 Sep 2020 10:26:18 +0200 (CEST)
Date:   Fri, 25 Sep 2020 10:26:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200925082618.GT2628@hirez.programming.kicks-ass.net>
References: <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200924111907.GE2628@hirez.programming.kicks-ass.net>
 <20200924153834.GW29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924153834.GW29330@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 24, 2020 at 08:38:34AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 24, 2020 at 01:19:07PM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 24, 2020 at 10:16:14AM +0200, Uladzislau Rezki wrote:
> > > The key point is "enough". We need pages to make a) fast progress b) support
> > > single argument of kvfree_rcu(one_arg). Not vice versa. That "enough" depends
> > > on scheduler latency and vague pre-allocated number of pages, it might
> > > be not enough what would require to refill it more and more or we can overshoot
> > > that would lead to memory overhead. So we have here timing issues and
> > > not accurate model. IMHO.
> > 
> > I'm firmly opposed to the single argument kvfree_rcu() idea, that's
> > requiring memory to free memory.
> 
> Not quite.
> 
> First, there is a fallback when memory allocation fails.  Second,
> in heavy-use situations, there is only one allocation per about
> 500 kvfree_rcu() calls on 64-bit systems.  Third, there are other
> long-standing situations that require allocating memory in order to
> free memory.

Some of which are quite broken. And yes, I'm aware of all that, I'm the
one that started swap-over-NFS, which requires network traffic to free
memory, which is one insane step further.

But the way to make that 'work' is carefully account and pre-allocate
(or size the reserve) the required memory to make progress and to
strictly limit concurrency to ensure you stay in your bounds.

> So I agree that it is a good general rule of thumb to avoid allocating
> on free paths, but there are exceptions.  This is one of them.

The very first thing you need to do is proof your memory usage is
bounded, and then calculate your bound.

The problem is that with RCU you can't limit concurrency. call_rcu()
can't block, you can't wait for a grace period to end when you've ran
out of your reserve.

That is, you don't have a bound, so no reserve what so ever is going to
help.

You must have that callback_head fallback.
