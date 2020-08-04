Return-Path: <SRS0=f/Ck=BO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79DBC433E1
	for <rcu@archiver.kernel.org>; Tue,  4 Aug 2020 17:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D889207FC
	for <rcu@archiver.kernel.org>; Tue,  4 Aug 2020 17:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bWwAh9CP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgHDRMH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgHDRMH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 4 Aug 2020 13:12:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C4EC06174A;
        Tue,  4 Aug 2020 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sz6jtQ7L4VaLq7/Zit/IDyT8kBbwLII2WidR1CC1WfI=; b=bWwAh9CPNLSZESZOk5mCBF84LR
        9G4Rkga1BN+Q/i9uTjCCzAFKiEE/ddXKwU9ehE08ObW3iKCRBvCqIyZQNDF34n8ztv4PtfHHIj5EF
        ZkSBuiQyL6Pupl3waNCJBT3m7Ipc+kslqhKGyUfa/XsN2xQuZBpYSi4F3fyyHbugzrWO35ipVXBs4
        Ghtxq1FpSS8wiV3pGldLpKHgQ5EwS81jPj1y64lfGHiXRRUrIGVWeqpiY6loTYejTHhx/1flj+XDc
        MGtvaLjaQjZaojasrsT6gSyGcUSFImp5U8BApfYQcrXjAcP455Gv6qfoKgLdf7KYUGvjKWwQW8gY/
        88blmvMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k30Tr-0005XU-AD; Tue, 04 Aug 2020 17:12:03 +0000
Date:   Tue, 4 Aug 2020 18:12:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PROTOTYPE 1/1] mm: Add __GFP_FAST_TRY flag
Message-ID: <20200804171203.GH23808@casper.infradead.org>
References: <20200803163029.1997-1-urezki@gmail.com>
 <1d50a46a-b97f-96b2-8a5c-21075f022f01@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d50a46a-b97f-96b2-8a5c-21075f022f01@suse.cz>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 04, 2020 at 07:02:14PM +0200, Vlastimil Babka wrote:
> > 2) There was a proposal from Matthew Wilcox: https://lkml.org/lkml/2020/7/31/1015
> > 
> > <snip>
> > On non-RT, we could make that lock a raw spinlock.  On RT, we could
> > decline to take the lock.  We'd need to abstract the spin_lock() away
> > behind zone_lock(zone), but that should be OK.
> > <snip>
> > 
> > It would be great to use any existing flag, say GFP_NOWAIT. Suppose we
> > decline to take the lock across the page allocator for RT. But there is
> > at least one path that does it outside of the page allocator. GFP_NOWAIT
> > can wakeup the kswapd, whereas a "wake-up path" uses sleepable lock:
> > 
> > wakeup_kswapd() -> wake_up_interruptible(&pgdat->kswapd_wait).
> > 
> > Probably it can be fixed by the excluding of waking of the kswapd process
> > defining something like below:
> 
> Is something missing here?
> 
> > what is equal to zero and i am not sure if __get_free_page(0) handles
> > all that correctly, though it allocates and seems working on my test
> > machine! Please note it is related to "if we can reuse existing flags".
> > 
> > In the meantime, please see below for a patch that adds a __GFP_FAST_TRY,
> > which can at least serve as a baseline against which other proposals can
> > be compared. The patch is based on the 5.8.0-rc3.
> > 
> > Please RFC.
> 
> At first glance __GFP_FAST_TRY (more descriptive name? __GFP_NO_LOCKS?) seems
> better than doing weird things with GFP_NOWAIT, but depends on the real benefits
> (hence my first questions).

I think what Vlad is trying to say is that even GFP_NOWAIT will wake
kswapd, which involves taking a spinlock.  If you specify 0 in your GFP
flags, then we won't wake kswapd.  So a simple:

#define GFP_NOLOCKS	0

should do the trick (modulo various casting, blah blah blah)
