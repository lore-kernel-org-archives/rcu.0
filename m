Return-Path: <SRS0=EzCL=BV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F5AC433DF
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 14:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4ED9206C3
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 14:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pRHQzTnY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ts3wdVRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgHKOoZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:44:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58854 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgHKOoZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 10:44:25 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597157062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vcln4Ca/4Fv4aIfCbdX1ilYpW3I83s8BkkosnjfF/9g=;
        b=pRHQzTnYuDs8oyfJmawu+/oYkSua7IKYXTcGTem2SuZPjaR7H/f52+ylgGKu3ierp88ap6
        0zA99s7nvYiY21pYwT8h4t6WQETbe8YpJTZ5V/12f+JWIf+UFUu1rBx+6gWYwoxfGdQ/zZ
        1SioXawuDrbKnVWdloBAS6+uYn7ervKFI0HIunTzctLgXEdGs/JVx5hIjKzVNvhpELL/OS
        E8L3T3hWa92ss0Ot4QeItyLe+3X7NYDmTka6Fb3tBlNOTq9lhIfkGUkciG9qiRqw2scN2w
        ndW5WieIuemPfWW9LucSywm6Q1itFJuGsI9O7kfzEMklKxhp/szCg2ppQmchvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597157062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vcln4Ca/4Fv4aIfCbdX1ilYpW3I83s8BkkosnjfF/9g=;
        b=Ts3wdVRNujK6Sly60+quuhFMSNlyCokdzwXFNRdRUmMuVX8Hj08DrORTsVjqYALSlwhDsB
        OrB84dSJsEJX08AQ==
To:     Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
In-Reply-To: <20200810192525.GG4773@dhcp22.suse.cz>
References: <20200809204354.20137-1-urezki@gmail.com> <20200809204354.20137-2-urezki@gmail.com> <20200810123141.GF4773@dhcp22.suse.cz> <20200810160739.GA29884@pc636> <20200810192525.GG4773@dhcp22.suse.cz>
Date:   Tue, 11 Aug 2020 16:44:21 +0200
Message-ID: <87pn7x6y4a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:
> On Mon 10-08-20 18:07:39, Uladzislau Rezki wrote:
>> > On Sun 09-08-20 22:43:53, Uladzislau Rezki (Sony) wrote:
>> > Is there any fundamental problem to make zone raw_spin_lock?
>> > 
>> Good point. Converting a regular spinlock to the raw_* variant can solve 
>> an issue and to me it seems partly reasonable. Because there are other
>> questions if we do it:
>> 
>> a) what to do with kswapd and "wake-up path" that uses sleepable lock:
>>     wakeup_kswapd() -> wake_up_interruptible(&pgdat->kswapd_wait).
>
> If there is no RT friendly variant for waking up process from the atomic
> context then we might need to special case this for the RT tree.

That's a solvable problem.

>> b) How RT people reacts on it? I guess they will no be happy.
>
> zone->lock should be held for a very limited amount of time.

Emphasis on should. free_pcppages_bulk() can hold it for quite some time
when a large amount of pages are purged. We surely would have converted
it to a raw lock long time ago otherwise.

For regular enterprise stuff a few hundred microseconds might qualify as
a limited amount of time. For advanced RT applications that's way beyond
tolerable..

>> As i described before, calling the __get_free_page(0) with 0 as argument
>> will solve the (a). How correctly is it? From my point of view the logic
>> that bypass the wakeup path should be explicitly defined.
>
> gfp_mask == 0 is GFP_NOWAIT (aka an atomic allocation request) which
> doesn't wake up kswapd. So if the wakeup is a problem then this would be
> a way to go.

The wakeup is the least of my worries.

> To me it would make more sense to support atomic allocations also for
> the RT tree. Having both GFP_NOWAIT and GFP_ATOMIC which do not really
> work for atomic context in RT sounds subtle and wrong.

Well, no. RT moves almost everything out of atomic context which means
that GFP_ATOMIC is pretty meanlingless on a RT kernel. RT sacrifies
performance for determinism. It's a known tradeoff.

Now RCU creates a new thing which enforces to make page allocation in
atomic context possible on RT. What for?

What's the actual use case in truly atomic context for this new thing on
an RT kernel?

The actual RCU code disabling interrupts is an implementation detail
which can easily be mitigated with a local lock.

Thanks,

        tglx
