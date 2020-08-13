Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F0CC433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 13:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E5B20768
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 13:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zX+uBrde";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Zz+45My"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMNWE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMNWE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 09:22:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4690C061757;
        Thu, 13 Aug 2020 06:22:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597324921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a75FvpsngyHZBmQ4rj7wRDEgOahPu9fXmXI+cwPoWYo=;
        b=zX+uBrdeE0IqtapTP6+A90KGBuvFL+Xo+8GijbcJBHy+X/r41FA537fdpvrVCFJNwxXgj+
        VUMnQKqYJ6pY6TAVLdotmwasumB7wikZ9ySD91JlbIRg12pahFzoTl3tydG2lr0BGvksLm
        F7bcsz//Ui0KSbgCpZhDycWNGeCqSTuIpVPKKNRFbVPsyysApVxB2iN0IKtGquggLog1Rk
        OREFGBcTKKZw7ENYoJBCdWGlavos5C16gaDjFlSH6EPJqfe0niY3GoB/Ac/n/jbtWqwoyg
        0tZsuFZfImVZ0vntcuvvSfwT3kOslzIIfIO3fD3vtcg3MT1EcCd7aw68LT92Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597324921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a75FvpsngyHZBmQ4rj7wRDEgOahPu9fXmXI+cwPoWYo=;
        b=4Zz+45Myel25NXIboO0ClR0DuWBpwMC6Es4vQzFsvQuRkLsYuk/VeKyz/p3E06pL8uWl6C
        bqDZmUlnnCiyvJBw==
To:     Uladzislau Rezki <urezki@gmail.com>, Michal Hocko <mhocko@suse.com>
Cc:     paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
In-Reply-To: <20200813095840.GA25268@pc636>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72> <874kp87mca.fsf@nanos.tec.linutronix.de> <20200813075027.GD9477@dhcp22.suse.cz> <20200813095840.GA25268@pc636>
Date:   Thu, 13 Aug 2020 15:22:00 +0200
Message-ID: <874kp6llzb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Uladzislau Rezki <urezki@gmail.com> writes:
> On Thu, Aug 13, 2020 at 09:50:27AM +0200, Michal Hocko wrote:
>> On Wed 12-08-20 02:13:25, Thomas Gleixner wrote:
>> [...]
>> > I can understand your rationale and what you are trying to solve. So, if
>> > we can actually have a distinct GFP variant:
>> > 
>> >   GFP_I_ABSOLUTELY_HAVE_TO_DO_THAT_AND_I_KNOW_IT_CAN_FAIL_EARLY
>> 
>> Even if we cannot make the zone->lock raw I would prefer to not
>> introduce a new gfp flag. Well we can do an alias for easier grepping
>> #define GFP_RT_SAFE	0

Just using 0 is sneaky but yes, that's fine :)

Bikeshedding: GFP_RT_NOWAIT or such might be more obvious.

>> that would imply nowait semantic and would exclude waking up kswapd as
>> well. If we can make wake up safe under RT then the alias would reflect
>> that without any code changes.

It basically requires to convert the wait queue to something else. Is
the waitqueue strict single waiter?

>> The second, and the more important part, would be to bail out anytime
>> the page allocator is to take a lock which is not allowed in the current
>> RT context. Something like

>> +	/*
>> +	 * Hard atomic contexts are not supported by the allocator for
>> +	 * anything but pcp requests
>> +	 */
>> +	if (!preemtable())

If you make that preemtible() it might even compile, but that still wont
work because if CONFIG_PREEMPT_COUNT=n then preemptible() is always
false.

So that should be:

	if (!preemptible() && gfp == GFP_RT_NOWAIT)

which is limiting the damage to those callers which hand in
GFP_RT_NOWAIT.

lockdep will yell at invocations with gfp != GFP_RT_NOWAIT when it hits
zone->lock in the wrong context. And we want to know about that so we
can look at the caller and figure out how to solve it.

>> > The page allocator allocations should also have a limit on the number of
>> > pages and eventually also page order (need to stare at the code or let
>> > Michal educate me that the order does not matter).
>> 
>> In practice anything but order 0 is out of question because we need
>> zone->lock for that currently. Maybe we can introduce pcp lists for
>> higher orders in the future - I have a vague recollection Mel was
>> playing with that some time ago.

Ok.
 
>> > To make it consistent the same GFP_ variant should allow the slab
>> > allocator go to the point where the slab cache is exhausted.
>> > 
>> > Having a distinct and clearly defined GFP_ variant is really key to
>> > chase down offenders and to make reviewers double check upfront why this
>> > is absolutely required.
>> 
>> Having a high level and recognizable gfp mask is OK but I would really
>> like not to introduce a dedicated flag. The page allocator should be
>> able to recognize the context which cannot be handled.

The GFP_xxx == 0 is perfectly fine.

> Sorry for jumping in. We can rely on preemptable() for sure, if CONFIG_PREEMPT_RT
> is enabled, something like below:
>
> if (IS_ENABLED_RT && preemptebale())

Ha, you morphed preemtable() into preemptebale() which will not compile
either :)

Thanks,

        tglx
