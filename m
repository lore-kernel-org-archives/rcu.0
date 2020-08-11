Return-Path: <SRS0=EzCL=BV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0373C433DF
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 19:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB9D206B2
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 19:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oHAMia7u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5elTrME8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHKTjN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgHKTjN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 15:39:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E6C06174A;
        Tue, 11 Aug 2020 12:39:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597174751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YV8vEVVqhngk6zTeFdnzvuc65En/mdSLGrqYDqzVMCg=;
        b=oHAMia7usYnGV2/RbJIvgRIFvUXvTG1MqS0jAZdgAYOx9M5ro+TzckijDUADM/SInRXrBu
        1yimeOxa2NVEiVIHyprnRi6fmMg70374QzA7yoCp1Z1SoI63nUOztGCJ96Igb+JvIzLbhY
        hiI7wFKn0tQHZYgCctYnvTUDNklRkGAcYx40u5JdzPIfoGgBrjzxO13tnzBMhEazDVNSBu
        rq0y/UtPS2S5Cx46Ys3AJTHEx6OBXd9Bg+7Fx1Rn2EmpoXclNR04sva/VVv/sltViSdJpS
        tb8OOxICpLyHsfimC7Stucm4e25ujHgSWW043c+a9AhmPQ9cO1De+PFSHy0gTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597174751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YV8vEVVqhngk6zTeFdnzvuc65En/mdSLGrqYDqzVMCg=;
        b=5elTrME8Ulv5SlkhoPEmX3f8GciJjnw7jNzCPNSl2o6RnBtKEsfmk+OiBO4Fxx9XgSgzbM
        sC9NgOyDeRXNApBw==
To:     paulmck@kernel.org
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
In-Reply-To: <87h7t96ve3.fsf@nanos.tec.linutronix.de>
References: <20200809204354.20137-1-urezki@gmail.com> <20200809204354.20137-2-urezki@gmail.com> <20200810123141.GF4773@dhcp22.suse.cz> <20200810160739.GA29884@pc636> <20200810192525.GG4773@dhcp22.suse.cz> <87pn7x6y4a.fsf@nanos.tec.linutronix.de> <20200811153327.GW4295@paulmck-ThinkPad-P72> <87h7t96ve3.fsf@nanos.tec.linutronix.de>
Date:   Tue, 11 Aug 2020 21:39:10 +0200
Message-ID: <87eeod6kgx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> On Tue, Aug 11, 2020 at 04:44:21PM +0200, Thomas Gleixner wrote:
>>> Now RCU creates a new thing which enforces to make page allocation in
>>> atomic context possible on RT. What for?
>>> 
>>> What's the actual use case in truly atomic context for this new thing on
>>> an RT kernel?
>>
>> It is not just RT kernels.  CONFIG_PROVE_RAW_LOCK_NESTING=y propagates
>> this constraint to all configurations, and a patch in your new favorite
>> subsystem really did trigger this lockdep check in a non-RT kernel.
>>
>>> The actual RCU code disabling interrupts is an implementation detail
>>> which can easily be mitigated with a local lock.
>>
>> In this case, we are in raw-spinlock context on entry to kfree_rcu().
>
> Where?

And aside of the where, wasn't kfree_rcu() from within raw spinlock held
regions possible all the time? Either I'm missing something or you are
fundamentally changing RCU internals. kfree_rcu() saved RT in various
ways where invoking kfree() was just not an option. Confused...

Thanks,

        tglx
