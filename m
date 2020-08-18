Return-Path: <SRS0=c1tG=B4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E556C433DF
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 23:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB19A2075E
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 23:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4hnDKA8g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6uNUzzxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgHRX0F (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:26:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34348 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHRX0F (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Aug 2020 19:26:05 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597793162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jsT/0OAQ5/ZDSq/ihICMFWx4yum70SDMT61SJDGYMcQ=;
        b=4hnDKA8g4FYwEMnNg0BpZdAzJdyfcZz5JDZMaXDOX5zC6L/fT7PoJODo7o17ysaJT1GYQL
        9CTob4RdKVbziw3UtPsl7MD/LeUdjeNACI72ThT2pluudrpaK8TZsOkIFilsWeww09tPa6
        3MfDpGv1LD5HLt46hfir3sv1KN8HsZBY/6peJGJE/AfGcQOTGP2Pa0jZaPPB0st71d/ZKw
        m9qzT2jaQoLX8xHnOTWE34jJ7Z9fXx7Twd1dEtRNKVfg23mJysAkZRlnl4tGBVF07sPxMs
        PkslYHPWrxavRNPmZR2X4xWI9TkSamv89NVZXs7dExo42oRGsGezK+hz2Dg3mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597793162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jsT/0OAQ5/ZDSq/ihICMFWx4yum70SDMT61SJDGYMcQ=;
        b=6uNUzzxEc+H2c2LGBTOGz6gqzlIqZYy3ucuvixXsNHtJV1BHf6sqUqY/z+ppZupN/lSh2B
        KLJlxjS89TXkY0Ag==
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
In-Reply-To: <20200818171330.GH27891@paulmck-ThinkPad-P72>
References: <20200814204140.GT4295@paulmck-ThinkPad-P72> <20200814215206.GL3982@worktop.programming.kicks-ass.net> <20200816225655.GA17869@pc636> <20200817082849.GA28270@dhcp22.suse.cz> <20200817222803.GE23602@paulmck-ThinkPad-P72> <20200818074344.GL28270@dhcp22.suse.cz> <20200818135327.GF23602@paulmck-ThinkPad-P72> <87o8n8hv5p.fsf@nanos.tec.linutronix.de> <20200818161355.GE27891@paulmck-ThinkPad-P72> <87lfibj3m8.fsf@nanos.tec.linutronix.de> <20200818171330.GH27891@paulmck-ThinkPad-P72>
Date:   Wed, 19 Aug 2020 01:26:02 +0200
Message-ID: <87h7szilit.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Paul,

On Tue, Aug 18 2020 at 10:13, Paul E. McKenney wrote:
> On Tue, Aug 18, 2020 at 06:55:11PM +0200, Thomas Gleixner wrote:
>> On Tue, Aug 18 2020 at 09:13, Paul E. McKenney wrote:
>> > On Tue, Aug 18, 2020 at 04:43:14PM +0200, Thomas Gleixner wrote:
>> >> Throttling the flooder is incresing robustness far more than reducing
>> >> cache misses.
>> >
>> > True, but it takes time to identify a flooding event that needs to be
>> > throttled (as in milliseconds).  This time cannot be made up.
>> 
>> Not really. A flooding event will deplete your preallocated pages very
>> fast, so you have to go into the allocator and get new ones which
>> naturally throttles the offender.
>
> Should it turn out that we can in fact go into the allocator, completely
> agreed.

You better can for any user space controllable flooding source.

>> So if your open/close thing uses the new single argument free which has
>> to be called from sleepable context then the allocation either gives you
>> a page or that thing has to wait. No fancy extras.
>
> In the single-argument kvfree_rcu() case, completely agreed.
>
>> You still can have a page reserved for your other regular things and
>> once that it gone, you have to fall back to the linked list for
>> those. But when that happens the extra cache misses are not your main
>> problem anymore.
>
> The extra cache misses are a problem in that case because they throttle
> the reclamation, which anti-throttles the producer, especially in the
> case where callback invocation is offloaded.

You still did not explain which contexts can create flooding. I gave you
a complete list a few mails ago, but you still did not tell which of the
contexts can cause flooding.

If it's any context which is not sleepable or controllable in any way,
then any attempt to mitigate it is a lost battle:

  A dependency on allocating memory to free memory is a dead end by
  definition.

Any flooder which is uncontrollable is a bug and no matter what kind of
hacks you provide, it will be able to bring the whole thing down.

So far this looks like you're trying to cure the symptoms, which is
wrong to begin with.

If the flooder is controllable then there is no problem with cache
misses at all unless the RCU free callbacks are not able to catch up
which is yet another problem which you can't cure by allocating more
memory.

Thanks,

        tglx
