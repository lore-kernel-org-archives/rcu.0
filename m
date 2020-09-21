Return-Path: <SRS0=oLBG=C6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEAEC43465
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 15:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A5020BED
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 15:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600703160;
	bh=HsDeVquuSyJnnOmiKWblMIIS/Vmw/qNnCOAfM6Vvy7M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=WIfirHJSusWKlcollhXeuNgM98W6OXHFiZv89B/N7dbLDLZM4rMq/HJ5rw7bdiNVH
	 XcCjKUdyJvv4TAJeSRaBZlvhogIyrWsgU3EFg9x35XOgpnIK3NZpRzJ/BaVguR+vXq
	 xv/x6SMey/qhwRFYWwb+MlnLEVSb4BiwyInoXefI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgIUPp7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Sep 2020 11:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbgIUPp7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Sep 2020 11:45:59 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC48920B1F;
        Mon, 21 Sep 2020 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600703158;
        bh=HsDeVquuSyJnnOmiKWblMIIS/Vmw/qNnCOAfM6Vvy7M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HUS24PP8unqxMWlYWto9xTl5J4tCiludA9Hh9bLtJ2XBvEqYTLOisVcBQ4MA1g5jR
         O0PqIensUHnmk4Q/KOipDVYwkFkgu8PMWA7pve4YudWsJkjjruDYDPmqDe6THgwJ3Z
         bG0HVCMveCT92pofr103S9xCbsq+LSP2ZIz9/GSM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8BE7D352303A; Mon, 21 Sep 2020 08:45:58 -0700 (PDT)
Date:   Mon, 21 Sep 2020 08:45:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200921154558.GD29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <20200921074716.GC12990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921074716.GC12990@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 21, 2020 at 09:47:16AM +0200, Michal Hocko wrote:
> On Fri 18-09-20 21:48:15, Uladzislau Rezki (Sony) wrote:
> [...]
> > Proposal
> > ========
> > Introduce a lock-free function that obtain a page from the per-cpu-lists
> > on current CPU. It returns NULL rather than acquiring any non-raw spinlock.
> 
> I was not happy about this solution when we have discussed this
> last time and I have to say I am still not happy. This is exposing
> an internal allocator optimization and allows a hard to estimate
> consumption of pcp free pages. IIUC this run on pcp cache can be
> controled directly from userspace (close(open) loop IIRC) which makes it
> even bigger no-no.

Yes, I do well remember that you are unhappy with this approach.
Unfortunately, thus far, there is no solution that makes all developers
happy.  You might be glad to hear that we are also looking into other
solutions, each of which makes some other developers unhappy.  So we
are at least not picking on you alone.  :-/

> I strongly agree with Thomas http://lkml.kernel.org/r/87tux4kefm.fsf@nanos.tec.linutronix.de
> that this optimization is not aiming at reasonable workloads. Really, go
> with pre-allocated buffer and fallback to whatever slow path you have
> already. Exposing more internals of the allocator is not going to do any
> good for long term maintainability.

I suggest that you carefully re-read the thread following that email.

Given a choice between making users unhappy and making developers
unhappy, I will side with the users each and every time.

							Thanx, Paul
