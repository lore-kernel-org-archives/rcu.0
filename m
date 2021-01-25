Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BB5C433E0
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 16:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F7D22510
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 16:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbhAYQOe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 Jan 2021 11:14:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:58244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729862AbhAYQO0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 Jan 2021 11:14:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611589185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zKS/Is5s9cc0mzPuWsCvSSGfuL7/tBg1PVAllAYqfSU=;
        b=TDxYHXSkfZ2OFjnCSFKr3cLU1pTXjeRqsX+yoD/GrbAWpwcu/BRne7P8UJJeilurf6S61l
        jIZ9y62a+zX2hG3utViE7U7uzmd6K61dhRsEZgt+4HXB0X8O1jTnhROVRP78seKgn3eOxI
        3SHfPblJ7Slvp9x+xkZcQMwER+1afQk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2AD06ADD8;
        Mon, 25 Jan 2021 15:39:45 +0000 (UTC)
Date:   Mon, 25 Jan 2021 16:39:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] kvfree_rcu: Allocate a page for a single argument
Message-ID: <20210125153943.GN827@dhcp22.suse.cz>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210125132236.GJ827@dhcp22.suse.cz>
 <20210125143150.GA2282@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125143150.GA2282@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon 25-01-21 15:31:50, Uladzislau Rezki wrote:
> > On Wed 20-01-21 17:21:46, Uladzislau Rezki (Sony) wrote:
> > > For a single argument we can directly request a page from a caller
> > > context when a "carry page block" is run out of free spots. Instead
> > > of hitting a slow path we can request an extra page by demand and
> > > proceed with a fast path.
> > > 
> > > A single-argument kvfree_rcu() must be invoked in sleepable contexts,
> > > and that its fallback is the relatively high latency synchronize_rcu().
> > > Single-argument kvfree_rcu() therefore uses GFP_KERNEL|__GFP_RETRY_MAYFAIL
> > > to allow limited sleeping within the memory allocator.
> > 
> > __GFP_RETRY_MAYFAIL can be quite heavy. It is effectively the most heavy
> > way to allocate without triggering the OOM killer. Is this really what
> > you need/want? Is __GFP_NORETRY too weak?
> > 
> Hm... We agreed to proceed with limited lightwait memory direct reclaim.
> Johannes Weiner proposed to go with __GFP_NORETRY flag as a starting
> point: https://www.spinics.net/lists/rcu/msg02856.html
> 
> <snip>
>     So I'm inclined to suggest __GFP_NORETRY as a starting point, and make
>     further decisions based on instrumentation of the success rates of
>     these opportunistic allocations.
> <snip>

I completely agree with Johannes here.

> but for some reason, i can't find a tail or head of it, we introduced
> __GFP_RETRY_MAYFAIL what is a heavy one from a time consuming point of view.
> What we would like to avoid.

Not that I object to this use but I think it would be much better to use
it based on actual data. Going along with it right away might become a
future burden to make any changes in this aspect later on due to lack of 
exact reasoning. General rule of thumb for __GFP_RETRY_MAYFAIL is really
try as hard as it can get without being really disruptive (like OOM
killing something). And your wording didn't really give me that
impression.

-- 
Michal Hocko
SUSE Labs
