Return-Path: <SRS0=6ydw=B3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DD7C433E8
	for <rcu@archiver.kernel.org>; Mon, 17 Aug 2020 22:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF6E2072D
	for <rcu@archiver.kernel.org>; Mon, 17 Aug 2020 22:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597703285;
	bh=NUONv9kLCShilfn9ZT/o30cFFqVc/L2+Z/w6nr7C0zk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=TG5xfDJ2iR4B20wUoCvj+XQoxLU6g8cP9tkNnUJgBz9fGOthKcFgjelqn9ewAiXfy
	 lam3au9OnD/tyK4mrSl1foMrJRecjGJQPsmUBA0TfXkHofFMi0ojylxYCQcHtMyEEq
	 V7p78TqClaKEwGV3VITXpzimNBZ/o0QY37ByNSyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHQW2F (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgHQW2F (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Aug 2020 18:28:05 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC39204EC;
        Mon, 17 Aug 2020 22:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597703284;
        bh=NUONv9kLCShilfn9ZT/o30cFFqVc/L2+Z/w6nr7C0zk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=z2inuekbTwOWe5b25wv8EliIvOxNuBYdsAw0rDxdv8Tx1PeutqY/VjF5lmu44RB7h
         11nUJyqzMMgH8lXsbxK2+PVorRtEXuGvPQXRL5rtuxd2GNLaKnBPuwzPIHkYG9klAk
         kKI2Pc2NooJe/okdbcRDEET3yYg5bItBBn++/0jQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DA17C3522617; Mon, 17 Aug 2020 15:28:03 -0700 (PDT)
Date:   Mon, 17 Aug 2020 15:28:03 -0700
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
Message-ID: <20200817222803.GE23602@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200814083037.GD3982@worktop.programming.kicks-ass.net>
 <20200814141425.GM4295@paulmck-ThinkPad-P72>
 <20200814161106.GA13853@paulmck-ThinkPad-P72>
 <20200814174924.GI3982@worktop.programming.kicks-ass.net>
 <20200814180224.GQ4295@paulmck-ThinkPad-P72>
 <875z9lkoo4.fsf@nanos.tec.linutronix.de>
 <20200814204140.GT4295@paulmck-ThinkPad-P72>
 <20200814215206.GL3982@worktop.programming.kicks-ass.net>
 <20200816225655.GA17869@pc636>
 <20200817082849.GA28270@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817082849.GA28270@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 17, 2020 at 10:28:49AM +0200, Michal Hocko wrote:
> On Mon 17-08-20 00:56:55, Uladzislau Rezki wrote:

[ . . . ]

> > wget ftp://vps418301.ovh.net/incoming/1000000_kmalloc_kfree_rcu_proc_percpu_pagelist_fractio_is_8.png
> 
> 1/8 of the memory in pcp lists is quite large and likely not something
> used very often.
> 
> Both these numbers just make me think that a dedicated pool of page
> pre-allocated for RCU specifically might be a better solution. I still
> haven't read through that branch of the email thread though so there
> might be some pretty convincing argments to not do that.

To avoid the problematic corner cases, we would need way more dedicated
memory than is reasonable, as in well over one hundred pages per CPU.
Sure, we could choose a smaller number, but then we are failing to defend
against flooding, even on systems that have more than enough free memory
to be able to do so.  It would be better to live within what is available,
taking the performance/robustness hit only if there isn't enough.

My current belief is that we need a combination of (1) either the
GFP_NOLOCK flag or Peter Zijlstra's patch and (2) Thomas Gleixner's
delayed allocation approach.  As you say and as Uladislau's measurements
suggest, if we only have Peter's approach, although we could handle short
floods just fine, we could not handle longer-term floods.  And Thomas's
approach is in fact designed to handle these longer-term floods.

Except that if we have only Thomas's approach, then we have to handle the
possibility that RCU_SOFTIRQ happened on the back of an interrupt that
happened while the interrupted process was holding a memory-allocator
lock.  This means further deferral, such as going into a workqueue,
which would allow better memory-allocator results, but which would also
mean further delays from the time that memory was needed until the time
that it was actually supplied.  Delays that could be bridged by either
a GFP_NOLOCK flag or Peter's patch.

So again, it looks like this is not an either/or situation, but rather
an need-both situation.

I freely confess that one of my hopes almost 30 years ago was that a
high-quality parallel memory allocator would eliminate the need for
special-purpose allocators, but as has been noted several times on this
thread, reality does not always seem to be compelled to take such
hopes into account.

							Thanx, Paul
