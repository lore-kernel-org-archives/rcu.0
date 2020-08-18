Return-Path: <SRS0=c1tG=B4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53318C433E1
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 16:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA5F207DE
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 16:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WMLTCK9u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cq931B0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgHRQzW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:55:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60404 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgHRQzQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Aug 2020 12:55:16 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597769713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lRnA/wasNgt3N1fOKKFjakzmrR8m48bxdaoauNatP3I=;
        b=WMLTCK9uMaYgN+l7nWqHD2RZlhiOVHeMfR+WGDgzx7CjDUeFIRxMgE22yIqCf4mcKNyHwM
        9/cKXIQ7M4axoMfKcRyvNo4/wPTgS0H8OyLj3t6bmJ2mbzD+0w3NvFxjJ518L8/Yoy7tGF
        TCLKsgK3usKaFcVbnlhKCOJJV1C+QJX8A4+oy1VONa4+/i/BEaSgeclwKKwycjwMnD+ryV
        H0Bu+2pK13HFVNXRzw1ataV8UQSDXF6A22WcRUcLitnJOOhSaYE4l3Hu4XZkUCEP2ywfgb
        PTlTBn7WDFILkctisJnteQbqejQ3T9dcDLMM1Q6DdsqfgIaiN+ABla1LezigQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597769713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lRnA/wasNgt3N1fOKKFjakzmrR8m48bxdaoauNatP3I=;
        b=cq931B0s0KrRKYyMcgIduqaVhFjJeVhJd3kRc3jIKHt3L05AH0m7TDRSuR9+X/p+MDZuUZ
        zvbuxNAtsMH2pdAQ==
To:     paulmck@kernel.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
In-Reply-To: <20200818161355.GE27891@paulmck-ThinkPad-P72>
References: <20200814180224.GQ4295@paulmck-ThinkPad-P72> <875z9lkoo4.fsf@nanos.tec.linutronix.de> <20200814204140.GT4295@paulmck-ThinkPad-P72> <20200814215206.GL3982@worktop.programming.kicks-ass.net> <20200816225655.GA17869@pc636> <20200817082849.GA28270@dhcp22.suse.cz> <20200817222803.GE23602@paulmck-ThinkPad-P72> <20200818074344.GL28270@dhcp22.suse.cz> <20200818135327.GF23602@paulmck-ThinkPad-P72> <87o8n8hv5p.fsf@nanos.tec.linutronix.de> <20200818161355.GE27891@paulmck-ThinkPad-P72>
Date:   Tue, 18 Aug 2020 18:55:11 +0200
Message-ID: <87lfibj3m8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 18 2020 at 09:13, Paul E. McKenney wrote:
> On Tue, Aug 18, 2020 at 04:43:14PM +0200, Thomas Gleixner wrote:
>> On Tue, Aug 18 2020 at 06:53, Paul E. McKenney wrote:
>> > On Tue, Aug 18, 2020 at 09:43:44AM +0200, Michal Hocko wrote:
>> >> Thomas had a good point that it doesn't really make much sense to
>> >> optimize for flooders because that just makes them more effective.
>> >
>> > The point is not to make the flooders go faster, but rather for the
>> > system to be robust in the face of flooders.  Robust as in harder for
>> > a flooder to OOM the system.
>> >
>> > And reducing the number of post-grace-period cache misses makes it
>> > easier for the callback-invocation-time memory freeing to keep up with
>> > the flooder, thus avoiding (or at least delaying) the OOM.
>> 
>> Throttling the flooder is incresing robustness far more than reducing
>> cache misses.
>
> True, but it takes time to identify a flooding event that needs to be
> throttled (as in milliseconds).  This time cannot be made up.

Not really. A flooding event will deplete your preallocated pages very
fast, so you have to go into the allocator and get new ones which
naturally throttles the offender.

So if your open/close thing uses the new single argument free which has
to be called from sleepable context then the allocation either gives you
a page or that thing has to wait. No fancy extras.

You still can have a page reserved for your other regular things and
once that it gone, you have to fall back to the linked list for
those. But when that happens the extra cache misses are not your main
problem anymore.

Thanks,

        tglx

