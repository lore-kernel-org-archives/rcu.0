Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01807C433DF
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 23:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCDC9206B2
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 23:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wQEpHbzY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YY9WNXQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHNXke (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 19:40:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39776 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNXkd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 19:40:33 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597448432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ur7uXpcRbGymuHNjafxl0I8hYKYlxBpQY8FlNgJDhJk=;
        b=wQEpHbzY2xfKCvU09A8XAPHp9dEn4XZ5bueEHTSjPQWBj/BQWQnwF6vxjh+yBj6z0GDYIo
        B3P4xDxaH17JdvAyMMTCCvBMiypPGJPYOSi14lvpV5VBNgySl+19ON/FGT4eiatymgU8PK
        c39pMe3oP8BiQVw/gVHMo54h8bIKJnbGKl8UFLUFUpok5QKvHLajxkW5OzsJIlynR29KuU
        mV8ezdiZLCjoY4OYC5v7mu5Brm911kU+oXwK+Tupr6pdUQsK6rANcizbXr4EbuGekskhZ5
        L6oiZ/7+usJzQIHuyBQ0Ru1EdLySJUFxnx5ZaYVtQVdUa8Sj7Vj9JMS+1I6K5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597448432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ur7uXpcRbGymuHNjafxl0I8hYKYlxBpQY8FlNgJDhJk=;
        b=YY9WNXQ1vA6t2lXkSOA6fbk+zoHlmPBW9/5IdhvbiirJsFuu1TJkay7LJU/LuiHny5ED5F
        sDDCiIpi+2ijmvCg==
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
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
In-Reply-To: <20200814215206.GL3982@worktop.programming.kicks-ass.net>
References: <20200813185257.GF4295@paulmck-ThinkPad-P72> <20200813220619.GA2674@hirez.programming.kicks-ass.net> <875z9m3xo7.fsf@nanos.tec.linutronix.de> <20200814083037.GD3982@worktop.programming.kicks-ass.net> <20200814141425.GM4295@paulmck-ThinkPad-P72> <20200814161106.GA13853@paulmck-ThinkPad-P72> <20200814174924.GI3982@worktop.programming.kicks-ass.net> <20200814180224.GQ4295@paulmck-ThinkPad-P72> <875z9lkoo4.fsf@nanos.tec.linutronix.de> <20200814204140.GT4295@paulmck-ThinkPad-P72> <20200814215206.GL3982@worktop.programming.kicks-ass.net>
Date:   Sat, 15 Aug 2020 01:40:31 +0200
Message-ID: <87imdkkd8w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14 2020 at 23:52, Peter Zijlstra wrote:
> On Fri, Aug 14, 2020 at 01:41:40PM -0700, Paul E. McKenney wrote:
>> > And that enforces the GFP_NOLOCK allocation mode or some other solution
>> > unless you make a new rule that calling call_rcu() is forbidden while
>> > holding zone lock or any other lock which might be nested inside the
>> > GFP_NOWAIT zone::lock held region.
>> 
>> Again, you are correct.  Maybe the forecasted weekend heat will cause
>> my brain to hallucinate a better solution, but in the meantime, the
>> GFP_NOLOCK approach looks good from this end.
>
> So I hate __GFP_NO_LOCKS for a whole number of reasons:
>
>  - it should be called __GFP_LOCKLESS if anything
>  - it sprinkles a bunch of ugly branches around the allocator fast path
>  - it only works for order==0
>
> Combined I really odn't think this should be a GFP flag. How about a
> special purpose allocation function, something like so..

No. No. No.

It's not requried at all after the context got set straight and my brain
started working again.

There is no need to provide such a thing which tries to "optimize"
unfixable problems and as a consequence makes other people use it for
the completely wrong reasons all over the place.

We have plenty of that stuff already. No need for more ...

Thanks,

        tglx
 
