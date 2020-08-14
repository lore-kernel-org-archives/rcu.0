Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108B1C433DF
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 20:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6B220771
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 20:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597437701;
	bh=scyrwTbuHhuKlqtV11BJGT5nyPFK8M5OUoE49z9q3L0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=MC7hUL1SP9KosB8cCsg2xSFj3qwDDgOHgcui0tWGjxuhd7JesFz+UFR1Plbyzdil6
	 z9DJVzA7sI1zU6cDGcs55JoZoEZmjrbyIdoeBTMxXp4TE7og21XRxH8IqntI0oRuJA
	 Ds4HTJRPrAAeM9OE9HMEvTfBiYF+2fQtb5Yu/+Lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgHNUll (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgHNUll (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 16:41:41 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D32C7206C0;
        Fri, 14 Aug 2020 20:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597437700;
        bh=scyrwTbuHhuKlqtV11BJGT5nyPFK8M5OUoE49z9q3L0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VlDm3ljGDrUfdey3ROSk1O1NkkMzrkQ8jJLPNB5pyJkVI2ukM2igYZ7D63kWNXjt9
         vfIVkU6ciD2PWaWe0MjY/V5yQwXs1Iya07GwhVhYKk+FU4LKMnma6/IErBkkyeVYlu
         7VLKyFFoNhbGclMUXS1oiGdnO+vLz3mz1jgz4e1A=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AE20E3522A0E; Fri, 14 Aug 2020 13:41:40 -0700 (PDT)
Date:   Fri, 14 Aug 2020 13:41:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20200814204140.GT4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200813182618.GX2674@hirez.programming.kicks-ass.net>
 <20200813185257.GF4295@paulmck-ThinkPad-P72>
 <20200813220619.GA2674@hirez.programming.kicks-ass.net>
 <875z9m3xo7.fsf@nanos.tec.linutronix.de>
 <20200814083037.GD3982@worktop.programming.kicks-ass.net>
 <20200814141425.GM4295@paulmck-ThinkPad-P72>
 <20200814161106.GA13853@paulmck-ThinkPad-P72>
 <20200814174924.GI3982@worktop.programming.kicks-ass.net>
 <20200814180224.GQ4295@paulmck-ThinkPad-P72>
 <875z9lkoo4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z9lkoo4.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14, 2020 at 09:33:47PM +0200, Thomas Gleixner wrote:
> On Fri, Aug 14 2020 at 11:02, Paul E. McKenney wrote:
> > On Fri, Aug 14, 2020 at 07:49:24PM +0200, Peter Zijlstra wrote:
> >> On Fri, Aug 14, 2020 at 09:11:06AM -0700, Paul E. McKenney wrote:
> >> > Just to make sure we are talking about the same thing, please see below
> >> > for an untested patch that illustrates how I was interpreting your words.
> >> > Was this what you had in mind?
> >> 
> >> No, definitely not.
> >> 
> >> Also, since we used to be able to use call_rcu() _everywhere_, including
> >> under zone->lock, how's that working with you calling the
> >> page-allocating from it?
> >
> > Indeed, that is exactly the problem we are trying to solve.
> 
> Wait a moment. Why are we discussing RT induced raw non raw lock
> ordering at all?

Because we like to argue?  (Sorry, couldn't resist.)

> Whatever kernel you variant you look at this is not working:
> 
>   lock(zone)  call_rcu() lock(zone)
> 
> It's a simple recursive dead lock, nothing else.

You are of course absolutely correct.

> And that enforces the GFP_NOLOCK allocation mode or some other solution
> unless you make a new rule that calling call_rcu() is forbidden while
> holding zone lock or any other lock which might be nested inside the
> GFP_NOWAIT zone::lock held region.

Again, you are correct.  Maybe the forecasted weekend heat will cause
my brain to hallucinate a better solution, but in the meantime, the
GFP_NOLOCK approach looks good from this end.

							Thanx, Paul
