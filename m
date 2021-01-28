Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91E1C433E6
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 15:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EB264DD6
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 15:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhA1PRv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Jan 2021 10:17:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:59002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231171AbhA1PRt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Jan 2021 10:17:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611847022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CUUsqoDshqZ4qwQ1Kc4iSyaByclB2HlvDzwBh7gRls4=;
        b=ioVcpdleXlKYLmDeMvdOTbmadVIiiTiPMNjAXN3IgvJ0IvirC8P2v31xUobENq54J/wb2w
        PSX/PY9AtEbCb/sE6Twy/kOgmVmfXfdyJS0I/19RceFU/kk6U+ypGZKvQiMKjZb33mV/iX
        iyZsKoaaBfeEp0ndRGvraK+yuGh7Ks8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF9A2AE44;
        Thu, 28 Jan 2021 15:17:02 +0000 (UTC)
Date:   Thu, 28 Jan 2021 16:17:01 +0100
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
Message-ID: <YBLVbZzy0KSONizm@dhcp22.suse.cz>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210125132236.GJ827@dhcp22.suse.cz>
 <20210125143150.GA2282@pc638.lan>
 <20210125153943.GN827@dhcp22.suse.cz>
 <20210125162559.GA52712@pc638.lan>
 <20210128151152.GA1867@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128151152.GA1867@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu 28-01-21 16:11:52, Uladzislau Rezki wrote:
> On Mon, Jan 25, 2021 at 05:25:59PM +0100, Uladzislau Rezki wrote:
> > On Mon, Jan 25, 2021 at 04:39:43PM +0100, Michal Hocko wrote:
> > > On Mon 25-01-21 15:31:50, Uladzislau Rezki wrote:
> > > > > On Wed 20-01-21 17:21:46, Uladzislau Rezki (Sony) wrote:
> > > > > > For a single argument we can directly request a page from a caller
> > > > > > context when a "carry page block" is run out of free spots. Instead
> > > > > > of hitting a slow path we can request an extra page by demand and
> > > > > > proceed with a fast path.
> > > > > > 
> > > > > > A single-argument kvfree_rcu() must be invoked in sleepable contexts,
> > > > > > and that its fallback is the relatively high latency synchronize_rcu().
> > > > > > Single-argument kvfree_rcu() therefore uses GFP_KERNEL|__GFP_RETRY_MAYFAIL
> > > > > > to allow limited sleeping within the memory allocator.
> > > > > 
> > > > > __GFP_RETRY_MAYFAIL can be quite heavy. It is effectively the most heavy
> > > > > way to allocate without triggering the OOM killer. Is this really what
> > > > > you need/want? Is __GFP_NORETRY too weak?
> > > > > 
> > > > Hm... We agreed to proceed with limited lightwait memory direct reclaim.
> > > > Johannes Weiner proposed to go with __GFP_NORETRY flag as a starting
> > > > point: https://www.spinics.net/lists/rcu/msg02856.html
> > > > 
> > > > <snip>
> > > >     So I'm inclined to suggest __GFP_NORETRY as a starting point, and make
> > > >     further decisions based on instrumentation of the success rates of
> > > >     these opportunistic allocations.
> > > > <snip>
> > > 
> > > I completely agree with Johannes here.
> > > 
> > > > but for some reason, i can't find a tail or head of it, we introduced
> > > > __GFP_RETRY_MAYFAIL what is a heavy one from a time consuming point of view.
> > > > What we would like to avoid.
> > > 
> > > Not that I object to this use but I think it would be much better to use
> > > it based on actual data. Going along with it right away might become a
> > > future burden to make any changes in this aspect later on due to lack of 
> > > exact reasoning. General rule of thumb for __GFP_RETRY_MAYFAIL is really
> > > try as hard as it can get without being really disruptive (like OOM
> > > killing something). And your wording didn't really give me that
> > > impression.
> > > 
> > Initially i proposed just to go with GFP_NOWAIT flag. But later on there
> > was a discussion about a fallback path, that uses synchronize_rcu() can be
> > slow, thus minimizing its hitting would be great. So, here we go with a
> > trade off.
> > 
> > Doing it hard as __GFP_RETRY_MAYFAIL can do, is not worth(IMHO), but to have some
> > light-wait requests would be acceptable. That is why __GFP_NORETRY was proposed.
> > 
> > There were simple criterias we discussed which we would like to achieve:
> > 
> > a) minimize a fallback hitting;
> > b) avoid of OOM involving;
> > c) avoid of dipping into the emergency reserves. See kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument kvfree_rcu()
> > 
> One question here. Since the code that triggers a page request can be
> directly invoked from reclaim context as well as outside of it. We had
> a concern about if any recursion is possible, but what i see it is safe.
> The context that does it can not enter it twice:
> 
> <snip>
>     /* Avoid recursion of direct reclaim */
>     if (current->flags & PF_MEMALLOC)
>         goto nopage;
> <snip>

Yes this is a recursion protection.

> What about any deadlocking in regards to below following flags?
> 
> GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN

and __GFP_NOMEMALLOC will make sure that the allocation will not consume
all the memory reserves. The later should be clarified in one of your
patches I have acked IIRC.
-- 
Michal Hocko
SUSE Labs
