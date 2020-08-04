Return-Path: <SRS0=f/Ck=BO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CB3C433DF
	for <rcu@archiver.kernel.org>; Tue,  4 Aug 2020 17:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903C7206D4
	for <rcu@archiver.kernel.org>; Tue,  4 Aug 2020 17:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgHDReU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:34:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:36476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728256AbgHDReU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 4 Aug 2020 13:34:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F18AB5D8;
        Tue,  4 Aug 2020 17:34:34 +0000 (UTC)
Subject: Re: [RFC-PROTOTYPE 1/1] mm: Add __GFP_FAST_TRY flag
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
References: <20200803163029.1997-1-urezki@gmail.com>
 <1d50a46a-b97f-96b2-8a5c-21075f022f01@suse.cz>
 <20200804171203.GH23808@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <fe1dcc38-c968-0439-cb01-431cf004fc38@suse.cz>
Date:   Tue, 4 Aug 2020 19:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804171203.GH23808@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 8/4/20 7:12 PM, Matthew Wilcox wrote:
> On Tue, Aug 04, 2020 at 07:02:14PM +0200, Vlastimil Babka wrote:
>> > 2) There was a proposal from Matthew Wilcox: https://lkml.org/lkml/2020/7/31/1015
>> > 
>> > <snip>
>> > On non-RT, we could make that lock a raw spinlock.  On RT, we could
>> > decline to take the lock.  We'd need to abstract the spin_lock() away
>> > behind zone_lock(zone), but that should be OK.
>> > <snip>
>> > 
>> > It would be great to use any existing flag, say GFP_NOWAIT. Suppose we
>> > decline to take the lock across the page allocator for RT. But there is
>> > at least one path that does it outside of the page allocator. GFP_NOWAIT
>> > can wakeup the kswapd, whereas a "wake-up path" uses sleepable lock:
>> > 
>> > wakeup_kswapd() -> wake_up_interruptible(&pgdat->kswapd_wait).
>> > 
>> > Probably it can be fixed by the excluding of waking of the kswapd process
>> > defining something like below:
>> 
>> Is something missing here?
>> 
>> > what is equal to zero and i am not sure if __get_free_page(0) handles
>> > all that correctly, though it allocates and seems working on my test
>> > machine! Please note it is related to "if we can reuse existing flags".
>> > 
>> > In the meantime, please see below for a patch that adds a __GFP_FAST_TRY,
>> > which can at least serve as a baseline against which other proposals can
>> > be compared. The patch is based on the 5.8.0-rc3.
>> > 
>> > Please RFC.
>> 
>> At first glance __GFP_FAST_TRY (more descriptive name? __GFP_NO_LOCKS?) seems
>> better than doing weird things with GFP_NOWAIT, but depends on the real benefits
>> (hence my first questions).
> 
> I think what Vlad is trying to say is that even GFP_NOWAIT will wake
> kswapd, which involves taking a spinlock.  If you specify 0 in your GFP
> flags, then we won't wake kswapd.  So a simple:
> 
> #define GFP_NOLOCKS	0
> 
> should do the trick (modulo various casting, blah blah blah)

Ah, you're right, waking up kswapd is is only done with __GFP_KSWAPD_RECLAIM and
GFP_NOWAIT equals to that. So that's easy to avoid for the rcu allocation.

But still IIUC option 2) would mean that even with "#define GFP_NOLOCKS	0" would
mean we need to abstract away the zone lock, and behave differently depending on
the kernel being RT, and inadvertedly changing other users that happen to
specify gfp where "gfp & GFP_RECLAIM_MASK == 0" (or however we would exactly
check if we can take the lock on RT kernel). That sounds too complicated to me.
